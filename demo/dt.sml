(* shortened version of data trees
 *
 * $Log: dt.sml,v $
 * Revision 1.2  1997/07/15 12:42:28  brucem
 * [Bug #30199]
 * Update to SML'97.
 *
 *  Revision 1.1  1995/10/26  17:38:39  daveb
 *  new unit
 *  Example trees for the inspector.
 *
 *  Revision 1.1  1995/10/15  22:10:08  brianm
 *  new unit
 *  New file.
 *
 *
 *)

datatype DTree =
            EMPTY      |
	    INT of int | STR of string | TRUE | FALSE |
	    NODE of DTree * DTree list

val e  = EMPTY
val tt = TRUE
val ff = FALSE

fun i x = INT x
fun b x = if x then TRUE else FALSE
fun s x = STR(x)
fun n x l  =  NODE(x,l)
fun n' x y =  NODE(x,[y])

fun l (x :: y) = NODE(x,[(l y)])
  | l nil      = EMPTY


fun copies x =
    let fun doit (0,r) = r
          | doit (i,r) = doit (i-1,x::r)
        fun run n = if n > 0 then doit(n,[]) else []
    in
       run
    end

fun ll n =
    let fun doit (x::xl) =
            let val xl' = doit(xl)
                val v = NODE(x,xl') 
            in
                copies v n
            end
          | doit ([]) = []
    in
        doit
    end

val s1 = "The Quick Brown Fox Jumps Over The Lazy Dog"
val s2 = "One Small Step for A Man, One Giant Leap For Mankind"
val s3 = "Now Is The Time For All Good Men To Come To The Aid Of The Party"
val s4 = "Hope Springs Eternal In The Human Breast"

val l1 = [s1,s2,s3,s4]
val l2 = l1 @ l1 @ l1 @ l1
val l3 = l2 @ l2 @ l2 @ l2
val l4 = l3 @ l3 @ l3 @ l3

val t1  = (s1,s2,s3,s4)

val t2 = (t1,t1,t1)
val t3 = (t2,t2,t2)
val t4 = (t3,t3,t3)

val t2' = (s1,t1,s2,t1,s3,t1,s4)
val t3' = (s1,t2',s2,t2',s3,t2',s4)
val t4' = (s1,t3',s2,t3',s3,t3',s4)

val x1 = s s1
val x2 = s s2
val x3 = i 42
val x4 = i 23

val y1 = n' (n' x1 x2) (n' x3 x4)
val y2 = l [x1, x2, x3, x4, tt, ff]
val y3 = n x1 [ (n x2 [y1,y1,y1]),  (n x2 [y1,y1,y1]),  (n x2 [y1,y1,y1]) ]
val y4 = n x1 (ll 3 [x2, x3, x4, tt, ff])

val z = ()
