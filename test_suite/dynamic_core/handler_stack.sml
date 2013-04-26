(*

Result: OK
 
$Log: handler_stack.sml,v $
Revision 1.5  1997/11/21 10:52:38  daveb
[Bug #30323]

 * Revision 1.4  1997/05/28  16:48:06  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/31  12:42:40  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.2  1996/05/01  17:38:07  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/08/13  16:12:14  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

fun f n =
  let
    val x =
      let
	val y = TextIO.openIn"foo"
      in
	0
      end handle IO.Io _ => 1
  in
    if x = 0 orelse n <= 0 then 0 else f (n-1)
  end

val _ = f(100000)

