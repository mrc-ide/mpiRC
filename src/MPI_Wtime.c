#include "mpiRC.h"

SEXP r_mpirc_MPI_Wtime() {
  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = MPI_Wtime();
  UNPROTECT(1);
  return result;
}
