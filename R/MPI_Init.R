##' @useDynLib mpiRC, .registration = TRUE
NULL

check_init <- function() {
  if (!mpirc_MPI_Initialized()) {
    stop("MPI not initialized")
  }
}

check_non_init <- function() {
  if (mpirc_MPI_Initialized()) {
    stop("MPI already initialized")
  }
}

##' @export
##' @title Initialise MPI communcation
##' @description Wrapper for MPI_Init(NULL, NULL). Call only once at the start
##' of the code. After this call, you can get the size of the MPI world and
##' this node's rank.
mpirc_MPI_Init <- function()  {
  check_non_init()
  .Call(c_mpirc_MPI_Init)
  invisible()
}
