##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Com_size(MPI_COMM_WORLD, &no_nodes)
##' @returns Number of nodes included in the MPI_COMM_WORLD.
mpirc_MPI_Comm_size <- function() {
  check_init()
  check_non_finalized()
  as.integer(.Call(c_mpirc_MPI_Comm_size))
}
