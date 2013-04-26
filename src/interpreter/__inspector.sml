(* tty inspector
 *
 * Copyright (C) 1993 Harlequin Ltd.
 *
 * $Log: __inspector.sml,v $
 * Revision 1.5  1995/02/14 14:07:50  matthew
 * Removing Parser structure
 *
Revision 1.4  1993/05/18  18:47:07  jont
Removed integer parameter

Revision 1.3  1993/04/21  16:00:32  matthew
Added parameter structures.  Not all used currently

Revision 1.2  1993/04/20  10:25:05  matthew
 Renames Inspector_Values to InspectorValues

Revision 1.1  1993/03/12  15:25:10  matthew
Initial revision

 *)

require "../utils/__lists";
require "../interpreter/__incremental";
require "../typechecker/__basis";
require "../typechecker/__types";
require "../interpreter/__inspector_values";
require "../main/__user_options";
require "../interpreter/__shell_types";
require "../debugger/__value_printer";

require "_inspector";

structure Inspector_ = Inspector (
                                  structure Lists = Lists_
                                  structure Incremental = Incremental_
                                  structure Basis = Basis_
                                  structure Types = Types_
                                  structure InspectorValues = InspectorValues_
                                  structure UserOptions = UserOptions_
                                  structure ShellTypes = ShellTypes_
                                  structure ValuePrinter = ValuePrinter_
                                    )

