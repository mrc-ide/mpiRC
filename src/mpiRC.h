#ifndef MPI_HELPER_H
#define MPI_HELPER_H

#include <mpi.h>
#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

typedef struct mpirc_data_wrapper {
  void* data;
  int length;
  MPI_Datatype mpi_type;
  int R_type;
} mpirc_data_wrapper;

mpirc_data_wrapper* get_data_wrapper(SEXP data);

SEXP r_mpirc_MPI_Comm_size();
SEXP r_mpirc_MPI_Comm_rank();
SEXP r_mpirc_MPI_Init();
SEXP r_mpirc_MPI_Initialized();
SEXP r_mpirc_MPI_Finalize();
SEXP r_mpirc_MPI_Finalized();
SEXP r_mpirc_MPI_Get_processor_name();
SEXP r_mpirc_MPI_Gather(SEXP send_vec, SEXP root);

#endif

