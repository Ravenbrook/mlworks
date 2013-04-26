(*
Realisation error.

Result: FAIL

$Log: realise_err2.sml,v $
Revision 1.2  1993/01/20 16:38:37  daveb
Added header.


Copyright (c) 1992 Harlequin Ltd.
*)

signature SIG = 
  sig
    structure A : sig 
                    structure B : sig end
                    structure C : sig end
                  end
  end;

structure S : SIG = 
  struct
    structure A = struct end
  end
