(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/export.sml,v $
 
   sml_tk Export Signature.  ``All you ever wanted to know about sml_tk''

   Part II: Functions
  
   $Date: 1999/06/16 10:02:08 $
   $Revision: 1.1 $

   Author: bu/cxl (Last modification by $Author: johnh $)

   (C) 1996, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "basic_util";
require "basic_types";
require "com";
require "config";
require "tk_event";
require "paths";
require "coord";
require "c_item";
require "ann_texts";
require "mark";
require "annotation";
require "tk_types";
require "widget_tree";
require "c_item_tree";
require "annotation_tree";
require "tk_windows";
require "eventloop";
require "widget_ops";
require "sys_init";

signature SML_TK =
sig

(* 1. Identifiers *)
    val newWinId             : unit -> TkTypes.WinId
    val newWidgetId          : unit -> TkTypes.WidId
    val newCItemId           : unit -> TkTypes.CItemId
    val newCItemFrameId      : unit -> TkTypes.WidId
    val newAnnotationId      : unit -> TkTypes.AnnId
    val newAnnotationFrameId : unit -> TkTypes.WidId

    (* to generate more meaningful names *)
    val mkWinId     : string -> TkTypes.WinId
    val mkCItemId   : string -> TkTypes.CItemId
    val mkWidgetId  : string -> TkTypes.WidId
(*  val mkFrameId   : string -> TkTypes.WidId
 *)

    (* to generate dependent identifiers *)
    val subWidId    : TkTypes.WidId* string-> TkTypes.WidId


(* 2. Control *)

    val startTcl    : TkTypes.Window list -> unit
    val startTclExn : TkTypes.Window list -> string

    (* same as closing the main window with closeWindow *)
    val exitTcl : unit -> unit

    val resetTcl : unit -> unit


(* 3. Windows *)
    val getWindow     : TkTypes.WinId -> TkTypes.Window
    val getAllWindows : unit  -> TkTypes.Window list

    val openWindow  : TkTypes.Window -> unit
    val closeWindow : TkTypes.WinId -> unit
    val changeTitle : TkTypes.WinId -> TkTypes.Title -> unit
    val occursWin   : TkTypes.WinId -> bool


(* 4. Widgets *)

(* 4.1 General Operations *)

    val occursWidget : TkTypes.WidId-> bool
    val getWidget    : TkTypes.WidId -> TkTypes.Widget

(*                            -- the second argument is a WidPath    *)
    val addWidget : TkTypes.WinId -> TkTypes.WidId -> TkTypes.Widget -> unit 
    val delWidget : TkTypes.WidId -> unit

    val addBind : TkTypes.WidId -> TkTypes.Binding list   -> unit
    val addConf : TkTypes.WidId -> TkTypes.Configure list -> unit

    val setBind : TkTypes.WidId -> TkTypes.Binding list   -> unit 
    val setConf : TkTypes.WidId -> TkTypes.Configure list -> unit


    val getTextWidWidgets : TkTypes.Widget -> TkTypes.Widget list
    val getCanvasWidgets  : TkTypes.Widget -> TkTypes.Widget list

(* 4.2. Configure, Binding, ... for Widgets *)

    (* are all derived from selectWidget *)
    val getConf     : TkTypes.WidId -> TkTypes.Configure list
    val getRelief   : TkTypes.WidId -> TkTypes.RelKind
    val getCommand  : TkTypes.WidId -> TkTypes.SimpleAction
    val getBindings : TkTypes.WidId -> TkTypes.Binding list
    val getWidth    : TkTypes.WidId -> int
    val getHeight   : TkTypes.WidId -> int
    val getMCommand : TkTypes.WidId -> int list -> TkTypes.SimpleAction


(* 4.3 Operations for Widget containing text (TextWid, Listbox, Entry) *)

(* 4.3.2 Manipulation of Text *)

    val insertText    : TkTypes.WidId -> string -> TkTypes.Mark -> unit
    val insertTextEnd : TkTypes.WidId -> string -> unit

    val clearText     : TkTypes.WidId -> unit
    val deleteText    : TkTypes.WidId -> TkTypes.Mark * TkTypes.Mark -> unit

    (* not for Entry *)
    val readText    : TkTypes.WidId -> TkTypes.Mark * TkTypes.Mark -> string
    val readTextAll : TkTypes.WidId -> string

    val readTextWidState   : TkTypes.WidId -> bool
    val setTextWidReadOnly : TkTypes.WidId -> bool -> unit

    val clearTextWidText   : TkTypes.WidId -> unit
    val replaceTextWidText : TkTypes.WidId -> TkTypes.AnnoText-> unit

(* 4.3.3 Selection of postions and ranges *)

    val readCursor   : TkTypes.WidId -> TkTypes.Mark
    val readSelRange : TkTypes.WidId -> (TkTypes.Mark * TkTypes.Mark) list

(* 4.4 Annotated texts" *)
    val mkAT      : string -> TkTypes.AnnoText
    val mtAT      : TkTypes.AnnoText 

    infix 6 ++  
    val ++        : TkTypes.AnnoText * TkTypes.AnnoText -> TkTypes.AnnoText

    val nlAT         : TkTypes.AnnoText -> TkTypes.AnnoText
    val concatATWith : string -> TkTypes.AnnoText list -> TkTypes.AnnoText 

(* 4.5 Annotation *)
    val getAnnotation     : TkTypes.WidId -> TkTypes.AnnId -> TkTypes.Annotation

    val addAnnotation     : TkTypes.WidId -> TkTypes.Annotation -> unit
    val delAnnotation     : TkTypes.WidId -> TkTypes.AnnId    -> unit

    val getAnnotationBind : TkTypes.WidId -> TkTypes.AnnId -> TkTypes.Binding list
    val getAnnotationConf : TkTypes.WidId -> TkTypes.AnnId -> TkTypes.Configure list

    val addAnnotationBind : TkTypes.WidId -> TkTypes.AnnId -> TkTypes.Binding list -> unit
    val addAnnotationConf : TkTypes.WidId -> TkTypes.AnnId -> TkTypes.Configure list -> unit

    val readAnnotationMarks : TkTypes.WidId -> TkTypes.AnnId -> (TkTypes.Mark * TkTypes.Mark) list

    val readSelection     : TkTypes.WidId -> (TkTypes.Mark * TkTypes.Mark) list

(* 4.6 Canvases incl. Canvas Items *)
    val getCItem : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.CItem

    val addCItem : TkTypes.WidId -> TkTypes.CItem   -> unit
    val delCItem : TkTypes.WidId -> TkTypes.CItemId -> unit

    val getCItemBind : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Binding list
    val getCItemConf : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Configure list

    val addCItemBind : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Binding list -> unit
    val addCItemConf : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Configure list -> unit

    val readCItemCoords  : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Coord list
    val readCItemHeight  : TkTypes.WidId -> TkTypes.CItemId -> int
    val readCItemWidth   : TkTypes.WidId -> TkTypes.CItemId -> int

    val moveCItem       : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Coord -> unit
    val setCItemCoords  : TkTypes.WidId -> TkTypes.CItemId -> TkTypes.Coord list -> unit

(* 4.7 Menues *)
    val popUpMenu          : TkTypes.WidId -> int option -> TkTypes.Coord -> unit

(*  val createAndPopUpMenu : TkTypes.Widget-> int option -> TkTypes.Coord -> unit --- still buggy *)


(* 4.8 Buttons and Tcl Vaues *)

    val setVarValue  : string -> string -> unit
    val readVarValue : string -> string

(* 4.9 Coord *)

    val addCoord  : TkTypes.Coord -> TkTypes.Coord -> TkTypes.Coord
    val subCoord  : TkTypes.Coord-> TkTypes.Coord -> TkTypes.Coord
    val smultCoord : TkTypes.Coord-> int-> TkTypes.Coord
   
    type Rect
        
    val inside   : TkTypes.Coord -> Rect -> bool
    val moveRect : Rect -> TkTypes.Coord -> Rect

(* 5. Communication with other applications *)

    val addApp : TkTypes.AppId * TkTypes.program * TkTypes.protocolName 
               * TkTypes.CallBack * TkTypes.QuitAction -> unit 

    val removeApp : TkTypes.AppId -> unit

    val getApp : TkTypes.AppId -> TkTypes.App

    val getLineApp : TkTypes.AppId -> string
    val getLineMApp : TkTypes.AppId -> string
    val putLineApp : TkTypes.AppId -> string -> unit

(* 6. Misc *)

(* 6.1. Checks *)

(*  val check       : TkTypes.Window -> bool *)
(*  val checkMItem  : TkTypes.MItem -> bool  *)
    val checkWidId  : TkTypes.WidId -> bool
(*  val checkWidget : TkTypes.Widget -> bool *)

(*  val checkWin : TkTypes.Window -> bool    *)
    val checkWinId : TkTypes.WinId -> bool
    val checkWinTitle : TkTypes.Title -> bool

(* 6.2. Focus and Grabs *)

    val focus   : TkTypes.WinId -> unit
    val deFocus : TkTypes.WinId -> unit
    val grab    : TkTypes.WinId -> unit
    val deGrab  : TkTypes.WinId -> unit

(* 6.3. Selection *)

    val readSelWindow : unit -> (TkTypes.WinId * TkTypes.WidId) option

(* 6.4. GUI state ... *)

    val initSmlTk  : unit -> unit

    val getSrcPath : unit -> string

end

structure SmlTk : SML_TK =
    struct
	open BasicUtil
	open Com
	open Coord 
	open CItem
	open CItemTree
	open Annotation
	open AnnotationTree
	open Paths
	open Config
	open TkEvent
	open AnnotatedText
	open WidgetTree
	open Window
	open Eventloop
	open WidgetOps

	val getSrcPath = BasicTypes.getSrcPath

	val occursWin     = occursWindowGUI;

	val changeTitle   = Window.changeTitle;
	val checkWin      = Window.check;
	val checkWinId    = Window.checkWinId;
	val checkWinTitle = Window.checkTitle;
	val openWindow    = Window.openW
	val closeWindow   = Window.close

	val getWindow     = BasicTypes.getWindowGUI
	val getAllWindows = BasicTypes.getWindowsGUI

	val addCoord  = Coord.add
	val subCoord  = Coord.sub
	val smultCoord = Coord.smult
	val showCoord = Coord.show
	val convCoord = Coord.read

	val showMark  = Mark.show
	val showMarkL = Mark.showL

	val occursWidget = Paths.occursWidgetGUI
	val delWidget   = WidgetTree.deleteWidget
	val addConf     = WidgetTree.configure
	val addBind     = WidgetTree.addBindings
	val setBind     = WidgetTree.newBindings
	val setConf     = WidgetTree.newconfigure

	val getWidget   = selectWidget
	val getConf     = select
	val getRelief   = selectRelief
	val getCommand  = selectCommand
	val getWidth    = selectWidth
	val getHeight   = selectHeight
	val getBindings = selectBindings
	val getMCommand = selectMCommand

	val addCItem = CItemTree.add
	val delCItem = CItemTree.delete

	val addCItemBind = CItemTree.addBinding
        val addCItemConf = CItemTree.addConfigure

	val getCItem  = CItemTree.get

	val getCItemBind = CItemTree.getBinding
	val getCItemConf = CItemTree.getConfigure
	    
	val moveCItem = CItemTree.move
	val setCItemCoords = CItemTree.setCoords

	val updCItem = CItemTree.upd

	val mkAT = mk
	val nlAT = nl

	val getAnnotation = AnnotationTree.get
	val updAnnotation = AnnotationTree.upd
	val addAnnotation = AnnotationTree.add
	val delAnnotation = AnnotationTree.delete

	val getAnnotationBind = AnnotationTree.getBinding
	val getAnnotationConf = AnnotationTree.getConfigure
	val addAnnotationBind = AnnotationTree.addBinding
	val addAnnotationConf = AnnotationTree.addConfigure

	val readAnnotationMarks = AnnotationTree.readMarks


	val readSelWindow = selectSelWindow
	val readVarValue  = selectVarValue
	val readText      = selectText
        val readTextAll   = selectTextAll

        val readCursor    = WidgetOps.selectCursor
        val readSelRange  = WidgetOps.selectSelRange

	val readCItemCoords = CItemTree.getCoords 
        val readCItemHeight = CItemTree.getHeight
        val readCItemWidth  = CItemTree.getWidth

	val readIconHeight  = getIconHeight
	val readIconWidth   = getIconWidth

	val newCItemId           = CItem.newId
        val newCItemFrameId      = newFrId
	val newAnnotationId      = Annotation.newId
	val newAnnotationFrameId = Annotation.newFrId
        val newWinId             = newWidgetId  (* dodgy *)

	(* these also have to check their arguments for non-alphanumerical
	 * characters etc. *)
	fun mkWinId str     = str ^ newWinId()
        fun mkFrameId str   = str ^ newFrId()
	fun mkCItemId str   = str ^ CItem.newId()
        fun mkWidgetId str  = str ^ newWidgetId()

	fun subWidId(w, str)= w ^ str

	val initSmlTk = SysInit.initSmlTk

    end


