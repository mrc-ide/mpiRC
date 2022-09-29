#include "mpiRC.h"

void mpirc_MPI_Scatter(mpirc_data_wrapper* send_data, mpirc_data_wrapper* recv_data,
                       int root_node, int no_nodes) {

  MPI_Scatter(send_data->data, send_data->length / no_nodes, send_data->mpi_type,
             recv_data->data, send_data->length / no_nodes, recv_data->mpi_type,
             root_node, MPI_COMM_WORLD);

}

SEXP r_mpirc_MPI_Scatter(SEXP send_vec, SEXP root) {
  int root_node = asInteger(root);
  int rank = asInteger(r_mpirc_MPI_Comm_rank());
  int no_nodes = asInteger(r_mpirc_MPI_Comm_size());

  mpirc_data_wrapper* send_data = get_data_wrapper(send_vec);

  SEXP result = PROTECT(allocVector(send_data->R_type, send_data->length / no_nodes));
  mpirc_data_wrapper* recv_data = get_data_wrapper(result);
  mpirc_MPI_Scatter(send_data, recv_data, root_node, no_nodes);

  UNPROTECT(1);
  return result;
}

