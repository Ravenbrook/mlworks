(*
$Log: __lexrules.sml,v $
Revision 1.8  1993/05/18 16:17:15  jont
Removed integer parameter

Revision 1.7  1993/03/26  11:54:36  daveb
Added InBuffer parameter.

Revision 1.6  1993/03/18  17:09:31  daveb
Added Options parameter.

Revision 1.5  1992/11/05  15:32:46  matthew
Changed Error structure to Info

Revision 1.4  1992/08/28  16:14:57  richard
Changed LexBasics error handler for proper global error
handler.

Revision 1.3  1992/08/18  13:28:06  davidt
This file is now back in use again!

Revision 1.2  1992/08/14  21:14:15  davidt
NO LONGER IN USE! Commented out code to cause a parser
error if this file is ever used.

Revision 1.1  1991/09/06  16:47:14  nickh
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "__regexp";
require "__inbuffer";
require "_lexrules";
require "../utils/__crash";
require "../utils/__lists";
require "../basics/__token";
require "../main/__options";
require "../main/__info";

structure LexRules_ =
  MLRules (structure Crash = Crash_
	   structure Lists = Lists_
	   structure Token = Token_
	   structure RegExp = RegExp_
	   structure InBuffer = InBuffer_
	   structure Options = Options_
           structure Info = Info_);
