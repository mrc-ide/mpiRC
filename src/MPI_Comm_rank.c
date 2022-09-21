#include "mpiRC.h"

SEXP mpirc_MPI_Comm_rank() {
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = rank;
  UNPROTECT(1);
  return result;
}