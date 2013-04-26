(*
Cover

Result: OK

$Log: cover4.sml,v $
Revision 1.3  1996/05/23 12:23:04  matthew
Shell.Options change

 * Revision 1.2  1996/04/01  11:52:47  matthew
 * updating
 *
 * Revision 1.1  1993/05/27  13:23:22  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

structure A = struct type t = int type u = real end;
structure B : sig type t end = A;
structure C : sig type u end = A;
signature SIG = sig structure D : sig type t and u end sharing D = B end;
