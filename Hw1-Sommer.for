      program polynomials
c*********************************************************************
c  Author: Steven Sommer
c  Course: CS 415 - Principles of Programming Languages
c  Assignment Name: Fortran Program
c  Description: This program is a FORTAN 77 program that stores polynomials.
c               Then the user can choose from two polynomials and then the program 
c               perform operations using the corresponding polynomial(s).
c
c
c
      implicit none
      integer nmax
      parameter (nmax = 20)
      integer I, N, K, L
      real X, Y, coef(3,nmax), coef_res(nmax)
      character*20 line
      open (10, file='poly.dat')
      DO I = 1, 3
        READ (10,*,END=99) N, (COEF(I,K), K = 1, N)
      END DO
99    CLOSE (10)
      DO
	PRINT *, ''
	PRINT *, '.:Stevens Fortran 77 Program:.'
	PRINT *, '------------------------------' 
        PRINT *, '1. SELECT AND EVALUATE A POLYNOMIAL'
        PRINT *, '2. SELECT AND ADD TWO POLYNOMIALS'
        PRINT *, '3. EXIT'
        PRINT *, 'Enter your choice: '
        READ *, K
        IF (K .EQ. 1) THEN
          PRINT *, 'Enter the polynomial number (1, 2, or 3): '
          READ *, L
          PRINT *, 'Enter the value of x: '
          READ *, X
          Y = 0.0
          DO I = 1, N
            Y = Y + COEF(L,I) * X**(N-I+1)
          END DO
          PRINT *, 'The value of the polynomial is ', Y
        ELSE IF (K .EQ. 2) THEN
          PRINT *, 'Enter the first polynomial number (1, 2, or 3): '
          READ *, K
          PRINT *, 'Enter the second polynomial number (1, 2, or 3): '
          READ *, L
          DO I = 1, N
            COEF_RES(I) = COEF(K,I) + COEF(L,I)
          END DO
          PRINT *, 'The result polynomial is:'
          DO I = N, 1, -1
            PRINT *, COEF_RES(I), 'x^', N-I+1, ' +'
          END DO
        ELSE
          EXIT
        END IF
      END DO
      END