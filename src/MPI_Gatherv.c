#include "mpiRC.h"

void mpirc_MPI_Gatherv(mpirc_data_wrapper* send_data,
                       mpirc_data_wrapper* counts_recv,
                       mpirc_data_wrapper* displacements,
                       mpirc_data_wrapper* recv_data,
                      int root_node) {

  MPI_Gatherv(send_data->data, send_data->length, send_data->mpi_type,
              recv_data->data, counts_recv->data, displacements->data,
              recv_data->mpi_type, root_node, MPI_COMM_WORLD);

}

SEXP r_mpirc_MPI_Gatherv(SEXP send_vec, SEXP counts_recv_vec,
                         SEXP displacements_vec, SEXP root) {
  int root_node = asInteger(root);
  int no_nodes = asInteger(r_mpirc_MPI_Comm_size());

  mpirc_data_wrapper* send_data = get_data_wrapper(send_vec);
  mpirc_data_wrapper* counts_recv = get_data_wrapper(counts_recv_vec);
  mpirc_data_wrapper* displacements = get_data_wrapper(displacements_vec);

  int max_size = 0;
  for (int i=0; i<no_nodes; i++) {
    int new_max = ((int*)(displacements->data))[i] +
                  ((int*)(counts_recv->data))[i];
    if (new_max > max_size) max_size = new_max;
  }
  SEXP result = PROTECT(allocVector(send_data->R_type, max_size));

  mpirc_data_wrapper* recv_data = get_data_wrapper(result);
  mpirc_MPI_Gatherv(send_data, counts_recv, displacements, recv_data, root_node);

  UNPROTECT(1);
  return result;
}

