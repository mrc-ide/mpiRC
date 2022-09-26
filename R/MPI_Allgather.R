##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Allgather()
##' @description Each node sends a vector of the same size to all others,
##' and all nodes collect all the data.
##' @param send_vec A vector of integers or numerics to be sent.
##' @return A vector of the data from all nodes in rank order.
mpirc_MPI_Allgather <- function(send_vec)  {
  .Call(c_mpirc_MPI_Allgather, send_vec)
}
