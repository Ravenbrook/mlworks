(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 10:06:40 $
  $Revision: 1.1 $
   Purpose of this file: Operations on Widgets Contents

   *********************************************************************** *)

require "__int";

require "basic_util";
require "basic_types";
require "com";
require "config";
require "paths";
require "ann_texts";
require "mark";
require "annotation";
require "widget_tree";
require "annotation_tree";
require "tk_windows";
require "widget_ops_sig";

structure WidgetOps : WIDGET_OPS = 
struct

open BasicTypes BasicUtil 

fun readTextWidState wid =
    let 
	val widg = WidgetTree.getWidgetGUI wid
	val tp   = (Paths.getTclPathGUI o Paths.getIntPathGUI) wid

    in
	if ( (selWidgetWidgetType widg) = Tex ) then
	    case Com.readTclVal (tp ^ ".txt cget -state") of
		"normal"   => false (* TextWidStateNormal *)
	      | "disabled" => true  (* TextWidStateDisabled *)
	      | "" => false
	else
	    raise WIDGET "WidgetOps.readTextWidState: applied to non-TextWidget"
    end

fun setTextWidReadOnly wid st =
    let 
	val widg = WidgetTree.getWidgetGUI wid
	val tp   = (Paths.getTclPathGUI o Paths.getIntPathGUI) wid
    in
	if ( (selWidgetWidgetType widg) = Tex ) then
	    Com.putTclCmd (tp ^ ".txt configure -state " ^ (Config.showTextWidState st))
	else
	    raise WIDGET "WidgetOps.setTextWidState: applied to non-TextWidget"
    end
    

fun clearTextWidText wid =
    let
	val widg  = WidgetTree.getWidgetGUI wid
	val anl   = AnnotatedText.selAnno (Annotation.selTextWidAnnoText widg)
	val oldSt = readTextWidState wid
    in
	(setTextWidReadOnly wid false;
	 app (fn an => AnnotationTree.delete wid (Annotation.selAnnotationId an)) anl;
	 WidgetTree.clearText wid;
	 setTextWidReadOnly wid oldSt)
    end

fun replaceTextWidText wid ats =
    let
	val oldSt = readTextWidState wid
    in
	(clearTextWidText wid;
	 setTextWidReadOnly wid false;
	 WidgetTree.insertTextEnd wid (AnnotatedText.selText ats);
	 app (fn an => AnnotationTree.add wid an) (AnnotatedText.selAnno ats);
	 setTextWidReadOnly wid oldSt)
    end


(* selectText has to look for the actual text in case of an 
   Entry- TextWid or Listbox widget *)
fun selectText wid (m1,m2) = 
    let 
	val gvf = Com.readTclVal
	val ip =  Paths.getIntPathGUI wid;
        val w  =  WidgetTree.getWidgetGUIPath ip
    in 
	case w of
	    Entry(_,_,_,_)   => 
		gvf((Paths.getTclPathGUI ip) ^ " get")
	  (* Absolute Notloesung. Unklar wie man Selektionen findet !!! *)
	  | TextWid _ => 
		(Com.putLine (Com.writeMToTcl^" ["^(Paths.getTclPathGUI ip) ^ 
			      ".txt get "^(Mark.show m1)^ " " ^
			      (Mark.show m2)^"]") ;
		 Com.getLineM())
	  | Listbox _ => 
		let 
		    val (mt1,_)=StringUtil.breakAtDot (Mark.show m1)
		    val (mt2,_)=StringUtil.breakAtDot (Mark.show m2)
		in  
		    gvf((Paths.getTclPathGUI ip)^".box get "^mt1^" "^mt2)
		end
	  | _  => Config.selText w
    end

fun selectTextAll wid = selectText wid (Mark(0,0),MarkEnd);


fun selectSelRange wid =
    let 
	val gvf = Com.readTclVal
	val ip =  Paths.getIntPathGUI wid
        val w  =  WidgetTree.getWidgetGUIPath ip
	fun mkMark str = 
	    let val (x, y)= StringUtil.breakAtDot str
	    in  Mark(StringUtil.toInt x, StringUtil.toInt y)
	    end  
	fun group []  = [] 
	  | group (a::b::S) = (a,b)::group(S) 
    in 
	case w of
	    TextWid _ => 
		let
		    val s = gvf((Paths.getTclPathGUI ip)^".txt tag ranges sel")
		in
		    group(map mkMark (StringUtil.words s))
		end
	  | Listbox _ => 
		 let 
		     val t = gvf((Paths.getTclPathGUI ip)^".box curselection")
		 in  
		     if t="" then 
			 []
		     else 
			 [(Mark(StringUtil.toInt t,0),MarkEnd)]
		 end
          (* Entry ????????? *)
	  | _            => []
    end


fun selectSelWindow () = 
    let 
	val gvf = Com.readTclVal
	val t   = gvf("selection own")
    in  
	if t = "" then NONE else SOME (Paths.getIntPathFromTclPathGUI t)
    end


(* selectCursor has to look for the actual cursor position in listboxes  *)
(* and textwidgets *)

fun selectCursor wid =
    let 
	val gvf = Com.readTclVal
	val ip =  Paths.getIntPathGUI wid;
        val w  =  WidgetTree.getWidgetGUIPath ip
    in 
	case w of
	    TextWid _ => 
		 let 
		     val t = gvf((Paths.getTclPathGUI ip)^".txt index insert")
		     val (m1,m2)= StringUtil.breakAtDot t
		 in 
		     Mark(StringUtil.toInt m1, StringUtil.toInt m2) 
		 end
	  | Listbox _ =>
		 let
		     val t = gvf((Paths.getTclPathGUI ip)^".box curselection")
(*		     val _ = Debug.print 2 ("SelectCursor: t= >"^t^"<") *)
		 in
		     if ( t = "" ) then
			 raise WIDGET "WidgetOps.selectCursor: no selection"
		     else
			 Mark(getOpt(Int.fromString t, 0),0)
		 end
          (* Entry ????????? *)
	  | _            => 
		Mark(0,0)
    end


(* No check that this variable is really defined!!! *)

fun selectVarValue var = 
    Com.readTclVal("global "^var^"; set "^ var)


fun setVarValue var value = 

    ignore (Com.readTclVal("global "^var^"; set " ^ var ^ " " ^ value))


fun createAndPopUpMenu widg index co =
    let
	val winid = Paths.newWidgetId()
	val frmid = Paths.newWidgetId()
	val frm   = Frame(frmid, [widg], [], [], [])
	val wid   = selWidgetWidId widg
    in
	Window.openW(winid, [], [frm], fn()=> ());
	WidgetTree.popUpMenu wid index co
    end



end






