subroutine G0W0(doACFDT,exchange_kernel,doXBS,COHSEX,BSE,TDA_W,TDA, & 
                dBSE,dTDA,evDyn,singlet,triplet,linearize,eta,            & 
                nBas,nC,nO,nV,nR,nS,ENuc,ERHF,ERI_AO,ERI_MO,dipole_int,PHF,cHF,eHF,Vxc,eG0W0)

! Perform G0W0 calculation

  implicit none
  include 'parameters.h'
  include 'quadrature.h'

! Input variables

  logical,intent(in)            :: doACFDT
  logical,intent(in)            :: exchange_kernel
  logical,intent(in)            :: doXBS
  logical,intent(in)            :: COHSEX
  logical,intent(in)            :: BSE
  logical,intent(in)            :: TDA_W
  logical,intent(in)            :: TDA
  logical,intent(in)            :: dBSE
  logical,intent(in)            :: dTDA
  logical,intent(in)            :: evDyn
  logical,intent(in)            :: singlet
  logical,intent(in)            :: triplet
  logical,intent(in)            :: linearize
  double precision,intent(in)   :: eta

  integer,intent(in)            :: nBas
  integer,intent(in)            :: nC
  integer,intent(in)            :: nO
  integer,intent(in)            :: nV
  integer,intent(in)            :: nR
  integer,intent(in)            :: nS
  double precision,intent(in)   :: ENuc
  double precision,intent(in)   :: ERHF
  double precision,intent(in)   :: ERI_AO(nBas,nBas,nBas,nBas)
  double precision,intent(in)   :: ERI_MO(nBas,nBas,nBas,nBas)
  double precision,intent(in)   :: dipole_int(nBas,nBas,ncart)
  double precision,intent(in)   :: Vxc(nBas)
  double precision,intent(in)   :: eHF(nBas)
  double precision,intent(in)   :: cHF(nBas,nBas)
  double precision,intent(in)   :: PHF(nBas,nBas)

! Local variables

  logical                       :: print_W = .true.
  integer                       :: ispin
  double precision              :: EcRPA
  double precision              :: EcBSE(nspin)
  double precision              :: EcAC(nspin)
  double precision              :: EcGM
  double precision,allocatable  :: SigX(:)
  double precision,allocatable  :: SigC(:)
  double precision,allocatable  :: Z(:)
  double precision,allocatable  :: OmRPA(:)
  double precision,allocatable  :: XpY_RPA(:,:)
  double precision,allocatable  :: XmY_RPA(:,:)
  double precision,allocatable  :: rho_RPA(:,:,:)

  double precision,allocatable  :: eG0W0lin(:)

! Output variables

  double precision              :: eG0W0(nBas)

! Hello world

  write(*,*)
  write(*,*)'************************************************'
  write(*,*)'|          One-shot G0W0 calculation           |'
  write(*,*)'************************************************'
  write(*,*)

! Initialization

  EcRPA = 0d0

! COHSEX approximation

  if(COHSEX) then 
    write(*,*) 'COHSEX approximation activated!'
    write(*,*)
  end if

! TDA for W

  if(TDA_W) then 
    write(*,*) 'Tamm-Dancoff approximation for dynamic screening!'
    write(*,*)
  end if

! TDA 

  if(TDA) then 
    write(*,*) 'Tamm-Dancoff approximation activated!'
    write(*,*)
  end if

! Spin manifold 

  ispin = 1

! Memory allocation

  allocate(SigC(nBas),SigX(nBas),Z(nBas),OmRPA(nS),XpY_RPA(nS,nS),XmY_RPA(nS,nS),rho_RPA(nBas,nBas,nS),eG0W0lin(nBas))

!-------------------!
! Compute screening !
!-------------------!

  call linear_response(ispin,.true.,TDA_W,.false.,eta,nBas,nC,nO,nV,nR,nS,1d0, & 
                       eHF,ERI_MO,OmRPA,rho_RPA,EcRPA,OmRPA,XpY_RPA,XmY_RPA)

  if(print_W) call print_excitation('RPA@HF      ',ispin,nS,OmRPA)

!--------------------------!
! Compute spectral weights !
!--------------------------!

  call excitation_density(nBas,nC,nO,nR,nS,ERI_MO,XpY_RPA,rho_RPA)

!------------------------!
! Compute GW self-energy !
!------------------------!

  call self_energy_exchange_diag(nBas,cHF,PHF,ERI_AO,SigX)
  call self_energy_correlation_diag(COHSEX,eta,nBas,nC,nO,nV,nR,nS,eHF,OmRPA,rho_RPA,EcGM,SigC)

!--------------------------------!
! Compute renormalization factor !
!--------------------------------!

  call renormalization_factor(COHSEX,eta,nBas,nC,nO,nV,nR,nS,eHF,OmRPA,rho_RPA,Z)

!-----------------------------------!
! Solve the quasi-particle equation !
!-----------------------------------!

  eG0W0lin(:) = eHF(:) + Z(:)*(SigX(:) + SigC(:) - Vxc(:))

  ! Linearized or graphical solution?

  if(linearize) then 
 
    write(*,*) ' *** Quasiparticle energies obtained by linearization *** '
    write(*,*)

    eG0W0(:) = eG0W0lin(:)

  else 

    write(*,*) ' *** Quasiparticle energies obtained by root search (experimental) *** '
    write(*,*)
  
    call QP_graph(nBas,nC,nO,nV,nR,nS,eta,eHF,SigX,Vxc,OmRPA,rho_RPA,eG0W0lin,eG0W0)

    ! Find all the roots of the QP equation if necessary

    ! call QP_roots(nBas,nC,nO,nV,nR,nS,eta,eHF,Omega,rho,eGWlin)
 
  end if

! Compute the RPA correlation energy

  call linear_response(ispin,.true.,TDA_W,.false.,eta,nBas,nC,nO,nV,nR,nS,1d0,eG0W0,ERI_MO,OmRPA, & 
                       rho_RPA,EcRPA,OmRPA,XpY_RPA,XmY_RPA)

!--------------!
! Dump results !
!--------------!

  call print_G0W0(nBas,nO,eHF,ENuc,ERHF,SigC,Z,eG0W0,EcRPA,EcGM)

! Deallocate memory

  deallocate(SigC,Z,OmRPA,XpY_RPA,XmY_RPA,rho_RPA,eG0W0lin)

! Plot stuff

! call plot_GW(nBas,nC,nO,nV,nR,nS,eHF,eGW,OmRPA,rho_RPA)

! Perform BSE calculation

  if(BSE) then

    call Bethe_Salpeter(TDA_W,TDA,dBSE,dTDA,evDyn,singlet,triplet,eta,nBas,nC,nO,nV,nR,nS,ERI_MO,dipole_int,eHF,eG0W0,EcBSE)

    if(exchange_kernel) then
 
      EcBSE(1) = 0.5d0*EcBSE(1)
      EcBSE(2) = 1.5d0*EcBSE(2)
 
    end if

    write(*,*)
    write(*,*)'-------------------------------------------------------------------------------'
    write(*,'(2X,A50,F20.10)') 'Tr@BSE@G0W0 correlation energy (singlet) =',EcBSE(1)
    write(*,'(2X,A50,F20.10)') 'Tr@BSE@G0W0 correlation energy (triplet) =',EcBSE(2)
    write(*,'(2X,A50,F20.10)') 'Tr@BSE@G0W0 correlation energy           =',EcBSE(1) + EcBSE(2)
    write(*,'(2X,A50,F20.10)') 'Tr@BSE@G0W0 total energy                 =',ENuc + ERHF + EcBSE(1) + EcBSE(2)
    write(*,*)'-------------------------------------------------------------------------------'
    write(*,*)

!   Compute the BSE correlation energy via the adiabatic connection 

    if(doACFDT) then

      write(*,*) '-------------------------------------------------------------'
      write(*,*) ' Adiabatic connection version of BSE@G0W0 correlation energy '
      write(*,*) '-------------------------------------------------------------'
      write(*,*) 

      if(doXBS) then 

        write(*,*) '*** scaled screening version (XBS) ***'
        write(*,*)

      end if

      call ACFDT(exchange_kernel,doXBS,.true.,TDA_W,TDA,BSE,singlet,triplet,eta,nBas,nC,nO,nV,nR,nS,ERI_MO,eHF,eG0W0,EcAC)

      write(*,*)
      write(*,*)'-------------------------------------------------------------------------------'
      write(*,'(2X,A50,F20.10)') 'AC@BSE@G0W0 correlation energy (singlet) =',EcAC(1)
      write(*,'(2X,A50,F20.10)') 'AC@BSE@G0W0 correlation energy (triplet) =',EcAC(2)
      write(*,'(2X,A50,F20.10)') 'AC@BSE@G0W0 correlation energy           =',EcAC(1) + EcAC(2)
      write(*,'(2X,A50,F20.10)') 'AC@BSE@G0W0 total energy                 =',ENuc + ERHF + EcAC(1) + EcAC(2)
      write(*,*)'-------------------------------------------------------------------------------'
      write(*,*)

    end if

  end if

end subroutine G0W0
