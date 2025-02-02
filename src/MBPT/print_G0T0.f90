subroutine print_G0T0(nBas,nO,eHF,ENuc,ERHF,SigT,Z,eGT,EcRPA)

! Print one-electron energies and other stuff for G0T0

  implicit none
  include 'parameters.h'

  integer,intent(in)                 :: nBas,nO
  double precision,intent(in)        :: ENuc
  double precision,intent(in)        :: ERHF
  double precision,intent(in)        :: EcRPA(nspin)
  double precision,intent(in)        :: eHF(nBas)
  double precision,intent(in)        :: SigT(nBas)
  double precision,intent(in)        :: Z(nBas)
  double precision,intent(in)        :: eGT(nBas)

  integer                            :: p,HOMO,LUMO
  double precision                   :: Gap

! HOMO and LUMO

  HOMO = nO
  LUMO = HOMO + 1
  if(nBas >= LUMO) then

    Gap = eGT(LUMO) - eGT(HOMO)

  else

    Gap = 0d0

  end if

! Dump results

  write(*,*)'-------------------------------------------------------------------------------'
  write(*,*)'  One-shot G0T0 calculation (T-matrix self-energy)  '
  write(*,*)'-------------------------------------------------------------------------------'
  write(*,'(1X,A1,1X,A3,1X,A1,1X,A15,1X,A1,1X,A15,1X,A1,1X,A15,1X,A1,1X,A15,1X,A1,1X)') &
            '|','#','|','e_HF (eV)','|','Sigma_T (eV)','|','Z','|','e_QP (eV)','|'
  write(*,*)'-------------------------------------------------------------------------------'

  do p=1,nBas
    write(*,'(1X,A1,1X,I3,1X,A1,1X,F15.6,1X,A1,1X,F15.6,1X,A1,1X,F15.6,1X,A1,1X,F15.6,1X,A1,1X)') &
    '|',p,'|',eHF(p)*HaToeV,'|',SigT(p)*HaToeV,'|',Z(p),'|',eGT(p)*HaToeV,'|'
  enddo

  write(*,*)'-------------------------------------------------------------------------------'
  write(*,'(2X,A50,F15.6,A3)') 'G0T0 HOMO      energy (eV)            =',eGT(HOMO)*HaToeV,' eV'
  write(*,'(2X,A50,F15.6,A3)') 'G0T0 LUMO      energy (eV)            =',eGT(LUMO)*HaToeV,' eV'
  write(*,'(2X,A50,F15.6,A3)') 'G0T0 HOMO-LUMO gap    (eV)            =',Gap*HaToeV,' eV'
  write(*,*)'-------------------------------------------------------------------------------'
  write(*,'(2X,A50,F20.10,A3)') 'Tr@RPA@G0T0 correlation energy (singlet) =',EcRPA(1),' au'
  write(*,'(2X,A50,F20.10,A3)') 'Tr@RPA@G0T0 correlation energy (triplet) =',EcRPA(2),' au'
  write(*,'(2X,A50,F20.10,A3)') 'Tr@RPA@G0T0 correlation energy           =',EcRPA(1) + EcRPA(2),' au'
  write(*,'(2X,A50,F20.10,A3)') 'Tr@RPA@G0T0 total energy                 =',ENuc + ERHF + EcRPA(1) + EcRPA(2),' au'
  write(*,*)'-------------------------------------------------------------------------------'
  write(*,*)

end subroutine print_G0T0


