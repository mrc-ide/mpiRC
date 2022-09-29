context("MPI_Scatter")

test_that("MPI scatter with integers", {
  script <- c("rank<-mpiRC::mpirc_MPI_Comm_rank()",
              "size<-mpiRC::mpirc_MPI_Comm_size()",
              "x<-seq(length.out=3*size,by=1)",
              "g<-mpiRC::mpirc_MPI_Scatter(x,0)",
              "Sys.sleep(0.25*rank)",
              "cat(rank,paste(g))")

  res <- test_mpi(script, 2)

})
