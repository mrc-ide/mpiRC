context("MPI_Gather")

test_that("MPI gather with integers", {
  for (root in 0:1) {

    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "x<-as.integer((c(1,2,3)*(1+rank)))",
        sprintf("g<-mpiRC::mpirc_MPI_Gather(x,%d)", root),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 2)
    expect_true(sprintf("%d 1 2 3 2 4 6", root) %in% res)
    expect_true(sprintf("%d ", (1 - root)) %in% res)
    expect_equal(length(res), 2)
  }
})

test_that("MPI gather with doubles", {
  for (root in 0:1) {

    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "x<-c(0.1,0.2,0.3)*(1.0+rank)",
                sprintf("g<-mpiRC::mpirc_MPI_Gather(x,%d)", root),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 2)
    expect_true(sprintf("%d 0.1 0.2 0.3 0.2 0.4 0.6", root) %in% res)
    expect_true(sprintf("%d ", (1 - root)) %in% res)
    expect_equal(length(res), 2)
  }
})

test_that("MPI gather single node", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Gather(x,0)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 1)
  expect_equal(res, "0 0.1 0.2 0.3")
  expect_equal(length(res), 1)

})

