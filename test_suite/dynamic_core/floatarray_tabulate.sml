(*

Result: OK
 
 * Revision Log:
 * -------------
 * $Log: floatarray_tabulate.sml,v $
 * Revision 1.2  1997/05/28 12:05:17  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 *  Revision 1.1  1997/01/07  15:03:40  andreww
 *  new unit
 *  [Bug #1818]
 *  floatarray tests
 *
 *
 *

Copyright (c) 1997 Harlequin Ltd.
*)

fun f x = real (10-x)

val a = MLWorks.Internal.FloatArray.tabulate(10, f)

val b = MLWorks.Internal.FloatArray.arrayoflist
  (map real [10, 9, 8, 7, 6, 5, 4, 3, 2, 1])

fun eq(a, b) =
  let
    val l = MLWorks.Internal.FloatArray.length a
  in
    if l <> MLWorks.Internal.FloatArray.length b then
      (print"Fail on unequal length\n";
       false)
    else
      let
	fun compare 0 = true
	  | compare n =
	    let
	      val n' = n-1
	    in
	      (floor (MLWorks.Internal.FloatArray.sub(a, n'))) = 
              (floor (MLWorks.Internal.FloatArray.sub(b, n'))) andalso
	      compare n'
	    end
      in
	compare l
      end
  end

val _ = print(if eq(a, b) then "Pass\n" else "Fail\n")
