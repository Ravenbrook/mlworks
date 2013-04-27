(* mirprint.sml the signature *)
(*
$Log: mirprint.sml,v $
Revision 1.14  1997/05/21 17:01:16  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.13  1996/04/30  16:47:32  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.11  1993/01/05  15:51:18  jont
 * Modified to print directly to a given stream for speed and controllability
 *
Revision 1.10  1992/02/28  15:33:40  richard
Changed the way virtual registers are handled.  See MirTypes.

Revision 1.9  1991/11/14  10:49:24  richard
Removed references to fp_double registers.

Revision 1.8  91/11/05  10:14:36  richard
Added procedure print function.

Revision 1.7  91/10/16  16:12:45  richard
Added unadorned register printing.

Revision 1.6  91/10/03  10:46:25  richard
Added fp_operand function.

Revision 1.5  91/09/11  14:39:59  richard
Brought reg_operand to the outside.

Revision 1.4  91/09/09  13:33:43  richard
Yet more functions made available. Names containing ``print''
shortened (it's in the structure name).

Revision 1.3  91/09/06  13:52:05  richard
Still more functions revealed to the outside world (but
mostly to MirDataFlow so I can watch what it is doing.

Revision 1.2  91/09/05  11:59:31  richard
Added functions to allow individual opcodes and blocks to be printed.

Revision 1.1  91/07/25  14:01:09  jont
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../basis/__text_io";
require "mirtypes";

signature MIRPRINT = sig
  structure MirTypes	: MIRTYPES

  val show_register_names	: bool ref
  val show_real_registers	: bool ref

  val string_mir_code	: MirTypes.mir_code -> string
  val print_mir_code	: MirTypes.mir_code -> TextIO.outstream -> unit
  val procedure		: MirTypes.procedure -> string
  val block		: MirTypes.block -> string
  val opcode		: MirTypes.opcode -> string
  val binary_op		: MirTypes.binary_op -> string
  val unary_op		: MirTypes.unary_op -> string
  val binary_fp_op	: MirTypes.binary_fp_op -> string
  val unary_fp_op	: MirTypes.unary_fp_op -> string
  val store_op		: MirTypes.store_op -> string
  val store_fp_op	: MirTypes.store_fp_op -> string
  val gp_operand	: MirTypes.gp_operand -> string
  val reg_operand	: MirTypes.reg_operand -> string
  val fp_operand	: MirTypes.fp_operand -> string
  val any_reg		: MirTypes.any_register -> string
  val gc_register	: MirTypes.GC.T -> string
  val non_gc_register	: MirTypes.NonGC.T -> string
  val fp_register	: MirTypes.FP.T -> string
end
