(*  ==== Testing ====
 * this tests that the Exact Real conversion functions work properly.
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
    Result: OK
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: reals_2.sml,v $
 *  Revision 1.6  1998/04/21 09:28:37  mitchell
 *  [Bug #30336]
 *  Fix tests to agree with change in spec of toString and fmt
 *
 *  Revision 1.5  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.4  1997/11/21  10:48:38  daveb
 *  [Bug #30323]
 *
 *  Revision 1.3  1997/05/28  15:56:52  matthew
 *  Updating
 *
 *  Revision 1.2  1997/03/14  11:20:32  matthew
 *  Adding printing of ~nan test
 *
 *  Revision 1.1  1997/03/03  14:57:12  matthew
 *  new unit
 *
 *
 *
*)


(* Functions for testing the various conversion functions *)
(* fmt *)

fun opt (SOME x) = x | opt NONE = raise Div
val from = opt o Real.fromString
val exact = Real.fmt (StringCvt.EXACT);
val rep = MLWorks.Internal.Value.real_to_string;
fun equal (x,y) = (Real.isNan x andalso Real.isNan y) orelse rep x = rep y
fun test1 x = equal (opt (Real.fromString ("   " ^ exact x ^ "foobar")),x)
fun test2 s = s = exact (from s)
fun test_read s =
  let
    val sz = size s
    fun getc i = if i >= sz then NONE else SOME (String.sub (s,i),i+1)
    fun mkstring (src,acc) =
      case getc src of
        NONE => implode (rev acc)
      | SOME (c,src) => mkstring (src,c::acc)
  in
    case Real.scan getc 0 of
      SOME (r,src) => SOME (rep r,mkstring (src,[]))
    | _ => NONE
  end;

fun check_overflow f =
  (ignore(f ()); false) handle Overflow => true

val t1 = map test1 [0.0, 0.0/0.0, ~(0.0/0.0),1E34,Real.nextAfter(1E34,1E35),
                    Real.nextAfter (1.0,2.0), Real.nextAfter(1.0,0.0),
                    from "nan", from "+inf"]
val t2 = map test2 ["0.1E1",exact (Real.nextAfter (1.0,2.0)),
                    "nan"]
val t3 = equal (from "nan", from "nan")

val t4 = [test_read "nan" = SOME (rep (from "nan"),""),
          test_read "nanfoo" = SOME (rep (from "nan"),"foo"),
          test_read "foo" = NONE,
          test_read "1.23E10" = SOME (rep (from "1.23E10"),""),
          test_read "1.23Efoo" = SOME (rep (from "1.23"),"Efoo")]

val t5 = [test_read "1.0" = SOME  (rep 1.0,""),
          test_read ".1" = SOME  (rep 0.1,""),
          test_read "1.0E0" = SOME  (rep 1.0,""),
          test_read "0.1E1" = SOME  (rep 1.0,""),
          test_read "10E~1" = SOME  (rep 1.0,""),
          test_read "1" = SOME  (rep 1.0,""),
          test_read "1foo" = SOME  (rep 1.0,"foo"),
          test_read "1.0foo" = SOME  (rep 1.0,"foo"),
          test_read "1E00foo" = SOME  (rep 1.0,"foo"),
          test_read "1.0E00foo" = SOME  (rep 1.0,"foo")]

val t6 = [test_read "  foo" = NONE,
          test_read "  1." = SOME  (rep 1.0,"."),
          test_read "  1.E" = SOME  (rep 1.0,".E"),
          test_read "  1.E23" = SOME  (rep 1.0,".E23")]

val t7 = [check_overflow (fn () => test_read ("1E1234455678988976563"))]
          
val t8 = [equal (Real.realFloor 1.0,1.0),
          equal (Real.realCeil 1.0,1.0),
          equal (Real.realTrunc 1.0,1.0),
          equal (Real.realFloor 1.5,1.0),
          equal (Real.realCeil 1.5,2.0)]
val t9 = [equal (Real.realTrunc 1.0,1.0),
          Real.== (Real.realFloor (~(0.0)),0.0),
          Real.== (Real.realCeil (~(0.0)),0.0),
          Real.== (Real.realTrunc (~(0.0)),0.0),
          equal (Real.realFloor Real.posInf,Real.posInf),
          equal (Real.realCeil Real.posInf,Real.posInf),
          equal (Real.realTrunc Real.posInf,Real.posInf)]
fun deccheck x =
  let
    fun chk x = equal (x, Real.fromDecimal (Real.toDecimal (x)))
  in
    chk x andalso chk (Real.nextAfter (x,Real.posInf))
  end

val t10 = map deccheck [1.0,~1.0,0.0,~(0.0),
                        opt (Real.fromString "nan"),
                        Real.minPos, Real.minNormalPos,
                        Real.maxFinite, Real.posInf, Real.negInf]
