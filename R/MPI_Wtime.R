##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Wtime()
##' @returns Returns a high-resolution time in seconds since some reference point.
mpirc_MPI_Wtime <- function() {
  check_init()
  check_non_finalized()
  as.double(.Call(c_mpirc_MPI_Wtime))
}
