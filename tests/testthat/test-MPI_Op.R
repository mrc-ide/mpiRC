context("MPI_Op")

test_that("MPI_Op simple tests", {
  expect_equal(mpiRC:::mpirc_MPI_Op("min"), 1)
  expect_equal(mpiRC:::mpirc_MPI_Op("MAX"), 2)
  expect_equal(mpiRC:::mpirc_MPI_Op("prod"), 3)
  expect_equal(mpiRC:::mpirc_MPI_Op("SUM"), 4)
})
