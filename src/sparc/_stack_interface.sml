(* _stack_interface the structure *)
(*
$Log: _stack_interface.sml,v $
Revision 1.12  1998/03/23 15:02:16  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.11  1997/03/20  15:31:02  stephenb
 * [Bug #1822]
 * Add frame and ml_value types as which have been introduced
 * into the signature <URI:hope://MLWsrc/main/stack_interface.sml>
 * in version 1.4.
 *
 * Revision 1.10  1996/05/17  09:54:39  matthew
 * Moved Bits to MLWorks.Internal.Bits
 *
 * Revision 1.9  1996/05/17  09:44:22  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.8  1996/05/01  09:54:01  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1996/03/20  14:33:39  matthew
 * Changes for new language definition
 *
 * Revision 1.6  1996/02/07  15:13:18  stephenb
 * Add frame_code in order to support "next" command in debugger.
 *
 * Revision 1.5  1995/10/17  12:23:48  matthew
 * Adding "set_return_value" function
 *
 * for use in tracing.
 *
 * Revision 1.4  1995/05/01  10:26:25  jont
 * Get require statements right
 *
 * Revision 1.3  1995/04/21  14:30:06  matthew
 * Switching off debugging
 *
 * Revision 1.1  1995/03/20  11:03:36  matthew
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

    val do_debug = false

    fun debug f =
      if do_debug
        then TextIO.output(TextIO.stdErr,"  # " ^ f () ^ "\n")
      else ()

    (* Miscellaneous utilities *)
    (* Maybe these should be elsewhere *)

    val is_ml_frame = MLWorks.Internal.Value.Frame.is_ml_frame
    val cast = MLWorks.Internal.Value.cast


    (* SPARC specific stuff *)
    val sp_offset = 14
    val closure_offset = 9
    val arg_offset = 8

    fun frame_arg frame = MLWorks.Internal.Value.Frame.sub (frame,arg_offset)
    fun set_frame_return_value (frame,value) = MLWorks.Internal.Value.Frame.update (frame,arg_offset,value)

    (* "Generic" frame function *)

    (* SPARC version *)
    fun next_frame frame : frame = 
      cast (MLWorks.Internal.Value.Frame.sub (frame,sp_offset))

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
        (* Skip a frame *)
        val bottom = next_frame bottom
        val acc = [(bottom,0,is_ml_frame bottom)]
      in
        (* omit bottom frame (this is the one above the base frame) *)
        (* This depends on our mechanism for setting up the base frame *)
        case scan (bottom,acc) of
          (_::rest) => rest
        | rest => rest
      end

    fun variable_debug_frame frame = frame

    (* End SPARC specific stuff *)

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

    
