(***********************************************************************)
(*                                                                     *)
(*                         Caml Special Light                          *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1995 Institut National de Recherche en Informatique et   *)
(*  Automatique.  Distributed only by permission.                      *)
(*                                                                     *)
(***********************************************************************)
(* compatability *)
(*
*)

val sub1 = Array.sub
val update1 = Array.update
val array1 = Array.array
val sin = Math.sin
val cos = Math.cos

local
fun abs_real(x:real) = if x < 0.0 then ~x else x
fun print_real (x:real) = print(Real.toString x)

(* $Id: fft.sml,v 1.3 1998/02/22 17:01:49 mitchell Exp $ *)

val pi = 3.14159265358979323846

val tpi = 2.0 * pi

fun for(start,stop,f) = 
    let fun loop i = if i > stop then () else (ignore(f i); loop (i+1))
    in
	loop start
    end

val print_string : string -> unit = print
val print_int : int -> unit = print_string o Int.toString
val print_newline : unit -> unit = fn _ => print_string "\n"

fun dump pxr pxi = 
  for(0,15,fn i => 
      (print_int i; 
       print " ";
       print_real (sub1(pxr,i+1)); 
       print " "; 
       print_real (sub1(pxi,i+1));
       print_newline()))


fun fft px py np =
let val i = ref 2 
    val m = ref 1 
  
    val _ = 
	while (!i < np) do
	    (i := !i + !i; 
	     m := !m + 1)
    val n = !i 
in  
  if n <> np then (
    for (np+1,n,fn i=>
      (update1(px,i,0.0); 
       update1(py,i,0.0)));
    print_string "Use "; print_int n;
    print_string " point fft"; print_newline()
  ) else ();

  let val n2 = ref(n+n) 
  in
    for(1,!m-1,fn k =>
    let val _ = n2 := !n2 div 2
	val n4 = !n2 div 4 
	val e  = tpi / (real (!n2 ))
    in
      for(1,n4,fn j =>
      let val a = e * real(j - 1) 
	  val a3 = 3.0 * a 
	  val cc1 = cos(a) 
	  val ss1 = sin(a) 
	  val cc3 = cos(a3)
	  val ss3 = sin(a3)
	  val is = ref j 
	  val id = ref(2 * !n2) 
      in
        while !is < n do
          let val i0r = ref (!is)
	  in
	      while !i0r < n do
		  let val i0 = !i0r 
		      val i1 = i0 + n4 
		      val i2 = i1 + n4 
		      val i3 = i2 + n4 
		      val r1 = sub1(px,i0) - sub1(px,i2) 
		      val _ = update1(px,i0,sub1(px,i0) + sub1(px,i2))
		      val r2 = sub1(px,i1) - sub1(px,i3) 
		      val _ = update1(px,i1,sub1(px,i1) + sub1(px,i3))
		      val s1 = sub1(py,i0) - sub1(py,i2) 
		      val _ = update1(py,i0,sub1(py,i0) + sub1(py,i2))
		      val s2 = sub1(py,i1) - sub1(py,i3) 
		      val _ = update1(py,i1,sub1(py,i1) + sub1(py,i3))
		      val s3 = r1 - s2 
		      val r1 = r1 + s2 
		      val s2 = r2 - s1 
		      val r2 = r2 + s1 
		  in
		      update1(px,i2,r1*cc1 - s2*ss1);
		      update1(py,i2,~s2*cc1 - r1*ss1);
		      update1(px,i3,s3*cc3 + r2*ss3);
		      update1(py,i3,r2*cc3 - s3*ss3);
		      i0r := i0 + !id
		  end;
	     is := 2 * !id - !n2 + j; 
	     id := 4 * !id
	     (* ; dump px py *)
	  end
      end)
    end)
  end;

(************************************)
(*  Last stage, length=2 butterfly  *)
(************************************)

  let val is = ref 1 
      val id = ref 4 
  in
      while !is < n do
	  let val i0r = ref (!is)
	  in
	      while !i0r <= n do
		  let val i0 = !i0r 
		      val i1 = i0 + 1 
		      val r1 = sub1(px,i0) 
		      val _ = update1(px,i0,r1 + sub1(px,i1))
		      val _ = update1(px,i1,r1 - sub1(px,i1))
		      val r1 = sub1(py,i0) 
		  in
		      update1(py,i0,r1 + sub1(py,i1));
		      update1(py,i1,r1 - sub1(py,i1));
		      i0r := i0 + !id
		  end;
	      is := 2 * !id - 1; 
	      id := 4 * !id
	  end
  end;
(*
  print "\nbutterfly\n";
  dump px py;
*)
(*************************)
(*  Bit reverse counter  *)
(*************************)

  let val j = ref 1 
  in
    for (1,n-1,fn i =>
    (if i < !j then (
      let val xt1 = sub1(px,!j) 
	  val xt2 = sub1(px,i)
	  val _ = update1(px,!j,xt2)
	  val _ = update1(px,i,xt1)
	  val yt1 = sub1(py,!j) 
	  val yt2 = sub1(py,i)
      in
	  update1(py,!j,yt2);
	  update1(py,i,yt1)
      end)
     else ();
     let val k = ref(n div 2) 
     in
        while !k < !j do (j := !j - !k; k := !k div 2);
        j := !j + !k
     end));
(*
     print "\nbit reverse\n";
     dump px py;
*)
     n
  end
end;

fun test np =
  (print_int np; print_string "... "; 
  let val enp = real np 
      val npm = np div 2 - 1
      val pxr = array1 ((np+2), 0.0)
      val pxi = array1 ((np+2), 0.0)
      val t = pi / enp
      val _ = update1(pxr,1,(enp - 1.0) * 0.5)
      val _ = update1(pxi,1,0.0)
      val n2 = np div 2 
      val _ = update1(pxr,n2+1,~0.5)
      val _ = update1(pxi,n2+1,0.0)
  in
      for (1,npm,fn i =>
      let val j = np - i 
	  val _ = update1(pxr,i+1,~0.5)
	  val _ = update1(pxr,j+1,~0.5)
	  val z = t * (real i)
	  val y = ~0.5 * (cos(z)/sin(z)) 
      in
	   update1(pxi,i+1,y);
	   update1(pxi,j+1,~y)
      end);
(*
  print "\n"; print "before fft: \n";
  dump pxr pxi;
*)
  ignore(fft pxr pxi np);
(*
  print "\n"; print "after fft: \n";
  dump pxr pxi;
*)
  let val zr = ref 0.0 
      val zi = ref 0.0 
      val kr = ref 0 
      val ki = ref 0 
  in
      for (0,np-1,fn i =>
      let val a = abs_real(sub1(pxr,i+1) - (real i))
      in
	   if !zr < a then 
	       (zr := a; 
		kr := i)
	   else ();
	   let val a = abs_real(sub1(pxi,i+1))
	   in
	       if !zi < a then 
		   (zi := a; 
		    ki := i)
	       else ()
	   end
      end);
      let val zm = if abs_real (!zr) < abs_real (!zi) then !zi else !zr 
      in
	  print_real zm; print_newline()
      end
  end
 end)
in
fun doit() = 
  let val np = ref 16 
  in for(1,13,fn i => (test (!np); np := (!np)*2))
  end

end

use "utils/benchmark";

test "fft" 1 doit ();
