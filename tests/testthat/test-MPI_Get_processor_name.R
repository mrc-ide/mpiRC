context("MPI_Get_procesor_name")

test_that("Processor name is correct", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Get_processor_name())", procs)
    comp_name <- as.character(Sys.info()["nodename"])
    expect_true(all.equal(res, rep(comp_name, procs)))
  }
})
