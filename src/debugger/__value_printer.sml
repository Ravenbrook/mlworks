(* __value_printer.sml the structure *)
(*
$Log: __value_printer.sml,v $
Revision 1.12  1996/05/13 11:11:36  matthew
Removing some basis structures

 * Revision 1.11  1996/04/18  15:17:36  jont
 * initbasis moves to basis
 *
 * Revision 1.10  1995/09/15  10:59:02  daveb
 * Added Int32 parameter.
 *
Revision 1.9  1995/09/12  13:57:06  daveb
Added Word and Word32 parameters.

Revision 1.8  1995/03/17  19:43:03  daveb
Removed redundant require.

Revision 1.7  1994/06/09  15:48:36  nickh
New runtime directory structure.

Revision 1.6  1993/12/09  19:27:01  jont
Added copyright message

Revision 1.5  1993/05/18  16:34:32  daveb
Removed the Integer structure.

Revision 1.4  1992/10/06  16:15:39  clive
Changes for the use of new shell

Revision 1.3  1992/08/13  15:45:54  clive
Neatening up, plus changes due to lower level sharing changes

Revision 1.2  1992/07/13  09:48:02  clive
Some minor printing changes

Revision 1.1  1992/06/22  15:20:34  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../rts/gen/__tags";
require "../typechecker/__types";
require "../utils/__lists";
require "../utils/__crash";
require "../typechecker/__valenv";
require "__value_printer_utilities";
require "__debugger_types";
require "_value_printer";

structure ValuePrinter_ = 
  ValuePrinter(structure Types = Types_
               structure Crash = Crash_
               structure Tags = Tags_
               structure Lists = Lists_
               structure Valenv = Valenv_
               structure Debugger_Types = Debugger_Types_
               structure ValuePrinterUtilities = ValuePrinterUtilities_)

