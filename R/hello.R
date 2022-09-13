##' @useDynLib mpiRC, .registration = TRUE
NULL

mpirc_mpi_rank     <- function() { .Call(c_mpirc_get_comm_rank) }
mpirc_mpi_init     <- function() { .Call(c_mpirc_mpi_init)      }
mpirc_mpi_finalize <- function() { .Call(c_mpirc_mpi_finalize)  }
hello_world        <- function() { .Call(c_hello_world)         }
easy_pi            <- function() { .Call(c_easy_pi)             }

##' @export
##' @title Hello world, reporting rank and size
do_hello_world <- function() {
  mpirc_mpi_init()
  hello_world()
  mpirc_mpi_finalize()
  invisible()
}


##' @export
##' @title Compute PI distributed over nodes
do_easy_pi <- function() {
  mpirc_mpi_init()
  hello_world()
  pi <- easy_pi()
  rank <- mpirc_mpi_rank()
  if (rank == 0) {
    message(sprintf("Rank 0: result = %.9f\n", pi))
  }
  mpirc_mpi_finalize()
  invisible()
}
