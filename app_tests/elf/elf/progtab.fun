(*
 *
 * $Log: progtab.fun,v $
 * Revision 1.2  1998/06/03 12:25:09  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Spiro Michaylov <spiro@cs.cmu.edu>       *)
(* Modified: Frank Pfenning <fp@cs.cmu.edu>, Feb  4 1992 *)

(* Program table *)

functor Progtab
   (structure Basic : BASIC
    structure Term : TERM
    structure Sb : SB sharing Sb.Term = Term 
    structure Sign : SIGN     sharing Sign.Term = Term
    structure Print : PRINT   sharing Print.Term = Term
    structure Reduce : REDUCE  sharing Reduce.Term = Term
    structure Skeleton : SKELETON sharing Skeleton.Term = Term)
   : PROGTAB =
struct

structure Term = Term
structure Sign = Sign
structure Skeleton = Skeleton

local open Term
in

  exception Progtab

  datatype mobility = Dynamic of bool | Static | Unknown of bool

  datatype progentry =
      Progentry of 
	  {
	  Faml: Term.term,                (* family *) 
	  Name: Term.term,                (* name of rule *)
	  Vars: Term.varbind list,        (* variables *)
	  Head: Term.term,                (* head of rule *)
	  Subg: mobility list,            (* subgoals *)
	  Indx: Term.term option,	  (* principal functor of 1st arg *)
	  Skln: Skeleton.skeleton         (* skeleton for unification *)
	  }

  val rules : progentry list Array.array = Array.array (1000,nil)

  val free_prog : int ref = ref 0

  (* reset should only be called if the symbol table is cleared out at the *)
  (* same time.  Normally, store_prog will reinitialize the program table *)
  fun reset () = ( free_prog := 0 )

  fun clean_prog_table () = 
	  let fun cpt (0) = ()
		| cpt (n) = (Array.update (rules,n-1,nil) ; cpt (n-1))
	   in cpt (!free_prog) end

  fun end_of_rel pos rule = 
	  Array.update (rules, pos, ( Array.sub (rules,pos) @ (rule::nil) ))

  fun store_rule (rule as (Progentry {Faml = (Const(E(ref {Prog = index_r, ...}))), ...})) = 
	  (case !index_r
	     of NONE =>          (index_r := SOME (!free_prog) ;
				  Array.update (rules,(!free_prog),(rule::nil)) ;
				  free_prog := !free_prog + 1 ;
				  () )
	      | SOME ri =>       (end_of_rel ri rule;
				  () ))
    | store_rule (rule) =
         raise Basic.Illegal("store_rule: head is not a constant")

  fun store_prog progs = 
	  let val _ = clean_prog_table ()
	      fun ss nil = ()
		| ss (rule::rules) = (store_rule rule ; ss rules)
	      fun sp nil = ()
		| sp (prog::progs) = (ss prog ; sp progs)
	   in sp progs end

  (* The notion of dynamic below presumes that polymorphism is static *)

  fun mark_dynamic (Const(E(ref {Prog = index_r, Dyn = dyn_r, ...}))) =
        ( case !index_r
	    of NONE => (index_r := SOME (!free_prog) ;
			Array.update (rules,!free_prog,nil) ;
			free_prog := !free_prog + 1)
             | _ => () ;
          dyn_r := true )
    | mark_dynamic (Uvar _) = ()  (* Uvar's must be static right now *)
    | mark_dynamic _ =
         raise Basic.Illegal("mark_dynamic: family is not constant")

  fun is_dynamic (Const(E(ref {Dyn = ref(dyn), ...}))) = dyn
    | is_dynamic _ = false

  fun occurs_to_bool Maybe = true
    | occurs_to_bool Vacuous = false

  fun mobility_occ A occurs =
    let fun mobility (A as Const _) =
	       if is_dynamic A
	          then Dynamic (occurs_to_bool occurs)
		  else Static
	  | mobility (Appl(A,M)) = mobility A
	  | mobility (Pi((_,B),_)) = mobility B
	  | mobility (Type) = Static
	  | mobility (Abst(_,A)) = mobility A
	  | mobility (Evar(_,_,_,ref(SOME(A)))) = mobility A
	  | mobility (Evar(_,_,_,ref NONE)) = Unknown (occurs_to_bool occurs)
	  | mobility (Uvar _) = Unknown (occurs_to_bool occurs)
	  | mobility _ = raise Basic.Illegal ("mobility: unexprected argument")
    in mobility A end

  fun sbgs A sg =
       let val A' = Reduce.head_norm A
	in case A'
	     of Pi((yofB as Varbind(y,B),C),occurs) =>
		 let val sg' = mobility_occ B occurs :: sg
		  in if (occurs = Maybe)
		        then let val b = Sb.new_uvar yofB
			      in sbgs (Sb.apply_sb (Sb.term_sb yofB b) C)
				          sg'
			     end
			else sbgs C sg'
		 end
	      | _ => sg
       end

  fun subgoals A = sbgs A nil

  fun get_rules (Uvar _) = nil  
    | get_rules (Const(entry as E(ref {Prog = index_r, ...}))) = 
	  (case !index_r
	     of NONE =>           nil
	      | SOME ri =>        Array.sub (rules,ri) )
    | get_rules _ =
         raise Basic.Illegal("get_rules: head is not a Uvar or constant")

  fun first_arg _ nil = NONE
    | first_arg (Appl(M,_)) (h::t) = first_arg M t
    | first_arg _ (h::t) = SOME(h)

  fun term_index (Const e) = SOME(Const e)
    | term_index (Uvar v) = SOME(Uvar v)
    | term_index (Appl(M,_)) = term_index(M)
    | term_index (Evar(_,_,_,ref(SOME M0))) = term_index M0
    | term_index (Abst(_,M)) = term_index(M)
    | term_index _ = NONE

  fun get_index (Const(E(ref {Full = f, ...}))) args = 
	  let val a = first_arg f args
	   in
		  (case a 
		     of NONE => NONE
		      | SOME(t) => term_index t)
	  end
    | get_index (Uvar v) args = 
		  (case args 
		     of h::t => SOME(h)
		      | _ => NONE)
    | get_index _ _ =
         raise Basic.Illegal("get_index: head is not a Uvar or constant")

  fun indexes_match NONE _ = true
    | indexes_match _ NONE = true
    | indexes_match (SOME i1) (SOME i2) = Reduce.eq_head (i1,i2)

  (*
     In order to ``compile'' we need to know which families are static
     and which families are dynamic.  We thus record each entry in the
     program table as it is converted.  The program table can still be
     garbage collected by the call to the query function.
  *)

  fun is_knd_target (Type) = true
    | is_knd_target _ = false

  fun make_progentry only_if_dynamic (c,A) =
      let val (Gamma,A') = Reduce.pi_vbds(A)
	  val d = Reduce.rigid_term_head A'
		  handle Basic.Illegal _ =>
		   raise Print.subtype("Conversion to program", A',
				       ", the clause head, has a variable head")
	  val (head,args) = Reduce.head_args A'
       in if is_knd_target(d)
	  then NONE
	  else if only_if_dynamic andalso not(is_dynamic(d))
	       then NONE
	       else SOME(Progentry 
			       {  Faml = d, 
				  Name = c,
				  Vars = Gamma,
				  Head = A',
				  Subg = subgoals A,
				  Indx = get_index head args, 
				  Skln = Skeleton.debone A' }  )
      end

  (* Note: a signature is in reverse order! *)

  fun sign_to_prog dynamic sign =
      let fun stp nil = nil
	    | stp ((e as E(ref {Bind = Varbind(c,A),...}))::se_list) =
		  (case (make_progentry false (Const(e),A))
		     of NONE => ( if dynamic
				     then mark_dynamic (Const(e))
				     else () ;
                                  stp se_list )
		      | SOME(progentry) => progentry :: stp se_list)
	    | stp _ = 
		  raise Basic.Illegal("sign_to_prog: basic const in signature")
       in stp (Sign.sig_to_list sign) end

end (* local ... *)
end (* functor Progtab *)
