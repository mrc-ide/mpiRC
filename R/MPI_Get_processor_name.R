##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Get processor name
##' @description Wrapper for MPI_Get_processor_name.
##' @returns The name of the compute node calling the function.
mpirc_MPI_Get_processor_name <- function() {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Get_processor_name)
}
