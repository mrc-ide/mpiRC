#include "mpiRC.h"

void mpirc_MPI_Allreduce(mpirc_data_wrapper* send_data, mpirc_data_wrapper* recv_data,
                      MPI_Op red_op) {

  MPI_Allreduce(send_data->data, recv_data->data, send_data->length,
                send_data->mpi_type, red_op, MPI_COMM_WORLD);

}

SEXP r_mpirc_MPI_Allreduce(SEXP send_vec, SEXP func) {
  MPI_Op red_op = mpirc_MPI_Op(asInteger(func));
  mpirc_data_wrapper* send_data = get_data_wrapper(send_vec);

  SEXP result = PROTECT(allocVector(send_data->R_type, send_data->length));
  mpirc_data_wrapper* recv_data = get_data_wrapper(result);
  mpirc_MPI_Allreduce(send_data, recv_data, red_op);

  UNPROTECT(1);
  return result;
}

