(*
Badly formed argument signature in functor declaration with result signature

Result: FAIL
 
$Log: well_formed5.sml,v $
Revision 1.2  1996/04/01 12:19:53  matthew
updating

 * Revision 1.1  1993/12/02  11:04:46  nickh
 * Initial revision
 *

Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure S = struct
	      end;

functor F (type t
	   structure B : sig
			   val x:t
			 end
	   sharing B = S) : sig end =
  struct
  end;
