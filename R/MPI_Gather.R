##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Gather()
##' @description Each node sends a vector of the same size to all others,
##' and the root node alone collects all the data.
##' @param send_vec A vector of integers or numerics to be sent.
##' @return On the root node, a vector of the data from all nodes in order
##' is returned; on all other nodes, NULL.
mpirc_MPI_Gather <- function(send_vec, root)  {
  check_init()
  check_non_finalized()
  res <- .Call(c_mpirc_MPI_Gather, send_vec, as.integer(root))
  if (mpirc_MPI_Comm_rank() == root) res else NULL
}
