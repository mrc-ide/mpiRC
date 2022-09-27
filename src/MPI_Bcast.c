#include "mpiRC.h"

void mpirc_MPI_Bcast(mpirc_data_wrapper* data, int root_node) {

  MPI_Bcast(data->data, data->length, data->mpi_type,
            root_node, MPI_COMM_WORLD);

}

SEXP r_mpirc_MPI_Bcast(SEXP vec, SEXP root) {
  int root_node = asInteger(root);
  mpirc_data_wrapper* data = get_data_wrapper(vec);
  mpirc_MPI_Bcast(data, root_node);
  return vec;
}

