(*

Result: OK
 
 * Revision Log:
 * --------------
 * $Log: floatarray_map_index.sml,v $
 * Revision 1.2  1997/05/28 12:00:35  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  14:43:43  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [0,1,2,3,4,5,6,7,8,9])

val b = MLWorks.Internal.FloatArray.map_index
  (fn (index, value:real) => (real index)*value) a

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list b))
          of [0,1,4,9,16,25,36,49,64,81] => 
            print"Pass\n"
           | _ => print"Fail\n"
