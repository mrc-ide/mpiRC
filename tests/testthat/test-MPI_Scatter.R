context("MPI_Scatter")

test_that("MPI scatter with sizes, roots and types", {

  single <- function(type, procs, root, expected) {
    script <- c(
      "rank<-mpiRC::mpirc_MPI_Comm_rank()",
      "size<-mpiRC::mpirc_MPI_Comm_size()",
      "all<-rep(0,3*size)",
      sprintf("if(rank==%d)all<-seq(from=%s,length.out=3*size,by=1)", root, type),
      sprintf("my<-mpiRC::mpirc_MPI_Scatter(all,%d)", root),
      "Sys.sleep(0.25*rank)",
      "cat(rank,paste(my))")
    res <- test_mpi(script, procs)
    for (ex in expected) {
      expect_true(ex %in% res)
    }
    expect_equal(length(expected), length(res))
  }

  single("1L", 1, 0, "0 1 2 3")
  single("1L", 2, 0, c("0 1 2 3", "1 4 5 6"))
  single("1L", 2, 1, c("0 1 2 3", "1 4 5 6"))
  single("1L", 3, 0, c("0 1 2 3", "1 4 5 6", "2 7 8 9"))
  single("1L", 3, 1, c("0 1 2 3", "1 4 5 6", "2 7 8 9"))
  single("1L", 3, 2, c("0 1 2 3", "1 4 5 6", "2 7 8 9"))

  single("1.1", 1, 0, "0 1.1 2.1 3.1")
  single("1.1", 2, 0, c("0 1.1 2.1 3.1", "1 4.1 5.1 6.1"))
  single("1.1", 2, 1, c("0 1.1 2.1 3.1", "1 4.1 5.1 6.1"))
  single("1.1", 3, 0, c("0 1.1 2.1 3.1", "1 4.1 5.1 6.1", "2 7.1 8.1 9.1"))
  single("1.1", 3, 1, c("0 1.1 2.1 3.1", "1 4.1 5.1 6.1", "2 7.1 8.1 9.1"))
  single("1.1", 3, 2, c("0 1.1 2.1 3.1", "1 4.1 5.1 6.1", "2 7.1 8.1 9.1"))
})
