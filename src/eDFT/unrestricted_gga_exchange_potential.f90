subroutine unrestricted_gga_exchange_potential(DFA,nEns,wEns,nGrid,weight,nBas,AO,dAO,rho,drho,Fx)

! Select GGA exchange functional for potential calculation

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: DFA
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  integer,intent(in)            :: nBas
  double precision,intent(in)   :: AO(nBas,nGrid)
  double precision,intent(in)   :: dAO(3,nBas,nGrid)
  double precision,intent(in)   :: rho(nGrid)
  double precision,intent(in)   :: drho(3,nGrid)

! Output variables

  double precision,intent(out)  :: Fx(nBas,nBas)

! Select GGA exchange functional

  select case (DFA)

    case (1)

      call UG96_gga_exchange_potential(nGrid,weight,nBas,AO,dAO,rho,drho,Fx)
      
    case (2)
    
      call UB88_gga_exchange_potential(nGrid,weight,nBas,AO,dAO,rho,drho,Fx)

    case (3)
    
      call UPBE_gga_exchange_potential(nGrid,weight,nBas,AO,dAO,rho,drho,Fx)

    case default

      call print_warning('!!! GGA exchange potential not available !!!')
      stop

  end select

end subroutine unrestricted_gga_exchange_potential
