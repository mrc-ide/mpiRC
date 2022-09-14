#include "mpi.h"
#include <stdio.h>

int main(int argc, char* argv[]) {
  MPI_Init(NULL, NULL);
  int no_nodes;
  MPI_Comm_size(MPI_COMM_WORLD, &no_nodes);
  int my_rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
  printf("Hello. I am %d/%d\n", my_rank, no_nodes);
  MPI_Finalize();
  return 0;
}
