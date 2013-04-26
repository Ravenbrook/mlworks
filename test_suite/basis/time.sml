(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
Result: OK

 *
 * Test Time.  Each test result should be true.
 *
 * Revision Log
 * ------------
 *
 * $Log: time.sml,v $
 * Revision 1.15  1998/10/07 15:58:52  jont
 * [Bug #30487]
 * Handle Time.Time in toSeconds test
 *
 *  Revision 1.14  1998/10/02  14:36:29  jont
 *  [Bug #30487]
 *  Use 2**31 to overflow Time.toSeconds instead of 2**29
 *
 *  Revision 1.13  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.12  1997/11/21  10:50:11  daveb
 *  [Bug #30323]
 *
 *  Revision 1.11  1997/06/06  11:05:06  jont
 *  Add compilation of __real to get comparison on reals
 *
 *  Revision 1.10  1997/03/06  13:44:49  matthew
 *  Time.fmt has changed
 *
 *  Revision 1.9  1996/11/05  13:45:17  andreww
 *  [Bug #1711]
 *  real no longer eqtype
 *
 *  Revision 1.8  1996/10/02  09:01:38  stephenb
 *  [Bug #1629]
 *  Add some Time.+ (Time.now (), X) tests.
 *
 *  Revision 1.7  1996/10/02  08:42:23  stephenb
 *  Add some tests for Time.> and Time.>=
 *
 *  Revision 1.5  1996/07/29  14:35:14  stephenb
 *  Fix a typo.
 *
 *  Revision 1.4  1996/07/29  14:13:49  stephenb
 *  [Bug #1506]
 *  Add a case to test Time.-(x,y) when usecs(x) < usecs(y).
 *  Specifically added tests: sub_[bcd].
 *
 *  Revision 1.3  1996/05/29  10:58:30  stephenb
 *  Add more tests.
 *
 *  Revision 1.2  1996/05/22  10:19:29  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/08  14:08:12  stephenb
 *  new unit
 *
 *)


val fromReal_a = Time.fromReal 0.0 = Time.zeroTime;
val fromReal_b = (ignore(Time.fromReal ~1.0); false) handle Time => true;

val toReal_a = Real.==(Time.toReal Time.zeroTime, 0.0);

val fromSeconds_a = Time.fromSeconds 0 = Time.zeroTime;
val fromSeconds_b = (ignore(Time.fromSeconds ~1); false) handle Time => true;

val toSeconds_a = Time.toSeconds Time.zeroTime = 0;
val toSeconds_b = (ignore(Time.toSeconds (Time.fromReal 2147483648.0)); false) handle Overflow => true | Time.Time => true;


val fromMilliseconds_a = Time.fromMilliseconds 0 = Time.zeroTime;
val fromMilliseconds_b = (ignore(Time.fromMilliseconds ~1); false) handle Time => true;


val toMilliseconds_a = Time.toMilliseconds Time.zeroTime = 0;


val fromMicroseconds_a = Time.fromMicroseconds 0 = Time.zeroTime;
val fromMicroseconds_b = (ignore(Time.fromMicroseconds ~1); false) handle Time => true;


val toMicroseconds_a = Time.toMicroseconds Time.zeroTime = 0;


val plus_a = Time.fromSeconds 10 = Time.+ (Time.fromSeconds 5, Time.fromSeconds 5);


local
  val now = Time.now ()
in
  val plus_b = now = Time.+ (now, Time.zeroTime);
end



val sub_a = Time.zeroTime = Time.- (Time.fromSeconds 5, Time.fromSeconds 5);

val sub_b = Time.-(Time.fromReal 19.5, Time.fromReal 18.6) = Time.fromReal 0.9;

val sub_c = (ignore(Time.-(Time.fromSeconds 5, Time.fromSeconds 10)); false) handle Time => true;

val sub_d = (ignore(Time.-(Time.fromReal 19.5, Time.fromReal 19.6)); false) handle Time => true;


val leq_a = Time.<= (Time.zeroTime, Time.zeroTime);
val leq_b = Time.<= (Time.zeroTime, Time.fromSeconds 10);
val leq_c = Time.<= (Time.fromSeconds 9, Time.fromSeconds 10);
val leq_d = Time.<= (valOf (Time.fromString "844170614.164"), valOf (Time.fromString "844170614.589"));
val leq_e = Time.<= (valOf (Time.fromString "844170614.589"), valOf (Time.fromString "844170614.589"));


val geq_a = Time.>= (Time.zeroTime, Time.zeroTime);
val geq_b = Time.>= (Time.fromSeconds 10, Time.zeroTime);
val geq_c = Time.>= (Time.fromSeconds 10, Time.fromSeconds 9);
val geq_e = Time.>= (valOf (Time.fromString "844170614.164"), valOf (Time.fromString "844170614.164"));
val geq_d = Time.>= (valOf (Time.fromString "844170614.589"), valOf (Time.fromString "844170614.164"));


val lt_a = not (Time.< (Time.zeroTime, Time.zeroTime));
val lt_b = Time.< (Time.fromSeconds 9, Time.fromSeconds 10);
val lt_c = not (Time.< (Time.fromSeconds 10, Time.fromSeconds 10));
val lt_d = not (Time.< (Time.fromSeconds 10, Time.fromSeconds 9));
val lt_e = Time.< (valOf (Time.fromString "844170614.164"), valOf (Time.fromString "844170614.589"));


val gt_a = not (Time.> (Time.zeroTime, Time.zeroTime));
val gt_b = Time.> (Time.fromSeconds 10, Time.fromSeconds 9);
val gt_c = not (Time.> (Time.fromSeconds 10, Time.fromSeconds 10));
val gt_d = not (Time.> (Time.fromSeconds 9, Time.fromSeconds 10));
val gt_e = Time.> (valOf (Time.fromString "844170614.589"), valOf (Time.fromString "844170614.164"));


val toString_a = Time.toString (Time.fromReal 1.1234) = "1.123";
val toString_b = Time.toString (Time.fromReal 1.1235) = "1.123";
val toString_c = Time.toString (Time.fromReal 1.1236) = "1.124";
val toString_d = Time.toString (Time.fromReal 0.0) = "0.000";
val toString_e = Time.toString (Time.fromReal 1.1) = "1.100";

val fmt_a = Time.fmt 3 (Time.fromReal 1.1234) = "1.123";
val fmt_b = Time.fmt 3 (Time.fromReal 1.1235) = "1.123";
val fmt_c = Time.fmt 3 (Time.fromReal 1.1236) = "1.124";
val fmt_d = Time.fmt 3 (Time.fromReal 0.0) = "0.000";
val fmt_e = Time.fmt 3 (Time.fromReal 1.1) = "1.100";
val fmt_f = Time.fmt 0 (Time.fromReal 1.1234) = "1";
val fmt_g = Time.fmt 3 (Time.fromReal 1.8) = "1.800";
val fmt_h = Time.fmt 0 (Time.fromReal 1.8) = "2";
val fmt_h = Time.fmt ~1 (Time.fromReal 1.8) = "2";

local
  fun invalid NONE = true
  |   invalid _    = false
  fun eq (NONE, ans) = false
  |   eq (SOME t, ans) = (Time.toString t) = ans
in
  val fromString_a = eq (Time.fromString "1", "1.000");
  val fromString_b = eq (Time.fromString "1.1234", "1.123");
  val fromString_c = invalid (Time.fromString "~1.1234");
  val fromString_d = eq (Time.fromString "  1", "1.000");
  val fromString_e = eq (Time.fromString "1.", "1.000");
  val fromString_f = eq (Time.fromString " \n\t189.125125crap", "189.125");
  val fromString_g = invalid (Time.fromString ".1234");
end
