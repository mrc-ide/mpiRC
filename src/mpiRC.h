#ifndef MPI_HELPER_H
#define MPI_HELPER_H

#include <mpi.h>
#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

SEXP mpirc_MPI_Comm_size();
SEXP mpirc_MPI_Comm_rank();
SEXP mpirc_MPI_Init();
SEXP mpirc_MPI_Initialized();
SEXP mpirc_MPI_Finalize();
SEXP mpirc_MPI_Finalized();
SEXP mpirc_MPI_Get_processor_name();
SEXP mpirc_MPI_Gather(SEXP send_vec, SEXP vec_type, SEXP root);

#endif

