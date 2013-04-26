(*
Result realisation forcing argument sharing

Result: FAIL

$Log: share19.sml,v $
Revision 1.1  1996/04/03 13:20:51  matthew
new unit
New test

Revision 1.1  1994/01/05  12:38:26  jont
Initial revision

Copyright (c) 1994 Harlequin Ltd.
*)
signature FOO = sig structure S : sig type t end end;
signature EMPTY = sig end;

signature BAR = 
  sig 
    structure F1 : FOO where type S.t = real
    structure F2 : EMPTY
    structure F3 : FOO where type S.t = int
    sharing F1 = F2 = F3
  end
