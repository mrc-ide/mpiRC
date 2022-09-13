#include "mpiRC.h"
#include "model.h"

SEXP mpirc_test_code() {

  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);

  Rprintf("Hello world, I am %s (%d/%d)\n", processor_name,
          _mpirc_get_comm_rank(), _mpirc_get_comm_size());

  return R_NilValue;
}
