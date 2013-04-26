(* *********************************************************************** *)
(*									   *)
(* Project: sml/Tk: an Tk Toolkit for sml	 			   *)
(* Author: Burkhart Wolff, University of Bremen	 			   *)
(* Date: 25.7.95				 			   *)
(* Purpose of this file: Event Handler					   *)
(*									   *)
(* *********************************************************************** *)

require "__text_io";

require "basic_util";
require "debug";
require "basic_types";
require "com";
require "config";
require "tk_event";
require "c_item";
require "annotation";
require "widget_tree";
require "tk_windows";
require "eventloop_sig";

structure Eventloop : EVENTLOOP =
struct

local open BasicUtil BasicTypes in

(* This module contains the Controller of the tcl-subprocess  *)
(* startTcl accepts a list of window-descriptions, starts the *)
(* tcl-process, transmits the window-descriptions to it .     *)
(* After this "launch" it starts the event-handler, that      *)
(* waits for "emmissions" of the launched tcl-proccess and    *)
(* interprets its commands on the sml-side. *)

val event_on = ref(true); (* for debugging *)

fun event s =
    let 
	val _ = TextIO.output (TextIO.stdOut, "processing event: " ^ s ^ "\n")
        val ss   = StringUtil.words s
        val kind = hd ss
        val win  = hd (tl ss) 
        val path = hd (tl (tl ss))
    in  
	if kind = "Command" then 
	    WidgetTree.selectCommandPath (win, path) () 
	else if kind = "WBinding" then 
	    let 
		val key  = hd (tl (tl (tl ss)))
		val ev_v = hd (tl (tl (tl (tl ss))))
		val tkev = TkEvent.unparse ev_v
		val wid  = (SOME (WidgetTree.getWidgetGUIPath (win,path)))
		           handle WINDOWS t => NONE
				| WIDGET t  => NONE
	    in 
		case wid of 
		    SOME wid => (WidgetTree.selectBindKeyPath (win, path) key) tkev
		  | NONE     => Debug.warning("got NONEX-WBinding\n")
	    end 
	    handle WIDGET      t => Debug.warning ("Exception WIDGET: "^t)
		 | CItem.CITEM t => Debug.warning ("Exception CITEM: "^t)
	else if kind = "CBinding" then 
	    let 
		val cid  = hd (tl (tl (tl ss)))
		val key  = hd (tl (tl (tl (tl ss))))
		val ev_v = hd (tl (tl (tl (tl (tl ss)))))
		val tkev = TkEvent.unparse ev_v
		val wid  = (SOME (WidgetTree.getWidgetGUIPath (win,path)))
		           handle WINDOWS t => NONE
				| WIDGET t  => NONE
	    in 
		case wid of 
		    SOME wid => (CItem.getBindingByName wid cid key) tkev
		  | NONE     => Debug.warning("got NONEX-CBinding\n")
	    end
	    handle CItem.CITEM t => Debug.warning("Exception CITEM: "^t)
		 | WIDGET      t => Debug.warning("Exception WIDGET: "^t)
	else if kind = "TBinding" then 
	    let 
		val tn   = hd (tl (tl (tl ss)))
		val key  = hd (tl (tl (tl (tl ss))))
		val ev_v = hd (tl (tl (tl (tl (tl ss)))))
		val tkev = TkEvent.unparse ev_v
		val wid  = (SOME (WidgetTree.getWidgetGUIPath (win,path)))
		           handle WINDOWS t => NONE
				| WIDGET t  => NONE
	    in 
		case wid of 
		    SOME wid => (Annotation.getBindingByName wid tn key) tkev
		  | NONE     => Debug.warning("got NONEX-TBinding\n")
	    end
	    handle CItem.CITEM t => Debug.warning("Exception CITEM: "^t)
		 | WIDGET      t => Debug.warning("Exception WIDGET: "^t)
	else if kind = "MCommand" then  
	    let 
		val mitpath = Config.readCascPath (hd (tl (tl (tl ss))))
	    in  
		WidgetTree.selectMCommandMPath (win, path) mitpath () 
	    end
	else if kind = "VValue" then
	    Debug.print 1 ("Eventloop.event: someone missed VValue")
	else if kind = "ERROR" then
	    (Debug.print 1 ("Eventloop.event: got Tcl Error: \""^(StringUtil.concatWith " " (tl ss))^"\"");
	     raise TCL_ERROR ("Eventloop.event: got Tcl Error: \""^(StringUtil.concatWith " " (tl ss))^"\"") 
             )
	else 
	    Debug.print 1 ("Tcl junk sent to SmlTk: " ^ s)
    end;

(*
fun getTclValue req =
    let
	val concatSp = StringUtil.concatWith " "
	fun getAnswer aws =
	    let
		val a    = Com.getLine()
		val ss   = words a
		val kind = hd ss
		val _ = Debug.print 1 ("Eventloop.getTclValue: got \""^a^"\"");
	    in
		if (kind = "VValue" ) then
		    (concatSp(tl(ss)), aws)
		else
		    getAnswer(aws@[a])
	    end

(*	val _         = Com.putLine (Com.writeToTcl ^ " \"VValue [" ^ req ^ "]\"")
 *)
(*	val _         = Com.putLine ("WriteSec \"VValue\" \""^ req ^ "\"")
 *)
	val _         = Com.putLine ("WriteSec \"VValue\" {"^ req ^ "}")
	val (a,binds) = getAnswer []
    in
	(app event binds;a)
    end
*)

val env = MLWorks.Internal.Runtime.environment;
val doOneEvent : unit -> unit = env "mlw tcl do one event"

(* ### ein wenig ineffizient :-)  *)
(* ### schon ein bischen besser, wenn es nur ein Applikation gibt *)
fun appLoop () = 
    let
	exception BREAK;

	val _ = doOneEvent();

	fun procTclA _ = 
	    let
		val tas = BasicTypes.getTclAnswersGUI ()
	    in
		case tas of
		    []        => ()
		  | (ta::tal) => 
			(BasicTypes.updTclAnswersGUI(tal);
			 event ta;
			 procTclA ())
	    end

	fun selApps (apps,_,_,_,_,_) = apps
	fun hasInput inst = TextIO.canInput (inst,1)
	fun doInput  ap = 
	  let 
	    val the_input = Com.getLineApp(Com.selAppId(ap))
	  in
	    if (the_input = "TCL NO RESULT") then ()
	    else
	      ((Com.selAppCallBack (ap)) the_input;
	       raise BREAK)
	  end

(*
	fun tryInput ap = 
	    let
		val inst = Com.selAppOut ap
	    in
		case hasInput(inst) of
		    false => ()
		  | true => (doInput ap; raise BREAK)

	    end
*)

	fun loopOrNot []            = ()  (* appLoop() *)
	  | loopOrNot [firstApp]    = (doInput firstApp handle BREAK => ();appLoop()) 
	  | loopOrNot apps          = (app doInput apps handle BREAK => ();appLoop())
    in
	(procTclA ();
	 loopOrNot (selApps(!COM_state)) )
    end;

fun startTcl ws =
    if (Com.initTcl event) then 
	(app Window.openW ws; 
	 appLoop())
    else 
	raise TCL_ERROR "Error at setup-time: wrong communication received";

fun startTclExn ws = 
    (startTcl ws; "") 
    handle WIDGET      t => "WIDGET: "^t
	 | CItem.CITEM t => "CITEM: "^t
	 | WINDOWS     t => "WINDOWS: "^t
	 | CONFIG      t => "CONFIG: "^t
	 | BasicTypes.TCL_ERROR t => "TCL_ERROR: "^t
	 | Annotation.ANNOTATION  t => "ANNOTATION: "^t
	 | GET           => "GET "


end

end;

