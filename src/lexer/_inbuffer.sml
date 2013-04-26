(*
$Log: _inbuffer.sml,v $
Revision 1.23  1998/02/19 16:27:40  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.22  1996/10/30  15:48:55  io
 * moving String from toplevel
 *
 * Revision 1.21  1996/04/30  14:50:42  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.20  1995/06/08  14:44:53  daveb
 * Removed expansion of tabs.
 *
Revision 1.19  1994/03/08  16:36:58  daveb
Fixed previous log message.

Revision 1.18  1994/03/08  14:52:22  daveb
Minor improvements to locations.  First index of locations now
defined by values in Info.Location.

Revision 1.17  1993/11/29  12:56:12  matthew
Increment column number to next tab stop for a tab character.

Revision 1.16  1993/09/02  14:22:39  jont
Merging in bug fixes

Revision 1.15.1.2  1993/09/02  13:24:45  jont
Improvements to getsomemore to avoid string duplication

Revision 1.15.1.1  1993/04/01  09:38:52  jont
Fork for bug fixing

Revision 1.15  1993/04/01  09:38:52  daveb
Added a boolean eof parameter to mkLineInBuffer, for use with the
incremental parser.

Revision 1.14  1992/12/21  11:04:40  matthew
Change to allow token streams to be created with a given initial line number.

Revision 1.13  1992/11/19  14:52:53  matthew
Added flush_to_nl

Revision 1.12  1992/11/09  18:36:17  daveb
Added clear_eof function.

Revision 1.11  1992/10/14  11:21:44  richard
Added line number to token stream input functions.

Revision 1.10  1992/09/02  15:32:07  richard
Files now start with line 1.  (Oh well.)
Installed central error reporting mechanism.

Revision 1.9  1992/08/18  15:06:28  davidt
Major change which discards already used characters from the
input buffer only when more input is read in, and the buffer
would have to be copied anyway. Removed the forget and flush
functions which are now redundant.

Revision 1.8  1992/08/15  14:01:16  davidt
getChar now returns an integer, using MLWorks.String.ordof

Revision 1.7  1992/08/14  17:40:10  jont
Removed all currying from inbuffer

Revision 1.6  1992/08/07  15:44:50  davidt
String structure is now pervasive.

Revision 1.5  1992/05/19  17:10:59  clive
Fixed line position output from lexer

Revision 1.4  1992/04/02  11:15:21  matthew
Changed position so doesn't raise Eof when positioning to end of file

Revision 1.3  1992/03/23  15:27:30  matthew
Added line numbering

Revision 1.2  1992/01/27  14:43:40  jont
Added type constraints onto bp variables for the benefit of our compiler

Revision 1.1  1991/09/06  16:48:22  nickh
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

require "inbuffer";
require "../basics/location";

functor InBuffer (
  structure Location: LOCATION
) : INBUFFER =
  struct
    datatype InBuffer =
      INBUFFER of
        {buffer : string ref,		(* characters read from input *)
         lastpos : int ref,
         position : int ref,		(* position in buffer *)
         bs : int ref,			(* buffer start position *)
         ln : int ref,			(* line number *)
	 col : int ref,			(* column number *)
	 lastcol : int ref,		(* column of last newline lexed *)
	 eof : bool ref,		(* at end of file? *)
	 more : (int -> string)}	(* generating function *)


    (* eof is set if the generating function has generated an empty string
       (which appends a \n to the buffer).  Any read past the end of a stream
       raises Eof.  lastcol is used for the location of an erroneous newline
       in a string.  *)

    type StateEncapsulation = int * int
      
    exception Eof
    (* raised by any function that tries to read past the end of the stream *)

    exception Position
    (* raised by position if it tries to position before the start of the buffer *)

    exception Forget
    (* raised by forget if it tries to forget past the current position *)
    
    fun mkInBuffer (f) = INBUFFER
      {buffer = ref "", lastpos = ref 0, position = ref 0, bs = ref 0,
       ln = ref Location.first_line, col = ref Location.first_col,
       lastcol = ref Location.first_col, eof = ref false, more = f}

    fun mkLineInBuffer (f,line, eof) = INBUFFER
      {buffer = ref "", lastpos = ref 0, position = ref 0, bs = ref 0,
       ln = ref line, col = ref Location.first_col,
       lastcol = ref Location.first_col, eof = ref eof, more = f}

      (* getsomemore raises Eof if eof was already set. Otherwise it
       appends the next input to the buffer, returning false if there is no
       more input *)

    fun getsomemore (INBUFFER {buffer, lastpos, position, bs, eof, more, ln, ...}) =
      if (!eof) then
	raise Eof
      else
	let
	  val s = more (!ln)
	  val left = size(!buffer) - !lastpos
	  val some_more = size s <> 0
	  val next = if some_more then s else (eof := true; "")
	  val new =
	    if left = 0 then
	      next
	    else
	      substring (* could raise Substring *)(!buffer, !lastpos, left) ^ next
	in
	  bs := !bs + !lastpos; 
	  position := !position - !lastpos;
	  lastpos := 0;
	  buffer := new;
	  some_more
	end

    fun getpos (INBUFFER {position, bs, col, ...}) = (!position + !bs, !col)
    fun eof (INBUFFER {eof, ...}) = !eof
    fun clear_eof (ib as INBUFFER {eof, ...}) =
      (eof := false;
       ignore(getsomemore ib);
       ()
      )
       

    (* position raises Position if it attempts to read too far back, and
     Eof if too far forward. Otherwise it returns unit.*)

    fun setPosition (x as INBUFFER {buffer, lastpos, position, bs, ln, col, ...}, (n,charpos)) =
      let
        fun count_newlines (buffer,from,to) =
          let fun cnaux (b,f,t,res) =
            (* assume f <= t here *)
            if f = t then res
            else
              if MLWorks.String.ordof(b,f) = ord #"\n" then cnaux (b,f+1,t,res+1)
              else cnaux (b,f+1,t,res)
          in
            if from > to
              then ~(cnaux (buffer,to,from,0))
            else cnaux (buffer,from,to,0)
          end
        val bp = n - !bs
      in
	if bp < 0 then
	  raise Position
	else
	  if bp > size (!buffer) then
	    (ignore(getsomemore x); setPosition (x, (n,charpos)))
	  else
	    let
	      val deltalines = count_newlines (!buffer, !position, bp)
	    in
	      ln := !ln + deltalines;
	      col := charpos;
	      position := bp;
	      lastpos := bp
          end
      end

    val position = setPosition

    (* getchar: a straight-forward definition *)

    val tabsize = 8

    fun getchar (x as INBUFFER {buffer, position, ln, col, lastcol, ...}) =
      let
	val pos = !position
      in
	if pos >= size (!buffer) then
	  if getsomemore x then
	    getchar x
	  else
	    ord #"\n"	(* Dummy value.  Location info unchanged. *)
	else
	  (position := pos+1;
	   let
	     val char = MLWorks.String.ordof(!buffer,pos)
           in
             if char = ord #"\n" then
	       (ln := !ln + 1; lastcol := !col; col := Location.first_col)
             else
	       col := !col + 1;
	     char
           end)
      end

    fun getlinenum (INBUFFER {ln, ...}) = !ln
    fun getlinepos (INBUFFER {col, ...}) = !col
    fun getlastlinepos (INBUFFER {lastcol, ...}) = !lastcol

    fun flush_to_nl (b as (INBUFFER {buffer, position, eof,...})) =
      if (!eof)
        then ()
      else
        let val pos = !position
        in
          if pos > 0 andalso pos-1 < size(!buffer) andalso MLWorks.String.ordof(!buffer,pos-1) = ord #"\n"
            then ()
          else
            while (getchar b) <> ord #"\n"
              do ()
        end
  end
