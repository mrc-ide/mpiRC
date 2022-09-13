#include "../inst/include/mpiRC.h"
#include "../inst/include/model.h"

SEXP mpirc_test_code() {
  Rprintf("Hello world, %d/%d\n", _mpirc_get_comm_rank(), _mpirc_get_comm_size());
  return R_NilValue;
}
