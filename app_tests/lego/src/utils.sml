(*
 *
 * $Log: utils.sml,v $
 * Revision 1.2  1998/08/05 17:13:57  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "$.basis.__list";
(* utils.ml *)

(* failure, bug, and warning *)
require "ut1";

exception Failure of string
fun failwith s = raise Failure s
exception Bug of string
fun bug s = raise Bug ("\nbug detected at "^s)


(* Pointer equality !!! *)
fun eq(x:'a,y:'a) = 
      (MLWorks.Internal.Value.cast(x): int) =
      (MLWorks.Internal.Value.cast(y): int)

(*
(* Timers *)
fun start_timer() = System.Timer.start_timer()
fun makestring_timer t =
  let
    val non_gc_time = System.Timer.check_timer t
    val gc_time = System.Timer.check_timer_gc t
  in
    "time= "^(System.Timer.makestring non_gc_time)^
    "  gc= "^(System.Timer.makestring gc_time)
  end
*)


fun fst(x,_) = x 
fun snd(_,y) = y
fun thrd(_,_,z) = z

fun do_list f [] = ()
  | do_list f (h::t) = (ignore(f h); do_list f t)
fun do_list_funny f g [x] = f x
  | do_list_funny f g (h::t) = (ignore(f h);ignore(g());do_list_funny f g t)
  | do_list_funny f g [] = bug"do_list_funny"


fun succ n = n + 1

fun max (x,y):int = if x > y then x else y

fun I x = x

val length = List.length

exception Hd
fun hd [] = raise Hd | hd (h::_) = h
exception Tl
fun tl [] = raise Tl | tl (_::t) = t

exception Nth
fun nth [] n = raise Nth | nth (h::t) n = if n = 1 then h else nth t (n-1)

fun string_of_num (n:int) = int_to_string n

exception Assoc
fun ASSOC e [] = raise Assoc
  | ASSOC e (h::t) = if fst h = e then h else ASSOC e t

(*
fun assoc e l = snd (ASSOC e l)
*)

fun tryAssoc e =
  let
    fun try [] = NONE
      | try ((key, value) :: t) = if key = e then SOME value else try t
  in
    try
  end

fun assoc e =
  let
    fun try [] = raise Assoc
      | try ((key, value) :: t) = if key = e then value else try t
  in
    try
  end

(*
fun exists f [] = false
  | exists f (h::t) = (f h) orelse (exists f t)
*)
val exists = List.exists

(*
fun for_all f [] = true
  | for_all f (h::t) = (f h) andalso (for_all f t)
*)
val for_all = List.all

fun equal_fst u (x,y) = (u=x) 

val mem_assoc = fn x => (exists o equal_fst) x

fun neg f e = not (f e)

(*
fun sep_last [] = failwith "sep_last"
  | sep_last (h::t) = 
    let val pair = (h,t) 
        fun sep_last_aux (pair as (h,[])) = pair
          | sep_last_aux (h,h'::t') = 
            let val pair = (h',t')
                val (x,l) = sep_last_aux pair in (x,h::l) end
     in sep_last_aux pair end
*)
fun sep_last [] = failwith "sep_last"
  | sep_last list =
    let
      val list' = rev list
    in
      (hd list', rev(tl list))
    end

(*
fun except_last [] = failwith "except_last"
  | except_last (h::t) = 
    let val pair = (h,t) 
        fun except_last_aux (_,[]) = []
          | except_last_aux (x,h'::t') = 
              let val pair = (h',t') in x :: (except_last_aux pair) end
     in except_last_aux pair end
*)

fun except_last [] = failwith "except_last"
  | except_last list = rev(tl(rev list))

fun chop_aux(0, (l1,l2)) = (rev l1, l2)
  | chop_aux(n, (_,[])) = failwith "chop_aux"
  | chop_aux(n, (l1,(h::t))) = chop_aux((n-1), (h::l1, t))

fun chop_list n l = chop_aux(n, ([],l))


fun first_n 0 l = []
  | first_n n [] = failwith "first_n"
  | first_n n (h::t) = h::(first_n (n-1) t)


fun repeat n action arg =
    let fun repeat_action n =
            if n <= 0 then () else (ignore(action arg); repeat_action (n-1))
     in repeat_action n end

fun interval n m =
    let fun interval_n (l,m) =
            if n > m then l else interval_n (m::l, m-1)
     in interval_n ([],m) end

fun C f x y = f y x


(* printing *)
fun prs s = print s
and pri n = print (int_to_string n)
and line() = print "\n"
and message s = print (s^"\n")



(* structure sharing *)
exception Share

fun share f x = (f x) handle Share => x
fun share2 (f1,f2) (x,y) = (f1 x,share f2 y) handle Share => (x,f2 y)
fun share3 (f1,f2,f3) (x,y,z) = 
  (let val (x2,x3) = share (share2 (f2,f3)) (y,z)
   in (f1 x,x2,x3)
   end handle Share => (x,f2 y,share f3 z))
     handle Share => (x,y,f3 z)
fun map_share _ [] = raise Share
  | map_share f l =
  let
(*
    fun map_share_f [] = raise Share
      | map_share_f [x] =
	[(f x) handle Share => x]
      | map_share_f(x::l) =
	(((f x) handle Share => x)::(map_share_f l))
*)
    fun map_share_f(acc, []) = rev acc
      | map_share_f(acc, x :: l) =
	map_share_f(((f x) handle Share => x) :: acc, l)
  in
    map_share_f([], l)
  end

fun no_raise_map_share f l =
  let
    fun map_share_f(acc, []) = rev acc
      | map_share_f(acc, x :: l) =
	map_share_f(((f x) handle Share => x) :: acc, l)
  in
    map_share_f([], l)
  end
    
fun I_share x = raise Share


(* list operators *)
exception Empty of string

fun last []  = raise Empty "last"
  | last [x] = x
  | last (x::xs) = last xs
fun dropLast []  = raise Empty "dropLast"
  | dropLast [x] = []
(*
  | dropLast (x::xs) = x :: dropLast xs
*)
  | dropLast list = rev(tl(rev list))

(*
fun removeLast l = (last l, dropLast l)
      handle Empty _ => raise Empty "removeLast"
*)

fun removeLast l =
  let
    val l' = rev l
  in
    case l' of
      [] => raise Empty "removeLast"
    | x :: xs => (x, rev xs)
  end
(*
fun foldr f a (x::xs) = f x (foldr f a xs)
  | foldr f a []      = a
*)
fun foldr f = List.foldr (fn (x, y) => f x y)

(*
fun foldl f a (x::xs) = foldl f (f a x) xs
  | foldl f a []      = a
*)
fun foldl f = List.foldl (fn (x, y) => f y x)

fun foldr1 f [] = raise Empty "foldr1"
  | foldr1 f l  = let val (last,front) = removeLast l
		  in  foldr f last front
		  end

fun member x = exists (fn z => z=x)
val mem = member

fun findDup dum [] = (false,dum)
  | findDup dum (x::xs) = if member x xs then (true,x)
			  else findDup dum xs


(*******************  not in use **********************
fun dedup (x::xs) = if member x xs then dedup xs else x::(dedup xs)
fun setDiff (x::xs) ys = if member x ys then setDiff xs ys
			 else x::(setDiff xs ys)
  | setDiff [] _ = []
********************************************************)

(* do not change order of list *)
fun filter_pos p = 
    let fun select x res = if p x then x::res else res
     in foldr select [] end
fun filter_neg p = 
    let fun select x res = if p x then res else x::res
     in foldr select [] end

exception Zip
fun zip ((x::xs),(y::ys)) = (x,y)::(zip (xs,ys))
  | zip ([],[])           = []
  | zip _                 = raise Zip

(* lists of strings *)
fun concat_sep sep (s::[]) = s
  | concat_sep sep (s::ss) = s^sep^(concat_sep sep ss)
  | concat_sep sep [] = ""


(* a functional utility *)
fun Repeat n fnc arg = if (n<=0)
                       then arg 
                       else fnc (Repeat (n-1) fnc arg);

(* apply to a pair *)
fun pair_apply f (x,y) = (f x,f y);
