##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Test if MPI is initialised
##' @description Wrapper for MPI_Initialized(). Useful since other operations
##' will crash R if called from an inappropriate state.
mpirc_MPI_Initialized <- function()  {
  as.logical(.Call(c_mpirc_MPI_Initialized))
}
