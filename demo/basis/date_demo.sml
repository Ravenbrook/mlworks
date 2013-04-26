(*  ==== BASIS EXAMPLES : DATE_DEMO signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module defines functions to demonstrate the use of the Date structure
 *  in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: date_demo.sml,v $
 *  Revision 1.1  1996/08/09 16:04:02  davids
 *  new unit
 *
 *
 *)


signature DATE_DEMO =
  sig

    (* Print the date at which a file was last modified. *)

    val fileDate : string -> unit


    (* Print the current date. *)

    val dateNow : unit -> unit

  end
