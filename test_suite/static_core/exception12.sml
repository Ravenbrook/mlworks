(*
 Pattern matching on exceptions is quite hard;
 textual identity is not the same as constructor equivalence.  

Result:  WARNING

$Log: exception12.sml,v $
Revision 1.1  1994/01/24 16:55:32  nosa
Initial revision

Revision 1.1  1994/01/24  16:55:32  nosa
Initial revision



Copyright (c) 1993 Harlequin Ltd.
*)

exception E of exn;
exception A of exn;
exception B = A;
exception C of exn;
exception D = C;
exception F;

fun f (E(E(E(A(E(E(E(C(E(E(E(B(E(E(E(D(F))))))))))))))))) = 1
|   f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))) = 2(* redundant *)
|   f (E(E(E(C(E(E(E(E(B(E(E(E(E(E(E(B(F))))))))))))))))) = 3
|   f (E(E(E(D(E(E(E(E(A(E(E(E(E(E(E(C(F))))))))))))))))) = 4;

f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))); (* 1 *)
f (E(E(E(B(E(E(E(D(E(E(E(A(E(E(E(C(F))))))))))))))))); (* 1 *)
f (E(E(E(D(E(E(E(E(A(E(E(E(E(E(E(A(F))))))))))))))))); (* 3 *)
f (E(E(E(C(E(E(E(E(B(E(E(E(E(E(E(D(F))))))))))))))))); (* 4 *)
