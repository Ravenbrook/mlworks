(*

Result: OK
 
* Revision Log:
* -------------
* $Log: floatarray_append.sml,v $
* Revision 1.1  1997/01/07 15:10:05  andreww
* new unit
* [Bug #1818]
* floatarray tests
*
*
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


(* have to be careful here, since real isn't an equality type in sml'96*)


val a = MLWorks.Internal.FloatArray.arrayoflist
                          (map real [0,1,2,3,4,5,6,7,8,9])

val b = MLWorks.Internal.FloatArray.arrayoflist
                          (map real [0,1,2,3,5])

val c = MLWorks.Internal.FloatArray.append(a, b)

val _ = case (map floor (MLWorks.Internal.FloatArray.to_list c))
          of [0,1,2,3,4,5,6,7,8,9,0,1,2,3,5] 
            => print "Pass\n"
          | _ => print "Fail\n"
