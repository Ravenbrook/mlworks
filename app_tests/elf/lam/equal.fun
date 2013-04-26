(*
 *
 * $Log: equal.fun,v $
 * Revision 1.2  1998/06/03 12:17:14  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Term equality *)

functor Equal
  (structure Term        : TERM
   structure Sb		 : SB          sharing Sb.Term = Term
   structure Reduce	 : REDUCE      sharing Reduce.Term = Term
   structure UUtils	 : UUTILS      sharing UUtils.Term = Term)
  : EQUAL =
struct

structure Term = Term

local open Term
in

   fun term_eq(M,N) = term_eq_norm(Reduce.head_norm M,Reduce.head_norm N)
   and term_eq_norm (M as Abst(xofA,_),N) =
	 let val a = Sb.new_uvar xofA
	  in term_eq(Appl(M,a),Appl(N,a)) end
     | term_eq_norm (M, N as Abst(xofA,_)) =
	 let val a = Sb.new_uvar xofA
	  in term_eq(Appl(M,a),Appl(N,a)) end
     | term_eq_norm (M as Pi((xofA as Varbind(x,A),B),occurs),
		     N as Pi((yofA' as Varbind(y,A'),B'),occurs')) =
         if (occurs = Vacuous) andalso (occurs' = Vacuous)
	    then term_eq(A,A') andalso term_eq(B,B')
	    else if term_eq(A,A')
		    then let val a = Sb.new_uvar xofA
			  in term_eq (Sb.apply_sb (Sb.term_sb xofA a) B,
				      Sb.apply_sb (Sb.term_sb yofA' a) B')
			 end
		    else false
     | term_eq_norm (Pi _, _) = false
     | term_eq_norm (_, Pi _) = false
     | term_eq_norm (Type, Type) = true
     | term_eq_norm (Type, _) = false
     | term_eq_norm (_, Type) = false
     | term_eq_norm (M,N) = head_args_eq ((M,Reduce.head_args M),
					  (N,Reduce.head_args N))
   and head_args_eq ((M,(headM,Margs)),(N,(headN,Nargs))) =
	 if Reduce.eq_head(headM,headN) andalso args_eq(Margs,Nargs)
	 then true
	 else let val Mdef = UUtils.is_defn headM
		  and Ndef = UUtils.is_defn headN
		  fun expand (NONE,NONE) = false
		    | expand (NONE,SOME(H)) = term_eq(M,UUtils.replace_head N H)
		    | expand (SOME(G),NONE) = term_eq(UUtils.replace_head M G,N)
		    | expand (SOME(G),SOME(H)) =
			term_eq(UUtils.replace_head M G,UUtils.replace_head N H)
	       in expand(Mdef,Ndef) end
   and args_eq (nil,nil) = true
     | args_eq ((M1::restM),(N1::restN)) =
	  term_eq(M1,N1) andalso args_eq(restM,restN)
     | args_eq (_,_) = false

end  (* local ... *)
end  (* functor Equal *)
