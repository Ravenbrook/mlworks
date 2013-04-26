(*************************************************************************)
(* Toolkit Functions for The Ghost CSG Raytracer - (C) Chris Walton 1994 *)
(*************************************************************************)

(* Standard error handler *)
exception Error of string
fun error s = raise Error s

(* ------------------------- REAL NUMBER FUNCTIONS --------------------- *)

(* Maths roundoff tolerance value *)
val epsilon = 1.0E~5;   

(* PI *)
val PI = 3.14159265358979323844

(* Tangent function (radians) *)
fun tan x = (sin x) / (cos x)

(* Real number equality testing *)
infix 4 ==
fun x == y = if x = y then true
             else if Real.== (x+y,0.0) then false
             else abs((x-y)/(x+y)) < epsilon

(* Real number power function x^y *)
exception power
fun pow x y = if x<0.0 then raise power
              else if x == 0.0 then 0.0
              else if y == 0.0 then 1.0
              else exp(y * ln x)

(* Minimum of two real numbers *)
fun min'r x (y:real) = if x<y then x else y

(* ---------------------- LIST MANIPULATING FUNCTIONS ------------------- *) 

(* Get the n 'th element of a list *)
exception element_not_found 
fun element ([], _) = raise element_not_found
  | element (h::t, 0) = h
  | element (h::t, n) = element(t, n-1)

(* Get the head of a list *)
exception Hd
fun hd [] = raise Hd
  | hd (h::_) = h

(* Get the tail of a list *)
exception Tl
fun tl [] = raise Tl
  | tl (_::t) = t

(* List fold left function *)
fun foldleft f e [] = e
  | foldleft f e (h::t) = foldleft f (f(e, h)) t

fun null [] = true
  | null _ = false
