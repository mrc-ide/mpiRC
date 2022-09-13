@echo off
net use Q: \\qdrive.dide.ic.ac.uk\homes\wrh1 >nul 2>nul
call setr64_4_2_1.bat
set R_LIBS=Q:/R
set R_LIBS_USER=Q:/R
Rscript -e "mpiRC::do_hello_world()"
net use Q: /delete >nul 2>nul
