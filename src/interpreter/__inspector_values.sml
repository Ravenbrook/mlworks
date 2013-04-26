(* inspector utilities
 *
 * Copyright (C) 1993 Harlequin Ltd.
 *
 * $Log: __inspector_values.sml,v $
 * Revision 1.6  1995/10/13 23:53:30  brianm
 * Adding ValuePrinter_ dependency ...
 *
Revision 1.5  1994/06/09  15:59:25  nickh
New runtime directory structure.

Revision 1.4  1993/05/18  15:14:12  jont
Removed integer parameter

Revision 1.3  1993/04/20  10:23:38  matthew
Renamed Inspector_Values to InspectorValues

Revision 1.2  1993/04/01  11:02:51  matthew
Removed ValuePrinter structure

Revision 1.1  1993/03/12  15:26:29  matthew
Initial revision

 *)

require "../utils/__lists";
require "../utils/__crash";
require "../typechecker/__types";
require "../typechecker/__valenv";
require "../typechecker/__scheme";
require "../rts/gen/__tags";
require "../debugger/__value_printer";

require "_inspector_values";

structure InspectorValues_ = InspectorValues(
  structure Lists = Lists_
  structure Crash = Crash_
  structure Types = Types_
  structure Valenv = Valenv_
  structure Scheme = Scheme_
  structure Tags = Tags_
  structure ValuePrinter = ValuePrinter_
					     )
