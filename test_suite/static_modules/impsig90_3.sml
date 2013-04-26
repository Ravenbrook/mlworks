(*
Test that signature matching doesn't instantiate imperative type variables
Result: FAIL
 
$Log: impsig90_3.sml,v $
Revision 1.1  1996/10/07 11:32:38  andreww
new unit
new test.

 * Revision 1.2  1996/09/25  09:21:27  matthew
 * Updating for new definition
 *
 * Revision 1.1  1994/07/05  11:27:16  jont
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition, true);

signature S =
  sig
    type t
    val f: unit -> t list
  end;

structure T:S =
  struct
    type t = int
    val r = ref []
    fun f () = !r
  end
