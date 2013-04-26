(* FileTime structure *)
(*
 *
 * Copyright (C) 1998 Harlequin Group Plc
 *
 * FS independent access to actual time stamp stored with file
 * Unix version
 *
 * $Log: __file_time.sml,v $
 * Revision 1.2  1998/04/07 17:01:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *)

require "__os";
require "^.main.file_time";

structure FileTime : FILE_TIME =
  struct
    val modTime = OS.FileSys.modTime (* The easy case *)
  end
