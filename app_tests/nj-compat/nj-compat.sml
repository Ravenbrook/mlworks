(*
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
 * Compatibility file for old style New Jersey applications
 *
 * $Log: nj-compat.sml,v $
 * Revision 1.5  1998/06/11 09:39:16  jont
 * [Bug #70127]
 * Add List.fold for mwb
 *
 *  Revision 1.4  1998/06/08  16:44:01  jont
 *  [Bug #70127]
 *  Add exception Nth
 *
 *  Revision 1.3  1998/06/02  11:16:05  jont
 *  [Bug #70127]
 *  Modifications for cwb
 *
 *  Revision 1.2  1998/06/01  10:00:50  jont
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

structure String = MLWorks.String

fun makestring n =
  let
    fun makeDigit digit =
      if digit >= 10 then chr (ord #"A" + digit - 10)
      else chr (ord #"0" + digit)
    val sign = if n < 0 then "~" else ""
    fun makeDigits (n,acc) =
      let
        val digit = 
          if n >= 0 
            then n mod 10
          else 
            let
              val res = n mod 10
            in
              if res = 0 then 0 else 10 - res
            end
        val n' = 
          if n >= 0 orelse digit = 0 then 
            n div 10
          else 1 + n div 10
        val acc' = makeDigit digit :: acc
      in 
        if n' <> 0
          then makeDigits (n',acc')
        else acc'
      end
  in
    sign^(implode (makeDigits (n,[])))
  end

val substring = String.substring
val implode = String.implode
val explode = String.explode

val flush_out = TextIO.flushOut
val input_line = TextIO.inputLine;
val input = TextIO.inputN;
val std_err = TextIO.stdErr;
val std_out = TextIO.stdOut;
val std_in = TextIO.stdIn;
val output = TextIO.output
val end_of_stream = TextIO.endOfStream
val open_in = TextIO.openIn
val close_in = TextIO.closeIn
val open_out = TextIO.openOut
val close_out = TextIO.closeOut
type instream = TextIO.instream
type outstream = TextIO.outstream

val ordof = String.ordof;

open MLWorks.Internal.Array;

val length = List.length

infix quot

val op quot = op div : int * int -> int

exception Revfold
fun fold f [] x = x | fold f (a::b) x = f (a, (fold f b x));
fun revfold f l x = fold f (rev l) x
  
exception OpenString
(*
fun open_string s = 
  let
    val sref = ref (explode s)
    fun get (n,[],acc) = (implode (rev acc),[])
      | get (0,l,acc) = (implode (rev acc),l)
      | get (n,(a::b),acc) = get(n-1,b,a::acc)
    fun input n =
      let val (result,rest) = get (n,!sref,[])
      in
        sref := rest;
        result
      end
    fun lookahead () =
      case !sref of
        (a::b) => a
      | _ => ""
    fun end_of_stream () =
      case !sref of
        [] => true
      | _ => false
  in
    MLWorks.IO.instream{input = input,
                        lookahead = lookahead,
                        end_of_stream = end_of_stream,
                        clear_eof = fn () => (),
                        closed_in = fn _ => false,
                        close_in = fn () => ()}
  end
*)

exception UseStream
fun use_stream _ = raise UseStream

fun inc n = n := (!n + 1)
fun dec n = n := (!n - 1)
fun null [] = true
  | null _ = false

exception Hd
exception Tl

fun hd [] = raise Hd
  | hd (a::b) = a
fun tl [] = raise Tl
  | tl (a::b) = b
  

fun bool_makestring true = "true"
  | bool_makestring false = "false"

structure List =
  struct
    open List
    val fold = fold
  end;
val rem = op mod : int * int -> int
infix 9 rem
fun outputc stream value = TextIO.output(stream, value)
val exists = List.exists

val truncate = floor

val nth = List.nth;
fun nthtail(x, n) =
 if n < 0 then
   raise Match
 else
   if n = 0 then x
   else
     case x of
       [] => raise Match
     | _ :: xs => nthtail(xs, n-1)

val app = List.app

fun min (n:int,m:int) = if n < m then n else m
fun max (n:int,m:int) = if n > m then n else m

structure String =
  struct
    open MLWorks.String
    val size = size
    val length = size
  end


structure System =
  struct
    fun argv () = ["foo","bar","baz","boo"]
    exception Environ
    fun environ x = raise Environ
    fun exn_name x = MLWorks.Internal.Value.exn_name x

    structure Unsafe =
      struct
        exception BlastRead
        fun blast_read x = raise BlastRead
        exception BlastWrite
        fun blast_write x = raise BlastWrite
        structure CInterface =
          struct
            fun system (s : string) = 0
            exception SysError of int * string
          end
      end
    structure Control =
      struct
        structure Print =
          struct
            type outstream = TextIO.outstream
            val printDepth = ref 10
            val printLength = ref 10
            val stringDepth = ref 10
            val printLoop = ref false
            val signatures = ref 10
            val pathnames = ref 10
            val out =  ref TextIO.stdOut
            val linewidth = ref 10
            fun say s = TextIO.output (!out,s)
            fun flush () = TextIO.flushOut (!out)
            val printLength = ref 20;
          end
        val unittounit = fn () => ()
        val allocProfReset = unittounit
        val allocProfPrint = unittounit
        val prLambda = ref unittounit
        val debugging = ref true
        val primaryPrompt = ref ""
        val secondaryPrompt = ref ""
        val internals = ref true
        val weakUnderscore = ref true
        val interp = ref true
        val debugLook = ref true
        val debugCollect = ref true
        val debugBind = ref true
        val saveLambda = ref true
        val saveLvarNames = ref true
        val timings = ref true
        val reopen = ref true
        val markabsyn = ref true
        val indexing = ref true
        val instSigs = ref true
        val quotation = ref true
      end
  end;

exception Pp
fun pp _ _ = (print "Calling pp\n"; "");

fun exportFn (s,_) = print ("Exporting " ^ s ^ "\n");
fun exportML s = print "Exporting executables not supported\n"

val system: string -> unit =
  fn s => (ignore(MLWorks.Internal.Runtime.environment "system os system" s);())

exception Chr=String.Chr
exception Ord=String.Ord

val ord = String.ord
val chr = String.chr
val ordof = String.ordof
val substring = String.substring

structure Bits = MLWorks.Internal.Bits
structure Array = MLWorks.Internal.Array
structure Vector = MLWorks.Internal.Vector
exception Interrupt = MLWorks.Interrupt
exception Mod

exception Io = IO.Io

exception Nth
