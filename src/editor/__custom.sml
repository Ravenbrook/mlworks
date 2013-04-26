(*  === CUSTOM Editor interface ===
 *
 *  $Log: __custom.sml,v $
 *  Revision 1.1  1996/06/11 17:23:24  brianm
 *  new unit
 *  New file.
 *
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *)

require "$.utils.__lists";

require "custom";
require "_custom";


structure CustomEditor_ : CUSTOM_EDITOR =
CustomEditor(
   structure Lists = Lists_
);
