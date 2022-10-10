##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Allreduce()
##' @description Each node sends a vector of the same size to all other nodes,
##' which each perform a reduction operation (such as sum or product) across each
##' element, resulting in a single vector of the same size as the original.
##' @param data A vector of integers or numerics to be sent
##' @param func The reduction function; a string which can currently be "SUM",
##' "PROD", "MIN" or "MAX".
##' @return On the root node, a vector of the same size as the original, having
##' applied the reduction function to the vectors from each node. On all other nodes, NULL.
mpirc_MPI_Allreduce <- function(data, func)  {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Allreduce, data, mpirc_MPI_Op(func))
}
