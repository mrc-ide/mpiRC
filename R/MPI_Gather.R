##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Gather()
##' @description Each node sends a vector of the same size to all others,
##' and the root node alone collects all the data.
##' @param data A vector of integers or numerics to be sent
##' @param root The rank of node that receives the gathered data
##' @return On the root node, a vector of the data from all nodes in order
##' is returned; on all other nodes, NULL.
mpirc_MPI_Gather <- function(data, root)  {
  check_root_node(root)
  check_init()
  check_non_finalized()
  res <- .Call(c_mpirc_MPI_Gather, data, as.integer(root))
  if (mpirc_MPI_Comm_rank() == root) res else NULL
}
