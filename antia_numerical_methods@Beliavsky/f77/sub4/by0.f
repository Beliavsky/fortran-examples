!	To calculate the Bessel function of second kind of order zero
!	for real positive argument
!	For X.LE.0 the function is not defined and subroutine will return
!	a zero value without any error message or flag.
!
!	Required routines : None
 
      FUNCTION BY0(X)
!      IMPLICIT REAL*8(A-H,O-Z)
!	EUGAM is the Euler's constant
      PARAMETER(EUGAM=0.5772156649015328606D0,PI=3.14159265358979324D0)
      DIMENSION A(8),B(8),A1(5),B1(5),A2(5),B2(5),A0(7),B0(8)
 
!	Coefficients of rational function approximations
      DATA A/ 1.293686560051304152D-02,  8.573459862295151747D-05,
     1        3.854769244046149702D-07,  1.308534328117880493D-09,
     1        3.512360907188715842D-12,  7.512575042421009221D-15,
     1        1.229302278444845702D-17,  1.311883486088925264D-20/
      DATA B/ 9.999999999999999878D-01, -2.370631343994868513D-01,
     1        1.247651819849453565D-02, -2.529374255010058573D-04,
     1        2.411267406461247155D-06, -1.159484705672466498D-08,
     1        2.730546745501229851D-11, -2.517936655103065990D-14/

      DATA A0/ 1.089079731266387424D-02,  5.954632605213292419D-05,
     1         2.150109922530480401D-07,  5.641082188778387960D-10,
     1         1.102341761343675716D-12,  1.539990321465010920D-15,
     1         1.263081729204829936D-18/
      DATA B0/ 2.500000000000000006D-01, -2.071480067183403591D-02,
     1         5.553511120900719150D-04, -6.804373640943337406D-06,
     1         4.346149688717712144D-08, -1.505635199331021665D-10,
     1         2.703193275976574669D-13, -1.993047807317608951D-16/

      DATA A1/ 8.911849018950665793D+01,
     1         2.078818787053760203D+03,  1.366258799766718466D+04,
     1         1.800383785973922830D+04,  4.923440494847201509D+02/
      DATA B1/ 9.999999999999999908D-01,
     1         8.904817768950681616D+01,  2.072664795311476688D+03,
     1         1.352584337655551999D+04,  1.723138433448795889D+04/

      DATA A2/  1.046366195300779895D+02,  2.980727727381642723D+03,
     1          2.570418404044668245D+04,  5.291014161889741749D+04,
     1          9.497228391199055149D+03/
      DATA B2/ -1.249999999999999534D-01, -1.300633525376058087D+01,
     1         -3.651542590150084093D+02, -3.016744074771875522D+03,
     1         -5.251679479249748063D+03/
 
      BY0=0.0
      IF(X.LE.0) RETURN

      IF(X.LT.8.0) THEN
!	Use rational function approximations for 
        Y=X*X
        FN=((((((B(8)*Y+B(7))*Y+B(6))*Y+B(5))*Y+B(4))*Y+B(3))*Y+B(2))*Y
     1      +B(1)
        FD=(((((((A(8)*Y+A(7))*Y+A(6))*Y+A(5))*Y+A(4))*Y+A(3))*Y+A(2))*Y
     1      +A(1))*Y+1
        BJ0=FN/FD
 
        FN=((((((B0(8)*Y+B0(7))*Y+B0(6))*Y+B0(5))*Y+B0(4))*Y+B0(3))*Y
     1      +B0(2))*Y +B0(1)
        FD=((((((A0(7)*Y+A0(6))*Y+A0(5))*Y+A0(4))*Y+A0(3))*Y+A0(2))*Y
     1      +A0(1))*Y +1
        BY0=2.*(BJ0*(LOG(X/2)+EUGAM)+Y*FN/FD)/PI
 
      ELSE
!	Use rational function approximations for P_0 and Q_0
        X1=1./X**2
        FN=(((B1(5)*X1+B1(4))*X1+B1(3))*X1+B1(2))*X1+B1(1)
        FD=((((A1(5)*X1+A1(4))*X1+A1(3))*X1+A1(2))*X1+A1(1))*X1+1
        P0=FN/FD
 
        FN=(((B2(5)*X1+B2(4))*X1+B2(3))*X1+B2(2))*X1+B2(1)
        FD=((((A2(5)*X1+A2(4))*X1+A2(3))*X1+A2(2))*X1+A2(1))*X1+1
        Q0=FN/(FD*ABS(X))

        X1=ABS(X)
        BY0=SQRT(2./(PI*X1))*(P0*SIN(X1-PI/4)+Q0*COS(X1-PI/4))
!        BJ0=SQRT(2./(PI*X1))*(P0*COS(X1-PI/4)-Q0*SIN(X1-PI/4))
      ENDIF
 
      END
