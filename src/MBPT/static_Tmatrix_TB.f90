subroutine static_Tmatrix_TB(eta,nBas,nC,nO,nV,nR,nS,nOO,nVV,lambda,ERI,Omega1,rho1,Omega2,rho2,TB)

! Compute the OVVO block of the static T-matrix for the coupling block

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: nBas
  integer,intent(in)            :: nC
  integer,intent(in)            :: nO
  integer,intent(in)            :: nV
  integer,intent(in)            :: nR
  integer,intent(in)            :: nS
  integer,intent(in)            :: nOO
  integer,intent(in)            :: nVV
  double precision,intent(in)   :: eta
  double precision,intent(in)   :: lambda
  double precision,intent(in)   :: ERI(nBas,nBas,nBas,nBas)
  double precision,intent(in)   :: Omega1(nVV)
  double precision,intent(in)   :: rho1(nBas,nBas,nVV)
  double precision,intent(in)   :: Omega2(nOO)
  double precision,intent(in)   :: rho2(nBas,nBas,nOO)

! Local variables

  double precision              :: chi
  double precision              :: eps
  integer                       :: i,j,a,b,ia,jb,kl,cd

! Output variables

  double precision,intent(out)  :: TB(nS,nS)

  ia = 0
  do i=nC+1,nO
    do a=nO+1,nBas-nR
      ia = ia + 1
      jb = 0
      do j=nC+1,nO
        do b=nO+1,nBas-nR
          jb = jb + 1

          chi = 0d0

          do cd=1,nVV
            eps = Omega1(cd)**2 + eta**2
!           chi = chi + lambda*rho1(i,b,cd)*rho1(a,j,cd)*Omega1(cd)/eps
            chi = chi + rho1(i,b,cd)*rho1(a,j,cd)*Omega1(cd)/eps
          enddo

          do kl=1,nOO
            eps = Omega2(kl)**2 + eta**2
!           chi = chi + lambda*rho2(i,b,kl)*rho2(a,j,kl)*Omega2(kl)/eps
            chi = chi + rho2(i,b,kl)*rho2(a,j,kl)*Omega2(kl)/eps
          enddo

          TB(ia,jb) = TB(ia,jb) + 2d0*lambda*chi

        enddo
      enddo
    enddo
  enddo

end subroutine static_Tmatrix_TB
