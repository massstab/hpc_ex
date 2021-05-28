#!/bin/bash
N=(1 5 10 12 14)
for i in {0..5};
do
	srun -n 1 ./axpy.openacc ${N[i]}
done