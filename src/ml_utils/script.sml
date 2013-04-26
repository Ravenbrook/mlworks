(* script.sml *)
(*
 *
 * runtime system script maker for ML
 *
 * $Log: script.sml,v $
 * Revision 1.6  1996/11/01 12:18:31  io
 * [Bug #1614]
 * remove toplevel String.
 *
 * Revision 1.5  1996/05/16  12:56:22  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.4  1995/02/02  16:54:16  jont
 * Modify in light of BTree changes
 * Still not correct following module naming changes
 *
Revision 1.3  1993/04/05  12:34:37  jont
Added code to deal with image contents

Revision 1.2  1993/04/01  14:34:14  jont
Added ability to make an image file from this

Revision 1.1  1993/03/26  15:57:06  jont
Initial revision

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
 *)

require "../utils/__option";
require "../utils/__btree";
require "../utils/__lists";
require "../main/__io";
require "../main/__info";
require "../main/__options";
require "../lexer/__lexer";

val output1 = "#!/bin/sh\nLIBDIR=/usr/local/lib/MLWorks\nBINDIR=/usr/local/lib/MLWorks/bin\nSCRIPTDIR=/usr/local/lib/MLWorks/bin\nRUNTIME=mlrunx\nexec $BINDIR/$RUNTIME -load "

fun get_imports_from_stream (error_info, ts, imports) =
  let
    val get = Lexer_.getToken error_info
  in
    case get(Options_.default_options, Lexer_.Token.PLAIN_STATE, ts) of
      Lexer_.Token.RESERVED Lexer_.Token.REQUIRE =>
	(case get(Options_.default_options, Lexer_.Token.PLAIN_STATE, ts) of
	   Lexer_.Token.STRING filename =>
	     (case get(Options_.default_options, Lexer_.Token.PLAIN_STATE, ts) of
		Lexer_.Token.RESERVED Lexer_.Token.SEMICOLON =>
		  ()
	      | _ =>
		  Info_.error' Info_.default_options
		  (Info_.RECOVERABLE,
		   Lexer_.locate ts,
		   "missing ; after require");
		  get_imports_from_stream (error_info, ts, filename :: imports)
		  )
	 | _ =>
	     Info_.error' Info_.default_options
	     (Info_.FATAL,
	      Lexer_.locate ts,
	      "missing string after require")
	     )
    | _ => imports
  end

fun get_imports error_info filename =
  let
    val stream = open_in filename
    val ts = Lexer_.mkFileTokenStream (stream, filename)
    val imports = get_imports_from_stream (error_info, ts, [])
  in
    close_in stream;
    imports
  end handle Io _ => []

exception bad_args of string

fun make_list(acc, [], _) = acc
  | make_list(acc as (load_list, name_map), file :: files_to_do, inprogress) =
    let
      val sml_name = Io_.sml_name file
      val comp_name = Io_.compilation_name sml_name
      val _ = case BTree_.tryApply'(inprogress, comp_name) of
	MLWorks.Option.NONE => ()
      | _ => raise bad_args ("Circularity at '" ^ sml_name ^ "'")
    in
      case BTree_.tryApply'(name_map, comp_name) of
	MLWorks.Option.NONE =>
	  let
	    val comp_path = Io_.compilation_path sml_name
	    (* Now accumulate all the requires of this files and prepend them *)
	    (* to the files_to_do list, add this file to the map and load_list *)
	    (* and recurse *)
	    val imports = get_imports Info_.default_options sml_name
	    val import_names =
	      map (fn name => Io_.relative_name(comp_path, name)) imports
	    val inprogress = BTree_.define(inprogress, comp_name, true)
	    val (load_list, name_map) =
	      Lists_.reducel
	      (fn (acc as (load_list, name_map), filename) =>
	       let
		 val co_name = Io_.compilation_name filename
	       in
		 case BTree_.tryApply'(name_map, co_name) of
		   MLWorks.Option.NONE =>
		     make_list(acc, [filename], inprogress)
		 | _ => acc
	       end)
	      (acc, import_names)
	  in
	    make_list((Io_.mo_name sml_name :: " " :: load_list,
		       BTree_.define(name_map, comp_name, true)), files_to_do, inprogress)
	  end
      | _ => make_list((load_list, name_map), files_to_do, inprogress)
    end

fun make_script(command_name, library, args_delim, ml_source) =
  let
    val (args_needed, delim) = case args_delim of
      Option_.PRESENT x => (true, x)
    | _ => (false, "")
    val (library, lib_string) = case library of
      Option_.PRESENT library => (library, library)
    | _ => (output(std_out, "No library specified, assuming '/usr/local/lib/MLWorks/images/pervasive.img'\n");
	    ("/usr/local/lib/MLWorks/images/pervasive.img", "$LIBDIR/images/pervasive.img"))
    val lib_names = MLWorks.Internal.Images.table library
      handle MLWorks.Internal.Images.Table string => raise bad_args string
    val lib_names = map (fn str => (str, true)) lib_names
    val files = implode(rev(#1(make_list(([], BTree_.from_list' ((op<):string*string->bool) lib_names),
					 [ml_source], BTree_.empty' ((op<):string*string->bool)))))
    val script = output1 ^ lib_string ^
      (if args_needed then " -pass " ^ delim ^ " $* " ^ delim else "") ^
	 files ^ "\n"
  in
    output(std_out, script)
  end

fun check_option(Option_.ABSENT, string) = string
  | check_option(_, _) = ""

fun do_help() =
  (output(std_out, "script args:\n");
   output(std_out, "-command <filename> : the name of the resulting command\n");
   output(std_out, "-library <filename> : the name of a library to be loaded\n");
   output(std_out, "-arg_delimiter <string> : a string which may be safely used as an argument delimiter\n");
   output(std_out, "-source <filename> : the top level source program.\n"))

fun obey([], Option_.PRESENT command_name, library, args_delim,
	 Option_.PRESENT ml_source) =
  make_script(command_name, library, args_delim, ml_source)
  | obey([], a, _, _, b) = raise bad_args
    ("Missing args:" ^ check_option(a, " -command") ^ check_option(b, " -source") ^ "\n")
  | obey(args, a, b, c, d) =
    (case args of
       (hd as "-command") :: x :: xs =>
	 (case a of
	    Option_.ABSENT => obey(xs, Option_.PRESENT x, b, c, d)
	  | _ => raise bad_args ("Option '" ^ hd ^ "' is already specified" ))
     | (hd as "-library") :: x :: xs =>
	 (case b of
	    Option_.ABSENT => obey(xs, a, Option_.PRESENT x, c, d)
	  | _ => raise bad_args ("Option '" ^ hd ^ "' is already specified" ))
     | (hd as "-arg_delimiter") :: x :: xs =>
	 (case c of
	    Option_.ABSENT => obey(xs, a, b, Option_.PRESENT x, d)
	  | _ => raise bad_args ("Option '" ^ hd ^ "' is already specified" ))
     | (hd as "-source") :: x :: xs =>
	 (case d of
	    Option_.ABSENT => obey(xs, a, b, c, Option_.PRESENT x)
	  | _ => raise bad_args ("Option '" ^ hd ^ "' is already specified" ))
     | "-help" :: _ => do_help()
     | x :: _ => raise bad_args ("Unknown option '" ^ x ^ "'or wrong arguments to '" ^ x)
     | _ => raise bad_args"Compiler error")

fun obey1 str_list =
  obey(str_list, Option_.ABSENT, Option_.ABSENT, Option_.ABSENT, Option_.ABSENT)
  handle bad_args string =>
    output(MLWorks.IO.std_err, "script: " ^ string ^ "\n")

fun obey2["-save", filename] =
  (MLWorks.save(filename, fn () => obey1(MLWorks.arguments()));
   ())
  | obey2 arg = (output(std_out, "Bad initial args\n");
		 Lists_.iterate (fn str => output(std_out, str ^ "\n")) arg;
		 ())

val _ = obey2(MLWorks.arguments());
