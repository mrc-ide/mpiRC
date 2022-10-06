mpirc_MPI_Op <- function(func)  {
  func <- toupper(func)
  stopifnot(func %in% c("MIN", "MAX", "PROD", "SUM"))
  as.integer(which(func == c("MIN", "MAX", "PROD", "SUM")))
}
