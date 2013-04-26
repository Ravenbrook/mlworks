(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 10:02:06 $
  $Revision: 1.1 $
   Purpose of this file: Event Handler

   *********************************************************************** *)

require "basic_types";

signature EVENTLOOP =
    sig

	val event_on : bool ref

(*	val getTclValue : string -> string
 *)

	val startTcl    : BasicTypes.Window list -> unit
	val startTclExn : BasicTypes.Window list -> string
    end
