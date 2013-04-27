(*  ==== INITIAL BASIS :  LIST-PAIRS ====
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
 *  $Log: list_pair.sml,v $
 *  Revision 1.1  1996/04/18 11:43:18  jont
 *  new unit
 *
 * Revision 1.1  1996/04/18  11:43:18  jont
 * new unit
 *
 *  Revision 1.2  1996/03/20  13:02:28  stephenb
 *  Bring up to date with version 1.0 dated 1/1996 in March 12th 1996 draft.
 *  Added foldl and foldr
 *
 *  Revision 1.1  1995/03/16  21:19:54  brianm
 *  new unit
 *  reanmed from list-pairs.sml
 *
 *
 *)


signature LIST_PAIR =
  sig

    val zip    : ('a list * 'b list) -> ('a * 'b) list
    val unzip  : ('a * 'b) list -> ('a list * 'b list)
    val map    : ('a * 'b -> 'c) -> ('a list * 'b list) -> 'c list
    val app    : ('a * 'b -> unit) -> ('a list * 'b list) -> unit
    val foldl  : (('a * 'b * 'c) -> 'c) -> 'c -> ('a list * 'b list) -> 'c
    val foldr  : (('a * 'b * 'c) -> 'c) -> 'c -> ('a list * 'b list) -> 'c
    val all    : ('a * 'b -> bool) -> ('a list * 'b list) -> bool
    val exists : ('a * 'b -> bool) -> ('a list * 'b list) -> bool

  end (* signature LIST_PAIR *)
