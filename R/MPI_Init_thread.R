##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Initialise MPI communcation
##' @description Wrapper for MPI_Init_threads(). Call only once at the start
##' of the code, as an alternative to MPI_Init, specifying the level of threading
##' you want. MPI implementations are not required to support all the levels of
##' threading. For OpenMP use, using MPI_Init on a whole node, followed by
##' `omp_init()` is sufficient for hybrid MPI/OpenMP.
##' @param level The name of the threading level, as per the MPI documentation.
##' One of `MPI_THREAD_SINGLE` (which implies no threading), `MPI_THREAD_FUNELLED`
##' (in which only the master thread performs MPI functions), `MPI_THREAD_SERIALIZED`
##' (in which any threads can perform an MPI function, but not simultaneously), or
##' `MPI_THREAD_MULTIPLE`, where any threads can perform MPI functions at the same
##' time. Performance is reported to be worse in this last mode, while algorithms
##' using it will be somewhat complicated to synchronise. These four options are
##' numbered 0, 1, 2 and 3 internally - see return value.
##' @returns The name of the threading level that the MPI implementation will
##' provide on this occasion - if all is well, this will be equal to the level
##' you requested.
mpirc_MPI_Init_thread <- function(level)  {
  check_non_init()
  c("MPI_THREAD_SINGLE", "MPI_THREAD_FUNELLED",
    "MPI_THREAD_SERIALIZED", "MPI_THREAD_MULTIPLE")[
      .Call(c_mpirc_MPI_Init_thread, mpirc_MPI_thread_level(level))]
}

mpirc_MPI_thread_level <- function(level)  {
  func <- toupper(level)

  thread_level <- c("MPI_THREAD_SINGLE", "MPI_THREAD_FUNELLED",
                    "MPI_THREAD_SERIALIZED", "MPI_THREAD_MULTIPLE")
  stopifnot(level %in% thread_level)

  # 0,1,2,3 - to match MPI constants

  as.integer(which(level == thread_level) - 1)
}
