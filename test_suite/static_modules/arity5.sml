(*
Result: OK
 
$Log: arity5.sml,v $
Revision 1.3  1996/05/23 12:21:39  matthew
Shell.Options change

 * Revision 1.2  1996/05/22  11:26:13  daveb
 * The abstractions option is now disabled by default, so set it explicitly.
 *
 * Revision 1.1  1994/05/06  12:48:02  jont
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)

Shell.Options.set (Shell.Options.Language.abstractions, true);

signature SIG = sig type 'a T end;

abstraction S : SIG =
  struct
    type 'a T = 'a list
  end;
