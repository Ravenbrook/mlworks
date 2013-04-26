(*
 *
 * $Log: load.sml,v $
 * Revision 1.2  1998/06/08 18:22:45  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     23/07/90
Glasgow University and Rutherford Appleton Laboratory.

load.sml

Functions to load the state of eril, or parts thereof, from files 
saved previously.

*)

functor LoadFUN (structure iS : I_SORT
		 structure iO : I_OPSYMB
		 structure iV : I_VARIABLE
		 structure iE : I_EQUALITY
		 structure iP : I_PRECEDENCE
		 structure Sig : SIGNATURE
		 structure CAC : CAC_THEORY
		 structure Es : EQUALITYSET 
		 structure En : ENVIRONMENT
		 structure iEn : I_ENVIRONMENT
		 structure Ord : ORDERINGS
		 structure State : STATE
		 sharing type Sig.S.Sort = Sig.V.Sort = Sig.O.Sort = 
		              iS.Sort = iO.Sort 
		 and     type Sig.S.Sort_Store = Sig.V.Sort_Store = 
		              iS.Sort_Store = iO.Sort_Store = iV.Sort_Store
		 and     type Sig.O.OpId = iO.OpId
		 and     type Sig.O.Op_Store = iO.Op_Store
		 and     type Sig.V.Variable_Store = iV.Variable_Store
		 and     type Sig.Signature = iE.Signature = En.Signature = CAC.Signature =
		 	      Ord.Signature = State.Signature = iEn.Signature 
		 and     type iE.Term = iO.Term = Es.Term = State.Term
		 and     type Es.Equality = iE.Equality = En.Equality = 
		 	      iEn.Equality = Ord.Equality = CAC.Equality
		 and     type Es.EqualitySet = iE.EqualitySet = State.EqualitySet
		 and     type Ord.Environment = En.Environment = iEn.Environment = State.Environment
		 and     type Ord.ORIENTATION = En.ORIENTATION = iEn.ORIENTATION
		 and     type State.State = iEn.State
	        ) : LOAD =
struct

type State = State.State

open iS iO iV iE iP Sig Es Ord State

fun open_load_file () = 
    (Error.unsetErrorFlag () ;	(* clear any previous error *)
   let val file_name = prompt_reply "Enter Name of File to Read from: "
   in
    if file_name = "" then Error "" else
	OK (open_in file_name)
(* POLY-ML exception *)
	handle Io _ => Error ("Unable to open input file "^file_name)
(* sml-nj exception *)
	     | io_failure => Error ("Unable to open input file "^file_name)
   end)


local 
fun load_all_signature infn (A,T) = 
    let val ll = Lex.lex (infn ())
    in if Lex.end_check2 ll then (A,T) else
    (case hd ll of
       "sorts" => (write_terminal "loading sorts\n";
       		 load_all_signature infn 
                 (change_sorts A (load_sorts infn (get_sorts A)),T)
                 )
     | "sort_ordering" => (write_terminal "loading sort order\n";
       		 load_all_signature infn 
                 (change_sorts A (load_sort_ordering infn (get_sorts A)),T)
                 )
     | "opns" => (write_terminal "loading operations\n";
       		 load_all_signature infn 
                 (apply_pair (change_operators A,I) 
                 (load_operators infn (get_sorts A) T (get_operators A)))
                 )
     | "vars"  => (write_terminal "loading variables\n";
       		 load_all_signature infn 
                 (change_variables A 
                 (load_variables infn (get_sorts A) (get_variables A)),T)
                 )
     |   "#"    => (write_terminal "ignoring comment\n";
       		 load_all_signature infn (A,T)
                  )
    |   _      => (A,T)
     )
     end

fun load_eq_sets infn S =
    let val ll = infn ()
        val A = get_Signature S
        val T = get_Parser S
        val Es = get_Equalities S
        val En = get_Environment S
    in if Lex.end_check1 ll then Es else
       let val (label,rest) = first_chars (strip (explode ll))
           val title = implode (clear_ends rest)
           val d = write_terminal ("Loading Equality Set "^label^"\n")
           val (E,Es') = case get_by_label Es label of 
        	  OK E => (change_name E title ,remove_by_label Es label)
        	| Error _ => (new_equality_set label title, Es)
           val eqns = load_equality_set infn A T (snd (En.get_locstrat En) A) E
       in load_eq_sets infn (change_Equalities
          (K (case new_labES Es' eqns of 
          OK nes => nes | Error m => (
          error_message "Something seriously wrong in the insertion and removal of equality sets";Es))
          )S)
       end
    end

fun load_sig (A,T) = 
    (case open_load_file () of 
	OK is => let val infn = fn () => read_line is
	 	     fun readin () = 
	 	         let val ll = Lex.lex (infn ())
	 	         in if null ll 
	                    then (A,T)
	                    else case hd ll of 
	 	                  "signature" => 
	 	                     let val (A',T') = load_all_signature infn (A,T) ;
	                             in (close_in is; (A',T'))
	                             end 
			         | "#"	 => readin ()
	                         |   _   => (A,T)
	                 end
	         in readin ()
	        end |
        Error "" =>  (A,T) |
        Error m  =>  (error_message m ; load_sig (A,T)))

fun makeTheory A En = 
    let val strat = snd (En.get_locstrat En)
        val d     = write_terminal "Calculating new equational theory"
    in foldl (Es.eqinsert (strat A)) Es.EmptyEqSet (CAC.CAC_Theory A)
    end 

in (* of local *)


fun load_signature S = 
    let val (A',T') = load_sig (get_Signature S , get_Parser S)
        val AC = makeTheory A' (get_Environment S)
    in (if Error.isErrorFlag () then (error_and_wait "Errors during Load - No change to Signature" ; S) else  
        change_EqTheory (change_Parser (change_Signature S A') T') AC)
    end

fun load_equations S = 
	(case open_load_file () of 
	 OK is => let val infn = fn () => read_line is
	 	      val ll = Lex.lex (infn ())
	 	  in if null ll 
	             then S
	             else case hd ll of 
	 	      "eqns" => let val Es' = change_Equalities (load_eq_sets infn) S
	                        in (close_in is; 
	                            if Error.isErrorFlag () 
	                            then (error_and_wait "Errors during Load - No change to Equalities " ; 
	                                  S)  
	                            else Es')
	                        end 
	             |   _   => S
	          end   |
         Error "" =>  S |
         Error m  =>  (error_message m ; load_equations S)) 

fun load_state S = 
    (case open_load_file () of 
	 OK is => let val infn = fn () => read_line is
	              fun ld_state S =
	                  let val ll = Lex.lex (infn ())
	                  in if null ll 
	                     then S
	                     else case hd ll of 
			     "signature" => let val (A',T') = load_all_signature infn (get_Signature S,get_Parser S)
			     		    in ld_state (change_Parser (change_Signature S A') T')
			     		    end 
			    | "env"      => ld_state (change_Environment (iEn.load_environment load_globalord infn) S)
			    | "eqns"     => change_Equalities (load_eq_sets infn) S
			    | "#"	 => ld_state S
			    |   _        => S
			  end 
		      val S' = ld_state S
                  in (close_in is ; 
                     if Error.isErrorFlag () 
                     then (error_and_wait "Errors during Load - No Change to State"; S) 
                     else
       		     change_EqTheory  S' (makeTheory (get_Signature S') (get_Environment S')) ) 
	          end |
         Error "" =>  S |
         Error m  =>  (error_message m ; load_state S)) 

end (* of local *)
 ;
	 	      
local  
val Load_Menu = Menu.build_menu "Load Options" 
[
("a",   "Load Signature",load_signature),
("e",   "Load Equality Sets",load_equations ),
("s",   "Load State",        load_state     ),
("A",   "Load Act One Specification",
        (fn x => (error_message "ACT ONE Interface not yet implemented\n";
            	      wait_on_user () ;
            	      x )))
] 

in
val load_options = Menu.display_menu_screen 2 Load_Menu I "Load Options" "Load"
end 

end (* of functor LoadFUN *)
;

