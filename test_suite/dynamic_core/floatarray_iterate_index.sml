(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_iterate_index.sml,v $
 * Revision 1.2  1997/05/28 11:59:29  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:39:33  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

val a = MLWorks.Internal.FloatArray.arrayoflist(map real [0,1,2,3,4,5,6,7,8,9])

val b = ref [] : (int * real) list ref

fun f(index, value) = b := (index, 9.0-value) :: (!b)

val _ = MLWorks.Internal.FloatArray.iterate_index f a

val _ = case (map (fn (x,y)=>(x,floor y)) (!b))
          of [(9,0),(8,1),(7,2),(6,3),(5,4),(4,5),(3,6),(2,7),(1,8),(0,9)]
            => print"Pass\n"
          | _ => print"Fail\n"
