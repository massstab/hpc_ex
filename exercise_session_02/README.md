# Exercise Session 02 #
In this session, you will compile and run your first programs on Piz Daint. This directory contains two versions of the code that were parallelized using MPI or OpenMP.

Ex2
cc ist the name of the compiler. The -0 flag makes like a optimized version of the executbale? The number sets kind of a higher optimization lever. But i don't know what that means. Compiled with make cpi_mpi and make cpi_omp.

Ex3
I can see different categories: PARTITION AVAIL JOB_SIZE  TIMELIMIT   CPUS  S:C:T   NODES STATE      NODELIST.
I haven't found out how to print only a users job. Ok now i have: "squeue -u user" is the command.
To redirect logfiles i added
#SBATCH --output=output.log
#SBATCH --error=error.log
to the job script. But couldn't find the files. But it already creates a log file for every jobs by default(slurm-29776145.out).
Now it worked. Putting the logfiles in the /logs folder. Sent a question in slack if my batch file is correct.
