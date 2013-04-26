(* Types for passing to the shell and listener creation functions.
 *
 * Copyright (C) 1993 Harlequin Ltd.
 *
 * $Log: __shell_types.sml,v $
 * Revision 1.10  1995/04/28 10:48:07  daveb
 * Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.9  1995/03/06  18:30:36  daveb
 *  Added InterPrint parameter.
 *  
 *  Revision 1.8  1995/03/01  10:56:49  matthew
 *  Removing ValuePrinter from parameter
 *  
 *  Revision 1.7  1994/08/01  09:02:51  daveb
 *  Added Preferences argument.
 *  
 *  Revision 1.6  1994/06/17  13:34:39  daveb
 *  Added Btree argument.
 *  
 *  Revision 1.5  1993/09/02  14:13:21  daveb
 *  Added Crash parameter.
 *  
 *  Revision 1.4  1993/05/18  15:25:18  jont
 *  Removed integer parameter
 *  
 *  Revision 1.3  1993/05/04  15:13:55  matthew
 *  Added Integer substructure
 *  
 *  Revision 1.2  1993/04/06  16:07:27  jont
 *  Moved user_options and version from interpreter to main
 *  
 *  Revision 1.1  1993/02/26  12:18:59  daveb
 *  Initial revision
 *  
 *
 *)

require "__user_context";
require "../main/__user_options";
require "../main/__preferences";
require "_shell_types";

structure ShellTypes_ = ShellTypes(
  structure UserContext = UserContext_
  structure UserOptions = UserOptions_
  structure Preferences = Preferences_
)
