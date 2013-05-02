(*
$Log: _lexrules.sml,v $
Revision 1.47  1997/07/21 08:52:17  daveb
[Bug #30090]
Removed spurious require on __old.

 * Revision 1.46  1996/11/06  10:55:08  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.45  1996/11/04  16:00:54  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.44  1996/11/01  12:29:19  io
 * [Bug #1614]
 * leftover String.ord
 *
 * Revision 1.43  1996/10/30  16:32:07  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.42  1996/10/10  10:25:53  andreww
 * [Bug #1646]
 * Adding new escape sequence.
 *
 * Revision 1.41  1996/05/21  13:43:38  daveb
 * abstractions is now a compatibility option.
 *
 * Revision 1.40  1996/05/07  10:29:20  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.39  1996/04/30  17:37:16  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.38  1996/04/29  13:20:10  matthew
 * Integer changes
 * ,
 *
 * Revision 1.37  1996/03/25  12:18:19  matthew
 * Changing default imperative attibute to false.  This was trying to be too clever.
 *
 * Revision 1.36  1996/03/19  15:38:15  matthew
 * Updating for new language
 *
 * Revision 1.35  1995/07/28  14:40:32  matthew
 * Changin magic open bracker to #(
 *
Revision 1.34  1995/07/24  15:30:30  jont
Add word literal

Revision 1.33  1995/07/19  10:14:20  jont
Add recognition of character special constants

Revision 1.32  1995/07/17  10:23:17  jont
Recognise hex integers as integers

Revision 1.31  1995/03/17  14:33:34  matthew
Adding cached chr function

Revision 1.30  1995/03/10  16:52:18  matthew
Improving message for malformed real literals

Revision 1.29  1994/06/24  09:25:36  nickh
Add a type constraint required by NJ for the daily build.

Revision 1.28  1994/06/23  13:17:47  matthew
Changed the way keywords are lexed.

Revision 1.27  1994/03/08  13:49:45  daveb
Improving location reported for erroneous newline in string.

Revision 1.26  1993/11/26  17:09:16  matthew
Added error check for numeric specification out of range.

Revision 1.25  1993/10/07  10:21:32  nickh
Merging in bug fixes.

Revision 1.24.1.2  1993/10/06  16:37:55  nickh
Fixed error recovery on string reading, and added comment to
describe error conditions.

Revision 1.24  1993/08/25  19:02:21  jont
Removed some handlers in favour of a different mechanism. Comment lexing
and string lexing should improve dramatically

Revision 1.23  1993/05/28  13:30:00  matthew
Better regexp for long_id's

Revision 1.22  1993/05/27  15:49:47  matthew
Allow lexing of longids ending in "."
This is to make completion work.

Revision 1.21  1993/05/20  12:27:41  matthew
Added code for abstractions.

Revision 1.20  1993/05/18  16:17:03  jont
Removed integer parameter

Revision 1.19  1993/03/31  10:52:49  jont
Miinor efficiency improvements

Revision 1.18  1993/03/30  12:31:32  daveb
Replaced lexers for strings and comments with faster, more functional,
simple functions.  EOFs are now annotated with a LexerState value, so
that we can lex strings and comments that extend over multiple lines
in a listener.  Removed the now redundant check_end_state.

Revision 1.17  1993/03/23  16:01:05  daveb
Action functions now take an options parameter.  This is used to control
the interpretation of "require", "<<" and ">>".

Revision 1.16  1993/02/12  15:35:57  matthew
Adding magic brackets tokens.
There should be a switch to lex as normal

Revision 1.15  1992/12/08  16:01:34  matthew
Hack to handle unclosed comments and strings

Revision 1.14  1992/12/02  17:23:48  matthew
Added newline in string error.

Revision 1.13  1992/11/05  15:29:53  matthew
Changed Error structure to Info

Revision 1.12  1992/08/31  17:00:54  richard
Replaced LexBasics error handler by proper global error stuff.

Revision 1.11  1992/08/19  14:02:08  davidt
Added the formfeed character to the list of whitespace characters.
Removed a silly bug which allowed '3' as a string formatting character.

Revision 1.10  1992/08/15  16:31:59  davidt
Modified to provide functions which accept lists of chars (ints)
instead of strings. Comments are now parsed much more quickly
since the regular expressions match more input in one go.

Revision 1.9  1992/08/14  08:33:48  clive
Fixed lexer to read in negative exponents

Revision 1.8  1992/08/07  15:47:05  davidt
String structure is now pervasive.

Revision 1.7  1992/08/05  14:43:54  jont
Removed some structures and sharing

Revision 1.6  1992/07/28  11:13:47  matthew
Changed string definition so that only escapes and printable characters are allowed.
An illegal string character acts as a terminator, rather than being ignored, so this
should catch unclosed strings.

Revision 1.5  1992/05/14  15:20:36  richard
Added IGNORE token to remove recursion from lexing of comments and strings.

Revision 1.4  1992/03/10  12:27:18  matthew
Changed errors to print message and continue rather than raise exception

Revision 1.3  1991/10/09  10:47:44  davidt
Changed definition because the lexers are now numbered from zero,
instead of one ie. !self 1 becomes !self 0 etc.

Revision 1.2  91/09/11  16:50:34  nickh
Added one or two things to make the syntax more legible (infix regexp
operators, for instance).

Revision 1.1  91/09/06  16:48:44  nickh
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

require "../utils/crash";
require "../utils/lists";
require "../basics/token";
require "../main/options";
require "../main/info";
require "regexp";
require "inbuffer";
require "lexrules";

require "../basis/__int";
require "^.basis.__string";

functor MLRules
  (structure Crash : CRASH
   structure Lists : LISTS
   structure Token : TOKEN
   structure RegExp : REGEXP
   structure InBuffer : INBUFFER
   structure Options : OPTIONS
   structure Info : INFO) : LEXRULES = 
struct 
  type options = Options.options
  structure InBuffer = InBuffer

  (* This should be an option really *)
  val new_definition = true

  local 

      (* one or two things to make the syntax bearable *)

    val || = RegExp.BAR
    val & = RegExp.DOT
    infix 0 ||
    infix 1 &

    val class = RegExp.CLASS
    val negClass = RegExp.negClass
    val star = RegExp.STAR
    val plus = RegExp.plusRE
    val node = RegExp.NODE

    val digit = RegExp.digit
    val hexDigit = RegExp.hexDigit
    val letter = RegExp.letter

    (* general things *)
      
    val alphanumeric = (class "_'") || digit || letter
    val symbol = class "!%&$#+-/:<=>?@\\~`^|*"
    val whitespace = plus(class " \n\t\012\013")
      
    (* things for ids *)
      
    val alpha_id = letter & star(alphanumeric)
    val symbolic_id = plus(symbol)
    val id = alpha_id || symbolic_id
    val long_id = id & star(node "." & id) & (node "." || RegExp.EPSILON)
      
    (* things for tyvars *)
      
    val alphas = star(alphanumeric)
    val tyvar = node "'" & alphas

    (* things for numbers *)
      
    val digits = plus(digit)
    val hexdigits = node "0x" & plus(hexDigit)
    val frac = (node "." & digits) || node "." (* Erroneous case *)
    val intnum = digits || (node "~" & digits)
    val intword = node "0w" & digits
    val hexintnum = hexdigits || (node "~" & hexdigits)
    val hexintword = node "0wx" & plus(hexDigit)
    val exp = node "E" & intnum
    val realnum = intnum & (frac || exp || (frac & exp))

    val implode_char = MLWorks.String.implode_char

    fun convert l = implode_char (rev l)

    fun location_file Info.Location.UNKNOWN = Crash.impossible "location_file"
    |   location_file (Info.Location.FILE f) = f
    |   location_file (Info.Location.LINE (f, _)) = f
    |   location_file (Info.Location.POSITION (f, _, _)) = f
    |   location_file (Info.Location.EXTENT {name, ...}) = name

    fun new_location (_, Info.Location.UNKNOWN) = Info.Location.UNKNOWN
    |   new_location (b, l) =
	  Info.Location.POSITION
	    (location_file l, InBuffer.getlinenum b, InBuffer.getlinepos b)
    
    fun newline_location (_, Info.Location.UNKNOWN) = Info.Location.UNKNOWN
    |   newline_location (b, l) =
	  Info.Location.POSITION
	    (location_file l,
	     InBuffer.getlinenum b - 1,
	     InBuffer.getlastlinepos b)
    
    fun extend_location (b, l) =
	  Info.Location.combine
	    (l, Info.Location.EXTENT {name = "", s_col = 0, s_line = 0,
				      e_line = InBuffer.getlinenum b,
				      e_col = InBuffer.getlinepos b})
  in
    structure RegExp = RegExp
    structure Symbol = Token.Symbol
    structure Info = Info
    type Result = Token.Token

    val eof = Token.EOF (Token.PLAIN_STATE)

    (* We read strings and comments locally, for efficiency.  When called
       from the shell after reading a line that ended in the middle of a
       string or comment, the lexer must call the appropriate function. *)

    (* We use comparisons of integer encodings, because comparing
     strings is expensive. *)

    val lparen = ord #"("
    val rparen = ord #")"
    val star = ord #"*"


    val depth' = ref 0

    fun read_comment (buffer, depth) =
      let
	val _ = depth' := depth
	(* Need to take care when placing handlers.
	 Don't lose tail-recursiveness. *)
	fun getchar b = InBuffer.getchar b

	fun aux (b, 0) = Token.IGNORE
	  | aux (b, n) =
            let
	      val c = getchar b
	    in
	      if c = lparen then do_lparen (b, n)
	      else if c = star then do_star (b, n)
		   else aux (b, n)
	    end

	  and do_lparen (b, n) =
            let
	      val c = getchar b
	    in
	      if c = star then (depth' := n+1;
				aux (b, n+1))
	      else if c = lparen then do_lparen (b, n)
		   else aux (b, n)
	    end

	  and do_star (b, n) =
            let
	      val c = getchar b
	    in
	      if c = star then do_star (b, n)
	      else if c = rparen then (depth' := n-1;
				       aux (b, n-1))
		   else aux (b, n)
	    end
      in
	aux (buffer, depth)
	handle InBuffer.Eof => Token.EOF (Token.IN_COMMENT (!depth'))
      end

(* string reading. There are various ways in which string reading can
 go wrong:

 1. an unescaped newline
 2. another unescaped character
 3. a \^c sequence, where c is outside the range 64--95
 4. a \dxy sequence, where one of xy is not a digit
 5. a \x sequence, where x is not n, t, ^, ", \, a format char or a digit (* \" *)
 6. a \fffffx sequence, where x is not \ or a format char
 7. Eof
 8. Numeric specification out of range (> 255).

We report an error for each of these (except Eof in a formatting
string, for the interactive lexer). In case 1, we stop reading and
return the current string (since the programmer has probably failed to
close it, and we don't want to read the rest of the file as a string.
In cases 2-6 we continue reading the string. In case 7, obviously, we
stop.

Nick Haines 06-Oct-93
*)

    fun format_char 32 = true	(* space *)
    |   format_char  9 = true	(* tab *)
    |   format_char 10 = true	(* newline *)
    |   format_char 12 = true	(* formfeed *)
    |   format_char 13 = true	(* return *)
    |   format_char c = false

    fun read_whitespace (location, buffer, error_info) =
      let
	val c = InBuffer.getchar buffer
      in
	if format_char c then
	  read_whitespace (location, buffer, error_info)
	else if c = ord #"\\" then
	  ()
	     else 
	       (Info.error
		error_info
		(Info.RECOVERABLE, new_location (buffer, location),
		 "Missing \\ after formatting characters in string");
		()) (* string reading error case 6 *)
      end

    fun is_digit c = c >= ord #"0" andalso c <= ord #"9"
    fun hexdigit c = 
      if is_digit c then 
	c-ord #"0"
      else if c>=ord #"a" andalso c<=ord #"f" then
	10+c-ord #"a"
      else if c>=ord #"A" andalso
	c<=ord #"Z" then
	10+c-ord #"A"
      else ~1
      
    fun read_string (location, buffer, error_info, so_far) =
      let
	val getchar = InBuffer.getchar

	fun read_digits (_, 0, b, location, c) = c
	  | read_digits (error_info, n, b, location, c) =
	    let
	      val c1 = getchar b
	    in
	      if is_digit c1 then
		read_digits
		(error_info, n - 1, b, location, 10 * c + c1 - ord #"0")
	      else
		(Info.error
		 error_info
		 (Info.RECOVERABLE, new_location (b, location),
		  "Malformed numeric character specification in string");
		 0) (* string reading error case 4 *)
	    end


	fun read_hexdigits (_, 0, b, location, acc) = acc
	  | read_hexdigits (error_info, n, b, location, (acc,chars)) =
	    let
	      val c1 = getchar b
              val d1 = hexdigit c1 (* = ~1 if error *)
	    in
	      if d1 <> ~1 then
		read_hexdigits
		(error_info, n-1, b, location, (16*acc+d1,c1::chars))
	      else
		(Info.error
		 error_info
		 (Info.RECOVERABLE, new_location (b, location),
		  "Malformed hex character specification in string");
		 (0,[])) (* string reading error case 4 *)
	    end
      
	fun printable c = c >= 32 andalso c <= 126	(* includes space *)

        val escapes = [(ord #"n",ord #"\n"),
                       (ord #"t",ord #"\t"),
                       (ord #"\"",ord #"\""),
                       (ord #"\\", ord #"\\"),
                       (* New ones *)
                       (ord #"a", 7),
                       (ord #"b", 8),
                       (ord #"v", 11),
                       (ord #"f", 12),
                       (ord #"r",13)]

        fun is_escape_char c =
          let
            fun mem [] = false
              | mem ((c',_)::rest) = c = c' orelse mem rest
          in
            mem escapes
          end

        fun get_escape_char c =
          let
            fun get [] = Crash.impossible "get_escape_char"
              | get ((c',x)::rest) =
                if c = c' then x else get rest
          in
            get escapes
          end

	fun aux (b, l) = 
	  let
	    val quote = ord #"\"" (* \" *)
	    val backslash = ord #"\\"
	    val newline = ord #"\n"
	    val c = getchar b
	  in
	    if c = quote then
	      Token.STRING (implode_char (rev (l @ so_far)))
	    else if c = backslash then
	      let
		val c' = getchar b
	      in
		if is_escape_char c' then aux (b, get_escape_char c' :: l)
		else
                  if c' = ord #"^" then
                    let
                      val c'' = getchar b
                    in
                      if c'' >= 64 andalso c'' <= 95 then
                        aux (b, (c'' - 64) :: l)
                      else
                        (Info.error
                         error_info
                         (Info.RECOVERABLE, new_location (b, location),
                          "Illegal character after \\^ in string, " ^
                          "ASCII " ^ Int.toString c'');
                         aux (b, l))
                    (* string reading error case 3 *)
                    end
                  else
                    if is_digit c' then
                      let
                        val c'' = read_digits (error_info, 2, b, location,
                                               c' - ord #"0")
                      in
                        if c'' >= 0 andalso c'' < 256 
                          then aux (b, c'' :: l)
                        else
                          (Info.error
                           error_info
                           (Info.RECOVERABLE, new_location (b, location),
                            "Out of range numeric character specification in string " ^
                            "\"\\" ^ Int.toString c'' ^ "\"");
                           aux (b,l)) (* string reading error case 8 *)
                      end
                    else
                      if c'= ord #"u" then
                        let
                          val (c'',charlist) = read_hexdigits 
                                      (error_info, 4, b, location, (0,[]))
                        in
                        if c'' >= 0 andalso c'' < 256 
                          then aux (b, c'' :: l)
                        else
                          (Info.error
                           error_info
                           (Info.RECOVERABLE, new_location (b, location),
                            "Out of range hexadecimal character specification\
                             \ in string " ^ "\"\\u" ^ 
                            (implode_char (rev charlist)) ^ "\"");
                           aux (b,l)) (* string reading error case 8 *)
                        end
                      else
                        if format_char c' then
                          (read_whitespace (location, b, error_info);
                           aux (b, l))
                          handle InBuffer.Eof =>
                            Token.EOF (Token.IN_STRING (l @ so_far))
                        else
                          (Info.error
                           error_info
                           (Info.RECOVERABLE, new_location (b, location),
                            "Illegal character after \\ in string, " ^
                            "ASCII " ^ Int.toString c');
                           aux (b, l)) (* string reading error case 5 *)
	      end
		 else
		   if c = newline then
		     (Info.error
		      error_info
		      (Info.RECOVERABLE, newline_location (b, location),
		       "Unexpected newline in string");
		      Token.STRING(implode_char (rev (l @ so_far))))
		     (* string reading error case 1 *)
		   else
		     if printable c then
		       (* Can do better here - get a substring from the buffer *)
		       aux (b, c :: l)
		     else
		       (Info.error
			error_info
			(Info.RECOVERABLE, new_location (b, location),
			 "Illegal character in string, ASCII " ^
			 Int.toString c);
			aux (b,l)) (* string reading error case 2 *)
	  end
      in
	aux (buffer, [])
	handle InBuffer.Eof =>
	  Info.error' error_info (Info.FATAL, extend_location (buffer, location),
				  "Unexpected end of string")
      end

    fun continue_string (location, buffer, error_info, so_far) =
      (read_whitespace (location, buffer, error_info);
       read_string (location, buffer, error_info, so_far))
      handle InBuffer.Eof => (*  can only be raised by read_whitespace *)
	Token.EOF (Token.IN_STRING so_far)

    fun read_char(arg as (location, buffer, error_info, so_far)) =
      let
	val str = case read_string arg of
	  Token.STRING s => s
	| _ => Crash.impossible"lexrules:read_string fails to return string"
      in
	if size str <> 1 then
	  Info.error' error_info (Info.RECOVERABLE, location,
				  "Character constant has wrong length string")
	else
	  Token.CHAR str
      end

    fun fix chars = Symbol.find_symbol(implode_char chars)

    fun split ([], chars, ids) = fix chars :: ids
      | split (c :: rest, chars, ids) =
	if c = ord #"." then
	  split(rest, [], fix chars :: ids)
	else split(rest, c :: chars, ids)

(*
    fun fix chars = Symbol.find_symbol(implode chars)

    fun split ([], chars, ids) = fix chars :: ids
      | split (c :: rest, chars, ids) =
	if c = ord #"." then
	  split(rest, [], fix chars :: ids)
	else split(rest, chr c :: chars, ids)
*)

    fun getLast ([], _) =
      Crash.impossible "lexrules.getLast"
      | getLast ([id], strids) = (rev strids, id)
      | getLast (strid :: rest, strids) =
	getLast(rest, strid :: strids)

    val symfuns = 
      map (fn (s,f) => (map ord (rev (explode s)),f))
      [("abstype",fn _ => Token.RESERVED (Token.ABSTYPE)),
       ("and",	fn _ => Token.RESERVED (Token.AND)),
	("andalso",fn _ => Token.RESERVED (Token.ANDALSO)),
	("as",	fn _ => Token.RESERVED (Token.AS)),
	("case",	fn _ => Token.RESERVED (Token.CASE)),
	("do",	fn _ => Token.RESERVED (Token.DO)),
	("datatype",fn _ => Token.RESERVED (Token.DATATYPE)),
	("else",	fn _ => Token.RESERVED (Token.ELSE)),
	("end",	fn _ => Token.RESERVED (Token.END)),
	("exception",fn _ => Token.RESERVED (Token.EXCEPTION)),
	("fn",	fn _ => Token.RESERVED (Token.FN)),
	("fun",	fn _ => Token.RESERVED (Token.FUN)),
	("handle",	fn _ => Token.RESERVED (Token.HANDLE)),
	("if",	fn _ => Token.RESERVED (Token.IF)),
	("in",	fn _ => Token.RESERVED (Token.IN)),
	("infix",	fn _ => Token.RESERVED (Token.INFIX)),
	("infixr",	fn _ => Token.RESERVED (Token.INFIXR)),
	("let",	fn _ => Token.RESERVED (Token.LET)),
	("local",	fn _ => Token.RESERVED (Token.LOCAL)),
	("nonfix",	fn _ => Token.RESERVED (Token.NONFIX)),
	("of",	fn _ => Token.RESERVED (Token.OF)),
	("op",	fn _ => Token.RESERVED (Token.OP)),
	("open",	fn _ => Token.RESERVED (Token.OPEN)),
	("orelse",	fn _ => Token.RESERVED (Token.ORELSE)),
	("raise",	fn _ => Token.RESERVED (Token.RAISE)),
	("rec",	fn _ => Token.RESERVED (Token.REC)),
	("require",fn options =>
                        case options of
			    Options.OPTIONS {
			      extension_options = Options.EXTENSIONOPTIONS {
			        require_keyword = true, ...
			      },
			    ...} => Token.RESERVED (Token.REQUIRE)
			  | _ => Token.LONGID ([],
					       Symbol.find_symbol "require")),
	("then",	fn _ => Token.RESERVED (Token.THEN)),
	("type",	fn _ => Token.RESERVED (Token.TYPE)),
	("val",	fn _ => Token.RESERVED (Token.VAL)),
	("with",	fn _ => Token.RESERVED (Token.WITH)),
	("withtype",fn _ => Token.RESERVED (Token.WITHTYPE)),
	("while",	fn _ => Token.RESERVED (Token.WHILE)),
	("eqtype",	fn _ => Token.RESERVED (Token.EQTYPE)),
	("functor",fn _ => Token.RESERVED (Token.FUNCTOR)),
	("include",fn _ => Token.RESERVED (Token.INCLUDE)),
	("sharing",fn _ => Token.RESERVED (Token.SHARING)),
	("sig",	fn _ => Token.RESERVED (Token.SIG)),
	("signature",fn _ => Token.RESERVED (Token.SIGNATURE)),
	("struct",	fn _ => Token.RESERVED (Token.STRUCT)),
	("structure",fn _ => Token.RESERVED (Token.STRUCTURE)),
	("where",
         fn options =>
         let
           val Options.OPTIONS
             {compat_options =
              Options.COMPATOPTIONS {old_definition, ...},...} =
             options
         in
           if old_definition
             then Token.LONGID ([],Symbol.find_symbol "where")
           else Token.RESERVED (Token.WHERE)
         end),
	("abstraction",
         fn options =>
         let
           val Options.OPTIONS
             {compat_options =
              Options.COMPATOPTIONS {abstractions, ...},...} =
             options
         in
           if abstractions
             then Token.RESERVED (Token.ABSTRACTION)
           else Token.LONGID ([],Symbol.find_symbol "abstraction")
         end),
	(":>",
         fn options =>
         let
           val Options.OPTIONS
             {compat_options =
              Options.COMPATOPTIONS {old_definition, ...},...} =
             options
         in
           if old_definition
             then Token.LONGID ([],Symbol.find_symbol ":>")
           else Token.RESERVED (Token.ABSCOLON)
         end),
	(":",	fn _ => Token.RESERVED(Token.COLON)),
	("|",	fn _ => Token.RESERVED(Token.VBAR)),
	("=",	fn _ => Token.RESERVED(Token.EQUAL)),
	("=>",	fn _ => Token.RESERVED(Token.DARROW)),
	("->",	fn _ => Token.RESERVED(Token.ARROW)),
	("#",	fn _ => Token.RESERVED(Token.HASH))]

    val max_length = 15
    val keywords = MLWorks.Internal.Array.array (max_length,[])

      (* NJ requires a type constrant here *)
      : (int list * (Options.options -> Token.Token)) list MLWorks.Internal.Array.array

    val _ =
      map
      (fn (data as (s,f)) =>
       let
         val len = length s
         val entry = MLWorks.Internal.Array.sub (keywords,len)
       in
         MLWorks.Internal.Array.update (keywords,len,data::entry)
       end)
      symfuns

    fun do_long_id s = 
      Token.LONGID(getLast (split(s, [], []), []))

    fun eqchars ([],[]) = true
      | eqchars ([],_::_) = false
      | eqchars (_::_,[]) = false
      | eqchars ((c:int)::rest,(c':int)::rest') = c = c' andalso eqchars (rest,rest')

    fun do_name_token (s,options) =
      let
        fun lookup [] = do_long_id s
          | lookup ((s',f)::rest) =
            if eqchars(s,s') then f options else lookup rest
        val len = length s
      in
        if len < max_length
          then lookup (MLWorks.Internal.Array.sub (keywords,len))
        else do_long_id s
      end

    fun make_tyvar (s,options) = 
      let
        val Options.OPTIONS {compat_options = Options.COMPATOPTIONS {old_definition,...},
                             ...} = options
        val name = convert s
	val sz = size name
        val is_eq = 
	  sz >= 2 andalso
	  String.sub(name, 1) = #"'"
        (* All variable are imperative with the new definition! *)
        val is_imp = 
          if old_definition then
	    if is_eq then
	      (sz >= 3) andalso 
	      String.sub(name, 2) = #"_"
	    else 
	      (sz >= 2) andalso 
	      String.sub(name, 1) = #"_"
	  else
            false
      in
        Token.TYVAR(Symbol.find_symbol name,is_eq,is_imp)
      end (* make_tyvar *)

    val rules =
       [(* numbers *)
	
	(intnum,		fn (_,_,s,_) => Token.INTEGER (convert s)),
	(hexintnum,		fn (_,_,s,_) => Token.INTEGER (convert s)),
	(intword,		fn (_,_,s,_) => Token.WORD (convert s)),

	(hexintword,		fn (_,_,s,_) => Token.WORD (convert s)),
        (* Check that we don't have a misplaced . here *)
	(realnum,
         fn (p,_,s,(error_info,options)) => 
         let
           fun check (#"." ::d::rest) = is_digit (ord d)
             | check [#"." ] = false
             | check (a::b) = check b
             | check [] = true
           val str = convert s
         in
           if check (explode str) then
	     ()
           else
             Info.error error_info
             (Info.RECOVERABLE,p,
              "Malformed real literal: " ^ str);
           Token.REAL (convert s)
         end),
	
	(* type variables *)
	
	(tyvar,			fn (_,_,s,(error_info,options)) => make_tyvar (s,options)),

	(* Symbolic keywords *)
        (* The following are not valid identifiers, so lex them separately *)
	(node "(",	fn _ => Token.RESERVED(Token.LPAR)),
	(node ")",	fn _ => Token.RESERVED(Token.RPAR)),
	(node "[",	fn _ => Token.RESERVED(Token.BRA)),
	(node "]",	fn _ => Token.RESERVED(Token.KET)),
	(node "{",	fn _ => Token.RESERVED(Token.LBRACE)),
	(node "}",	fn _ => Token.RESERVED(Token.RBRACE)),
	(node ",",	fn _ => Token.RESERVED(Token.COMMA)),
	(node ";",	fn _ => Token.RESERVED(Token.SEMICOLON)),
	(node "...",	fn _ => Token.RESERVED(Token.ELLIPSIS)),
	(node "_",	fn _ => Token.RESERVED(Token.UNDERBAR)),
        (* This ought to do something appropriate if dynamic option not set *)
	(node "#(", 
         fn (loc,_,_,(error_info, options)) => 
         case options of
           Options.OPTIONS 
           {extension_options = 
            Options.EXTENSIONOPTIONS 
            {type_dynamic = true, ...},...} => Token.RESERVED (Token.MAGICOPEN)
          | _ => 
              (Info.error
               error_info
               (Info.RECOVERABLE, loc,
                "Dynamic type bracket not valid with these options: replacing with left parenthesis");
               Token.RESERVED (Token.LPAR))),

	(* identifiers and keywords *)
	
        (long_id, fn (_,_,s,(_,options)) => do_name_token (s,options)),
	
	(* comments and strings *)
	
	(node "(*",	fn (loc,buf,_,(error_info, options)) =>
			  read_comment (buf,1)),

	(node "#\"",
	                fn (loc, buf, _, (error_info, _)) =>
			  read_char(loc, buf, error_info, [])),

        (node "\"",	fn (loc,buf,_,(error_info,_)) =>
			  read_string (loc,buf,error_info,[])),
	 
        (* whitespace *)
	 
	 (whitespace,	fn _ => Token.IGNORE)
         
	 ]

  end
	   
end

