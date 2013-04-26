(* Data Trees
 *
 * (C) Harlequin 1995
 *
 * Useful examples for demonstrating the graphical inspector
 *
 * $Log: data_tree.sml,v $
 * Revision 1.2  1996/04/03 13:56:40  daveb
 * Changes for value polymorphism.
 *
 *  Revision 1.1  1995/10/26  17:38:09  daveb
 *  new unit
 *  Example trees for the inspector.
 *
 *  Revision 1.1  1995/10/15  22:11:39  brianm
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

fun flip (NODE(EMPTY,y::l)) = flip(NODE(y,l))
  | flip (NODE(x,y::l))     = NODE(flip(y), map flip (x :: l))
  | flip (NODE(x,[]))       = NODE(EMPTY,[flip(x)])
  | flip (TRUE)      = FALSE
  | flip (FALSE)     = TRUE
  | flip (INT(i))    = INT(~i)
  | flip (STR(s))    = STR( implode ( rev (explode s) ) )
  | flip (a)         = a

fun maptree f =
    let fun mapit (NODE(d,l)) = NODE(mapit(d),map mapit l)
          | mapit (atom)      = f(atom)
    in
        mapit
    end

fun at_end (x,l) =
    let fun doit (a::l,r) = doit(l,a::r)
          | doit ([],r)   = rev(x::r)
    in
        doit(l,[])
    end

fun rotmaptree f = 
    let fun doit (NODE(d,d'::l)) = NODE(doit(d'),map doit (at_end(d,l)))
          | doit (atom)          = f(atom)
    in
        doit
    end

  fun rottree x = rotmaptree (fn x => x) x

    local
      fun doit (NODE(x,y::l), sofar) = doit(y,NODE(x,sofar::l))
          | doit (NODE(x,[]), sofar) = doit(x,sofar)
          | doit (EMPTY, sofar) = sofar
          | doit (atom, sofar)  = NODE(atom,[sofar])
    in
      val revtree =
        fn dt => doit(dt,EMPTY)
    end

    local
      fun doit (NODE(x,y::l), sofar) =
            let val x' = doit(x,EMPTY)
            in
                doit(y,NODE(x',sofar::l))
            end
          | doit (NODE(x,[]), sofar) = doit(x,sofar)
          | doit (EMPTY, sofar) = sofar
          | doit (atom, sofar)  = NODE(atom,[sofar])
    in
      val REVtree =
        fn dt => doit(dt,EMPTY)
    end

    local
      fun doit (NODE(x,y::l), sofar) =
            let val x' = doit(x,sofar)
            in
                doit(y,NODE(x',sofar::l))
            end
          | doit (NODE(x,[]), sofar) = doit(x,sofar)
          | doit (EMPTY, sofar) = sofar
          | doit (atom, sofar)  = NODE(atom,[sofar])
    in
      val topsy_turvey =
        fn dt => doit(dt,EMPTY)
    end

fun subtrees (n as NODE(d,l)) = NODE(n,subtrees(d) :: (map subtrees l))
  | subtrees (atom)           = atom

fun apptree l r =
    let fun doit (NODE(d,lst)) = NODE(d, doit_all lst)
	  | doit (EMPTY)       = r
	  | doit (atom)        = atom

	and doit_all [] = []
	  | doit_all (l) =
	    let fun loop ([a],r)  = rev(doit(a) :: r)
		  | loop (a::l,r) = loop(l,a::r)
		  | loop ([],r)   = rev(r)
	    in
		loop(l,[])
	    end
    in
	doit(l)
    end

fun blend (NODE(d,l)) (NODE(d',l')) =
    let val dd' = blend d d'
        val ll' = blend_list l l'
    in
        NODE(dd',ll')
    end
  | blend EMPTY dt = dt
  | blend dt EMPTY = dt
  | blend l r = NODE(l,[r])

and blend_list (dt::l) (dt'::l') = (blend dt dt') :: (blend_list l l')
  | blend_list [] _ = []
  | blend_list _ [] = []


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

fun box (n as NODE(_,[])) = n
  | box (NODE(x,l))          = NODE( box(x), (map box l) )
  | box (atom)               = NODE(atom,[])

fun unbox (NODE(dt,[])) = unbox(dt)
  | unbox (NODE(d,l)) = NODE(unbox d, map unbox l)
  | unbox (atom) = atom

fun atoms dt =
    let fun doit(NODE(d,l), al) =
            let val rl = doit_all(rev l,al)
            in
                doit(d,rl)
            end
          | doit(EMPTY,al) = al
          | doit(atom,al)  = atom :: al

        and doit_all (a::l,al) = doit_all(l,doit(a,al))
          | doit_all ([],al)   = al
    in
        doit(dt,[])
    end

fun max(a:int,b) = if a < b then b else a

fun height (NODE(x,y)) = 1 + height_list(x::y)
  | height (EMPTY)     = 0
  | height (atom)      = 1

and height_list l =
    let fun doit (m,a::l) =
            let val h = height(a)
            in
	       doit(max(m,h),l)
	    end
          | doit(m,[]) = m
    in
       doit(0,l)
    end

fun fsum_list (f,l) =
    let fun doit(s,a::l) = doit(s+f(a),l)
          | doit(s,[])   = s
    in
       doit(0,l)
    end

fun nodes (NODE(x,l)) = 1 + nodes(x) + fsum_list(nodes,l)
  | nodes (EMPTY)     = 0
  | nodes (atom)      = 1

fun tips (NODE(x,l)) = tips(x) + fsum_list(tips,l)
  | tips (EMPTY)     = 0
  | tips (atom)      = 1

fun inodes (NODE(x,l)) = 1 + inodes(x) + fsum_list(inodes,l)
  | inodes (atom)      = 0

fun is_prefix (NODE(d,l),NODE(d',l')) = (d = d') andalso is_prefix_list (l,l')
  | is_prefix (EMPTY, _)   = true
  | is_prefix (atom,atom') = (atom = atom')

and is_prefix_list (a::l,a'::l') = is_prefix(a,a') andalso is_prefix_list(l,l')
  | is_prefix_list ([],_)        = true
  | is_prefix_list (_,_)         = false

fun find test =
    let fun try (dt) = test (dt) orelse scan (dt)
        and scan (NODE(d,l)) = try (d) orelse try_every (l)
          | scan (atom) = test (atom)
        and try_every (a::l) = try(a) orelse try_every(l)
          | try_every ([])   = false

        fun top_level (l as NODE(_,_)) = try(l)
          | top_level (atom) = test(atom)
    in
        top_level
    end

fun is_subtree dt1 dt2 = find (fn dt' => (dt1 = dt')) dt2
