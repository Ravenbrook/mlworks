(* Copyright (c) 1996 Harlequin Ltd.
 *

Result: OK

 * Test that the debugger can continue after a stack overflow.
 *
 * Revision Log
 * ------------
 * $Log: continue_on_overflow.sml,v $
 * Revision 1.2  1998/04/27 14:07:18  johnh
 * [Bug #30229]
 * Reflect recent changes to mode options.
 *
 *  Revision 1.1  1996/12/18  16:06:34  stephenb
 *  new unit
 *
 *)

Shell.Options.Mode.debugging ();
MLWorks.Internal.Runtime.Memory.max_stack_blocks := 5;

local
  fun ilist (0, l) = l
    | ilist (n, l) = ilist (n-1, n::l)
in
  fun intlist n = ilist (n, [])
end

intlist 10000;
c
