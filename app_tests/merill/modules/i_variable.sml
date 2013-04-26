(*
 *
 * $Log: i_variable.sml,v $
 * Revision 1.2  1998/06/08 18:08:26  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

This module provides the top level interface for the formal entering and display of algebra 
descriptions, orderings on sorts and symbols, and equality sets.

bmm     23 - 04 - 90

*)

functor I_Variable (structure S : SORT
		    structure V : VARIABLE 
		    structure iS : I_SORT
		    sharing type S.Sort = V.Sort = iS.Sort
		    and     type S.Sort_Store = iS.Sort_Store = V.Sort_Store
		   ) : I_VARIABLE = 
struct 

type Variable_Store = V.Variable_Store
type Sort_Store = V.Sort_Store

open S V 

local

open Parse 

datatype VarDec = Whole of string | Prefix of string

fun vardec_parser ss s =
let 
val id = notkey [":","*"]
val sortp = iS.sort_parser ss

fun variable_dec_line toks = 
	(    drop_errors(variable_dec -- $":") --  sortp  >> apply_fst fst
	) toks
and variable_dec toks = 
        (    id  --  $"*"	>> (Prefix o fst)
          || id			>> Whole
        ) toks 
in
reader variable_dec_line s
	handle (SynError m) => (error_message m ; raise (SynError m))
end 

fun read_variables infn endfn SS VS =
    let val s = infn ()
    in if endfn s then VS else
       read_variables infn endfn SS
	       ((case vardec_parser SS s of
	         (Whole v ,sv) => declare_variable VS (v,sv)
	       | (Prefix v,sv) => declare_prefix   VS (v,sv)
	       )  handle (SynError_) => VS)
    end  
in 
val enter_variables = read_variables (fn () => prompt_line "") Strings.nl
fun load_variables infn = read_variables infn Lex.end_check1
end (* of local *)

	local 
	val show_wholes = map (fn (v,s) => v^"  :  "^ s)
	val show_pres = map (fn (v,s) => v^"*  :  "^ s)
	in
	fun display_variables VS = 
	    let val (wls,pfxs) = names_of_vars VS
	    in display_two_cols Left ("Declared Variables",
	        show_wholes wls ,
	        "Variable Prefixes" ,
	        show_pres pfxs )
	    end  

	fun save_variables outfn VS = 
	    let val (wls,pfxs) = names_of_vars VS
	        val f = (fn () => outfn "\n") o outfn
	    in (app f (show_wholes wls) ;
	        app f (show_pres pfxs) ;
	        outfn Lex.end_marker)
	    end  
	end

        fun delete_variables vs = 
		let val s = prompt_line ""
		in if nl s then vs 
		   else delete_variables (foldl delete_variable vs (Lex.lex_line s))
		end  

local
val Variable_Menu = Menu.build_menu "Variable Options" 
[
("a",   "Add Variables",
       fn (s,vs) =>  (newline (); write_terminal "Enter Variables:\n" ;
    		      (s,enter_variables s vs)
    		     )
),
("d",   "Delete Variables",
       fn (s,vs) =>  (newline (); write_terminal "Enter Variables to Delete:\n" ;
     		      (s,delete_variables vs)
     		     )
)
] 
in
fun variable_options (s,vs) = snd (
    Menu.display_menu_screen 1 Variable_Menu
     (fn (s,vs) => display_variables vs)
       "VARIABLES" "Variables" (s,vs))

end (* of local *)

end (* of functor I_VariableFUN *)
;
  