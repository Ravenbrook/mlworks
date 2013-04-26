(*
$Log: inbuffer.sml,v $
Revision 1.12  1994/03/08 14:42:00  daveb
Added getLastLinePos, to support better locations for erroneous newlines
in strings.

Revision 1.11  1993/04/01  09:39:15  daveb
Added a boolean eof parameter to mkLineInBuffer, for use with the
incremental parser.

Revision 1.10  1992/12/21  11:06:58  matthew
Change to allow token streams to be created with a given initial line number.

Revision 1.9  1992/11/19  14:33:12  matthew
Added flush_to_nl

Revision 1.8  1992/11/09  18:35:26  daveb
Added clear_eof function.

Revision 1.7  1992/10/14  11:21:46  richard
Added line number to token stream input functions.

Revision 1.6  1992/08/18  15:06:06  davidt
Removed the forget and flush functions which are now redundant.

Revision 1.5  1992/08/14  20:06:01  davidt
Function getchar now returns an int.

Revision 1.4  1992/08/14  17:37:56  jont
Removed all currying from inbuffer

Revision 1.3  1992/05/19  17:04:18  clive
Fixed line position output from lexer

Revision 1.2  1992/03/23  13:34:38  matthew
Added line numbering.

Revision 1.1  1991/09/06  16:49:14  nickh
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
signature INBUFFER =
  sig
    type InBuffer

    exception Eof
    exception Position

    type StateEncapsulation

    val mkInBuffer : (int -> string) -> InBuffer
    val mkLineInBuffer : ((int -> string) * int * bool) -> InBuffer
    val getpos : InBuffer -> StateEncapsulation
    val position : (InBuffer * StateEncapsulation) -> unit
    val eof : InBuffer -> bool
    val clear_eof : InBuffer -> unit
    val getchar : InBuffer -> int
    val getlinenum : InBuffer -> int
    val getlinepos : InBuffer -> int
    val getlastlinepos : InBuffer -> int
    val flush_to_nl : InBuffer -> unit
  end
