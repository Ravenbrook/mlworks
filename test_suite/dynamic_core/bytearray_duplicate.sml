(*

Result: OK
 
$Log: bytearray_duplicate.sml,v $
Revision 1.4  1997/05/28 11:43:34  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/21  18:55:57  io
 * [Bug #1603]
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  16:59:47  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:46:24  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

val a = MLWorks.Internal.ByteArray.arrayoflist[0,1,2,3,4,5,6,7,8,9]

val b = MLWorks.Internal.ByteArray.duplicate a

fun eq(a, b) =
  let
    val l = MLWorks.Internal.ByteArray.length a
  in
    if l <> MLWorks.Internal.ByteArray.length b then
      (print"Fail on unequal length\n";
       false)
    else
      let
	fun compare 0 = true
	  | compare n =
	    let
	      val n' = n-1
	    in
	      MLWorks.Internal.ByteArray.sub(a, n') = MLWorks.Internal.ByteArray.sub(b, n') andalso
	      compare n'
	    end
      in
	compare l
      end
  end

val _ = print(if eq(a, b) andalso a <> b then "Pass\n" else "Fail\n")
