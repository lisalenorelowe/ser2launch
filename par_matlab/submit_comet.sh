#!/bin/bash
#SBATCH --job-name="par_matlab"
#SBATCH --output="par_matlab.out.%j.%N"
#SBATCH --partition=debug
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --export=ALL
#SBATCH -t 00:30:00

#To use, do
#  sbatch submit_comet.sh

#This job runs with 1 nodes, 24 cores per node for a total of 24 cores.
#ibrun in verbose mode will give binding detail
module load matlab

#Replace the start and end for your loop indicies, i.e.:
# runscript(istart,iend)
matlab -nodisplay -nosplash -r 'runscript(1,248);exit;'

