<h3>Ex1:</h3>
That worked.

<h3>Ex2:</h3>
That worked as well. Pushed the implementation in the setvec.cu file.

<h3>Ex3:</h3>
Wasn't too difficult. But lost one hour because i did
`cudaMemcpy(mat_out, mat_out_gpu, size, cudaMemcpyHotToDevice);`
instead of
`cudaMemcpy(mat_out, mat_out_gpu, size, cudaMemcpyDeviceToHost);`
when copying back the data from device :(

<h3>Ex4:</h3>
This one was a bit harder. To find out the right blocksize i tried different approaches. Like `n*n / BLOCKSIZE` or `n*(n-1) / BLOCKSIZE` but finally with `(n*(n+1)) / BLOCKSIZE` it passed the test. This are 3710 blocks. But with playing around with this number i got a minimum of block of `3907`.