context("MPI_Bcast")

test_that("MPI_Bcast works for different types, roots and sizes", {
  for (type in 1:2) {
    if (type == 1) {
      v1 <- "as.integer(c(-3,4,-5))"
      r1 <- "-3 4 -5"
    } else {
      v1 <- "as.double(c(3.14,6.28,-42))"
      r1 <- "3.14 6.28 -42"
    }

    for (nodes in 1:3) {
      for (root in 0:(nodes-1)) {

        script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
            sprintf("x<-%s", v1),
            sprintf("g<-mpiRC::mpirc_MPI_Bcast(x,%d)", root),
                    "Sys.sleep(0.25*rank)",
                    "cat(rank,paste(g))")

        res <- test_mpi(script, nodes)
        for (j in 0:(nodes-1)) {
          expect_true(sprintf("%d %s", j, r1) %in% res)
        }
        expect_equal(length(res), nodes)
      }
    }
  }
})
