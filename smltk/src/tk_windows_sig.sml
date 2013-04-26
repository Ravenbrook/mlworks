(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 10:06:38 $
  $Revision: 1.1 $
   Purpose of this file: Abstract data Type Window

   *********************************************************************** *)

require "basic_types";

signature WINDOW =
    sig
	val check      : BasicTypes.Window -> bool

	val checkWinId : BasicTypes.WinId  -> bool
	val checkTitle : BasicTypes.Title  -> bool

(*
	val appendGUI    : Window -> unit
	val addGUI       : Window -> unit
	val deleteGUI    : WinId -> unit	
	val deleteAllGUI : unit -> unit
*)

	val changeTitle : BasicTypes.WinId -> BasicTypes.Title -> unit
	val openW       : BasicTypes.Window -> unit
	val close       : BasicTypes.WinId -> unit

    end
