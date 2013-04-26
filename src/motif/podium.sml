(* podium.sml the signature *)

(*
$Log: podium.sml,v $
Revision 1.7  1997/06/17 15:35:04  johnh
Automatic checkin:
changed attribute _comment to ' *  '

 * Revision 1.1  1994/07/14  15:21:35  matthew
 * new unit
 * New unit
 *
Revision 1.5  1994/07/14  15:21:35  daveb
start_x_interface now has the type ListenerArgs -> bool -> unit.

Revision 1.4  1993/04/16  14:11:32  matthew
Renamed Args to ListenerArgs

Revision 1.3  1993/03/15  17:14:36  matthew
Renamed ShellData to Args
Changed type of start_x_interface

Revision 1.2  1993/03/08  15:21:53  matthew
Changes for ShellData type

Revision 1.1  1993/03/02  17:53:32  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd.
*)

signature PODIUM =
sig

  type ListenerArgs

  val start_x_interface: ListenerArgs -> bool -> unit

end;
