(*
 *
 * $Log: constraints_datatypes.fun,v $
 * Revision 1.2  1998/06/03 12:17:43  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Constraint data structures *)

functor ConstraintsDataTypes (structure Term : TERM) : CONSTRAINTS_DATATYPES =
struct

structure Term = Term

local open Term
in

  datatype eqterm
     = Rigid of term * (term * term list)
     | Gvar of term * (term * term list)
     | Flex of term * term
     | Abstraction of term
     | Quant of term
     | Any of term

  datatype dpair = Dpair of eqterm * eqterm

  datatype constraint = Con of dpair list

end  (* local ... *)
  
end  (* structure ConstraintsDataTypes *)
