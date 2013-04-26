(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: word8s.sml,v $
 *  Revision 1.6  1997/11/21 10:51:31  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:26:58  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.4  1996/11/06  12:06:29  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.3  1996/10/22  13:23:18  jont
 *  Remove references to toplevel
 *
 *  Revision 1.2  1996/06/04  19:51:17  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.1  1996/05/22  15:04:46  matthew
 *  new unit
 *  New test
 *
*)

(* test/word8.sml -- some test cases for Word8, appropriate for a
   two's complement machine whose Integer.precision = SOME 31 
   PS 1995-03-30, 1995-07-12, 1995-11-06 
   modified for MLWorks Fri May 17 11:43:55 1996 still incomplete
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
    open Word8;
    val op > = gt and op < = lt and op >= = ge and op <= = le;
    val op + = add and op - = sub and op * = mul 
    and op div = idiv and op mod = imod;
    val i2W = Word.fromInt
    val i2w = fromInt
    and w2i = toInt
    and w2ix = toIntX
in

val test1 = checkrange (0, 255) 
    (fn i => i = w2i (i2w i));

val test2 = checkrange (~1000, 1000) 
    (fn i => let val r = w2i (i2w i) 
	     in Int.<=(0,r) andalso Int.<(r, 256)end);

val test3 = checkrange (~128, 127) 
    (fn i => i = toIntX (i2w i));

val test4 = checkrange (~1000, 1000)
    (fn i => let val r = toIntX (i2w i) 
	     in ~128 <= r andalso r < 128 end);

val test5a = checkrange (0,15) 
    (fn i => (i+240) div 2 * 2 + 1
             = w2i (orb (i2w i, i2w 241)));
val test5b = checkrange (0,255)
    (fn i => i = w2i (orb (i2w i, i2w i)));
val test5c = checkrange (~1000,1000)
    (fn i => let val r = w2i (andb (i2w 2047, i2w i)) 
	     in 0 <= r andalso r < 256 end);
val test6a = checkrange (0,15) 
    (fn i => i div 2 * 2 = w2i (andb (i2w i, i2w 254)));
val test6b = checkrange (0,255)
    (fn i => i = w2i (andb (i2w i, i2w i)));
val test6c = checkrange (~1000,1000)
    (fn i => let val r = w2i (andb (i2w 2047, i2w i)) 
	     in 0 <= r andalso r < 256 end);
val test7a = checkrange (0,15) 
    (fn i => i+240 = w2i (xorb (i2w i, i2w 240)));
val test7b = checkrange (0, 255)
    (fn i => 0 = w2i (xorb (i2w i, i2w i)));
val test7c = checkrange (~1000,1000)
    (fn i => let val r = w2i (xorb (i2w 0, i2w i)) 
	     in 0 <= r andalso r < 256 end);
val test8a = check (255 = w2i (notb (i2w 0)));
val test8b = check (0 = w2i (notb (i2w 255)));
val test8c = checkrange (~1000,1000)
    (fn i => let val r = w2i (notb (i2w i)) 
	     in 0 <= r andalso r < 256 end);

val test9a = checkrange (0,7)
    (fn k => pwr2 k = w2i (<< (i2w 1, i2W k)));
val test9b = checkrange (8,70)
    (fn k => 0 = w2i (<< (i2w 1, i2W k)));
val test9c = checkrange (~50,50)
    (fn k => let val r = w2i (<< (i2w 1, i2W k))
	     in 0 <= r andalso r < 256 end);
val test9d = checkrange (~50,50)
    (fn k => let val r = w2i (>> (i2w 1, i2W k))
	     in 0 <= r andalso r < 256 end);
val test9e = checkrange (0, 127) 
    (fn i => 2 * i = w2i (<< (i2w i, i2W 1)));
val test9f = checkrange (0, 255)
    (fn i => i div 2 = w2i (>> (i2w i, i2W 1)));
val test9g = checkrange (0,64)
    (fn k => rwp 255 k = w2i (>> (i2w 255, i2W k)));
val test9h = checkrange (1,65)
    (fn k => 0 = w2i (<< (i2w 1, i2W (~k))));
val test9i = checkrange (1,65)
    (fn k => 0 = w2i (>> (i2w 1, i2W (~k))));

val test10a = checkrange (1,65)
    (fn k => 0 = w2i (~>> (i2w 1, i2W (~k))));
val test10b = checkrange (1,65)
    (fn k => ~1 = w2ix (~>> (i2w 255, i2W (~k))));
val test10c = checkrange (~50,50)
    (fn k => let val r = w2i (~>> (i2w 1, i2W k))
	     in 0 <= r andalso r < 256 end);
val test10d = checkrange (~128, 127)
    (fn i => i div 2 = toIntX (~>> (i2w i, i2W 1)));
val test10e = checkrange (0,65)
    (fn k => rwp ~128 k = toIntX (~>> (i2w ~128, i2W k)));

val test11a = check (Word8.>  (i2w 255, i2w 254));
val test11b = check (Word8.<  (i2w 253, i2w 254));
val test11c = check (Word8.>= (i2w 128, i2w 128));
val test11d = check (Word8.>= (i2w 128, i2w 127));
val test11e = check (Word8.<= (i2w 1,   i2w 1));
val test11f = check (Word8.<= (i2w 0,   i2w 1));

val test12a = check (w2i(Word8.+(i2w   5, i2w  10)) =  15);
val test12b = check (w2i(Word8.+(i2w 127, i2w  11)) = 138);
val test12c = check (w2i(Word8.+(i2w 254, i2w   3)) =   1);
val test12d = check (w2i(Word8.-(i2w  10, i2w   3)) =   7);
val test12e = check (w2i(Word8.-(i2w 138, i2w  11)) = 127);
val test12f = check (w2i(Word8.-(i2w   1, i2w   3)) = 254);
val test12g = check (w2i(Word8.*(i2w   5, i2w  11)) =  55);
val test12h = check (w2i(Word8.*(i2w   4, i2w  35)) = 140);
val test12i = check (w2i(Word8.*(i2w   3, i2w 129)) = 131);
val test12j = check (w2i(Word8.div(i2w  10, i2w 3)) =   3);
val test12k = check (w2i(Word8.div(i2w 255, i2w 1)) = 255);
val test12l = check (w2i(Word8.div(i2w 242, i2w 3)) =  80);
val test12m = check (w2i(Word8.mod(i2w  10, i2w 3)) =   1);
val test12n = check (w2i(Word8.mod(i2w 255, i2w 1)) =   0);
val test12o = check (w2i(Word8.mod(i2w 242, i2w 3)) =   2);
val test12p = (Word8.div(i2w 0, i2w 256) seq "WRONG")
              handle Div => "OK" | _ => "WRONG";
val test12q = (Word8.mod(i2w 0, i2w 256) seq "WRONG")
              handle Div => "OK" | _ => "WRONG";

fun chk f (s, r) = 
    check'(fn _ => 
	   case f s of
	       SOME res => res = i2w r
	     | NONE     => false)

fun chkScan fmt = chk (StringCvt.scanString (scan fmt))

val test13a = 
    List.map (chk fromString)
             [("21", 33),
	      ("0", 0),
	      ("ff", 255),
	      ("FF", 255),
	      (" \n\t21Grap", 33)];

val test13b = 
    List.map (fn s => case fromString s of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "GG"];	    

val test13c = (fromString "100" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test13d = (fromString "FFFFFFFFFFFFFFF" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test14a = 
    List.map (chkScan StringCvt.DEC)
             [("123", 123),
	      ("0", 0),
	      ("255", 255),
	      (" \n\t123crap", 123)];

val test14b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.DEC) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "ff"];	    

val test14c = (StringCvt.scanString (scan StringCvt.DEC) "256" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test14d = (StringCvt.scanString (scan StringCvt.DEC) "9999999999999999" 
	       seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test15a = 
    List.map (chkScan StringCvt.BIN)
             [("10010", 18),
	      (" \n\t10010crap", 18)];

val test15b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.BIN) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "2", "8", "ff"];

val test15c = (StringCvt.scanString (scan StringCvt.BIN) "100000000" 
	       seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test15d = (StringCvt.scanString (scan StringCvt.BIN) 
	       "1111111111111111111111111111111111111111111111111111111111" 
	       seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test16a = 
    List.map (chkScan StringCvt.OCT)
             [("207", 135),
	      ("0", 0),
	      ("377", 255),
	      (" \n\t207crap", 135)];

val test16b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.OCT) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1", "8", "ff"];

val test16c = (StringCvt.scanString (scan StringCvt.OCT) "400" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test16d = (StringCvt.scanString (scan StringCvt.OCT) 
	       "7777777777777777777777777777777777777777777" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test17a = 
    List.map (chkScan StringCvt.HEX)
             [("21", 33),
	      (" \n\t21Grap", 33)];

val test17b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.HEX) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+1", "~1", "-1"];

val test17c = (StringCvt.scanString (scan StringCvt.HEX) "100" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

val test17d = (StringCvt.scanString (scan StringCvt.HEX) 
	       "FFFFFFFFFFFFFFFFFF" seq "WRONG") 
              handle Overflow => "OK" | _ => "WRONG";

local 
    fun fromToString i = 
	fromString (toString (fromInt i)) = SOME (fromInt i);

    fun scanFmt radix i = 
	let val w = fromInt i
	    val s = fmt radix w
	in StringCvt.scanString (scan radix) s = SOME w end;

in
val test18 = 
    check'(fn _ => range (0, 255) fromToString);

val test19 = 
    check'(fn _ => range (0, 255) (scanFmt StringCvt.BIN));

val test20 = 
    check'(fn _ => range (0, 255) (scanFmt StringCvt.OCT));

val test21 = 
    check'(fn _ => range (0, 255) (scanFmt StringCvt.DEC));

val test22 = 
    check'(fn _ => range (0, 255) (scanFmt StringCvt.HEX));
end
end;

