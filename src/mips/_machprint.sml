(*
 Copyright (c) 1993 Harlequin Ltd.
 
 based on Revision 1.9 
 Revision Log
 ------------
 $Log: _machprint.sml,v $
 Revision 1.10  1998/04/23 11:16:01  mitchell
 [Bug #30349]
 Fix non-unit non-final expression warnings

 * Revision 1.9  1997/05/22  13:19:42  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.8  1996/10/09  17:01:11  io
 * basify
 *
 * Revision 1.7  1996/05/01  12:10:00  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.6  1994/10/19  12:34:15  matthew
 * Improved label printing.  Added align function.
 *
Revision 1.5  1994/04/26  15:25:39  io
adding labels

Revision 1.4  1994/02/22  12:47:14  jont
Put back consistent version

Revision 1.2  1993/11/16  16:14:19  io
Deleted old SPARC comments and fixed type errors

 *)

require "^.basis.__string_cvt";
require "^.basis.__text_io";

require "../utils/lists";
require "mips_assembly";
require "../main/machprint";

functor MachPrint(
  structure Lists : LISTS
  structure Mips_Assembly : MIPS_ASSEMBLY
) : MACHPRINT =
struct
  structure Mips_Assembly = Mips_Assembly

  type Opcode = Mips_Assembly.opcode

  val opcol = 35
  val labcol = 7

  fun pad columns x = StringCvt.padRight #" " columns x
  (* Double word align starts of procedures *)

  fun align i = if i mod 2 = 0 then i else i+1

  (* The way instructions are indexed should be consistent with _mip_assembly *)
  fun print_code (stream, labmap) (i, ((tag, code), name)) = 
    (TextIO.output(stream, ("[Mips_Assembly Code]" ^ " for " ^ name ^ "\n"));
     Lists.reducel 
     (fn (i,(opcode,comment)) => 
      let
        val (lab, instr) = Mips_Assembly.labprint(opcode,i,labmap)
        val line = if size comment = 0 then
          concat [pad labcol lab, instr, "\n"]
                   else concat [pad labcol lab, pad opcol instr, "; ", comment, "\n"]
      in
        TextIO.output(stream, line);
        i+1
      end)
     (align i+2,code))


    fun print_mach_code code_list_list stream = let
      val labmap = Mips_Assembly.make_labmap
	(map (fn code_list =>
	      map (fn ((tag,code),name) => 
		   (map (fn (x,y) => x) code))
	      code_list)
	 code_list_list)
    in
      ignore(
        Lists.reducel 
        (fn (n,code_list) => Lists.reducel (print_code (stream,labmap)) (align n,code_list))
        (0,code_list_list));
      ()
    end (* print_mach_code *) 	      

end (* functor *)
