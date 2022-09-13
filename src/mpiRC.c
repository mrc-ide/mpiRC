#include "mpiRC.h"

SEXP mpirc_mpi_init() {
  MPI_Init(NULL, NULL);
  return R_NilValue;
}

SEXP mpirc_mpi_finalize() {
  MPI_Finalize();
  return R_NilValue;
}

int _mpirc_get_comm_size() {
  int size;
  MPI_Comm_size(MPI_COMM_WORLD, &size);
  return size;
}

int _mpirc_get_comm_rank() {
  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  return rank;
}

SEXP mpirc_get_comm_size() {
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = _mpirc_get_comm_size();
  UNPROTECT(1);
  return result;
}

SEXP mpirc_get_comm_rank() {
  SEXP result = PROTECT(result = NEW_INTEGER(1));
  INTEGER(result)[0] = _mpirc_get_comm_rank();
  UNPROTECT(1);
  return result;
}


