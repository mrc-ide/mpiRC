#include "mpiRC.h"

SEXP mpirc_MPI_Get_processor_name() {
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);
  SEXP result = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(result, 0, mkChar(processor_name));
  UNPROTECT(1);
  return result;
}
