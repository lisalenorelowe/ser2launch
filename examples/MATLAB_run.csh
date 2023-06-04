#!/bin/csh
#BSUB -W 0:05 		   # Maximum 5min
#BSUB -J launch_matlab     # Job name as listed in queue	
#BSUB -n 8 		   # number of MPI processes
#BSUB -oo launch_matlab_out   # Write stdout to file s2p_out, overwrite old ones
#BSUB -eo launch_matlab_err   # Write stdout to file s2p_err, overwrite old ones
module load PrgEnv-intel 
module load matlab
mpirun ./launch MATLAB_commands.txt
