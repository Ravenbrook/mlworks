(* WinNtLinkSupport the functor *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
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
 * $Log: _win_nt_link_support.sml,v $
 * Revision 1.9  1999/04/23 11:22:48  daveb
 * [Bug #190553]
 * OS.Process.status is no longer an equality type.
 *
 * Revision 1.8  1999/03/17  14:56:55  daveb
 * [Bug #190523]
 * Changes to execute functions in the Windows structure.
 *
 * Revision 1.7  1999/02/02  16:02:13  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.6  1998/11/03  13:14:22  jont
 * [Bug #70204]
 * Do archive using Windows.execute as system isn't good enough
 *
 * Revision 1.5  1998/11/02  14:52:42  jont
 * [Bug #70204]
 * Sort out entry point when linking exes
 *
 * Revision 1.4  1998/10/30  16:57:06  jont
 * [Bug #70198]
 * Add support for invoking gcc and creating a unqiue stamp for a dll/so
 *
 * Revision 1.3  1998/10/23  16:03:19  jont
 * [Bug #70198]
 * Add ability to make archives (using ar)
 *
 * Revision 1.2  1998/10/21  13:47:24  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/crash";
require "../basis/__word32";
require "../basis/__int";
require "../basis/__list";
require "../basis/__string";
require "../basis/__string";
require "../basis/__word8_vector";
require "../basis/__bin_io";
require "../basis/__text_io";
require "../basis/__io";
require "__windows";
require "__os";
require "../main/encapsulate";
require "../main/link_support";

functor WinNtLinkSupport (
  structure Crash : CRASH
  structure Encapsulate : ENCAPSULATE
) : LINK_SUPPORT =
  struct
    datatype target_type = DLL | EXE
    datatype linker_type = GNU | LOCAL
    fun munge(acc, []) = String.concat(rev acc)
      | munge(acc, [x]) = munge(x :: acc, [])
      | munge(acc, x :: y) = munge(" " :: x :: acc, y)

    val munge = fn list => munge([], list)

    fun get_all_output ins =
      if TextIO.endOfStream ins then
	()
      else
	(ignore(TextIO.input1 ins); get_all_output ins)

    fun link
      {objects, (* Full pathnames *)
       libs, (* Full pathnames *)
       target, (* Just a final component, without .exe or anything *)
       target_path, (* Where to put the target *)
       dll_or_exe,
       base, (* Default base address *)
       make_map, (* True if a link map should be produced *)
       linker (* Use the default or GNU *)
       } =
      let
	val target_ext = case dll_or_exe of DLL => "dll" | EXE => "exe"
	val target_pathname = OS.Path.joinDirFile{dir=target_path, file=target}
	val target_filename = OS.Path.joinBaseExt{base=target_pathname, ext=SOME target_ext}
	val (linker, out, linker_opts) =
	  case linker of
	    GNU => ("ld.exe", "", Crash.unimplemented"GNU linker for Win32")
	  | LOCAL =>
	      let
		val args =
		  if make_map then
		    ["/MAP:" ^ OS.Path.joinBaseExt{base=target_pathname, ext=SOME"map"}]
		  else
		    []
		val args =
		  "/nologo" ::
		  (case dll_or_exe of DLL => "/ENTRY:MLWDLLmain@12" | EXE => "/ENTRY:main") ::
		  "-base:0x" ^ Word32.toString base :: args
		val args = case dll_or_exe of
		  DLL => "/DLL" :: args
		| EXE => args
		val out = "/OUT:" ^ target_filename
	      in
		("link.exe", out, args)
	      end
	val linker_path = case Windows.findExecutable linker of
	  SOME ln => ln
	| NONE => raise OS.SysErr("Cannot find linker: " ^ linker, NONE)
	val args = out :: (objects @ libs @ linker_opts)
	val cmd = munge(out :: (objects @ libs @ linker_opts))

	val status = Windows.simpleExecute (linker_path, args)
      in
	if OS.Process.isSuccess status then
          ()
        else
          raise OS.SysErr("Link failed", NONE)
      end

    fun checked_input(f, len) =
      let
	val s = BinIO.inputN(f, len)
	val read_len = Word8Vector.length s
      in
	if read_len <> len then raise OS.SysErr("Corrupt object file (2) " ^ Int.toString read_len ^ " " ^ Int.toString len, NONE)
	else
	  s
      end

    fun new_name file =
      let
	val {base, ext} = OS.Path.splitBaseExt file
      in
	OS.Path.toUnixPath(OS.Path.joinBaseExt{base=base, ext=SOME"mrc"})
      end

    fun copy file =
      let
	val copied = new_name file
	val code_offset = Encapsulate.code_offset file
	val input =
	  BinIO.openIn file
	  handle IO.Io{name, ...} =>
	    raise OS.SysErr("Io error: " ^ name, NONE)
	val output =
	  BinIO.openOut copied
	  handle IO.Io{name, ...} =>
	    raise OS.SysErr("Io error: " ^ name, NONE)
	(* Get everything up to but not including the code *)
	val s = checked_input(input, code_offset)
      in
	BinIO.output(output, s);
	BinIO.closeOut output
      end

    fun archive{archive : string, files : string list} =
      let
	val ar = case Windows.findExecutable"ar.exe" of
	  SOME x => x
	| NONE => raise OS.SysErr("Cannot find archiver: ar.exe", NONE)
	val copies = map new_name files
	(* Now extract the compiler info from all the .mo files *)
	val _ = app copy files;
	(* Now make the archive *)
	val status = Windows.simpleExecute (ar, "cr" :: archive :: copies)
      in
	  if OS.Process.isSuccess status then
	    ()
          else 
            raise OS.SysErr("ar failed", NONE);
	(* Now remove the copies *)
	app OS.FileSys.remove copies
      end

    fun gcc arg =
      let
	val gcc = case Windows.findExecutable"gcc.exe" of
	  SOME gcc => gcc
	| NONE => raise OS.SysErr("Can't find gcc", NONE)
	val {base, ext} = OS.Path.splitBaseExt arg
	val object = OS.Path.joinBaseExt{base=base, ext = SOME"o"}
	val args = munge["-c", arg, "-o", object]
	val status = OS.Process.system(gcc ^ " " ^ args)
      in
	if not (OS.Process.isSuccess status) then
	  raise OS.SysErr("'gcc " ^ args ^ "' failed", NONE)
	else
	  let
	    val extend = case Windows.findExecutable"extend.exe" of
	      SOME extend => extend
	    | NONE => raise OS.SysErr("Can't find extend", NONE)
	    val status = OS.Process.system(extend ^ " " ^ object)
	  in
	    if OS.Process.isSuccess status then
	      ()
	    else
	      raise OS.SysErr("'extend " ^ object ^ "' failed", NONE)
	  end
      end

    fun make_word([], n, acc) = (String.implode(rev acc), [])
      | make_word(list as (l :: rest), n, acc) =
      if n <= 0 then
	(String.implode(rev acc), rest)
      else
	make_word(rest, n-1, l :: acc)

    fun munge_stamp string =
      let
	val expl = String.explode string
	val expl = List.filter (fn x => x <> #"-") expl
	val (num1, rest) = make_word(expl, 8, [])
	val (num2, rest) = make_word(rest, 8, [])
	val (num3, rest) = make_word(rest, 8, [])
	val (num4, rest) = make_word(rest, 8, [])
      in
	(num1, num2, num3, num4)
      end

    fun make_stamp dll =
      let
	val uuidgen = case Windows.findExecutable"uuidgen.exe" of
	  SOME uuidgen => uuidgen
	| NONE => raise OS.SysErr("Can't find uuidgen", NONE)
	val proc = Windows.execute(uuidgen, [])
	val ins = Windows.textInstreamOf proc
	val line = TextIO.inputLine ins
	val (num1, num2, num3, num4) = munge_stamp line
	val _ = Windows.reap proc
      in
	"\t.data\n\t.globl\tuid\nuid:\n" ^
	"\t.long\t0x" ^ num1 ^ "\n" ^
	"\t.long\t0x" ^ num2 ^ "\n" ^
	"\t.long\t0x" ^ num3 ^ "\n" ^
	"\t.long\t0x" ^ num4 ^ "\n" ^
	"\t.globl\ttext_start\n" ^
	"\t.long\ttext_start\n" ^
	"\t.globl\tdata_start\n" ^
	"\t.long\tdata_start\n" ^
	"\t.globl\ttext_end\n" ^
	"\t.long\ttext_end\n" ^
	"\t.globl\tdata_end\n" ^
	"\t.long\tdata_end\n" ^
	"\t.long\t0\n" ^
	"\t.asciz\t\"" ^ dll ^ "\"\n"
      end

  end
