# mpiRC

This R package demonstrates running R code on multiple nodes, by using
MPI calls from C, called at the top level from R functions. At present
it is targetting our Windows-based Azure cluster, which includes 
Microsoft's MPI build. Conveniently, the libraries for MS-MPI are
also included in RTools 4.2.

