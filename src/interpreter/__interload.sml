(*  ==== INTERPRETER LINK/LOADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __interload.sml,v $
 *  Revision 1.4  1994/06/09 16:00:04  nickh
 *  New runtime directory structure.
 *
 *  Revision 1.3  1994/03/08  17:41:12  jont
 *  Moving module types into separate file
 *
 *  Revision 1.2  1993/01/04  15:22:21  daveb
 *  Added ObjectFile_ parameter.
 *
 *  Revision 1.1  1992/10/09  07:40:40  richard
 *  Initial revision
 *
 *)

require "../main/__code_module";
require "../rts/gen/__objectfile";
require "../utils/__lists";
require "__inter_envtypes";
require "_interload";

structure InterLoad_ =
  InterLoad (
    structure Code_Module = Code_Module_
    structure Inter_EnvTypes = Inter_EnvTypes_
    structure ObjectFile = ObjectFile_
    structure Lists = Lists_
  );
