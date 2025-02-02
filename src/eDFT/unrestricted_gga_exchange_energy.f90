subroutine unrestricted_gga_exchange_energy(DFA,nEns,wEns,nGrid,weight,rho,drho,Ex)

! Select GGA exchange functional for energy calculation

  implicit none

  include 'parameters.h'

! Input variables

  integer,intent(in)            :: DFA
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  double precision,intent(in)   :: rho(nGrid)
  double precision,intent(in)   :: drho(ncart,nGrid)

! Output variables

  double precision              :: Ex

  select case (DFA)

    case (1)

      call UG96_gga_exchange_energy(nGrid,weight,rho,drho,Ex)

    case (2)

      call UB88_gga_exchange_energy(nGrid,weight,rho,drho,Ex)

    case (3)

      call UPBE_gga_exchange_energy(nGrid,weight,rho,drho,Ex)

    case default

      call print_warning('!!! GGA exchange energy not available !!!')
      stop

  end select

end subroutine unrestricted_gga_exchange_energy
