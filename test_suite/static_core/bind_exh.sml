(*
Binding patterns which contain inexhaustive matches or no variables must warn

Result: WARNING
 
$Log: bind_exh.sml,v $
Revision 1.2  1994/03/15 11:48:11  jont
Change to get warning reported after all

Revision 1.1  1993/04/16  10:40:54  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

local
  val (x, 1) = (1, 1)

  val 1 = 1
in
end

