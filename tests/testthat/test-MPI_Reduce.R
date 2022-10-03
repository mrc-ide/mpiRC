context("MPI_Reduce")

test_that("MPI reduce with integers", {
  for (root in 0:1) {
    for (op in c("MIN", "MAX", "SUM", "PROD")) {

    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "x<-as.integer((rank*3):(2+(rank*3)))",
        sprintf("g<-mpiRC::mpirc_MPI_Reduce(x,%d,'%s')", root, op),
                "Sys.sleep(0.25*rank)",
                "cat(rank,paste(g))")

      res <- test_mpi(script, 2)
      v1 <- c(0,1,2)
      v2 <- c(3,4,5)
      if (op == "MIN") v3 <- pmin(v1, v2)
      else if (op == "MAX") v3 <- pmax(v1, v2)
      else if (op == "SUM") v3 <- v1 + v2
      else if (op == "PROD") v3 <- v1 * v2

      expect_true(sprintf("%d %d %d %d", root, v3[1], v3[2], v3[3]) %in% res)
      expect_true(sprintf("%d ", (1 - root)) %in% res)
      expect_equal(length(res), 2)
    }
  }
})

test_that("MPI reduce with doubles", {
  for (root in 0:1) {
    for (op in c("MIN", "MAX", "SUM", "PROD")) {

      script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                  "x<-as.double(0.1+(rank*3):(2.1+(rank*3)))",
                  sprintf("g<-mpiRC::mpirc_MPI_Reduce(x,%d,'%s')", root, op),
                  "Sys.sleep(0.25*rank)",
                  "cat(rank,paste(g))")

      res <- test_mpi(script, 2)
      v1 <- c(0.1,1.1,2.1)
      v2 <- c(3.1,4.1,5.1)
      if (op == "MIN") v3 <- pmin(v1, v2)
      else if (op == "MAX") v3 <- pmax(v1, v2)
      else if (op == "SUM") v3 <- v1 + v2
      else if (op == "PROD") v3 <- v1 * v2

      expect_true(sprintf("%d %s %s %s", root, v3[1], v3[2], v3[3]) %in% res)
      expect_true(sprintf("%d ", (1 - root)) %in% res)
      expect_equal(length(res), 2)
    }
  }
})

test_that("MPI reduce single node", {
  for (op in c("MIN", "MAX", "SUM", "PROD")) {
    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "x<-as.integer(1:3)",
                sprintf("g<-mpiRC::mpirc_MPI_Reduce(x,0,'%s')", op),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 1)
    expect_equal(res, "0 1 2 3")
    expect_equal(length(res), 1)
  }

  for (op in c("MIN", "MAX", "SUM", "PROD")) {
    script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                "x<-as.double(1.1:3.1)",
                sprintf("g<-mpiRC::mpirc_MPI_Reduce(x,0,'%s')", op),
                "cat(rank,paste(g))")

    res <- test_mpi(script, 1)
    expect_equal(res, "0 1.1 2.1 3.1")
    expect_equal(length(res), 1)
  }

})

