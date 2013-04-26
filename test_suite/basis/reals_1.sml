(*  ==== Testing ====
 * this tests that the Real.nextAfter function works properly. (Bug 1526)
 *
    Result: OK
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: reals_1.sml,v $
 *  Revision 1.6  1997/11/21 15:01:38  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  15:57:11  matthew
 *  Updating
 *
 *  Revision 1.4  1996/11/06  13:35:38  andreww
 *  [Bug #1711]
 *  real is no longer eqtype.
 *
 *  Revision 1.3  1996/11/06  12:05:24  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/10/10  10:38:57  jont
 *  Add test for rem
 *
 *  Revision 1.1  1996/08/08  15:47:24  andreww
 *  new unit
 *
 *  Tests behaviour of Real.nextAfter.
 *
 *
*)


infix 1 seq
fun e1 seq e2 = e2;
fun say s = print s
fun check b = if b then "OK" else "WRONG";
fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN";

fun range (from, to) p = 
    let open Int
    in
	(from > to) orelse (p from) andalso (range (from+1, to) p)
    end;

val nextAfter = Real.nextAfter;
val ?= = Real.?=
infix ?=

val test_1 = check(nextAfter(1.0/0.0,1.0)?=Real.posInf);
val test_2 = check(nextAfter(1.0/0.0,~1.0)?=Real.posInf);
val test_3 = check(nextAfter(~1.0/0.0,1.0)?=Real.negInf);
val test_4 = check(nextAfter(~1.0/0.0,~1.0)?=Real.negInf);

val test_5 = check(nextAfter(1.0,1.0)?=1.0);
val test_6 = check(nextAfter(1.0,2.0)>1.0);
val test_7 = check(nextAfter(1.0,0.0)<1.0);

val test_8 = check(let val first = nextAfter(1.0,0.0)
                       val second = nextAfter(first,0.0)
                    in second<first andalso first<1.0
                   end);

val test_9 = check(let val first = nextAfter(~1.0,0.0)
                       val second = nextAfter(first,0.0)
                    in second>first andalso first> ~1.0
                   end);
val test_10 = check(Real.rem(17.0,8.0) ?= 1.0)
