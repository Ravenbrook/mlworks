(* i386_opcodes.sml the signature *)
(*
$Log: i386_opcodes.sml,v $
Revision 1.1  1994/09/08 12:19:47  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "i386types";

signature I386_OPCODES = sig
  structure I386Types : I386TYPES
    
  datatype opcode = OPCODE of int list (* A list of byte values *)

  val output_opcode : opcode -> string

end
