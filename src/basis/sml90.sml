(* This signature specifies the top-level items in the 1990 Definition Of
 * Standard ML that were removed by the revised basis.  Opening a matching
 * structure should enable almost any code written for the original
 * Definition to be compiled.
 *
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
 * $Log: sml90.sml,v $
 * Revision 1.2  1997/09/19 10:01:50  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *  Revision 1.1  1996/05/30  16:10:23  daveb
 *  new unit
 *  Backwards compatibility.
 *
 *
 *)

signature SML90 =
sig
  type instream
  type outstream

  exception Ord
  exception Io of string

  (* The following exceptions are all aliases for Overflow *)
  exception Abs
  exception Quot
  exception Prod
  exception Neg
  exception Sum
  exception Diff
  exception Floor

  (* The following exceptions never in fact occur *)
  exception Sqrt
  exception Exp
  exception Ln

  (* The following exception is a synonym of Div *)
  exception Mod

  (* The following exception is raised when ... *)
  exception Interrupt

  val sqrt: real -> real
  val sin: real -> real
  val cos: real -> real
  val arctan: real -> real
  val exp: real -> real
  val ln: real -> real
  val chr: int -> string
  val ord: string -> int
  val explode: string -> string list
  val implode: string list -> string

  val std_in: instream
  val open_in: string -> instream
  val input: instream * int -> string
  val lookahead: instream -> string
  val close_in: instream -> unit
  val end_of_stream: instream -> bool

  val std_out: outstream
  val open_out: string -> outstream
  val output: outstream * string -> unit
  val close_out: outstream -> unit
end

