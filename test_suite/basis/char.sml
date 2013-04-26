(*  ==== Testing ====
 *
    Result: OK
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: char.sml,v $
 *  Revision 1.12  1998/04/17 11:30:37  mitchell
 *  [Bug #30338]
 *  Update test to allow quote in fromCString
 *
 *  Revision 1.11  1998/02/18  11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.10  1997/11/21  10:43:32  daveb
 *  [Bug #30323]
 *
 *  Revision 1.9  1997/08/05  09:28:46  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.8  1997/05/28  11:02:56  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.7  1996/10/22  13:20:18  jont
 *  Remove references to toplevel
 *
 *  Revision 1.6  1996/07/02  10:48:26  io
 *  more tests with fromCString or toCString
 *
 *  Revision 1.5  1996/05/23  10:52:43  io
 *  add more test
 *
 *  Revision 1.4  1996/05/22  12:02:09  daveb
 *  Renamed Shell.Module to Shell.Build
 *
 *  Revision 1.3  1996/05/16  12:28:11  io
 *  rm warnings, rm inconsistencies in fromString
 *
 *  Revision 1.2  1996/05/16  10:01:05  io
 *  chars -> char
 *
 *  Revision 1.1  1996/05/14  16:04:34  io
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
  fun range (from, to) p = 
    (from > to) orelse (p from) andalso (range (Char.succ from, to) p)
  infix 1 seq
  fun e1 seq e2 = e2;


  val untested = "UNTESTED"
  val s1 = "" (* 0 *)
  and s2 = "ABCDE\tFGHI" (* 10 *)
  and ABCDE = map Char.chr (iterate (65, 69))

  val test1 = check' "test1"
    (fn _=>
     size s1 = 0 andalso size s2 = 10 andalso
     Char.chr 0 = Char.minChar andalso
     Char.chr (Char.ord Char.minChar) = Char.minChar andalso
     Char.chr Char.maxOrd = Char.maxChar andalso
     Char.chr (Char.ord Char.maxChar) = Char.maxChar andalso
     Char.chr (Char.ord Char.maxChar) = Char.chr Char.maxOrd)
  val test1a = checkexn' "test1a" Chr 
    (fn _=>
     Char.succ Char.maxChar)
  val test1c = checkexn' "test1c" Chr
    (fn _=>
     Char.chr (Char.maxOrd + 1))
  val test1d = checkexn' "test1d" Chr
    (fn _=> Char.chr ~1)
  val test1e = checkexn' "test1e" Chr
    (fn _=>not (Char.succ Char.maxChar = Char.chr (Char.maxOrd + 1)))
  val test1f = check' "test1f" 
    (fn _=>Char.succ Char.minChar = Char.chr 1)

  val (two,zero,nine,letter_a,letter_z,letter_A,letter_Z) = 
    (50, 48, 57, 97, 97+(26-1), 65, 65+(26-1))
    (* ascii characters, and assumes linear within each range *)
    
  val (c_0, c_2, c_9, c_a, c_z, c_A, c_Z, c_space) =
    let fun foo x = (Char.chr o Char.ord) x in
      (foo #"0", foo #"2", foo #"9", foo #"a", foo #"z",
       foo #"A", foo #"Z", foo #" ")
    end

  val test1g = check' "test1g" 
    (fn _=>
     MLWorks.String.ord "2" = two andalso 
     Char.ord #"2" = two andalso
     MLWorks.String.ord "a" = letter_a andalso
     Char.ord #"a" = letter_a andalso
     MLWorks.String.ord "0" = zero andalso
     Char.ord #"0" = zero andalso
     MLWorks.String.ord "a" = letter_a andalso
     Char.ord #"a" = letter_a andalso
     MLWorks.String.ord "A" = letter_A andalso
     Char.ord #"A" = letter_A andalso
     MLWorks.String.ord "z" = letter_z andalso
     Char.ord #"z" = letter_z andalso
     MLWorks.String.ord "Z" = letter_Z andalso
     Char.ord #"Z" = letter_Z andalso
     c_0 = Char.chr zero andalso
     c_9 = Char.chr nine andalso
     c_a = Char.chr letter_a andalso
     c_z = Char.chr letter_z andalso
     c_A = Char.chr letter_A andalso
     c_Z = Char.chr letter_Z andalso
     not (Char.chr two = c_0) andalso
     not (Char.chr two < c_0) andalso
     Char.chr two > c_0 andalso
     not (Char.chr two < Char.chr two) andalso
     not (Char.chr two > c_9) andalso
     not (Char.chr two >= c_9) andalso
     Char.chr two < c_9 andalso
     Char.chr two <= c_9 andalso
     Char.pred (Char.pred (Char.chr two)) = c_0  andalso
     Char.succ (Char.succ (Char.chr zero)) = c_2)

  val test1h = checkexn' "test1h" Chr
    (fn _=>Char.succ Char.maxChar)

  val test1i = checkexn' "test1i" Chr
    (fn _=>Char.pred Char.minChar)

  val test2 = check' "test2" 
    (fn _=>
     Char.isUpper c_A andalso
     Char.isUpper c_Z andalso
     not (Char.isUpper (Char.chr letter_a)) andalso
     not (Char.isUpper (Char.chr two)) andalso
     not (Char.isUpper c_0) andalso
     not (Char.isUpper c_a) andalso
     not (Char.isUpper Char.maxChar) andalso
     range (c_A, c_Z) Char.isUpper andalso
     not (range (c_A, c_Z) Char.isLower) andalso
     range (c_a, c_z) Char.isLower andalso
     not (range (c_a, c_z) Char.isUpper))

  val test3 = check' "test3" 
    (fn _=>
     Char.toUpper (Char.toLower c_A) = c_A andalso
     Char.toUpper c_A = c_A andalso
     Char.toUpper c_space = c_space andalso
     Char.toLower c_space = c_space andalso
     Char.toUpper c_0 = c_0 andalso
     Char.toLower c_0 = c_0)

  val test4 = check' "test4"
    (fn _=>
     Char.compare (c_a, c_z) = LESS andalso
     Char.compare (c_z, c_a) = GREATER andalso
     Char.compare (c_a, c_a) = EQUAL)

  val test5 = check' "test5" 
    (fn _=>
     Char.< (c_a, c_z) andalso
     not (Char.< (c_z, c_a)) andalso
     not (Char.< (c_z, c_z)) andalso
     Char.< (c_0, c_9) andalso 
     Char.<= (c_0, c_9) andalso
     Char.<= (c_0, c_0) andalso
     not (Char.>= (c_0, c_9)) andalso
     Char.> (c_9, c_0) = Char.< (c_0, c_9) andalso
     Char.>= (c_9, c_0) = Char.<= (c_0, c_9))

  val test6 = check' "test6"
    (fn _=>not (Char.contains "" (Char.chr 65))
     andalso not (Char.contains "aBCDE" (Char.chr 65))
     andalso (Char.contains "ABCD" (Char.chr 67))
     andalso not (Char.contains "" #"\000")
     andalso not (Char.contains "" #"\255")
     andalso not (Char.contains "azAZ09" #"\000")
     andalso not (Char.contains "azAZ09" #"\255"))

  val test7 = check' "test7"
    (fn _=>Char.notContains "" (Char.chr 65)
     andalso Char.notContains "aBCDE" (Char.chr 65)
     andalso not (Char.notContains "ABCD" (Char.chr 67))
     andalso Char.notContains "" #"\000"
     andalso Char.notContains "" #"\255"
     andalso Char.notContains "azAZ09" #"\000"
     andalso Char.notContains "azAZ09" #"\255")

  fun mycontains s c = 
    let val stop = String.size s
      fun h i = i < stop andalso (c = String.sub(s, i) orelse h(i+1))
    in 
      h 0 
    end
      
  (* Check that p(c) = (mycontains s c) for all characters *)
  fun equivalent p s = 
    let fun h n =
      n > 255 orelse 
      (p (Char.chr n) = mycontains s (Char.chr n)) andalso h(n+1)
    in 
      h 0 
    end

  fun checkset n p s = check' n
    (fn _ => equivalent p s)
    
  val graphchars = "!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ\
   \[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
  val ascii = "\^@\^A\^B\^C\^D\^E\^F\^G\^H\t\n\^K\^L\^M\^N\^O\^P\
   \\^Q\^R\^S\^T\^U\^V\^W\^X\^Y\^Z\^[\^\\^]\^^\^_\
   \ !\"#$%&'()*+,-./0123456789:;<=>?@\
   \ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\127" 
  val lowerascii = "\^@\^A\^B\^C\^D\^E\^F\^G\^H\t\n\^K\^L\^M\^N\^O\^P\
   \\^Q\^R\^S\^T\^U\^V\^W\^X\^Y\^Z\^[\^\\^]\^^\^_\
   \ !\"#$%&'()*+,-./0123456789:;<=>?@\
   \abcdefghijklmnopqrstuvwxyz[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~\127" 

  val upperascii = "\^@\^A\^B\^C\^D\^E\^F\^G\^H\t\n\^K\^L\^M\^N\^O\^P\
   \\^Q\^R\^S\^T\^U\^V\^W\^X\^Y\^Z\^[\^\\^]\^^\^_\
   \ !\"#$%&'()*+,-./0123456789:;<=>?@\
   \ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~\127" 
    
  val whitespace = " \009\010\011\012\013";

  val allchars = 
    let fun h acc n = 
      let val c = Char.chr n in
        if c <= Char.minChar then c::acc
        else h (c::acc) (n-1)
      end
    in
      h [] Char.maxOrd 
    end
  
  val test8a = checkset "test8a" Char.isLower "abcdefghijklmnopqrstuvwxyz";
  val test8b = checkset "test8b" Char.isUpper "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  val test8c = checkset "test8c" Char.isDigit "0123456789";
  val test8d = checkset "test8d" Char.isAlpha "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  val test8e = checkset "test8e" Char.isHexDigit "0123456789abcdefABCDEF";
  val test8f = checkset "test8f" Char.isAlphaNum "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
  val test8g = checkset "test8g" Char.isPrint (whitespace ^ graphchars)
  val test8h = checkset "test8h" Char.isSpace whitespace
  val test8i = checkset "test8i" Char.isGraph graphchars
  val test8j = checkset "test8j" Char.isAscii ascii
  
  val test9 = check' "test9" 
    (fn _ => map Char.toLower (String.explode ascii) = String.explode lowerascii)
  val test10 = check' "test10" 
    (fn _ => map Char.toUpper (String.explode ascii) = String.explode upperascii)
  val test11 = check' "test11"
    (fn _ => 
     map Char.toUpper (String.explode graphchars)
     seq map Char.toLower (String.explode graphchars)
     seq true)

  val test12 = check' "test12"
    (fn _ => 
     map Char.pred (List.drop(allchars, 1)) = List.take(allchars, 255))
    
  val test13 = checkexn' "test13" Chr
    (fn _=>Char.pred Char.minChar seq "WRONG")

  val test14 = check' "test14"
    (fn _ => 
     map Char.succ (List.take(allchars, 255)) = List.drop(allchars, 1))
    
  val test15 = checkexn' "test15" Chr 
    (fn _=>Char.succ Char.maxChar seq "WRONG")

  val test16 = 
    let fun chk (arg, res) = Char.toString arg = res
    in check' "test16" 
      (fn _ => List.all chk 
       [(#"\n", "\\n"),
        (#"\t", "\\t"),
        (#"\000", "\\^@"),
        (#"\001", "\\^A"),
        (#"\031", "\\^_"),
        (#"\032", " "),
        (#"\126", "~"),
        (#"\\", "\\\\"),
        (#"\"", "\\\""),
        (#"A", "A"),
        (#"\127", "\\127"),
        (#"\128", "\\128"),
        (#"\255", "\\255")])
    end
  
  (* takes a string and does the identity using f and g ie (f (g s)) 
   * and returns the ones that fail to match 
   *)
  fun chk (s:string, f, g) = 
    let
      val sz = size s
      fun scan (acc, i) = 
        if i < sz then
          let val c = String.sub (s, i)
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
                    
    
  val test17 = check' "test17"
    (fn _=>
     let 
       val chars = String.implode (List.tabulate(256, Char.chr))
     in 
       chk (chars, Char.fromString, fn s => SOME (Char.toString s)) = []
     end)
  
  val test18 =   		     
    let fun chkFromString (arg, res) = Char.fromString arg = SOME res
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
         ("\\0000", #"\000"),
         ("\\0001", #"\000"),
         ("\\127", #"\127"),
         ("\\1278", #"\127"),
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
         ("\\   \t\n\n \\\\000a", #"\000"),
         ("\\   \t\n\n \\\\097b", #"a"),
         ("\\   \t\n\n \\\\255c", #"\255")]
    in 
      check' "test18" 
      (fn _ => List.all chkFromString argResList)
    end
    
  val test19 = check' "test19" 
    (fn _ => List.all (fn arg => Char.fromString arg = NONE)
     ["\\",
      (* "\\a", *)
      (* "\\b", *)
      (* "\\f", *)
      (* "\\v", *)
      "\000",
      "\001",
      "\127",
      "\128",
      "\\N",
      "\\T",
      "\\1",
      "\\11",
      "\\256",
      "\\-65",
      "\\~65",
      "\\?",
      "\\^`",
      "\\^a",
      "\\^z",
      "\\   a",
      "\\   a\\B",
      "\\   \\"
      ])

    val test20 = check' "test20"
      (fn _=>
       List.all (fn (x,y)=> Char.fromCString x = SOME y)
       [("A", #"A"),
        ("z", #"z"),
        ("@", #"@"),
        ("\\?", #"?"),
        ("'", #"'"),
        ("~", #"~"),
        ("\\n", #"\n"),
        ("\\t", #"\t"),
        ("\\\\", #"\\"),
        ("\\\"", #"\""),
        ("\\000", #"\000"),
        ("\\0000", #"\000"),
        ("\\0001", #"\000"),
        ("\\127", #"W"),
        ("\\1278", #"W"),
        ("\\255", #"\173")])
        

    val test21 = check' "test21" 
      (fn _=>
       List.all (fn x=> Char.fromCString x = NONE)
       ["\\",
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
        "\\xG",
        "\\x+ff",
        "\\x-ff",
        "\\x~ff",
        "\\   \t\n\n \\A",
        "?"
        ])

in
  val it = ()
end
