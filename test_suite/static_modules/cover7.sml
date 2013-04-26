(*
Cover

Result: OK

$Log: cover7.sml,v $
Revision 1.1  1993/06/23 10:45:56  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)
signature Empty = sig end 
      and  Real = sig type t end ;

structure A = struct type t = real end ;

functor FUN() = A ;

structure B:Empty = A

structure A = struct end ;

signature T = sig structure C:Real sharing C=B end;

structure S:T =
  struct
    structure C = FUN()
  end
