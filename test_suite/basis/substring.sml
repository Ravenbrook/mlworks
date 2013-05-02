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
 *  $Log: substring.sml,v $
 *  Revision 1.10  1998/02/18 11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.9  1997/11/21  10:49:20  daveb
 *  [Bug #30323]
 *
 *  Revision 1.8  1997/08/11  09:25:15  brucem
 *  [Bug #30094]
 *  Test Substring.span
 *
 *  Revision 1.7  1997/08/05  09:56:24  brucem
 *  [Bug #30004]
 *  Suppress printing structure contents to prevent spurious failure.
 *
 *  Revision 1.6  1997/05/28  13:26:53  jont
 *  [Bug #30090]
 *  Remove uses of MLWorks.IO
 *
 *  Revision 1.5  1996/10/22  13:21:36  jont
 *  Remove references to toplevel
 *
 *  Revision 1.4  1996/10/02  20:45:57  io
 *  [Bug #1630]
 *  fix typo in sub boundary case for raising Subscript and expose more hidden tests
 *
 *  Revision 1.3  1996/07/29  20:14:25  io
 *  [Bug #1509]
 *  add isPrefix tests
 *
 *  Revision 1.2  1996/06/05  01:35:23  io
 *  modify Module to Build
 *
 *  Revision 1.1  1996/05/17  13:00:58  io
 *  new unit
 *
 *)


local
  infix 1 seq
  fun e1 seq e2 = e2;
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
      
  fun base2 (a, b) = (Substring.base a, Substring.base b)
  fun extract (sa:string, i, SOME l) = Substring.substring (sa, i, l)
    | extract (sa, i, NONE) = Substring.substring (sa, i, String.size sa - i)
    
  val s1 = ""				(* String.size s1 =  0 *)
  and s2 = "ABCDE\tFGHI";		(* String.size s2 = 10 *)
  val ss1 = Substring.all s1			(* size s1 =  0 *)
  and ss2 = Substring.all s2;			(* size s2 = 10 *)
    
  val sa = "AAAAaAbAABBBB";		(* String.size sa = 14 *)
  (*            45678      *)
    
  val ssa1 = extract(sa, 4, SOME 0)	(* size ssa1 = 0 *)
  val ssa2 = extract(sa, 4, SOME 5)	(* size ssa2 = 5 *)
    
  val ss3 = extract("junk this is a   (clear)textjunk", 4, SOME 24);
(*                       456789012345678901234567        *)


  val test1a = 
    check' "test1a" (fn _ => 
	   (s2, 10, 0) = Substring.base(extract (s2, 10, SOME 0))
	   andalso (s2, 10, 0) = Substring.base(extract (s2, 10, NONE))
	   andalso (s2, 0,  0) = Substring.base(extract (s2, 0, SOME 0))
	   andalso (s2, 4,  3) = Substring.base(extract(s2, 4, SOME 3))
	   andalso (s2, 4,  6) = Substring.base(extract(s2, 4, SOME 6))
	   andalso (s2, 4,  6) = Substring.base(extract(s2, 4, NONE))
	   andalso (s2, 0, 10) = Substring.base(extract(s2, 0, SOME 10))
	   andalso (s2, 0, 10) = Substring.base(extract(s2, 0, NONE)));

    
  val test1b = checkexn' "test1b" Subscript (fn ()=>extract(s2, ~1, SOME 0))
  val test1c = checkexn' "test1c" Subscript (fn ()=>extract(s2, 11, SOME 0))
  val test1d = checkexn' "test1d" Subscript (fn ()=>extract(s2, 0, SOME 11))
  val test1e = checkexn' "test1e" Subscript (fn ()=>extract(s2, 10, SOME 1))
  val test1f = checkexn' "test1f" Subscript (fn ()=>extract(s2, ~1, NONE))
  val test1g = checkexn' "test1g" Subscript (fn ()=>extract(s2, 11, NONE))

  val test1h =
    check' "test1h" (fn _ =>
	   Substring.string ssa1 = ""
	   andalso Substring.string ssa2 = "aAbAA"
	   andalso s1 = Substring.string (Substring.all s1) 
	   andalso s2 = Substring.string (Substring.all s2));
    
  val test2a = 
    check' "test2a" (fn _ => 
	   Substring.string(Substring.triml 6 ss2) = "FGHI"
	   andalso s2 = Substring.string(Substring.triml 0 ss2)
	   andalso s1 = Substring.string(Substring.triml 0 ss1)
	   andalso (s2, 10, 0) = Substring.base(Substring.triml 10 ss2)
	   andalso (s2, 10, 0) = Substring.base(Substring.triml 11 ss2)
	   andalso (sa, 6, 3) = Substring.base(Substring.triml 2 ssa2)
	   andalso (sa, 9, 0) = Substring.base(Substring.triml 5 ssa2)
	   andalso (sa, 9, 0) = Substring.base(Substring.triml 6 ssa2));
    
  val test2b = checkexn' "test2b" Subscript (fn ()=>Substring.triml ~1 ss2)
  val test2c = checkexn' "test2c" Subscript (fn ()=>Substring.triml ~1 ssa2)
      
  val test3a = 
    check' "test3a" (fn _ => 
	   Substring.string(Substring.trimr 6 ss2) = "ABCD"
	   andalso s2 = Substring.string(Substring.trimr 0 ss2)
	   andalso s1 = Substring.string(Substring.trimr 0 ss1)
	   andalso (s2, 0, 0) = Substring.base(Substring.trimr 10 ss2)
	   andalso (s2, 0, 0) = Substring.base(Substring.trimr 11 ss2)
	   andalso (sa, 4, 3) = Substring.base(Substring.trimr 2 ssa2)
	   andalso (sa, 4, 0) = Substring.base(Substring.trimr 5 ssa2)
	   andalso (sa, 4, 0) = Substring.base(Substring.trimr 6 ssa2));
    
  val test3b = checkexn' "test3b" Subscript (fn ()=>Substring.trimr ~1 ss2)
  val test3c = checkexn' "test3c" Subscript (fn ()=>Substring.trimr ~1 ssa2)
     
  val test4 = 
    check' "test4a" (fn _ => 
	   Substring.isEmpty ss1 
	   andalso not (Substring.isEmpty ss2)
	   andalso Substring.isEmpty ssa1
	   andalso not (Substring.isEmpty ssa2));
    
  val test5a = 
    check' "test5a" (fn _ =>
	   case Substring.getc ssa1 of NONE => true | _ => false);
    
  val test5b = 
    check' "test6a" (fn _ =>
	   case Substring.getc ssa2 of
             NONE             => false 
           | SOME(#"a", rest) => "AbAA" = Substring.string rest
           | _                => false);
    
  val test6 = 
    check' "test6" (fn _ =>
	   Substring.first ssa1 = NONE
	   andalso Substring.first ssa2 = SOME #"a")
    
  val test7 = 
    check' "test7" (fn _ => (Substring.size ss1 = 0 andalso Substring.size ss2 = 10
		    andalso Substring.size ssa1 = 0 andalso Substring.size ssa2 = 5));
    
  val test8a = 
    check' "test8a" (fn _ => (Substring.sub(ss2,6) = Char.chr 70 andalso Substring.sub(ss2,9) = Char.chr 73
		    andalso Substring.sub(ssa2, 1) = Char.chr 65));
  val test8b = checkexn' "test8b" Subscript (fn ()=>Substring.sub(ss1, 0))
  val test8c = checkexn' "test8c" Subscript (fn ()=>Substring.sub(ss2, ~1))
  val test8d = checkexn' "test8d" Subscript (fn ()=>Substring.sub(ss2, 10))
  val test8e = checkexn' "test8e" Subscript (fn ()=>Substring.sub(ssa2, ~1))
  val test8f = checkexn' "test8f" Subscript (fn ()=>Substring.sub(ssa2, 5))
      
  val test9a = 
    check' "test9a" (fn _ => 
	   Substring.base ss2 = Substring.base(Substring.slice(ss2, 0, SOME (Substring.size ss2)))
	   andalso Substring.base ss2 = Substring.base(Substring.slice(ss2, 0, NONE))
	   andalso (s2, 10, 0) = Substring.base(Substring.slice(ss2, Substring.size ss2, SOME 0))
	   andalso (s2, 10, 0) = Substring.base(Substring.slice(ss2, Substring.size ss2, NONE))
	   andalso Substring.base ss1 = Substring.base(Substring.slice(ss1, 0, SOME 0))
	   andalso Substring.base ss1 = Substring.base(Substring.slice(ss1, 0, NONE)));
    
  val test9b = 
    check' "test9b" (fn _ => 
           (sa, 4, 5) = Substring.base(Substring.slice(ssa2, 0, SOME 5))
	   andalso (sa, 4, 5) = Substring.base(Substring.slice(ssa2, 0, NONE))
	   andalso (sa, 4, 0) = Substring.base(Substring.slice(ssa2, 0, SOME 0))
	   andalso (sa, 9, 0) = Substring.base(Substring.slice(ssa2, 5, SOME 0))
	   andalso (sa, 9, 0) = Substring.base(Substring.slice(ssa2, 5, NONE))
	   andalso (sa, 5, 3) = Substring.base(Substring.slice(ssa2, 1, SOME 3))
	   andalso (sa, 5, 4) = Substring.base(Substring.slice(ssa2, 1, SOME 4))
	   andalso (sa, 5, 4) = Substring.base(Substring.slice(ssa2, 1, NONE)));
    
  val test9c = checkexn' "test9c" Subscript (fn ()=>Substring.slice(ssa2, ~1, SOME 0))
  val test9d = checkexn' "test9d" Subscript (fn ()=>Substring.slice(ssa2, 6, SOME 0))
  val test9e = checkexn' "test9e" Subscript (fn ()=>Substring.slice(ssa2, 0, SOME 6))
  val test9f = checkexn' "test9f" Subscript (fn ()=>Substring.slice(ssa2, 5, SOME 1))
  val test9g = checkexn' "test9g" Subscript (fn ()=>Substring.slice(ssa2, ~1, NONE))
  val test9h = checkexn' "test9h" Subscript (fn ()=>Substring.slice(ssa2, 6, NONE))
      
  val test12 =
    check' "test12" (fn _ => 
                     Substring.concat [] = ""
	   andalso Substring.concat [ssa1, ssa1, ssa1] = ""
	   andalso Substring.concat [ssa2, ssa2, ssa2] = "aAbAAaAbAAaAbAA"
	   andalso Substring.concat [ssa2, ssa1, ss2, ss1] = "aAbAAABCDE\tFGHI");
    
  val test13 = 
    check' "test13" (fn _ => 
	   Substring.explode ss1 = []
	   andalso Substring.explode ssa1 = []
	   andalso Substring.explode ssa2 = [#"a", #"A", #"b", #"A", #"A"]);
    
  val test14 = 
    check' "test14" (fn _ => 
	   EQUAL = Substring.compare(ssa1,ssa1) andalso EQUAL = Substring.compare(ssa2,ssa2)
	   andalso LESS = Substring.compare(Substring.triml 1 ssa2, ssa2)
	   andalso GREATER = Substring.compare(ssa2, Substring.triml 1 ssa2)
	   andalso LESS = Substring.compare(Substring.trimr 1 ssa2, ssa2)
	   andalso GREATER = Substring.compare(ssa2, Substring.trimr 1 ssa2)
	   andalso LESS = Substring.compare(Substring.all "AB", ssa2)
	   andalso GREATER = Substring.compare(ssa2,Substring.all "AB"));
    
  fun finda c = c <> #"A";
  fun findb c = c <> #"B";
    
  val test15 = 
    check' "test15" (fn _ =>
	   (sa, 5, 4) = Substring.base(Substring.dropl finda ssa2)
	   andalso (sa, 9, 0) = Substring.base(Substring.dropl findb ssa2)
	   andalso Substring.base ssa1 = Substring.base(Substring.dropl finda ssa1));
    
  val test16 = 
    check' "test16" (fn _ =>
	   (sa, 4, 5) = Substring.base(Substring.dropr finda ssa2)
	   andalso (sa, 4, 0) = Substring.base(Substring.dropr findb ssa2)
	   andalso Substring.base ssa1 = Substring.base(Substring.dropr finda ssa1));
    
  val test17 = 
    check' "test17" (fn _ =>
	   (sa, 4, 1) = Substring.base(Substring.takel finda ssa2)
	   andalso (sa, 4, 5) = Substring.base(Substring.takel findb ssa2)
	   andalso Substring.base ssa1 = Substring.base(Substring.takel finda ssa1));
    
  val test18 = 
    check' "test18" (fn _ =>
	   (sa, 9, 0) = Substring.base(Substring.taker finda ssa2)
	   andalso (sa, 4, 5) = Substring.base(Substring.taker findb ssa2)
	   andalso Substring.base ssa1 = Substring.base(Substring.taker finda ssa1));
    
  val test19 =
    check' "test19" (fn _ => 
	   ((sa, 4, 1), (sa, 5, 4)) = base2(Substring.splitl finda ssa2)
	   andalso ((sa, 4, 5), (sa, 9, 0)) = base2(Substring.splitl findb ssa2)
	   andalso base2(ssa1, ssa1) = base2(Substring.splitl finda ssa1));
    
  val test20 =
    check' "test20" (fn _ => 
	   ((sa, 4, 5), (sa, 9, 0)) = base2(Substring.splitr finda ssa2)
	   andalso ((sa, 4, 0), (sa, 4, 5)) = base2(Substring.splitr findb ssa2)
	   andalso base2(ssa1, ssa1) = base2 (Substring.splitr finda ssa1));
    
  val test21 = 
    check' "test21" (fn _ => 
	   ((sa, 4, 0), (sa, 4, 5)) = base2(Substring.position "" ssa2)
	   andalso ((sa, 4, 1), (sa, 5, 4)) = base2(Substring.position "Ab" ssa2)
	   andalso ((sa, 4, 5), (sa, 9, 0)) = base2(Substring.position "B" ssa2)
	   andalso ((sa, 4, 5), (sa, 9, 0)) = base2(Substring.position "AAB" ssa2)
	   andalso ((sa, 4, 0), (sa, 4, 5)) = base2(Substring.position "aA" ssa2)
	   andalso ((sa, 4, 2), (sa, 6, 3)) = base2(Substring.position "bAA" ssa2)
	   andalso (Substring.base ssa1, Substring.base ssa1) = base2(Substring.position "A" ssa1)
	   andalso (Substring.base ssa1, Substring.base ssa1) = base2(Substring.position "" ssa1));
    
  (* For the pre-November 1995 version of Substring.position: 
val test21 = 
   check' "test21" (fn _ => 
   (sa, 4, 5) = Substring.base(Substring.position "" ssa2)
   andalso (sa, 5, 4) = Substring.base(Substring.position "Ab" ssa2)
   andalso (sa, 9, 0) = Substring.base(Substring.position "B" ssa2)
   andalso (sa, 9, 0) = Substring.base(Substring.position "AAB" ssa2)
   andalso (sa, 4, 5) = Substring.base(Substring.position "aA" ssa2)
   andalso (sa, 6, 3) = Substring.base(Substring.position "bAA" ssa2)
   andalso Substring.base ssa1 = Substring.base(Substring.position "A" ssa1)
   andalso Substring.base ssa1 = Substring.base(Substring.position "" ssa1));
   *)
    
  val test22a = 
    check' "test22a" (fn _ => 
	   (Substring.translate (fn _ => "") ssa2 = ""
	    andalso Substring.translate (fn x => String.str x) ssa1 = ""
	    andalso Substring.translate (fn x => String.str x) ssa2 = Substring.string ssa2));
    
  val test22b = 
    check' "test22b" (fn _ => 
	   (Substring.translate (fn c => if c = #"b" then "XYZ " else String.str c) ssa2
            = "aAXYZ AA"));
    
  val test23 = 
    check' "test23" (fn _ => 
	   (List.null(Substring.tokens Char.isSpace ssa1)
	    andalso List.null(Substring.tokens (Char.contains "Aab") ssa2)
	    andalso map Substring.string (Substring.tokens (fn c => c = #"A") ssa2) = ["a","b"]));
    
  val test24 = 
    check' "test24" (fn _ => 
	   (map Substring.base (Substring.fields Char.isSpace ssa1) = [Substring.base ssa1]
	    andalso map Substring.base (Substring.fields (Char.contains "Aab") ssa2)
            = [(sa,4,0),(sa,5,0),(sa,6,0),(sa,7,0),(sa,8,0),(sa,9,0)]
	    andalso map Substring.string (Substring.fields (fn c => c = #"A") ssa2) 
            = ["a","b","",""]));
    
  val test25 = 
    check' "test25" (fn _ => 
	   List.null(Substring.tokens (fn _ => true) ss3)
	   andalso List.null(Substring.tokens (fn _ => false) (Substring.all ""))
	   andalso List.null(Substring.tokens (Char.contains " ()") (Substring.all "(()())(( ()"))
	   andalso ["this","is","a","clear","text"] = 
           map Substring.string (Substring.tokens (Char.contains " ()") ss3));
    
  local 
    val v = ref 0
    fun setv c = v := Char.ord c;
  in 
    
    val test26a = 
      check' "test26a" (fn _ => 
             (v := 0;
              Substring.foldl (fn (x, _) => setv x) () ssa2;
              !v = 65));
      
    val test26b = 
      check' "test26b" (fn _ => 
             String.implode(Substring.foldl (op ::) [] ssa2) = "AAbAa");
      
    val test27a = 
      check' "test27a" (fn _ => 
             (v := 0;
              Substring.foldr (fn (x, _) => setv x) () ssa2;
              !v = 97));
      
    val test27b = 
      check' "test27b" (fn _ => 
                        String.implode(Substring.foldr (op ::) [] ssa2) = "aAbAA");
      
    val test28 = 
      check' "test28" (fn _ => 
             (v := 0;
              Substring.app setv ssa2;
              !v = 65));
  end

  val test29a = 
    check' "test29a" (fn _ =>
	   base2(Substring.splitAt(ssa1, 0)) = ((sa, 4, 0), (sa, 4, 0))
	   andalso base2(Substring.splitAt(ssa2, 0)) = ((sa, 4, 0), (sa, 4, 5))
	   andalso base2(Substring.splitAt(ssa2, 1)) = ((sa, 4, 1), (sa, 5, 4))
	   andalso base2(Substring.splitAt(ssa2, 4)) = ((sa, 4, 4), (sa, 8, 1))
	   andalso base2(Substring.splitAt(ssa2, 5)) = ((sa, 4, 5), (sa, 9, 0)));
  val test29b = checkexn' "test29b" Subscript (fn ()=>Substring.splitAt(ssa2, ~1))
  val test29c = checkexn' "test29c" Subscript (fn ()=>Substring.splitAt(ssa2, 6))
      
  val test30a = 
    check' "test30a" (fn _ => 
	   (s2, 10, 0) = Substring.base(Substring.substring(s2, 10, 0))
	   andalso (s2, 0,  0) = Substring.base(Substring.substring(s2, 0, 0))
	   andalso (s2, 4,  3) = Substring.base(Substring.substring(s2, 4, 3))
	   andalso (s2, 4,  6) = Substring.base(Substring.substring(s2, 4, 6))
	   andalso (s2, 0, 10) = Substring.base(Substring.substring(s2, 0, 10)));
    
  val test30b = checkexn' "test30b" Subscript 
    (fn ()=>Substring.substring(s2, ~1, 0))
  val test30c = checkexn' "test30c" Subscript 
    (fn ()=> Substring.substring(s2, 11, 0))
  val test30d = checkexn' "test30d" Subscript
    (fn ()=>Substring.substring(s2, 0, 11))
  val test30e = checkexn' "test30e" Subscript 
    (fn ()=>Substring.substring(s2, 10, 1))

  val test31 = 
    check' "test31" 
    (fn _=>
     not (Substring.isPrefix "abc" (Substring.substring (s2, 10, 0))) andalso
     Substring.isPrefix "" (Substring.substring (s2, 0, 0)) andalso
     Substring.isPrefix "aAbAA" ssa2 andalso
     Substring.isPrefix "aAbA" ssa2 andalso
     not (Substring.isPrefix "baba" ssa2) andalso
     not (Substring.isPrefix "any" (Substring.extract ("1234", 4, NONE))) andalso
     not (Substring.isPrefix "ha" (Substring.extract ("blahblah", 7, NONE))))

  val test32 = checkexn' "test32" Subscript 
    (fn ()=>Substring.sub (Substring.substring ("abcdefghijklmnop", 2,2), 2))

  (* Test Substring.span *)
  local
    val s1 = Substring.substring ("ABCDabcd", 1, 2)
    val s2 = Substring.substring ("ABCDabcd", 4, 2)
    val s3 = Substring.substring ("ABCDabcd", 1, 5) (* span (s1, s2) *)
    val s4 = Substring.substring ("ABCDabcd", 0, 1)
    val s5 = Substring.substring ("ABCDabcd", 1, 0) (* span (s1, s4) *)
    val s6 = Substring.substring ("BBCDabcd", 4, 2)
  in
    val test33 = check' "test33"
      (fn _ => Substring.span(s1, s2)=s3)
    val test34 = check' "test34"
      (fn _ => Substring.span(s1, s4)=s5)
    val test35 = checkexn' "test35" Substring.Span
      (fn _ => Substring.span(s2, s1))
    val test36 = checkexn' "test36" Substring.Span
      (fn _ => Substring.span(s1, s6))
   end (* of test Substring.span *)
in
  val it = ()
end
