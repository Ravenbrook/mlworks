(* LINK_SUPPORT the signature *)
(*
 * Functions to support linking of .o files to make .sos or .dlls
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: link_support.sml,v $
 * Revision 1.4  1998/10/26 16:51:28  jont
 * [Bug #70198]
 * Add support for invoking gcc and creating a unqiue stamp for a dll/so
 *
 * Revision 1.3  1998/10/23  15:33:59  jont
 * [Bug #70198]
 * Add ability to make archives (using ar)
 *
 * Revision 1.2  1998/10/21  13:47:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../basis/__word32";

signature LINK_SUPPORT =
  sig
    datatype target_type = DLL | EXE
    datatype linker_type = GNU | LOCAL
    val link :
      {objects : string list, (* Full pathnames *)
       libs : string list, (* Full pathnames *)
       target : string, (* Just a final component, without .exe or anything *)
       target_path : string, (* Where to put the target *)
       dll_or_exe : target_type,
       base : Word32.word, (* Default base address *)
       make_map : bool, (* True if a link map should be produced *)
       linker : linker_type (* Use the default or GNU *)
       } -> unit

    val archive : {archive : string, files : string list} -> unit

    val make_stamp : string -> string

    val gcc : string -> unit

  end
