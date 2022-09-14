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

int64_t do_throws(int64_t throws) {
  int64_t hits = 0;
  for (int64_t i = 0; i < throws; i++) {
    double x = ((double) rand()) / RAND_MAX;
    double y = ((double) rand()) / RAND_MAX;
    if (((x * x) + (y * y)) <= (double) 1) hits++;
  }
  return hits;
}

SEXP easy_pi() {
  int64_t throws = 100000000L;

  srand(_mpirc_get_comm_rank());
  int nodes = _mpirc_get_comm_size();
  int64_t hits = do_throws(throws);

  int64_t total = 0;
  MPI_Allreduce(&hits, &total, 1, MPI_INT64_T, MPI_SUM, MPI_COMM_WORLD);

  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = 4.0 * ((double) total / (throws * nodes));
  UNPROTECT(1);
  return result;

}

//////////////////////////////////////////////////////////////////

SEXP iter_pi() {
  int nodes = _mpirc_get_comm_size();
  int rank = _mpirc_get_comm_rank();
  double target_delta = 1e-8;
  double current_delta = DBL_MAX;
  double current_pi = 0;
  double candidate_pi = 0;

  int64_t throw_chunk = 10000000L;
  int64_t all_throws = 0;
  int64_t all_hits = 0;
  srand(_mpirc_get_comm_rank());

  while (current_delta > target_delta) {
    if (rank == 0) {
      Rprintf("Pi so far: %.14f - Delta = %.14f\n", current_pi, current_delta);
    }
    all_hits += do_throws(throw_chunk);
    all_throws += throw_chunk;

    int64_t total = 0;
    MPI_Allreduce(&all_hits, &total, 1, MPI_INT64_T, MPI_SUM, MPI_COMM_WORLD);

    candidate_pi = 4.0 * ((double) total / (all_throws * nodes));
    current_delta = fabs(candidate_pi - current_pi);
    current_pi = candidate_pi;
  }

  SEXP result = PROTECT(allocVector(REALSXP, 1));
  REAL(result)[0] = current_pi;
  UNPROTECT(1);
  return result;
}
