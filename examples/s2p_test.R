# R script:  s2p_test.R
# Example of using command line arguments in an R script
# Author:  NCSU HPC
# Usage:
#  Rscript s2p_test.R [param1] [param2] [param3]

# Reads in the arguments
args = commandArgs(trailingOnly=TRUE)

# Throw error if missing or too many arguments
argslen <- length(args)
if (argslen > 3) stop('Error: too many arguments')
if (argslen < 3) stop('Error: Takes three arguments')

cat("There were ",argslen," arguments to Rscript.\n")
cat("Arguments were ",args,"\n")

cat("Parameter 1 is ",args[1],".\n",sep="")
cat("Parameter 2 is ",args[2],".\n",sep="")
cat("Parameter 3 is ",args[3],".\n",sep="")

#Print hostname to make sure jobs are distributed across nodes
system("echo $HOSTNAME")
#Do something that takes time to make sure jobs are not run in serial
system("sleep 30")
