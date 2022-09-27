context("MPI_Barrier")

test_that("MPI_Barrier seems about right", {
  for (procs in 2:4) {
    res <- test_mpi(c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
                      "t1<-mpiRC::mpirc_MPI_Wtime()",
                      "Sys.sleep(0.1+(rank*0.5))",
                      "t2<-mpiRC::mpirc_MPI_Wtime()",
                      "mpiRC::mpirc_MPI_Barrier()",
                      "t3<-mpiRC::mpirc_MPI_Wtime()",
                      "Sys.sleep(0.1+(rank*0.5))",
                      "message(paste(rank,t1,1))",
                      "message(paste(rank,t2,2))",
                      "message(paste(rank,t3,3))"), procs)

    res <- data.frame(proc = as.integer(unlist(lapply(strsplit(res, " "), `[[`, 1))),
                      time = as.double(unlist(lapply(strsplit(res, " "), `[[`, 2))),
                      loc = as.integer(unlist(lapply(strsplit(res, " "), `[[`, 3))))

    diff1 <- max(res$time[res$loc == 1]) - min(res$time[res$loc == 1])
    diff2 <- max(res$time[res$loc == 2]) - min(res$time[res$loc == 2])
    diff3 <- max(res$time[res$loc == 3]) - min(res$time[res$loc == 3])

    expect_equal(nrow(res), procs * 3)
    expect_lt(diff1, 1e-3)
    expect_gt(diff2, (procs - 1) * 0.48)
    expect_lt(diff3, 1e-3)
  }
})
