(*
 *
 * $Log: hash.sml,v $
 * Revision 1.2  1998/06/03 12:20:08  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1992 by Carnegie Mellon University *)

(* Gene Rollins (rollins+@cs.cmu.edu)
   School of Computer Science, Carnegie-Mellon Univ, Pittsburgh, PA *)

structure Hash :HASH = struct
open Array List
infix 9 sub

type ('a,'b) table = ('a*'a->bool) * (('a*int*'b) list array) * int

fun create (equality :'_a * '_a -> bool)
           table'size (empty'value'list :'_b list) :('_a,'_b) table =
  let val mt = ([] :('_a * int * '_b) list)
  in (equality, array (table'size, mt), table'size)
  end

val defaultSize = 97 (* a prime; or try primes 37, 997 *)

fun defaultEqual ((x :string), (y :string)) :bool = (x = y)

fun createDefault (empty'value'list :'_b list) :(string,'_b) table =
  let val mt = ([] :(string * int * '_b) list)
  in (defaultEqual, array (defaultSize, mt), defaultSize)
  end

fun enter ((equal, table, table'size) :('a,'b) table) (key, hash) value = 
  let val place = hash mod table'size
      val bucket = table sub place
      fun put'in [] = [(key,hash,value)]
        | put'in ((k,h,v)::tail) =
	    if (h = hash) andalso equal (k, key)
	      then (key,hash,value)::tail
	      else (k,h,v)::(put'in tail)
  in
    update (table, place, put'in bucket)
  end

fun remove ((equal, table, table'size) :('a,'b) table) (key, hash) =
  let val place = hash mod table'size
      val bucket = table sub place
      fun take'out [] = []
        | take'out ((k,h,v)::tail) =
	    if (h = hash) andalso equal (k, key)
	      then tail
	      else (k,h,v)::(take'out tail)
  in
    update (table, place, take'out bucket)
  end

fun lookup ((equal, table, table'size) :('a,'b) table) (key, hash) =
  let val place = hash mod table'size
      val bucket = table sub place
      fun get'out [] = NONE
        | get'out ((k,h,v)::tail) =
	    if (h = hash) andalso equal (k, key)
	      then SOME v
	      else get'out tail
  in
    get'out bucket
  end

exception NotFound

fun lookup' ((equal, table, table'size) :('a,'b) table) (key, hash) =
  let val place = hash mod table'size
      val bucket = table sub place
      fun get'out [] = raise NotFound
        | get'out ((k,h,v)::tail) =
	    if (h = hash) andalso equal (k, key)
	      then v
	      else get'out tail
  in
    get'out bucket
  end

fun print' ((_, table, table'size) :('a,'b) table)
          (print'key :'a -> unit) (print'value :'b -> unit) =
  let fun pr'bucket [] = ()
        | pr'bucket ((key,hash,value)::rest) =
            (print'key key; print ": ";
             print_int (hash:int); print ": ";
	     print'value value; print "\n"; pr'bucket rest)
      fun pr i =
        if i >= table'size then ()
	  else
	    case (table sub i) of
	       [] => (pr (i+1))
             | (b as (h::t)) =>
	         (print "["; print_int(i:int); print "]\n";
	          pr'bucket b; pr (i+1))
  in pr 0 end

val print = print'

fun scan ((_, table, table'size) :('a,'b) table) operation =
  let fun map'bucket [] = ()
        | map'bucket ((key,hash,value)::rest) =
            (ignore(operation (key, hash) value); map'bucket rest)
      fun iter i =
        if i >= table'size then ()
	  else (map'bucket (table sub i); iter (i+1))
  in iter 0 end

fun fold ((_, table, table'size) :('a, 'b) table)
         (operation :'a * int -> 'b -> 'g -> 'g) (init :'g) :'g =
  let fun fold'bucket [] acc = acc
        | fold'bucket ((key,hash,value)::rest) acc =
             fold'bucket rest (operation (key, hash) value acc)
      fun iter i acc =
        if i >= table'size then acc
	  else iter (i+1) (fold'bucket (table sub i) acc)
  in iter 0 init end

fun scanUpdate ((_, table, table'size) :('a,'b) table) operation =
  let fun map'bucket [] = []
        | map'bucket ((key,hash,value)::rest) =
            ((key,hash,operation (key, hash) value)::(map'bucket rest))
      fun iter i =
        if i >= table'size then ()
	  else (update (table, i, map'bucket (table sub i)); iter (i+1))
  in iter 0 end

fun eliminate ((_, table, table'size) :('a,'b) table) predicate =
  let fun map'bucket [] = []
        | map'bucket ((key,hash,value)::rest) =
            if predicate (key, hash) value then map'bucket rest
              else (key,hash,value)::(map'bucket rest)
      fun iter i =
        if i >= table'size then ()
	  else (update (table, i, map'bucket (table sub i)); iter (i+1))
  in iter 0 end

fun bucketLengths ((_, table, table'size) :('a,'b) table) (maxlen :int)
    :int array =
  let val count :int array = array (maxlen+1, 0)
      fun inc'sub x = 
        let val y = min (x, maxlen) in
          update (count, y, (count sub y) + 1)
        end
      fun iter i =
        if i >= table'size then ()
	  else (inc'sub (length (table sub i)); iter (i+1))
  in
    iter 0;
    count
  end

end
