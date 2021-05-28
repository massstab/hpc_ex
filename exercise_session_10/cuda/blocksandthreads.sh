#!/bin/bash

BLOCK=(60 120 180 240 300 360 420 600 )
THREAD=(16 32 48 64 80 96 112 128 144 160 )

for i in {0..7};
do
	srun cpi_cuda ${BLOCK[i]} ${THREAD[i]}
done