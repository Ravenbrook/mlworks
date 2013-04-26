(*
Covering error.

Result: FAIL

$Log: cover3.sml,v $
Revision 1.3  1996/04/01 11:57:59  matthew
updating

 * Revision 1.2  1993/05/27  13:18:21  daveb
 * Line numbers changed in error message.
 *
Revision 1.1  1993/05/27  13:18:21  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

structure A = struct type t = int end;
structure B : sig end = A;
signature SIG = sig structure D : sig type t end sharing D = B end;
structure A = struct end;
signature SIG = sig structure D : sig type t end sharing D = B end;
