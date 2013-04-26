(* ml_debugger.sml the signature *)
(*
$Log: ml_debugger.sml,v $
Revision 1.65  1997/05/06 09:27:59  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.64  1996/01/08  16:26:10  nickb
 * Change SIGNAL to INTERRUPT (interrupts aren't signals on Windows).
 *
 * Revision 1.63  1995/12/07  15:19:35  jont
 * Add functions to add and remove breakpoints from the table,
 * along with max hit counts
 *
 * Revision 1.62  1995/07/13  10:05:03  matthew
 * Removing Incremental structure
 *
Revision 1.61  1995/06/15  14:45:26  daveb
Hid the details of the WINDOWING type.

Revision 1.60  1995/06/14  12:39:12  daveb
Removed redundant parameters from ml_debugger, added a message_fn
parameter, and removed unnecessary currying.

Revision 1.59  1995/06/02  14:09:41  nickb
Add fatal signals.

Revision 1.58  1995/05/02  15:10:15  matthew
Removing script parameter from ml_debugger

Revision 1.57  1995/04/07  16:01:36  matthew
nothing much

Revision 1.56  1995/02/20  17:26:37  matthew
Changes to pervasive Frame structure

Revision 1.55  1995/01/13  14:52:17  daveb
Replaced Option structure with references to MLWorks.Option.

Revision 1.54  1994/08/01  09:18:14  daveb
Added preferences argument to ml_debugger.

Revision 1.53  1994/06/17  16:55:46  daveb
Replaced context_ref with context.

Revision 1.52  1994/02/23  17:00:02  nosa
Debugger scripts for tracing tool using debugger.

Revision 1.51  1994/02/02  12:21:58  daveb
CHanged substructure of InterMake.

Revision 1.50  1993/12/09  19:27:38  jont
Added copyright message

Revision 1.49  1993/11/23  10:09:56  daveb
Removed with_frame_wrap.  Changed type of with_start_frame so that callers
don't have to provide the frame.

Revision 1.48  1993/10/12  16:20:27  matthew
Merging bug fixes

Revision 1.47.1.2  1993/10/12  12:04:03  matthew
Added STACK_OVERFLOW parameter type

Revision 1.47.1.1  1993/08/06  14:45:51  jont
Fork for bug fixing

Revision 1.47  1993/08/06  14:45:51  nosa
Inspector invocation in debugger-window.

Revision 1.46  1993/08/04  14:57:23  nosa
Changed type of WINDOWING for ShowFrameInfo option in debugger window.

Revision 1.45  1993/07/30  13:43:58  nosa
Changed Option.T to Option.opt.

Revision 1.44  1993/06/11  13:00:46  matthew
Added function debugger continuation

Revision 1.43  1993/05/28  14:27:48  matthew
Added tty_ok option to WINDOWING

Revision 1.42  1993/05/12  15:19:14  matthew
 Added message function to Windowing debugger
Added with_frame_wrap

Revision 1.41  1993/05/10  15:34:07  daveb
Changed argument of ml_debugger from Incremental.options to Options.options.

Revision 1.40  1993/05/07  17:14:11  matthew
Added quit and continue options to windowing debugger.
Added global base frame and debugger_types

Revision 1.39  1993/05/06  12:59:37  matthew
>> Removed printer descriptors.
>> stringify_value now takes just a print_options object
>> .

Revision 1.38  1993/04/30  12:36:02  matthew
Changed type of WINDOWING datatype

Revision 1.37  1993/04/26  12:26:18  matthew
Removes BackTraceType type and the TRACE parameter option

Revision 1.36  1993/04/02  13:52:56  matthew
Removed Debugger_Types

Revision 1.35  1993/03/29  14:30:14  matthew
Removed current_module parameter from ml_debugger

Revision 1.34  1993/03/11  12:20:16  matthew
Signature revisions

Revision 1.33  1993/03/09  15:19:15  matthew
Options & Info changes

Revision 1.32  1993/02/23  15:52:22  matthew
Added BREAK option to parameter type.

Revision 1.31  1993/02/09  10:39:42  matthew
Typechecker structure changes

Revision 1.30  1993/02/04  17:50:18  matthew
Rationalised substructures.

Revision 1.29  1992/12/18  10:07:13  clive
We also pass the current module forward for the source_displayer

Revision 1.28  1992/12/17  11:37:24  clive
Changed debug info to have only module name - needed to pass module table through to window stuff

Revision 1.27  1992/12/15  14:23:21  clive
Allow the backtrace to stop at a particular frame

Revision 1.26  1992/11/27  14:52:28  clive
Debugger now takes a print_descriptor

Revision 1.25  1992/11/20  13:03:53  clive
Allowed messages for the 'c' and 'q' options

Revision 1.24  1992/11/17  11:44:54  matthew
Changed Error structure to Info

Revision 1.23  1992/11/12  14:51:06  clive
Tracing added again

Revision 1.22  1992/10/29  16:09:05  richard
The debugger can now be invoked by a signal or exception.
The MLWorks.Internal.Debugger structure has been removed.

Revision 1.21  1992/10/27  11:04:59  clive
Took out trace and added binding of frame arguments to it

Revision 1.20  1992/10/13  14:40:30  clive
Changes for windowing listener

Revision 1.19  1992/10/06  13:21:08  clive
Tynames now have a slot recording their definition point

Revision 1.18  1992/10/06  13:21:08  clive
Changes for the use of new shell

Revision 1.17  1992/09/10  14:26:50  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.16  1992/09/03  09:09:47  clive
Added functionality to the value_printer

Revision 1.15  1992/08/26  19:02:19  richard
Rationalisation of the MLWorks structure.

Revision 1.14  1992/08/26  18:47:21  jont
Removed some redundant structures and sharing

Revision 1.13  1992/08/26  12:32:00  clive
Fixed a few bugs and added binding of frame arguments to it

Revision 1.12  1992/08/24  16:10:32  clive
Added details about leafness to the debug information

Revision 1.11  1992/08/21  09:22:49  clive
Added a loop inside the debugger

Revision 1.10  1992/08/19  12:24:55  clive
Added untrace

Revision 1.9  1992/08/19  10:46:27  clive
Changed to reflect changes to pervasive_library

Revision 1.8  1992/08/18  16:27:17  richard
 Changed coercion and the ml_value type in the pervasive environment.

Revision 1.7  1992/08/17  10:43:16  clive
Various improvements

Revision 1.6  1992/08/13  13:45:10  clive
Neatening up, plus changes due to lower level sharing changes

Revision 1.5  1992/08/10  11:39:31  clive
New sharing constraints after lower level changes

Revision 1.4  1992/07/30  12:41:37  clive
Working monomorphic version of trace

Revision 1.3  1992/07/16  16:17:22  clive
Made the debugger work better, and changes for the new interface to the runtime system

Revision 1.2  1992/07/13  10:14:28  clive
Support for interpreter

Revision 1.1  1992/06/22  15:20:54  clive
Initial revision

 * Copyright (c) 1993 Harlequin Ltd.
*)

require "../debugger/value_printer";

signature ML_DEBUGGER =
  sig
    structure ValuePrinter : VALUE_PRINTER

    datatype ('a, 'b)union = INL of 'a | INR of 'b
    type preferences

    val size_of_data_cache : int ref

    type debugger_window

    datatype TypeOfDebugger = 
      WINDOWING of debugger_window * (string -> unit) * bool
    | TERMINAL

    datatype parameter =
      INTERRUPT
    | FATAL_SIGNAL of int
    | EXCEPTION of exn
    | BREAK of string
    | STACK_OVERFLOW

(*
    | TRACE of MLWorks.Internal.Value.ml_value * MLWorks.Internal.Value.ml_value
*)

    datatype Continuation =
      POSSIBLE of string * Continuation_action
    | NOT_POSSIBLE
    and Continuation_action =
      NORMAL_RETURN
      | DO_RAISE of exn
      | FUN of (unit -> unit)

    val get_start_frame : unit -> MLWorks.Internal.Value.Frame.frame

    val with_start_frame :
      (MLWorks.Internal.Value.Frame.frame -> 'a) -> 'a

    val with_debugger_type :
      TypeOfDebugger ->
      (MLWorks.Internal.Value.Frame.frame -> 'a) ->
      'a

    val get_debugger_type : unit -> TypeOfDebugger

    val ml_debugger : 
      (TypeOfDebugger * ValuePrinter.Options.options * preferences)
      -> (MLWorks.Internal.Value.Frame.frame * parameter
          * Continuation * Continuation)
      -> unit

(*
    val add_break : int * string -> unit
    val add_break_list : (int * string) list -> unit
    val remove_break : string -> unit
    val break_list : unit -> {name:string,hits:int,max:int} list
*)

  end
