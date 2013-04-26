(*

Result: OK
 
$Log: array_duplicate.sml,v $
Revision 1.4  1997/05/28 11:30:02  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:12:21  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:45:49  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:57:46  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ExtendedArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ExtendedArray.duplicate a

fun eq(a, b) =
  let
    val l = MLWorks.Internal.ExtendedArray.length a
  in
    if l <> MLWorks.Internal.ExtendedArray.length b then
      (print"Fail on unequal length\n";
       false)
    else
      let
	fun compare 0 = true
	  | compare n =
	    let
	      val n' = n-1
	    in
	      MLWorks.Internal.ExtendedArray.sub(a, n') = MLWorks.Internal.Array.sub(b, n') andalso
	      compare n'
	    end
      in
	compare l
      end
  end

val _ = print(if eq(a, b) andalso a <> b then "Pass\n" else "Fail\n")
