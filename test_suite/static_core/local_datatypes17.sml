(* tests that structure sharing isn't broken by local datatypes

Result: OK

$Log: local_datatypes17.sml,v $
Revision 1.1  1996/10/04 18:38:25  andreww
new unit
new test


Copyright (c) 1996 Harlequin Ltd.
*)



signature BIONIC = sig type bionic_arm type bionic_leg end;

functor SixMillionDollarMan(structure Steve: sig structure B: BIONIC end
                            structure Jamie: sig structure B: BIONIC end
                              sharing Steve.B = Jamie.B) =
struct
end;
