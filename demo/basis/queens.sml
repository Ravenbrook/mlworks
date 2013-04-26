(*  ==== BASIS EXAMPLES : QUEENS signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module demonstrates the use of the Word structure in the basis
 *  library.  It solves the eight queens problem - the problem of determining
 *  how eight queens may be placed on a chessboard such that no queen attacks
 *  another queen.
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: queens.sml,v $
 *  Revision 1.1  1996/07/26 14:48:54  davids
 *  new unit
 *  New unit.
 *
 *
 *)

signature QUEENS =
  sig

    (* Display all solutions to the eight queens problem. *)

    val eightQueens : unit -> unit


    (* Display all solutions to the n queens problem.  This is a
     generalisation of the eight queens problem, placing n queens on
     a board of size (n x n). *)

    val nQueens : int -> unit

  end
