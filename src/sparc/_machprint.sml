(* _machprint.sml the functor *)
(*
$Log: _machprint.sml,v $
Revision 1.17  1998/02/20 09:32:18  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.16  1997/05/22  13:19:06  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.15  1996/10/29  18:09:35  io
 * moving String from toplevel
 *
 * Revision 1.14  1996/04/30  17:09:04  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.13  1994/03/24  11:07:19  matthew
 * Cope with alignment of code properly.
 *
Revision 1.12  1994/03/23  17:35:50  matthew
Fixed bug with mutually recursive functions.
Printing improvements

Revision 1.11  1994/03/21  16:21:17  matthew
Added labels to assembler output

Revision 1.10  1993/12/17  15:12:10  io
moved machprint to main/

Revision 1.9  1993/05/28  15:19:59  matthew
Align comments.

Revision 1.8  1993/03/12  11:55:38  matthew
Added type OpCode

Revision 1.7  1993/01/05  15:28:00  jont
Modified to print final machine code

Revision 1.6  1992/02/27  16:03:42  richard
Changed the way virtual registers are handled.  See MirTypes.

Revision 1.5  1992/02/07  12:48:56  richard
Abolished PRESERVE_ALL_REGS.

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

require "^.basis.__string_cvt";
require "^.basis.__text_io";

require "../utils/lists";
require "sparc_assembly";
require "../main/machprint";

functor MachPrint(
  structure Lists : LISTS
  structure Sparc_Assembly : SPARC_ASSEMBLY
) : MACHPRINT =
struct
  structure Sparc_Assembly = Sparc_Assembly

  type Opcode = Sparc_Assembly.opcode

  val opcol = 35
  val labcol = 5

  fun pad columns x = StringCvt.padRight #" " columns x
  fun align n = if n mod 2 = 0 then n else n+1

  (* This could be somewhat better coded *)
  (* The diddling with +2 & align is to cope with backptr slots * alignment *)
  fun print_code (stream,labmap) (n,((tag, code),name)) =
    (TextIO.output(stream, ("[Sparc_Assembly Code]" ^ " for " ^ name ^ "\n"));
     Lists.reducel
     (fn (n,(x,y)) =>
      let
        val (lab,ass) = Sparc_Assembly.labprint (x,n,labmap)
        val line =
          if size y = 0
            then concat [pad labcol lab,ass,"\n"]
          else
            concat [pad labcol lab,pad opcol ass,"; ",y,"\n"]
      in
        TextIO.output(stream,line);
        n+1
      end)
     (align (n+2),code))

  fun print_mach_code code_list_list stream =
    let
      val labmap = 
        Sparc_Assembly.make_labmap 
        (map
         (fn code_list =>
          map 
          (fn ((tag,code),name) => (map (fn (x,y) => x) code))
          code_list)
         code_list_list)
    in
      ignore(
        Lists.reducel
        (fn (n,code_list) => Lists.reducel (print_code (stream,labmap)) (align n,code_list))
        (0,code_list_list));
      ()
    end
end

