(*
 *
 * $Log: absyn.fun,v $
 * Revision 1.2  1998/06/03 12:19:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Abstract syntax *)
(* Error messages here need to be improved !!! *)

functor Absyn (structure Basic : BASIC
	       structure Term : TERM
	       structure Naming : NAMING
	          sharing Naming.Term = Term
               structure Symtab : SYMTAB
                  sharing type Symtab.entry = Term.sign_entry) : ABSYN =
struct

structure Term = Term
structure Symtab = Symtab

exception UndeclConst of (int * int) * string
exception AbsynError of (int * int) * string

datatype atom
   = Opr of (int * int) * Term.sign_entry
   | Arg of Term.term

type aterm = string list -> string list -> string list * Term.term
type avarbind = string list -> string list -> string list * Term.varbind
type atermseq = string list -> string list -> string list * (atom list)
type aatom = string list -> string list -> string list * atom

val mark_syntax = ref true

fun mark (arg as (lrpos,M)) = if !mark_syntax then Term.Mark arg else M

fun mark_if_known ((SOME(left),SOME(right)),M) = Term.Mark((left,right),M)
  | mark_if_known (_,M) = M

fun mark_postfix (M as Term.Appl(M1,M2)) =
      if !mark_syntax
	 then mark_if_known ((Term.left_location M2,Term.right_location M1), M)
	 else M
  | mark_postfix _ = raise Basic.Illegal("mark_infix: improper argument")

fun mark_infix (M as (Term.Appl(Term.Appl(_,M1),M2))) =
      if !mark_syntax
	 then mark_if_known ((Term.left_location M1,Term.right_location M2), M)
         else M
  | mark_infix _ = raise Basic.Illegal("mark_infix: improper argument")

(*
fun makestring_lrpos (lpos:int,rpos:int) = "Line " ^ makestring(lpos) ^ ":"
*)

fun make_atom (lrpos,se as Term.E (ref {Fixity = ref (SOME _), ...})) =
       Opr(lrpos,se)
  | make_atom (lrpos,Term.E (ref {Full = d, ...})) = Arg(mark(lrpos,d))
  | make_atom (lrpos,se) = Arg(mark(lrpos,Term.Const(se)))  (* Int, String *)

fun bare_atom_to_term (Arg(M)) = M
  | bare_atom_to_term (Opr(lrpos,Term.E (ref {Full = d, ...}))) = mark(lrpos,d)
  | bare_atom_to_term (Opr(lrpos,se)) = mark(lrpos,Term.Const(se))

fun atom_to_term (aL) = fn bvars => fn freevars =>
       let val (fvs, L) = aL bvars freevars
        in (fvs, bare_atom_to_term L) end

(* Now the code which deals with fixity and precedence *)

exception FixityError of (int * int) * string
exception InternalFixityError of string

fun fixity_of (Opr (_,Term.E (ref {Fixity = ref (SOME (fixity,prec)), ...}))) =
       fixity
  | fixity_of _ = raise Basic.Illegal("fixity_of: arg is not an Opr")

fun makestring_opr (L as Opr (_,Term.E (ref {Bind = Term.Varbind(x,_), ...}))) =
      (case fixity_of L
         of Term.Infix _ => "infix operator " ^ x
	  | Term.Prefix  => "prefix operator " ^ x
	  | Term.Postfix => "postfix operator " ^ x)
  | makestring_opr _ = raise Basic.Illegal("makestring_opr: arg is not an Opr")

fun prec_of (Opr (_,Term.E (ref {Fixity = ref (SOME (fixity,prec)), ...}))) =
       prec
  | prec_of _ = raise Basic.Illegal("prec_of: arg is not an Opr")

fun term_of (Opr (lrpos,Term.E (ref {Full = d, ...}))) = mark(lrpos,d)
  | term_of _ = raise Basic.Illegal("term_of: arg is not an Opr")

fun reduce_postfix (L::Arg(M)::seq') =
       Arg(mark_postfix(Term.Appl(term_of(L),M)))::seq'
  | reduce_postfix _ = raise Basic.Illegal("reduce_postfix: illegal stack")

fun reduce_infix (Arg(M2)::L::Arg(M1)::seq') =
       Arg(mark_infix(Term.Appl(Term.Appl(term_of(L),M1),M2)))::seq'
  | reduce_infix _ = raise Basic.Illegal("reduce_infix: illegal stack")

fun reduce_prefix (Arg(M)::L::seq') = Arg(Term.Appl(term_of(L),M))::seq'
  | reduce_prefix _ = raise Basic.Illegal("reduce_prefix: illegal stack")

fun reduce_stack (nil) = raise Basic.Illegal("reduce_stack: illegal empty stack")
  | reduce_stack (Arg(M)::nil) = M
  | reduce_stack (seq as (Arg(M)::(L as Opr _)::_)) =
      (case fixity_of L
         of Term.Infix(_) => reduce_stack (reduce_infix seq)
	  | Term.Prefix => reduce_stack (reduce_prefix seq)
	  | Term.Postfix => raise Basic.Illegal("reduce_stack: unreduced postfix"))
  | reduce_stack (Arg _ :: Arg _ :: _) =
       raise Basic.Illegal("reduce_stack: unreduced application")
  | reduce_stack (L::_) = 
       raise InternalFixityError("Insufficient arguments for "
				 ^ makestring_opr(L))
       
fun stackArgOpr (L, Term.Infix(_), seq) = L::seq
  | stackArgOpr (L, Term.Prefix, seq) = L::seq
  | stackArgOpr (L, Term.Postfix, seq) =
       raise Basic.Illegal("stackArgOpr: unprocessed postfix")

fun stackOpr1 (L, Term.Prefix) = L::nil
  | stackOpr1 (L, _) =
       raise InternalFixityError("Leading " ^ makestring_opr L)

fun stackOprOpr (L, Term.Prefix, L', fix', seq) = stackArgOpr(L, fix', seq)
  | stackOprOpr (L, fix, L', fix', seq) =
       raise InternalFixityError(makestring_opr L
	                         ^ " following " ^ makestring_opr L')

fun stackOprArg1 (L, Term.Prefix, _) =
       raise InternalFixityError(makestring_opr L ^ " in infix position")
  | stackOprArg1 (L, Term.Postfix, seq) =
       reduce_postfix (L::seq)
  | stackOprArg1 (L, _, seq) = L::seq

fun stackOprArgOpr (L, Term.Postfix, L'', Term.Prefix, seq) =
       if prec_of(L) > prec_of(L'')
	  then reduce_postfix(L::seq)
	  else stack(L, reduce_prefix seq)
  | stackOprArgOpr (L, Term.Postfix, L'', Term.Infix(_), seq) =
       if prec_of(L) > prec_of(L'')
	  then reduce_postfix(L::seq)
	  else stack(L, reduce_infix seq)

  | stackOprArgOpr (L, Term.Prefix, L'', _, seq) =
       raise InternalFixityError(makestring_opr L ^ " in infix position")

  | stackOprArgOpr (L, Term.Infix(Term.None), L'', Term.Infix(Term.None), seq) =
       if prec_of(L) > prec_of(L'')
          then L::seq
	  else if prec_of(L) = prec_of(L'')
		  then raise InternalFixityError("Ambiguous non-associative " ^ makestring_opr L ^ " and " ^ makestring_opr L'')
		  else stack(L, reduce_infix seq)

  | stackOprArgOpr (L, Term.Infix(_), L'', Term.Infix(Term.Right), seq) =
       if prec_of(L) >= prec_of(L'')
          then L::seq
	  else stack(L, reduce_infix seq)  

  | stackOprArgOpr (L, Term.Infix(_), L'', Term.Infix(_), seq) =
       if prec_of(L) > prec_of(L'')
	  then L::seq
	  else stack(L, reduce_infix seq)

  | stackOprArgOpr (L, Term.Infix(_), L'', Term.Prefix, seq) =
       if prec_of(L) > prec_of(L'')
          then L::seq
	  else stack(L, reduce_prefix seq)

  | stackOprArgOpr (L, _, L'', Term.Postfix, seq) =
       raise Basic.Illegal("stackOprArgOpr: illegally stacked postfix")

and stack (L as Arg _,nil) = L::nil
  | stack (L as Arg _,seq as ((O as Opr _)::seq')) =
       stackArgOpr (L, fixity_of O, seq)
  | stack (L as Arg(M), (L' as Arg(M'))::seq') =
       Arg(Term.Appl(M',M))::seq'
  | stack (L as Opr _, nil) = stackOpr1 (L, fixity_of L)
  | stack (L as Opr _, seq as ((L' as Opr _)::seq')) =
       stackOprOpr (L, fixity_of L, L', fixity_of L',seq)
  | stack (L as Opr _, seq as ((L' as Arg _)::nil)) =
       stackOprArg1 (L, fixity_of L, seq)
  | stack (L as Opr _, seq as ((Arg _)::(L'' as Opr _)::seq')) =
       stackOprArgOpr (L, fixity_of L, L'', fixity_of L'', seq)
  | stack (L as Opr _, seq as ((L' as Arg _)::(L'' as Arg _)::seq')) =
       raise Basic.Illegal("stack: illegally stacked Arg's")

fun to_varbind (axofA) = axofA nil nil
fun to_term (aM) = aM nil nil

fun mk_abst (axofA,aM) lrpos = fn bvars => fn freevars =>
    let val (fvs1,xofA as Term.Varbind(vname,_)) = axofA bvars freevars
	val (fvs2,M) = aM (vname::bvars) fvs1
     in (fvs2,mark(lrpos,Term.Abst(xofA,M))) end

fun mk_pi (axofA,aM) lrpos = fn bvars => fn freevars =>
    let val (fvs1,xofA as Term.Varbind(vname,_)) = axofA bvars freevars
	val (fvs2,M) = aM (vname::bvars) fvs1
     in (fvs2,mark(lrpos,Term.make_pi(xofA,M))) end

fun mk_arrow (aM1,aM2) lrpos = fn bvars => fn freevars =>
    let val (fvs1,M1) = aM1 bvars freevars
	val (fvs2,M2) = aM2 bvars fvs1
     in (fvs2,mark(lrpos,Term.make_arrow(M1,M2))) end

fun mk_appl (aM1,aM2) lrpos = fn bvars => fn freevars =>
    let val (fvs1,M1) = aM1 bvars freevars
	val (fvs2,M2) = aM2 bvars fvs1
     in (fvs2,mark(lrpos,Term.Appl(M1,M2))) end

(* version which never marks the application *)
fun mk_appl0 (aM1,aM2) = fn bvars => fn freevars =>
    let val (fvs1,M1) = aM1 bvars freevars
	val (fvs2,M2) = aM2 bvars fvs1
     in (fvs2,Term.Appl(M1,M2)) end

fun mk_hastype (aM,aA) lrpos = fn bvars => fn freevars =>
    let val (fvs1,M) = aM bvars freevars
	val (fvs2,A) = aA bvars fvs1
     in (fvs2,mark(lrpos,Term.HasType(M,A))) end

fun mk_mark (aM) lrpos = fn bvars => fn freevars =>
    let val (fvs,M) = aM bvars freevars
     in (fvs,mark(lrpos,M)) end

fun mk_varbind (vname,aA) = fn bvars => fn freevars =>
    let val (fvs,A) = aA bvars freevars
     in (fvs,Term.Varbind(vname,A)) end

fun mk_oneseq (aL) lrpos = fn bvars => fn freevars =>
    let val (fvs, L) = aL bvars freevars
     in
        (fvs, stack(L,nil))
        handle InternalFixityError(msg) => raise FixityError(lrpos,msg)
    end

fun mk_termseq (aSeq, aL) lrpos = fn bvars => fn freevars =>
    let val (fvs1, seq) = aSeq bvars freevars
        val (fvs2, L) = aL bvars fvs1
     in 
        (fvs2, stack(L,seq))
        handle InternalFixityError(msg) => raise FixityError(lrpos,msg)
    end

fun seq_to_term (aSeq) lrpos = fn bvars => fn freevars =>
    let val (fvs,seq) = aSeq bvars freevars
     in
        (fvs, reduce_stack seq)
        handle InternalFixityError(msg) => raise FixityError(lrpos,msg)
    end

fun term_to_term aL term_mod_fn = fn bvars => fn freevars =>
    let val (fvs,M) = aL bvars freevars
     in (fvs, term_mod_fn M)
    end

fun mk_const (vname) lrpos =
      fn bvars => fn freevars =>
         (freevars,if (exists (fn bv => vname = bv) bvars)
		   then raise AbsynError(lrpos,"Illegal local binding of constant "
					       ^ vname ^ "\n")
                   else (case (Symtab.find_entry vname)
                           of NONE => raise UndeclConst(lrpos,vname)
                            | SOME se => make_atom(lrpos,se)))

fun mk_bv_const vname lrpos =
      fn bvars => fn freevars =>
         (freevars,if (exists (fn bv => vname = bv) bvars)
		      then Arg(mark(lrpos,Term.Bvar(vname)))
		      else (case (Symtab.find_entry vname)
                              of NONE => raise UndeclConst(lrpos,vname)
                               | SOME se => make_atom(lrpos,se)))

fun mk_bv_fv vname lrpos =
      fn bvars => fn freevars =>
         (if (exists (fn bv => vname = bv) bvars)
	        orelse (exists (fn fv => vname = fv) freevars)
             then freevars
	     else vname::freevars ,
	  Arg(mark(lrpos,Term.Bvar(vname))))

fun mk_bv_const_fv vname lrpos =
      fn bvars => fn freevars =>
         if (exists (fn bv => vname = bv) bvars)
	    then (freevars,Arg(mark(lrpos,Term.Bvar(vname))))
	    else (case (Symtab.find_entry vname)
                    of NONE => ((if (exists (fn fv => vname = fv) freevars)
                 	        then freevars
                 	        else vname::freevars),
                       		Arg(mark(lrpos,Term.Bvar(vname))))
                     | SOME se => (freevars,make_atom(lrpos,se)))

fun mk_bv_uv_const vname lrpos =
      fn bvars => fn freevars =>
         (freevars,if (exists (fn bv => vname = bv) bvars)
		      then Arg(mark(lrpos,Term.Bvar(vname)))
		      else (case (Naming.lookup_varname vname)
			      of NONE => (case (Symtab.find_entry vname)
					   of NONE => raise UndeclConst(lrpos,vname)
					    | SOME se => make_atom(lrpos,se))
			       | SOME M => Arg(mark(lrpos,M))))

fun mk_bv_uv_const_fv vname lrpos =
      fn bvars => fn freevars =>
         if (exists (fn bv => vname = bv) bvars)
	    then (freevars,Arg(mark(lrpos,Term.Bvar(vname))))
	    else (case (Naming.lookup_varname vname)
		      of NONE => (case (Symtab.find_entry vname)
				      of NONE => ((if (exists (fn fv => vname = fv)
						       freevars)
						   then freevars
						   else vname::freevars),
						  Arg(mark(lrpos,Term.Bvar(vname))))
				       | SOME se => (freevars,make_atom(lrpos,se)))
		       | SOME M => (freevars,Arg(mark(lrpos,M))))

fun mk_uscore lrpos = fn bvars => fn freevars =>
    (freevars,mark(lrpos,Term.Wild))

fun mk_ttype lrpos = fn bvars => fn freevars =>
    (freevars,mark(lrpos,Term.Type))

fun term_to_atom (aM) = fn bvars => fn freevars =>
    let val (fvs, M) = aM bvars freevars
     in (fvs, Arg(M)) end

fun mk_int (n) lrpos = fn bvars => fn freevars =>
    (freevars, mark(lrpos,Term.Const(Term.Int(n))))

fun mk_string (str) lrpos = fn bvars => fn freevars =>
       (freevars, mark(lrpos,Term.Const(Term.String(str))))

fun mk_int_type lrpos = fn bvars => fn freevars =>
       (freevars, mark(lrpos,Term.Const(Term.IntType)))

fun mk_string_type lrpos = fn bvars => fn freevars =>
       (freevars, mark(lrpos,Term.Const(Term.StringType)))

val mk_uscore_string = "_"

fun mk_binop (opname,abM1,abM2) lrpos_op lrpos_whole =
  mk_appl (mk_appl0(atom_to_term(mk_const opname lrpos_op),abM1),abM2)
          lrpos_whole

fun mk_quant (qname,abM) lrpos_quant lrpos_whole =
  mk_appl (atom_to_term(mk_const qname lrpos_quant),abM) lrpos_whole

type afixity = int * string list

fun find_cref lrpos x =
       (case (Symtab.find_entry x)
	  of NONE => raise UndeclConst(lrpos,x)
	   | SOME (sigentry) => sigentry)

fun mk_fix (fsp,(n,ys)) lrpos = ((fsp, n), map (find_cref lrpos) ys)
fun mk_fixity (n,ys) lrpos = 
       if n > Term.fixity_max
          then raise FixityError
	       (lrpos, "Precedence " ^ makestring n
		^ " too large (maximum: " ^ makestring Term.fixity_max ^ ")")
          else if n < Term.fixity_min
	      then raise FixityError
		   (lrpos, "Precedence " ^ makestring n
		    ^ " too small (minimum: " ^ makestring Term.fixity_min ^ ")")
	       else (n,ys)

fun mk_name_pref (x,ys) lrpos = (find_cref lrpos x, ys)

end  (* functor Absyn *)
