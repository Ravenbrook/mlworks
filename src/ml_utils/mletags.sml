(* mletags.sml the utility *)
(*
$Log: mletags.sml,v $
Revision 1.6  1996/11/06 12:08:39  matthew
[Bug #1728]
__integer becomes __int

 * Revision 1.5  1996/10/29  19:16:17  io
 * [Bug #1614]
 * remove topleve String
 *
 * Revision 1.4  1996/05/16  12:55:41  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.3  1993/05/18  19:36:42  jont
 * Removed __integer parameter
 *
Revision 1.2  1993/04/01  14:23:05  jont
Added ability to make an image file from this

Revision 1.1  1993/03/09  16:55:32  jont
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

require "^.basis.__int";
require "^.basis.__string";
require "../utils/__crash";
require "../lexer/__lexer";
require "../main/__info";
require "../main/__options";
require "../basics/__token";
require "../utils/__lists";
require "../basics/__location";

exception Exit

fun count_list list = Lists_.reducel (fn (acc, s) => acc + size s) (0, list)

val get = Lexer_.getToken Info_.default_options

fun do_tags([], output_stream, close_stream) =
  if close_stream then close_out output_stream else ()
  | do_tags(filename :: filenames, output_stream, close_stream) =
    let
      val in_stream =
	open_in filename
	handle MLWorks.IO.Io s =>
	  (output(MLWorks.IO.std_err,
		  "Failed to open'" ^ filename ^ "'for input because " ^ s ^ "\n");
	   raise Exit)
      val ts = Lexer_.mkFileTokenStream (in_stream, filename)

      fun do_work list =
	if Lexer_.eof ts then list
	else
	  let
	    val token = get(Options_.default_options, Lexer_.Token.PLAIN_STATE, ts)
	  in
	    if Lexer_.eof ts then
	      list
	    else
	      (case token of
		 Token_.RESERVED(Token_.FUN) =>
		   if Lexer_.eof ts then
		     list
		   else
		     (case get(Options_.default_options, Lexer_.Token.PLAIN_STATE, ts) of
			Token_.LONGID(_, name) =>
			  let
			    val line = case Lexer_.locate ts of
			      Location_.UNKNOWN => Crash_.impossible"Lexer failure"
			    | Location_.FILE _ => Crash_.impossible"Lexer failure"
			    | Location_.LINE(_, i) => i
			    | Location_.POSITION(_, i, _) => i
			    | Location_.EXTENT{s_line, ...} => s_line
			  in
			    do_work(line :: list)
			  end
		      | _ => Crash_.impossible"Bad token following FUN")
	       | _ => do_work list)
	  end
      val the_list = rev(do_work [])
      val _ = close_in in_stream
      val in_stream =
	open_in filename
	handle Io s =>
	  (MLWorks.IO.output(MLWorks.IO.std_err,
		  "Failed to open'" ^ filename ^ "'for input because " ^ s ^ "\n");
	   raise Exit)
      fun do_work(_, _, [], done) = done
	| do_work(here, line, arg as (i :: rest), done) =
	  if i < here then
	    (MLWorks.IO.output(MLWorks.IO.std_err, "mletags: internal failure\n");
	     raise Exit)
	  else
	    if i > here then
	      do_work(here+1, MLWorks.IO.input_line in_stream, arg, done)
	    else
	      let
		val line_size = size line
		val line =
		  if line_size > 0 andalso String.sub(line, line_size-1) = #"\n" then
		    substring(line, 0, line_size - 1)
		  else
		    line
	      in
		do_work(here, line, rest, "\n" :: "0" :: "," ::
			Int.toString here ::
			chr 127 :: line :: done)
	      end
      val the_list = do_work(0, "", the_list, [])
      val length = count_list the_list
    in
      MLWorks.IO.output(output_stream, concat[(str o chr) 12, "\n", filename, ",",
				    Int.toString length, "\n"]);
      MLWorks.IO.output(output_stream, concat(rev the_list));
      close_in in_stream;
      do_tags(filenames, output_stream, close_stream)
  end

fun obey("-f" :: output_file :: (input_files as (_ :: _))) =
    (do_tags(input_files, MLWorks.IO.open_out output_file, true)
     handle MLWorks.IO.Io s =>
       MLWorks.IO.output(MLWorks.IO.std_err, "mletags: Failed to open'" ^ output_file ^
	      "'for output because " ^ s ^ "\n")
	  | Exit => ())
  | obey(arg as (_ :: _)) = do_tags(arg, MLWorks.IO.std_out, false)
  | obey args = (MLWorks.IO.output(MLWorks.IO.std_err,
		     "mletags: No args\nShould be mletags [-f <output_file>] <input_files>\n"))

fun obey1["-save", filename] =
  (MLWorks.save(filename, fn () => obey(MLWorks.arguments()));
   ())
  | obey1 arg = (print "Bad initial args\n";
		 Lists_.iterate (fn str => print (str ^ "\n")) arg;
		 ())

val _ = obey1(MLWorks.arguments ());
