#!/bin/bash
N=( )
for i in {0..7};
do
	srun -n 1 axpy.openacc ${N[i]}
done