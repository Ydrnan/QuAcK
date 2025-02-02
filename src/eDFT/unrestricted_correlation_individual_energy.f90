subroutine unrestricted_correlation_individual_energy(rung,DFA,LDA_centered,nEns,wEns,nGrid,weight,rhow,drhow,rho,drho, & 
                                                      doNcentered,kappa,Ec)

! Compute the correlation energy of individual states

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: rung
  integer,intent(in)            :: DFA
  logical,intent(in)            :: LDA_centered
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  double precision,intent(in)   :: rhow(nGrid,nspin)
  double precision,intent(in)   :: drhow(ncart,nGrid,nspin)
  double precision,intent(in)   :: rho(nGrid,nspin)
  double precision,intent(in)   :: drho(ncart,nGrid,nspin)
  logical,intent(in)            :: doNcentered
  double precision,intent(in)   :: kappa

! Local variables

  double precision              :: EcLDA(nsp)
  double precision              :: EcGGA(nsp)

! Output variables

  double precision,intent(out)  :: Ec(nsp)

  select case (rung)

!   Hartree calculation

    case(0) 

      Ec(:) = 0d0

!   LDA functionals

    case(1) 

      call unrestricted_lda_correlation_individual_energy(DFA,LDA_centered,nEns,wEns,nGrid,weight,rhow,rho, & 
                                                          doNcentered,kappa,Ec)

!   GGA functionals

    case(2) 

      call print_warning('!!! Individual energies NYI for GGAs !!!')

!   MGGA functionals

    case(3) 

      call print_warning('!!! Individual energies NYI for MGGAs !!!')

!   Hybrid functionals

    case(4) 

      call print_warning('!!! Individual energies NYI for hybrids !!!')

  end select
 
end subroutine unrestricted_correlation_individual_energy
