(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/sys_conf.sml,v $

   System configuration.  
  
   Reads the environment variables determing the source dir location,
   wish, protocol file, and the display.
 
   $Date: 1999/06/16 10:02:21 $
   $Revision: 1.1 $
   Author: stefan (Last modification by $Author: johnh $)

   (C) 1996, Bremen Institute for Safe Systems (BISS), University of Bremen. 

  ************************************************************************** *)

require "__string";

require "basic_util";

signature SYS_CONF =
sig
    val getSmlTkPath : unit -> string
    val getProtPath  : unit -> string
    val getTclPath   : unit -> string
    val getFontPath  : unit -> string
    val getDisplay   : unit -> string
end;


structure SysConf : SYS_CONF =
struct

open BasicUtil

(******************************************************************************
 *                                                                            *
 * WARNING: sys_conf.sml is generated from sys_conf.sml.tmpl by the Makefile. *
 *          file. DO NOT CHANGE sys_conf.sml, but CHANGE sys_conf.sml.tmpl.   *
 *                                                                            *
 *****************************************************************************)

val pathPrefix     = ""
val smlTkPath      = "/sml_tk_mlw/"
val tclPath        = ""
val protPath       = ""

val srcEnvVar      = "SMLTK_ROOT"
val tclVar         = "SMLTK_TCL"
val protVar        = "SMLTK_LOGFILE"

fun getSmlTkPath () = "/u/johnh/temp/src/sml_tk_mlw/"
(*
    getOpt(FileUtil.getEnv srcEnvVar, pathPrefix)^ smlTkPath
*)

fun getProtPath () = "/u/johnh/temp/smltk_mlw.log"
(*
    getOpt(FileUtil.getEnv protVar, protPath)
*)

fun getTclPath () = "/u/johnh/temp/tk4.2/unix/wish"
(*
    getOpt(FileUtil.getEnv tclVar, tclPath)
*)

fun getFontPath () = (getSmlTkPath ())^"testfont"

    (* this returns the "full" display name, ie. 
     * HOST:<DISPLAY>.<SCREEN>
     * taken from the DISPLAY and HOSTNAME environment variables 
     *)
fun getDisplay () =    
    let val dpy = getOpt(FileUtil.getEnv "DISPLAY", "NO-DISPLAY")
	val host= getOpt(FileUtil.getEnv "HOSTNAME", "NO-HOST")
    in  (if String.sub(dpy, 0)= #":" then host^dpy   
            (* prefix with host name if display name is ":0.0" or some such *)
	else dpy)
	    handle Subscript=> host
		(* that will not work with 0.93... sorry :-) *)
    end


end


