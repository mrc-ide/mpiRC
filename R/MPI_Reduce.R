##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Reduce()
##' @description Each node sends a vector of the same size to the root node,
##' which performs a reduction operation (such as sum or product) across each
##' element, resulting in a single vector of the same size as the original.
##' @param data A vector of integers or numerics to be sent
##' @param root The rank of node that receives the data
##' @param func The reduction function; a string which can currently be "SUM",
##' "PROD", "MIN" or "MAX".
##' @return On the root node, a vector of the same size as the original, having
##' applied the reduction function to the vectors from each node. On all other nodes, NULL.
mpirc_MPI_Reduce <- function(data, root, func)  {
  check_root_node(root)
  check_init()
  check_non_finalized()

  res <- .Call(c_mpirc_MPI_Reduce, data, as.integer(root), mpirc_MPI_Op(func))
  if (mpirc_MPI_Comm_rank() == root) res else NULL
}
