#include "mpiRC.h"

SEXP r_mpirc_MPI_Init_thread(SEXP level) {
  int lev = asInteger(level);
  if (lev == 0) lev = MPI_THREAD_SINGLE;
  else if (lev == 1) lev = MPI_THREAD_FUNNELED;
  else if (lev == 2) lev = MPI_THREAD_SERIALIZED;
  else if (lev == 3) lev = MPI_THREAD_MULTIPLE;

  int level_provided;
  MPI_Init_thread(NULL, NULL, lev, &level_provided);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = level_provided;
  UNPROTECT(1);
  return result;
}
