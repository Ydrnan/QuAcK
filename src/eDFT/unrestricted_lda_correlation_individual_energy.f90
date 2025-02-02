subroutine unrestricted_lda_correlation_individual_energy(DFA,LDA_centered,nEns,wEns,nGrid,weight,rhow,rho, & 
                                                          doNcentered,kappa,Ec)

! Compute LDA correlation energy for individual states

  implicit none
  include 'parameters.h'

! Input variables

  logical,intent(in)            :: LDA_centered
  integer,intent(in)            :: DFA
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  double precision,intent(in)   :: rhow(nGrid,nspin)
  double precision,intent(in)   :: rho(nGrid,nspin)
  logical,intent(in)            :: doNcentered
  double precision,intent(in)   :: kappa

! Output variables

  double precision              :: Ec(nsp)

! Select correlation functional

  select case (DFA)

    case (1)

!     call UW38_lda_correlation_individual_energy(nGrid,weight,rhow,rho,doNcentered,kappa,Ec)

    case (2)

!     call UPW92_lda_correlation_individual_energy(nGrid,weight,rhow,rho,doNcentered,kappa,Ec)

    case (3)

      call UVWN3_lda_correlation_individual_energy(nGrid,weight,rhow,rho,doNcentered,kappa,Ec)

    case (4)

      call UVWN5_lda_correlation_individual_energy(nGrid,weight,rhow,rho,doNcentered,kappa,Ec)

    case default

      call print_warning('!!! LDA correlation functional not available !!!')
      stop

  end select

end subroutine unrestricted_lda_correlation_individual_energy
