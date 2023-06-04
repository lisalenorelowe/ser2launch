%Call a function in parallel
%Example is 'hello', please replace with your function
function[ierr] = runscript(istart,iend) 

%Set to all cores on the node
numCores = maxNumCompThreads
parpool(numCores) 

%Start loop
parfor loopVar = istart:iend; 

%replace 'hello' with your function
%If you want to get all the output, remove the semicolon
hello(loopVar);

end

ierr=0;
