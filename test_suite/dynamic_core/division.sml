(*

Result: OK
 
$Log: division.sml,v $
Revision 1.5  1998/02/18 11:56:00  mitchell
[Bug #30349]
Fix test to avoid non-unit sequence warning

 * Revision 1.4  1997/05/28  11:53:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.3  1996/05/02  15:27:33  matthew
 * Updating
 *
 * Revision 1.2  1996/05/01  17:11:12  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1994/11/23  16:59:20  matthew
 * new file
 *

Copyright (c) 1994 Harlequin Ltd.
*)

(* Some tests for the correctness of division functions *)

let
fun f (x,y) = (x div y,x mod y)

val top = 536870911
val bot = ~536870912

in
  if 
    f (5,3) = (1,2) andalso
    f (~5,3) = (~2,1) andalso
    f (5,~3) = (~2,~1) andalso
    f (~5,~3) = (1,~2) andalso
    f (105,10) = (10,5) andalso
    f (1000000,100) = (10000,0) andalso
    f (bot,1) = (bot,0) andalso
    ((ignore(f (bot,~1)); false) handle Overflow => true) andalso
    ((ignore(f (bot,0)); false) handle Div => true) andalso
    ((ignore(f (0,0)); false) handle Div => true) andalso
    f (bot,~2) = (268435456, 0)
    then print"Div test succeeded\n"
  else print"Error: error in division test\n"
end;
