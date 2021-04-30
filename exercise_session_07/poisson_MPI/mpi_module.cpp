#include <mpi.h>
#include <stdio.h>
#include "init.h"
#include <math.h>
#include<bits/stdc++.h>

int start_MPI(int* my_rank, int* size){
	printf("Setting MPI environment\n");
	MPI_Init(NULL,NULL);
	MPI_Comm_size(MPI_COMM_WORLD,size);
	MPI_Comm_rank(MPI_COMM_WORLD,my_rank);

	return 0;
}

int close_MPI(){
	MPI_Finalize();
	return 0;
}

int mpi_get_domain(int nx, int ny, int my_rank, int size, int* min_x, int* max_x, int* min_y, int* max_y){
	/*
	define corners or local domains
	*/

	float slice;
	int remainder;

    printf("in mpi_get_domain() in mpi_module.cpp,  define corners of the local domains\n");

    *min_y = 0;
    *max_y = ny;

    slice = (int)floor(nx / size);
	remainder = nx % size;

	*min_x = slice * my_rank;
	*max_x = slice * (my_rank+1) -1;

	
    if (my_rank == size-1){
    	*max_x = nx;
    }

    printf("slice:%f\n", slice);
    printf("min_y:%d\n", *min_y);
    printf("max_y:%d\n", *max_y);

  
	printf("I am rank %d and my domain is: xmin, xmax, ymin, ymax: %d %d %d %d\n",my_rank,*min_x,*max_x,*min_y,*max_y);
	return 0;
}

int halo_comm(params p, int my_rank, int size, double** u, double* fromLeft, double* fromRight){
	/*this function, vectors fromLeft and fromRight should be received from the neighbours of my_rank process*/
	/*if you want to implement also cartesian topology, you need fromTop and fromBottom in addition to fromLeft a
	nd fromRight*/

	for (int j=0;j<(p.ymax - p.ymin);j++) {fromLeft[j] = 0; fromRight[j] = 0;} //initialize fromLeft and fromRight

    /* define columns to be sent to right neighbour and to the left neighbour, 
    also receive one both form left and right neighbour*/

    MPI_Status status[4];
    MPI_Request request[4];
    
	int left_rank  = (my_rank+size-1)%size;
    int right_rank = (my_rank+1)%size;

    printf("I am processor %d out of %d, left %d, right %d\n", my_rank, size, left_rank, right_rank);

    int sendlen = p.ymax - p.ymin;
    printf("%d\n", sendlen);
	double* column_to_right = new double [sendlen];
	for (int j=0;j<(p.ymax - p.ymin);j++) column_to_right[j] = u[p.xmax - p.xmin - 1][j]; 
	double* column_to_left = new double [sendlen];
	for (int j=0;j<(sendlen);j++) column_to_left[j] = u[0][j]; 

    
    for(int i=0; i<size; i++){
        MPI_Isend(column_to_left, sendlen, MPI_DOUBLE, left_rank, 0, MPI_COMM_WORLD, &request[0]);       
        MPI_Isend(column_to_right, sendlen, MPI_DOUBLE, right_rank, 0, MPI_COMM_WORLD, &request[1]);       
        MPI_Irecv(fromLeft, sendlen, MPI_DOUBLE, left_rank, 0, MPI_COMM_WORLD, &request[2]);
        MPI_Irecv(fromRight, sendlen, MPI_DOUBLE, right_rank, 0, MPI_COMM_WORLD, &request[3]);
        MPI_Wait(request, status); 
    }


	printf("mpi_module.cpp, define halo comm:  \n");
	return 0;
}


int ALLREDUCE(double* loc_diff, double* loc_sumdiff){

	MPI_Allreduce(loc_diff, loc_sumdiff, 1, MPI_DOUBLE, MPI_SUM, MPI_COMM_WORLD);

	return 0;
	}

