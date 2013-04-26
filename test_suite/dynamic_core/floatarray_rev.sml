(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_rev.sml,v $
 * Revision 1.2  1997/05/28 12:02:04  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  14:49:04  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [0,1,2,3,4,5,6,7,8,9])

val b = MLWorks.Internal.FloatArray.rev a

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list b))
          of [9,8,7,6,5,4,3,2,1,0] =>
            print"Pass\n"
           | _ => print"Fail\n"
