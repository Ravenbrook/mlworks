(*
 *
 * $Log: elf_depend.fun,v $
 * Revision 1.2  1998/06/03 12:28:56  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* Copyright (c) 1991 by Carnegie Mellon University *)
(* Author: Frank Pfenning <fp@cs.cmu.edu>           *)

(* Legal dependencies for Elf *)
(* This should be fixed to at least warn in the case of polymorphism *)

functor ElfDepend (structure Term : TERM) : TYPE_DEPEND =
struct

  structure Term = Term

  (* For now, no dependency is prohibited in Elf *)
  fun known_may_depend _ = true
  val unknown_may_depend = true

end  (* functor ElfDepend *)
