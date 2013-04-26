(*  ==== Testing ====
 *
    Result: OK
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: maths.sml,v $
 *  Revision 1.8  1997/11/25 13:44:56  daveb
 *  [Bug #30323]
 *
 *  Revision 1.7  1997/10/09  15:39:23  jont
 *  [Bug #30279]
 *  Remove duplicated test names 12j and 12k
 *  Add further tests for integer exponents
 *
 *  Revision 1.6  1997/09/25  13:23:26  jont
 *  [Bug #70012]
 *  Improved testing of pow function
 *
 *  Revision 1.5  1997/05/28  11:06:35  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1996/11/06  13:36:39  andreww
 *  [Bug #1711]
 *  reals no longer equality type.
 *
 *  Revision 1.3  1996/11/06  12:05:12  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/10/22  13:20:44  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/05/22  12:14:39  matthew
 *  new unit
 *  New test
 *
*)

(* test/math.sml 
   PS 1995-02-25
   modified for MLWorks Fri May 17 10:44:35 1996
*)

fun check b = if b then "OK" else "WRONG";
fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN";

fun range (from, to) p = 
  let open Int
  in
    (from > to) orelse (p from) andalso (range (from+1, to) p)
  end;

fun checkrange bounds = check o range bounds;

val _ = Shell.Options.set(Shell.Options.Language.oldDefinition,true);

local
  fun check_nan (a : real) =
    if a = a then "WRONG"
    else "OK"

  open Math
  val MAXDOUBLE = 8.98846567431157E307;
  val MINDOUBLE = 4.94065645841246544E~324
  val PI = 3.14159265358979323846;
  val E = 2.7182818284590452354;
  val posinf = 1.0 / 0.0
  val neginf = ~posinf
  val eps = 1E~7;
  fun check1 (opr, a, r) =
    let val res = opr a
    in
      if r = res orelse r = 0.0 andalso abs res <= eps orelse abs(res/r - 1.0) <= eps
	then "OK" else "WRONG"
    end;
  fun check2 (opr, a1, a2, r) =
    let val res = opr(a1, a2)
    in
      if r = res orelse
	(r = 0.0 andalso abs res <= eps) orelse
	abs(res/r - 1.0) <= eps
	then "OK" else "WRONG"
    end;
in

val test0a = check(abs(PI - pi) <= eps);
val test0b = check(abs(E - e) <= eps);

val test1a = check1(sqrt, 64.0, 8.0);
val test1b = check1(sqrt, 0.0, 0.0);
val test1c = check_nan (sqrt ~1.0);

val test2a = check1(sin, 0.0, 0.0);
val test2b = check1(sin, pi/2.0, 1.0);
val test2c = check1(sin, pi, 0.0);
val test2d = check1(sin, 3.0*pi/2.0, ~1.0);

val test3a = check1(cos, 0.0, 1.0);
val test3b = check1(cos, pi/2.0, 0.0);
val test3c = check1(cos, pi, ~1.0);
val test3d = check1(cos, 3.0*pi/2.0, 0.0);

val test4a = check1(tan, 0.0, 0.0);
val test4b = check1(tan, pi/4.0, 1.0);
val test4c = check1(tan, pi, 0.0);
val test4d = check1(tan, 3.0*pi/4.0, ~1.0);
val test4e = check1(tan, ~pi/4.0, ~1.0);
val test4f = check((abs(tan (pi/2.0))  > 1E8) handle _ => true);
val test4g = check((abs(tan (~pi/2.0)) > 1E8) handle _ => true);

val test5a = check1(asin, 0.0, 0.0);
val test5b = check1(asin, 1.0, pi/2.0);
val test5c = check1(asin, ~1.0, ~pi/2.0);
val test5d = check_nan (asin 1.1)
val test5e = check_nan (asin ~1.1)

val test6a = check1(acos, 1.0, 0.0);
val test6b = check1(acos, 0.0, pi/2.0);
val test6c = check1(acos, ~1.0, pi);
val test6d = check_nan (acos 1.1)
val test6e = check_nan (acos ~1.1)

val test7a = check1(atan, 0.0, 0.0);
val test7b = check1(atan, 1.0, pi/4.0);
val test7c = check1(atan, ~1.0, ~pi/4.0);
val test7d = check1(atan, 1E8, pi/2.0);
val test7e = check1(atan, ~1E8, ~pi/2.0);

(* atan2 -- here I am in doubt over the argument order, since the New
Basis document is inconsistent with itself and with atan2 in the C
libraries. *)

val test8a = check2(atan2, 0.0, 0.0, 0.0);
val test8b = check2(atan2, 0.0, 1.0, pi/2.0);
val test8c = check2(atan2, 0.0, ~1.0, ~pi/2.0);
val test8d = check2(atan2, 1.0, 1.0, pi/4.0);
val test8e = check2(atan2, 1.0, ~1.0, ~pi/4.0);
val test8f = check2(atan2, ~1.0, ~1.0, ~3.0*pi/4.0);
val test8g = check2(atan2, ~1.0, 1.0, 3.0*pi/4.0);
val test8h = check2(atan2, 1.0, 1E8, pi/2.0);
val test8i = check2(atan2, 1.0, ~1E8, ~pi/2.0);
val test8j = check2(atan2, 1E8, 1.0, 0.0);
val test8k = check2(atan2, ~1E8, 1.0, pi);
val test8l = check2(atan2, ~1E8, ~1.0, ~pi);

val test9a = check1(exp, 0.0, 1.0);
val test9b = check1(exp, 1.0, e);
val test9c = check1(exp, ~1.0, 1.0/e);

val test10a = check1(ln, 1.0, 0.0);
val test10b = check1(ln, e, 1.0);
val test10c = check1(ln, 1.0/e, ~1.0);
val test10d = check1 (ln, 0.0, neginf);
val test10e = check_nan (ln ~1.0);

val nan = pow (~1.0, 1.1);

val test12a = check2(pow, 0.0, 0.0, 1.0); (* arbitrary, might be 0.0 *)
val test12b = check2(pow, 2.0, posinf, posinf);
val test12c = check2(pow, ~2.0, posinf, posinf);
val test12d = check2(pow, 0.5, posinf, 0.0);
val test12e = check2(pow, ~0.5, posinf, 0.0);
val test12f = check2(pow, 2.0, neginf, 0.0);
val test12g = check2(pow, ~2.0, neginf, 0.0);
val test12h = check2(pow, 0.5, neginf, posinf);
val test12i = check2(pow, ~0.5, neginf, posinf);
val test12j = check2(pow, posinf, 2.0, posinf);
val test12k = check2(pow, posinf, 0.5, posinf);
val test12l = check2(pow, posinf, ~2.0, 0.0);
val test12m = check2(pow, posinf, ~0.5, 0.0);
val test12n = check2(pow, neginf, 3.0, neginf);
val test12o = check2(pow, neginf, 2.5, posinf);
val test12p = check2(pow, neginf, 2.0, posinf);
val test12q = check2(pow, neginf, ~3.0, ~0.0);
val test12r = check2(pow, neginf, ~2.5, 0.0);
val test12s = check2(pow, neginf, ~2.0, 0.0);
val test12t = check_nan(pow(0.0, nan));
val test12u = check_nan(pow(~0.0, nan));
val test12v = check_nan(pow(0.5, nan));
val test12w = check_nan(pow(2.0, nan));
val test12x = check_nan(pow(~0.5, nan));
val test12y = check_nan(pow(~2.0, nan));
val test12z = check_nan(pow(posinf, nan));
val test12A = check_nan(pow(neginf, nan));
val test12B = check_nan(pow(nan, nan));
val test12C = check_nan(pow(nan, 0.5));
val test12D = check_nan(pow(nan, 1.0));
val test12E = check_nan(pow(nan, 2.0));
val test12F = check_nan(pow(nan, ~0.5));
val test12G = check_nan(pow(nan, ~1.0));
val test12H = check_nan(pow(nan, ~2.0));
val test12I = check_nan(pow(nan, posinf));
val test12J = check_nan(pow(nan, neginf));
val test12K = check_nan (pow (~1.0, 1.1));
val test12L = check_nan (pow (~1.0, 0.5));
val test12M = check_nan (pow (~2.0, 1.1));
val test12N = check_nan (pow (~2.0, 0.5));
val test12O = check_nan (pow (~0.5, 1.1));
val test12P = check_nan (pow (~0.5, 0.5));
val test12Q = check_nan (pow (1.0, posinf));
val test12R = check_nan (pow (1.0, neginf));
val test12S = check_nan (pow (~1.0, posinf));
val test12T = check_nan (pow (~1.0, neginf));
val test12U = check2(pow, 0.0, ~3.0, posinf);
val test12V = check2(pow, ~0.0, ~3.0, neginf);
val test12W = check2(pow, 0.0, ~2.0, posinf);
val test12X = check2(pow, ~0.0, ~2.0, posinf);
val test12Y = check2(pow, 0.0, 3.0, 0.0);
val test12Z = check2(pow, ~0.0, 3.0, ~0.0);
val test12aa = check2(pow, 0.0, 2.0, 0.0);
val test12ab = check2(pow, ~0.0, 2.0, 0.0);
val test12ac = check2(pow, 7.0, 0.0, 1.0);
val test12ad = check2(pow, 64.0, 0.5, 8.0); 
val test12ae = check2(pow, ~9.0, 2.0, 81.0); 
val test12af = check2(pow, 10.0, ~2.0, 0.01); 
val test12ag = check2(pow, ~10.0, ~2.0, 0.01); 
val test12ah = check2(pow, 0.0, 0.5, 0.0); 
val test12ai = check2(pow, 0.4, ~2.0, 6.25); 
val test12aj = check2 (pow, 0.0, ~1.0,posinf);
val test12ak = check2 (pow, 0.0, ~0.5,posinf);
val test12al = check2 (pow, 3.0, 1000000.0, posinf);
val test13a = check1(log10, 1.0, 0.0);
val test13b = check1(log10, 10.0, 1.0);
val test13c = check1(log10, 100.0, 2.0);
val test13d = check1(log10, 0.1, ~1.0);
val test13e = check1(log10, 0.01, ~2.0);
end
