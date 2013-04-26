(*
$Log: __share.sml,v $
Revision 1.7  1995/02/07 15:28:01  matthew
Removing debug stuff

Revision 1.6  1993/03/17  19:01:28  matthew
Added basistypes structure

Revision 1.5  1992/08/04  12:40:36  davidt
Removed redundant structure argument.

Revision 1.4  1992/03/16  11:15:22  jont
Added require"__debug"

Revision 1.3  1992/01/27  18:16:11  jont
Added ty_debug parameter

Revision 1.2  1991/11/19  19:01:55  jont
Added crash parameter

Revision 1.1  91/06/07  11:22:19  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__lists";
require "../utils/__print";
require "../utils/__crash";
require "../basics/__identprint";
require "../typechecker/__datatypes";
require "../typechecker/__valenv";
require "../typechecker/__strnames";
require "../typechecker/__nameset";
require "../typechecker/__sharetypes";
require "__basistypes";
require "../typechecker/_share";

structure Share_ = Share(
  structure Lists = Lists_
  structure Crash = Crash_
  structure IdentPrint = IdentPrint_
  structure Datatypes = Datatypes_	
  structure Sharetypes = Sharetypes_	
  structure Valenv = Valenv_	
  structure Strnames = Strnames_	
  structure Nameset = Nameset_
  structure Print = Print_
  structure BasisTypes = BasisTypes_
    );
  
