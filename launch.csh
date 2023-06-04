#!/bin/csh
#BSUB -W 0:05 		   # Maximum 5min
#BSUB -J launch            # Job name as listed in queue	
#BSUB -n 8 		   # number of MPI processes
#BSUB -oo launch.out.%J   # Write stdout to file s2p_out, overwrite old ones
#BSUB -eo launch.err.%J   # Write stdout to file s2p_err, overwrite old ones
module load PrgEnv-intel 
mpirun ./launch commands.txt
