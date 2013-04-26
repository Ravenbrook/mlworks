(* OBJECT_OUTPUT the signature *)
(*
 * Functions to output code as genuine (.o) object files, either in assembler
 * format, or binary
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: object_output.sml,v $
 * Revision 1.3  1998/10/22 12:22:55  jont
 * [Bug #70218]
 * Remove need for mnemonic assembler input
 *
 * Revision 1.2  1998/08/25  12:09:19  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

signature OBJECT_OUTPUT =
  sig
    datatype OUTPUT_TYPE = ASM | BINARY

    type Opcode

    type Module

    type ModuleId

    type Project

    val output_object_code :
      (OUTPUT_TYPE * ModuleId * string * Project) ->
      Module ->
      unit
  end
