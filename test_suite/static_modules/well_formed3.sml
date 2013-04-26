(*
Badly formed constraint signature for structure declaration

Result: FAIL
 
$Log: well_formed3.sml,v $
Revision 1.1  1993/12/02 11:02:23  nickh
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

local
  structure S = struct
		end
in
  structure A :
    sig
      type t
      structure B :
	sig
	  val x:t
	end
      sharing B = S
    end =
    struct
    end
end
