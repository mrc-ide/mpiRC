##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title MPI Barrier
##' @description Wrapper for MPI_Barrier(world). Causes MPI processes to
##' block until all of the team reach the barrier, and only the continue.
##' Use this to ensure parallel work is completed before the next section
##' of code starts.
mpirc_MPI_Barrier <- function()  {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Barrier)
  invisible()
}
