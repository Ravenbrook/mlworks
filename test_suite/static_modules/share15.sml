(*
Assemblies shadowing

Result: OK

$Log: share15.sml,v $
Revision 1.3  1996/05/23 12:27:46  matthew
UPdating

 * Revision 1.2  1996/04/01  12:28:39  matthew
 * updating
 *
 * Revision 1.1  1993/05/25  12:54:17  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

structure A = struct type t = int end;

structure B = struct structure A = struct end end;

signature SIG = sig structure D : sig type t end sharing D = A end;
