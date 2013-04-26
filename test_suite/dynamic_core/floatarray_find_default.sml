(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_find_default.sml,v $
 * Revision 1.2  1997/05/28 11:58:16  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:40:18  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)



val a = MLWorks.Internal.FloatArray.arrayoflist(map real [1,2,3,4,5,6,7,8,9,0])

val b = MLWorks.Internal.FloatArray.find_default (fn x => not (x < 4.0), 10) a

val c = MLWorks.Internal.FloatArray.find_default (fn x => x < 0.0, 10) a

val _ =
  if b = 3 then print"Pass 1\n" else print"Fail 1\n"

val _ =
  if c = 10 then print"Pass 2\n" else print"Fail 2\n"
