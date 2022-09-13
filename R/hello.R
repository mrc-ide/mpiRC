##' @useDynLib mpiRC, .registration = TRUE
NULL

mpirc_mpi_init <- function() {
  .Call(c_mpirc_mpi_init)
}

mpirc_mpi_finalize <- function() {
  .Call(c_mpirc_mpi_finalize)
}

mpirc_test_code <- function() {
  .Call(c_mpirc_test_code)
}

##' @export
##' @title Test MPI code
hello <- function() {
  mpirc_mpi_init()
  mpirc_test_code()
  mpirc_mpi_finalize()
}
