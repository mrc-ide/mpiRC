##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Bcast()
##' @description The root node sends identical data to all other nodes
##' @param data The vector of data to be sent
##' @param root The rank of the node that performs the broadcast
##' @return The vector of data from the broadcasting node.
mpirc_MPI_Bcast <- function(data, root)  {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Bcast, data, as.integer(root))
}
