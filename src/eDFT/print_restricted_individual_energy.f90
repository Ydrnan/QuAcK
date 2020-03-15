subroutine print_restricted_individual_energy(nEns,ET,EV,EJ,Ex,Ec,Exc,ExLZ,EcLZ,ExcLZ,ExDD,EcDD,ExcDD,E,Om)

! Print individual energies for eDFT calculation

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)                 :: nEns
  double precision,intent(in)        :: ET(nEns)
  double precision,intent(in)        :: EV(nEns)
  double precision,intent(in)        :: EJ(nEns)
  double precision,intent(in)        :: Ex(nEns),Ec(nEns),Exc(nEns)
  double precision,intent(in)        :: ExLZ,EcLZ,ExcLZ
  double precision,intent(in)        :: ExDD(nEns),EcDD(nEns),ExcDD(nEns)
  double precision,intent(in)        :: E(nEns)
  double precision,intent(in)        :: Om(nEns)

! Local variables

  integer                            :: iEns

!------------------------------------------------------------------------
! Kinetic energy
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual Kinetic     energies'
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Kinetic     energy state ',iEns,': ',ET(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Potential energy
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual Potential   energies'
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Potential   energy state ',iEns,': ',EV(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Hartree energy
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual Hartree     energies'
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Hartree     energy state ',iEns,': ',EJ(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Exchange energy
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual exchange    energies'
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Exchange    energy state ',iEns,': ',Ex(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Correlation energy
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual correlation energies'
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Correlation energy state ',iEns,': ',Ec(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Compute Levy-Zahariev shift
!------------------------------------------------------------------------

  write(*,'(A60)')              '-------------------------------------------------'
  write(*,'(A40,2X,2X,F16.10,A3)') '  x Levy-Zahariev shifts: ',ExLZ, ' au'
  write(*,'(A40,2X,2X,F16.10,A3)') '  c Levy-Zahariev shifts: ',EcLZ, ' au'
  write(*,'(A40,2X,2X,F16.10,A3)') ' xc Levy-Zahariev shifts: ',ExcLZ,' au'
  write(*,'(A60)')              '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Compute derivative discontinuities
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Derivative discontinuities (DD)    '
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') '  x ensemble derivative ',iEns,': ',ExDD(iEns), ' au'
    write(*,'(A40,I2,A2,F16.10,A3)') '  c ensemble derivative ',iEns,': ',EcDD(iEns), ' au'
    write(*,'(A40,I2,A2,F16.10,A3)') ' xc ensemble derivative ',iEns,': ',ExcDD(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

!------------------------------------------------------------------------
! Total and Excitation energies
!------------------------------------------------------------------------

  write(*,'(A60)')           '-------------------------------------------------'
  write(*,'(A50)')           ' Individual and excitation energies '
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=1,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Individual energy state ',iEns,': ',E(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=2,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Excitation energy  1 ->',iEns,': ',Om(iEns),' au'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  do iEns=2,nEns
    write(*,'(A40,I2,A2,F16.10,A3)') ' Excitation energy  1 ->',iEns,': ',Om(iEns)*HaToeV,' eV'
  end do
  write(*,'(A60)')           '-------------------------------------------------'
  write(*,*)

end subroutine print_restricted_individual_energy