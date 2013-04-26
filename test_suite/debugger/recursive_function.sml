(* Copyright (c) 1996 Harlequin Ltd.
 *

Result: OK

 * Test that the debugger can step and generate correct stack back traces.
 * for a function with one argument which is a tuple (contains a nice
 * mix of function, integer and list).
 *
 * Revision Log
 * ------------
 * $Log: recursive_function.sml,v $
 * Revision 1.2  1998/04/27 10:35:34  johnh
 * [Bug #30229]
 * Reflect recent changes to mode options.
 *
 *  Revision 1.1  1996/10/03  11:58:43  stephenb
 *  new unit
 *
 *)

Shell.Options.Mode.debugging ();

fun foldl (f, z, []) = z
  | foldl (f, z, (x::xs)) = foldl (f, (f (z, x)), xs);

fun sum xs = foldl (op+, 0, xs);

Shell.Trace.breakpoint "sum";

(* The following is the correct number of "s"teps and "b"acktraces for
 * the above argument.
 *)
sum [1,2,3];
b
s
b
s
b
s
b
s
b
s
b
s
b
s
b
s
