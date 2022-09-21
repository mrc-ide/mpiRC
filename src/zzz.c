#include "mpiRC.h"

#include <R_ext/Rdynload.h>
#include <Rversion.h>

static const R_CallMethodDef call_methods[] = {
 {"c_mpirc_MPI_Init",               (DL_FUNC) &mpirc_MPI_Init,               0},
 {"c_mpirc_MPI_Initialized",        (DL_FUNC) &mpirc_MPI_Initialized,        0},
 {"c_mpirc_MPI_Finalize",           (DL_FUNC) &mpirc_MPI_Finalize,           0},
 {"c_mpirc_MPI_Finalized",          (DL_FUNC) &mpirc_MPI_Finalized,          0},
 {"c_mpirc_MPI_Comm_size",          (DL_FUNC) &mpirc_MPI_Comm_size,          0},
 {"c_mpirc_MPI_Comm_rank",          (DL_FUNC) &mpirc_MPI_Comm_rank,          0},
 {"c_mpirc_MPI_Get_processor_name", (DL_FUNC) &mpirc_MPI_Get_processor_name, 0},
 {"c_mpirc_MPI_Gather",             (DL_FUNC) &mpirc_MPI_Gather,             3},
 {NULL,                             NULL,                                    0}
};

void R_init_mpiRC(DllInfo *info) {

  // Register C routines to be called from R


  R_registerRoutines(info, NULL, call_methods, NULL, NULL);

#if defined(R_VERSION) && R_VERSION >= R_Version(3, 3, 0)
    R_useDynamicSymbols(info, FALSE);
    R_forceSymbols(info, TRUE);
#endif

}
