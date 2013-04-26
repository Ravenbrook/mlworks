(*
 *
 * $Log: interface.fun,v $
 * Revision 1.2  1998/06/03 12:16:49  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Externally visible aspects of the lexer and parser *)

functor Interface () : INTERFACE =
struct

  type pos = int
  datatype region = Region of {from : int * int, to : int * int}

  local 
      val line = ref 1   (* number of line currently scanned *)
      val newlines = ref (nil:pos list)  (* list of positions of newlines *)
      (* invariant: length (!bols) + 1 = !line *)
  in
    fun init_line (iline) = ( line := iline ; newlines := nil )
    fun next_line (pos) = ( line := !line + 1 ; 
			    newlines := pos :: !newlines )
    fun last_newline () =
	   (case (!newlines)
	      of nil => 0
               | (pos::_) => pos)
    val dummy_pos = 0
    fun search_pos (pos:pos, line, nil) = (line, pos)
      | search_pos (pos:pos, line, newline_pos::rest) =
	  if pos > newline_pos
	     then (line, pos-newline_pos)
	     else search_pos (pos, line-1, rest)
    fun region (lpos,rpos) =
	  Region {from = search_pos (lpos,!line,!newlines),
		  to = search_pos (rpos,!line,!newlines)}
    fun makestring_region (Region {from = (lline,lcol), to = (rline,rcol)}) =
	  (makestring lline) ^ "." ^ (makestring lcol)
	  ^ "-" ^ (makestring rline) ^ "." ^ (makestring rcol)
	   
    fun error (errmsg,lrpos) =
      print ("Line " ^ (makestring_region (region lrpos)) ^ ": "
	     ^ errmsg ^ "\n")
  end

end  (* functor Interface *)
