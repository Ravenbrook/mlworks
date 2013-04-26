(* Object_Output the structure *)
(*
 * Functions to output code as genuine (.o) object files, either in assembler
 * format, or binary
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: __object_output.sml,v $
 * Revision 1.3  1999/02/02 16:01:37  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.2  1998/08/25  12:09:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "__sparc_assembly";
require "../main/__code_module";
require "../main/__project";
require "../basics/__module_id";

structure Object_Output_ =
  struct
    datatype OUTPUT_TYPE = ASM | BINARY

    type Opcode = Sparc_Assembly_.opcode

    type Module = Code_Module_.Module

    type ModuleId = ModuleId_.ModuleId

    type Project = Project_.Project

    fun output_object_code _ _ = ()
      (* Not implemented yet *)

  end
