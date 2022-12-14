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
MPI_Op mpirc_MPI_Op(int r_mpi_op);

SEXP r_mpirc_MPI_Allgather(SEXP data);
SEXP r_mpirc_MPI_Allreduce(SEXP data, SEXP func);
SEXP r_mpirc_MPI_Barrier();
SEXP r_mpirc_MPI_Bcast(SEXP data, SEXP root);
SEXP r_mpirc_MPI_Comm_size();
SEXP r_mpirc_MPI_Comm_rank();
SEXP r_mpirc_MPI_Init();
SEXP r_mpirc_MPI_Initialized();
SEXP r_mpirc_MPI_Finalize();
SEXP r_mpirc_MPI_Finalized();
SEXP r_mpirc_MPI_Gather(SEXP data, SEXP root);
SEXP r_mpirc_MPI_Get_processor_name();
SEXP r_mpirc_MPI_Reduce(SEXP data, SEXP root, SEXP func);
SEXP r_mpirc_MPI_Scatter(SEXP data, SEXP root);
SEXP r_mpirc_MPI_Wtime();

#endif
