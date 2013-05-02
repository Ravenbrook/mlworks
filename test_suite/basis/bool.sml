(*  ==== Testing ====
 *
    Result: OK
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
 *  Revision Log
 *  ------------
 *  $Log: bool.sml,v $
 *  Revision 1.6  1997/11/21 10:43:15  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:22:21  matthew
 *  Updating
 *
 *  Revision 1.4  1996/10/22  13:19:56  jont
 *  Remove references to toplevel
 *
 *  Revision 1.3  1996/06/04  18:14:12  io
 *  stringcvt->string_cvt
 *
 *  Revision 1.2  1996/05/22  10:18:58  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/08  19:15:22  io
 *  new unit
 *
 *)

local
  fun print_result s res = print (s^":"^res^"\n")
  fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN"

  val test1 = 
    check' (fn _=>
            Bool.fromString "abc" = NONE andalso
            Bool.fromString "afals" = NONE andalso
            Bool.fromString "afalse" = NONE andalso
            Bool.fromString "false" = SOME false andalso
            Bool.fromString "falsea" = SOME false andalso
            Bool.fromString "atru" = NONE andalso
            Bool.fromString "atrue" = NONE andalso
            Bool.fromString "true" = SOME true andalso
            Bool.fromString "truea" = SOME true andalso
            Bool.fromString " true" = SOME true andalso
            Bool.fromString " false" = SOME false andalso
            Bool.fromString " FALSE" = SOME false andalso
            Bool.fromString "fAlSe" = SOME false)
  val test2 = 
    check' (fn _=>
            Bool.not true = false andalso
            Bool.not false = true)
  val test3 = 
    check' (fn _=>
            Bool.fromString "False" = StringCvt.scanString Bool.scan "_False")

  val test4 =
    check' (fn _=>
            Bool.toString true = "true" andalso
            Bool.toString false = "false")
in
  val it = 
    (print_result "fromString" test1;
     print_result "not" test2;
     print_result "toString" test4)
end
