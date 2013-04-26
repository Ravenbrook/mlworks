(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: real_vectors.sml,v $
 *  Revision 1.5  1998/02/18 11:56:01  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.4  1997/11/21  15:01:29  daveb
 *  [Bug #30323]
 *
 *  Revision 1.3  1997/08/08  14:10:27  brucem
 *  [Bug #30086]
 *  Test map and mapi.
 *
 *  Revision 1.2  1997/05/28  15:55:44  matthew
 *  Updating
 *
 *  Revision 1.1  1997/01/30  14:45:30  andreww
 *  new unit
 *  adapted Sestoft's vector test suite for realvectors.
 *
 *
 *
*)

(* test/vector.sml -- some test cases for Vector 
   PS 1994-12-10, 1995-06-14 
   modified for MLWorks Fri May 17 11:17:17 1996
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

fun checkrange bounds = check o range bounds;


local
    open RealVector;
    infix 9 sub;
    infix eq
    val op eq = Real.==
in

infix ==
fun a == b =
  RealVector.length a = RealVector.length b
  andalso
  let
    fun scan i =
      if i = RealVector.length a
        then true
      else
        RealVector.sub (a,i) eq (RealVector.sub (b,i))
        andalso scan (i+1)
  in
    scan 0
  end

fun listEq ([],[]) = true
  | listEq (h::t,h'::t') = h eq h' andalso listEq(t,t')
  | listEq _ = false
fun listEq' ([],[]) = true
  | listEq' ((a,b)::t,(a',b')::t') = 
  a=a' andalso b eq b' andalso listEq'(t,t')
  | listEq' _ = false
  
val a = fromList [0.0,1.0,2.0,3.0,4.0,5.0,6.0];
val b = fromList [44.0,55.0,66.0];
val c = fromList [0.0,1.0,2.0,3.0,4.0,5.0,6.0];

val test1 = check'(fn _ => not(a == b));
val test2 = check'(fn _ => a == c);

val d = tabulate(100, fn i => real(i mod 7));

val test3 = check'(fn _ => d sub 27 eq 6.0);

val test4a = (tabulate(maxLen+1, fn i => real i) seq "WRONG")
             handle Size => "OK" | _ => "WRONG";

val test4b = (tabulate(~1, fn i => real i)       seq "WRONG")
             handle Size => "OK" | _ => "WRONG";

val test4c = check'(fn _ => length (tabulate(0, fn i => real(i div 0))) = 0);

val test5 = check'(fn _ => length (fromList []) = 0 andalso length a = 7);

val test6a = (c sub ~1 seq "WRONG") handle Subscript => "OK" | _ => "WRONG";
val test6b = (c sub 7  seq "WRONG") handle Subscript => "OK" | _ => "WRONG";
val test6c = check'(fn _ => c sub 0 eq 0.0);

val e = concat [d, b, d];

val test7 = check'(fn _ => length e = 203);


val test8 = check'(fn _ => length (concat []) = 0);

val f = extract (e, 100, SOME 3); 

val test9 = check'(fn _ => f == b);

val test9a = check'(fn _ => e == extract(e, 0, SOME (length e)) 
		    andalso e == extract(e, 0, NONE));
val test9b = check'(fn _ => fromList [] == extract(e, 100, SOME 0));
val test9c = (extract(e, ~1, SOME (length e))  seq "WRONG") 
             handle Subscript => "OK" | _ => "WRONG"
val test9d = (extract(e, length e + 1, SOME 0)  seq "WRONG") 
             handle Subscript => "OK" | _ => "WRONG"
val test9e = (extract(e, 0, SOME (length e+1)) seq "WRONG") 
             handle Subscript => "OK" | _ => "WRONG"
val test9f = (extract(e, 20, SOME ~1)        seq "WRONG") 
             handle Subscript => "OK" | _ => "EXN"
val test9g = (extract(e, ~1, NONE)  seq "WRONG") 
             handle Subscript => "OK" | _ => "WRONG"
val test9h = (extract(e, length e + 1, NONE)  seq "WRONG") 
             handle Subscript => "OK" | _ => "EXN"
val test9i = check'(fn _ => fromList [] == extract(e, length e, SOME 0)
		    andalso fromList [] == extract(e, length e, NONE));

  (* Test map and mapi *)
  val v = (fromList [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0]) ;

  val add1 = (fn i => i + 1.0) ;

  val addi = (fn (i, j) => Real.fromInt i + j) ;

  val testAa = check'
         (fn _ => (map add1 v) == fromList [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]) ;
  val testAb = check'
         (fn _ => (map add1 (fromList [])) == (fromList [])) ;
  val testAc = check'
         (fn _ => (mapi addi (v, 0, NONE)) == fromList [0.0,2.0,4.0,6.0,8.0,10.0,12.0,14.0]);
  val testAd = check'
         (fn _ => (mapi addi (v, 1, NONE)) == fromList [2.0,4.0,6.0,8.0,10.0,12.0,14.0]);
  val testAe = check'
         (fn _ => (mapi addi (v, 7, NONE)) == fromList [14.0]);
  val testAf = 
         (ignore(mapi addi (v, ~1, NONE)); "WRONG") handle Subscript => "OKEXN"
                                                  | _ => "WRONG EXN" ;
  val testAga = check'
         (fn _ => (mapi addi (v, 8, NONE)) == fromList [])
  val testAgb =
         (ignore(mapi addi (v, 9, NONE)); "WRONG") handle Subscript => "OKEXN"
                                                  | _ => "WRONG EXN" ;
  val testAh =
         check' (fn _ => mapi addi (v, 0, SOME 2) == fromList [0.0, 2.0]) ;
  val testAi =
         check' (fn _ => mapi addi (v, 6, SOME 2) == fromList [12.0,14.0]) ;
  val testAj =
         (ignore(mapi addi (v,7,SOME 2)); "WRONG") handle Subscript => "OKEXN"
                                                 | _ => "WRONG EXN" ;
  val testAk = check'
         (fn _ => mapi addi (v, 2, SOME 0) == fromList [])
  val testAl =
         (ignore(mapi addi (v, 2, SOME ~1)); "WRONG") handle Subscript => "OKEXN"
                                                 | _ => "WRONG EXN" ;


end;
