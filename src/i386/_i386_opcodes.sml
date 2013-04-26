(* _i386_opcodes.sml the functor *)
(*
$Log: _i386_opcodes.sml,v $
Revision 1.3  1996/10/31 14:59:07  io
moving String from toplevel

 * Revision 1.2  1996/05/01  12:40:34  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.1  1994/09/09  15:42:32  jont
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)

require "../utils/crash";
require "i386types";
require "i386_opcodes";


functor I386_Opcodes(
  structure Crash : CRASH
  structure I386Types : I386TYPES
) : I386_OPCODES =
struct
  structure I386Types = I386Types

  datatype opcode = OPCODE of int list

  fun make_list(bytes, value, acc) =
    if bytes <= 0 then acc
    else
      make_list(bytes-1, value div 256, chr(value mod 256) :: acc)

  fun output_int(bytes, value) =
    make_list(bytes, value, [])

  fun output_opcode(OPCODE i) =
    implode (map chr i)

end
