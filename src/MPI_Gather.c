#include "mpiRC.h"

SEXP mpirc_MPI_Gather(SEXP send_vec, SEXP vec_type, SEXP root) {
  char _vec_type = asChar(vec_type);
  int _root = asInteger(root);
  int size = mpirc_MPI_Comm_size();

  void* sendbuf;
  int sendcount = LENGTH(send_vec);
  MPI_Datatype sendtype;
  void* recvbuf;
  int recvcount = LENGTH(send_vec) * size;

  SEXP result;

  if (_vec_type == 'I') {
    sendbuf = INTEGER(send_vec);
    sendtype = MPI_INT;
    result = PROTECT(allocVector(INTSXP, recvcount));
    recvbuf = INTEGER(result);

  } else if (_vec_type == 'R') {
    sendbuf = REAL(send_vec);
    sendtype = MPI_DOUBLE;
    result = PROTECT(allocVector(REALSXP, recvcount));
    recvbuf = REAL(result);
  }

  MPI_Gather(sendbuf, sendcount, sendtype,
             recvbuf, sendcount, sendtype, _root, MPI_COMM_WORLD);

  UNPROTECT(1);
  return result;
}
