(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
   Date: $Date: 1999/06/16 10:06:41 $
   Revision: $Revision: 1.1 $
   Purpose of this file: Operations on Widgets Contents

   *********************************************************************** *)

require "basic_types";

signature WIDGET_OPS =
    sig
	val readTextWidState    : BasicTypes.WidId -> bool
	val setTextWidReadOnly  : BasicTypes.WidId -> bool -> unit

	val clearTextWidText    : BasicTypes.WidId -> unit
	val replaceTextWidText  : BasicTypes.WidId -> 
	                          BasicTypes.AnnoText -> unit 

	val selectText          : BasicTypes.WidId -> 
	                          BasicTypes.Mark * BasicTypes.Mark -> 
				  string
	val selectTextAll       : BasicTypes.WidId -> string

	val selectSelRange      : BasicTypes.WidId -> 
	                          (BasicTypes.Mark * BasicTypes.Mark) list 
	val selectSelWindow     : unit  -> 
	                          (BasicTypes.WinId * BasicTypes.WidId) option
	val selectCursor        : BasicTypes.WidId -> BasicTypes.Mark

	val selectVarValue      : string -> string
	val setVarValue         : string -> string        -> unit

	val createAndPopUpMenu : BasicTypes.Widget -> (int option) -> 
	                         BasicTypes.Coord -> unit 

    end
