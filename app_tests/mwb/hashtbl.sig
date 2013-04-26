(*
 *
 * $Log: hashtbl.sig,v $
 * Revision 1.2  1998/06/11 13:37:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature HASHTABLE =
sig
    type ('a , 'b) hashtable

    (* maketable(size,hfun,eqfun,samplekey,sampleval) *)
    val maketable: int * ('_a -> int) * ('_a * '_a -> bool) * '_a * '_b -> ('_a , '_b) hashtable
    val empty : ('a , 'b) hashtable -> bool
    val size : ('a , 'b) hashtable -> int
    (* number of buckets *)
    val bucketcount: ('a , 'b) hashtable -> int
    val entrycount:  ('a , 'b) hashtable -> int
    val hits : ('a , 'b) hashtable -> int

    val get_rehash_threshold : unit -> real
    val set_rehash_threshold : real -> unit

    (* puthash(key,kval,htbl) *)
    val puthash : '_a * '_b * ('_a , '_b) hashtable -> unit
    (* gethash(key,htbl) *)
    val gethash : 'a * ('a , 'b) hashtable -> 'b option
    val maphash : ('a * 'b -> 'c) -> ('a , 'b) hashtable -> 'c list

end
