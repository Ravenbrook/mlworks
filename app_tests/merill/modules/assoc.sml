(*
 *
 * $Log: assoc.sml,v $
 * Revision 1.2  1998/06/08 17:31:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

assoc.ml			BMM   27-02-90

This provides a type of association lists.  They are not classical assoc lists
as they can signal failure on clashes.  

Somtimes known as bindings.

*)
signature ASSOC = 
  sig
	type ('a,'b) Assoc
	val Empty_Assoc : ('a,'b) Assoc
	val FailAssoc   : ('a,'b) Assoc
	val assoc_lookup : ('a -> 'a -> bool) -> 'a -> ('a,'b) Assoc -> 'b Search
	val isfailassoc : ('a,'b) Assoc -> bool
	val assoc_update : ('a -> 'a -> bool) -> 'a -> 'b -> 
		  	('a,'b) Assoc -> ('a,'b) Assoc 
	val assoc : ('a -> 'a -> bool) -> ('b -> 'b -> bool) -> 'a -> 'b -> 
		  			('a,'b) Assoc -> ('a,'b) Assoc 
	val assoc_nocheck : 'a -> 'b -> ('a,'b) Assoc -> ('a,'b) Assoc
	val compose_assocs : ('a -> 'a -> bool) -> ('b -> 'b -> bool) -> 
		  		(('a,'b) Assoc -> 'b -> 'b) -> ('a,'b) Assoc 
		  		-> ('a,'b) Assoc -> ('a,'b) Assoc 
end (* of signature ASSOC *)
;

structure Assoc : ASSOC = 
struct

abstype ('a,'b) Assoc = Ass of ('a * 'b) list | FailAss
  with
    val Empty_Assoc = Ass []
    val FailAssoc   = FailAss
    
    local
      fun addb p (Ass bl) = Ass (p::bl)
	| addb _  FailAss = FailAssoc

      fun printb pra prb (x,y) = (ignore(pra x); prb y)
    in
      fun isfailassoc FailAss = true
	| isfailassoc _ = false

      fun printbind pra prb  (Ass m)  = (app (printb pra prb) m; "\n")
        | printbind _ _ FailAss = "FailAssoc"

      fun assoc_lookup equalsa x (Ass bl) =
          let fun scan ((h,hb)::tl) = if equalsa x h then Match hb else scan tl
	        | scan [] = NoMatch
          in scan bl
          end
	| assoc_lookup _ _ FailAss = NoMatch
  
      fun assoc_update equalsa x y (Ass bl) =
        let fun remove ((h,hb)::tl) = if equalsa x h then tl
				    else (h,hb)::(remove tl)
	      | remove [] = []
        in
	  addb (x,y) (Ass (remove bl))
        end
	| assoc_update _ _ _ FailAss = FailAssoc

      fun assoc _ _ _ _ FailAss = FailAssoc
	| assoc equalsa equalsb x y bnd =
        ( case assoc_lookup equalsa x bnd of
           NoMatch   => addb (x,y) bnd 
           | Match b => if equalsb b y then bnd else FailAssoc )
      
      fun assoc_nocheck x i (Ass abl) = Ass ((x,i)::abl)
        | assoc_nocheck _ _ FailAss = FailAssoc
     
     (* Merge bindings S2 into bindings S1 taking care to *)
     (* 'app' the bindings in S2 to the right sides of S1 *)
     (* incase 'b is equal to 'a; Duplicate bindings in S1*)
     (* and S2 will cause FailAssoc in addbind             *)

      fun compose_assocs eqa eqb app FailAss _ = FailAssoc
        | compose_assocs eqa eqb app _ FailAss = FailAssoc
        | compose_assocs eqa eqb app (Ass []) S = S
        | compose_assocs eqa eqb app S (Ass []) = S
        | compose_assocs eqa eqb app (Ass ((v,t)::rs)) S =
          assoc eqa eqb v (app S t)
	      (compose_assocs eqa eqb app (Ass rs) S)
    end
  end

end ; (* of structure Assoc *) 
