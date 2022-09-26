# mpiRC

This R package allows MPI functions to be called from R code, 
by wrapping MPI calls with the C API. Function arguments will
not be exactly the same as the MPI originals, primarily
because the originals make use of var parameters for the
data structures. Moreover, we may be able to simplify the function
calls a little by calculating length and establishing data types
automatically.

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
