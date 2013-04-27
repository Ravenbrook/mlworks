(*
$Log: _regexp.sml,v $
Revision 1.5  1996/10/30 16:33:59  io
[Bug #1614]
basifying String

 * Revision 1.4  1996/04/30  14:47:42  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.3  1995/07/17  10:09:24  jont
 * Add hex digit class
 *
Revision 1.2  1992/08/15  16:20:21  davidt
Removed a coupld of redundant functions and added the
negClass function.

Revision 1.1  1991/09/06  16:45:36  nickh
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

require "../utils/lists";
require "regexp";


functor RegExp (structure Lists : LISTS) : REGEXP =
  struct
    datatype RegExp = 
      DOT of RegExp * RegExp
    | STAR of RegExp
    | BAR of RegExp * RegExp
    | NODE of string
    | CLASS of string
    | EPSILON

    fun plusRE r = DOT(r,STAR(r))

    fun sequenceRE [] = EPSILON
      | sequenceRE (r::[]) = r
      | sequenceRE (r::rs) = DOT(r,sequenceRE(rs))

    local
      fun upto(m, n) = if m > n then [] else chr m :: upto(m+1, n)
      fun class(m, n) = CLASS(implode (upto(m, n)))
    in
      val printable = class(32, 126)
      val letter = CLASS "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnbopqrstuvwxyz"
      val digit = CLASS "0123456789"
      val hexDigit = CLASS "0123456789abcdefABCDEF"
      val any = class(0, 255)
      fun negClass s = CLASS(implode (Lists.difference (upto(0, 255), explode s)))
    end
  end
