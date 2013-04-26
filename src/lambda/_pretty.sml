(*****************************************)
(* _pretty.sml - A Simple Pretty-Printer *)
(*****************************************)

(* $Log: _pretty.sml,v $
 * Revision 1.15  1996/10/10 04:38:08  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.14  1996/04/30  16:12:11  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.13  1993/01/06  13:10:12  jont
 * Removed string_of_T and recoded in terms of simplified reduce
 *
Revision 1.12  1993/01/05  19:02:57  jont
 Added functions to print directly to a supplied stream

Revision 1.11  1992/12/10  13:11:18  jont
Rewrote reduce in a more functional and simpler style. It now prints
signatures sensibly at last.

Revision 1.10  1992/12/03  10:24:51  matthew
Fixed bug in reduce

Revision 1.9  1992/09/24  14:22:27  richard
Added reduce.

Revision 1.8  1992/06/16  10:39:50  davida
Faster printing scheme.

Revision 1.7  1992/02/14  13:37:15  jont
Added a type specifier to disambiguate overloaded operation

Revision 1.6  1991/11/21  19:28:21  jont
Added some brackets to keep njml 0.75 happy

Revision 1.5  91/10/22  12:48:58  davidt
Replaced impossible exception with Crash.impossible calls.

Revision 1.4  91/08/06  13:57:21  davida
Removed line-spill prefix 'cos it was a mess.

Revision 1.3  91/08/06  12:20:12  davida
Added hack to produce an immediate printing from
pretty-print trees.  This could do with tidying up
a bit...

Revision 1.2  91/07/22  15:02:40  davida
Tidied up newline behaviour, and added a hack to cope
with lines that are too long.  Not really satisfactory,
but this is only intended for development purposes...

Revision 1.1  91/07/19  13:54:51  davida
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/crash";
require "pretty";

functor PrettyFun (structure Crash : CRASH) : PRETTY =
 struct

  (* Print Items *)

  datatype T = Block of T list * int * int	(* indentation, length *)
    	     | String of string
             | Break of int			(* length *)
    	     | Newline;
      
  val margin = ref 78;

  fun list_of(n, char) =
    let
      fun sub_fun(n, acc) =
	if n <= 0 then acc
	else sub_fun(n-1, char :: acc)
    in
      sub_fun(n, [])
    end

  fun spaces n = implode(list_of(n, #" "))

  fun reduce f (result, indent, T) =
    let 
      val prefix = spaces indent
      val result = f (result, prefix)
      val end_of_line = !margin

      fun string(result, [], used, empty, prefix) = (result, empty, used)
	| string(result, T :: TS, used, empty, prefix) =
	  let
	    val (result, empty, used) = case T of
	      String s =>
		(f(result, s), false, used + size s)
	    | Break len =>
		if len + used > end_of_line then
		  (f(result, "\n" ^ prefix), true, size prefix)
		else
		  let
		    val space = spaces len
		  in
		    (f(result, space), empty, used + len)
		  end
	    | Newline =>
		(f(result, "\n" ^ prefix), true, size prefix)
	    | Block(TS, indent, _) =>
		let
		  val space = spaces indent
		  val prefix' = prefix ^ space
		in
		  string(if empty then f(result, space) else result,
			   TS, used, empty, prefix')
		end
	  in
	    string(result, TS, used, empty, prefix)
	  end
    in
      #1(string(result, [T], indent, true, prefix))
    end


  fun string_of_T T = reduce (op^) ("", 0, T)

  fun print_T print_fn T = reduce (fn ((), s) => print_fn s) ((), 0, T)

  val str = String
  and brk = Break
  and nl = Newline;

  fun blk (indent,Ts) =
    let 
        fun max (m,[]) = m
          | max (m:int, i::is) = if i>m then max(i,is) else max(m,is)
	  
        fun length ([],k::ks) = max (k,ks)
          | length (Block(_,_,len)::Ts,k::ks) = length(Ts,(k+len)::ks)
          | length ((String s)::Ts,k::ks) = length(Ts,((size s)+k)::ks)
          | length ((Break len)::Ts,k::ks) = length(Ts,(len+k)::ks)
          | length (Newline::Ts,ks) = length(Ts, 0::ks)
          | length _ = Crash.impossible "Pretty.blk";
    in  
      Block(Ts,indent, length(Ts,[0]) )
    end

  fun lst(lp,sep,rp) ts =
    let 
      fun list [] = []
        | list [T] = [T]
        | list (T::Ts) = T :: (sep @ (list Ts))
    in 
      (str lp) :: ((list ts) @ [str rp])
    end

 end;
