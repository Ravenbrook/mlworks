(* Copyright (c) 1996 Harlequin Ltd.
 *

Result: OK

 * Ensure that the debugger doesn't stumble over fake frames 
 * that are created when an exception is raised.  In particular
 * see <URI:hope://MLWsrc/rts/src/arch/I386/interface.S#ml_raise>
 * and <URI:hope://MLWsrc/rts/src/arch/MIPS/interface.S#ml_raise>.
 * 
 * Revision Log
 * ------------
 * $Log: exception.sml,v $
 * Revision 1.2  1998/04/27 10:34:52  johnh
 * [Bug #30229]
 * Reflect recent changes to mode options.
 *
 *  Revision 1.1  1996/11/14  10:16:49  stephenb
 *  new unit
 *  [Bug #1760]
 *
 *
 *)

Shell.Options.Mode.debugging ();

exception Foo;

fun foldl f z [] = raise Foo
  | foldl f z (x::xs) = foldl f (f (z, x)) xs;


fun sum xs = foldl op+ 0 xs;

let
  val x = sum [1,2,3];
in
  ()
end;
