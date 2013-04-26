(* UnixLinkSupport the functor *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: _unix_link_support.sml,v $
 * Revision 1.4  1998/10/26 15:59:46  jont
 * [Bug #70198]
 * Add support for invoking gcc and creating a unqiue stamp for a dll/so
 *
 * Revision 1.3  1998/10/23  14:44:54  jont
 * [Bug #70198]
 * Add ability to make archives (using ar)
 *
 * Revision 1.2  1998/10/21  13:47:21  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/crash";
require "../basis/__word32";
require "__os";
require "../main/link_support";

functor UnixLinkSupport (
  structure Crash : CRASH
) : LINK_SUPPORT =
  struct
    datatype target_type = DLL | EXE
    datatype linker_type = GNU | LOCAL
    fun link
      {objects, (* Full pathnames *)
       libs, (* Full pathnames *)
       target, (* Just a final component, without .exe or anything *)
       target_path, (* Where to put the target *)
       dll_or_exe,
       base, (* Default base address *)
       make_map, (* True if a link map should be produced *)
       linker (* Use the default or GNU *)
       } =
      Crash.unimplemented"Unix linker support: link"

    fun archive{archive : string, files : string list} =
      Crash.unimplemented"Unix linker support: archive"

    fun make_stamp _ = Crash.unimplemented"Unix linker support: make_stamp"

    fun gcc _ = Crash.unimplemented"Unix linker support: gcc"
  end
