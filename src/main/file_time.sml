(* FILE_TIME signature *)
(*
 *
 * Copyright (C) 1998 Harlequin Group Plc
 *
 * FS independent access to actual time stamp stored with file
 *
 * $Log: file_time.sml,v $
 * Revision 1.2  1998/04/07 17:01:41  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *)

require "^.system.__time";

signature FILE_TIME =
  sig
    val modTime  : string -> Time.time
  end
