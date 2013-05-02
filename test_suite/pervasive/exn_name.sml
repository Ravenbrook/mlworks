(*
Result: OK
 
* $Log: exn_name.sml,v $
* Revision 1.3  1997/11/21 10:53:14  daveb
* [Bug #30323]
*
 *  Revision 1.2  1997/08/11  09:51:31  brucem
 *  [Bug #30086]
 *  Stop printing structure contents to prevent spurious failure.
 *
 *  Revision 1.1  1997/03/27  13:10:06  andreww
 *  new unit
 *  [Bug #1989]
 *  tests that the pervasive function exnName really does return a string.
 *
*
*
*
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

fun reportOK true = "test succeeded"
  | reportOK false = "test failed"


exception MyException

fun noDebugInfo s =
  let
    fun nameOnly i =
      if i=size s then s
      else
        if String.sub(s,i)= #"[" then String.substring(s,0,i)
        else nameOnly (i+1)
  in
    nameOnly 0
  end

val x = reportOK(noDebugInfo(exnName MyException)="MyException")
        handle e => "exception raised";
