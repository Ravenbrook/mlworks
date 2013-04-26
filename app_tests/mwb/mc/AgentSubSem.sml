(*
 *
 * $Log: AgentSubSem.sml,v $
 * Revision 1.2  1998/06/11 13:33:52  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor AgentSubSem(structure Agent: McAGENT
                    structure NameSubstitution: NAMESUBSTITUTION
                    structure Boolean: TEST
                    sharing NameSubstitution.B = Boolean
                    sharing Agent.B = Boolean
                    sharing NameSubstitution.N
                             = Agent.ACT.N
                    sharing Agent.ACT.N
                             = Boolean.N): AGENTSUBSEM =
struct

  structure A = Agent

  structure NS = NameSubstitution

  structure B = Boolean

  exception name_substitution_too_small

  exception open_agent_encountered

(*  exception not_yet_implemented *)

  exception normal_form_expected

  exception process_expected

  fun normal_form A ns env =
        if A.is_nil A env
        then A
        else
        if A.is_sum A env
        then A.mk_sum (normal_form (A.sum_left A env) ns env)
                      (normal_form (A.sum_right A env) ns env)
        else
        if A.is_prefix A env
        then A
        else
        if A.is_par A env
        then A.mk_par (normal_form (A.par_left A env) ns env)
                      (normal_form (A.par_right A env) ns env)
        else
        if A.is_conditional A env (* abstract syntax bAB, b a boolean *)
        then
          if McList.subset NS.N.curry_eq (B.domain (A.get_boolean A env)) (NS.domain ns)
          then
            if NS.entails ns (A.get_boolean A env)
            then normal_form (A.cond_positive A env) ns env
            else normal_form (A.cond_negative A env) ns env
          else raise name_substitution_too_small
        else
        if A.is_application A env
        then
          normal_form (A.abstraction_right (*A.mk_application*)
                          (A.appl_arg A env)
                          (normal_form (A.appl_fun A env) ns env) env) ns env
        else
        if A.is_restriction A env
        then
          let val x = NS.N.next (A.free_names A);
	      val _ = if Flags.trace() then print ("*is_restriction "^(A.mkstr A)^"\n") else ()
              val A1 = normal_form (A.restriction_right x A env)
                               (NS.add_distinct x ns) env
          in
            if McList.member NS.N.curry_eq x (A.free_names A1)
            then
              if A.is_process A1 env
              then A.mk_restriction x A1
              else
              if A.is_abstraction A1 env
              then
                let val y = NS.N.next (A.free_names A1);
                    val A2 = A.abstraction_right y A1 env
                in A.mk_abstraction y (A.mk_restriction x A1) end
              else
              if A.is_concretion A1 env
              then
                if NS.N.eq ((A.concretion_left A1 env), x)
                then A.mk_bconcretion x A1
                else A.mk_concretion
                       (A.concretion_left A1 env)
                       (A.mk_restriction x (A.concretion_right A1 env))
              else (* A is bound concretion *)
                let val y = NS.N.next (A.free_names A1);
                    val A2 = A.bconcretion_right y A1 env
                in
                  A.mk_bconcretion y (A.mk_restriction x A2)
                end
            else A1
          end
        else
        if A.is_abstraction A env	(* Moved from before is_application /BV *)
        then A
        else
        if A.is_identifier A env
        then (* raise open_agent_encountered *)
	    normal_form (A.identifier_def A env) ns env
(*        else
        if A.is_recursive_agent A env
        then raise not_yet_implemented
       *)
        else A (* A is a concretion and thus in normal form *)

  fun is_normal_form A e =
        if A.is_nil A e
        then true
        else
        if A.is_sum A e
        then is_normal_form (A.sum_right A e) e
             andalso is_normal_form (A.sum_left A e) e
        else
        if A.is_prefix A e
        then true
        else
        if A.is_par A e
        then is_normal_form (A.par_right A e) e
             andalso is_normal_form (A.par_left A e) e
        else
        if A.is_conditional A e
        then false
        else
        if A.is_application A e
        then false
        else
        if A.is_restriction A e
        then
          A.is_bconcretion A e
          orelse
            let val x = NS.N.next (A.free_names A)
            in is_normal_form (A.restriction_right x A e) e end
        else
        if A.is_identifier A e
        then false
(*         else                        *)
(*         if A.is_recursive_agent A e *)
(*         then false                  *)
        else
        if A.is_concretion A e
        then true
        else A.is_abstraction A e
         

fun commitments ns A e =
      if is_normal_form A e
      then
        if A.is_nil A e
        then nil
        else
        if A.is_sum A e
        then (commitments ns (A.sum_right A e) e)@(commitments ns (A.sum_left A e) e)
        else
        if A.is_prefix A e
        then [(A.prefix_left A e,A.prefix_right A e)]
        else
        if A.is_par A e
        then
          let fun left_goes nil A2 = nil |
                  left_goes ((a,A1)::cl) A2 =
                      (a,A.mk_par A1 A2)::(left_goes cl A2);
              fun right_goes A1 nil = nil |
                  right_goes A1 ((a,A2)::cl) =
                      (a,A.mk_par A1 A2)::(right_goes A1 cl);
              fun match_filter (a,A1) nil ns = nil |
		  match_filter (a,A1) ((b,A2)::cl) ns =
		  if A.ACT.is_input(a) andalso A.ACT.is_output(b) then
		      if NS.is_eq (A.ACT.name a) (A.ACT.name b) ns
			  then (A.ACT.mk_tau(),A.pseudo_appl A1 A2 e)
			      ::(match_filter (a,A1) cl ns)
		      else match_filter (a,A1) cl ns
		  else if A.ACT.is_output(a) andalso A.ACT.is_input(b) then
		      if NS.is_eq (A.ACT.name a) (A.ACT.name b) ns
			  then (A.ACT.mk_tau(),A.pseudo_appl A1 A2 e)
			      ::(match_filter (a,A1) cl ns)
		      else match_filter (a,A1) cl ns
		  else match_filter (a,A1) cl ns
(*                  match_filter (A.ACT.mk_act x,A1)
                               ((A.ACT.mk_bar y,A2)::cl) ns =
                    if NS.is_eq x y ns
                    then (A.ACT.tau (),A.pseudo_appl A1 A2 e)
                            ::(match_filter (A.ACT.mk_act x,A1) cl ns)
                    else match_filter (A.ACT.mk_act x,A1) cl ns |
                  match_filter (A.ACT.mk_bar x,A1)
                               ((A.ACT.mk_act y,A2)::cl) ns =
                    if NS.is_eq x y ns
                    then (A.ACT.tau (),A.pseudo_appl A1 A2 e)
                            ::(match_filter (A.ACT.mk_bar x,A1) cl ns)
                    else match_filter (A.ACT.mk_bar x,A1) cl ns |
                  match_filter (a,A1) (hd::cl) ns = match_filter (a,A1) cl ns;
*)
              fun sync nil cl2 ns = nil |
                  sync ((a,A)::cl1) cl2 ns =
                    (match_filter (a,A) cl2 ns)@(sync cl1 cl2 ns)
          in (left_goes (commitments ns (A.par_left A e) e) (A.par_right A e))
             @ (right_goes (A.par_left A e) (commitments ns (A.par_right A e) e))
             @ (sync (commitments ns (A.par_left A e) e)
                     (commitments ns (A.par_right A e) e) ns)
          end
        else
        if A.is_process A e andalso A.is_restriction A e
        then
          let val x = NS.N.next (A.free_names A);
              val A1 = A.restriction_right x A e;
              val ns1 = NS.private x ns;
              fun filter nil = nil |
		  filter ((a,A2)::cl) =
		  if A.ACT.is_input(a) orelse A.ACT.is_output(a) then
		      if NS.N.eq(A.ACT.name a,x) then filter cl
		      else ((a,A2)::(filter cl))
		  else (* tau *)
		      ((a,A2)::(filter cl))
(*                  filter ((A.ACT.mk_act y,A2)::cl) =
                    if NS.N.eq (x, y)
                    then filter cl
                    else ((A.ACT.mk_act y,A2)::(filter cl)) |
                  filter ((A.ACT.mk_bar y,A2)::cl) =
                    if NS.N.eq (x, y)
                    then filter cl
                    else ((A.ACT.mk_bar y,A2)::(filter cl)) |
                  filter ((A.ACT.tau (),A2)::cl) =
                    ((A.ACT.tau (),A2)::(filter cl))
*)
          in filter (commitments ns1 A1 e) end
        else raise process_expected
      else raise normal_form_expected
        
end
