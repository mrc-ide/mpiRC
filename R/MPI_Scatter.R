##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Scatter()
##' @description The root node sends an equally-sized chunk of its data to
##' each node.
##' @param data A vector of integers or numerics.
##' @param root The node with the data to be scattered
##' @return On each node, an equally sized chunk of the root node's data
mpirc_MPI_Scatter <- function(data, root)  {
  check_root_node(root)
  root <- as.integer(root)
  size <- mpirc_MPI_Comm_size()

  # For now assuming exact multiple.

  stopifnot(length(data) %% size == 0)

  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Scatter, data, root)
}
