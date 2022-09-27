context("MPI_Finalize")

test_that("Multiple Finalize fails", {
  for (procs in 1:2) {
    res <- test_mpi(c("mpiRC::mpirc_MPI_Init()", "mpiRC::mpirc_MPI_Finalize()",
                      "mpiRC::mpirc_MPI_Finalize()"), procs, auto_IF = FALSE)
    expect_equal(sum(grepl("MPI already finalized", res)), procs)
  }
})

test_that("Finalize without init fails", {
  for (procs in 1:2) {
    res <- test_mpi("mpiRC::mpirc_MPI_Finalize()", procs, auto_IF = FALSE)
    expect_equal(sum(grepl("MPI not initialized", res)), procs)
  }
})

