#include "mpiRC.h"

SEXP r_mpirc_MPI_Comm_size() {
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = size;
  UNPROTECT(1);
  return result;
}
