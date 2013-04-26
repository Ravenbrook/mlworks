(* __newparser.sml the structure *)
(*
$Log: __parser.sml,v $
Revision 1.5  1995/12/14 17:08:34  jont
Reordering requires a bit

Revision 1.4  1993/02/03  17:58:22  matthew
Simplified parameter signature

Revision 1.3  1992/09/02  15:36:28  richard
Installed central error reporting mechanism.

Revision 1.2  1992/08/26  15:34:00  matthew
Small bungle in requires.

Revision 1.1  1992/08/25  16:50:47  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)


require "../lexer/__lexer";
require "__LRparser";
require "../utils/__crash";
require "_parser";

structure Parser_ = NewParser(structure LRparser = LRparser_
                              structure Lexer = Lexer_
                              structure Crash = Crash_)
