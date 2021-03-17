CFLAGS=-Wall -O3 -ffast-math -mavx2 -fopenmp
LDFLAGS=-fopenmp -lm
CC=gcc


all_cpi: gettime.o cpi.o cpi


cpi: cpi.o gettime.o
	gcc -Wall -o cpi cpi.o gettime.o

cpi.o: cpi.c
	gcc -O3 -ffast-math -mavx2 -Wall -c -o cpi.o cpi.c





all_cpi_mpi: cpi_mpi.o cpi_mpi

cpi_mpi: cpi_mpi.o gettime.o
	cc -Wall -o cpi_mpi cpi_mpi.o gettime.o

cpi_mpi.o: cpi_mpi.c gettime.c
	cc -O3 -ffast-math -mavx2 -Wall -c cpi_mpi.c gettime.c


all_sum: sum.o sum

sum: sum.o gettime.o

sum.o: sum.c gettime.h


all_sum_omp: sum_omp.o sum

sum_omp: sum_omp.o gettime.o

sum_omp.o: sum_omp.c gettime.h



gettime.o: gettime.c gettime.h
	gcc -O3 -ffast-math -mavx2 -Wall -c -o gettime.o gettime.c



clean_cpi:
	rm -f gettime.o cpi.o cpi

clean_cpi_mpi:
	rm -f gettime.o cpi_mpi.o cpi_mpi

clean_sum:
	rm -f gettime.o sum.o sum

clean_sum_omp:
	rm -f gettime.o sum_omp.o sum_omp