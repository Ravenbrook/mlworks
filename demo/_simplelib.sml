require "simplelib";
require "basis.__array";

functor SimpleLib() : SIMPLELIB = 
struct

  (* list ops *)
      
  fun nil @ M = M
    | (x :: L) @ M = x :: (L @ M)
  fun map f =
    let fun m nil = nil
	  | m (a::r) = f a :: m r
    in  m
    end
      
(* the 'map' function defined above is not good for short lists.
   neither does it have good stack behaviour. The following version
   is optimised for both *)
(*
  local
    fun rev' (done, []) = done
      | rev' (done, x::xs) = rev' (x::done, xs)
  in
    
    (* We seem to use map with short lists a lot so... *)
    fun map f [] = []
      | map f [x] = [f x]
      | map f [x,y] = [f x, f y]
      | map f [x,y,z] = [f x, f y, f z]
      | map f [x,y,z,w] = [f x, f y, f z, f w]
      | map f (x :: y :: z :: w :: rest) =
	let
	  fun map_sub([], done) = rev' ([], done)
	    | map_sub(x :: xs, done) = map_sub (xs, f x :: done)
	in
	  f x :: f y :: f z :: f w :: map_sub(rest, [])
	end
  end
 *)
  exception Hd
  exception Tl
  
  fun hd (a::r) = a | hd nil = raise Hd
  fun tl (a::r) = r | tl nil = raise Tl    

  fun fold f (b,[]) = b
    | fold f (b,a::r) = let fun f2(e,[]) = f(e,b)
			      | f2(e,a::r) = f(e,f2(a,r))
			in f2(a,r)
			end

  (* the version of 'fold' above is not bad, but defines a new closure
   for each complete application. The version below is slightly more efficient. *)
(*
  fun fold f = 
    let
      fun red (acc, []) = acc
	| red (acc, x::xs) = red (f(acc,x), xs)
    in 
      red
    end
*)  
  (* misc *)
    
  fun min(x:real,y:real) = if x<y then x else y
  fun max(x:real,y:real) = if x<y then y else x
  fun abs(x:real) = if x < 0.0 then ~x else x
  exception MaxList
  exception MinList
  exception SumList
  fun max_list [] = raise MaxList | max_list l = fold max (hd l,l)
  fun min_list [] = raise MinList | min_list l = fold min (hd l,l)
  fun sum_list [] = 0.0
    | sum_list (x :: xs) = x + sum_list xs

  (* the version of sum_list above has bad stack discipline. This
   * version uses an accumulator *)
(*
  local
    fun sum_list' ([],acc) = acc
      | sum_list' (x::xs,acc) = sum_list' (xs,x+acc:real)
   in
     fun sum_list l = sum_list' (l,0.0)
   end
 *)
  fun for {from=start:int,step=delta:int, to=endd:int} body =
      if delta>0 andalso endd>=start then 
	  let fun f x = if x > endd then () else (ignore (body x); f(x+delta))
	  in f start
	  end
      else if endd<=start then
	  let fun f x = if x < endd then () else (ignore (body x); f(x+delta))
	  in f start
	  end
      else ()
  fun from(n,m) = if n>m then [] else n::from(n+1,m)

  (* this version of from has bad stack discipline. It would be better
   * to use an accumulator: *)
(*
 local
   fun from'(n,m,acc) = if n > m then acc else from'(n,m-1,m::acc)
 in
   fun from (n,m) = from'(n,m,[])
 end
 *)
  fun flatten [] = []
    | flatten (x::xs) = x @ flatten xs

  fun pow(x,y) = if y = 0 then 1.0 else x*pow(x,y-1)
      
(* The version of 'pow' above has bad stack behaviour. It is more
 * efficiently coded using an accumulator: *)
(*
  local
    fun pow'(x:real,y,acc) = if y = 0 then acc else pow'(x,y-1,x*acc)
  in
    fun pow(x,y) = if y = 0 then 1.0 else pow'(x,y,1.0)
  end
 *)
   fun min(a:real,b) = if a<b then a else b
   fun max(a:real,b) = if a>b then a else b

   exception Overflow

   type bounds2 = ((int * int) * (int * int))

  type 'a array2 = {rows : int, columns : int, v : 'a Array.array} * bounds2

  fun array2'(rows, columns, e) = 
    if rows<0 orelse columns<0 then raise Size
    else {rows=rows,columns=columns,v=Array.array(rows*columns,e)}
      
  fun sub2' ({rows,columns,v}, s :int, t:int) =
    if s < 0 then raise Subscript
    else if s>=rows then raise Subscript
	 else if t<0 then raise Subscript
	      else if t>=columns then raise Subscript
		   else Array.sub(v,s*columns+t)

  fun update2' ({rows,columns,v}, s : int, t:int, e) : unit = Array.update(v,s*columns+t,e)
    
(* The 2d arrays defined above use integer multiplication on every
access: a slow operation on some machines. The following version does
not: *)
(*
   type 'a array2 = 'a Array.array MLWorks.Vector.vector * ((int * int) * (int * int))

   fun maken (0,f,acc) = acc
     | maken (n,f,acc) = maken (n-1,f,(f ())::acc)

   fun array2' (rows,columns,e) =
     MLWorks.Vector.vector (maken (rows, fn () => Array.array(columns,e),[]))

   fun sub2' (a,s,t) = Array.sub(MLWorks.Vector.sub(a,s),t)

   fun update2' (a,s,t,v) = Array.update(MLWorks.Vector.sub(a,s),t,v)
 *)

  fun array2 (bounds as ((l1,u1),(l2,u2)),v) = (array2'(u1-l1+1,u2-l2+1,v), bounds) 
  fun sub2 ((A,((lb1,ub1), (lb2,ub2))),(k,l)) = sub2'(A, k-lb1, l-lb2) 
  fun  update2 ((A,((lb1,_),(lb2,_))),(k,l), v) = update2'(A,k-lb1,l-lb2,v)

  type 'a array1 = 'a Array.array * (int * int)
  val array1 = fn ((l,u),v) => (Array.array(u-l+1,v),(l,u))
  val sub1 = fn ((A,(l:int,u:int)),i:int) => Array.sub(A,i-l) 
  val update1 = fn((A,(l,_)),i,v) => Array.update(A,i-l,v)
  fun bounds1(_,b) = b

  val grid_max = 20

  val iterations = 3

end
