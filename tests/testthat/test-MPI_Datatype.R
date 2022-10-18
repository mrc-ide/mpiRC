context("MPI_Datatype")

test_that("MPI_Datatype simple tests", {
  expect_equal(mpiRC:::mpirc_MPI_Datatype("int"), 1)
  expect_equal(mpiRC:::mpirc_MPI_Datatype("DOUBLE"), 2)
})
