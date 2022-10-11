##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Alltoall()
##' @description Each node chops its data into equally-sized pieces, one for each
##' node, and scatters the data to each. The receiving node gathers the equally-sized
##' pieces from each sending node. For example, if there are three nodes, and six 
##' elements of data, then node 0 sends the first and second elements to node 0 (itself), 
##' the third and fourth elements to node 1, and the fifth and sixth elements to node 2. 
##' After the call, node 0 has all the first and second elements from everybody (in node 
##' order); node 1 has all the third and fourth elements similarly, and node 2 has all 
##' the fifth and sixth. Hence, MPI_Alltoall is a little like a transpose, in the way
##' data gets distributed.
##' @param data A vector of integers or numerics to be sent
##' @return A vector of the contributions of data received from each node in order of rank
##' is returned.
mpirc_MPI_Alltoall <- function(data, root)  {
  check_init()
  check_non_finalized()
  if ((length(data) %% mpirc_MPI_Comm_size()) != 0) {
    stop("In mpirc_MPI_Alltoall, data length must be multiple of node count")
  }
  .Call(c_mpirc_MPI_Alltoall, data)
}
