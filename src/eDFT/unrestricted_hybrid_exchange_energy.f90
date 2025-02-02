subroutine unrestricted_hybrid_exchange_energy(DFA,LDA_centered,nEns,wEns,aCC_w1,aCC_w2,nGrid,weight,nBas,P,FxHF, &
                                               rho,drho,Ex,Cx_choice)

! Compute the exchange energy for hybrid functionals

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: DFA
  logical,intent(in)            :: LDA_centered
  integer,intent(in)            :: nEns
  double precision,intent(in)   :: wEns(nEns)
  double precision,intent(in)   :: aCC_w1(3)
  double precision,intent(in)   :: aCC_w2(3)
  integer,intent(in)            :: nGrid
  double precision,intent(in)   :: weight(nGrid)
  integer,intent(in)            :: nBas
  double precision,intent(in)   :: P(nBas,nBas)
  double precision,intent(in)   :: FxHF(nBas,nBas)
  double precision,intent(in)   :: rho(nGrid)
  double precision,intent(in)   :: drho(ncart,nGrid)
  integer,intent(in)            :: Cx_choice

! Local variables

  double precision              :: ExLDA,ExGGA,ExHF
  double precision              :: a0,aX

! Output variables

  double precision,intent(out)  :: Ex

  select case (DFA) 

    case (1)

      call unrestricted_fock_exchange_energy(nBas,P,FxHF,Ex)

    case (2)

      a0 = 0.20d0
      aX = 0.72d0
  
      call unrestricted_lda_exchange_energy(1,LDA_centered,nEns,wEns,aCC_w1,aCC_w2,nGrid,weight,&
                                            rho,ExLDA,Cx_choice)
      call unrestricted_gga_exchange_energy(2,nEns,wEns,nGrid,weight,rho,drho,ExGGA)
      call unrestricted_fock_exchange_energy(nBas,P,FxHF,ExHF)
  
      Ex = ExLDA              & 
         + a0*(ExHF  - ExLDA) &
         + aX*(ExGGA - ExLDA) 

    case (3)

      call unrestricted_gga_exchange_energy(2,nEns,wEns,nGrid,weight,rho,drho,ExGGA)
      call unrestricted_fock_exchange_energy(nBas,P,FxHF,ExHF)
  
      Ex = 0.5d0*ExHF + 0.5d0*ExGGA

    case (4)

      call unrestricted_gga_exchange_energy(3,nEns,wEns,nGrid,weight,rho,drho,ExGGA)
      call unrestricted_fock_exchange_energy(nBas,P,FxHF,ExHF)
  
      Ex = 0.25d0*ExHF + 0.75d0*ExGGA

    case default

      call print_warning('!!! Hybrid exchange energy not available !!!')
      stop

  end select
 
end subroutine unrestricted_hybrid_exchange_energy
