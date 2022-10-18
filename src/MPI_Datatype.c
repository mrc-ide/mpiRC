#include "mpiRC.h"

/* Translate from R int into MPI_Type -
 *
 * Ordering must match MPI_Type.R
 * Null return should never get reached.
*/

MPI_Datatype mpirc_MPI_Datatype(int r_mpi_type) {
  if (r_mpi_type == 1) return MPI_INT;
  if (r_mpi_type == 2) return MPI_DOUBLE;
  return MPI_DATATYPE_NULL;
}
