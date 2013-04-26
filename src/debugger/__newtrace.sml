(*  Tracing utility
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  $Log: __newtrace.sml,v $
 *  Revision 1.5  1996/06/21 08:52:30  stephenb
 *  Replace old utils/lists with basis/list.
 *
 * Revision 1.4  1995/03/08  11:00:38  matthew
 * Adding StackInterface structure
 *
Revision 1.3  1995/02/21  11:01:23  matthew
Added ShellTypes and DebuggerUtilities

Revision 1.2  1994/06/09  15:48:14  nickh
New runtime directory structure.

Revision 1.1  1993/05/07  10:44:55  matthew
Initial revision

 *
 *)

require "../basis/__list";
require "../typechecker/__types";
require "../typechecker/__scheme";
require "../main/__user_options";
require "../rts/gen/__tags";
require "../interpreter/__incremental";
require "../interpreter/__shell_types";
require "__value_printer";
require "../machine/__stack_interface";
require "__debugger_utilities";

require "_newtrace";

structure Trace_ = Trace (structure List = List
                          structure Tags = Tags_
                          structure Types = Types_
                          structure Scheme = Scheme_
                          structure UserOptions = UserOptions_
                          structure Incremental = Incremental_
                          structure ShellTypes = ShellTypes_
                          structure ValuePrinter = ValuePrinter_
                          structure StackInterface = StackInterface_
                          structure DebuggerUtilities = DebuggerUtilities_
                            );
