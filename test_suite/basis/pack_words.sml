(*  ==== Testing ====
 *
 *  Result: OK
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
 *  $Log: pack_words.sml,v $
 *  Revision 1.2  1998/08/17 16:34:26  jont
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

val u = Word8Vector.fromList (map Word8.fromInt  [0,0,0,1]);
val x1 = Pack32Little.subVec(u, 0) = 0w16777216;
val x2 = Pack32Big.subVec(u, 0) = 0w1;
val v = Word8Vector.fromList (map Word8.fromInt  [1,0,0,0]);
val x3 = Pack32Little.subVec(v, 0) = 0w1;
val x4 = Pack32Big.subVec(v, 0) = 0w16777216;
val w = Word8Vector.fromList (map Word8.fromInt  [0,1]);
val y1 = Pack16Little.subVec(w, 0) = 0w256;
val y2 = Pack16Big.subVec(w, 0) = 0w1;
val x = Word8Vector.fromList (map Word8.fromInt  [1,0]);
val y3 = Pack16Little.subVec(x, 0) = 0w1;
val y4 = Pack16Big.subVec(x, 0) = 0w256;
