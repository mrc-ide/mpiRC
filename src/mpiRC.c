#include "mpiRC.h"


SEXP mpirc_MPI_Comm_size() {
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = size;
  UNPROTECT(1);
  return result;
}

SEXP mpirc_MPI_Comm_rank() {
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = rank;
  UNPROTECT(1);
  return result;
}

SEXP mpirc_MPI_Finalize() {
  MPI_Finalize();
  return R_NilValue;
}

SEXP mpirc_MPI_Finalized() {
  int res;
  MPI_Finalized(&res);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = res;
  UNPROTECT(1);
  return result;
}

SEXP mpirc_MPI_Get_processor_name() {
  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);
  SEXP result = PROTECT(allocVector(STRSXP, 1));
  SET_STRING_ELT(result, 0, mkChar(processor_name));
  UNPROTECT(1);
  return result;
}

SEXP mpirc_MPI_Init() {
  MPI_Init(NULL, NULL);
  return R_NilValue;
}

SEXP mpirc_MPI_Initialized() {
  int res;
  MPI_Initialized(&res);
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = res;
  UNPROTECT(1);
  return result;
}


