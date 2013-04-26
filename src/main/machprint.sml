(* machprint.sml the signature *)
(*
$Log: machprint.sml,v $
Revision 1.3  1997/05/22 13:18:31  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.2  1996/04/30  17:07:21  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1993/12/17  12:48:02  io
 * Initial revision
 *
Revision 1.3  1993/03/12  11:55:14  matthew
Signature revisions

Revision 1.2  1993/01/05  15:25:58  jont
Modified to print from final machine code

Revision 1.1  1991/10/02  14:41:13  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "^.basis.__text_io";

signature MACHPRINT = sig
  type Opcode
  val print_mach_code :
    (('a * (Opcode * string) list) * string) list list ->
    TextIO.outstream ->
    unit
end
