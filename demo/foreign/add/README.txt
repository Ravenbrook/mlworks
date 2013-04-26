The add example is is very simple.  It shows how to interface MLWorks
to a C function that adds two integers and returns the result.  As
such it shows the following parts of the foreign interface :-
 
 - calling a C function from ML
 - passing C integer from ML to C.
 - returning a C integer from C to ML.

The first step to running the example is to follow the instructions
in the README contained in enclosing directory about how set up any
necessary values that the example requires and building the library
that the example requires.

Once the library has been built, start MLWorks and then :-

* Create a listener and load in the add code into MLWorks by doing :-

    Shell.File.loadSource "__add";

* If all goes well the C library has been loaded and it is ready to
  be called.  Since the arguments to the add function are C types,
  you need to explicitly load the C interface to enable you to
  interactively create C objects :-

    Shell.Build.loadSource "foreign.__mlworks_c_interface";

* Create some C integers and pass them to the add routine.  For
  example ...

    MLWorks> structure C = MLWorksCInterface;

    MLWorks> val x = C.Int.fromInt 25;
    val x : C.Int.int = _

    MLWorks> val y = C.Int.fromInt 17;
    val y : C.Int.int = _

    MLWorks> val z = Add.add (x, y);
    val z : C.Int.int = _

    MLWorks> C.Int.toInt z;
    val it : int = 42
