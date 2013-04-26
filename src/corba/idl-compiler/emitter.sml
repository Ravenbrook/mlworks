(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/emitter.sml,v 1.1 1999/03/09 15:01:19 clive Exp $" *)

require "walker";

signature EMITTER = 
  sig
    structure Walker : WALKER
    val generate_signatures : Walker.Absyn.definition list -> string list list
  end

