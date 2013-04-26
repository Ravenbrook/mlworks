(*  ==== TOP LEVEL BATCH COMPILER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: batch.sml,v $
 *  Revision 1.6  1999/05/27 10:38:43  johnh
 *  [Bug #190553]
 *  FIx require statements to fix bootstrap compiler.
 *
 * Revision 1.5  1999/05/13  09:43:45  daveb
 * [Bug #190553]
 * Replaced use of basis/exit with utils/mlworks_exit.
 *
 * Revision 1.4  1996/05/08  13:30:54  stephenb
 * Update wrt move of file "main" to basis.
 *
 * Revision 1.3  1996/04/17  14:24:14  stephenb
 * Change obey signature to return a list of Exit.status instead
 * of a raw int status.
 *
 * Revision 1.2  1993/04/28  10:02:03  richard
 * The batch compiler now returns a status code.
 *
 *  Revision 1.1  1992/09/01  12:23:39  richard
 *  Initial revision
 *
 *)

require "../utils/mlworks_exit";

signature BATCH =
  sig
    structure Exit : MLWORKS_EXIT

    val obey : string list -> Exit.status
  end;
