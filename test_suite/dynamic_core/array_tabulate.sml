(*

Result: OK
 
$Log: array_tabulate.sml,v $
Revision 1.4  1997/05/28 11:39:50  jont
[Bug #30090]
Remove uses of MLWorks.IO

 * Revision 1.3  1996/05/08  11:28:06  jont
 * Arrays and Vectors have moved to MLWorks.Internal
 *
 * Revision 1.2  1996/05/01  16:56:29  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/03/29  11:56:09  jont
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

fun f x = 10-x

val a = MLWorks.Internal.ExtendedArray.tabulate(10, f)

val b = MLWorks.Internal.ExtendedArray.arrayoflist[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

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

val _ = print(if eq(a, b) then "Pass\n" else "Fail\n")
