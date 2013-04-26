(*
 *
 * $Log: Visited.sml,v $
 * Revision 1.2  1998/06/11 13:24:37  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor VisitedTable(structure Sequent: SEQUENT
                              sharing Sequent.D.F = Sequent.F): VISITEDTABLE =
struct

  structure S = Sequent

  type visited_table =
        (S.F.CST.constant * S.C.cond * S.A.agent * 
             (S.F.ACT.N.name list) * bool) list

  exception mark_only_constants

  exception cannot_happen

  val init = nil

  fun mark_visited vt (S.mk_sequent(c,dl,A,F)) =
        if S.F.is_rooted_con F
        then case [S.F.constant F] (*S.F.constants (S.F.unroot F)*) of 
               V::nil => (V,c,A,S.F.params F,false)::vt |
               _      => raise cannot_happen
        else raise mark_only_constants

  fun is_visited vt (S.mk_sequent(c,dl,A,F)) =
        if S.F.is_rooted_con F
        then case [S.F.constant F] (*S.F.constants (S.F.unroot F)*) of
               U::nil => let
                           fun leq (V1,c1,A1,nl1,b1) (V2,c2,A2,nl2,b2) =
                               if S.F.is_GFP (S.D.entry dl U)
                               then
                                   S.F.CST.eq V1 V2 andalso
                                   (if b1 then b2 else true) andalso
                                   S.C.entails c1 c2 andalso
                                   S.A.eq A1 A2 andalso
                                   McList.l_eq S.F.ACT.N.curry_eq nl1 nl2
                               else
                                   S.F.CST.eq V1 V2 andalso
                                   (if b1 then b2 else true) andalso
                                   S.C.entails c2 c1 andalso
                                   S.A.eq A1 A2 andalso
                                   McList.l_eq S.F.ACT.N.curry_eq nl1 nl2
                         in
                           if McList.member leq (U,c,A,S.F.params F,true) vt
                           then true else false
                         end |
               _      => raise cannot_happen
        else false

  fun enable nil = nil |
      enable ((U,c,A,p,b)::vt) = (U,c,A,p,true)::(enable vt)

end
