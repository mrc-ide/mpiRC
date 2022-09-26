context("mpi_finalized")

test_that("MPI is not finalized before it's initialised", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Finalized())", procs,
                    auto_IF = FALSE)
    expect_identical(res, rep("FALSE", procs))
  }
})

test_that("MPI is not finalized after just initialisation", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Finalized())", procs)
    expect_identical(res, rep("FALSE", procs))
  }
})

test_that("MPI is finalized when it's finalized", {
  for (procs in 1:2) {
    res <- test_mpi(c("mpiRC::mpirc_MPI_Init()",
                      "mpiRC::mpirc_MPI_Finalize()",
                      "cat(mpiRC::mpirc_MPI_Finalized())"), procs,
                    auto_IF = FALSE)
    expect_identical(res, rep("TRUE", procs))
  }
})
