(*
Remember fixity for open where relevant
Result: OK

$Log: fixity15.sml,v $
Revision 1.3  1996/05/23 12:20:35  matthew
Shell.Options change

 * Revision 1.2  1996/02/23  16:29:03  daveb
 * Converted Shell structure to new capitalisation convention.
 *
# Revision 1.1  1994/05/09  16:48:20  jont
# new file
#
Copyright (c) 1993 Harlequin Ltd.
*)

structure S = struct infix aaa end;
open S;
Shell.Options.set(Shell.Options.Language.fixityInOpen, true);
open S;
Shell.Options.set(Shell.Options.Language.fixityInOpen, false);
open S;
