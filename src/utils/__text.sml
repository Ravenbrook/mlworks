(*  ==== TEXT TYPE ====
 *       STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __text.sml,v $
 *  Revision 1.1  1992/02/11 11:40:12  richard
 *  Initial revision
 *
 *)

require "__lists";
require "_text";

structure Text_ = Text (
  structure Lists = Lists_
)
