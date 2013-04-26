(* test/stringcvt.sml -- 1995-10-26 
 * modified for MLWorks Fri May 24 10:19:54 1996
 * Result: OK
 * $Log: string_cvt.sml,v $
 * Revision 1.5  1997/11/21 10:49:11  daveb
 * [Bug #30323]
 *
 *  Revision 1.4  1997/05/28  11:19:58  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.3  1996/11/06  12:05:31  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.2  1996/10/22  13:21:21  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/06/04  19:45:26  io
 *  new unit
 *  stringcvt->string_cvt
 *
 *  Revision 1.3  1996/05/28  13:12:51  jont
 *  Inlining auxil.sml
 *
 *  Revision 1.2  1996/05/24  09:21:37  io
 *  fix...
 *
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
    open StringCvt
    (* Read all upper case letters, skip lowercase letters, scan an
     * integer, and return the excess characters: *)

    fun triple getc src =
	let open StringCvt
	    val (str1, src1) = splitl Char.isUpper getc src
	    val src2         = dropl Char.isLower getc src1
	in case Int.scan DEC getc src2 of
	    NONE            => NONE
	  | SOME (i, src3)  => 
		let val str2 = takel (fn _ => true) getc src3
		in SOME((str1, i, str2), src3) end
	end

    fun testtrip (s, res) = scanString triple s = res;
in

val test1 = 
    check'(fn _ =>
	   padLeft #"#" 0 "abcdef" = "abcdef"
	   andalso padLeft #"#" 6 "abcdef" = "abcdef"
	   andalso padLeft #"#" 7 "abcdef" = "#abcdef"
	   andalso padLeft #"#" 10 "abcdef" = "####abcdef"
	   andalso padLeft #"#" ~3 "abcdef" = "abcdef");

val test2 = 
    check'(fn _ =>
	   padRight #"#" 0 "abcdef" = "abcdef"
	   andalso padRight #"#" 6 "abcdef" = "abcdef"
	   andalso padRight #"#" 7 "abcdef" = "abcdef#"
	   andalso padRight #"#" 10 "abcdef" = "abcdef####"
	   andalso padRight #"#" ~3 "abcdef" = "abcdef");

val test3 = 
    check'(fn _ =>
    testtrip ("", NONE)
    andalso testtrip(" a1", NONE)
    andalso testtrip(" A1", NONE)
    andalso testtrip("ABC A1", NONE)
    andalso testtrip("ABC a1", NONE)
    andalso testtrip(" *1", NONE)
    andalso testtrip("ABC *1", NONE));

val test4 = 
    check'(fn _ =>
    testtrip ("1", SOME("", 1, ""))
    andalso testtrip ("1", SOME("", 1, ""))
    andalso testtrip (" 1", SOME("", 1, ""))
    andalso testtrip (" 1  ", SOME("", 1, "  ")));

val test5 =
    check'(fn _ =>
    testtrip ("1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("a1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("a1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("azbc1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("azbc1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("azbc  1a123+ +&D", SOME("", 1, "a123+ +&D"))
    andalso testtrip ("azbc  1a123+ +&D", SOME("", 1, "a123+ +&D")))

val test6 = 
    check'(fn _ =>
    testtrip ("~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("a~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("a~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("azbc~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("azbc~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("azbc  ~1234a123+ +&D", SOME("", ~1234, "a123+ +&D"))
    andalso testtrip ("azbc  ~1234a123+ +&D", SOME("", ~1234, "a123+ +&D")))

val test7 =
    check'(fn _ =>
    testtrip ("A1a123+ +&D", SOME("A", 1, "a123+ +&D"))
    andalso testtrip ("ABCDEFG1a123+ +&D", SOME("ABCDEFG", 1, "a123+ +&D"))
    andalso testtrip ("Aa1a123+ +&D", SOME("A", 1, "a123+ +&D"))
    andalso testtrip ("ABCDEFGa1a123+ +&D", SOME("ABCDEFG", 1, "a123+ +&D"))
    andalso testtrip ("Aazbc1a123+ +&D", SOME("A", 1, "a123+ +&D"))
    andalso testtrip ("ABCDEFGazbc1a123+ +&D", SOME("ABCDEFG", 1, "a123+ +&D"))
    andalso testtrip ("Aazbc  1a123+ +&D", SOME("A", 1, "a123+ +&D"))
    andalso testtrip ("ABCDEFGazbc  1a123+ +&D", SOME("ABCDEFG", 1, "a123+ +&D")))

val test8 = 
    check'(fn _ =>
    testtrip ("A~1234a123+ +&D", SOME("A", ~1234, "a123+ +&D"))
    andalso 
    testtrip ("ABCDEFG~1234a123+ +&D", SOME("ABCDEFG", ~1234, "a123+ +&D"))
    andalso testtrip ("Aa~1234a123+ +&D", SOME("A", ~1234, "a123+ +&D"))
    andalso 
    testtrip ("ABCDEFGa~1234a123+ +&D", SOME("ABCDEFG", ~1234, "a123+ +&D"))
    andalso testtrip ("Aazbc~1234a123+ +&D", SOME("A", ~1234, "a123+ +&D"))
    andalso 
    testtrip ("ABCDEFGazbc~1234a123+ +&D", SOME("ABCDEFG", ~1234, "a123+ +&D"))
    andalso testtrip ("Aazbc  ~1234a123+ +&D", SOME("A", ~1234, "a123+ +&D"))
    andalso 
    testtrip ("ABCDEFGazbc  ~1234a123+ +&D", SOME("ABCDEFG", ~1234, "a123+ +&D")))

val test9 = 
    check'(fn _ =>
    let fun getstring b getc src = 
	    SOME(takel (fn _ => b) getc src, src)
	fun dup 0 s = s
	  | dup n s = dup (n-1) (s^s);
	val longstring = dup 13 "abAB12 %^&"
    in 
	scanString (getstring true) longstring = SOME longstring 
	andalso scanString (getstring false) longstring = SOME ""
    end)

end
