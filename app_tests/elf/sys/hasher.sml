(*
 *
 * $Log: hasher.sml,v $
 * Revision 1.2  1998/06/03 11:49:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature HASHER = 
sig

  val hashString : string -> int

end  (* signature HASHER *)

functor Hasher () : HASHER =
struct

  val prime = 8388593 (* largest prime less than 2^23 *)
  val base = 128

  fun hashString(str: string) : int =
      let fun loop (0,n) = n
            | loop (i,n) = 
                let val i = i-1
                    val n' = (base * n + ordof(str,i)) 
                 in loop (i, (n' - prime * (n' quot prime)))
                end
       in loop (size str,0) end

end  (* functor Hasher *)
