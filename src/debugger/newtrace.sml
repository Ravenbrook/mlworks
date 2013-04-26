(*  Tracing utility
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  $Log: newtrace.sml,v $
 *  Revision 1.14  1997/05/01 12:28:30  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 * Revision 1.13  1996/02/19  10:14:21  stephenb
 * In the process of adding the "next" command to the tracing module, one
 * name change was made: step_status -> stepping.
 *
 * Revision 1.12  1995/12/07  17:45:16  jont
 * Add more structure to the breakpoint table to allow
 * multiple skipping of breakpoints, and breakpoint hit counting
 *
 * Revision 1.11  1995/10/26  10:29:55  matthew
 * Adding untrace_all
 *
Revision 1.10  1995/10/24  12:51:33  daveb
Removed get_stepping (it duplicated step_state).

Revision 1.9  1995/10/17  13:55:57  matthew
Simplifying trace interface

Revision 1.8  1995/10/03  15:35:13  daveb
Added get_stepping.

Revision 1.7  1995/05/31  15:30:56  matthew
Adding trace_always.

Revision 1.6  1995/04/18  11:04:03  matthew
New step and breakpoint functionality

Revision 1.5  1995/02/23  16:26:04  matthew
Added simple trace functions

Revision 1.4  1993/12/09  16:38:51  matthew
Added function replacement function

Revision 1.3  1993/08/19  11:35:14  matthew
Added message function parameter

Revision 1.2  1993/06/02  14:05:25  matthew
Added untrace function

Revision 1.1  1993/05/07  10:46:10  matthew
Initial revision

 *
 *)

signature TRACE =
  sig
    type Type
    type Context
    type UserOptions

    val trace_full_internal :
      bool ->
      ((MLWorks.Internal.Value.T * Type) *
       (MLWorks.Internal.Value.T * Type)) ->
      MLWorks.Internal.Value.T -> unit

    val trace_full :
      string *
      (MLWorks.Internal.Value.T * Type) *
      (MLWorks.Internal.Value.T * Type) ->
      unit
      
    (* New stuff *)
    val trace : string -> unit
    val break : {name:string,hits:int,max:int} -> unit
    val trace_list : string list -> unit
    val break_list : {name:string,hits:int,max:int} list -> unit
    val untrace : string -> unit
    val unbreak : string -> unit
    val breakpoints : unit -> {name:string,hits:int,max:int} list
    val traces : unit -> string list
    val is_a_break : string -> {name:string,hits:int,max:int} option
    val update_break : {name:string,hits:int,max:int} -> unit

    val untrace_all : unit -> unit
    val unbreak_all : unit -> unit

    val set_stepping:   bool -> unit
    val stepping:       unit -> bool
    val set_step_count: int -> unit
    val step_through:   ('a -> 'b) -> 'a -> 'b

    val set_trace_all : bool -> unit
    val next : MLWorks.Internal.Value.Frame.frame -> unit

    (* gets the entire debug string for the function (name+location) *)
    val get_function_string : ('a -> 'b) -> string
    (* Just gets the name of the function *)
    val get_function_name : ('a -> 'b) -> string
  end

