#!/bin/tcsh
#BSUB -n 6                      # Number of MPI tasks
#BSUB -R span[hosts=1]          # MPI tasks per node
#BSUB -x                        # Exclusive use of nodes
#BSUB -J par_matlab             # Name of job
#BSUB -W 0:10                   # Wall clock time
#BSUB -o par_matlab.out.%J      # Standard out
#BSUB -e par_matlab.err.%J      # Standard error

#This matlab script will autodetect and use all cores on the node

##To submit, do 
## bsub < submit_henry2.csh
module load matlab         # Set environment

#Replace the start and end for your loop indicies, i.e.:
# runscript(istart,iend)
matlab -nodisplay -nosplash -r 'runscript(1,120);exit;' 
