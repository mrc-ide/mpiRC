rem Assuming you have the cluster tools installed,
rem and the mpi_hw.exe in Q:\mpitest

job submit /scheduler:wpia-hpc-hn /jobtemplate:AllNodes /numnodes:4 /singlenode:false /workdir:\\qdrive.dide.ic.ac.uk\homes\wrh1\mpitest /stdout:c_out.txt /stderr:c_err.txt mpiexec -n 4 mpi_hw.exe
