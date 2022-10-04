#include "mpiRC.h"

void mpirc_MPI_Reduce(mpirc_data_wrapper* send_data, mpirc_data_wrapper* recv_data,
                      int root_node, MPI_Op red_op) {

  MPI_Reduce(send_data->data, recv_data->data, send_data->length,
             send_data->mpi_type, red_op, root_node, MPI_COMM_WORLD);

}

SEXP r_mpirc_MPI_Reduce(SEXP send_vec, SEXP root, SEXP func) {
  int root_node = asInteger(root);
  int red_op_enum = asInteger(func);
  MPI_Op red_op = MPI_MIN;
  if (red_op_enum == 2) red_op = MPI_MAX;
  else if (red_op_enum == 3) red_op = MPI_PROD;
  else if (red_op_enum == 4) red_op = MPI_SUM;

  mpirc_data_wrapper* send_data = get_data_wrapper(send_vec);

  SEXP result = PROTECT(allocVector(send_data->R_type, send_data->length));
  mpirc_data_wrapper* recv_data = get_data_wrapper(result);
  mpirc_MPI_Reduce(send_data, recv_data, root_node, red_op);

  UNPROTECT(1);
  return result;
}

