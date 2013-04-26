(*
Sharing unequal rigid structures, one in the basis nameset, one not

Result: FAIL
 
$Log: rigid_structures.sml,v $
Revision 1.2  1996/04/01 12:17:22  matthew
updating

 * Revision 1.1  1993/12/02  11:19:31  nickh
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

local
  structure A = struct
		end
in
  structure C =
    struct
      structure D =
	struct
	end
      structure E :
	sig
	  sharing D=A
	end =
	struct
	end
    end
end;

