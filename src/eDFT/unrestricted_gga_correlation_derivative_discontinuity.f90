subroutine unrestricted_gga_correlation_derivative_discontinuity(DFA,nEns,wEns,nGrid,weight,rhow,Ec)

! Compute the correlation GGA part of the derivative discontinuity

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: DFA
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  double precision,intent(in)   :: rhow(nGrid,nspin)

! Local variables

  double precision              :: aC

! Output variables

  double precision,intent(out)  :: Ec(nsp,nEns)

! Select correlation functional

  select case (DFA)

    case (1)

      Ec(:,:) = 0d0

    case (2)

      Ec(:,:) = 0d0

    case default

      call print_warning('!!! GGA correlation functional not available !!!')
      stop

  end select
 
end subroutine unrestricted_gga_correlation_derivative_discontinuity
