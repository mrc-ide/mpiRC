#ifndef MPI_HELPER_H
#define MPI_HELPER_H

#include <mpi.h>
#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

int _mpirc_get_comm_rank();
int _mpirc_get_comm_size();

SEXP mpirc_mpi_init();
SEXP mpirc_mpi_finalize();
SEXP mpirc_get_comm_size();
SEXP mpirc_get_comm_rank();

#endif

