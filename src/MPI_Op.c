#include "mpiRC.h"

/* Translate from R int into MPI_Op -
 * convenience because both MPI_Reduce and
 * MPI_Allreduce will need it too.
 *
 * Ordering must match MPI_Op.R
 * Null return should never get reached.
*/

MPI_Op mpirc_MPI_Op(int r_mpi_op) {
  if (r_mpi_op == 1) return MPI_MIN;
  if (r_mpi_op == 2) return MPI_MAX;
  if (r_mpi_op == 3) return MPI_PROD;
  if (r_mpi_op == 4) return MPI_SUM;
  return MPI_OP_NULL;
}
