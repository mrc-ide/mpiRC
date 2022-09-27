context("MPI_Allgather")

test_that("MPI all gather with integers", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-as.integer((c(1,2,3)*(1+rank)))",
              "g<-mpiRC::mpirc_MPI_Allgather(x)",
              "if(rank==1)Sys.sleep(1)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 2)
  expect_true("0 1 2 3 2 4 6" %in% res)
  expect_true("1 1 2 3 2 4 6" %in% res)
  expect_equal(length(res), 2)
})

test_that("MPI all gather with doubles", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)*(1.0+rank)",
              "g<-mpiRC::mpirc_MPI_Allgather(x)",
              "if(rank==1)Sys.sleep(1)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 2)
  expect_true("0 0.1 0.2 0.3 0.2 0.4 0.6" %in% res)
  expect_true("1 0.1 0.2 0.3 0.2 0.4 0.6" %in% res)
  expect_equal(length(res), 2)
})


test_that("MPI all gather single node", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Allgather(x)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 1)
  expect_equal(res, "0 0.1 0.2 0.3")
  expect_equal(length(res), 1)

})

