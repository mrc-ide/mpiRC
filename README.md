# mpiRC

This R package allows MPI functions to be called from R code, 
by wrapping MPI calls with the C API. Function arguments will
not be exactly the same as the MPI originals, primarily
because the originals make use of var parameters for the
data structures. Moreover, we may be able to simplify the function
calls a little by calculating length and establishing data types
automatically.

## Implemented / To-Do

It is unlikely I'll implement the entirety of the MPI standard, and
at least for now, the focus is on multi-node (not threaded, as there
are other viable ways of doing that), with all the usual suspects
that get taught in a foundational MPI course.

Below is the plan of what I'd like to implement, and a rough
indication of functionality so far.

- [x] MPI_Allgather
- [ ] MPI_Allgatherv
- [x] MPI_Bcast 
- [x] MPI_Barrier
- [x] MPI_Comm_rank
- [x] MPI_Comm_size
- [x] MPI_Finalize
- [x] MPI_Finalized
- [x] MPI_Gather (of whole vector)
- [ ] MPI_Gatherv
- [x] MPI_Get_processor_name
- [x] MPI_Init
- [x] MPI_Initialized
- [ ] MPI_Recv
- [ ] MPI_Reduce
- [ ] MPI_Reduceall
- [ ] MPI_Scatter
- [ ] MPI_Scatterv
- [ ] MPI_Send
- [x] MPI_Wtime

## Contributions 

To implement a new command, look through the PRs a similar command, or 
basically follow this sort of path:

* Make a github branch with the name of the MPI_Command
* Write src/MPI_Command.c, using a similar existing command as a guide.
* Update the top of src/zzz.c
* Add the new functinon in src/mpiRC.h
* Write R/MPI_Command.R, again, using a similar existing one as a guide.
* devtools::document() to create man/mpirc_MPI_command.Rd
* Write tests/testthat/test-MPI_command.R, using another as a guide.
* Update DESCRIPTION, NEWS, and this README.
* Test. You'll need mpiexec on your path.
* Done. Make the PR



## Requirements

The package has been developed in R 4.2, alongside RTools 4.2, which
helpfully contains support for the Microsoft MPI library. You will need
the Microsoft `mpiexec` tool from 
[here](https://www.microsoft.com/en-us/download/confirmation.aspx?id=100593)

* Make sure when you run `mpiexec` from the command-line, you really
do get a Microsoft one. There is also an Intel provided MPI library, 
if you've installed Intel Parallel Studio. This has a different protocol,
and while the parallel launch will occur, you'll find the rank and size 
will be reported incorrectly.

* After this, MPI code can be launched locally with something like
```
mpiexec -n 4 Rscript my_mpi_code.R
```

* And if you happen to have a Microsoft HPC (Azure) Cluster available,
simply running a multi-node job will work as you'd hope:

```
job submit /scheduler:HN /jobtemplate:JT /workdir:WD /numnodes:4 mpiexec -n 4 run.bat
```

where run.bat contains whatever you need to do to run your R job.
