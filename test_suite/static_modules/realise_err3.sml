(*
Realisation error.

Result: FAIL

$Log: realise_err3.sml,v $
Revision 1.2  1993/01/20 16:38:53  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    structure A : sig 
                    type t
                  end
  end;

structure S : SIG = 
  struct
    structure A = struct end
  end
