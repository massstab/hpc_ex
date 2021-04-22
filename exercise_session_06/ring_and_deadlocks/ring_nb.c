#include <mpi.h>
#include <stdio.h>

int main(int argc, char** argv) {
    // Initialize the MPI environment
    MPI_Init(NULL, NULL);

    // Get the number of processes and rank of the process
    int size, my_rank, tag=0;

    MPI_Request request;
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

    int my_sum = 0;

    int send_rank = my_rank;  // Send    buffer
    int recv_rank = 0;        // Receive buffer

    // Compute the ranks of left/right neighbours 
    int left_rank, right_rank;
    if (my_rank == size-1)
    {
        left_rank = my_rank-1;
        right_rank = 0;
    }
    else if (my_rank == 0)
    {
        left_rank = size-1;
        right_rank = 1;
    }
    else {
        left_rank = my_rank-1;
        right_rank = my_rank+1;
    }

    // Loop over the number of processes
    for (int i = 0; i < size; ++i)
    {
    //     send to right, receive from left
        MPI_Irecv(&send_rank, 1,MPI_INTEGER,right_rank,tag,MPI_COMM_WORLD,&request);
        MPI_Isend(&recv_rank, 1,MPI_INTEGER,left_rank,tag,MPI_COMM_WORLD,&request);
        MPI_Wait(&request,MPI_STATUS_IGNORE);
         
    //     update the send buffer
        send_rank = recv_rank;
    //     update the local sum
        my_sum += recv_rank;      
    }
    printf("I am processor %d out of %d, and the sum is %d\n", my_rank, size, my_sum);

    // Finalize the MPI environment.
    MPI_Finalize();
}
