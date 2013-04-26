(*  ==== INITIAL BASIS : COMMAND_LINE  ====
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 *  Revision Log
 *  ------------
 *  $Log: __command_line.sml,v $
 *  Revision 1.2  1997/06/30 11:08:48  andreww
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *
 *)

require "command_line";

structure CommandLine : COMMAND_LINE =
  struct
    val name = MLWorks.name
    val arguments = MLWorks.arguments
  end