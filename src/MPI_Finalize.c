#include "mpiRC.h"

SEXP mpirc_MPI_Finalize() {
  MPI_Finalize();
  return R_NilValue;
}
