(* __mach_cg.sml the structure *)
(*
$Log: __mach_cg.sml,v $
Revision 1.5  1998/01/30 09:38:26  johnh
[Bug #30326]
Merge in change from MLWorks_workspace_97 branch.

 * Revision 1.4.10.2  1997/11/20  17:08:42  daveb
 * [Bug #30326]
 * Renamed utils/*timer to utils/*mlworks_timer.
 *
 * Revision 1.4.10.1  1997/09/11  20:54:08  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.4  1995/03/02  11:04:39  matthew
 * Adding Options structure
 *
Revision 1.3  1994/09/28  11:30:55  jont
Add structure MirPrint (temporary)

Revision 1.2  1994/09/15  16:52:16  jont
Get location of generated files right

Revision 1.1  1994/09/01  10:52:44  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)

require "../rts/gen/__tags";
require "../utils/__text";
require "../utils/__print";
require "../utils/__mlworks_timer" ;
require "../utils/__lists";
require "../utils/__crash";
require "../main/__info";
require "../main/__options";
require "../utils/__sexpr";
require "../main/__reals";
require "../main/__code_module";
require "../basics/__ident";
require "../mir/__mirtables";
require "../mir/__mirregisters";
require "../mir/__mirprint";
require "__machspec";
require "__i386_schedule";
require "../rts/gen/__implicit";
require "../utils/_diagnostic";
require "_i386_cg";


structure Mach_Cg_ = I386_Cg(
  structure Tags = Tags_
  structure Print = Print_
  structure Timer = Timer_
  structure Lists = Lists_
  structure Crash = Crash_
  structure Info = Info_
  structure Sexpr = Sexpr_
  structure Reals = Reals_
  structure Ident = Ident_
  structure Options = Options_
  structure MirTables = MirTables_
  structure MirRegisters = MirRegisters_
  structure MirPrint = MirPrint_
  structure MachSpec = MachSpec_
  structure Code_Module = Code_Module_
  structure I386_Schedule = I386_Schedule_
  structure Implicit_Vector = ImplicitVector_
  structure Diagnostic = Diagnostic(structure Text = Text_ )
)
