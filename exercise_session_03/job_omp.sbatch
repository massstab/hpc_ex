#!/bin/bash -l 
#SBATCH --job-name="sum_omp" 
#SBATCH --account="uzg2" 
#SBATCH --time=00:05:00 
#SBATCH --nodes=1 
#SBATCH --ntasks-per-core=1 
#SBATCH --ntasks-per-node=1 
#SBATCH --cpus-per-task=12 
#SBATCH --partition=debug 
#SBATCH --constraint=gpu 
#SBATCH --hint=nomultithread
#SBATCH --output=sum_omp.logs 
#SBATCH --error=sum_omp_errors.logs 


export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK 

srun ./sum_omp