(*
 *
 * $Log: List.sig,v $
 * Revision 1.2  1998/06/11 13:20:50  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature McLIST =
sig

  val member: ('a -> 'a -> bool) -> 'a -> 'a list -> bool

  val l_eq: ('a -> 'a -> bool) -> ('a list) -> ('a list) -> bool

  val l_rm: ('a -> 'a -> bool) -> 'a -> 'a list -> 'a list

  val l_rm_and_tell: ('a -> 'a -> bool) -> 'a -> 'a list -> bool * 'a list

  val subset: ('a -> 'a -> bool) -> ('a list) -> ('a list) -> bool

  val for_all: ('a -> bool) -> ('a list) -> bool

  val for_some: ('a -> bool) -> ('a list) -> bool

  val flatten: ('a list) list -> 'a list

  val del_dup: ('a -> 'a -> bool) -> ('a list) -> 'a list

  val headers: ('a list) list -> 'a list

  val sort: ('a * 'a -> bool) -> bool -> 'a list -> 'a list

  (* max takes linear ordering, list, and a bottom element *)
  val max: ('a -> 'a -> bool) -> 'a list -> 'a -> 'a

end
