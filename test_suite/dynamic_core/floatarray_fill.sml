(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_fill.sml,v $
 * Revision 1.2  1997/05/28 11:55:58  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:22:05  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.array(10, 0.0)

val _ = MLWorks.Internal.FloatArray.fill(a, 1.0)

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list a))
          of [1,1,1,1,1,1,1,1,1,1] 
               => print"Pass\n"
           | _ => print"Fail\n"
