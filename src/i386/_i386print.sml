(* _i386print.sml the functor *)
(*
$Log: _i386print.sml,v $
Revision 1.14  1999/02/02 15:59:54  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.13  1998/02/19  17:07:44  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.12  1997/09/19  09:19:48  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.11  1997/05/21  17:07:12  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.10  1996/11/06  11:12:40  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.9  1996/10/31  15:02:24  io
 * removing toplevel String.
 *
 * Revision 1.8  1996/05/01  12:56:56  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/04/30  13:20:57  matthew
 * Removing use of MLWorks.Integer
 *
 * Revision 1.6  1994/11/30  15:42:27  matthew
 * Made printing bytes optional
 *
Revision 1.5  1994/10/27  14:48:10  jont
Remove debugging print statements

Revision 1.4  1994/10/19  15:14:44  jont
Fix label calculation

Revision 1.3  1994/10/18  14:14:01  jont
Fix printing for mutually recursive functions

Revision 1.2  1994/09/16  13:26:57  jont
Add printing of binary form at present

Revision 1.1  1994/09/09  14:55:00  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../basis/__text_io";

require "../utils/lists";
require "i386_assembly";
require "../main/machprint";
require "^.basis.__string_cvt";

functor I386Print(
  structure Lists : LISTS
  structure I386_Assembly : I386_ASSEMBLY
) : MACHPRINT =
struct
  structure I386_Assembly = I386_Assembly
  structure I386_Opcodes = I386_Assembly.I386_Opcodes

  type Opcode = I386_Assembly.opcode

  val print_bytes = true

  val opcol = 35
  val labcol = 8

  fun pad columns x = 
    StringCvt.padRight #" " columns x

  fun print_nibble i =
    if i >= 0 andalso i <= 9 then
      chr (i+ ord #"0")
    else
      if i >= 10 andalso i <= 16 then
	chr(i+ ord #"a" - 10)
      else
	raise Match

  fun print_byte i =
    let
      val hi = (i div 16) mod 16
      val lo = i mod 16
    in
      str (print_nibble hi) ^ str (print_nibble lo) ^ " "
    end

  val max_bytes = 12

  fun space_pad 0 = []
    | space_pad n =
      if n < 0 then raise Match else "   " :: space_pad(n-1)

  fun double_align n = ((n+7) div 8) * 8

  (* This could be somewhat better coded *)
  (* The diddling with +- 2 is to cope with backptr slots *)
  (* Now +-8 as we're working in bytes *)
  fun print_code (stream,labmap) (n,((tag, code),name)) =
    (TextIO.output(stream, ("[I386_Assembly Code]" ^ " for " ^ name ^
		     (*"at offset " ^ Int.toString(n + 8) ^ *)"\n"));
     Lists.reducel
     (fn (n,(x,y)) =>
      let
	val I386_Opcodes.OPCODE byte_list = I386_Assembly.assemble x
        val (lab,ass) = I386_Assembly.labprint (x,n,labmap)
	val bytes = length byte_list
	val code = if print_bytes then map print_byte byte_list else []
	val padding =
          if print_bytes then
	    if bytes > max_bytes then
	      (print"Strange, very long opcode sequence";
	       [])
	    else
	      space_pad(max_bytes - bytes)
          else []
        val line =
          if size y = 0 then
	    concat (padding @ code @ [pad labcol lab,ass,"\n"])
          else
            concat (padding @ code @ [pad labcol lab,pad opcol ass,"; ",y,"\n"])
      in
        TextIO.output(stream,line);
        n+I386_Assembly.opcode_size x
      end)
     (double_align n + 8,code))

  fun print_mach_code code_list_list stream =
    let
      val labmap = 
        I386_Assembly.make_labmap 
        (map
         (fn code_list =>
          map 
          (fn ((tag,code),name) => (map (fn (x,y) => x) code))
          code_list)
         code_list_list)
    in
      ignore(Lists.reducel
        (fn (n,code_list) =>
         Lists.reducel (print_code (stream,labmap)) (double_align n,code_list))
        (0,code_list_list));
      ()
    end
end
