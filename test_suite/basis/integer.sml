(* test/integer.sml -- here we test only the `exotic' operations
   PS 1995-02-25 
   modified for MLWorks Fri May 17 10:56:33 1996
   
   Result: OK
*)


(*included "~sml/basis/19960305/test/auxil.sml"; *)
Shell.Options.set (Shell.Options.ValuePrinter.maximumSeqSize,20000);

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

fun checkrange bounds = check o range bounds;
(* end of included "~sml/basis/19960305/test/auxil.sml"; *)

local 
    open Int
      
    fun divmod (i, d, q, r)  = check(i div d = q andalso i mod d = r);
    fun quotrem (i, d, q, r) = check(quot (i,d) = q andalso rem(i, d) = r);
in	

val test1a = divmod(10, 3, 3, 1);
val test1b = divmod(~10, 3, ~4, 2);
val test1c = divmod(~10, ~3, 3, ~1);
val test1d = divmod(10, ~3, ~4, ~2);

val test2a = quotrem(10, 3, 3, 1);
val test2b = quotrem(~10, 3, ~3, ~1);
val test2c = quotrem(~10, ~3, 3, ~1);
val test2d = quotrem(10, ~3, ~3, 1);

val test3 = check(max(~5, 2) =  2 andalso max(5, 2) = 5);
val test4 = check(min(~5, 3) = ~5 andalso min(5, 2) = 2);

val test5 = check(sign ~57 = ~1 andalso sign 99 = 1 andalso sign 0 = 0);
val test6 = check(sameSign(~255, ~256) andalso sameSign(255, 256) 
		  andalso sameSign(0, 0));

local 
    val args = [0.0, 99.0, ~5.0, 1.1, ~1.1, 1.9, ~1.9, 2.5, ~2.5, 
		1000001.4999, ~1000001.4999];
in
val test7  = check(map Real.ceil args  
		   = [0, 99, ~5, 2, ~1, 2, ~1, 3, ~2, 1000002, ~1000001]);
val test8  = check(map Real.floor args 
		   = [0, 99, ~5, 1, ~2, 1, ~2, 2, ~3, 1000001, ~1000002]);
val test9  = check(map Real.trunc args 
		   = [0, 99, ~5, 1, ~1, 1, ~1, 2, ~2, 1000001, ~1000001]);
val test10 = check(map Real.round args 
		   = [0, 99, ~5, 1, ~1, 2, ~2, 2, ~2, 1000001, ~1000001]);
end

val test11 = check(Real.== (0.0,real 0) andalso Real.== (2.0,real 2) andalso Real.== (~2.0,real ~2));

val test12 = 
    case (minInt, maxInt) of
	(SOME mi, SOME ma) =>
	    check(sign mi = ~1 andalso sign ma = 1 
		  andalso sameSign(mi, ~1) andalso sameSign(ma, 1))
      | (NONE, NONE)       => "OK"
      | _                  => "WRONG";

fun chk f (s, r) = 
    check'(fn _ => 
	   case f s of
	       SOME res => res = r
	     | NONE     => false)

fun chkScan fmt = chk (StringCvt.scanString (scan fmt))

val test13a = 
    List.map (chk fromString)
             [("10789", 10789),
	      ("+10789", 10789),
	      ("~10789", ~10789),
	      ("-10789", ~10789),
	      (" \n\t10789crap", 10789),
	      (" \n\t+10789crap", 10789),
	      (" \n\t~10789crap", ~10789),
	      (" \n\t-10789crap", ~10789)
	      ];

val test13b = 
    List.map (fn s => case fromString s of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+ 1", "~ 1", "- 1", "ff"];	    

val test14a = 
    List.map (chkScan StringCvt.DEC)
             [("10789", 10789),
	      ("+10789", 10789),
	      ("~10789", ~10789),
	      ("-10789", ~10789),
	      (" \n\t10789crap", 10789),
	      (" \n\t+10789crap", 10789),
	      (" \n\t~10789crap", ~10789),
	      (" \n\t-10789crap", ~10789),
	      ("0", 0),
	      ("00",0),
	      ("+0",0),
	      ("-0",0),
	      ("~0",0),
	      ("001",1),
	      ("1",1)];


val test14b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.DEC) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+ 1", "~ 1", "- 1", "ff"];	    

val test15a = 
    List.map (chkScan StringCvt.BIN)
             [("10010", 18),
	      ("+10010", 18),
	      ("~10010", ~18),
	      ("-10010", ~18),
	      (" \n\t10010crap", 18),
	      (" \n\t+10010crap", 18),
	      (" \n\t~10010crap", ~18),
	      (" \n\t-10010crap", ~18),
	      ("0", 0),
	      ("00",0),
	      ("+0",0),
	      ("-0",0),
	      ("~0",0),
	      ("001",1),
	      ("1",1)];

val test15b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.BIN) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+ 1", "~ 1", "- 1", "2", "8", "ff"];

val test16a = 
    List.map (chkScan StringCvt.OCT)
             [("2071", 1081),
	      ("+2071", 1081),
	      ("~2071", ~1081),
	      ("-2071", ~1081),
	      (" \n\t2071crap", 1081),
	      (" \n\t+2071crap", 1081),
	      (" \n\t~2071crap", ~1081),
	      (" \n\t-2071crap", ~1081),
	      ("0", 0),
	      ("00",0),
	      ("+0",0),
	      ("-0",0),
	      ("~0",0),
	      ("001",1),
	      ("1",1)];

val test16b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.OCT) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+ 1", "~ 1", "- 1", "8", "ff"];

val test17a = 
    List.map (chkScan StringCvt.HEX)
             [("20Af", 8367),
	      ("+20Af", 8367),
	      ("~20Af", ~8367),
	      ("-20Af", ~8367),
	      (" \n\t20AfGrap", 8367),
	      (" \n\t+20AfGrap", 8367),
	      (" \n\t~20AfGrap", ~8367),
	      (" \n\t-20AfGrap", ~8367),
	      ("0", 0),
	      ("00",0),
	      ("+0",0),
	      ("-0",0),
	      ("~0",0),
	      ("001",1),
	      ("1",1),
	      ("0x1",1),
	      ("0X1",1),
	      ("0x000f",15),
	      ("~0x0f", ~15),
	      ("-0xf", ~15),
	      ("+0x0f", 15),
	      ("+f", 15),
	      ("0x22zzzz1", 34)];

val test17b = 
    List.map (fn s => case StringCvt.scanString (scan StringCvt.HEX) s 
	              of NONE => "OK" | _ => "WRONG")
	   ["", "-", "~", "+", " \n\t", " \n\t-", " \n\t~", " \n\t+", 
	    "+ 1", "~ 1", "- 1", "0x", "0x~1", "\n\t+x1", "0Xg", "0x-f"];


local 
    fun fromToString i = 
	fromString (toString i) = SOME i;

    fun scanFmt radix i = 
	StringCvt.scanString (scan radix) (fmt radix i) = SOME i;

    fun fromS radix s = 
      StringCvt.scanString (scan radix) s
      

in
val test18 = 
    check'(fn _ => range (~1200, 1200) fromToString);

val test19 = 
    check'(fn _ => range (~1200, 1200) (scanFmt StringCvt.BIN));

val test20 = 
    check'(fn _ => range (~1200, 1200) (scanFmt StringCvt.OCT));

val test21 = 
    check'(fn _ => range (~1200, 1200) (scanFmt StringCvt.DEC));

val test22 = 
    check'(fn _ => range (~1200, 1200) (scanFmt StringCvt.HEX));

end
end
