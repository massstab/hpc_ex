# Exercise Session 06 #
In this session, we will mostly practice MPI communications.

In the first exercise, we establish communication between processes on a ring. Each process will send and receive information from its closest neighbours. Without being careful, it is not rare to encounter deadlocks in such problems. A bonus question (a bit more involved) will guide you to learn how to use MPI cartesian communicators on a 1D periodic grid in order to set-up the ring.  

In the second exercise, you have to estimate the Euler constant using a famous series. Your implementation have to be parallelized with MPI.

In the third exercise, you will implement the missing routines of an incomplete 2D Poisson Solver. 

In this folder you can find:

* ring_and_deadlocks/ring.c : a skeleton code that you can use to solve Exercise 1
* poisson_solver/ : the incomplete Poisson Solver for exercise 3

# Ex1 #
Compile: `cc -o ring ring.c`
allocate: `salloc --account=uzh8 --partition=debug --constraint=mc --ntasks=36 --time=00:05:00`
run: `srun -n 4 ring`

I run the code and it just hanged. First I did it with the wrong send (the Send() not the Ssend()) function and it terminated and it was smart enough to output a deadlock error (first commit). Then I grouped the processes with a simple modulo operation to find even/odd ranks. It solves the problem because two neighbouring processes can then not both be in the receive state which blocks sending. Maybe it's not the best solution if you ask like this...
