(*
 *
 * $Log: PropVar.sml,v $
 * Revision 1.2  1998/06/11 13:22:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor PropVar(Agent: McAGENT):PROPVAR =
struct

  structure A = Agent

  datatype propvar = mk_propvar of int

  fun mkstr (mk_propvar n) = "P"^(makestring n)

  fun eq (mk_propvar n) (mk_propvar m) = n=m

  fun next l =
        mk_propvar((McList.max (fn x => fn y => x<=y)
             (map (fn (mk_propvar n) => n) l) 0) + 1)

end; (* PropVar *)

