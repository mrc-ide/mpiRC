#include "mpiRC.h"

SEXP r_mpirc_MPI_Initialized() {
  int res;
  MPI_Initialized(&res);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = res;
  UNPROTECT(1);
  return result;
}
