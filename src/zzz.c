#include "../inst/include/mpiRC.h"
#include "../inst/include/model.h"

#include <R_ext/Rdynload.h>
#include <Rversion.h>

static const R_CallMethodDef call_methods[] = {
  {"c_mpirc_mpi_init",      (DL_FUNC) &mpirc_mpi_init,       0},
  {"c_mpirc_mpi_finalize",  (DL_FUNC) &mpirc_mpi_finalize,   0},
  {"c_mpirc_test_code",     (DL_FUNC) &mpirc_test_code,      0},
  {"c_mpirc_get_comm_size", (DL_FUNC) &mpirc_get_comm_size,  0},
  {"c_mpirc_get_comm_rank", (DL_FUNC) &mpirc_get_comm_rank,  0},
  {NULL,                   NULL,                             0}
};

void R_init_mpiRC(DllInfo *info) {

  // Register C routines to be called from C

  //R_RegisterCCallable("mpiRC", "_mpirc_get_comm_size", (DL_FUNC) &_mpirc_get_comm_size);
  //R_RegisterCCallable("mpiRC", "_mpirc_get_comm_rank", (DL_FUNC) &_mpirc_get_comm_rank);

  // Register C routines to be called from R


  R_registerRoutines(info, NULL, call_methods, NULL, NULL);

#if defined(R_VERSION) && R_VERSION >= R_Version(3, 3, 0)
    R_useDynamicSymbols(info, FALSE);
    R_forceSymbols(info, TRUE);
#endif

}
