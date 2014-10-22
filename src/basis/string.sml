(*  ==== INITIAL BASIS : STRINGS ====
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
 *  $Log: string.sml,v $
 *  Revision 1.4  1997/08/07 14:49:11  brucem
 *  [Bug #30086]
 *  Add map and mapi.
 *
 *  Revision 1.3  1996/10/03  15:26:55  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.2  1996/05/17  15:53:02  io
 *  from|toCString
 *
 *  Revision 1.1  1996/05/15  12:49:32  jont
 *  new unit
 *
 * Revision 1.4  1996/05/13  13:47:47  io
 * complete toString
 *
 * Revision 1.3  1996/05/10  12:15:57  io
 * revising
 *
 * Revision 1.2  1996/05/07  09:55:14  io
 * revising...
 *
 * Revision 1.1  1996/04/18  11:46:00  jont
 * new unit
 *
 *  Revision 1.2  1995/03/17  21:20:45  brianm
 *  Added Char structure dependency - doesn't assume Char is opened.
 *
 * Revision 1.1  1995/03/08  16:25:49  brianm
 * new unit
 * New file.
 *
 *)

require "char";

signature STRING =
  sig
    structure Char : CHAR
    eqtype char
      sharing type char = Char.char
    eqtype string
    val maxSize : int
    val size : string -> int
    val sub : (string * int) -> char
    val extract : (string * int * int option) -> string 
    val concat    : string list -> string
    val concatWith : string -> string list -> string
    val ^         : string * string -> string
    val implode   : char list -> string
    val explode : string -> char list
    val translate : (char -> string) -> string -> string 
    val compare : (string * string) -> order
    val str : char -> string
    val isPrefix : string -> string -> bool
    val substring : (string * int * int) -> string
    val fields : (char -> bool) -> string -> string list
    val tokens : (char -> bool) -> string -> string list
    val collate : (char * char -> order) -> (string * string) -> order

    val map  : ( char -> char) -> string -> string
    val mapi : (int * char -> char) -> string * int * int option -> string

    val fromString : string -> string option
    val toString : string -> string

    val fromCString : string -> string option
    val toCString : string -> string

    val <= : string * string -> bool
    val <  : string * string -> bool
    val >= : string * string -> bool
    val >  : string * string -> bool
  end
