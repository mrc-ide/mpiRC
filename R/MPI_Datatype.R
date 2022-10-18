mpirc_MPI_Datatype <- function(type)  {
  type <- toupper(type)

  # Order of Ops (1..) must match numbering in MPI_Type.c

  mpi_Datatype_enum <- c("INT", "DOUBLE")
  stopifnot(type %in% mpi_Datatype_enum)
  as.integer(which(type == mpi_Datatype_enum))
}
