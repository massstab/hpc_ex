# Exercise Session 05 #
In this session, we will first practise regular expressions using `grep` command as well as in the context of data parsing. Moreover, we will profile a simple N-body gravity code using `perftools-lite`. Also, we will investigate the complexity of this code and understand the use of `argc` and `argv` parameters. 

In this folder you can find:

* binary.txt : the data used in the first part of Exercise 1
* measurements.txt : the data used in the second part of Exercise 1
* nbody.cpp : the serial version of the gravity code needed for Exercises 2 and 3 



EX1:
1) `egrep '00$' binary.txt`
2) This condition is never given in binary.txt. But `egrep '^1\d*1$' binary.txt` would do the job.
3) This is just `egrep '110' binary.txt`
4) `egrep '(\d*1\d*){3}' binary.txt`
5) `egrep '(111)+' binary.txt`

Usage temp_time.sh:
`./temp_time.sh <measurments.txt`

EX2:
I loaded `module load perftools-lite`
I compiled with:
`CC -Og -ffast-math -o nbody nbody.cpp`
and got the warning:

WARNING: PerfTools is saving object files from a temporary directory into directory '/users/dlinder/.craypat/nbody/12679'
INFO: creating the PerfTools-instrumented executable 'nbody' (lite-samples) ...OK

Commit: The logfile is slurm.20209247.out. It contains the tables as discussed in lecture. In line 73 of the file we can see that line 23 needs 64.6% of the computation time. This is maybe where the square root one line before is computed.

Last part:
I separated the two functions and added the header files. I had some problems with multiple definitions of the struct. I defined the struct in forces.h and included it in init_conditions.h and nbody.cpp. The multiple definitions problem I solved with a header guard in forces.h.

reports:
nbody+11449-2357s, slurm-30309247.out: first part (one cpp file)
nbody+19413-2357s, slurm-30333263.out: second part (different cpp's and header files)

The program with different cpp files took 4x longer.
