(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_to_list.sml,v $
 * Revision 1.2  1997/05/28 12:05:38  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:04:42  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.from_list
  (map real [1,2,3,4,5,1,2,3,4,5])

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list a))
          of [1,2,3,4,5,1,2,3,4,5] => 
            print"Pass\n"
           | _ => print"Fail\n"
