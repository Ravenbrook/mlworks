(* stack_interface the signature *)
(*
$Log: stack_interface.sml,v $
Revision 1.4  1997/03/21 09:57:55  stephenb
[Bug #1822]
variable_debug_frame: add a comment explaining what it does!
Also introduce some types so that the signatures are much shorter.

 * Revision 1.3  1996/02/07  15:07:12  stephenb
 * Add frame_code in order to support "next" command in debugger.
 *
# Revision 1.2  1995/10/17  12:22:55  matthew
# Adding "set_return_value" function
#
# for use in tracing.
#
# Revision 1.1  1995/03/20  11:05:55  matthew
# new unit
# Machine dependent debugger stuff.
#
*)

signature STACK_INTERFACE =
  sig

    type frame = MLWorks.Internal.Value.Frame.frame

    type ml_value = MLWorks.Internal.Value.ml_value


    val variable_debug_frame : frame -> frame
    (*
     * For a given frame that logically contains some debug info.,
     * returns the frame that physically contains the info.
     *
     * This is here to abstract over the differences regarding
     * which closures are stored in which stack frames on the 
     * different architectures.
     *)


    val frame_code : frame -> ml_value

    val frame_name : frame -> string
    val frame_closure : frame -> ml_value
    val frame_arg : frame -> ml_value
    val set_frame_return_value : frame * ml_value -> unit
    val is_stack_extension_frame : frame -> bool

    val get_basic_frames : frame * frame -> (frame * int * bool) list
  end
