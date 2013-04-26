(* Object_Output the structure *)
(*
 * Functions to output code as genuine (.o) object files, either in assembler
 * format, or binary
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: __object_output.sml,v $
 * Revision 1.2  1998/08/25 12:09:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/__crash";
require "__mips_assembly";
require "../main/__code_module";
require "../main/__project";
require "../basics/__module_id";

structure Object_Output_ =
  struct
    datatype OUTPUT_TYPE = ASM | BINARY

    type Opcode = Mips_Assembly_.opcode

    type Module = Code_Module_.Module

    type ModuleId = ModuleId_.ModuleId

    type Project = Project_.Project

    fun output_object_code _ _ = ()
      (* Not implemented yet *)

  end
