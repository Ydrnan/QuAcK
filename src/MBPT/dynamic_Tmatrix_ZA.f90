subroutine dynamic_Tmatrix_ZA(eta,nBas,nC,nO,nV,nR,nS,nOO,nVV,lambda,eGT,Omega1,Omega2,rho1,rho2,OmBSE,ZA_dyn)

! Compute the dynamic part of the Bethe-Salpeter equation matrices

  implicit none
  include 'parameters.h'

! Input variables

  double precision,intent(in)   :: eta
  integer,intent(in)            :: nBas
  integer,intent(in)            :: nC
  integer,intent(in)            :: nO
  integer,intent(in)            :: nV
  integer,intent(in)            :: nR
  integer,intent(in)            :: nS

  integer,intent(in)            :: nOO
  integer,intent(in)            :: nVV

  double precision,intent(in)   :: lambda
  double precision,intent(in)   :: eGT(nBas)
  double precision,intent(in)   :: OmBSE

  double precision,intent(in)   :: Omega1(nVV)
  double precision,intent(in)   :: Omega2(nOO)
  double precision,intent(in)   :: rho1(nBas,nBas,nVV)
  double precision,intent(in)   :: rho2(nBas,nBas,nOO)
  
! Local variables

  double precision              :: chi
  double precision              :: eps
  integer                       :: i,j,a,b,ia,jb,cd,kl

! Output variables

  double precision,intent(out)  :: ZA_dyn(nS,nS)

! Initialization

  ZA_dyn(:,:) = 0d0

! Build dynamic A matrix

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
            eps = + OmBSE - Omega1(cd) + (eGT(i) + eGT(j))
            chi = chi + rho1(i,j,cd)*rho1(a,b,cd)*(eps**2 - eta**2)/(eps**2 + eta**2)**2
          end do

          do kl=1,nOO
            eps = + OmBSE + Omega2(kl) - (eGT(a) + eGT(b))
            chi = chi + rho2(i,j,kl)*rho2(a,b,kl)*(eps**2 - eta**2)/(eps**2 + eta**2)**2
          end do

          ZA_dyn(ia,jb) = ZA_dyn(ia,jb) + 2d0*lambda*chi

        end do
      end do
    end do
  end do

end subroutine dynamic_Tmatrix_ZA
