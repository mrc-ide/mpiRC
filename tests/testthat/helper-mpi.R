test_mpi <- function(script, procs = 2, auto_IF = TRUE) {
  if (auto_IF) {
    script <- c("mpiRC::mpirc_MPI_Init()", script, "mpiRC::mpirc_MPI_Finalize()")
  }
  script <- script[script != ""]
  cmds <- paste(" -e ", paste(script, collapse = " -e "))
  suppressWarnings(
    system2("mpiexec", sprintf(" -n %d Rscript %s", procs, cmds),
                 stdout = TRUE, stderr = TRUE))

}
