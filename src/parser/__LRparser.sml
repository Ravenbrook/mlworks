(* __LRparser.sml the structure *)
(*
$Log: __LRparser.sml,v $
Revision 1.4  1993/05/18 18:01:36  jont
Removed integer parameter

Revision 1.3  1992/11/06  12:21:55  matthew
Changed Error structure to Info

Revision 1.2  1992/09/02  15:07:01  richard
Installed central error reporting mechanism.

Revision 1.1  1992/08/25  16:58:03  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)

require "../utils/__crash";
require "../utils/__lists";
require "__LRbasics";
require "__actionfunctions";
require "_LRparser";

structure LRparser_ = LRparser(structure LRbasics = LRbasics_
                               structure ActionFunctions = ActionFunctions_
                               structure Lists = Lists_
                               structure Crash = Crash_
                                 );
