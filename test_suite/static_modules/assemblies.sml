(*
Check builtin datatypes can be rebound
Result: OK
 
$Log: assemblies.sml,v $
Revision 1.2  1996/06/04 16:37:40  jont
Ensure this runs under the old definition

 * Revision 1.1  1995/08/18  11:30:54  jont
 * new unit
 *

Copyright (c) 1995 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition, true);
datatype bool = true | false
datatype 'a list = nil | op :: of 'a * 'a list
