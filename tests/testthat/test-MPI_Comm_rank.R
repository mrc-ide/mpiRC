context("MPI_Comm_rank")

test_that("Comm ranks are correct", {
  for (procs in 1:4) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Comm_rank())", procs)
    expect_true(all.equal(sort(res),
                          sort(as.character(0:(procs-1)))))
  }
})
