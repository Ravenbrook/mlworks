require "btree";

(* Use
    fromList (mkList N , op < : int * int -> bool);
   where N is any number much greater than 0 (e.g. 10000) *)

local
  open MLWorks.Profile
in

(* See the reference manual 3.4.4 for info on the selector *)

val add'_manner =  make_manner 
                     {calls = true, copies = true, depth = 2,
                      space = true, time = true, breakdown = [TOTAL] }

val generic_manner = make_manner
                      {calls = false, copies = false, depth = 2,
                       space = false, time = false, breakdown = [] }

fun is_add' s = size s >= 4 andalso 
                substring (s,0,4) = "add'"

val fromList =
  profile
    (Options
      {scan = 3,
       selector = 
         fn s => if (is_add' s) then add'_manner else generic_manner
      }
     )
    Btree.fromList;

(* Add 100 to each value in the list as 42 is reserved for debugger demo *)

fun mkList 0 = []
|   mkList n = (n + 100) :: mkList (n-1);

end
