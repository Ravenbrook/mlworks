(*
Covering error.

Result: FAIL

$Log: cover2.sml,v $
Revision 1.2  1996/04/01 11:52:36  matthew
updating

 * Revision 1.1  1993/05/27  11:41:13  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);
structure A = struct type t = int end;
structure B : sig end = A;
structure A = struct end;
signature SIG = sig structure D : sig type t end sharing D = B end;
