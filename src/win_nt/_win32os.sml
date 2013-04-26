(* Copyright (C) 1996 Harlequin Ltd.
 *
 * An interface to a misc. collection of features made available
 * on any operating system that claims to be Win32.
 *
 * Revision Log
 * ------------
 *
 *  $Log: _win32os.sml,v $
 *  Revision 1.9  1998/06/05 14:24:54  mitchell
 *  [Bug #30416]
 *  Add support for CREATE_ALWAYS
 *
 *  Revision 1.8  1997/03/27  16:39:47  andreww
 *  [Bug #2004]
 *  add seek_current to seek_direction.
 *
 *  Revision 1.7  1997/01/15  12:24:15  io
 *  [Bug #1892]
 *  rename __word{8,16,32}{array,vector} to __word{8,16,32}_{array,vector}
 *
 *  Revision 1.6  1996/08/21  15:01:26  stephenb
 *  [Bug #1554]
 *  Replaces various uses of int with file_desc type.
 *
 *  Revision 1.5  1996/08/09  10:37:06  daveb
 *  [Bug #1536]
 *  Made read and write use Word8Vector.vectors instead of strings.
 *
 *  Revision 1.4  1996/07/15  15:57:44  andreww
 *  propagating changes made to system calls arising from the code to
 *  dynamically redirect standard IO.
 *
 *  Revision 1.3  1996/07/05  11:15:57  andreww
 *  Altering win32 runtime environment interface.
 *
 *  Revision 1.2  1996/03/20  15:03:48  matthew
 *  Changes for language revision
 *
 *  Revision 1.1  1996/03/01  17:29:10  jont
 *  new unit
 *  Support for revised initial basis
 *
 *
 *)

require "win32os";
require "^.basis.__word8_vector";

functor Win32OS () : WIN32OS =
  struct

    type file_desc = MLWorks.Internal.IO.file_desc

      (* NB, seek_direction will eventually migrate to the pervasive library.
       * There, at the moment, we're relying on the coincidence that
       * FROM_BEGIN->0, FROM_CURRENT->1, FROM_END->2 in the compiler
       * which just happens to be how 0,1 and 2 are interpreted in
       * the runtime. <URI:hope://MLWrts/src/OS/Win32/win32.c#win32_seek>
       *)

    datatype seek_direction = FROM_BEGIN | FROM_CURRENT | FROM_END

    datatype open_method = READ | READ_WRITE | WRITE 

    datatype open_action = CREATE_ALWAYS | OPEN_ALWAYS | OPEN_EXISTING

    val env = MLWorks.Internal.Runtime.environment

    val open_ : string * open_method * open_action -> file_desc = env "system os win32 open"

    (* The casts in the following are ugly but harmless.
     * Could eliminate most of them by moving the
     * Word8Vector.vector definition to MLWorks.
     *)
    val close : file_desc -> unit = MLWorks.Internal.IO.close

    val write : file_desc * Word8Vector.vector * int * int -> int = 
      MLWorks.Internal.Value.cast MLWorks.Internal.IO.write

    val read : file_desc * int -> Word8Vector.vector =
      MLWorks.Internal.Value.cast MLWorks.Internal.IO.read

    val seek : file_desc * int * seek_direction -> int = 
      MLWorks.Internal.Value.cast MLWorks.Internal.IO.seek

    val size : file_desc -> int = env "system os win32 size"

  end
