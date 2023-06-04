#!/bin/csh
#BSUB -W 0:05 		   # Maximum 5min
#BSUB -J launch_python     # Job name as listed in queue	
#BSUB -n 8 		   # number of MPI processes
#BSUB -oo launch_Python_out   # Write stdout to file s2p_out, overwrite old ones
#BSUB -eo launch_Python_err   # Write stdout to file s2p_err, overwrite old ones
module load PrgEnv-intel
mpirun ./launch Python_commands.txt
