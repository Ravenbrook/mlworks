(*
 *
 * $Log: matrix.sml,v $
 * Revision 1.2  1998/06/08 18:18:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* matrix *)
(* Matrix functions *)

(* matrix.sml

Matrix functions for the Incremental Knuth-Bendix Ordering.

Nick Cropper, University of Glasgow, 1992.

Modified Brian Matthews, 1992
*)

(* defines matProdT, matProd, and row operations *)

infixr 6 revConc;

signature MATRIX = 
sig
type Row
type Matrix
exception Dimension
val zeroRow : int -> int list -> int list
val allZero : int list -> bool
val revConc : 'a list * 'a list -> 'a list
val crossPair : 'a list -> 'b list -> ('a * 'b) list 
val distrPair : 'a -> 'b list -> ('a * 'b) list
val dotProd : int list -> int list -> int 
exception Width 
val width : 'a list list -> int
val add0Col : int list list -> int list list
val transpose : int list list -> int list list
val rowProd : int list -> int list list -> int list 
val matProdT : int list list -> int list list -> int list list
val matProd : int list list -> int list list -> int list list
end (* of signature MATRIX *)
;

functor MatrixFUN () : MATRIX = 
struct

type	Row    = int list;
type	Matrix = Row list;

exception	Dimension;


(* rows *)

fun zeroRow z xs = copy z 0 @ xs
(*
fun		zeroRow 0 xs = xs
|		zeroRow z xs = zeroRow (z - 1) (0 :: xs);
*)

val allZero = forall (eq 0)
(*
fun		allZero []      = true
|		allZero (0::zs) = allZero zs
|		allZero (_::_)  = false;
*)

val op revConc = fn x => uncurry (append o rev) x
(*
fun		[]      revConc ys = ys
|		(x::xs) revConc ys = xs revConc (x::ys);
*)

fun		crossPair []      _  = []
|		crossPair (x::xs) ys = distrPair x ys @ crossPair xs ys

and		distrPair x []      = []
|		distrPair x (y::ys) = (x, y) :: distrPair x ys;


local
	fun	dotProd' s []      []      = s : int
	|	dotProd' s (x::xs) (y::ys) = dotProd' (s + x*y) xs ys
	|	dotProd' s _ _ = raise Dimension
in
	fun	dotProd r1 r2 = dotProd' 0 r1 r2
end;

(* matrices *)

exception Width;

fun		width []      = raise Width
|		width (r::rs) = length r;

val add0Col = map (cons 0) ;
(*
fun		add0Col []      = []
|		add0Col (r::rs) = (0 :: r) :: add0Col rs;
*)

fun		transpose ([]::_) = []
|		transpose m       = map hd m :: transpose (map tl m);

fun		rowProd r []      = []
|		rowProd r (c::cs) = dotProd r c :: rowProd r cs;

(* matProdT -- Matrix product of transpose *)
(*             for efficiency              *)
(* matProdT m1 m2T -> m3                   *)

fun		matProdT []      m2 = []
|		matProdT (r::rs) m2 = rowProd r m2 :: matProdT rs m2;

(* matProd -- Matrix product *)
(* matProd m1 m2 -> m3       *)

fun		matProd m1 m2 = matProdT m1 (transpose m2);
end (* of functor MatrixFUN *)
;
