(* 
 * Command Line structure
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: command_line.sml,v $
 * Revision 1.2  1997/06/30 11:07:55  andreww
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *
 *)

signature COMMAND_LINE =
  sig
    val name: unit -> string
    val arguments: unit -> string list
  end