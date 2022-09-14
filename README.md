# mpiRC

This R package demonstrates running R code on multiple nodes, by using
MPI calls from C, called at the top level from R functions. At present
it is targetting our Windows-based Azure cluster, which includes 
Microsoft's MPI build. Conveniently, the libraries for MS-MPI are
also included in RTools 4.2.

For the examples below, I'm assuming the package is installed. For 
the cluster examples, I'm assuming it is installed in a repo in `Q:/R`

## Local testing

* `mpiexec.exe` is the tool needed to run MPI jobs, and it needs to be
Microsoft's version, since that's what is in RTools 4.2.
Download from [here](https://www.microsoft.com/en-us/download/confirmation.aspx?id=100593)

* Make sure when you run `mpiexec` from the command-line, you really
do get a Microsoft one. There is also an Intel provided MPI library, 
if you've installed Intel Parallel Studio. This has a different protocol,
and while the parallel launch will occur, you'll find the rank and size 
will be reported incorrectly.

* Install the package, and then see the `scripts` folder for
`hello-world-local.bat` and `easy-pi-local.bat`. These are both very simple, and of the form
`mpiexec -n 4 Rscript -e mpiRC::do_function()`. Running mpiexec directly will cause all 4
processes to be run on your local computer, so the results you see will be:

```
C:\Files\Dev\R\mpiRC\scripts>mpiexec -n 4 rscript -e "mpiRC::do_hello_world()"
Hello world, I am wes-desktop.dide.local (1/4)
Hello world, I am wes-desktop.dide.local (3/4)
Hello world, I am wes-desktop.dide.local (0/4)
Hello world, I am wes-desktop.dide.local (2/4)
```
for the Hello World test, and for the easy-pi:

```
C:\Files\Dev\R\mpiRC\scripts>mpiexec -n 4 rscript -e "mpiRC::do_easy_pi()"
Hello world, I am wes-desktop.dide.local (3/4)
Hello world, I am wes-desktop.dide.local (2/4)
Hello world, I am wes-desktop.dide.local (1/4)
Hello world, I am wes-desktop.dide.local (0/4)
Rank 0: result = 3.141536870
```

Note the different orders of reporting - text from the different processes is
interleaved (sometimes very clumsily if you output a lot of text). Generally,
we shouldn't rely on STDERR and STDOUT with MPI, but instead have each 
process write its own output. 

## Cluster testing

* The process is basically the same; we request `/numnodes:4` in the job submission,
and ask each node to `mpiexec -n 4 run.bat`, where the batch files does the 
old-fashioned setup (set the libraries, and add Rscript to the path).

* See the files containing `launch` and `cluster` in the `scripts` folder. They
assume that the package is installed in Q:/R (and change the user name)

For the Hello World test, `out.txt` then reports:-
```
Hello world, I am WPIA-HPC-005.dide.local (0/4)
Hello world, I am WPIA-HPC-006.dide.local (1/4)
Hello world, I am WPIA-HPC-007.dide.local (2/4)
Hello world, I am WPIA-HPC-008.dide.local (3/4)
```
noting the different notes. And the easy pi test reports similar in the output, 
but the text from R goes to stderr. 

```
Q:\mpitest>type out_pi.txt
Hello world, I am WPIA-HPC-005.dide.local (0/4)
Hello world, I am WPIA-HPC-006.dide.local (1/4)
Hello world, I am WPIA-HPC-007.dide.local (2/4)
Hello world, I am WPIA-HPC-008.dide.local (3/4)

Q:\mpitest>type err_pi.txt
Rank 0: result = 3.141536870
```

Then an iterative example, where we try to calculate pi, until the difference
between two timesteps is less than a target value:

```
Q:\mpitest>tail out_iter_pi.txt
Pi so far: 3.14151902265625 - Delta = 0.00000047304995
Pi so far: 3.14152113875969 - Delta = 0.00000211610344
Pi so far: 3.14151854461538 - Delta = 0.00000259414431
Pi so far: 3.14152137175573 - Delta = 0.00000282714034
Pi so far: 3.14152093787879 - Delta = 0.00000043387694
Pi so far: 3.14152063007519 - Delta = 0.00000030780360
Pi so far: 3.14151784104478 - Delta = 0.00000278903041
Pi so far: 3.14152005259259 - Delta = 0.00000221154782
Pi so far: 3.14151971764706 - Delta = 0.00000033494553
Pi so far: 3.14151960072993 - Delta = 0.00000011691713

Q:\mpitest>tail err_iter_pi.txt
Rank 0: result = 3.141519596377
```

We're not that close to pi here, and the change is a bit erratic - I think 
this is because I am using the terrible srand/rand RNG in stdlib.

## Standalone C version

See `scripts/standalone` for simple code, compile and run scripts for
a Hello World MPI in C example.
