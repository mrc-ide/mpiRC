##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Comm_rank(MPI_COMM_WORLD, &my_rank)
##' @returns Rank of this node, between 0 and (size-1) inclusive.
mpirc_MPI_Comm_rank <- function() {
  check_init()
  check_non_finalized()
  as.integer(.Call(c_mpirc_MPI_Comm_rank))
}
