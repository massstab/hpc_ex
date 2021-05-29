#include <cuda.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

/* Define the matrix size */
#define NX 200
#define NY 100

/* Size of a block */
#define BLOCKSIZE 256

__global__ void kernadd (float* mout, float* min1, float *min2, int nx, int ny)
{
  int i, j, index;
  index = blockDim.x*blockIdx.x+threadIdx.x;
  j = index/nx;
  i = index - j*nx;
  if ((i < nx) && (j < ny))
    mout[index] = min1[index] + min2[index];
    
}


/*******************************************************/
/*  We initialize the vectors with random values       */
/*******************************************************/

void Init(float* mat, int nx, int ny) {
  int i, j;
  for (i = 0; i < nx; i++) {	/* 2D loop */
    for (j = 0; j < ny; j++) {
      mat[i+j*nx] = drand48 ();	/* position of cell (i,j) */
    }
  }
}


/*******************************************************/
/*            MAIN PROGRAM                             */
/*******************************************************/

int main () {
  int i=0, error=0, nx=NX, ny=NY;
  float diff;
  int size = nx * ny * sizeof(float);

  /* Matrix allocation */
  float *mat_in1 = (float*) malloc(size);
  float *mat_in2 = (float*) malloc(size);
  float *mat_out = (float*) malloc(size);

  /* Matrix allocation on device */
  float *mat_out_gpu, *mat_in1_gpu, *mat_in2_gpu;
  /* TO DO : do the allocation below, using cudaMalloc()*/
  cudaMalloc (&mat_in1_gpu, size);
  cudaMalloc (&mat_in2_gpu, size);
  cudaMalloc (&mat_out_gpu, size);

  /* Matrix initialization */
  Init(mat_in1, nx, ny);
  Init(mat_in2, nx, ny);  
  
  /* TO DO : write below the instructions to copy it to the device */
  cudaMemcpy(mat_in1_gpu, mat_in1, size, cudaMemcpyHostToDevice);
  cudaMemcpy(mat_in2_gpu, mat_in2, size, cudaMemcpyHostToDevice);
  cudaMemcpy(mat_out_gpu, mat_out, size, cudaMemcpyHostToDevice);
  
  /* TO DO : complete the number of blocks below */
  int numBlocks = (nx * ny + BLOCKSIZE-1) / BLOCKSIZE;
 
  /* TO DO : kernel invocation */
  kernadd<<<numBlocks, BLOCKSIZE>>>(mat_out_gpu, mat_in1_gpu, mat_in2_gpu, nx, ny);

  cudaDeviceSynchronize();
  
  /* We now transfer back the matrix from the device to the host */
  /* TO DO : write cudaMemcpy() instruction below */
  cudaMemcpy(mat_out, mat_out_gpu, size, cudaMemcpyDeviceToHost);  
    
  /* free memory */
  cudaFree(mat_out_gpu);
  cudaFree(mat_in1_gpu);
  cudaFree(mat_in2_gpu);

  /* We now check that the result is correct */

  for (i=0; i< nx*ny; i++) {	/* No need for a 2D loop, actually ! */
    diff = mat_out[i] - (mat_in1[i]+mat_in2[i]);
    if (fabs(diff) > 0.0000001f) {
      error = 1;
    }
  }

  if (error) {
    printf("FAILED\n");
  }
  else {
    printf("PASSED\n");
  }
  free (mat_in1);
  free (mat_in2);
  free (mat_out);
}



