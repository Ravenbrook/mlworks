(* __pervasives.sml the structure *)
(*
$Log: __pervasives.sml,v $
Revision 1.9  1994/09/09 17:35:21  jont
_pervasives.sml moved back into main

Revision 1.8  1994/01/17  18:50:09  daveb
Moved _pervasives to machine dependent directory.

Revision 1.7  1993/05/18  16:59:49  jont
Removed integer parameter

Revision 1.6  1992/08/07  16:16:36  davidt
String structure is now pervasive.

Revision 1.5  1992/05/15  16:52:46  clive
Tried to neaten

Revision 1.4  1992/03/03  11:48:17  richard
Added BTree_ to parameters.

Revision 1.3  1992/02/11  13:17:18  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.2  1991/11/28  14:02:45  richard
Added several new modules.  See functor.

Revision 1.1  91/08/23  10:56:16  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "../utils/__text";
require "../utils/__btree";
require "../basics/__ident";
require "../utils/_diagnostic";
require "_pervasives";

structure Pervasives_ = Pervasives(
  structure Lists = Lists_
  structure Map = BTree_
  structure Crash = Crash_
  structure Ident = Ident_
  structure Diagnostic = Diagnostic ( structure Text = Text_ )
)
