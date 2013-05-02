(*  ==== Testing ====
 *
    Result: OK
 *
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
 *  Revision Log
 *  ------------
 *  $Log: string.sml,v $
 *  Revision 1.16  1998/04/17 11:32:52  mitchell
 *  [Bug #30338]
 *  Update test to allow quote in fromCString
 *
 *  Revision 1.15  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.14  1997/11/21  10:49:04  daveb
 *  [Bug #30323]
 *
 *  Revision 1.13  1997/08/08  12:54:09  brucem
 *  [Bug #30086]
 *  Add tests for String.map and String.mapi.
 *
 *  Revision 1.12  1997/08/05  10:32:37  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *  And change General.valOf to valOf.
 *
 *  Revision 1.11  1997/05/28  11:19:43  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.10  1997/01/13  16:19:20  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.9  1996/10/22  13:21:07  jont
 *  Remove references to toplevel
 *
 *  Revision 1.8  1996/09/25  09:52:11  io
 *  remove longList generation test
 *
 *  Revision 1.7  1996/07/25  16:17:02  daveb
 *  [Bug #1497]
 *  Added test to check that extract does bound checking on the empty string.
 *
 *  Revision 1.6  1996/07/02  15:29:27  io
 *  blotched checkin
 *
 *  Revision 1.5  1996/07/02  10:53:09  io
 *  ensure fromString returns accumulated results
 *  and fix octal digit handling in from|toCString
 *
 *  Revision 1.4  1996/06/04  23:12:47  io
 *  remove a slow test
 *
 *  Revision 1.3  1996/05/22  12:02:15  daveb
 *  Renamed Shell.Module to Shell.Build
 *
 *  Revision 1.2  1996/05/16  16:48:54  io
 *  remove from|to CString
 *
 *  Revision 1.1  1996/05/16  10:47:37  io
 *  new unit
 *
 *  Revision 1.4  1996/05/13  17:49:20  io
 *  more tests
 *
 *  Revision 1.3  1996/05/10  15:13:47  io
 *  ongoing
 *
 *  Revision 1.2  1996/05/09  18:47:59  io
 *  some more tests..
 *
 *  Revision 1.1  1996/05/09  17:22:06  io
 *  new unit
 *
 *)

local
  val print = fn s => fn res => (print(s^":"^res^"\n"))

  fun check' s f = print s ((if f () then "OK" else "WRONG") handle exn => "FAIL:"^General.exnName exn)

  fun checkexn' s exn f = 
    let val result = (ignore(f ()); "FAIL") handle ex =>
      if General.exnName ex = General.exnName exn then 
        "OKEXN" 
      else 
        "BADEXN:" ^ (General.exnName ex)
    in
      print s result
    end
      
  fun iterate (x,y) = if x>y then [] else x::iterate(x+1,y)
    
  val s1 = ""
  val s2 = "ABCDE\tFGHI"
  val ABCDE = map Char.chr (iterate (65, 69))

  val test1 = check' "test1" (fn _=>(map String.size [s1, s2]) = [0, 10])
  val test2 = check' "test2" (fn _=>String.sub(s2, 6) = Char.chr 70 andalso
                      String.sub(s2, 9) = Char.chr 73)
  val test3 = checkexn' "test3" Subscript (fn _=>String.sub(s1, 0))
  val test4 = checkexn' "test4" Subscript (fn _=>String.sub(s2, ~1))
  val test5 = checkexn' "test5" Subscript (fn _=>String.sub(s2, 10))

  fun foo (acc, 0) = acc
    | foo (acc, n) = 
    if n < 0 orelse n > Char.maxOrd then foo (#"_"::acc, n-1)
    else foo (Char.chr n :: acc, n-1)

  (*
   * val longList = foo ([], String.maxSize)
   * val test6a = check' "test6a" (fn _=>List.length longList = String.maxSize)
   * val longString = String.implode longList
   * val test6b = check' "test6b" (fn _=>String.size longString = String.maxSize)
   * val test6 = checkexn' "test6" Size (fn _=>String.implode (#"1"::longList))
   *)

  val test7 = check' "test7" 
    (fn _=>
     String.isPrefix "abc" "abcd" andalso
     String.isPrefix "abc" "abc" andalso 
     not (String.isPrefix "abcd" "abc") andalso
     not (String.isPrefix "abxd" "abcdef") andalso
     String.substring("abcd", 2, 2) = "cd" andalso
     String.substring("abcd", 0, 4) = "abcd")
  val test8 = checkexn' "test8" Subscript
    (fn _=>String.substring ("abcd", ~1, 2))
  val test9 = checkexn' "test9" Subscript
    (fn _=>String.substring ("abcd", 0, 5))
  val isDelimiter = fn c=> c = #"a"
  val test10 = check' "test10"
    (fn _=>
     String.fields isDelimiter "aaa" = ["", "", "", ""] andalso
     String.fields isDelimiter "aa1" = ["", "", "1"] andalso
     String.fields isDelimiter "1aa" = ["1", "", ""] andalso
     String.fields isDelimiter "1a2a3" = ["1", "2", "3"] andalso
     String.fields isDelimiter "1a2a" = ["1", "2", ""] andalso
     String.fields isDelimiter "a1a2" = ["", "1", "2"])
  val test11 = check' "test11"
    (fn _=>
     String.extract ("abc", 0, NONE) = "abc" andalso
     String.extract ("abc",1, NONE) = "bc" andalso
     String.extract ("abc",1, SOME 1) = "b" andalso
     String.extract ("abc",3, NONE) = "" andalso
     String.extract ("abc", 3, SOME 0) = "")

  val test11a = checkexn' "test11a" Subscript 
    (fn _=>String.extract ("abc", ~1, NONE))
  val test11b = checkexn' "test11b" Subscript
    (fn _=>String.extract ("abc", 4, NONE))
  val test11c = checkexn' "test11c" Subscript
    (fn _=>String.extract ("abc", 3, SOME 1))
  val test11d = checkexn' "test11d" Subscript
    (fn _=>String.extract ("abc",3, SOME 2))
  val test11e = checkexn' "test11e" Subscript
    (fn _=>String.extract ("abc", 0, SOME ~1))
  val test11f = checkexn' "test11f" Subscript
    (fn _=>String.extract ("abc", 1, SOME (1+2)))
  val test11g = checkexn' "test11g" Subscript
    (fn _=>String.extract(s2, ~1, SOME 0))
  val test11h = checkexn' "test11h" Subscript
    (fn _=>String.extract("", ~1, SOME 0))
  val test11i = checkexn' "test11i" Subscript
    (fn _=>String.extract("", 0, SOME 3))
  val test12a = check' "test12a"
    (fn _=> 
     s2 = String.substring(s2, 0, size s2) andalso 
     "" = String.substring(s2, size s2, 0) andalso
     "" = String.substring(s1, 0, 0))
  val test12b = checkexn' "test12b" Subscript
    (fn _=>String.substring(s2, ~1, 0))
  val test12c = checkexn' "test12c" Subscript 
    (fn _=>String.substring(s2, 11, 0))
  val test12d = checkexn' "test12d" Subscript
    (fn _=>String.substring(s2, 0, 11))
  val test12e = checkexn' "test12e" Subscript
    (fn _=>String.substring(s2, 10, 1))
  val test12f = check' "test12f"
    (fn _ => 
     "ABCDE" = String.substring(s2, 0, 5) andalso 
     "FGHI" = String.substring(s2, 6, 4))

  val test13a = check' "test13a" 
    (fn _=> 
     (String.translate (fn _ => "") s2 = "" andalso
      String.translate (fn x => String.str x) "" = "" andalso
      String.translate (fn x => String.str x) s2 = s2))

  val test13b = check' "test13b"
    (fn _ => 
     (String.translate 
      (fn c => if c = #"\t" then "XYZ " else String.str c)
      s2 
      = "ABCDEXYZ FGHI"))

  val test14 = check' "test14" 
    (fn _=> 
     (String.tokens Char.isSpace "" = []
      andalso String.tokens Char.isSpace "   \t \n" = []
      andalso String.tokens (fn c => c = #",") ",asd,,def,fgh" 
      = ["asd","def","fgh"]))

  val test15 = 
    check' "test15" 
    (fn _=> 
     (String.fields Char.isSpace "" = [""]
      andalso String.fields Char.isSpace "   \t \n" = ["","","","","","",""]
      andalso String.fields (fn c => c = #",") ",asd,,def,fgh" 
      = ["","asd","","def","fgh"]))
    
  val test16a = check' "test16a"
    (fn _ => 
     EQUAL = String.compare(s1,s1) andalso EQUAL = String.compare(s2,s2) andalso
     LESS = String.compare("A", "B") andalso
     GREATER = String.compare("B", "A") andalso
     LESS = String.compare("ABCD", "ABCDE") andalso
     GREATER = String.compare("ABCDE", "ABCD"))

  val test16b = check' "test16b"
    (fn _=> 
     EQUAL = String.compare(s1,s1) andalso EQUAL = String.compare(s2,s2) andalso
     LESS = String.compare("A", "a") andalso
     GREATER = String.compare("b", "B") andalso
     LESS = String.compare("abcd", "abcde") andalso
     GREATER = String.compare("abcde", "abcd"))

  val test17 = check' "test17"
    (fn _=>
     String.^("abc", "def") = "abcdef" andalso
     String.^("abc\000def", "ghi") = "abc\000defghi" andalso
     String.^("", "abc") = "abc" andalso
     String.^("", "\000") = "\000")

  (*
   * val test17a = checkexn' "test17a" Size
   * (fn _=>String.^(longString, "a"))
   * 
   * val test18a = checkexn' "test18a" Size
   * (fn _=>
   * String.concat ["a", longString])
   *)


  val test18b = check' "test18b"
    (fn _=>
     String.concat [] = "")
    
  val test19 = check' "test19"
    (fn _=>
     String.< (s1, s2) andalso
     not (String.< (s2, s1)) andalso
     not (String.< (s1, s1)) andalso
     not (String.< (s2, s2)) andalso

     String.<= (s1, s2) andalso
     not (String.<= (s2, s1)) andalso
     String.<= (s1, s1) andalso
     String.<= (s2, s2) andalso

     not (String.> (s1, s2)) andalso
     String.> (s2, s1) andalso
     not (String.> (s1, s1)) andalso
     not (String.> (s2, s2)) andalso
     
     not (String.>= (s1, s2)) andalso
     String.>= (s2, s1) andalso
     String.>= (s1, s1) andalso
     String.>= (s2, s2))

    val test20 = check' "test20"
      (fn _=>
       List.length (String.explode "abcdef\000\001\0031\0032") = (String.size "abcdef\000\001\0031\0032"))
    val test20a = check' "test20a"
      (fn _=>
       String.explode "abc" = [#"a", #"b", #"c"])
      

    val test21 = check' "test21"
      (fn _=>
       String.collate Char.compare ("abc", "ABC") = GREATER andalso
       String.collate Char.compare ("abc", "abc") = EQUAL andalso
       String.collate Char.compare ("ABC", "abc") = LESS)
      
    val charList = 
      [(#"\n", "\\n"),
       (#"\t", "\\t"),
       (#"\000", "\\^@"),
       (#"\001", "\\^A"),
       (#"\026", "\\^Z"),
       (#"\031", "\\^_"),
       (#"\032", " "),
       (#"\126", "~"),
       (#"\\", "\\\\"),
       (#"\"", "\\\""),
       (#"A", "A"),
       (#"\127", "\\127"),
       (#"\128", "\\128"),
       (#"\255", "\\255")]

    val test22 = check' "test22"
      (fn _=>
       String.toString (String.implode (map #1 charList)) =
       (String.concat (map #2 charList)))

    val charList2 = CharVector.tabulate (256, Char.chr)
    fun chk (s:string, f, g) = 
      let
        val sz = size s
        fun scan (acc, i) = 
          if i < sz then
            let 
              val c = String.str (String.sub (s, i))
            in
              case g c of
                NONE => scan (c::acc, i+1)
              | SOME s =>
                  case f s of
                    NONE => scan (c::acc, i+1)
                  | SOME t =>
                      if c = t then 
                        scan (acc, i+1)
                      else
                        scan (c::acc, i+1)
            end
          else
            rev acc
      in
        scan ([], 0)
      end

     val test23 = check' "test23" 
       (fn _=> 
        chk (charList2, String.fromString, fn c => SOME (String.toString c)) = [])
   
    val argResList = 
      [("A", #"A"),
       ("z", #"z"),
       ("@", #"@"),
       ("~", #"~"),
       ("\\n", #"\n"),
       ("\\t", #"\t"),
       ("\\\\", #"\\"),
       ("\\\"", #"\""),
       ("\\^@", #"\000"),
       ("\\^A", #"\001"),
       ("\\^Z", #"\026"),
       ("\\^_", #"\031"), 
       ("\\000", #"\000"),
       ("\\097", #"a"),
       ("\\255", #"\255"),
       ("\\   \t\n\n \\A", #"A"),
       ("\\   \t\n\n \\z", #"z"),
       ("\\   \t\n\n \\@", #"@"),
       ("\\   \t\n\n \\~", #"~"),
       ("\\   \t\n\n \\\\n", #"\n"),
       ("\\   \t\n\n \\\\t", #"\t"),
       ("\\   \t\n\n \\\\\\", #"\\"),
       ("\\   \t\n\n \\\\\"", #"\""),
       ("\\   \t\n\n \\\\^@", #"\000"),
       ("\\   \t\n\n \\\\^A", #"\001"),
       ("\\   \t\n\n \\\\^Z", #"\026"),
       ("\\   \t\n\n \\\\^_", #"\031"), 
       ("\\   \t\n\n \\\\000", #"\000"),
       ("\\   \t\n\n \\\\097", #"a"),
       ("\\   \t\n\n \\\\255", #"\255")]
      
    val test24 = check' "test24"
      (fn _=>
       let val (arg, res) = (String.concat (map #1 argResList),
                             String.implode (map #2 argResList))
       in
         List.all (fn (x,y)=> String.fromString x = SOME (String.str y)) 
         argResList andalso
         String.fromString arg = SOME res
       end)

    val test25 = check' "test25" 
      (fn _=> 
       List.all (fn arg => String.fromString arg = NONE)
       ["\\",
     (* "\\a", 
        "\\b",
        "\\f",
        "\\v", *)
        "\\N",
        "\\T",
        "\\1",
        "\\11",
        "\\256",
        "\\999",
        "\\-65",
        "\\~65",
        "\\?",
        "\\^`",
        "\\^a",
        "\\^z",
        "\\   a",
        "\\   a\\B",
        "\\   \\"])


    val test25a = check' "test25a"
      (fn _=>
       String.fromString "abc\nA" = SOME "abc" andalso
       String.fromString "abc\tA" = SOME "abc" andalso
       String.fromString "\tABC" = NONE)
      
    val test26 = check' "test26"
      (fn _=>
       String.fromCString "\000\001\031" = NONE andalso
       String.fromCString "\\n\\t\\\"\\\\\\a\\b\\v\\f\\r\\?\\'\\x" = SOME "\n\t\"\\\a\b\v\f\r?'" andalso
       String.fromCString "\\xff\\x00\\xff\\010\\100" = SOME "\255\000\255\008@" andalso
       String.fromCString "?" = NONE andalso
       String.fromCString "\127" = NONE andalso
       String.fromCString "abcABCxyzXYZ012890" = SOME "abcABCxyzXYZ012890")
      

    val test27 = check' "test27"
      (fn _=>chk (charList2, String.fromCString, fn c=>(SOME (String.toCString c))) = [])

    val argResList = 
      [("\n", "\\n"),
       ("\t", "\\t"),
       ("\v", "\\v"),
       ("\b", "\\b"),
       ("\r", "\\r"),
       ("\f", "\\f"),
       ("\a", "\\a"),
       ("\\", "\\\\"),
       ("?", "\\?"),
       ("'", "\\'"),
       ("\"", "\\\"")]

    fun chk (s, t) = 
      let
        val szs = size s
        val szt = size t
        fun scan (acc, i) = 
          if i < szs then
            let val c = String.sub(s, i) 
            in
              if c <> String.sub(t, i) then
                scan (c::acc, i+1)
              else
                scan (acc, i+1)
            end
          else
            rev acc
      in
        if szs <> szt then 
          raise General.Fail "chk"
        else
          scan ([], 0)
      end

    val test28 = check' "test28"
      (fn _=>let 
         val (arg, res)  = (String.concat (map #1 argResList),
                            String.concat (map #2 argResList))
       in
         chk (String.toCString arg, res) = []
       end)

    val argResList = 
      [("\\n", "\n"),
       ("\\t", "\t"),
       ("\\v", "\v"),
       ("\\b", "\b"),
       ("\\r", "\r"),
       ("\\f", "\f"),
       ("\\a", "\a"),
       ("\\\\",  "\\"),
       ("\\?", "?"),
       ("\\'", "'"),
       ("\\\"", "\""),
       ("\\1", "\001"),
       ("\\11", "\009"),
       ("\\111", "\073"),
       ("\\1007", "\0647"),
       ("\\100A", "\064A"),
       ("\\0",   "\000"),
       ("\\377", "\255"),
       ("\\18", "\0018"),
       ("\\178", "\0158"),
       ("\\1C", "\001C"),
       ("\\17C", "\015C"),
       ("\\x0", "\000"),
       ("\\xff", "\255"),
       ("\\xFF", "\255"),
       ("\\x1", "\001"),
       ("\\x11", "\017"),
       ("\\xag", "\010g"),
       ("\\xAAg", "\170g"),
       ("\\x0000000a", "\010"),
       ("\\x0000000a2", "\162"),
       ("\\x0000000ag", "\010g"),
       ("\\x0000000A", "\010"),
       ("\\x0000000A2", "\162"),
       ("\\x0000000Ag", "\010g"),
       ("\\x00000000000000000000000000000000000000000000000000000000000000011+",
        "\017+")]


    val test29 = check' "test29"
      (fn _=>
      let val (arg, res) = (String.concat (map #1 argResList),
                            String.concat (map #2 argResList))
        fun chk [] = []
          | chk ((x,y)::rest) = 
          case String.fromCString x of
            NONE => x::chk rest
          | SOME x' => 
              if x' = y then chk rest
              else
                x::chk rest
      in
        chk argResList = [] andalso
        String.fromCString arg = SOME res andalso
        String.toCString (valOf (String.fromCString arg)) = String.toCString res andalso
        String.fromCString "abc\n0123" = SOME "abc" andalso
        String.fromCString "\000abc\n0123" = NONE andalso
        String.fromCString "abc'123" = SOME "abc'123" andalso
        String.fromCString "abc\\'123" = SOME "abc'123"
      end)


    val test30 = check' "test30"
      (fn _=>
       List.all
       (fn arg=>String.fromCString arg = NONE)
       ["",
        "\n",
        "\t",
        "\"",
        "?",
        "\\",
        "\\X",
        "\\=",
        "\\400",
        "\\777",
        "\\8",
        "\\9",
        "\\c",
        "\\d",
        "\\x",
        "\\x100",
        "\\xG"])

    (* Test map and mapi *)
    val add1 = fn c => chr (1 + ord c)
    val addi = fn (i, c) => chr (i + ord c)
    val s = "ABCDabcd"
    val test31 = check' "test31"
      (fn _ => (String.map add1 s)="BCDEbcde")
    val test32 = check' "test32"
      (fn _ => (String.map add1 "")="")
    val test33 = check' "test33"
      (fn _ => (String.mapi addi (s, 0, NONE))="ACEGegik")
    val test34 = check' "test34"
      (fn _ => (String.mapi addi (s, 1, NONE))="CEGegik")
    val test35 = check' "test35"
      (fn _ => (String.mapi addi (s, 7, NONE))="k")
    val test36 = checkexn' "test36" Subscript
      (fn _ => (String.mapi addi (s, ~1, NONE))) 
    val test37a = check' "test37a"
      (fn _ => (String.mapi addi (s, 8, NONE)) = "")
    val test37b = checkexn' "test37b" Subscript
      (fn _ => (String.mapi addi (s, 9, NONE)))
    val test38 = check' "test38"
      (fn _ => (String.mapi addi (s, 0, SOME 2))="AC")
    val test39 = check' "test39"
      (fn _ => (String.mapi addi (s, 6, SOME 2))="ik")
    val test40 = checkexn' "test40" Subscript
      (fn _ => (String.mapi addi (s, 7, SOME 2)))
    val test41 = check' "test41"
      (fn _ => (String.mapi addi (s, 2, SOME 0))="")
    val test42 = checkexn' "test42" Subscript
      (fn _ => (String.mapi addi (s, 2, SOME (~1))))

in
  val it = ()
end
