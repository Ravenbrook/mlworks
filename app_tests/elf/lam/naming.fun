(*
 *
 * $Log: naming.fun,v $
 * Revision 1.2  1998/06/03 12:16:00  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Renaming primitives *)
(* This may have to be reconsidered for different languages *)

functor Naming (structure Basic : BASIC
	        structure Term : TERM) : NAMING =
struct

structure Term = Term

local 
  open Term

  fun is_anonymous (x) = (x = anonymous)

  fun renumber cf x index =
         let val x' = (x ^ makestring(index))
	  in if cf x'
		then renumber cf x (index + 1)
		else x'
	 end

  fun rename_apart cf x =
         if cf x
	    then renumber cf x 1
	    else x

  fun pick_pref cf nil = raise Basic.Illegal("pick_pref: empty list of preferences")
    | pick_pref cf (ys as (y1::_)) =
         let fun pp nil = renumber cf y1 1
	       | pp (y::ys) = if cf y then pp ys else y
          in pp ys end

  fun approx_target_fam (A as Const _) = SOME(A)
    | approx_target_fam (Appl(A,M)) = approx_target_fam A
    | approx_target_fam (Pi((_,B),_)) = approx_target_fam B
    | approx_target_fam (Type) = SOME(Type)
    | approx_target_fam (Abst(_,A)) = approx_target_fam A
    | approx_target_fam (Evar(_,_,_,ref(SOME(A)))) = approx_target_fam A
    | approx_target_fam (Evar(_,_,_,ref NONE)) = NONE
    | approx_target_fam (Bvar _) = NONE
    | approx_target_fam (Uvar _) = NONE
    | approx_target_fam (HasType(A,_)) = approx_target_fam A
    | approx_target_fam (Mark(_,M)) = approx_target_fam M
    | approx_target_fam (Wild) = NONE    
    | approx_target_fam (Fvar _) = NONE

  fun pref_name cf A =
        let val h = approx_target_fam A
	    fun prefs (NONE) = pick_pref cf ["X"]
	      | prefs (SOME(Const(E(ref {NamePref = ref(NONE), ...})))) =
		  pick_pref cf ["X"]
	      | prefs (SOME(Const(E(ref {NamePref = ref(SOME(ys)), ...})))) =
		  pick_pref cf ys
	      | prefs (SOME(Type)) = pick_pref cf ["A"]
	      | prefs (SOME(Const(IntType))) = pick_pref cf ["N"]
	      | prefs (SOME(Const(StringType))) = pick_pref cf ["S"]
	      | prefs _ = raise Basic.Illegal("pref_name: illegal approximate head")
	 in prefs h end

  val varname_list = ref (nil : (term * string) list)
  val uvarname_list = ref (nil : (term * string option ref) list)

  val temp_varname_list = ref (nil : (term * string) list)
  val temp_uvarname_list = ref (nil : (term * string option ref) list)


  fun same_var (x,y as Evar(_,_,_,ref(SOME(A)))) =
           eq_var(x,y) orelse same_var(x,A)
    | same_var (x,y) = eq_var(x,y)

  fun get_varname x nil = NONE
    | get_varname x ((y,name)::l) =
	      if same_var(x,y)
		 then SOME(name)
	         else get_varname x l

  fun get_or_assign_uvarname name_fn x nil = raise Basic.Illegal
         ("get_or_assign_uvarname: trying to name nonexistant parameter")
    | get_or_assign_uvarname name_fn x ((y,nameslot)::l) =
         (case (!nameslot)
	      of NONE => let val newname = name_fn ()
			 in nameslot := SOME(newname) ; newname
			 end
	       | SOME(name) => if eq_var(x,y)
			       then name
			       else get_or_assign_uvarname name_fn x l)

  fun get_var name nil = NONE
    | get_var name ((x,name')::l) =
         if name = name'
	    then SOME(x)
	    else get_var name l

  fun get_uvar name nil = NONE
    | get_uvar name ((x,ref NONE)::l) = get_uvar name l
    | get_uvar name ((x,ref (SOME name'))::l) =
         if name = name'
	    then SOME(x)
	    else get_uvar name l

  fun name_hint (Uvar(xofA,_)) = xofA
    | name_hint (Evar(xofA,_,_,_)) = xofA
    | name_hint (Fvar(xofA)) = xofA
    | name_hint _ = raise Basic.Illegal("namepref: non-variable argument")

in

  fun rename_varbind conflict_func (Varbind(x,A)) =
         if is_anonymous(x)
	    then pref_name conflict_func A
	    else renumber conflict_func x 1

  fun new_vname conflict_func (Varbind(x,A)) =
         if is_anonymous(x)
	    then pref_name conflict_func A
	    else rename_apart conflict_func x

  fun reset_varnames () = ( varname_list := nil;
			    temp_varname_list := nil )

  fun store_varnames () = ( temp_varname_list := (!varname_list);
			    varname_list := nil;
			    uvarname_list := nil)

  fun restore_varnames () = ( varname_list := (!temp_varname_list) )

  fun name_var conflict_fun x =
        (case (get_varname x (!varname_list))
	   of SOME(name) => name
	    | NONE => let val name = new_vname conflict_fun (name_hint x)
		       in ( varname_list := (x,name)::(!varname_list) ;
			    name ) end)
	     
  fun name_uvar conflict_fun x =
      let fun name_fun () = new_vname conflict_fun (name_hint x)
      in get_or_assign_uvarname name_fun x (!uvarname_list)
      end

  fun lookup_varname name =
        (case get_uvar name (!uvarname_list)
	     of NONE => get_var name (!varname_list)
	      | SOME(var) => SOME(var))

  fun install_names name_list = ( uvarname_list := name_list )

end  (* local ... *)

end  (* functor Naming *)
