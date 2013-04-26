(* _stack_interface the structure *)
(*
 * $Log: _stack_interface.sml,v $
 * Revision 1.15  1998/03/23 15:01:39  jont
 * [Bug #30090]
 * Remove use of MLWorks.IO
 *
 * Revision 1.14  1997/03/21  10:33:10  stephenb
 * [Bug #1822]
 * Add frame and ml_value types as which have been introduced
 * into the signature <URI:hope://MLWsrc/main/stack_interface.sml>
 * in version 1.4.
 *
 * Revision 1.13  1996/11/14  11:31:50  stephenb
 * [Bug #1767]
 * get_basic_frames: Remove "val bottom = next_frame bottom"
 * so that the top frame is not skipped (it is only on the SPARC
 * that it needs to be skipped).
 *
 * Revision 1.12  1996/05/17  09:47:34  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.11  1996/05/01  12:59:44  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.10  1996/03/20  14:42:14  matthew
 * Changes for new language definition
 *
 * Revision 1.9  1996/02/20  09:18:30  stephenb
 * Make the change that claims to have been made in the previous change!
 *
 * Revision 1.8  1996/02/14  12:46:03  stephenb
 * Add frame_code to support the implementation of "n" in the debugger.
 *
 * Revision 1.7  1995/12/18  13:47:41  matthew
 * Adding call to C set_frame_return_value
 *
 * Revision 1.6  1995/10/17  14:05:26  matthew
 * Adding "set_return_value" function
 *
 * for use in tracing.
 *
 * Revision 1.5  1995/06/14  13:24:14  jont
 * Cope with extra stack frame generated in ml_raise
 *
 * Revision 1.4  1995/06/13  09:58:30  jont
 * Convert to be Intel specific
 * Not complete yet, eg for argument acquisition
 *
 * Revision 1.3  1995/04/27  15:57:10  jont
 * Fix require statements and comments
 *
 * Revision 1.2  1995/04/21  14:30:47  matthew
 * Switching off debugging
 *
 * Revision 1.1  1995/03/20  11:04:33  matthew
 * new unit
 * Machine dependent debugger stuff.
 *
*)

require "^.basis.__text_io";
require "^.rts.gen.tags";
require "^.utils.crash";
require "^.main.stack_interface";

functor StackInterface (structure Tags : TAGS
                        structure Crash : CRASH
                          ) : STACK_INTERFACE =
  struct

    type frame = MLWorks.Internal.Value.Frame.frame

    type ml_value = MLWorks.Internal.Value.ml_value

    structure Bits = MLWorks.Internal.Bits

    (* This has been partially adapted for the 386 stuff *)
    val do_debug = false

    fun debug f =
      if do_debug
        then TextIO.output(TextIO.stdErr,"  # " ^ f () ^ "\n")
      else ()

    (* Miscellaneous utilities *)
    (* Maybe these should be elsewhere *)

    val is_ml_frame = MLWorks.Internal.Value.Frame.is_ml_frame
    val cast = MLWorks.Internal.Value.cast


    (* I386 specific stuff *)
    val sp_offset = 0
    val closure_offset = 1
    val arg_offset = 2 (* Wrong, but not yet determined anyway *)

    local
      val env = MLWorks.Internal.Runtime.environment
    in
      val frame_arg : frame -> ml_value = env "debugger frame argument"

      val set_frame_return_value : frame * ml_value -> unit = 
        env "debugger set frame return value"
        
    end

    (* "Generic" frame function *)

    fun next_frame frame : frame = 
      cast (MLWorks.Internal.Value.Frame.sub (frame,sp_offset))

    (* I386 version *)
    fun get_basic_frames (bottom,base_frame) =
      let
        fun scan (bottom,acc) =
          let
            val (another,next,offset) = MLWorks.Internal.Value.Frame.frame_next bottom
          in
            if another andalso next <> base_frame
              then
                scan (next,(next,offset,offset <> 0)::acc)
            else
              (if next <> base_frame then debug (fn _ => "No base frame") else ();
                 acc)
          end
        val acc = [(bottom,0,is_ml_frame bottom)]
      in
        case scan (bottom,acc) of
          (_::_::_::rest) => rest
        | (_::_::rest) => rest
        | (_::rest) => rest
        | rest => rest
(*        scan (bottom,acc)*)
      end

    fun variable_debug_frame frame = frame

    (* End I386 specific stuff *)

    fun frame_code frame = 
      let
        open MLWorks.Internal.Value
        val closure = Frame.sub (frame, closure_offset)
        val primary = primary closure
        val offset = 
          if primary = Tags.PAIRPTR then 0
          else if primary = Tags.POINTER then 1
          else Crash.impossible "bad primary for frame_name"
      in
        sub (closure, offset)
      end


    fun frame_name frame = MLWorks.Internal.Value.code_name (frame_code frame)


    fun frame_closure frame = MLWorks.Internal.Value.Frame.sub (frame,closure_offset)

    fun is_stack_extension_frame frame = 
      let
        val closure = frame_closure frame
      in
        cast closure = Bits.rshift (Tags.STACK_EXTENSION,2)
      end

  end

    
