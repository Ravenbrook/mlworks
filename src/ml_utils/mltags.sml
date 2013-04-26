(* mltags.sml the utility *)
(*
$Log: mltags.sml,v $
Revision 1.5  1996/10/31 16:54:33  io
[Bug #1614]
remove toplevel String.

 * Revision 1.4  1996/05/16  12:56:11  stephenb
 * Update wrt MLWorks.OS.arguments -> MLWorks.arguments change.
 *
 * Revision 1.3  1993/05/18  19:37:03  jont
 * Removed __integer parameter
 *
Revision 1.2  1993/04/01  14:27:43  jont
Added ability to make an image file from this

Revision 1.1  1993/03/09  16:55:21  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

require "../utils/__crash";
require "../lexer/__lexer";
require "../main/__info";
require "../main/__options";
require "../basics/__token";
require "../utils/__lists";
require "../basics/__location";

exception Exit

val get = Lexer_.getToken Info_.default_options

fun relation((name1, _), (name2, _)) = ((op<):string*string->bool) (name1, name2)

fun do_tags([], done, out_stream, close_stream) =
  let
    val the_list = Lists_.qsort relation done
  in
    app
    (fn (name, str) => (output(out_stream, name); output(out_stream, str)))
    the_list;
    if close_stream then close_out out_stream else ()
  end
  | do_tags(filename :: filenames, done, out_stream, close_stream) =
    let
      val in_stream =
	open_in filename
	handle Io s =>
	  (output(MLWorks.IO.std_err,
		  "Failed to open'" ^ filename ^ "'for input because " ^ s ^ "\n");
	   raise Exit)
      val ts = Lexer_.mkFileTokenStream (in_stream, filename)
      fun do_work list =
	if Lexer_.eof ts then
	  list
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
			    do_work((name, "\009" ^ filename ^ "\009" ^
				     MLWorks.Integer.makestring line ^ "\n") :: list)
			  end
		      | _ => Crash_.impossible"Bad token following FUN")
	       | _ => do_work list)
	  end
      val done = do_work done
    in
      close_in in_stream;
      do_tags(filenames, done, out_stream, close_stream)
    end

fun obey("-f" :: output_file :: (input_files as (_ :: _))) =
  (do_tags(input_files, [], open_out output_file, true)
     handle Io s =>
       output(MLWorks.IO.std_err, "mltags: Failed to open'" ^ output_file ^
	      "'for output because " ^ s ^ "\n")
	  | Exit => ())
  | obey(arg as (_ :: _)) = do_tags(arg, [], std_out, false)
  | obey args = (output(MLWorks.IO.std_err,
		     "mltags: No args\nShould be mltags [-f <output_file>] <input_files>\n"))

fun obey1["-save", filename] =
  (MLWorks.save(filename, fn () => obey(MLWorks.arguments()));
   ())
  | obey1 arg = (output(std_out, "Bad initial args\n");
		 app (fn str => output(std_out, str ^ "\n")) arg;
		 ())

val _ = obey1(MLWorks.arguments ());
