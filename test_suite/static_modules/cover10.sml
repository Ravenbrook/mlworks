(*
Cover

Result: OK

$Log: cover10.sml,v $
Revision 1.3  1996/05/23 12:22:52  matthew
Shell.Options change

 * Revision 1.2  1996/04/01  11:54:03  matthew
 * updating
 *
 * Revision 1.1  1993/06/25  15:51:22  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.oldDefinition,true);

functor A() =
  struct
    structure B = struct type t = int end;
    structure C : sig structure D : sig type t end sharing D = B end =
      struct
	structure D = B
      end
  end
