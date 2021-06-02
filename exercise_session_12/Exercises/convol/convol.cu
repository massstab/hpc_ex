#include <time.h>
#include <cuda.h>
#include <stdio.h>
#define STOP 0
#define START 1

#define BLOCKSIZE 256


extern "C" void chrono (int kind, float *time);

__global__ void kconvol (float *gpu_a, float *gpu_b, int n) {
  int i, j, l;
  // TO DO : evaluate the global 1D index l of the current thread,
  // using blockDim, blockIdx and threadIdx.
  l = threadIdx.x + blockIdx.x * blockDim.x;
  int bIdx = (blockIdx.x);
  int cDim = (blockDim.x);
  int TIdx = (threadIdx.x);
  
  // TO DO : evaluate global indices of thread (i,j) from the index l
  j = l % n;
  i = l / n;
  //printf("%d\n", l);
  //printf("---------\nl = %d, (i,j) = (%d,%d)\nblockIdx: %d\nblockDim: %d\nthreadIdx: %d\n", l, i, j, bIdx, cDim, TIdx);

  if ((i >= n) || (j >= n)) return;
  if ((i == 0) || (j == 0) || (i == n-1) || (j == n-1))  {
    gpu_b[l] = gpu_a[l]; // edges are untouched
  }
  else
    // TO DO : fill up the MISSING indices below
    gpu_b[l]=(1./5.)*(gpu_a[l-n] + gpu_a[l-1] + gpu_a[l] + gpu_a[l+1]+ gpu_a[l+n]);
}

extern "C" void gpu_convol (float *a, float *b, int n, int blocks) {
  float *gpu_a;
  float *gpu_b;
  cudaError_t err;
  float time;
  
  err = cudaMalloc (&gpu_a, n*n*sizeof(float));
  if (err != 0) {
    printf ("Error allocating gpu_a: %s\n", cudaGetErrorString (err));
    exit (1);
  }
  err = cudaMalloc (&gpu_b, n*n*sizeof(float));
  if (err != 0) {
    printf ("Error allocating gpu_b: %s\n", cudaGetErrorString (err));
    exit (1);
  }
  
  cudaMemcpy (gpu_a, a, n*n*sizeof(float), cudaMemcpyHostToDevice);
    
  // NOTE : the chronometer below does not contemplate overhead of memory allocation and
  // memory transfer.
  chrono (START, &time);
  // TO DO : the number of blocks is missing below in the kernel invocation
  //int blocks = (1000192) / BLOCKSIZE;
  printf("block: %d\n", blocks);
  printf("blocksize: %d\n", BLOCKSIZE);
  kconvol <<<blocks,BLOCKSIZE>>> (gpu_a, gpu_b, n);
  err=cudaDeviceSynchronize ();
  chrono (STOP, &time);
  printf ("Convolution took  %f sec. on GPU\n", time);
  cudaMemcpy (b, gpu_b, n*n*sizeof(float), cudaMemcpyDeviceToHost);
  if (err != 0) {
    printf ("%s\n", cudaGetErrorString (err));
    exit (1);
  }
  FILE *fp;
  fp = fopen("timing_plot_1000x1000.out", "a");
  fprintf(fp, "%d, %.10g\n", blocks, time);
  cudaFree (gpu_a);
  cudaFree (gpu_b);
}
