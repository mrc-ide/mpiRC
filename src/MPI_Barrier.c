#include "mpiRC.h"

SEXP r_mpirc_MPI_Barrier() {
  MPI_Barrier(MPI_COMM_WORLD);
  return R_NilValue;
}
