#include "mpiRC.h"

SEXP mpirc_MPI_Finalized() {
  int res;
  MPI_Finalized(&res);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = res;
  UNPROTECT(1);
  return result;
}
