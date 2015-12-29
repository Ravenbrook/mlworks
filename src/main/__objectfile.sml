(* __objectfile.sml the structure *)
(*
 * Object file opcodes
 * Originally generated from rts/src/objectfile.h, but copied
 * here to represent the output of the current compiler source,
 * which is *not* necessarily what the runtime system can load.
 *
 * Copyright 2013 Ravenbrook Limited
 *)

structure ObjectFile_ =
struct
  val GOOD_MAGIC = 450783256
  val HEADER_SIZE = 36
  val OBJECT_FILE_VERSION = 20
  val OPCODE_CODESET = 0
  val OPCODE_REAL = 1
  val OPCODE_STRING = 2
  val OPCODE_EXTERNAL = 3
end;
