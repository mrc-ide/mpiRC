mpirc_MPI_Op <- function(func)  {
  func <- toupper(func)

  # Order of Ops (1..) must match numbering in MPI_Op.c

  mpi_op_enum <- c("MIN", "MAX", "PROD", "SUM")
  stopifnot(func %in% mpi_op_enum)
  as.integer(which(func == mpi_op_enum))
}
