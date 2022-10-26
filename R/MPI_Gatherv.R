##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Gatherv()
##' @description Each node sends a vector (of any size) to all others,
##' and the root node alone collects all the data into one vector,
##' with sizes and offsets in the final vector declared.
##' @param data A vector of integers or numerics to be sent
##' @param counts The size of the vector send by each node
##' @param displacements The position in the resulting vector where each
##' node's contributing data is put; the first element is zero.
##' @param root The rank of node that receives the gathered data
##' @return On the root node, a vector of the data from all nodes, arranged
##' as specified by the counts and displacements. On all other nodes, NULL.
mpirc_MPI_Gatherv <- function(data, counts, displacements, root)  {
  check_root_node(root)
  check_init()
  check_non_finalized()
  nodes <- mpirc_MPI_Comm_size()
  if (length(counts) != nodes) {
    stop("In mpirc_MPI_Gatherv, counts must have an element per node")
  }
  if (length(displacements) != nodes) {
    stop("In mpirc_MPI_Gatherv, displacements must have an element per node")
  }
  stopifnot(is.vector(counts))
  stopifnot(is.vector(displacements))
  stopifnot(is.null(unlist(lapply(counts, assert_whole))))
  stopifnot(is.null(unlist(lapply(displacements, assert_whole))))

  res <- .Call(c_mpirc_MPI_Gatherv, data, as.integer(counts),
               as.integer(displacements), as.integer(root))
  if (mpirc_MPI_Comm_rank() == root) res else NULL
}
