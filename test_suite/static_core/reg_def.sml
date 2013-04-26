(*

Result: OK
 
$Log: reg_def.sml,v $
Revision 1.1  1994/06/03 13:23:51  jont
new file

Copyright (c) 1993 Harlequin Ltd.
*)

datatype Structure =
  STR of int |
  COPYSTR of Structure

fun compare_sig_env generate_moduler (COPYSTR str, env) =
  compare_sig_env generate_moduler (str, env)
  | compare_sig_env generate_moduler _ =
    raise Match
