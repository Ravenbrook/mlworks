The ls example implements an extremly simple version of UNIX ls
command using the directory(3) interface.  It produces output that is
similar to that produced by a shell script that contained :-

  #! /bin/sh
  ls -a1 ${1:-.}

The example shows the following parts of the MLWorks<->C interface :- 

 - calling C functions from ML.
 - passing pointers to C structures from ML to C.
 - returning pointers to C structures from C to ML.
 - allocating C structures from within ML.
 - creating a standalone executable which uses a dynamically loaded
   library.
 - calling routines defined in libc.


The first step to running the example is to follow the instructions
in the README contained in enclosing directory about how set up any
necessary values that the example requires and building the library
that the example requires.

Once the library has been built, start MLWorks and create a listener
and load in the ls code into MLWorks by doing :- 

  MLWorks> Shell.File.loadSource "__ls";

This should create an executable called "simplels".  This takes an
optional single argument which is the name of the directory.  For
example, running simplels on /tmp on this machine produces :-

  $ ./simplels -pass args /tmp args
  .
  ..
  mbox
  .getwd
  .X11-unix

If you do not type the name of a directory, then a listing of the
current directory is produced.  That is, the following commands
produce the same output :-

  $ ./simplels 
  $ ./simplels -pass args . args

If the directory does not exist, then simplels displays an error
message :-

  $ ./simplels -pass args does-not-exist args
  No such directory: does-not-exist
