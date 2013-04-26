(* _stack_interface the structure *)
(*
$Log: _stack_interface.sml,v $
Revision 1.14  1998/03/23 15:02:47  jont
[Bug #30090]
Remove use of MLWorks.IO

 * Revision 1.13  1997/03/20  15:30:35  stephenb
 * [Bug #1822]
 * Add frame and ml_value types as which have been introduced
 * into the signature <URI:hope://MLWsrc/main/stack_interface.sml>
 * in version 1.4.
 *
 * Revision 1.12  1996/05/17  09:45:11  matthew
 * Moving Bits to Internal
 *
 * Revision 1.11  1996/05/01  12:13:36  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.10  1996/03/20  13:27:59  matthew
 * Changes for value polymorphism
 *
 * Revision 1.9  1996/02/14  10:03:25  stephenb
 * Add frame_code to support the implementation of "n" in the debugger.
 *
 * Revision 1.8  1995/12/18  13:50:39  matthew
 * Tidying up.  Adding new set_frame_return_value.
 *
 * Revision 1.7  1995/10/17  14:04:56  matthew
 * Adding "set_return_value" function
 *
 * for use in tracing.
 *
 * Revision 1.6  1995/06/15  16:34:59  jont
 * Cope with extra stack frame generated in ml_raise
 *
 * Revision 1.5  1995/06/01  08:47:51  matthew
 * Using new runtime stack argument function
 *
 * Revision 1.4  1995/05/22  12:43:35  matthew
 * Commenting out hopeless frame_arg function
 *
 * Revision 1.3  1995/05/01  10:29:31  jont
 * Get require statements right
 *
 * Revision 1.2  1995/04/21  14:29:53  matthew
 * Switching off debugging
 *
 * Revision 1.1  1995/03/20  11:02:57  matthew
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
    val cast : 'a -> 'b = MLWorks.Internal.Value.cast

    (* MIPS specific stuff *)

    val sp_offset = 0
    val closure_offset = 1
    val lr_offset = 2
    val arg_offset = 3
      
    fun next_frame frame : frame = 
      cast (MLWorks.Internal.Value.Frame.sub (frame,sp_offset))

    local
      val env = MLWorks.Internal.Runtime.environment
    in
      val frame_arg : frame -> ml_value =  env "debugger frame argument"

      val set_frame_return_value : frame * ml_value -> unit =
        env "debugger set frame return value"

    end

    (* MIPS version *)

    fun get_basic_frames (bottom,base_frame) =
      let
        val acc = [(bottom,0,is_ml_frame bottom)]
        fun scan (bottom,acc) =
          let
            val (another,next,offset) = MLWorks.Internal.Value.Frame.frame_next bottom
          in
            if another andalso next <> base_frame
              then scan (next,(next,offset,offset <> 0)::acc)
            else
              (if next <> base_frame then debug (fn _ => "No base frame") else ();
                 acc)
          end
      in
        (* omit bottom frame (this is the one above the base frame) *)
        (* This depends on our mechanism for setting up the base frame *)

        case scan (bottom,acc) of
          (_::_::_::rest) => rest
        | (_::_::rest) => rest
        | (_::rest) => rest
        | rest => rest
      end

    fun variable_debug_frame frame = next_frame frame

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

    
