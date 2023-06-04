# Ser2launch

Program: launch

Developer:  Lisa L. Lowe, lisalenorelowe@gmail.com 

Originally for OIT-HPC@NCSU

Purpose: Bundles a series of serial jobs by distributing the commands listed in a file

## Run command

To use on Henry2 via LSF (this goes in your batch script):
```
mpirun ./launch [input file]
```
    
For general use:
```
mpirun -n [MPI tasks] ./launch [input file]
```    

## Instructions to compile and submit a batch job

Get the application and enter the directory:
```
git clone https://github.com/lisalenorelowe/ser2launch.git
cd ser2launch
```    

Compile the application, this assumes an Intel MPI environment:
```
module load PrgEnv-intel
source makeit.sh
```

For extra write statements to check the filename and that commands were sent/recieved properly, change `makeit.sh` to compile the application with "debug".
```  
#For extra debugging, uncomment this line in makeit.sh
mpiif90 -o launch -Ddebug launch.F90    
```

Run the application:

First run the test case.  The example commands are in commands.txt.  The commands say Hello from the node they are running on, write the date, and then sleep for 3 seconds.

To submit as a job on Henry2:
```
bsub < launch.csh
```
    
You should see this type of output in the LSF output launch.out.[JOBID]
```
Sending task          76 of         203
Hello from n2e2-8 on Sat Aug 1 10:00:44 EDT 2020
```

To run your own cases, either modify commands.txt, or change the name of the input file.  For example, if your list of commands is in a file my_commands.txt, then change the line in launch.csh to:
```
mpirun ./launch my_commands.txt
```  

## Limitations

In the Fortran code, the number of characters allowed in a command line is 200.  You can modify the code directly to change that number.  If you do that, remember to recompile the code.


## Warnings

**Acceptable Use**

Check your local HPC documentation for instructions on loading an MPI environment and submitting jobs. Also, if all of your tasks take 5 minutes and one takes an hour, many cores will be idle while waiting on the outstanding task to finish.  That is usually not considered as acceptable use.  Please be mindful
of this.

**For short tasks with overhead**

If you are running a very short task using a software that takes a while to load, it can cause problems or even crash a node.  In particular, I've seen this with MATLAB.  If you have a very simple and short task, try built in loop parallelization for the software, e.g., foreach/dopar(R) and search up keywords 'parallel pool' for the latest Python and MATLAB recommendations.  

This repo includes a sample MATLAB parallel loop: [par_matlab](par_matlab). 

**Also**

CONSIDER THIS A BETA VERSION!  There is no error checking of individual commands as of yet.  Use of this software is at your own risk.

----

DISCLAIMER:

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE. 
