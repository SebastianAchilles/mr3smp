      PROGRAM MAIN

      INTEGER N, NMAX, JMAX, IL, IU, M, LDA, LDZ, ZERO,
     $        SEED
      PARAMETER (NMAX=1000, JMAX=NMAX, LDA=NMAX, LDZ=NMAX, ZERO=0, 
     $           SEED=12)

      DOUBLE PRECISION VL, VU, W(NMAX)      
      COMPLEX*16 A(NMAX,NMAX), Z(NMAX,JMAX)

      INTEGER I, J, IERR

*     external functions
      EXTERNAL ZHEEIG

*     Intialize Hermitian matrix A of size N-by-N
      N = 300

      CALL SRAND(SEED)
      DO 100, I=1,N
         DO 200, J=1,I
            IF (I .EQ. J) THEN
               A(I,J) = COMPLEX(RAND(),ZERO)
            ELSE
               A(I,J) = COMPLEX(RAND(),RAND())
            ENDIF
 200     CONTINUE
 100  CONTINUE

      DO 300, I=1,N
         DO 400, J=I+1,N
            A(I,J) = CONJG(A(J,I))
 400     CONTINUE
 300  CONTINUE


*     Solve the symmetric eigenproblem
      CALL ZHEEIG('V', 'A', 'L', N, A, LDA, VL, VU, IL, IU, 
     $            M, W, Z, LDZ, IERR)
      IF (IERR .NE. 0) THEN
         WRITE(*,*) 'Routine has failed with error', IERR
      ENDIF


      WRITE(*,*) 'Sucessfully computed eigenpairs!'

      END
