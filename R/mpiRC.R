##' @useDynLib mpiRC, .registration = TRUE
NULL

##' @export
##' @title Wrapper for MPI_Comm_rank(MPI_COMM_WORLD, &my_rank)
##' @returns Rank of this node, between 0 and (size-1) inclusive.
mpirc_MPI_Comm_rank <- function() {
  check_init()
  check_non_finalized()
  as.integer(.Call(c_mpirc_MPI_Comm_rank))
}


##' @export
##' @title Wrapper for MPI_Com_size(MPI_COMM_WORLD, &no_nodes)
##' @returns Number of nodes included in the MPI_COMM_WORLD.
mpirc_MPI_Comm_size <- function() {
  check_init()
  check_non_finalized()
  as.integer(.Call(c_mpirc_MPI_Comm_size))
}


check_non_finalized <- function() {
  if (mpirc_MPI_Finalized()) {
    stop("MPI already finalized")
  }
}
##' @export
##' @title Finalize MPI communications.
##' @description Wrapper for MPI_Finalize(). Call this only once at the end of
##' the code.
mpirc_MPI_Finalize <- function()  {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Finalize)
  invisible()
}


##' @export
##' @title Test if MPI was finalized.
##' @description Wrapper for MPI_Finalized().
mpirc_MPI_Finalized <- function()  {
  as.logical(.Call(c_mpirc_MPI_Finalized))
}


check_init <- function() {
  if (!mpirc_MPI_Initialized()) {
    stop("MPI not initialized")
  }
}

check_non_init <- function() {
  if (mpirc_MPI_Initialized()) {
    stop("MPI already initialized")
  }
}

##' @export
##' @title Initialise MPI communcation
##' @description Wrapper for MPI_Init(NULL, NULL). Call only once at the start
##' of the code. After this call, you can get the size of the MPI world and
##' this node's rank.
mpirc_MPI_Init <- function()  {
  check_non_init()
  .Call(c_mpirc_MPI_Init)
  invisible()
}

##' @export
##' @title Test if MPI is initialised
##' @description Wrapper for MPI_Initialized(). Useful since other operations
##' will crash R if called from an inappropriate state.
mpirc_MPI_Initialized <- function()  {
  as.logical(.Call(c_mpirc_MPI_Initialized))
}


##' @export
##' @title Get Computer name
##' @description Wrapper for MPI_Get_computer_name.
##' @returns The name of the compute node calling the function.
mpirc_MPI_Get_processor_name <- function() {
  check_init()
  check_non_finalized()
  .Call(c_mpirc_MPI_Get_processor_name)
}

