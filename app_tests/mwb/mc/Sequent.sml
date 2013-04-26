(*
 *
 * $Log: Sequent.sml,v $
 * Revision 1.2  1998/06/11 13:20:04  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor Sequent(structure Formula: FORMULA
                structure Condition: CONDITION
                structure DefList: DEF_LIST
                structure Agent: McAGENT
                sharing Formula = DefList.F
                sharing Formula = Condition.F
                sharing Formula.ACT = Agent.ACT) : SEQUENT =
struct

  structure F = Formula
  structure C = Condition
  structure D = DefList
  structure A = Agent

  datatype sequent = mk_sequent of
       C.cond * D.def_list * A.agent * F.formula

  (* Should possibly check that all names free in c are also free in *)
  (* either A or F                                                   *)
  fun new_name (mk_sequent(c,dl,A,F)) =
        F.ACT.N.next ((A.free_names A)@(F.free_names F))

end
