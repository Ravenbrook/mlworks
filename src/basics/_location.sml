(* _location.sml the functor *)
(*
$Log: _location.sml,v $
Revision 1.18  1997/03/06 16:03:13  jont
[Bug #1938]
Remove __pre_basis from require list

 * Revision 1.17  1996/11/06  10:51:21  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.16  1996/11/04  15:56:55  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.15  1996/10/18  18:08:38  io
 * moving String from toplevel
 *
 * Revision 1.14  1996/08/05  13:11:04  stephenb
 * [Bug #1510]
 * extract_components: fixed bug which stopped the device being
 * identified -- this was due to a test of the form
 * c >= "a" andalso c <= "a" where the second "a" should obviously
 * be "z".  Didn't fix this directly, instead replaced all the
 * MLWorks.String.* functions with higher level ones from the Basis
 * such as Char.isAlpha.
 *
 * Revision 1.13  1996/05/30  12:00:38  daveb
 * The Ord exception is no longer at top level.
 *
 * Revision 1.12  1996/05/15  16:30:45  matthew
 * Removing diagnostics
 *
 * Revision 1.11  1996/05/15  14:22:58  matthew
 * Adding Windows device name parser thingy
 *
 * Revision 1.10  1996/04/30  17:32:09  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.9  1996/04/29  16:16:42  matthew
 * Removing utils/integer.sml
 *
 * Revision 1.8  1996/02/21  11:59:50  jont
 * Add file_of_location to extract the filename part of a location
 *
 * Revision 1.7  1996/02/02  12:35:50  daveb
 * Made extract handle POSITION case.
 *
Revision 1.6  1996/01/15  16:47:09  daveb
Added extract function.

Revision 1.5  1994/10/04  12:28:32  matthew
Added result signature

Revision 1.4  1994/03/08  14:40:30  daveb
Stopped printing of zero-length ranges as, e.g., 2,1 to 2,1.
Added first_col and first_line.

Revision 1.3  1993/04/15  16:30:16  matthew
Added a function to parse a string representing a location

Revision 1.2  1993/01/14  15:31:15  jont
Added a range type to Location.T

Revision 1.1  1992/09/04  08:24:15  richard
Initial revision

Copyright (C) 1992 Harlequin Ltd
*)
require "^.basis.__int";
require "^.basis.__char";
require "^.basis.__string";
require "location";

functor Location () : LOCATION =
  struct
    datatype T =
      FILE of string
      | LINE of string * int
      | POSITION of string * int * int
      | EXTENT of {name:string, s_line:int, s_col:int, e_line:int, e_col: int}
      | UNKNOWN
    
    val unknown_string = "unknown location"
    val unknown_size = size unknown_string

    val first_line = 1
    val first_col = 1

    fun to_string UNKNOWN = unknown_string
      | to_string (FILE name) = name
      | to_string (LINE (name, line)) =
      concat [name, ":", Int.toString line]
      | to_string (POSITION (name, line, column)) =
      concat [name, ":", Int.toString line, ",", Int.toString column]
      | to_string
      (EXTENT{name:string, s_line:int, s_col:int, e_line:int, e_col: int}) =
      if s_line = e_line andalso (s_col >= e_col - 1) then
	concat [name, ":", Int.toString s_line, ",", Int.toString s_col]
      else
	concat [name, ":", Int.toString s_line, ",",
		Int.toString s_col, " to ", Int.toString e_line,
		",", Int.toString
		(if e_col = first_col then first_col else e_col - 1)]


    fun parse_string (delimiters, s) = 
      let
	val sz = size s
	fun isPrefix (x,offset, s) = 
	  let val szx = size x
	    fun scan i = 
	      if i < szx then
		String.sub(x, i) = String.sub(s, i+offset) andalso
(*
		unsafe_string_char_sub (x, i) = unsafe_string_char_sub (s, i+offset) andalso
*)
		scan (i+1)
	      else
		true
	  in
	    scan 0
	  end (* isPrefix *)
        fun subp (sub,index) =
          let
            val subsize = size sub
            fun aux (index) =
              if (index + subsize <= sz) then
		if isPrefix (sub, index, s) then
		  index
		else
		  aux (index+1)
	      else
		~1
	  in
	    aux index
	  end (* subp *)
	fun scan (delim::l, index, acc) = 
	  (case subp (delim, index) of
	     ~1 => String.substring(s, index, sz-index) :: acc
	   | n => scan (l, n+size delim, String.substring(s, index, n-index)::acc))
	  | scan ([], index, acc) = 
	  if index < sz then
	    String.substring(s, index, sz-index) :: acc
	    else acc
      in
	rev (scan (delimiters, 0, []))
      end (* parseString *)


    exception InvalidLocation

    (* Need this vileness to cope with device names in PC locations
     *
     * As far as I the device is just a letter followed by colon i.e.
     * it is of the form  "[A-Za-z]:".  However, the following also
     * checks to make sure that the character following the colon
     * is not a digit.  Don't know what that check is for - stephenb
     *)
    fun extract_components s =
      let
        val (device,rest) =
          if      size s >= 3
          andalso Char.isAlpha (String.sub (s, 0))
          andalso String.sub (s, 1) = #":"
          andalso not (Char.isDigit (String.sub (s, 2)))
          then
            (substring (s, 0, 3), substring (s, 3, size s - 3))
          else
            ("",s)
      in
        case parse_string ([":", ",", " to ", ","],rest) of 
          [] => []
        | (name::stuff) => device ^ name ::stuff
      end

    exception InvalidInt
    fun getint s = 
      case Int.fromString s of
        SOME n => n
      | _ => 
          ((* MLWorks.IO.output (MLWorks.IO.terminal_out,"Invalid int " ^ s ^"\n"); *)
           raise InvalidInt)

    fun from_string s =
      if String.isPrefix unknown_string s then
	UNKNOWN
      else
        (* look for a filename and any other components *)
        (case extract_components s of
           [name] => FILE name
         | [name,line] => LINE(name,getint line)
         | [name,line,column] =>
             POSITION(name,
                      getint line,
                      getint column)
         | [name,s_line,s_col,e_line,e_col] =>
             EXTENT {name = name,
                     s_line = getint s_line,
                     s_col = getint s_col,
                     e_line = getint e_line,
                     e_col = getint e_col}
         | _ => ((* MLWorks.IO.output (MLWorks.IO.terminal_out,"Invalid location 1 " ^ s ^"\n"); *)
                 raise InvalidLocation))
           handle InvalidInt => ((* MLWorks.IO.output (MLWorks.IO.terminal_out,"Invalid location 2 " ^ s ^"\n"); *)
                                 raise InvalidLocation)
               

    fun combine(EXTENT{name, s_line, s_col, ...}, EXTENT{e_line, e_col, ...}) =
      EXTENT{name=name, s_line=s_line, s_col=s_col, e_line=e_line, e_col=e_col}
      | combine(t, _) = t (* Don't really care about this *)

    local
      (* input: number of lines to advance * start position.
           returns: position of first character of nth line. *)
      fun n_lines (str, 1, pos) = pos
      |   n_lines (str, n, pos) =
        if MLWorks.String.ordof (str, pos) = ord #"\n" then
          n_lines (str, n-1, pos+1)
        else
          n_lines (str, n, pos+1)
        handle
          MLWorks.String.Ord => size str - 1

    in
      fun extract (EXTENT {s_line, s_col, e_line, e_col, ...}, str) =
        let
          val s_pos = n_lines (str, s_line, 0) + s_col - 1;
  
          val e_pos =
            if s_line = e_line then
	      if e_col = s_col then
                s_pos + 1
	      else
                s_pos + e_col - s_col
            else
              n_lines (str, e_line - s_line + 1, s_pos) + e_col - 1
        in
          (s_pos, e_pos)
        end
      |   extract (POSITION (_, col, line), str) =
        let
          val pos = n_lines (str, line, 0) + col - 1
	in
	  (pos, pos + 1)
	end
      |   extract (loc,_) = 
          ((* MLWorks.IO.output (MLWorks.IO.terminal_out,"Invalid location 3 " ^ to_string loc ^"\n"); *)
           raise InvalidLocation)
    end

    fun file_of_location(FILE name) = name
      | file_of_location(LINE(name, _)) = name
      | file_of_location(POSITION(name, _, _)) = name
      | file_of_location(EXTENT{name, ...}) = name
      | file_of_location UNKNOWN = ""

  end

