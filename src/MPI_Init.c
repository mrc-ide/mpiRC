#include "mpiRC.h"

SEXP r_mpirc_MPI_Init() {
  MPI_Init(NULL, NULL);
  return R_NilValue;
}
