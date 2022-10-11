context("MPI_Alltoall")

test_that("MPI all to all with integers", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-as.integer((c(3,2,1)*(1+rank)))",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "Sys.sleep(0.25*rank)",
              "cat(rank,paste(g))")

  # ORig: 0:3,2,1    1:6,4,2    2:9,6,3
  # each proc(n) gets the nth terms:-
  #       0:3,6,9   1:2,4,6    2:1,2,3

  res <- test_mpi(script, 3)
  expect_true("0 3 6 9" %in% res)
  expect_true("1 2 4 6" %in% res)
  expect_true("2 1 2 3" %in% res)
  expect_equal(length(res), 3)

  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-as.integer((1:6*(1+rank)))",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "Sys.sleep(0.25*rank)",
              "cat(rank,paste(g))")

  # 0: 1,2,3,4,5,6     1:2,4,6,8,10,12   2:3,6,9,12,15,18
  # This time, proc 0 gets the 1st and 2nd terms...
  #            proc 1 gets the 3rd and 4th, etc... so...
  # 0:{1,2},{2,4},{3,6}
  # 1:{3,4},{6,8},{9,12}
  # 2:{5,6},{10,12},{15,18}

  res <- test_mpi(script, 3)
  expect_true("0 1 2 2 4 3 6" %in% res)
  expect_true("1 3 4 6 8 9 12" %in% res)
  expect_true("2 5 6 10 12 15 18" %in% res)
  expect_equal(length(res), 3)
})

test_that("MPI all to all with doubles", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(3,2,1)*(1.1+rank)",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "Sys.sleep(0.25*rank)",
              "cat(rank,paste(g))")

  # ORig: 0:3.3, 2.2, 1.1.   1:6.3, 4.2, 2.1   2:9.3, 6.2, 3.1
  # each proc(n) gets the nth terms:-
  #       0: 3.3, 6.3, 9.3    1: 2.2, 4.2, 6.2  2:1.1, 2.1, 3.1

  res <- test_mpi(script, 3)
  expect_true("0 3.3 6.3 9.3" %in% res)
  expect_true("1 2.2 4.2 6.2" %in% res)
  expect_true("2 1.1 2.1 3.1" %in% res)
  expect_equal(length(res), 3)

  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-1:6*(1.1+rank)",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "Sys.sleep(0.25*rank)",
              "cat(rank,paste(g))")

  # 0: 1.1, 2.2, 3.3, 4.4, 5.5, 6.6
  # 1: 2.1, 4.2, 6.3, 8.4, 10.5, 12.6
  # 2: 3.1, 6.2, 9.3, 12.4, 15.5, 18.6

  # This time, proc 0 gets the 1st and 2nd terms...
  #            proc 1 gets the 3rd and 4th, etc... so...

  # 0:{1.1, 2.2, 2.1, 4.2, 3.1, 6.2}
  # 1:{3.3, 4.4, 6.3, 8.4, 9.3, 12.4}
  # 2:{5.5, 6.6, 10.5, 12.6, 15.5, 18.6}

  res <- test_mpi(script, 3)
  expect_true("0 1.1 2.2 2.1 4.2 3.1 6.2" %in% res)
  expect_true("1 3.3 4.4 6.3 8.4 9.3 12.4" %in% res)
  expect_true("2 5.5 6.6 10.5 12.6 15.5 18.6" %in% res)
  expect_equal(length(res), 3)
})


test_that("MPI all to all single node", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2,0.3)",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 1)
  expect_equal(res, "0 0.1 0.2 0.3")
  expect_equal(length(res), 1)

})

test_that("MPI all to all - data count not divisible by size", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "x<-c(0.1,0.2)",
              "g<-mpiRC::mpirc_MPI_Alltoall(x)",
              "cat(rank,paste(g))")
  res <- test_mpi(script, 3)
  expect_equal(3, sum(grepl(
    "In mpirc_MPI_Alltoall, data length must be multiple of node count", res)))

})
