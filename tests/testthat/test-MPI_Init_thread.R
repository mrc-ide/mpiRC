context("MPI_Init_thread")

test_that("Multiple INIT fails", {
  for (procs in 1:2) {
    res <- test_mpi(c("mpiRC::mpirc_MPI_Init()",
                      "mpiRC::mpirc_MPI_Init_thread('MPI_THREAD_SINGLE')"),
                    procs, auto_IF = FALSE)
    expect_equal(sum(grepl("MPI already initialized", res)), procs)
    res <- test_mpi(c("mpiRC::mpirc_MPI_Init_thread('MPI_THREAD_SINGLE')",
                      "mpiRC::mpirc_MPI_Init()"),
                    procs, auto_IF = FALSE)
    expect_equal(sum(grepl("MPI already initialized", res)), procs)
  }
})

test_that("Init and Finalize works", {
  for (procs in 1:2) {
    res <- test_mpi(c("x<-mpiRC::mpirc_MPI_Init_thread('MPI_THREAD_MULTIPLE')",
                      "mpiRC::mpirc_MPI_Finalize()"),
                    procs, auto_IF = FALSE)
    expect_equal(length(res), 0)
    res <- test_mpi("", procs, auto_IF = TRUE)
    expect_equal(length(res), 0)
  }
})

