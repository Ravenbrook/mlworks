(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: word2.sml,v $
 *  Revision 1.6  1997/11/21 10:51:00  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:26:30  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1996/11/06  12:06:13  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.3  1996/10/22  13:22:50  jont
 *  Remove references to toplevel
 *
 *  Revision 1.2  1996/06/04  19:50:54  io
 *  stringcvt->string_cv
 *
 *  Revision 1.1  1996/05/22  14:59:02  matthew
 *  new unit
 *  New test
 *
*)

(* test/word.sml -- some test cases for Word, appropriate for a two's
   complement machine whose Integer.precision = SOME 31 
   PS 1995-03-19, 1995-07-12, 1995-11-06 
   modified for MLWorks Fri May 17 11:19:46 1996
*)   


infix 1 seq
fun e1 seq e2 = e2;
fun check b = if b then "OK" else "WRONG";
fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN";

fun range (from, to) p = 
    let open Int
    in
	(from > to) orelse (p from) andalso (range (from+1, to) p)
    end;

fun checkrange bounds = check o range bounds;


local 
    (* Isn't this disgusting: *)
    type 'a foo4 = 'a * 'a * 'a * 'a
    type 'a foo5 = 'a * 'a * 'a * 'a * 'a
    val (gt,  lt,  ge,   le) = 
      (op>, op<, op>=, op<=) : (int * int -> bool) foo4
    val (add, sub, mul, idiv, imod) = 
      (op+, op-, op*, op div, op mod) : (int * int -> int) foo5

    open Word;
    val op > = gt and op < = lt and op >= = ge and op <= = le;
    val op + = add and op - = sub and op * = mul 
    and op div = idiv and op mod = imod;
    val i2w = fromInt
    and w2i = toIntX;
in

val test1 = checkrange (0, 1025)
    (fn i => i = w2i (i2w i));

val test3 = checkrange (~1000, 1000) 
    (fn i => i = toIntX (i2w i));

val test5a = checkrange (0,15) 
    (fn i => (i+960) div 2 * 2 + 1
             = w2i (orb (i2w i, i2w 961)));
val test5b = checkrange (0,513)
    (fn i => i = w2i (orb (i2w i, i2w i)));
val test6a = checkrange (0,15) 
    (fn i => i div 2 * 2 = w2i (andb (i2w i, i2w ~2)));
val test6b = checkrange (0,513)
    (fn i => i = w2i (andb (i2w i, i2w i)));
val test7a = checkrange (0,15) 
    (fn i => i+960 = w2i (xorb (i2w i, i2w 960)));
val test7b = checkrange (0, 513)
    (fn i => 0 = w2i (xorb (i2w i, i2w i)));

val test8a = check (~1 = w2i (notb (i2w 0)));
val test8b = check (0 = w2i (notb (i2w ~1)));

(*val maxposint = 1073741823; *)
val maxposint = (* 2 ^ 29 - 1 * as 1 bit taken up by sign *) 536870911
val maxnegint = ~maxposint-1;
fun pwr2 0 = 1 
  | pwr2 n = 2 * pwr2 (n-1);
fun rwp i 0 = i
  | rwp i n = rwp i (n-1) div 2;

val test9a = checkrange (0,28)
    (fn k => pwr2 k = w2i (<< (i2w 1, i2w k)));
val test9b = checkrange (31,65)
    (fn k => 0 = w2i (<< (i2w 1, i2w k)));
val test9c = check (maxnegint = w2i (<< (i2w 1, i2w 29)));
val test9d = checkrange (0, 1025)
    (fn i => 2 * i = w2i (<< (i2w i, i2w 1)));
val test9e = checkrange (0, 1025)
    (fn i => i div 2 = w2i (>> (i2w i, i2w 1)));
val test9f = checkrange (0,65)
    (fn k => rwp maxposint k = w2i (>> (i2w maxposint, i2w k)));
val test9g = checkrange (1,65)
    (fn k => 0 = w2i (<< (i2w 1, i2w (~k))));
val test9h = checkrange (1,65)
    (fn k => 0 = w2i (>> (i2w 1, i2w (~k))));

val test10a = checkrange (1,65)
    (fn k => 0 = w2i (~>> (i2w 1, i2w (~k))));
val test10b = checkrange (1,65)
    (fn k => ~1 = w2i (~>> (i2w ~1, i2w (~k))));
val test10c = checkrange (~513, 513)
    (fn i => i div 2 = toIntX (~>> (i2w i, i2w 1)));
val test10d = checkrange (0,65)
    (fn k => rwp maxnegint k = toIntX (~>> (i2w maxnegint, i2w k)));
local 
    open Word
in
val test11a = check (i2w 256 > i2w 255);
val test11b = check (i2w 0 < i2w ~1);
val test11c = check (i2w maxposint >= i2w maxposint);
val test11d = check (i2w maxnegint >= i2w 127);
val test11e = check (i2w 1 <= i2w 1);
val test11f = check (i2w 0 <= i2w 1);
val test11g = check (i2w 0 < i2w maxposint);
val test11h = check (i2w maxposint < i2w maxnegint);
val test11i = check (i2w maxnegint < i2w ~1);
end;

local 
    open Word
in
val test12a = checkrange(0, 300) (fn k => w2i (i2w k + i2w 17) = add(k, 17));
val test12b = checkrange(0, 300) (fn k => w2i (i2w k - i2w 17) = sub(k, 17));
val test12c = checkrange(0, 300) (fn k => w2i (i2w k * i2w 17) = mul(k, 17));
val test12d = checkrange(0, 300) 
    (fn k => w2i (i2w k div i2w 17) = idiv(k, 17));
val test12e = checkrange(0, 300) 
    (fn k => w2i (i2w k mod i2w 17) = imod(k, 17));
val test12f = checkrange(0, 300) 
    (fn k => w2i (i2w k + i2w maxnegint) = add(k, maxnegint));
val test12g = checkrange(0, 300) 
    (fn k => w2i (i2w maxnegint - i2w k - i2w 1) = sub(maxposint,k));
val test12h = checkrange(0, 300) 
    (fn k => w2i (i2w k * i2w maxnegint) = mul(imod(k, 2), maxnegint));
val test12i = checkrange(0, 300) 
    (fn k => w2i (i2w k * i2w maxposint + i2w k) = mul(imod(k, 2), maxnegint));
val test12j = checkrange(0, 300) 
    (fn k => w2i (i2w k div i2w ~1) = 0);
val test12k = checkrange(0, 300) 
    (fn k => w2i (i2w k mod i2w ~1) = k);
val test12l = check(w2i (i2w maxposint + i2w 1) = maxnegint);
val test12m = check(w2i (i2w maxnegint - i2w 1) = maxposint);
val test12n = check(w2i (i2w ~1 div i2w 2) = maxposint);
val test12o = check(w2i (i2w ~1 mod i2w 2) = 1);
val test12p = check(w2i (i2w ~1 div i2w 100) = idiv(maxposint, 50));
val test12q = check(w2i (i2w ~1 mod i2w 10) = 3);
val test12r = (i2w 17 div i2w 0 seq "WRONG") 
              handle Div => "OK" | _ => "WRONG";
val test12s = (i2w 17 mod i2w 0 seq "WRONG") 
              handle Div => "OK" | _ => "WRONG";

fun chk f (s, r) = 
    check'(fn _ => 
	   case f s of
	       SOME res => res = i2w r
	     | NONE     => false)

fun chkScan fmt = chk (StringCvt.scanString (scan fmt))

val test13a = 
    List.map (chk fromString)
             [("20Af", 8367),
	      (" \n\t20AfGrap", 8367)];

val test13b = 
    List.map (fn s => case fromString s of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "GG"];	    

val test14a = 
    List.map (chkScan StringCvt.DEC)
             [("10789", 10789),
	      (" \n\t10789crap", 10789)];

val test14b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.DEC) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "ff"];	    

val test15a = 
    List.map (chkScan StringCvt.BIN)
             [("10010", 18),
	      (" \n\t10010crap", 18)];

val test15b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.BIN) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "2", "8", "ff"];

val test16a = 
    List.map (chkScan StringCvt.OCT)
             [("2071", 1081),
	      (" \n\t2071crap", 1081)];

val test16b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.OCT) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "8", "ff"];

val test17a = 
    List.map (chkScan StringCvt.HEX)
             [("20Af", 8367),
	      (" \n\t20AfGrap", 8367)];

val test17b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.HEX) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1"];

end;

local 
    fun fromToString i = 
	fromString (toString (fromInt i)) = SOME (fromInt i);

    fun scanFmt radix i = 
	let val w = fromInt i
	    val s = fmt radix w
	in StringCvt.scanString (scan radix) s = SOME w end;

in
val test18 = 
    check'(fn _ => range (0, 1200) fromToString);

val test19 = 
    check'(fn _ => range (0, 1200) (scanFmt StringCvt.BIN));

val test20 = 
    check'(fn _ => range (0, 1200) (scanFmt StringCvt.OCT));

val test21 = 
    check'(fn _ => range (0, 1200) (scanFmt StringCvt.DEC));

val test22 = 
    check'(fn _ => range (0, 1200) (scanFmt StringCvt.HEX));
    
end
end;
