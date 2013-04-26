(*

Result: OK
 
$Log: bytearray_tabulate.sml,v $
Revision 1.4  1997/05/28 11:52:05  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/09/11  14:32:17  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.2  1996/05/01  17:09:30  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/25  16:10:37  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

fun f x = 10-x

val a = MLWorks.Internal.ByteArray.tabulate(10, f)

val b = MLWorks.Internal.ByteArray.arrayoflist[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

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

val _ = print(if eq(a, b) then "Pass\n" else "Fail\n")
