(* inthashtable the signature *)
(*
$Log: inthashtable.sml,v $
Revision 1.4  1997/05/01 12:57:49  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.3  1996/10/03  09:36:40  matthew
 * Generalizing type of map
 *
 * Revision 1.2  1995/01/03  16:48:06  matthew
 * Sorting out type names
 *
 * Revision 1.1  1994/09/23  14:49:21  matthew
 * new file
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
 *)

signature INTHASHTABLE =
  sig
    type '_a T
    exception Lookup 
    val new     : int -> '_a T
    val lookup  : ('_a T * int) -> '_a
    val lookup_default  : ('_a T * '_a * int) -> '_a
    val tryLookup : ('_a T * int) -> '_a option
    val is_defined : ('_a T * int) -> bool
    val update  : ('_a T * int * '_a) -> unit
    val delete  : ('_a T * int) -> unit
    val to_list : '_a T -> (int * '_a) list
    val copy    : '_a T -> '_a T
    val map     : (int * '_a -> '_b) -> '_a T -> '_b T
    val fold    : ('b * int * '_a -> 'b) -> ('b * '_a T) -> 'b
    val iterate : (int * '_a -> unit) -> '_a T -> unit
    val stats : '_a T -> {size:int, count:int, smallest:int, largest:int}
    val print_stats : '_a T -> unit
  end
