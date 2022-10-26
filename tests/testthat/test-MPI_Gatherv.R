context("MPI_Gatherv")

test_that("MPI gatherv with integers", {
  for (root in 0:1) {

    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "size<-mpiRC::mpirc_MPI_Comm_size()",
                "dat<-seq(1+rank)",
                "counts<-seq(size)",
                "displs<-cumsum(counts-1)",
        sprintf("g<-mpiRC::mpirc_MPI_Gatherv(dat,counts,displs,%d)", root),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 2)
    expect_true(sprintf("%d 1 1 2", root) %in% res)
    expect_true(sprintf("%d ", (1 - root)) %in% res)
    expect_equal(length(res), 2)
  }
})

test_that("MPI gatherv with doubles", {
  for (root in 0:1) {

    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "size<-mpiRC::mpirc_MPI_Comm_size()",
                "dat<-seq(from=1.1,length.out=(rank+1),by=1)",
                "counts<-seq(size)",
                "displs<-cumsum(counts-1)",
                sprintf("g<-mpiRC::mpirc_MPI_Gatherv(dat,counts,displs,%d)", root),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 2)
    expect_true(sprintf("%d 1.1 1.1 2.1", root) %in% res)
    expect_true(sprintf("%d ", (1 - root)) %in% res)
    expect_equal(length(res), 2)
  }
})

test_that("MPI gatherv single node", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Gatherv(x,3,0,0)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 1)
  expect_equal(res, "0 0.1 0.2 0.3")
  expect_equal(length(res), 1)

})

test_that("MPI gatherv error cases", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Gatherv(x,c(1,2,3),0,0)",
              "cat(rank,paste(g))")
  res <- test_mpi(script, 1)
  expect_true(any(grepl("counts must have an element per node", res)))

  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Gatherv(x,3,c(1,2,3),0)",
              "cat(rank,paste(g))")
  res <- test_mpi(script, 1)
  expect_true(any(grepl("displacements must have an element per node", res)))

})
