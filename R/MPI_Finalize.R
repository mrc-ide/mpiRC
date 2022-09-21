##' @useDynLib mpiRC, .registration = TRUE
NULL

check_non_finalized <- function() {
  if (mpirc_MPI_Finalized()) {
    stop("MPI already finalized")
  }
}


##' @export
##' @title Finalize MPI communications.
##' @description Wrapper for MPI_Finalize(). Call this only once at the end of
##' the code.
mpirc_MPI_Finalize <- function()  {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Finalize)
  invisible()
}
