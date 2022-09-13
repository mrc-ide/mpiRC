#include "mpiRC.h"
#include "model.h"
#include "math.h"


//////////////////////////////////////////////////////////////////

SEXP hello_world() {

  char processor_name[MPI_MAX_PROCESSOR_NAME];
  int name_len;
  MPI_Get_processor_name(processor_name, &name_len);

  Rprintf("Hello world, I am %s (%d/%d)\n", processor_name,
          _mpirc_get_comm_rank(), _mpirc_get_comm_size());

  return R_NilValue;
}

//////////////////////////////////////////////////////////////////

SEXP easy_pi() {
  int64_t hits = 0;
  int64_t throws = 10000000L;

  srand(_mpirc_get_comm_rank());
  int nodes = _mpirc_get_comm_size();

  for (int64_t i = 0; i < throws; i++) {
    double x = ((double) rand()) / RAND_MAX;
    double y = ((double) rand()) / RAND_MAX;
    if (((x * x) + (y * y)) < 1) hits++;
  }

  int64_t total = 0;
  MPI_Allreduce(&hits, &total, 1, MPI_INT64_T, MPI_SUM, MPI_COMM_WORLD);

  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = 4.0 * ((double) total / (throws * nodes));
  UNPROTECT(1);
  return result;

}
