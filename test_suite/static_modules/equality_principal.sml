(*
Equality principal must recalculate equality attributes in case
sharing has caused any changes from type to eqtype status

Result: OK
 
$Log: equality_principal.sml,v $
Revision 1.3  1996/05/23 12:27:05  matthew
UPdating

 * Revision 1.2  1996/04/01  12:15:33  matthew
 * updating
 *
 * Revision 1.1  1993/09/23  14:39:14  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)
Shell.Options.set (Shell.Options.Language.oldDefinition,true);

signature SIG =
  sig
    type  t
    datatype  t' =
      C |
      D of t
  end;

signature Sig' =
  sig
    structure S : SIG
    sharing type S.t = int
  end;

functor f(X: Sig') = struct val _ = X.S.C = X.S.C end;
