(*
Ensure pervasive tynames loaded by the encapsulator
are unified with those already available, so that things like
oldDefinition work for real equality

Result: OK
 
$Log: unify_tynames.sml,v $
Revision 1.2  1997/11/26 14:46:47  jont
Automatic checkin:
changed attribute _comment to ' *  '


Copyright (C) 1997, The Harlequin Group PLC, all rights reserved.
*)

val _ = Shell.Options.set(Shell.Options.Language.oldDefinition,true);

local
  open Math
in
  fun check_nan (a : real) =
    if a = a then "WRONG"
    else "OK"
end
