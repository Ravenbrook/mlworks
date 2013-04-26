(*
Sharing error: between two functor parameters

Result: FAIL

$Log: share11.sml,v $
Revision 1.2  1996/04/01 12:17:42  matthew
updating

 * Revision 1.1  1993/05/21  13:10:44  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Compatibility.oldDefinition,true);

signature S = sig end;
functor Foo(structure T : S structure U : S) : sig structure V : S sharing V = T = U end = struct structure V = T end;
