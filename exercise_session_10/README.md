Ex1:

The output is everytime different. It takes longer every iteration. And the value of pi is doubled every time. Hmm.
`PI = 3.141592653589793 computed in 0.1099 seconds`
`PI = 6.283185307179586 computed in 0.1241 seconds`
`PI = 9.424777960769379 computed in 0.1382 seconds`
`PI = 12.56637061435917 computed in 0.1523 seconds`
`PI = 15.70796326794896 computed in 0.1663 seconds`


Ex2:
I compiled the code with:
`nvcc --gpu-architecture=sm_60 -o cpi_cuda cpi_cuda.cu gettime.c`
Now I got the following output:
`PI = 3.14159265358979 computed in 0.08585 seconds`


