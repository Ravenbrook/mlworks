(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: word16s-2.sml,v $
 *  Revision 1.5  1997/11/21 15:01:42  daveb
 *  [Bug #30323]
 *
 *  Revision 1.4  1997/05/28  11:25:57  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.3  1996/11/06  12:05:55  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/10/22  13:22:06  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/05/22  14:58:34  matthew
 *  new unit
 *  New test
 *
*)

(* test/word.sml -- some test cases for Word, appropriate for a two's
   complement machine whose Integer.precision = SOME 31 
   PS 1995-03-19 *)


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
    open Word16;
    val op > = gt and op < = lt and op >= = ge and op <= = le;
    val op + = add and op - = sub and op * = mul 
    and op div = idiv and op mod = imod;
    val intToWord = fromInt
    val wordToInt = toInt
    val i2w = intToWord
    and w2i = wordToInt;
in

fun shift (x,y) = if y > 0 then << (x,Word.fromInt y) else >> (x,Word.fromInt (~y))
fun ashift (x,y) = if y > 0 then << (x,Word.fromInt y) else ~>> (x, Word.fromInt (~y))
val signExtend = toIntX
val test1 = checkrange (0, 1025)
    (fn i => i = w2i (i2w i));

val test3 = checkrange (~1000, 1000) 
    (fn i => i = signExtend (i2w i));

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

val test8a = check (~1 = toIntX (notb (i2w 0)));
val test8b = check (0 = toIntX (notb (i2w ~1)));

val maxposint = 32767;
val maxnegint = ~maxposint-1;
fun pwr2 0 = 1 
  | pwr2 n = 2 * pwr2 (n-1);
fun rwp i 0 = i
  | rwp i n = rwp i (n-1) div 2;
val test9a = checkrange (0,14)
    (fn k => pwr2 k = w2i (shift (i2w 1, k)));
(* Not a required property *)
(*
val test9b = checkrange (31,65)
    (fn k => w2i (shift (i2w 1, k)) 
             = w2i (shift (i2w 1, k mod wordSize)));
*)
val test9c = check (~maxposint - 1 = toIntX (shift (i2w 1, 15)));
val test9d = checkrange (0, 1025)
    (fn i => 2 * i = w2i (shift (i2w i, 1)));
val test9e = checkrange (0, 1025)
    (fn i => i div 2 = w2i (shift (i2w i, ~1)));
val test9f = checkrange (0,30)
    (fn k => rwp maxposint k = w2i (shift (i2w maxposint, ~k)));

val test10a = checkrange (0, 14)
    (fn k => pwr2 k = w2i (ashift (i2w 1, k)));
(* Not a required property *)
(*
val test10b = checkrange (8,50)
    (fn k => w2i (ashift (i2w 1, k)) 
             = w2i (ashift (i2w 1, k mod wordSize)));
*)
(*
val test10c = check (maxnegint = signExtend (ashift (i2w 1, 29)));
*)
val test10d = checkrange (0, 513)
    (fn i => 2 * i = w2i (ashift (i2w i, 1)));
val test10e = checkrange (~513, 513)
    (fn i => i div 2 = signExtend (ashift (i2w i, ~1)));
val test10f = checkrange (0,30)
    (fn k => rwp maxnegint k = signExtend (ashift (i2w maxnegint, ~k)));
local 
    open Word16
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
    open Word16
in
val test12a = checkrange(0, 300) (fn k => w2i (i2w k + i2w 17) = add(k, 17));
val test12b = checkrange(0, 300) (fn k => toIntX (i2w k - i2w 17) = sub(k, 17));
val test12c = checkrange(0, 300) (fn k => w2i (i2w k * i2w 17) = mul(k, 17));
val test12d = checkrange(0, 300) 
    (fn k => w2i (i2w k div i2w 17) = idiv(k, 17));
val test12e = checkrange(0, 300) 
    (fn k => w2i (i2w k mod i2w 17) = imod(k, 17));
val test12f = checkrange(0, 300) 
    (fn k => toIntX (i2w k + i2w maxnegint) = add(k, maxnegint));
val test12g = checkrange(0, 300) 
    (fn k => toIntX (i2w maxnegint - i2w k - i2w 1) = sub(maxposint,k));
val test12h = checkrange(0, 300) 
    (fn k => toIntX (i2w k * i2w maxnegint) = mul(imod(k, 2), maxnegint));
val test12i = checkrange(0, 300) 
    (fn k => toIntX (i2w k * i2w maxposint + i2w k) = mul(imod(k, 2), maxnegint));
val test12j = checkrange(0, 300) 
    (fn k => w2i (i2w k div i2w ~1) = 0);
val test12k = checkrange(0, 300) 
    (fn k => w2i (i2w k mod i2w ~1) = k);
val test12l = check(toIntX (i2w maxposint + i2w 1) = maxnegint);
val test12m = check(toIntX (i2w maxnegint - i2w 1) = maxposint);
val test12n = check(toIntX (i2w ~1 div i2w 2) = maxposint);
val test12o = check(toIntX (i2w ~1 mod i2w 2) = 1);
val test12p = check(toIntX (i2w ~1 div i2w 100) = idiv(maxposint, 50));
val test12q = check(toIntX (i2w ~1 mod i2w 10) = 5);

val test13a = (i2w 17 div i2w 0 seq "WRONG") 
              handle Div => "OK" | _ => "WRONG";
val test13b = (i2w 17 mod i2w 0 seq "WRONG") 
              handle Div => "OK" | _ => "WRONG";
end;
end;
