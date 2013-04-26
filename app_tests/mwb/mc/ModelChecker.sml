(*
 *
 * $Log: ModelChecker.sml,v $
 * Revision 1.2  1998/06/11 13:26:48  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*************************************************************************)
(* First implementation on model checker for the polyadic pi-calculus    *)
(* based on Dam-CONCUR'93                                                *)
(*                                                                       *)
(* Remarks:                                                              *)
(*   - Strategy for handling visited sequent as                          *)
(*     in Stirling-Walker: Local Model Checking ...                      *)
(*     That is, only check when sequent has constant as formula          *)
(*   - Also only check when sequent has been normalised (when            *)
(*     ModelCheck2 is being applied                                      *)
(*   - No attempt at recording proved sequents. Should this be done?     *)
(*     Probably needs hashing as well as equality checking               *)
(*   - Later version should build refinement-based prover, then          *)
(*     implement model checker as tactic                                 *)
(*************************************************************************)

functor ModelChecker(structure Sequent: SEQUENT
                     sharing Sequent.F
                               = Sequent.D.F
                     sharing Sequent.F
                               = Sequent.C.F
                     sharing Sequent.F.ACT 
                               = Sequent.A.ACT
                     sharing Sequent.F.ACT.N
                               = Sequent.C.NS.N
                     structure AgentSubSem: AGENTSUBSEM
                     sharing AgentSubSem.NS = Sequent.C.NS
                     sharing AgentSubSem.A = Sequent.A) : MODELCHECKER =
struct

  structure S = Sequent

  structure V = VisitedTable(structure Sequent = S)

  structure AS = AgentSubSem

  open V
  open S

  exception cannot_happen
  exception not_closed_formula

  fun pb true = (if Flags.trace() then print "true\n" else ();true)
    | pb false = (if Flags.trace() then print "false\n" else ();false)

  fun mc2 vt ns d A F e =
      let val A1 = AS.normal_form A ns e
	  val _ = if not (Flags.trace()) then ()
	     else print("*mc2 vt "^(C.NS.mkstr ns)^" d "^(A.mkstr A)^" "^(F.mkstr F)^" e\n"
			^" normal form: "^(A.mkstr A1)^"\n"
			^" restricted ns: "^(C.NS.mkstr(C.NS.restrict ns ((A.free_names A1)@(F.free_names F))))^"\n")
      in mc3 vt (C.NS.restrict ns ((A.free_names A1)@(F.free_names F))) d A1 F e end
  and
      mc3 vt ns d A F e =
        if F.is_true F
        then true else
        if F.is_false F
        then false else
        if F.is_eq F
        then (* #### *)
	    (if Flags.trace() then print ("is_eq("^(F.ACT.N.mkstr (F.eq_left F))^","^(F.ACT.N.mkstr (F.eq_right F))^","^(C.NS.mkstr ns)^")\n") else ();
	    pb (C.NS.is_eq (F.eq_left F) (F.eq_right F) ns)) else
        if F.is_neq F
        then (* #### *)
	    (if Flags.trace() then print ("is_neq("^(F.ACT.N.mkstr (F.eq_left F))^","^(F.ACT.N.mkstr (F.eq_right F))^","^(C.NS.mkstr ns)^")\n") else ();
	    pb (C.NS.is_neq (F.eq_left F) (F.eq_right F) ns)) else
        if F.is_and F
        then
          (mc2 vt ns d A (F.select_left F) e) andalso
          (mc2 vt ns d A (F.select_right F) e) else
        if F.is_or F
        then
          (mc2 vt ns d A (F.select_left F) e) orelse
          (mc2 vt ns d A (F.select_right F) e) else
        if F.is_diamond_unbarred F
        then
          if A.is_process A e
          then McList.for_some
(*                  (fn (F.ACT.mk_act x,A1) =>                   *)
(*                            mc2 vt ns d A1 (F.successor x F) | *)
(*                      (F.ACT.mk_bar x,A1) => false |           *)
(*                      (F.ACT.tau (),A1) => false)              *)
		 (fn (x,A1) =>
		  if F.ACT.is_input x then
		      mc2 vt ns d A1 (F.successor (F.ACT.name x) F) e
		  else false)
                 (AS.commitments ns A e)
          else false else
        if F.is_diamond_barred F
        then
          if A.is_process A e
          then McList.for_some
(*                  (fn (F.ACT.mk_act x,A1) => false |           *)
(*                      (F.ACT.mk_bar x,A1) =>                   *)
(*                            mc2 vt ns d A1 (F.successor x F) | *)
(*                      (F.ACT.tau (),A1) => false)              *)
	         (fn (x,A1) =>
		  if F.ACT.is_output(x) then
		      mc2 vt ns d A1 (F.successor (F.ACT.name x) F) e
		  else false)
                 (AS.commitments ns A e)
          else false else
        if F.is_diamond_tau F
        then
          if A.is_process A e
          then McList.for_some
(*                  (fn (F.ACT.mk_act x,A1) => false |        *)
(*                      (F.ACT.mk_bar x,A1) => false |        *)
(*                      (F.ACT.tau (),A1) =>                  *)
(*                         mc2 vt ns d A1 (F.select_right F)) *)
	         (fn (x,A1) =>
		  if F.ACT.is_tau(x) then
		      mc2 vt ns d A1 (F.select_right F) e
		  else false)
                 (AS.commitments ns A e)
          else false else
        if F.is_box_unbarred F
        then
          if A.is_process A e
          then McList.for_all
(*                  (fn (F.ACT.mk_act x,A1) =>                   *)
(*                            mc2 vt ns d A1 (F.successor x F) | *)
(*                      (F.ACT.mk_bar x,A1) => true |            *)
(*                      (F.ACT.tau (),A1) => true)               *)
	      (fn (x,A1) =>
	       if F.ACT.is_input(x) then
		   mc2 vt ns d A1 (F.successor (F.ACT.name x) F) e
	       else true)
                 (AS.commitments ns A e)
          else false else
        if F.is_box_barred F
        then
          if A.is_process A e
          then McList.for_all
(*                  (fn (F.ACT.mk_act x,A1) => true |            *)
(*                      (F.ACT.mk_bar x,A1) =>                   *)
(*                            mc2 vt ns d A1 (F.successor x F) | *)
(*                      (F.ACT.tau (),A1) => true)               *)
	      (fn (x,A1) =>
	       if F.ACT.is_output(x) then
		   mc2 vt ns d A1 (F.successor (F.ACT.name x) F) e
	       else true)
                 (AS.commitments ns A e)
          else false else
        if F.is_box_tau F
        then
          if A.is_process A e
          then McList.for_all
(*                  (fn (F.ACT.mk_act x,A1) => true |            *)
(*                      (F.ACT.mk_bar x,A1) => true |            *)
(*                      (F.ACT.tau (),A1) =>                     *)
(*                            mc2 vt ns d A1 (F.select_right F)) *)
	      (fn (x,A1) =>
	       if F.ACT.is_tau(x) then
		   mc2 vt ns d A1 (F.select_right F) e
	       else true)
                 (AS.commitments ns A e)
          else false else
        if F.is_rooted_var F
        then raise not_closed_formula else
        if F.is_rooted_gfp F
        then
          let val new_con = D.new d
          in mc3 vt ns
                 (D.assign d new_con (F.unroot F)) A
                 (F.mk_rooted_con new_con (F.params F)) e
          end else
        if F.is_rooted_lfp F
        then
          let val new_con = D.new d
          in mc3 vt ns
                 (D.assign d new_con (F.unroot F)) A
                 (F.mk_rooted_con new_con (F.params F)) e
          end else
        if F.is_rooted_con F
        then
          let val U = 
	      F.constant F		(* /BV *)
(* 	      case F.constants (F.unroot F) of                    *)
(*                               (V::nil) => V |                  *)
(*                                _       => raise cannot_happen; *)
              val nl = F.params F;
              val fp = D.entry d U
          in
            if F.is_GFP fp
            then
              if V.is_visited vt (mk_sequent(C.NameSubst ns,d,A,F))
              then true
              else
                mc3 (enable
                     (mark_visited vt (mk_sequent(C.NameSubst ns,d,A,F))))
                   ns d A (F.unfold U (F.root fp nl)) e
            else
              if V.is_visited vt (mk_sequent(C.NameSubst ns,d,A,F))
              then false
              else
                mc3 (enable
                     (mark_visited vt (mk_sequent(C.NameSubst ns,d,A,F))))
                   ns d A (F.unfold U (F.root fp nl)) e
          end else
        if F.is_sigma F
        then
          if A.is_concretion A e
          then mc2 vt ns d (A.concretion_right A e)
                   (F.successor (A.concretion_left A e) F) e
          else false else
        if F.is_bsigma F
        then
          if A.is_bconcretion A e
          then
            let val ns' = C.NS.restrict ns ((A.free_names A)@(F.free_names F)) (* /BV *)
		val _ = if Flags.trace() then print("*is_bsigma/is_bconcretion "^(A.mkstr A)^"\n") else ()
		val x = new_name (mk_sequent(C.NameSubst ns',d,A,F))
            in
              mc2 vt (C.NS.add_distinct x ns') d
                  (A.bconcretion_right x A e)
                  (F.successor x F) e
            end
          else false else
        if F.is_pi F
        then
          if A.is_abstraction A e
          then
            let val ns' = C.NS.restrict ns ((A.free_names A)@(F.free_names F)) (* /BV *)
		val x = new_name  (mk_sequent(C.NameSubst ns',d,A,F))
            in
              McList.for_all
                (fn ns1 =>
                   mc2 vt ns1 d (A.abstraction_right x A e) (F.successor x F) e)
                (C.NS.add_new x ns')
            end
          else false else
        if F.is_exists F
        then
          if A.is_abstraction A e
          then
            let val ns' = C.NS.restrict ns ((A.free_names A)@(F.free_names F)) (* /BV *)
		val x = new_name  (mk_sequent(C.NameSubst ns',d,A,F))
            in
              McList.for_some
                (fn ns1 =>
                   mc2 vt ns1 d (A.abstraction_right x A e) (F.successor x F) e)
                (C.NS.add_new x ns')
            end
          else false
        else raise cannot_happen

  fun model_checker vt (mk_sequent(c,d,A,F)) e =
      McList.for_all
        (fn ns1 => mc2 vt ns1 d A F e)
        (C.partition ((A.free_names A)@(F.free_names F)) c)

  fun naked_model_checker A F e =
      mc2 V.init 
          (fold (fn (n,ns)=>C.NS.add_distinct n ns) (Lib.del_dups F.ACT.N.eq ((A.free_names A)@(F.free_names F))) C.NS.init)
          D.init A F e

end

