<h3>Ex1:</h3>
I wrote a little batch script which runs for `N=(1 5 10 12 14)` and the output is the following:

```
dlinder@daint105:/scratch/snx3000/dlinder> ./batch_run.sh 
memcopy and daxpy test of size 2
-------
timings
-------
axpy (openmp): 9.53674e-07 s
axpy (openacc): 0.000216007 s

============ PASSED
memcopy and daxpy test of size 32
-------
timings
-------
axpy (openmp): 9.53674e-07 s
axpy (openacc): 0.000216961 s

============ PASSED
memcopy and daxpy test of size 1024
-------
timings
-------
axpy (openmp): 9.53674e-07 s
axpy (openacc): 0.00022316 s

============ PASSED
memcopy and daxpy test of size 4096
-------
timings
-------
axpy (openmp): 2.86102e-06 s
axpy (openacc): 0.000232935 s

============ PASSED
memcopy and daxpy test of size 16384
-------
timings
-------
axpy (openmp): 1.00136e-05 s
axpy (openacc): 0.000238895 s

============ PASSED
memcopy and daxpy test of size 65536
-------
timings
-------
axpy (openmp): 8.70228e-05 s
axpy (openacc): 0.000335932 s

============ PASSED

```

So for the openmp case the duration stays until a certain N and then oncreases quickly. The openacc duration increases very little.
Sometimes when i run the script i wrote i got the error: `srun: error: Unable to create step for job 31508814: Job/step already completing or completed`. But when i run it manually without the script it worked.

<h3>Ex2:</h3>

Somehow we set every element `in[i]=out[i]` separate in a loop. But with my approach which was just try to set `#pragma acc parallel loop` before the for loop it gave me always this output:

```
dlinder@daint106:~/hpc_ex/exercise_session_11/basics> srun -n 1 blur.openacc_ncopies 1 1
dispersion 1D test of length n = 6 : 4.57764e-05MB
item 2 differs (expected, found): 0.375 != 0
==== failure ====
Host version took 5.00679e-06 s (5.00679e-06 s/step)
GPU version took 0.000313997 s (0.000313997 s/step)
dlinder@daint106:~/hpc_ex/exercise_session_11/basics> srun -n 1 blur.openacc_naive 1 1
dispersion 1D test of length n = 6 : 4.57764e-05MB
item 2 differs (expected, found): 0.375 != 0
==== failure ====
Host version took 4.05312e-06 s (4.05312e-06 s/step)
GPU version took 0.000283957 s (0.000283957 s/step)
dlinder@daint106:~/hpc_ex/exercise_session_11/basics> srun -n 1 blur.openacc_ncopies 2 2
dispersion 1D test of length n = 8 : 6.10352e-05MB
item 2 differs (expected, found): 0.449219 != 0.25
==== failure ====
Host version took 5.00679e-06 s (2.5034e-06 s/step)
GPU version took 0.000355005 s (0.000177503 s/step)
^[[Adlinder@daint106:~/hpc_ex/exercise_session_11/basics> srun -n 1 blur.openacc_naive 2 2
dispersion 1D test of length n = 8 : 6.10352e-05MB
item 2 differs (expected, found): 0.449219 != 0
==== failure ====
Host version took 4.05312e-06 s (2.02656e-06 s/step)
GPU version took 0.000335932 s (0.000167966 s/step)

```
Finally i got it to run with success but couldn't find out how to copy the data in and out...

```
dlinder@daint102:~/hpc_ex/exercise_session_11/basics> srun -n 1 ./blur.openacc_nocopies 100 10000
dispersion 1D test of length n = 20 : 0.000152588MB
==== success ====
Host version took 0.000370026 s (3.70026e-08 s/step)
GPU version took 0.588081 s (5.88081e-05 s/step)
```