context("mpi_initialized")

test_that("MPI is not initialized before it's... initialised", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Initialized())", procs,
                    auto_IF = FALSE)
    expect_identical(res, rep("FALSE", procs))
  }
})

test_that("MPI is initialized after being initialised", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Initialized())", procs)
    expect_identical(res, rep("TRUE", procs))
  }
})

test_that("MPI is initialized even after being finalized", {
  for (procs in 1:2) {
    res <- test_mpi(c("mpiRC::mpirc_MPI_Init()",
                      "mpiRC::mpirc_MPI_Finalize()",
                      "cat(mpiRC::mpirc_MPI_Initialized())"), procs,
                    auto_IF = FALSE)
    expect_identical(res, rep("TRUE", procs))
  }
})
