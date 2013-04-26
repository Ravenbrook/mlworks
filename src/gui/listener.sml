(* listener.sml the signature *)

(*
$Log: listener.sml,v $
Revision 1.1  1995/07/18 11:51:22  matthew
new unit
New unit

Revision 1.8  1995/07/18  11:51:22  matthew
Adding "external listener" flag

Revision 1.7  1994/03/11  17:07:58  matthew
Removed Exit exn

Revision 1.6  1993/04/16  10:46:26  matthew
Changed type of create function

Revision 1.5  1993/04/02  15:05:31  matthew
Removed Incremental structure

Revision 1.4  1993/03/19  14:57:45  matthew
create takes application exit function

Revision 1.3  1993/03/15  17:13:49  matthew
Simplified type of create
Renamed ShellData to Args

Revision 1.2  1993/03/08  15:18:43  matthew
Changes for ShellData type

Revision 1.1  1993/03/02  17:52:49  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

signature LISTENER =
sig
  type ToolData

  val create : bool -> ToolData -> unit
end;
