context("MPI_Comm_size")

test_that("Comm size matches -n arg", {
  for (procs in 1:4) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Comm_size())", procs)
    expect_true(all.equal(res, rep(as.character(procs), procs)))
  }
})
