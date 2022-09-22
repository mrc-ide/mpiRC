#include "mpiRC.h"

SEXP r_mpirc_MPI_Finalize() {
  MPI_Finalize();
  return R_NilValue;
}
