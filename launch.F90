PROGRAM  Main

implicit none

include 'mpif.h'

integer :: ierr, istatus(MPI_STATUS_SIZE), numprocs
integer :: myid,i,nlines,narg
integer :: pending_tasks, sent_tasks,free_proc,result
double precision :: time1,time2,time3
character*30 :: filename
character*200 :: command
character*10 :: cskip  !Command line arguments are taken as characters


! MPI Initialization 
 call MPI_INIT (ierr)
 call MPI_COMM_SIZE (MPI_COMM_WORLD, numprocs,ierr)
 call MPI_COMM_RANK (MPI_COMM_WORLD, myid, ierr)

! start timer
 time1 = MPI_Wtime()

! --- Command Line Arguments for file names ---
      if(myid.eq.0) then
         narg = command_argument_count()
       if (narg.eq.1) then
         call get_command_argument(1,filename)
         filename = trim(filename)
#ifdef debug
        write(6,*) "The input file is ", filename,"."
#endif
       endif
     endif


!--- ERROR CHECKING SECTION -------------------
! numprocs must be greater than 1
if(numprocs.eq.1) then
 write(6,*) "Code expects the number of tasks to be greater than 1."
 write(6,*) "Program will terminate."
  call MPI_FINALIZE(ierr)
 stop
endif

! First make sure there are at least as many tasks in the file as  
!  processors requested, less PE=0 
if(myid.eq.0) then
 nlines = 0 
 OPEN (1, file = filename)
 DO
   READ(1,*,iostat=ierr)
   IF (ierr/=0) EXIT
   nlines = nlines + 1
 END DO
 CLOSE (1)
 if(nlines.lt.(numprocs-1)) then
   write(6,*) "The number of commands, ",nlines,", is less than the number of MPI worker tasks, ",numprocs-1,"."
   write(6,*) "Program will terminate"
   !stop
 endif
endif

call MPI_BCAST(nlines,1,MPI_INT,0,MPI_COMM_WORLD,ierr)
if(nlines.lt.(numprocs-1)) then
 call MPI_FINALIZE(ierr)
 stop
endif
!--- END ERROR CHECKING SECTION -------------


! Processor with myid=0 (proc0) reads in parameters and sends to others 
 if(myid.eq.0) then 

  pending_tasks = 0
  sent_tasks = 0

  ! open file
  open(100,file=filename)

  ! Read the rest, send after each read
  do i=1,(numprocs-1)
   read(100,'(A)') command
   call MPI_SEND(command,200,MPI_CHAR,i,0,MPI_COMM_WORLD,ierr)
   pending_tasks = pending_tasks+1
   sent_tasks    = sent_tasks+1
#ifdef debug
   write(6,*) "pending,sent,nlines",pending_tasks,sent_tasks,nlines
#endif
  enddo
   !At this point, there is a task for each PE 
      write(6,*) "The first",(numprocs-1),"tasks have been sent."

  do  ! Wait for results, which can be from any source.
    call MPI_RECV(result,1,MPI_INTEGER,MPI_ANY_SOURCE,0,MPI_COMM_WORLD,istatus,ierr)
    free_proc = istatus(MPI_SOURCE)  !Which PE is free to request a new task
#ifdef debug
    write(6,*) "free_proc",free_proc
#endif
    if (sent_tasks < nlines) then
      read(100,'(A)') command
      write(6,*) "Sending task",sent_tasks,"of",nlines
      call MPI_SEND(command,200,MPI_CHAR,free_proc,0,MPI_COMM_WORLD,ierr)
      sent_tasks = sent_tasks + 1
    else
      ! All tasks have been sent - wait for all the results.
      pending_tasks = pending_tasks - 1
      write(6,*) "Tasks left = ",pending_tasks
    endif
    ! If all the tasks are complete, exit.
    if (pending_tasks == 0) EXIT
  enddo
 
  ! When all the tasks are complete, tell the workers there will be no more
  !  messages
  do i=1,(numprocs-1)
    command = "QUIT"
   call MPI_SEND(command,200,MPI_CHAR,i,0,MPI_COMM_WORLD,ierr)
   write(6,*) "Sent quit to pe=",i
  enddo
  !close file
  close(100)

 else

  do 
  ! Other processors recieve inputs from proc0
  call MPI_RECV(command,200,MPI_CHAR,0,0,MPI_COMM_WORLD,istatus,ierr)
    if (trim(command)=="QUIT") EXIT
     call system (trim(command))
     result=1   !Later, return the status of the command
#ifdef debug
     write(6,*) "Called command from",myid
     write(6,*) "The command was:",command
#endif
     call MPI_SEND(result, 1,MPI_INTEGER,0,0,MPI_COMM_WORLD,ierr)
  enddo
endif

 call MPI_FINALIZE(ierr)
 
 stop
END
