(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/widget_tree_sig.sml,v $
 
   Functions related to Path-Management.
  
   $Date: 1999/06/16 10:06:45 $
   $Revision: 1.1 $
   Author: Stefan Westmeier (Last modification by $Author: johnh $)

   (C) 1996, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "basic_types";

signature WIDGET_TREE =
    sig
	(* *********************************************************************** *)
	(* CHECKING the INTEGRITY of WIDGETS                                       *)
	(* *********************************************************************** *)

	val checkWidId      : string -> bool

	val checkOneWidgetConfigure : BasicTypes.WidgetType -> BasicTypes.Configure -> 
	                              bool
	val checkWidgetConfigure    : BasicTypes.WidgetType -> BasicTypes.Configure list -> 
	                              bool
	val checkOneWidgetBinding   : BasicTypes.WidgetType -> BasicTypes.Event -> 
	                              bool
	val checkWidgetBinding      : BasicTypes.WidgetType -> BasicTypes.Binding list -> 
	                              bool

	val checkOneMConfigure      : BasicTypes.WidgetType -> BasicTypes.Configure -> 
	                              bool
	val checkMItem      : BasicTypes.MItem -> bool


	val checkWidget     : BasicTypes.Widget -> bool

	(* *********************************************************************** *)
	(* SELECTING WIDGETS from the internal GUI state 			   *)
	(* *********************************************************************** *)

	val getWidgetGUI     : BasicTypes.WidId -> BasicTypes.Widget
	val getWidgetGUIPath : BasicTypes.IntPath -> BasicTypes.Widget

	(* *********************************************************************** *)
	(* ADDING WIDGETS to the internal GUI state	 			   *)
	(* *********************************************************************** *)

	val addWidgetPathAssGUI : BasicTypes.WinId -> BasicTypes.WidPath -> 
	                          BasicTypes.Widget -> unit
	val addWidgetsPathAssGUI : BasicTypes.WinId -> BasicTypes.WidPath -> 
	                           BasicTypes.Widget list -> unit

	val addWidgetGUI  : BasicTypes.WinId -> BasicTypes.WidPath -> 
	                    BasicTypes.Widget -> unit
	val addWidgetsGUI : BasicTypes.WinId -> BasicTypes.WidPath -> 
	                    BasicTypes.Widget list -> unit

	(* *********************************************************************** *)
	(* DELETING WIDGETS from the internal GUI state 			   *)
	(* *********************************************************************** *)

	val deleteWidgetGUI     : BasicTypes.WidId -> unit
	val deleteWidgetGUIPath : BasicTypes.IntPath -> unit

	(* *********************************************************************** *)
	(* UPDATING WIDGETS in the internal GUI state		         	   *)
	(* *********************************************************************** *)

	val updWidgetGUI      : BasicTypes.Widget -> unit
	val updWidgetGUIPath  : BasicTypes.IntPath -> BasicTypes.Widget -> unit


	(* *********************************************************************** *)
	(* ADDING WIDGETS to the "real" GUI                                        *)
	(* *********************************************************************** *)

	val packWid0 : bool -> string -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	               BasicTypes.WidId -> BasicTypes.Pack list -> 
		       BasicTypes.Configure list -> string -> 
		       BasicTypes.Binding list -> unit

	val packWid : bool -> string -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	              BasicTypes.WidId -> BasicTypes.Pack list -> 
		      BasicTypes.Configure list -> BasicTypes.Binding list -> unit

	val packTextWid : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                  BasicTypes.WidId -> BasicTypes.ScrollType -> 
			  string -> BasicTypes.Annotation list -> 
			  BasicTypes.Pack list -> BasicTypes.Configure list -> 
			  BasicTypes.Binding list -> unit

	val packListbox : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                  BasicTypes.WidId -> BasicTypes.ScrollType -> 
			  BasicTypes.Pack list -> BasicTypes.Configure list -> 
			  BasicTypes.Binding list -> unit

	val packCanvas : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                 BasicTypes.WidId -> BasicTypes.ScrollType -> 
			 BasicTypes.CItem list -> BasicTypes.Pack list -> 
			 BasicTypes.Configure list -> BasicTypes.Binding list -> 
			 unit

	val packMenu : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	               BasicTypes.WidId -> bool -> BasicTypes.MItem list -> 
		       BasicTypes.Pack list -> BasicTypes.Configure list -> 
		       BasicTypes.Binding list -> unit

	val packWidget  : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                  BasicTypes.Widget -> unit
	val packWidgets : bool -> BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                  BasicTypes.Widget list -> unit

	val packMenuItem  : BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                    BasicTypes.WidId -> BasicTypes.MItem -> int list -> unit
	val packMenuItems : BasicTypes.TclPath -> BasicTypes.IntPath -> 
	                    BasicTypes.WidId -> BasicTypes.MItem list -> 
			    int list -> unit


	(* *********************************************************************** *)
	(* UPDATING WIDGETS in the "real" GUI				           *)
	(* *********************************************************************** *)
(*
	val updConfigurePack  : WidId -> Configure list -> unit
	val updBindingPack    : WidId -> Binding list   -> unit

	val updWidgetPackPath : IntPath -> unit
	val updWidgetPack     : Widget  -> unit
*)
	(* *********************************************************************** *)
	(* EXPORTED FUNCTIONS					         	   *)
	(* *********************************************************************** *)

	val selectWidget     : BasicTypes.WidId -> BasicTypes.Widget
	val selectWidgetPath : BasicTypes.IntPath -> BasicTypes.Widget

	val addWidget        : BasicTypes.WinId -> BasicTypes.WidId -> 
	                       BasicTypes.Widget -> unit
	val deleteWidget     : BasicTypes.WidId -> unit
(*
	val updateWidget     : BasicTypes.Widget -> unit
*)

	(* *********************************************************************** *)
	(* IMPLEMENTATION: WIDGET CONTENTS		 			   *)
	(* *********************************************************************** *)

	val select              : BasicTypes.WidId   -> BasicTypes.Configure list
	val selectCommand       : BasicTypes.WidId   -> BasicTypes.SimpleAction
	val selectCommandPath   : BasicTypes.IntPath -> BasicTypes.SimpleAction
	val selectMCommandMPath : BasicTypes.IntPath -> int list -> BasicTypes.SimpleAction
	val selectMCommand      : BasicTypes.WidId   -> int list -> BasicTypes.SimpleAction
	val selectMCommandPath  : BasicTypes.IntPath -> int list -> BasicTypes.SimpleAction
	val selectBindings      : BasicTypes.WidId   -> BasicTypes.Binding list
	val selectBindKey       : BasicTypes.WidId   -> string -> BasicTypes.Action
	val selectBindKeyPath   : BasicTypes.IntPath -> string -> BasicTypes.Action
	val selectWidth         : BasicTypes.WidId -> int
	val selectHeight        : BasicTypes.WidId -> int
	val selectRelief        : BasicTypes.WidId -> BasicTypes.RelKind


	val configure        : BasicTypes.WidId -> BasicTypes.Configure list -> unit
	val newconfigure     : BasicTypes.WidId -> BasicTypes.Configure list -> unit
	val configureCommand : BasicTypes.WidId -> BasicTypes.SimpleAction   -> unit
	val addBindings      : BasicTypes.WidId -> BasicTypes.Binding list   -> unit
	val newBindings      : BasicTypes.WidId -> BasicTypes.Binding list   -> unit
	val configureWidth   : BasicTypes.WidId -> int                       -> unit
	val configureRelief  : BasicTypes.WidId -> BasicTypes.RelKind        -> unit
	val configureText    : BasicTypes.WidId -> string                    -> unit

	val insertText       : BasicTypes.WidId -> string -> BasicTypes.Mark -> unit
	val insertTextEnd    : BasicTypes.WidId -> string                    -> unit
	val deleteText       : BasicTypes.WidId -> 
	                       BasicTypes.Mark * BasicTypes.Mark             -> unit
	val clearText        : BasicTypes.WidId                              -> unit


	val focus   : BasicTypes.WinId -> unit
	val deFocus : BasicTypes.WinId -> unit

	val grab    : BasicTypes.WinId -> unit
	val deGrab  : BasicTypes.WinId -> unit

	val popUpMenu : BasicTypes.WidId -> (int option) -> 
	                BasicTypes.Coord -> unit

    end
