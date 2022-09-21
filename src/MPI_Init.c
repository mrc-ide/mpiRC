#include "mpiRC.h"

SEXP mpirc_MPI_Init() {
  MPI_Init(NULL, NULL);
  return R_NilValue;
}
