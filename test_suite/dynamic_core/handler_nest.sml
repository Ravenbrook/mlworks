(*

Result: OK
 
$Log: handler_nest.sml,v $
Revision 1.6  1997/11/21 10:52:31  daveb
[Bug #30323]

 * Revision 1.5  1997/06/05  17:11:30  jont
 * [Bug #30090]
 * Remove use of MLWorks.IO
 *
 * Revision 1.4  1997/05/28  12:13:26  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/31  12:41:25  jont
 * Io has moved into MLWorks.IO
 *
 * Revision 1.2  1996/05/01  17:16:45  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/08/17  14:37:16  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

val x =
  (let
     val x = TextIO.openIn"poo"
   in
     0
   end handle Match => 1)
     handle IO.Io _ => 2
