(*
Binding patterns which contain inexhaustive matches or no variables must warn
Including layered patterns which fail

Result: WARNING
 
$Log: bind_exh1.sml,v $
Revision 1.2  1994/03/15 11:52:50  jont
Change to get warning reported after all

Revision 1.1  1993/12/10  11:49:05  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

local
  val x as (y::z) = [1,2]
in
end
