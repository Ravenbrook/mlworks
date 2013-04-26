(*
 *
 * $Log: Visited.sig,v $
 * Revision 1.2  1998/06/11 13:23:57  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature VISITEDTABLE =
sig

    structure S: SEQUENT

    type visited_table

    exception mark_only_constants

    exception cannot_happen

    val init: visited_table

    val mark_visited: visited_table -> S.sequent -> visited_table

    val is_visited: visited_table -> S.sequent -> bool

    (* Visited sequents are marked as they are encountered.         *)
    (* Before using them, however, an introduction rule must have   *)
    (* been applied. enable is used for activating newly visited    *)
    (* sequents                                                     *)
    val enable: visited_table -> visited_table

end
