(*
 Copyright (c) 1993 Harlequin Ltd.
 
 Revision Log
 ------------
 based on Revision 1.29
 $Log: __mach_cg.sml,v $
 Revision 1.7  1998/01/30 09:47:48  johnh
 [Bug #30326]
 Merge in change from branch MLWorks_workspace_97

 * Revision 1.6.10.2  1997/11/20  17:09:04  daveb
 * [Bug #30326]
 *
 * Revision 1.6.10.1  1997/09/11  20:57:58  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.6  1995/03/01  17:18:08  matthew
 * Removed Debugger_Types.Options
 *
Revision 1.5  1994/06/13  09:58:33  nickh
Typo

Revision 1.4  1994/06/09  15:44:57  nickh
New runtime directory structure.

Revision 1.3  1994/03/08  17:33:53  jont
Add code_module to functor parameters

Revision 1.2  1993/11/16  15:49:49  io
Deleted old SPARC comments and fixed type errors

 *)

require "../rts/gen/__tags";
require "../utils/__text";
require "../utils/__print";
require "../utils/__mlworks_timer" ;
require "../utils/__lists";
require "../utils/__crash";
require "../main/__info";
require "../utils/__sexpr";
require "../main/__reals";
require "../main/__options";
require "../basics/__ident";
require "../mir/__mirtables";
require "../mir/__mirregisters";
require "__machspec";
require "../main/__code_module";
require "__mips_schedule";
require "../rts/gen/__implicit";
require "../utils/_diagnostic";
require "_mach_cg";


structure Mach_Cg_ = Mach_Cg(
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
  structure MachSpec = MachSpec_
  structure Code_Module = Code_Module_
  structure Mips_Schedule = Mips_Schedule_
  structure Implicit_Vector = ImplicitVector_
  structure Diagnostic = Diagnostic(structure Text = Text_ )
)


