##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Test if MPI was finalized.
##' @description Wrapper for MPI_Finalized().
mpirc_MPI_Finalized <- function()  {
  as.logical(.Call(c_mpirc_MPI_Finalized))
}
