#ifndef MPI_HELPER_H
#define MPI_HELPER_H

#include <mpi.h>
#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

SEXP mpirc_mpi_init();
SEXP mpirc_mpi_finalize();
SEXP mpirc_get_comm_size();
SEXP mpirc_get_comm_rank();

#endif

