(*
 * $Log: control_names.sml,v $
 * Revision 1.2  1997/10/28 16:39:31  johnh
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 * 
 * Copyright (C) 1997. The Harlequin Group Limited.  All rights reserved.
 *
 *)

signature CONTROL_NAME = 
  sig
    exception NotFound of string
    val getResID : string -> int
  end