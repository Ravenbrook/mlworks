(*
 *
 * $Log: hash-string.sml,v $
 * Revision 1.2  1998/06/02 15:42:59  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* hash-string.sml
 *
 * COPYRIGHT (c) 1992 by AT&T Bell Laboratories
 *)

structure HashString : sig

    val hashString : string -> int

  end = struct

  (* A function to hash strings with (from the SML/NJ compiler) *)
    local
      val prime = 8388593 (* largest prime less than 2^23 *)
      (* val base = 128 *)
      fun scale i = Bits.lshift(i, 7)  (* multiply by base (128) *)
    in
    fun hashString str = let
        val l = size str
        in
          case l
            of 0 => 0
             | 1 => ord str
             | 2 => ordof(str,0) + scale(ordof(str, 1))
             | 3 => ordof(str,0) + scale((ordof(str, 1) + scale(ordof(str, 2))))
             | _ => let
                fun loop (0,n) = n
                  | loop (i,n) = let
                      val i = i-1
                      val n' = ((scale n) + ordof(str,i)) 
                      in
                        loop (i, (n' - prime * (n' quot prime)))
                      end
                in
                  loop (l,0)
                end
        end
    end (* local *)
          
  end (* HashString *)
