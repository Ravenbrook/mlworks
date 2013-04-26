(*
absent redundancy warnings.

Result: WARNING
 
$Log: redundant2.sml,v $
Revision 1.2  1994/06/27 16:57:31  nosa
new test


Copyright (c) 1994 Harlequin Ltd.
*)

    datatype identifier =
      A of int |
      B of int |
      C of int |
      D of int |
      E of int;

fn (1,_,_,_) => 1 
 | (_,E _,E _,E _) => 2 
 | (1,_,E _,E _) => 3 (* redundant *)
 | _ => 4;
