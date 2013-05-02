(*  ==== INITIAL BASIS : LISTS ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: list.sml,v $
 *  Revision 1.3  1997/05/27 14:27:16  matthew
 *  Adding datatypes
 *
 *  Revision 1.2  1996/10/03  15:21:53  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/04/18  11:43:25  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:43:25  jont
 * new unit
 *
 *  Revision 1.3  1996/03/20  11:04:26  stephenb
 *  Bring up to date with respect to version 1.3 dated 10/1995.
 *  Added take and drop
 *  Removed nthTail
 *
 *  Revision 1.2  1995/04/07  14:38:45  jont
 *  Add require of general
 *
 * Revision 1.1  1995/03/08  16:23:59  brianm
 * new unit
 * No reason given
 *
 *)

signature LIST =
  sig

    datatype list = datatype list

    exception Empty

    val null : 'a list -> bool 

    val length : 'a list -> int 

    val @ : 'a list * 'a list -> 'a list

    val hd : 'a list -> 'a                (* raises Empty *)

    val tl : 'a list -> 'a list           (* raises Empty *)

    val last : 'a list -> 'a                (* raises Empty *)

    val nth : 'a list * int -> 'a           (* raises Subscript *)

    val take : ('a list * int ) -> 'a list

    val drop : ('a list * int ) -> 'a list

    val rev : 'a list -> 'a list 

    val concat : 'a list list -> 'a list

    val revAppend : 'a list * 'a list -> 'a list

    val app : ('a -> unit) -> 'a list -> unit

    val map : ('a -> 'b) -> 'a list -> 'b list

    val mapPartial : ('a -> 'b option) -> 'a list -> 'b list

    val find : ('a -> bool) -> 'a list -> 'a option

    val filter    : ('a -> bool) -> 'a list -> 'a list

    val partition : ('a -> bool ) -> 'a list -> ('a list * 'a list)

    val foldl : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b

    val foldr : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b

    val exists : ('a -> bool) -> 'a list -> bool

    val all    : ('a -> bool) -> 'a list -> bool

    val tabulate : (int * (int -> 'a)) -> 'a list   (* raises Size *)

  end (* signature LIST *)
