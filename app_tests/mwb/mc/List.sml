(*
 *
 * $Log: List.sml,v $
 * Revision 1.2  1998/06/11 13:21:35  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
structure McList:McLIST =
struct

  fun member eq a nil = false |
      member eq a (b::l) = eq a b orelse member eq a l

  fun l_eq eq nil nil = true |
      l_eq eq (a1::l1) (a2::l2) = eq a1 a2 andalso l_eq eq l1 l2 |
      l_eq eq _ _ = false

  fun l_rm eq a nil = nil |
      l_rm eq a (b::l) =
        if eq a b then l_rm eq a l else b::(l_rm eq a l)

  fun l_rm_and_tell eq a nil = (false,nil) |
      l_rm_and_tell eq a (b::l) =
        if eq a b then (true,l_rm eq a l)
        else let val (was_removed,l1) = l_rm_and_tell eq a l
             in (was_removed,b::l1) end

  fun subset eq nil l = true |
      subset eq (a1::l1) l =
        if member eq a1 l andalso subset eq l1 l then true else false

  fun for_all P nil = true |
      for_all P (a::l) = P a andalso for_all P l

(*   fun for_some P nil = false |                   *)
(*       for_some P (a::l) = P a orelse for_all P l *)
  fun for_some P nil = false |
      for_some P (a::l) = P a orelse for_some P l

  fun flatten nil = nil |
      flatten (l::ll) = l@(flatten ll)

  fun del_dup eq nil = nil |
      del_dup eq (a::l) = a::(del_dup eq (l_rm eq a l))

  fun headers nil = nil |
      headers (nil::l) = headers l |
      headers ((hd::tl)::l) = hd::(headers l)

  fun sort le del_dup =
       let fun sr []  = []
             | sr [a] = [a]
             | sr (h::t) =
               let fun part [] pivot = ([],[],[])
                     | part (h::t) pivot =
                       let val (A,B,C) = part t pivot
                        in if le(h,pivot) then
                              if le(pivot,h) then (A,h::B,C) else (h::A,B,C)
                           else (A,B,h::C)
                       end
                   val (A,B,C) = part t h
                in if del_dup then (sr A)@(h::(sr C)) else (sr A)@(h::B)@(sr C)
               end
        in sr
       end

  fun max le l bot =
        (fn nil => bot |
            (hd::tl) => hd) (sort (fn (x,y) => le y x) false l)

end
