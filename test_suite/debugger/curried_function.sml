(* Copyright (c) 1996 Harlequin Ltd.
 *

Result: OK

 * Test that the debugger can generate correct stack back traces.
 * Specifically for MIPS/386 which used to have a problem with this -- 
 * see bug 1446.
 *
 * Revision Log
 * ------------
 * $Log: curried_function.sml,v $
 * Revision 1.2  1998/04/27 10:29:08  johnh
 * [Bug #30229]
 * Reflect recent changes to modes.
 *
 *  Revision 1.1  1996/10/03  11:35:12  stephenb
 *  new unit
 *
 *)

Shell.Options.Mode.debugging ();

fun foldl f z [] = z
  | foldl f z (x::xs) = foldl f (f (z, x)) xs;

fun sum xs = foldl op+ 0 xs;

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
