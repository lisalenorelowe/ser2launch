% Example of using MATLAB with parfor 
% First, a user should covert their MATLAB script into a function 
%
%This function just makes a print statement with its argument and returns an error code.
function [ierr] = hello(param)

%Make print statement based on argument
fprintf('Hello from %f\n', param);

%If the task is very short (like that print statement), you can't really test if it 
% is actually running in parallel.  'pause' is like the 'sleep' command.
pause(10);

%Zero is no error
ierr = 0;
