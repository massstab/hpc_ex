# Exercise Session 03 #
In this session, you will work on modularization of the code and compilation optimization. Moreover, you will parallelize a simple code and successively plot its speedup. 
In this folder you can find:

* cpi.c : the serial version of last week parallel code, needed for Exercise 1
* cpi_mpi.c : the MPI version of cpi code, for Exercise 1
* sum.c : the code needed for Exercise 2


My notes:

Ex1:
Couldn't run the script becausee of the error: project "uzh8" has exceeded the maximum allowable usage
sbatch: error: cli_filter plugin terminated with error

Ok now it worked with the new uzg2 project.
4.02 seconds (mpi_Wtime)
4.03 seconds (getTime)
They are different because they where not exactly defined at the same time.


Ex2:
Compiled sum.c. But I had some problems with the lin: "gettime.o : gettime.c gettime.h". If i run with "make all" he wouldn't find the gettime.o file. If i run separate "make gettime.o" he wouldn't compile the gettime.c file again because it think it is up to date even when the gettime.o file doesn't even exists.
So i adden the line "gcc -O3 -ffast-math -mavx2 -c -o gettime.o gettime.c" and then it worked...

Different optimizations:
-O0: 0.38s
-O1: 0.20s
-O2: 0.17s
-O3: 0.17s
With the two flags: -ffast-math and -mavx2 I got approx 0.13s.

In the for loop it adds bitwise (&) with i and the numbers 15, 31 and 63. Then it adds the "distance" to each coordinate. I don't know what that should be.

I found here (https://www.geeksforgeeks.org/how-to-measure-time-taken-by-a-program-in-c/) a simple way to time your code with the time.h module.

I inserted the #pragma line right before the for loop. I #included the omp.h file but I didn't change the makefile. Is this right? So the compiler finds the included standard libraries without explicitly mention it in the makefile. 
Unfortunately the sbatch command gave me the error: "project "uzh8" has exceeded the maximum allowable usage" so i couldn't run my script in parallel.

Now I could run the parallel version: I tried to name all the files properly. I didn't put the different programs into folders. The makefile can compile all the c files with the make all_ command. Maybe when I have time, I will plot the speedup and make the bonus exercise.