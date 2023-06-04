#!/bin/csh
#BSUB -W 0:05 		   # Maximum 5min
#BSUB -J launch_R          # Job name as listed in queue	
#BSUB -n 8 		   # number of MPI processes
#BSUB -oo launch_R_out   # Write stdout to file s2p_out, overwrite old ones
#BSUB -eo launch_R_err   # Write stdout to file s2p_err, overwrite old ones
module load R
module load PrgEnv-intel
mpirun ./launch R_commands.txt
