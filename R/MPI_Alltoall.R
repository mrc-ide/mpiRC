##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Alltoall()
##' @description Each node sends an equally-sized portion of its data to each
##' other node; all nodes then end up with an equally-sized portion of data from
##' each other node. The size of the array to send should be an exact multiple of
##' the number of nodes. For example, if there are three nodes, and six elements of
##' data, then node 0 keeps the first and second elements, sends its third and fourth
##' elements to node 1, and its fifth and sixth elements to node 2. After the call,
##' node 0 has the first and second elements frmo everybody (in node order); node 1
##' has the third and fourth elements from everybody, and node 2 has the fifth and
##' sixth. Hence, MPI_Alltoall is a little like a transpose function, in the way it
##' distributes data; or equivalently, like a scatter followed by a gather.
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
