(*
 *
 * $Log: i_weights.sml,v $
 * Revision 1.2  1998/06/08 18:03:53  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

This module provides the top level interface for the formal entering and display
of the weights of function symbols.

bmm     23 - 04 - 90

*)

functor I_WeightFUN (structure W : WEIGHTS
		     structure S : SIGNATURE
		     sharing type W.OpId = S.O.OpId
		    ) : I_WEIGHTS =
struct

type Signature = S.Signature
type Weights = W.Weights

open W S.O

local
fun write_weights outfn FS w = (outfn (stringlist (fn (s,s') => s ^ "  =   " ^ s'^"\n") ("","","") 
				       (show_weights (show_operator FS) w)
				      ) )
in
fun save_weights outfn Sigma w = (ignore(write_weights outfn (S.get_operators Sigma) w) ; outfn Lex.end_marker ) 
fun display_weights Sigma = write_weights write_terminal (S.get_operators Sigma) ;
end

local
fun find_fst_symbol FS (s::ss) cand = 
	(case find_operator FS (mk_form cand) of
	  OK f => if s = "="
	          then OK (f,ss) 
	          else find_fst_symbol FS ss (snoc cand s)
	| Error _ => find_fst_symbol FS ss (snoc cand s) )
  | find_fst_symbol _ [] _ = Error ""


fun in_weight infn endfn FS W = 
      	 let val ss = infn ()
    	 in if endfn (strips ss) 
	    then W
	    else let val ssl = Lex.lex_line ss
    	         in  if null ssl 
    	             then in_weight infn endfn FS W 
    	             else
    	            (case find_fst_symbol FS ssl []
    	             of  OK (f,rss)  => 
    	             (case stringtoint (implode rss)
    	               of
    	                OK n => in_weight infn endfn FS (add_weight W f n)
    	              | Error _ => 
		(error_message ("Invalid Weight Declaration - no weight given "^ss) ;
    	        		in_weight infn endfn FS W ))
    	      | Error _     => 
    	      (error_message ("Invalid Weight Declaration - No Operator with form: "^ss) ;
    	                in_weight infn endfn FS W )
    	    )
    	    end
     	 end 

fun delete_weight FS W = 
    let val ss = (prompt1 "Enter Symbol: "; read_line_terminal ())
    in if nl (strips ss)
       then W
       else let val ssl = Lex.lex_line ss
	    in 	(case find_operator FS (mk_form ssl) of
         	     OK f => delete_weight FS (remove_weight W f)
                | Error _ => (error_message ("No Operator with form: "^ss);
		             delete_weight FS W)
	        )
	    end (* of let..in *)
    end (* of let..in *)
in
val delete_weight = delete_weight o S.get_operators 

val enter_weight = in_weight (fn () => (prompt1 "Enter Symbol & Weight: "; read_line_terminal ())) nl
			o S.get_operators
fun load_weight infn = in_weight infn Lex.end_check1 o S.get_operators
end 



local
   fun Weight_Menu FS = Menu.build_menu "Weight Options" 
   [
    ("a",   "Add Weight Declarations", 
            fn W => (newline (); write_terminal "Enter (eg. _ + _ = 1):\n" ;
           		enter_weight FS W)),
    ("d",   "Delete Weight Declarations",
            fn W => (newline (); write_terminal "Enter (f):\n" ;
           		delete_weight FS W))
   ] 

in
   
fun weight_options A = 
    Menu.display_menu_screen 1 (Weight_Menu A) (display_weights A) "WEIGHTS" "Weights"

end (* of local..in *)


end (* of functor I_WeightFUN *)
;
