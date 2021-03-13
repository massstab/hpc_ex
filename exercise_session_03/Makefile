CFLAGS=-O3 -ffast-math -mavx2
CC=cc

all : cpi_mpi.o gettime.o cpi_mpi

cpi_mpi : cpi_mpi.o gettime.o

cpi_mpi.o : cpi_mpi.c gettime.h

gettime.o : gettime.c gettime.h
	
clean:
	rm -f cpi_mpi cpi_mpi.o gettime.o