The stdio example consists of two simple versions of the Unix cat
program: __kitten.sml and __cat.sml.  The examples show the following
parts of the foreign interface :- 

 - The built in MLWorks <-> C <stdio.h> binding.
 - correct way to use C variables bound to ML values.
 - calling C functions from ML.
 - passing pointers to C structures from ML to C.
 - returning pointers to C structures from C to ML.
 - creating a standalone executable.

The first step to running the examples is to follow the instructions
in the README contained in enclosing directory about how set up any
necessary values that the examples require and building the library
that the examples require.

Once the library has been built, start MLWorks and create a listener
and load in one of the versions of cat.  For example, to load in
__kitten.sml do :-

  MLWorks> Shell.File.loadSource "__kitten";

This should create an executable called 'kitten'.  Loading __cub.sml
is done in the same way :-

  MLWorks> Shell.File.loadSource "__cub";

and this should create an executable called 'cub'.

To run either of the examples, just pass the name of the files to
concatenate.  For example, the following will concatenate __kitten.sml
and __cub.sml and write the result to the standard output.

