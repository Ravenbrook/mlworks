(*  ==== INITIAL BASIS :  GENERAL ====
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
 *  $Log: general.sml,v $
 *  Revision 1.4  1997/08/04 12:39:36  brucem
 *  [Bug #30084]
 *  Remove items which have been moved to Option.
 *
 * Revision 1.3  1996/05/08  14:53:41  jont
 * Update to latest revision
 *
 * Revision 1.2  1996/04/23  13:05:43  matthew
 * Updating
 *
 * Revision 1.1  1996/04/18  11:42:57  jont
 * new unit
 *
 *  Revision 1.4  1996/03/28  12:29:02  matthew
 *  Fixing rigid type sharing problem
 *
 *  Revision 1.3  1995/03/31  13:44:07  brianm
 *  Adding options operators to General ...
 *
 * Revision 1.2  1995/03/12  18:49:24  brianm
 * Commented out troublesome datatypes and equality definitions.
 *
 * Revision 1.1  1995/03/08  16:23:04  brianm
 * new unit
 *
 *)

signature GENERAL =
  sig
    eqtype  unit
    type  exn

    exception Bind
    exception Match
    exception Subscript
    exception Size
    exception Overflow
    exception Domain
    exception Div
    exception Chr
    exception Fail of string

    val exnName : exn -> string
    val exnMessage : exn -> string

    datatype order = LESS | EQUAL | GREATER

    val <> : (''a * ''a) -> bool

    val ! : 'a ref -> 'a

    val := : ('a ref * 'a) -> unit

    val o : (('b -> 'c) * ('a -> 'b)) -> 'a -> 'c

    val before : ('a * unit) -> 'a

    val ignore : 'a -> unit

  end
