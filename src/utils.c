#include "mpiRC.h"

mpirc_data_wrapper* get_data_wrapper(SEXP data) {
  mpirc_data_wrapper* result = malloc(sizeof(mpirc_data_wrapper));
  result->length = length(data);

  if (TYPEOF(data) == REALSXP) {
    result->data = REAL(data);
    result->mpi_type = MPI_DOUBLE;
    result->R_type = REALSXP;


  } else if (TYPEOF(data) == INTSXP) {
    result->data = INTEGER(data);
    result->mpi_type = MPI_INT;
    result->R_type = INTSXP;

  } else {
    Rf_error("invalid input for data");
  }

  return result;
}
