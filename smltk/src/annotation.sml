(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen

  $Date: 1999/06/16 09:53:13 $
  $Revision: 1.1 $

   Purpose of this file: Functions related to Text Widget Annotations

   *********************************************************************** *)

require "__list_pair";
require "__list";
require "__int";

require "basic_util";
require "debug";
require "basic_types";
require "com";
require "config";
require "bind";
require "paths";
require "ann_texts";
require "mark";
require "annotation_sig";

structure Annotation : ANNOTATION = 
struct

(*
nonfix prefix;
*)

local open BasicTypes BasicUtil in


exception ANNOTATION of string


type widgetPackFun = bool -> TclPath -> IntPath -> Widget -> unit

type widgetAddFun  = Widget list -> Widget -> WidPath           -> Widget list
type widgetDelFun  = Widget list -> WidId  -> WidPath           -> Widget list
type widgetUpdFun  = Widget list -> WidId  -> WidPath -> Widget -> Widget list

type widgetDelFunc = WidId -> unit
type widgetAddFunc = WinId -> WidPath -> Widget -> unit


fun selTextWidWidId (TextWid(wid,_,_,_,_,_)) = wid
  | selTextWidWidId _                        = 
    raise WIDGET "Annotation.selTextWidWidId applied to non-Text Widget"

fun selTextWidScrollType (TextWid(_,st,_,_,_,_)) = st
  | selTextWidScrollType _                       =
    raise WIDGET "Annotation.selTextWidScrollType applied to non-Text Widget"

fun selTextWidAnnoText (TextWid(_,_,at,_,_,_)) = at
  | selTextWidAnnoText _                         =
    raise WIDGET "Annotation.selTextWidText applied to non-Text Widget"

fun selTextWidPack (TextWid(_,_,_,p,_,_)) = p
  | selTextWidPack _                        =
    raise WIDGET "Annotation.selTextWidPack applied to non-Text Widget"

fun selTextWidConfigure (TextWid(_,_,_,_,c,_)) = c
  | selTextWidConfigure _                       =
    raise WIDGET "Annotation.selTextWidConfigure applied to non-Text Widget"

fun selTextWidBinding (TextWid(_,_,_,_,_,b)) = b
  | selTextWidBinding _                       =
    raise WIDGET "Annotation.selTextWidBinding applied to non-Text Widget"



fun updTextWidWidId (TextWid(_,st,at,p,c,b)) wid = TextWid(wid,st,at,p,c,b)
  | updTextWidWidId _ _ = 
    raise WIDGET "Annotation.updTextWidWidId applied to non-Text Widget"

fun updTextWidScrollType (TextWid(wid,_,at,p,c,b)) st = TextWid(wid,st,at,p,c,b)
  | updTextWidScrollType _ _ = 
    raise WIDGET "Annotation.updTextWidScrollType applied to non-Text Widget"

fun updTextWidAnnoText (TextWid(wid,st,_,p,c,b)) at = TextWid(wid,st,at,p,c,b)
  | updTextWidAnnoText _ _ = 
    raise WIDGET "Annotation.updTextWidAnnoText applied to non-Text Widget"

fun updTextWidPack (TextWid(wid,st,at,_,c,b)) p = TextWid(wid,st,at,p,c,b)
  | updTextWidPack _ _ = 
    raise WIDGET "Annotation.updTextWidPack applied to non-Text Widget"

fun updTextWidConfigure (TextWid(wid,st,at,p,_,b)) c = TextWid(wid,st,at,p,c,b)
  | updTextWidConfigure _ _ = 
    raise WIDGET "Annotation.updTextWidConfigure applied to non-Text Widget"

fun updTextWidBinding (TextWid(wid,st,at,p,c,_)) b = TextWid(wid,st,at,p,c,b)
  | updTextWidBinding _ _ = 
    raise WIDGET "Annotation.updTextWidBinding applied to non-Text Widget"



fun selAnnotationType (TATag _)    = ATTag
  | selAnnotationType (TAWidget _) = ATWidget

fun selAnnotationId (TATag(tn,_,_,_))          = tn
  | selAnnotationId (TAWidget(tn,_,_,_,_,_,_)) = tn

fun selAnnotationConfigure (TATag(_,_,c,_))          = c
  | selAnnotationConfigure (TAWidget(_,_,_,_,_,c,_)) = c

fun selAnnotationBinding (TATag(_,_,_,b)) = b
  | selAnnotationBinding  _               =
    raise ANNOTATION ("Annotation.selAnnotationBinding applied to non TATag")

fun selAnnotationMarks (TATag(_,ml,_,_))         = ml
  | selAnnotationMarks (TAWidget(_,m,_,_,_,_,_)) = [(m,m)]

fun selAnnotationWidId (TAWidget(_,_,widid,_,_,_,_)) = widid
  | selAnnotationWidId _                             =
    raise ANNOTATION ("Annotation.selAnnotationWidId applied to non TAWidget")

fun selAnnotationWidgets (TAWidget(_,_,_,wids,_,_,_)) = wids
  | selAnnotationWidgets _                            =
    raise ANNOTATION ("Annotataion.selAnnotationWidgets applied to non TAWidget")

fun selAnnotationWidgetConfigure (TAWidget(_,_,_,_,wc,_,_)) = wc
  | selAnnotationWidgetConfigure _ =
    raise ANNOTATION ("Annotataion.selAnnotationWidgetConfigure applied to non TAWidget")



fun updAnnotationConfigure (TAWidget(tn,i,wi,wids,wc,_,b)) c = 
    TAWidget(tn,i,wi,wids,wc,c,b)
  | updAnnotationConfigure (TATag(tn,i,_,b)) c =
    TATag(tn,i,c,b)

fun updAnnotationBinding (TAWidget(tn,i,wi,wids,wc,c,_)) b = 
    TAWidget(tn,i,wi,wids,wc,c,b)
  | updAnnotationBinding (TATag(tn,i,c,_)) b =
    TATag(tn,i,c,b)

fun updAnnotationWidgets (TAWidget(tn,i,wi,_,wc,c,b)) wids = TAWidget(tn,i,wi,wids,wc,c,b)
  | updAnnotationWidgets _ _ =
    raise ANNOTATION ("Annotation.updAnnotationWidgets applied to non TAWidget")


val selTextWidAnnotations = AnnotatedText.selAnno o selTextWidAnnoText
fun updTextWidAnnotations w a = updTextWidAnnoText w 
                                (AnnotatedText.updAnno (selTextWidAnnoText w) a)

val selTextWidText        = AnnotatedText.selText o selTextWidAnnoText 



fun get wid tn =
    let
	val anots = selTextWidAnnotations wid
	val item  = ListUtil.getx
	               (fn an => ((selAnnotationId an) = tn)) anots 
	                (ANNOTATION ("Annotation.get: " ^ tn ^ " not found"))
    in
	item
    end

fun getBindingByName wid tn name =
    let
	val anot = get wid tn
	val bis  = selAnnotationBinding anot
	val bi   = Bind.getActionByName name bis
    in
	bi
    end

fun upd widg tn nan =
    let
	val at    = selTextWidAnnoText widg
	val ans   = AnnotatedText.selAnno at
	val an    = ListUtil.getx (fn an => ((selAnnotationId an) = tn))
	                                   ans
					   (ANNOTATION ("annotation: " ^ tn ^ " not found"))
	val nans  = ListUtil.updateVal (fn an => ((selAnnotationId an) = tn))
	                                         nan
	                                         ans
	val nwidg = updTextWidAnnoText widg (AnnotatedText.updAnno at nans)
    in
	nwidg
    end


fun getTextWidWidgets (TextWid(wid,st,at,p,c,b)) =
    let
	val widans = List.filter (fn an => (selAnnotationType an = ATWidget))
	                         (AnnotatedText.selAnno at)
	val wids   = map selAnnotationWidgets widans
	val wids'  = List.concat wids
    in
	wids'
    end
  | getTextWidWidgets _ =
    raise WIDGET "Annotation.getTextWidWidgets applied to non-Text Widget"

fun getTextWidAnnotationWidgetAssList (TextWid(wid,st,at,p,c,b)) =
    let
  	val widans = List.filter (fn an => (selAnnotationType an = ATWidget)) 
	                         (AnnotatedText.selAnno at)
 	val wids   = map selAnnotationWidgets widans
    in
 	ListPair.zip(widans,wids)
    end
  | getTextWidAnnotationWidgetAssList _ =
    raise WIDGET "Annotation.getTextWidAnnotationWidgetAssList applied to non-Text Widget"


fun addTextWidWidget af (w as (TextWid _)) widg wp =
    let
	val _ = Debug.print 4 ("addTextWidWidget "^(selWidgetWidId w)^" "^(selWidgetWidId widg)^" "^wp)
	val (wId,nwp)     = Paths.fstWidPath wp      (* strip ".txt" *)
	val (wId',nwp')   = Paths.fstWidPath nwp      (* strip ".tfr" *)
    in
	if ( nwp' = "" ) then
	    raise ANNOTATION "Annotation.addTextWidWidget called for TAWidget-Toplevel"
	else
	    let
		val (wId'',nwp'') = Paths.fstWidPath nwp'
		val anwidass      = getTextWidAnnotationWidgetAssList w

		val (an,swidgs)   = ListUtil.getx
		                      (fn (c,(ws:Widget list)) => 
				       foldr
				         (fn (w,t) => ((selWidgetWidId w) = wId'') orelse t)
					 false ws)
				      anwidass 
				      (ANNOTATION ("Annotation.addTextWidWidget: subwidget " ^ wId'' ^ " not found" ))
		val _ = Debug.print 4 ("addTextWidWidget(ass): "^(selAnnotationId an)^" ["^
			       (StringUtil.concatWith ", " (map (selWidgetWidId) swidgs))^"]")

		val nswidgs       = af swidgs widg nwp'
		val nan           = updAnnotationWidgets an nswidgs
		val nwidg         = upd w (selAnnotationId nan) nan
	    in
		nwidg
	    end
    end
  | addTextWidWidget _ _ _ _ =
    raise WIDGET "Annotation.addTextWidWidgets applied to non-Text Widget"

fun deleteTextWidWidget df (w as (TextWid _)) wid wp =
    let
	val _ = Debug.print 4 ("deleteTextWidWidget "^(selWidgetWidId w)^" "^wp)
	val (wId,nwp)     = Paths.fstWidPath wp         (* strip ".tfr" *)
	val (wId',nwp')   = Paths.fstWidPath nwp
	val anwidass      = getTextWidAnnotationWidgetAssList w

	val (an,swidgs)   = ListUtil.getx
	                       (fn (c,(ws:Widget list)) => 
				  foldr
				  (fn (w,t) => ((selWidgetWidId w) = wId') orelse t)
				  false ws)
			       anwidass 
			       (ANNOTATION ("Annotation.deleteTextWidWidget: subwidget " ^ wId' ^ " not found"))

	val nswidgs       = df swidgs wId' nwp'
	val nan           = updAnnotationWidgets an nswidgs
	val nwidg         = upd w (selAnnotationId nan) nan
    in
	nwidg
    end
  | deleteTextWidWidget _ _ _ _ =
    raise WIDGET "Annotation.deleteTextWidWidget applied to non-Text Widget"

fun updTextWidWidget uf (w as (TextWid _)) wid wp neww =
    let
	val _ = Debug.print 4 ("updTextWidWidget "^(selWidgetWidId w)^" "^wp)
	val (wId,nwp)     = Paths.fstWidPath wp         (* strip ".tfr" *)
	val (wId',nwp')   = Paths.fstWidPath nwp
	val anwidass      = getTextWidAnnotationWidgetAssList w

	val (an,swidgs)   = ListUtil.getx
	                       (fn (c,(ws:Widget list)) => 
				  foldr
				  (fn (w,t) => ((selWidgetWidId w) = wId') orelse t)
				  false ws)
			       anwidass 
			       (ANNOTATION ("Annotation.updTextWidWidget did not find Subwidget " ^ wId'))

	val nswidgs       = uf swidgs wId' nwp' neww
	val nan           = updAnnotationWidgets an nswidgs
	val nwidg         = upd w (selAnnotationId nan) nan
    in
	nwidg
    end
  | updTextWidWidget _ _ _ _ _ =
    raise WIDGET "Annotation.updTextWidWidgets applied to non-Canvas Widget"


fun pack pf tp (ip as (win, pt)) (TATag(nm,il,c,b)) = 
    let
	val is     = Mark.showL il
	val conf   = Config.pack ip c
    in
	(Com.putTclCmd (tp ^ " tag add " ^ nm ^ " " ^ is);
	 Com.putTclCmd (tp ^ " tag configure " ^ nm ^ " " ^ conf);
	 app Com.putTclCmd (Bind.packTag tp ip nm b) )
    end
  | pack pf tp (ip as (win, pt)) (TAWidget(nm,i,widId,ws,wc,c,b)) =
    let 
	val it     = Mark.show i
	val conf   = Config.pack ip c
	val frw    = Frame(widId,ws,[],wc,[])
	val frtp   = tp ^ "." ^ widId
    in
	(ignore(pf false tp ip frw);
	 Com.putTclCmd (tp ^ " window create " ^ it ^ " " ^ conf ^ " -window " ^ frtp))
(* 
 *	 Com.putTclCmd (Bind.packTag tp ip cid b)) )
 *)
    end


fun add pf widg an =
    let
	val ip as (win,pt) = Paths.getIntPathGUI (selWidgetWidId widg)
	val tp             = Paths.getTclPathGUI ip
	val nip            = (win,pt ^ ".txt")
	val ntp            = tp ^ ".txt"
	val ans            = selTextWidAnnotations widg
	val nans           = ans@[an]
	val nwidg          = updTextWidAnnotations widg nans
    in
	(pack pf ntp nip an;
	 nwidg)
    end

fun delete dwf widg tn =
    let
	fun delete' dwf widg (an as (TAWidget(tn,_,wi,ws,_,_,_))) =
	    let
		val ip as (win,pt) = Paths.getIntPathGUI (selWidgetWidId widg)
		val tp             = Paths.getTclPathGUI ip
		val nip            = (win,pt ^ ".txt")
		val ntp            = tp ^ ".txt"
		val ans            = selTextWidAnnotations widg
		val nans           = List.filter (fn an => not ((selAnnotationId an) = tn)) ans
		val nwidg          = updTextWidAnnotations widg nans
	    in
		(app (dwf o selWidgetWidId) ws;
		 Com.putTclCmd ("destroy " ^ ntp ^ "." ^ wi);
(*		 Com.putTclCmd (ntp ^ " delete " ^ cid); 
 *)
		 nwidg)
	    end
	  | delete' dwf widg (an as (TATag(tn,_,_,_))) =
	    let
		val ip as (win,pt) = Paths.getIntPathGUI (selWidgetWidId widg)
		val tp             = Paths.getTclPathGUI ip
		val nip            = (win,pt ^ ".txt")
		val ntp            = tp ^ ".txt"
		val ans            = selTextWidAnnotations widg
		val nans           = List.filter (fn an => not ((selAnnotationId an) = tn)) ans
		val nwidg          = updTextWidAnnotations widg nans
	    in
		(Com.putTclCmd (ntp ^ " tag delete " ^ tn);
		 nwidg)
	    end
	val an = get widg tn
    in
	delete' dwf widg an
    end


fun addAnnotationConfigure widg tn cf =
    let
	fun cmdText (TAWidget _) = " window configure "
	  | cmdText (TATag _)    = " tag configure "
	    
	val ip as (win,pt) = Paths.getIntPathGUI (selWidgetWidId widg)
	val tp             = Paths.getTclPathGUI ip
	val nip            = (win,pt ^ ".txt")
	val ntp            = tp ^ ".txt"
	val ans            = selTextWidAnnotations widg
	val an             = ListUtil.getx (fn an => ((selAnnotationId an) = tn))
	                                   ans 
					   (ANNOTATION ("annotation: " ^ tn ^ " not found"))
	val conf           = selAnnotationConfigure an
	val nconf          = Config.add conf cf
	val nan            = updAnnotationConfigure an nconf
	val nans           = ListUtil.updateVal (fn an => ((selAnnotationId an) = tn))
	                                         nan
	                                         ans
	val nwidg          = updTextWidAnnotations widg nans
    in
	(Com.putTclCmd (ntp ^ (cmdText an) ^ tn ^ " " ^ Config.pack nip cf);
	 nwidg)
    end


fun addAnnotationBinding widg tn bi =
    let
	fun cmdText (TAWidget _) _ _ _ _     =
	    raise ANNOTATION "Annotation.addAnnotationBinding applied to non TATag"
	  | cmdText (TATag _) ntp nip tn bi = 
	    Bind.packTag ntp nip tn bi

	val ip as (win,pt) = Paths.getIntPathGUI (selWidgetWidId widg)
	val tp             = Paths.getTclPathGUI ip
	val nip            = (win,pt ^ ".txt")
	val ntp            = tp ^ ".txt"
	val ans            = selTextWidAnnotations widg
	val an             = ListUtil.getx (fn an => ((selAnnotationId an) = tn))
	                                   ans 
					   (ANNOTATION ("annotation: " ^ tn ^ " not found"))
	val bind           = selAnnotationBinding an
	val nbind          = Bind.add bind bi
	val nan            = updAnnotationBinding an nbind
	val nans           = ListUtil.updateVal (fn an => ((selAnnotationId an) = tn))
	                                         nan
	                                         ans
	val nwidg          = updTextWidAnnotations widg nans
    in
	(app Com.putTclCmd (cmdText an ntp nip tn bi);
	 nwidg)
    end


fun readSelection wid =
    let
	val ip   = Paths.getIntPathGUI (selWidgetWidId wid)
	val tp   = Paths.getTclPathGUI ip

	val ms   = Com.readTclVal (tp^ ".txt tag ranges sel")
    in
	Mark.readL ms
    end

fun readMarks wid tn =
    let
	val ip   = Paths.getIntPathGUI (selWidgetWidId wid)
	val tp   = Paths.getTclPathGUI ip

	val an   = get wid tn
    in
	case (selAnnotationType an) of
	    ATTag    => 
		Mark.readL (Com.readTclVal (tp^ ".txt tag ranges "^tn))
	  | ATWidget => 
		raise ANNOTATION ("Annotation.readMarks applied to non TATag")
    end



(* ************************************************************************ *)
(* 								            *)
(* Anonymous AnnotationId Manager					    *)
(* 									    *)
(* ************************************************************************ *)

val ANOTAGN_NR = ref(0);
fun newId() = (ignore(inc(ANOTAGN_NR));"anotagn"^Int.toString(!ANOTAGN_NR));

val ANOFRID_NR = ref(0);
fun newFrId() = (ignore(inc(ANOFRID_NR));"tfr"^Int.toString(!ANOFRID_NR));

end;

end;

