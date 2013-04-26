(* *********************************************************************** *)
(*									   *)
(* Project: sml/Tk: an Tk Toolkit for sml	 			   *)
(* Author: Burkhart Wolff, University of Bremen	 			   *)
(* Date: 25.7.95				 			   *)
(* Purpose of this file: BASIC PROCESS CONTROL AND COMMUNICATION ROUTINES  *)
(*									   *)
(* *********************************************************************** *)

require "__text_io";
require "__list";

require "basic_util";
require "debug";
require "basic_types";
require "com_sig";

structure Com : COM
= 
struct

local open BasicTypes in
local open BasicUtil in

val smltk_appid : AppId = "SMLTK";

val env = MLWorks.Internal.Runtime.environment;

val mlw_tclInit : unit -> unit = env "tcl tk init";
val mlw_tclEval : string -> string = env "mlw tcl eval";
val get_result : unit -> string = env "mlw tcl get result";
val do_tcl_event : unit -> unit = env "mlw tcl do one event";

(*
val results = ref []

fun removeLast [] = ("TCL NO RESULT", [])
  | removeLast [last] = (last, [])
  | removeLast (a::rest) = 
	let val (return_val, l) = removeLast rest 
	in (return_val, a::l)
	end

fun addResultStr (resRef, s) = resRef := (s::(!resRef))
fun remResultStr (resRef) = 
	let val (s, l) = removeLast (!resRef)
	in (resRef := l; s)
	end

fun get_result () = remResultStr results
fun put_result s = addResultStr (results, s)
*)

fun selAppId         ap = let val (id,_,_,_,_,_)    = ap in id   end;
fun selAppProt       ap = let val (_,_,_,prot,_,_)  = ap in prot end;
fun selAppIn         ap = let val (_,_,inst,_,_,_)  = ap in inst  end;
fun selAppOut        ap = let val (_,outs,_,_,_,_)  = ap in outs end;
fun selAppCallBack   ap = let val (_,_,_,_,cb,_)    = ap in cb   end;
fun selAppQuitAction ap = let val (_,_,_,_,_,qa)    = ap in qa   end;

fun getApp appId =
    let
	val (apps,_,_,_,_,_) = !COM_state
	val app = valOf (List.find ((eq appId) o selAppId) apps)
	    handle Option => raise (TCL_ERROR ("Error in function com.getApp (application id "^appId^")"))
    in
	app
    end;

fun getAppProt       appId = selAppProt(getApp appId);
fun getAppIn         appId = selAppIn(getApp appId);
fun getAppOut        appId = selAppOut(getApp appId);
fun getAppCallBack   appId = selAppCallBack(getApp appId);
fun getAppQuitAction appId = selAppQuitAction(getApp appId);

fun addAppI (app as (appId,tclo,tcli,prot,cb,qa)) = 
    let 
	val (apps,logf,wishp,tclini,srcp,fntp) = !COM_state
    in
	COM_state:=(apps@[app],logf,wishp,tclini,srcp,fntp)
    end;

fun addApp (appId,(prog,parms),prot,cb,qa) =
    let
	val (i1,o1) = FileUtil.execute(prog,parms)
	val o2      = TextIO.openOut(prot)
    in
	addAppI(appId,i1,o1,o2,cb,qa)
    end;


fun removeApp appId =
    let
	val (apps,logf,wishp,tclini,srcp,fntp) = !COM_state
	val napps = List.filter (not o (eq appId) o selAppId) apps
    in
	((getAppQuitAction(appId))();
	 COM_state:=(napps,logf,wishp,tclini,srcp,fntp))
    end;



val getProt = fn () => getAppProt smltk_appid;
val getIn   = fn () => getAppIn   smltk_appid;
val getOut  = fn () => getAppOut  smltk_appid;


(* very ineficcient. should be realized by a "hook" in order to make *)
(* the protocolling optional. if PROT="", no protocolling should     *)
(* take place *)

(* getLine() strings can only be used for texts that are certain not *)
(* contain \n. Otherwise, getlineM() (M for multiple) has to be used.*)
(* On the other side, an appropriate writeM is provided. *)

(* XXX potential problem with getLineApp if multiple apps are used, cos 
 * the same result store will be used in both cases.
 * !!! Instead, have multiple result queues in ML instead of one in the
 * runtime.
 *)

fun getLineApp appId = 
    let
	val outs = getAppOut appId
	val prot = getAppProt appId
	val t = get_result()
	(* strip off concluding "\n" *) 
(* 	val t = substring(t,0,(size t) -1) *)
    in 	
	if (t = "TCL NO RESULT") then ()
	else
	  (TextIO.output(prot, "<== " ^ t ^"\n");
	   TextIO.flushOut(prot));
	t
    end

and getLine () = getLineApp smltk_appid;

fun getLineMApp appId = 
    let
	val outs = getAppOut appId
	val prot = getAppProt appId
	fun getls () = 
	    let
		val t = get_result()
	    in    
		TextIO.output(prot, "<== " ^ t ^"\n");
		TextIO.flushOut(prot);
		if t = "EOM\n" then "" else t ^ getls () 
	    end
    in
	getls ()
    end

and getLineM () = getLineMApp smltk_appid;


fun do_events 0 = ()
  | do_events n = (do_tcl_event(); do_events (n-1))


(* XXX put_result stores, in a queue the tcl results 
 * and other info to be processed later. *)

fun putLineApp appId ps = 
    let
	val inst = getAppIn appId
	val prot = getAppProt appId
	val res = mlw_tclEval (ps)  (* removed newline *)
    in
(* 	do_events 10; *)
(* 	put_result res; *)
	TextIO.output(prot, "==> " ^ ps ^ "\n"); 			
	TextIO.flushOut(prot)
    end

and putLine ps = 
    putLineApp smltk_appid ps
	  
fun putTclCmd cmd =
    let
	val emsg = fn s => (StringUtil.concatWith " " s)

	fun getAnswer aws =
	    let
		val a    = getLine()
		val ss   = StringUtil.words a
		val kind = hd ss
		val _ = Debug.print 1 ("Eventloop.getTclValue: got \""^a^"\"");
	    in
		if (kind = "CMDOK" orelse kind = "ERROR" ) then
		    (a,aws)
		else
		    getAnswer(aws@[a])
	    end

	val _           = putLine ("WriteCmd \"CMDOK\" {"^ cmd ^ "}")
	val (a,binds)   = getAnswer []

	val gaws = getTclAnswersGUI()
	val _    = updTclAnswersGUI(gaws@binds)

	val _    = if not (length binds = 0) then
	               Debug.warning "Missed Binding"
		   else
		       ()
    in
	case (hd (StringUtil.words a)) of
	    "CMDOK" => ()
	  | "ERROR" => raise BasicTypes.TCL_ERROR 
		             ("Com.putCmd: got Tcl Error: \""^ a ^"\"")
	  | s       => raise BasicTypes.TCL_ERROR
		             ("Com.putCmd: got unexpected answer: \""^ s ^"\"")
    end


fun readTclVal req =
    let
	val concatSp = StringUtil.concatWith " "

	fun getAnswer aws =
	    let
		val a    = getLine()
		val ss   = StringUtil.words a
		val kind = hd ss
		val _ = Debug.print 1 ("Eventloop.getTclValue: got \""^a^"\"");
	    in
		if (kind = "VValue" ) then
		    (concatSp(tl(ss)), aws)
		else
		    getAnswer(aws@[a])
	    end

	val _         = putLine ("WriteSec \"VValue\" {"^ req ^ "}")
	val (a,binds) = getAnswer []

	val gaws = getTclAnswersGUI()
	val _    = updTclAnswersGUI(gaws@binds)
    in
	a
    end





(* Tcl - Primitives  *)
(* communication - routine that sends action-representations
   back to sml for interpretation *)

val commToTcl    = "Write"; (* "communicate"; *)
val writeToTcl   = "Write";
val writeMToTcl  = "WriteM";


(* Not used
*)

(* WriteM
\  put_result $msg                      \n \
\  put_result  \"EOM\"                  \n \
*)

val prelude_tcl = 
"proc Write {msg} {                     \n \
\ put_result $msg                       \n \
\}                                      \n \
\proc WriteSec {tag msg} {              \n \
\  set status [catch {eval $msg} res]   \n \
\  if {$status == 0} {                  \n \
\    put_result \"$tag $res\"           \n \
\  } else {                             \n \
\    put_result \"ERROR $res\"          \n \
\  }                                    \n \
\}                                      \n \
\proc WriteCmd {tag msg} {              \n \
\  set status [catch {eval $msg} res]   \n \
\  if {$status == 0} {                  \n \
\    put_result \"$tag\"                \n \
\  } else {                             \n \
\    put_result \"ERROR $res\"          \n \
\  }                                    \n \
\}                                      \n \
\proc WriteM {msg} {                    \n \
\ put_result $msg                       \n \
\ put_result \"EOM\"                    \n \
\}                                      \n ";


(* Tcl - PROCESS CONTROL  *)

fun initTcl cb = 
    let
(* 	val _ = print ("wish path = " ^ getWishPath() ^ "\n") *)
(* 	val (i1, o1) = FileUtil.execute (getWishPath (),[]) *)

	val _ = mlw_tclInit ()
	val (i1, o1) = (TextIO.stdIn, TextIO.stdOut)
	val o2       = TextIO.openOut (getLogfilename ())

	val qa       = fn () => ignore (mlw_tclEval "destroy .")
    in    
	addAppI (smltk_appid,i1,o1,o2,cb,qa);
	ignore(mlw_tclEval (getTclInit() ^ prelude_tcl));
	(* dummy for not handling exceptions *)
	true 
    end;

fun runTcl ()  = (); (* (putLine "EOM"); *)

(* ### 
   hier muss noch sichergestellt werden, dasz die andren Applikation
   auch gekillt werden
*)

fun exitTcl()  = 
    case !COM_state of
	([],_,_,_,_,_) => ()
      | (_,_,_,_,_,_)  => let
			  fun selApps (apps,_,_,_,_,_) = apps
		      in
			  (app (removeApp o selAppId) (selApps(!COM_state));
			   GUI_state:=([],[],[]);
			   COM_state:= ([],getLogfilename(),getWishPath(),getTclInit(),getSrcPath(),getFntPath()))
		      end;

fun resetTcl()  =  (GUI_state:=([],[],[]);
		     COM_state:= ([],getLogfilename (),
				  getWishPath(),getTclInit(),getSrcPath(),getFntPath()));

end; end;

end;

