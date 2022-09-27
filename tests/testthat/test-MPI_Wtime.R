context("mpi_wtime")

test_that("MPI_Wtime seems about right", {
  for (procs in 1:2) {
    res <- as.numeric(test_mpi(c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                                 "t1<-mpiRC::mpirc_MPI_Wtime()",
                                 "Sys.sleep(0.5)",
                                 "t2<-mpiRC::mpirc_MPI_Wtime()",
                                 "if(rank==1)Sys.sleep(0.5)",
                                 "cat(t2-t1)"), procs))

    expect_true(all(res > 0.4))
    expect_true(all(res < 0.6))
    expect_equal(length(res), procs)

  }
})
