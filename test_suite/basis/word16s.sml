(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: word16s.sml,v $
 *  Revision 1.5  1997/11/21 15:01:46  daveb
 *  [Bug #30323]
 *
 *  Revision 1.4  1997/05/28  11:26:15  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.3  1996/11/06  12:06:02  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/10/22  13:22:37  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/05/22  15:03:14  matthew
 *  new unit
 *  New test
 *
*)

(* test/word8.sml -- some test cases for Word8, appropriate for a
   two's complement machine whose Integer.precision = SOME 31 
   PS 1995-02-28 *)


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
    fun pwr2 0 = 1 
      | pwr2 n = 2 * pwr2 (n-1);
    fun rwp i 0 = i
      | rwp i n = rwp i (n-1) div 2;

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
    val maxword = 256 * 256
in

fun shift (x,y) = if y > 0 then << (x,Word.fromInt y) else >> (x,Word.fromInt (~y))
fun ashift (x,y) = if y > 0 then << (x,Word.fromInt y) else ~>> (x, Word.fromInt (~y))
val signExtend = toIntX

val test1 = checkrange (0, 255) 
    (fn i => i = toInt (fromInt i));

val test2 = checkrange (~1000, 1000) 
    (fn i => let val r = toInt (fromInt i) 
	     in 0 <= r andalso r < maxword end);

val test3 = checkrange (~128, 127) 
    (fn i => i = signExtend (fromInt i));

val test4 = checkrange (~1000, 1000)
    (fn i => let val r = signExtend (fromInt i) 
	     in ~maxword <= r andalso r < maxword end);

val test5a = checkrange (0,15) 
    (fn i => (i+240) div 2 * 2 + 1
             = toInt (orb (fromInt i, fromInt 241)));
val test5b = checkrange (0,255)
    (fn i => i = toInt (orb (fromInt i, fromInt i)));
val test5c = checkrange (~1000,1000)
    (fn i => let val r = toInt (andb (fromInt 2047, fromInt i)) 
	     in 0 <= r andalso r < maxword end);
val test6a = checkrange (0,15) 
    (fn i => i div 2 * 2 = toInt (andb (fromInt i, fromInt 254)));
val test6b = checkrange (0,255)
    (fn i => i = toInt (andb (fromInt i, fromInt i)));
val test6c = checkrange (~1000,1000)
    (fn i => let val r = toInt (andb (fromInt 2047, fromInt i)) 
	     in 0 <= r andalso r < maxword end);
val test7a = checkrange (0,15) 
    (fn i => i+240 = toInt (xorb (fromInt i, fromInt 240)));
val test7b = checkrange (0, 255)
    (fn i => 0 = toInt (xorb (fromInt i, fromInt i)));
val test7c = checkrange (~1000,1000)
    (fn i => let val r = toInt (xorb (fromInt 0, fromInt i)) 
	     in 0 <= r andalso r < maxword end);
val test8a = check (maxword - 1  = toInt (notb (fromInt 0)));
val test8b = check (0 = toInt (notb (fromInt (maxword - 1))));
val test8c = checkrange (~1000,1000)
    (fn i => let val r = toInt (notb (fromInt i)) 
	     in 0 <= r andalso r < maxword end);
val test9a = checkrange (0,7)
    (fn k => pwr2 k = toInt (shift (fromInt 1, k)));
(*
val test9b = checkrange (8,50)
    (fn k => toInt (shift (fromInt 1, k)) 
             = toInt (shift (fromInt 1, k mod wordSize)));
*)
val test9c = checkrange (~50,50)
    (fn k => let val r = toInt (shift (fromInt 1, k))
	     in 0 <= r andalso r < maxword end);
val test9d = checkrange (0, 127) 
    (fn i => 2 * i = toInt (shift (fromInt i, 1)));
val test9e = checkrange (0, 255)
    (fn i => i div 2 = toInt (shift (fromInt i, ~1)));
val test9f = checkrange (0,7)
    (fn k => rwp 255 k = toInt (shift (fromInt 255, ~k)));

val test10a = checkrange (0,7)
    (fn k => pwr2 k = toInt (ashift (fromInt 1, k)));
(*
val test10b = checkrange (8,50)
    (fn k => toInt (ashift (fromInt 1, k)) 
             = toInt (ashift (fromInt 1, k mod wordSize)));
*)
val test10c = checkrange (~50,50)
    (fn k => let val r = toInt (ashift (fromInt 1, k))
	     in 0 <= r andalso r < maxword end);
val test10d = checkrange (0, 127) 
    (fn i => 2 * i = toInt (ashift (fromInt i, 1)));
val test10e = checkrange (~128, 127)
    (fn i => i div 2 = signExtend (ashift (fromInt i, ~1)));
val test10f = checkrange (0,7)
    (fn k => rwp ~128 k = signExtend (ashift (fromInt ~128, ~k)));

val test11a = check (Word16.>  (fromInt 255, fromInt 254));
val test11b = check (Word16.<  (fromInt 253, fromInt 254));
val test11c = check (Word16.>= (fromInt 128, fromInt 128));
val test11d = check (Word16.>= (fromInt 128, fromInt 127));
val test11e = check (Word16.<= (fromInt 1,   fromInt 1));
val test11f = check (Word16.<= (fromInt 0,   fromInt 1));

val test12a = check (toInt(Word16.+(fromInt   5, fromInt  10)) =  15);
val test12b = check (toInt(Word16.+(fromInt 127, fromInt  11)) = 138);
val test12c = check (toInt(Word16.+(fromInt 65534, fromInt   3)) =   1);
val test12d = check (toInt(Word16.-(fromInt  10, fromInt   3)) =   7);
val test12e = check (toInt(Word16.-(fromInt 138, fromInt  11)) = 127);
val test12f = check (toInt(Word16.-(fromInt   1, fromInt   3)) = 65534);
val test12g = check (toInt(Word16.*(fromInt   5, fromInt  11)) =  55);
val test12h = check (toInt(Word16.*(fromInt   4, fromInt  35)) = 140);
val test12i = check (toInt(Word16.*(fromInt   3, fromInt 32769)) = 32771);
val test12j = check (toInt(Word16.div(fromInt  10, fromInt 3)) =   3);
val test12k = check (toInt(Word16.div(fromInt 255, fromInt 1)) = 255);
val test12l = check (toInt(Word16.div(fromInt 242, fromInt 3)) =  80);
val test12m = check (toInt(Word16.mod(fromInt  10, fromInt 3)) =   1);
val test12n = check (toInt(Word16.mod(fromInt 255, fromInt 1)) =   0);
val test12o = check (toInt(Word16.mod(fromInt 242, fromInt 3)) =   2);
val test12p = (Word16.div(fromInt 0, fromInt maxword) seq "WRONG")
              handle Div => "OK" | _ => "WRONG";
val test12q = (Word16.mod(fromInt 0, fromInt maxword) seq "WRONG")
              handle Div => "OK" | _ => "WRONG";
end;
