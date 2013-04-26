(*
 *
 * $Log: variable.sml,v $
 * Revision 1.2  1998/06/08 17:40:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(*
variable.ml			BMM   27-02-90

This module gives the code for the handling variables.

Depends on : 
	sort.sml

We need a mechanism for generating an unbounded number of variables. 

This could be handled in a similar fashion to the symbols, where the 
information about the symbol is kept strictly in the Symbol_Store.

However, for implementation convenience (as variables are frequently generated
and destroyed on the fly, without the representation being used) we choose to
carry information about the variable around with us.  

The Variable Store thus take on a different role (so slightly misleading terminology!)
to the Symbol Store.  Rather than represent the variables currently being used, 
it just contains a set of proformas for generating new variables of a given sort.
i.e. a variable can always be created of a given a sort.

*)

functor VariableFUN (structure S:SORT
		    ):VARIABLE = 
struct

type Sort = S.Sort
type Sort_Store = S.Sort_Store

(* 

A Variable consists of triple:

an int : a unique internal identifier for the variable
a string : a (partial) printable representation of the variable 
a Sort : the sort of the variable

variable_sort : Variable -> Sort 		- returns sort of variable
variable_label : Variable -> string		- returns a printable string
generate_variable : Sort -> Variable		- generates a variable of given sort (anonymous)
make_variable : string -> Sort -> Variable	- Gives a new variable of given label and sort
rename_variable : Variable -> Variable		- new identifier (same string)
VarEq : Variable -> Variable -> bool   		- Equality on Variables (on unique identifiers).
ord_v : Variable -> Variable -> bool   		- Arbritary syntactic ordering on variables.

*)

abstype Variable = Va of int * string * Sort 
	with
	local
	val var_num = ref 0 
	in

	fun variable_sort (Va (_,_,s)) = s 
	fun variable_label (Va (_,v,_)) = v

	fun generate_variable s = (inc var_num ; Va (!var_num,"",s))
	fun make_variable v s =  (inc var_num ; Va (!var_num,v,s))
	fun rename_variable (Va (_,st,s)) = (inc var_num ; Va (!var_num,st,s))

	fun VarEq (Va(n,_,s)) (Va(n',_,s')) = n = n' andalso S.SortEq s s'
	fun ord_v (Va(n,_,_)) (Va(n',_,_)) = n <= n'
	
	end (* of local *)

	end (* of abstype Variable *) ;

(*

The Variable Store contains the proformas for the printable representations of
variables.   (thus the string * Sort type in the Variable_Store). 

However, variables can be declared in TWO ways.  

i). As a whole variable e.g.  fred : int 
    		where any occurence of the string "fred" would be taken as the 
    		variable of that sort.
ii). As a variable prefix.  e.g.  x* : int
		where any string beginning with an x would be taken as a variable
		of sort int PROVIDING it was not an operator symbol or a whole 
		variable.

The two components Stores in the type Variable_Store hole the information of
these two different methods.

declare_variable : Variable_Store -> (string * Sort) -> Variable_Store
declare_prefix : Variable_Store -> (string * Sort) -> Variable_Store
*)

local
structure VOL = OrdList2FUN (struct type T = string * Sort
				   fun order (s1,_) (s2,_) = stringorder s1 s2
			    end)

open VOL
in
abstype Variable_Store = Vars of OrdList * OrdList
with

val Empty_Variable_Store = Vars (EMPTY,EMPTY)
fun declare_variable (Vars(Wholes,Prefixes)) (v,s) =
    (case lookup Wholes (v,s) of
     Match (v',s') => if  S.SortEq s s' then Vars(Wholes,Prefixes)
                      else (warning_message("Variable "^v^" already declared with different sort.  Overwriting.");
  			   Vars(insert (remove Wholes (v,s)) (v,s) , Prefixes) )
     | NoMatch => Vars(insert Wholes (v,s) , Prefixes) )

fun checkprefix (v,s) (v',s') = not (v = v' andalso S.SortEq s s') 
                                andalso (initial_substring v v' orelse initial_substring v' v )

fun declare_prefix (Vars(Wholes,Prefixes)) (v,s) =
    (case search checkprefix Prefixes (v,s) of
     Match (v',s') => (error_message ("prefix "^v^" clashes with prefix "^v');
  			   Vars(Wholes , Prefixes) )
     | NoMatch => Vars(Wholes , insert Prefixes (v,s)) )
	
local
fun checkwhole v (v',s') = v = v'
in 
fun read_variable (Vars(Wholes,Prefixes)) v = 
    let fun checkprefix v (v',s') = initial_substring v v'
    in  case    (case search checkwhole Wholes v of
      		NoMatch => search checkprefix Prefixes v 
      		| x => x )
	of 
	NoMatch => NoMatch |
	Match (_,s) => Match (make_variable v s)
    end

fun delete_variable (Vars(Wholes,Prefixes)) v = 
    Vars(remove Wholes (v,S.Top), remove Prefixes (v,S.Top))
end (* of local *)
	
local 
fun check s (v,s') = S.SortEq s s'
in
fun display_variable (Vars(Wholes,Prefixes)) Var = 
    let val st = variable_label Var
        val s = variable_sort Var
    in
    if st = "" then
    fst (case search check Prefixes s of 
	 Match v => v |
	 NoMatch => (case search check Wholes s of 
	    	     Match v => v |
	    	     NoMatch => ("?:"^S.sort_name s,s)  (* make up a name *)
	    	    )
	)
    else st
    end
end (* of local *)

fun names_of_vars (Vars(Wholes,Prefixes)) = 
    apply_both (List.map (apply_snd S.sort_name)) (Wholes,Prefixes)

fun variable_parser SS VS env sl = 
    let val ss = (strip sl)
    in if null ss then Error "No More Input For Variable"
       else 
       let val (v,rs) = (hd ss,tl ss) in 
       case Assoc.assoc_lookup eq v env of
        Match var => OK ((var,strip rs),env)
      | NoMatch   => (* generate new variable *)
      	 (case read_variable VS v of 
               Match var => OK ((var,strip rs),Assoc.assoc_nocheck v var env)
      	     | NoMatch => 	(* in this case, we may have in-line variable declaration *)
    		let val ss = (strip rs) 
    		in if null ss 
		   then Error (v^" not recognised as Variable.")
		   else let val (c,rss) = (hd ss, tl ss) in 
		        if c = ":" then 
		        let val rss = (strip rss) in 
		            if null rss then  
		        	Error (v^" not recognised as Variable.")
			    else let val (s,rss) = (hd rss,tl rss)
			             val so = S.name_sort s
			         in 
			         if S.is_declared_sort SS so
			         then let val var = generate_variable so
			              in  
			              OK ((var,rss),Assoc.assoc_nocheck v var env)
			              end 
			         else Error (v^" not recognised as Variable.")
			         end
			end
			else (* else for c = ":" condition *)
			Error (v^" not recognised as Variable.")
		        end
                end )
       end 
    end (* of function variable_parser*)

   end  (* of abstype Variable *)
end (* of local *)

(*

The abstract type Variable_Print_Env is a structure
which is used to provide a consistent, yet simple representation of variable
which occur in a term or in an equations

The structure as implemented is rather complicated - perhaps too complicated
for simple understanding - that is why I have separated it out into a abstype
of its own.

Only one constant and one function are provided.

type Variable_Print_Env

Empty_Var_Print_Env  : Variable_Print_Env
lookup_var_print_env : Variable_Print_Env -> Variable_Store -> 
			Variable -> string * Variable_Print_Env

The Empty_Var_Print_Env is self explanatory. 
lookup_var_print_env looks up the current representation of the variable (from
the string representation carried by the variable) and returns it if
it has already been used.  If it has yet to be used, it will insert it into 
the environment, as well.   Thus a new variable environment is returned.

The data structure is organised thus: 

(string , int * (Variable, string) Assoc.Assoc) Assoc.Assoc

The basic structure is an association list between strings and a pair.
The first part of the pair is an integer which is the number of entries
in the second part of the pair - an association list of variables and 
strings. 

The outer string is the representation of the variable as it is given 
in the variable/variable store.  Thus for variable x23476 it is "x", 
for y7823 it is "y".  The second string is a suffix to that string
for display in the term being printed.  

This relate to the term printer, but I give it here for showing the 
use of this environment.

eg term (with internal representations of vars)
	x678 + (y56 + ( x783 + x678 ) )

on reading x678 this sets up mapping:
	[ "x" -> (1 , [x678 -> ""])]

thus x678 is printed as "x" ^ "" = "x"

for y56, "y" =/= "x" therefore 
	[ "x" -> (1 , [x678 -> ""]) ,
	  "y" -> (1 , [y56  -> ""]) ]

on reading x783, an "x" variable, but different to previous therefore 
use the integer to provide a new suffix, and increment integer:
	[ "x" -> (2 , [x678 -> "",  x783 -> "1" ]) ,
	  "y" -> (1 , [y56  -> ""]) ]
x783 in then printed as "x" ^ "1" = "x1"

x678 has been read before and therefore we can read of the representation.

Thus the term is printed :  "x + (y + (x1 + x))"


*)


abstype Variable_Print_Env = 
        VPEnv of (string , int * (Variable, string) Assoc.Assoc) Assoc.Assoc
   with 
   
   local 
   val lookup_string = Assoc.assoc_lookup (eq : string -> string -> bool)
   val update_string = Assoc.assoc_update (eq : string -> string -> bool)
   val lookup_var = Assoc.assoc_lookup VarEq
   val update_var = Assoc.assoc_update VarEq
   in
   
   val Empty_Var_Print_Env = VPEnv Assoc.Empty_Assoc

   fun lookup_var_print_env (VPEnv vt) Vs vi = 
       let val vs = display_variable Vs vi
       in
       case lookup_string vs vt of	(* lookup string in environment *)
         NoMatch     => (vs,VPEnv(update_string vs (1,
                                  update_var vi "" Assoc.Empty_Assoc) vt))

       (* 
          if it is not there, we can return the string as it is, 
          but have to make the entry that we have seen that variable.  
       *)

       | Match (n,va) => (case lookup_var vi va of
                          NoMatch  => (vs^ makestring n,
                           	VPEnv(update_string  vs 
                           	(n+1,update_var vi (makestring n) va) vt))
                       	| Match ss => (vs^ss,VPEnv vt))
       end

   end (* of local in abstype *)

   end (* of abstype Variable_Print_Env *)

end (* of functor VariableFUN *)
  ; 
