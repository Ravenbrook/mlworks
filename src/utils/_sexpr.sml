(* _sexpr.sml the functor *)
(*
$Log: _sexpr.sml,v $
Revision 1.7  1996/10/28 14:43:44  io
moving String from toplevel

 * Revision 1.6  1996/08/09  13:18:51  io
 * add toList for MIPS mach_cg
 *
 * Revision 1.5  1996/05/07  10:49:46  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.4  1992/08/07  16:20:59  davidt
 * Took out String structure argument.
 *
Revision 1.3  1992/02/14  13:47:47  jont
Added string parameter to functor

Revision 1.2  1991/11/21  17:02:31  jont
Added copyright message

Revision 1.1  91/06/07  15:57:36  colin
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

require "sexpr";

(* For Lisp lovers *)

functor Sexpr () : SEXPR =
  struct

    datatype 'a Sexpr = NIL | ATOM of 'a | CONS of 'a Sexpr * 'a Sexpr

    fun list nil = NIL
      | list (hd::tl) = CONS (hd,list tl)

    exception Append
    
    fun append (NIL,x) = x
      | append (CONS (car,cdr), x) = CONS (car, append (cdr,x))
      | append (ATOM _,_) = raise Append

    fun printSexpr printer sexpr =
      let 
	fun printexp NIL = "()"
	  | printexp (ATOM a) = printer a
	  | printexp (CONS (car,cdr)) = "(" ^ printexp car ^ printrest cdr
	
	and printrest NIL = ")"
	  | printrest (ATOM a) = " . " ^ printer a ^ ")"
	  | printrest (CONS (car,cdr)) = " " ^ printexp car ^ printrest cdr
      in
	printexp sexpr
      end

    fun pprintSexpr printer sexpr =
      let
	fun spaces 0 = ""
	  | spaces n = " " ^ spaces (n-1)

	val spaces40 = spaces 40

	val indents =
	  MLWorks.Internal.Array.arrayoflist ["\n" ^ spaces40,
			       "\n>" ^ spaces40,
			       "\n>>" ^ spaces40,
			       "\n>>>" ^ spaces40,
			       "\n>>>>" ^ spaces40,
			       "\n>>>>>" ^ spaces40,
			       "\n>>>>>>" ^ spaces40,
			       "\n>>>>>>>" ^ spaces40]

	exception Indent

	fun indent s = 
	  let 
	    val a = s div 40
	    val b = s mod 40
	  in
	    if a > 7 then
	      raise Indent
	    else
	      substring (* could raise Substring *) (MLWorks.Internal.Array.sub(indents,a),0,a+b+1)
	  end

	fun pprintexp (NIL,_) = "()"
	  | pprintexp (ATOM a,_) = printer a
	  | pprintexp (CONS (car,cdr),n) =
	    indent n ^ "(" ^ pprintexp (car,n+1) ^ pprintrest (cdr,n+1)

	and pprintrest (NIL,_) = ")"
	  | pprintrest (ATOM a,_) = " . " ^ printer a ^ ")"
	  | pprintrest (CONS (car,cdr),n) = 
	    " " ^ pprintexp (car,n) ^ pprintrest (cdr,n)
      in
	pprintexp (sexpr,0)
      end

    (* flattens a list of lists
     * so far used in mips mach_cg only
     *)
    fun toList arg = 
      let 
	fun toList (CONS (xs, ys), zs, acc) = toList (xs, ys::zs, acc)
	  | toList (NIL, [], acc) = 
	    (* rev acc *)
	  foldl (op@) [] acc
	  | toList (NIL, x::xs, acc) = toList (x, xs, acc)
	  | toList (ATOM x, xs, acc) = toList (NIL, xs, x::acc)
      in
	toList (arg, [], [])
      end
  end
