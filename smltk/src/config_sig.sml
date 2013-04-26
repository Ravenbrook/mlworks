(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 09:58:17 $
  $Revision: 1.1 $
   Purpose of this file: Functions related to "Tk-Configurations"

   *********************************************************************** *)

require "basic_types";

signature CONFIG =
    sig
	val selWidth   : BasicTypes.Widget -> int
	val selHeight  : BasicTypes.Widget -> int
	val selRelief  : BasicTypes.Widget -> BasicTypes.RelKind
	val selText    : BasicTypes.Widget -> string
	val selCommand : BasicTypes.Widget -> BasicTypes.SimpleAction

	val selMWidth   : BasicTypes.MItem -> int
	val selMRelief  : BasicTypes.MItem -> BasicTypes.RelKind
	val selMText    : BasicTypes.MItem -> string
	val selMCommand : BasicTypes.MItem -> BasicTypes.SimpleAction

	val confEq : BasicTypes.Configure -> BasicTypes.Configure -> bool
	val noDblP : BasicTypes.Configure list -> bool

	val add    : BasicTypes.Configure list -> BasicTypes.Configure list -> 
	             BasicTypes.Configure list 
	val new    : BasicTypes.WidgetType -> BasicTypes.Configure list -> 
	             BasicTypes.Configure list -> BasicTypes.Configure list 

	val pack   : BasicTypes.IntPath -> BasicTypes.Configure list -> string
	val packM  : BasicTypes.IntPath -> int list -> 
	             BasicTypes.Configure list -> string

	val readCascPath : string -> int list

	(* ### gehört hier nicht her *)
	val packInfo : BasicTypes.Pack list -> string

	val showIconKind       : BasicTypes.IconKind -> string

	val showTextWidState   : bool -> string

	val winConfEq          : BasicTypes.WinConfigure -> 
	                         BasicTypes.WinConfigure -> bool

	val addWinConf         : BasicTypes.WinConfigure list -> 
	                         BasicTypes.WinConfigure list -> 
				 BasicTypes.WinConfigure list

	val selWinAspect       : BasicTypes.Window -> 
	                         (int * int * int * int) option
	val selWinGeometry     : BasicTypes.Window -> 
	                         (((int * int) option) *
				  ((int * int) option)   ) option

(*	val selWinIcon         : Window -> IconKind option
	val selWinIconMask     : Window -> IconKind option
	val selWinIconName     : Window -> string option
 *) 
	val selWinMaxSize      : BasicTypes.Window -> 
	                         (int * int) option
	val selWinMinSize      : BasicTypes.Window -> 
	                         (int * int) option 
	val selWinPositionFrom : BasicTypes.Window -> 
	                         BasicTypes.UserKind option
	val selWinSizeFrom     : BasicTypes.Window -> 
	                         BasicTypes.UserKind option
	val selWinTitle        : BasicTypes.Window -> 
	                         BasicTypes.Title option
	val selWinGroup        : BasicTypes.Window -> 
	                         BasicTypes.WinId option
	val selWinTransient    : BasicTypes.Window -> 
	                         BasicTypes.WinId option option
	val selWinOverride     : BasicTypes.Window -> 
	                         bool option

	val packWinConf : string -> BasicTypes.WinConfigure -> string



    end
