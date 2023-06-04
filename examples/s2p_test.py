# Python script:  s2p_test.py
# Example of using command line arguments in a Python script
# Author:  NCSU HPC
# Usage:
#  python s2p_test.py [param1] [param2] [param3]

import sys
import os

print "This is the name of the script: ", sys.argv[0]

# Throw error if missing or too many arguments
if len(sys.argv) > 4:
	sys.exit('Error: too many arguments')
if len(sys.argv) < 4:
	sys.exit('Error: Takes three arguments')

print "Number of arguments: ", len(sys.argv)
print "The arguments were: " , str(sys.argv)

print "Parameter 1 is ",sys.argv[1]
print "Parameter 2 is ",sys.argv[2]
print "Parameter 3 is ",sys.argv[3]

#Print hostname to make sure jobs are distributed across nodes
os.system("echo $HOSTNAME")
#Do something that takes time to make sure jobs are not run in serial
os.system("sleep 30")

