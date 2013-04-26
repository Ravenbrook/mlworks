(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 09:58:04 $
  $Revision: 1.1 $
   Purpose of this file: Functions related to "Tk-Bindings"

   *********************************************************************** *)

require "basic_types";

signature BIND =
    sig
	val selEvent  : BasicTypes.Binding -> BasicTypes.Event
	val selAction : BasicTypes.Binding -> BasicTypes.Action

	val getActionByName : string-> BasicTypes.Binding list -> 
                              BasicTypes.Action

	val noDblP    : BasicTypes.Binding list -> bool

	val add       : BasicTypes.Binding list -> BasicTypes.Binding list -> 
	                BasicTypes.Binding list
	val delete    : BasicTypes.Binding list -> BasicTypes.Binding list -> 
	                BasicTypes.Event list

	val packWidget   : BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                   BasicTypes.Binding list -> string list
	val packCanvas   : BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                   BasicTypes.CItemId -> BasicTypes.Binding list -> 
			   string list
	val packTag      : BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                   BasicTypes.AnnId   -> BasicTypes.Binding list -> 
			   string list

 	val unpackWidget : BasicTypes.TclPath -> BasicTypes.WidgetType -> 
	                   BasicTypes.Event list -> string list
(* 	val unpackCanvas : TclPath -> CItemId    -> Key list -> string  *)
    end
