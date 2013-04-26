(*  ==== FI EXAMPLES : RANDOM signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides ML functions to generate random numbers, using
 *  the foreign functions defined in random.c.
 *
 *  Revision Log
 *  ------------
 *  $Log: random.sml,v $
 *  Revision 1.1  1996/08/30 10:58:33  davids
 *  new unit
 *
 *
 *)


signature RANDOM =
  sig

    (* Set the seed for the random number generator. *)

    val setSeed : int -> unit


    (* random (a, b)
     Find a random number between 'a' and 'b'. *)

    val random : int * int -> int


    (* Use the current time to seed the random generator. *)

    val randomize : unit -> unit

  end
