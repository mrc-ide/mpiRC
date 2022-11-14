context("MPI_Get_procesor_name")

test_that("Processor name is correct", {
  for (procs in 1:2) {
    res <- test_mpi("cat(mpiRC::mpirc_MPI_Get_processor_name())", procs)
    expect_equal(length(unique(res)), 1)
    res <- toupper(res[1])
    expect_equal(res, paste(Sys.getenv("COMPUTERNAME"),
                            Sys.getenv("USERDNSDOMAIN"),
                            sep = "."))
  }
})
