(*
 *
 * $Log: lib.sml,v $
 * Revision 1.2  1998/06/11 12:57:46  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
structure Lib =
struct

(* stuff for handling user interrupts in SML/NJ (added by John Reppy) *)
   exception Interrupt  (* not present in SML/NJ 0.59-0.65 *)
   fun capturetopcont () =
     let
       exception callcc_required of string
     in
       raise raise callcc_required "capturetopcont"
     end
(*
       System.Unsafe.toplevelcont :=
          callcc (fn k => (callcc (fn k' => (throw k k'));
                           raise Interrupt))
*)
   exception AtoI
   fun atoi a =
       let fun digit "0" = 0  |  digit "1" = 1  |  digit "2" = 2
             | digit "3" = 3  |  digit "4" = 4  |  digit "5" = 5
             | digit "6" = 6  |  digit "7" = 7  |  digit "8" = 8
             | digit "9" = 9  |  digit _ = raise AtoI
           fun deal [] = 0
             | deal (h::t) = digit h + ((deal t) * 10)
        in deal(rev(explode a))
       end

   val inc = inc
   val dec = dec
   val min = min

   fun fst (x,_) = x
   fun snd (_,x) = x

   val mkstrint  :  int -> string = makestring
   val mkstrbool : bool -> string =(* makestring*)
     fn true => "true"
      | false => "false"

(* needed to flush output to std_out *)
   fun print (str,s) = (output(str,s); flush_out str)
   fun msg s = print(std_out,s)

   type 'a array = 'a Array.array
   val array = Array.array
   val Sub = Array.sub
   val update = Array.update

   exception Hd = Hd
   exception Tl = Tl
   exception disaster of string

   val hd = hd
   val tl = tl
   val length : 'a list -> int = length

   fun isnil [] = true
     | isnil (h::t) = false

   fun forall p l = let fun fall [] = true
                          | fall (h::t) = (p h) andalso (fall t)
                     in fall l
                    end

   fun exists p l = let fun ex [] = false
                          | ex (h::t) = (p h) orelse (ex t)
                     in ex l
                    end

   fun member eq (a,l) = exists (fn x => eq(x,a)) l

   fun rm eq (a,l) =
       let fun rma [] = []
             | rma (h::t) = if eq(h,a) then rma t else h::(rma t)
        in rma l
       end

   val map = map

   val app = app
   val fold = fold

   fun flatten [] = []
     | flatten (h::t) = h@(flatten t)

   fun filter p =
       let fun filt [] = []
             | filt (h::t) = let val ftail = filt t
                              in if p h then h::ftail else ftail
                             end
        in filt
       end

   fun eq elt_eq =
       let fun equal ([],[]) = true
             | equal (a::s,b::t) = elt_eq(a,b) andalso equal(s,t)
             | equal _ = false
        in equal
       end

   fun le elt_le =
       let fun leq ([],_)        = true
             | leq (_,[])        = false
             | leq (h::t,h'::t') = elt_le(h,h') andalso
                                   (not (elt_le(h',h)) orelse leq(t,t'))
        in leq
       end

   fun del_dups eq =
       let fun dd m [] = m
             | dd m (h::t) = if member eq (h,m) then dd m t else dd (m@[h]) t
        in dd []
       end

   fun multiply prod l1 l2 =
       let fun mult [] l = []
             | mult (h::t) l =
               let fun m [] = []
                     | m (h'::t') = prod(h,h') :: (m t')
                in (m l)@(mult t l)
               end
        in mult l1 l2
       end

   fun mkstr mkstrelt sep []     = ""
     | mkstr mkstrelt sep [a]    = mkstrelt a
     | mkstr mkstrelt sep (h::t) = (mkstrelt h)^sep^(mkstr mkstrelt sep t)

   val ran = ref 123
   fun random ub = (ran := (1005 * !ran + 7473) mod 8192;
                    (!ran) div (8192 div ub + 1))

(* get_line ignores leading and trailing blanks,   *)
(* and allows for the continuation character "\".  *)

   fun get_line infile =
       let fun strip (" "::t) = strip t
             | strip ("\n"::t) = strip t
             | strip l = l
           val revline = strip(rev(strip(explode(input_line infile))))
        in if not(isnil revline) andalso hd revline = "\\" then
              (implode(rev(strip(tl revline))))^" "^(get_line infile)
           else implode(rev revline)
       end

   (* From GNU Emacs: *)
   (* Apply ELT to each element of LIST, *)
   (* concatenating the results as strings, sticking in SEP between. *)
   (* Thus (mapconcat makestring [1,2,3] "+") => "1+2+3" *)
   fun mapconcat elt [] sep = ""
     | mapconcat elt [h] sep = elt h
     | mapconcat elt (h::t) sep = (elt h) ^ sep ^ (mapconcat elt t sep)


   (* From sortedlist.str, modulo duplicate removal *)
   fun sort le =
       let fun sr []  = []
             | sr [a] = [a]
             | sr (h::t) =
               let fun part [] pivot = ([],[],[])
                     | part (h::t) pivot =
                       let val (A,B,C) = part t pivot
                        in if le(h,pivot) then
                              if le(pivot,h) then (A,h::B,C) else (h::A,B,C)
                           else (A,B,h::C)
                       end
                   val (A,B,C) = part t h
	       in
		   (sr A)@(h::B)@(sr C)
               end
       in sr
       end

   fun mapcan f [] = []
     | mapcan f (h::t) = (f h)@(mapcan f t)

   fun mapunion eq f [] = []
     | mapunion eq f (h::t) =
       let val v = mapunion eq f t
	   val e = f h
	   fun umapp r [] = r
	     | umapp r (h::t) = if member eq (h,r)
				    then umapp r t
				else umapp (h::r) t
       in
	   umapp v e
       end

   fun max elt_le (h::t) =
       let fun mx (x,[]) = x
	     | mx (x,[h]) = if elt_le(x,h) then h else x
	     | mx (x,h::t) = mx(if elt_le(x,h) then h else x,t)
       in
	   mx (h,t)
       end
     | max _ _ = raise Match

(*
   fun map2 _ [] _ = []
     | map2 _ _ [] = []
     | map2 f (h1::t1) (h2::t2) = (f(h1,h2))::(map2 f t1 t2)
*)

end;
