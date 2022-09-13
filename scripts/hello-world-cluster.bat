@echo off

rem Map up my home directory

net use Q: \\qdrive.dide.ic.ac.uk\homes\wrh1

rem So I am assuming we have a R package repo setup at Q:/R, and
rem this package is installed in it.

call setr64_4_2_1.bat
set R_LIBS=Q:/R
set R_LIBS_USER=Q:/R

mpiexec -n 4 Rscript -e "mpiRC::do_hello_world()"

net use Q: /delete

