(*  ==== SMALL INTEGER SETS ====
 *           STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __smallintset.sml,v $
 *  Revision 1.5  1996/11/06 10:53:49  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 * Revision 1.4  1996/04/29  15:09:06  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.3  1993/05/18  14:59:19  jont
 * Revision integer parameter
 *
 *  Revision 1.2  1992/06/09  09:36:47  richard
 *  Removed Bit and Array parameters.
 *
 *)


require "../basis/__int";

require "__text";
require "__crash";
require "__lists";
require "_smallintset";


structure SmallIntSet_ = 
  SmallIntSet (structure Text = Text_
               structure Crash = Crash_
               structure Lists = Lists_
               val width = 16
               val lg_width = 4
               fun int_to_text int =
                 Text.from_string (Int.toString int))
