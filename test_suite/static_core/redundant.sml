(*
We were getting a spurious redundancy warning.

Result: OK
 
$Log: redundant.sml,v $
Revision 1.1  1994/06/17 12:27:43  daveb
new file


Copyright (c) 1994 Harlequin Ltd.
*)

    datatype identifier =
      A of int |
      B of int |
      C of int |
      D of int |
      E of int

    fun compare (A i, A i') = i < i'
    |   compare (A _, _) = true
    |   compare (_, A _) = false
    |   compare (B i, B i') = i < i'
    |   compare (B _, _) = true
    |   compare (_, B _) = false
    |   compare (C i, C i') = i < i'
    |   compare (C _, _) = true
    |   compare (_, C _) = false
    |   compare (D i, D i') = i < i'
    |   compare (D _, _) = true
    |   compare (_, D _) = false
    |   compare (E i, E i') = i < i'

