(*  ==== INTERPRETER MAKE SYSTEM ====
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: intermake.sml,v $
 *  Revision 1.47  1997/05/01 12:39:32  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 * Revision 1.46  1997/04/09  16:17:23  jont
 * [Bug #2040]
 * Make InterMake.load take an options argument
 *
 * Revision 1.45  1996/08/14  10:53:10  jont
 * Remove get_mo_information from interface as it's not used externally
 * Also remove get_src_information as it's also not used externally
 *
 * Revision 1.44  1996/05/03  09:15:21  daveb
 * Removed Interrupted and Error exceptions.
 * The load and compile functions side-effect their project arguments instead
 * of returning an updated value.
 *
 * Revision 1.43  1996/03/14  16:15:28  daveb
 * Added get_mo_information (again) and get_src_information.
 *
 * Revision 1.42  1995/12/11  17:07:10  daveb
 * Now passes debug info around as accumulated info instead of a basis.
 *
 *  Revision 1.41  1995/11/29  14:53:13  daveb
 *  Changed to use projects.
 *
 *  Revision 1.40  1995/07/28  12:01:50  matthew
 *  Improving load_mo errors
 *
 *  Revision 1.39  1995/01/30  13:03:53  daveb
 *  Changed get_mo_dependencies and get_mo_information to take module_ids.
 *
 *  Revision 1.38  1995/01/13  12:15:15  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *
 *  Revision 1.37  1994/07/26  10:09:44  daveb
 *  Removed inter_env component of Result type.
 *
 *  Revision 1.36  1994/04/12  17:31:01  jont
 *  Fix require file names in consistency info.
 *
 *  Revision 1.35  1994/03/25  17:04:24  daveb
 *  make now takes a module_id, instead of a module.
 *
 *  Revision 1.34  1994/03/17  16:57:42  matthew
 *  Return list of files EXECUTE result
 *
 *  Revision 1.33  1994/03/14  09:58:20  matthew
 *  Reinstated load_time in Result
 *  Dependencies also contain load_time value
 *
 *  Revision 1.32  1994/02/01  16:58:20  daveb
 *  make now takes a MOdule argument instead of a file name argument.
 *
 *  Revision 1.31  1994/01/28  16:27:24  matthew
 *  Improvements to error locations
 *
 *  Revision 1.30  1994/01/25  15:49:27  matthew
 *  Simplified interface.
 *
 *  Revision 1.29  1994/01/07  09:58:20  matthew
 *  Added get_mo_information
 *
 *  Revision 1.28  1993/11/15  14:08:45  nickh
 *  New pervasive time structure.
 *
 *  Revision 1.27  1993/10/05  10:24:59  jont
 *  Added save function for writing out .mo files
 *
 *  Revision 1.26  1993/09/02  17:08:30  matthew
 *  Merging in bug fixes
 *
 *  Revision 1.25.1.2  1993/09/01  15:01:47  matthew
 *  Added with_debug_information and current_debug_information to
 *  control global debug information.
 *
 *  Revision 1.25  1993/08/09  18:31:53  daveb
 *  Changes to reflect use of moduleids.
 *
 *  Revision 1.24  1993/07/30  14:32:45  nosa
 *  Changed Option.T to Option.opt.
 *
 *  Revision 1.23  1993/07/29  15:27:51  matthew
 *  Added Interrupted exception to indicate if a make was interrupted.
 *
 *  Revision 1.22  1993/05/14  12:23:23  jont
 *  Signature clean up
 *
 *  Revision 1.21  1993/05/11  12:47:41  matthew
 *  Added error list to Error exception
 *
 *  Revision 1.20  1993/04/02  13:34:27  matthew
 *  Signature changes
 *
 *  Revision 1.19  1993/03/11  13:26:51  matthew
 *  Signature revisions
 *
 *  Revision 1.18  1993/03/08  10:14:12  matthew
 *  Options & Info changes
 *
 *  Revision 1.17  1993/02/24  14:22:17  daveb
 *  Changed type of name_monitor field; indenting now done in this file.
 *
 *  Revision 1.16  1993/02/04  14:49:22  matthew
 *  Added sharing
 *
 *  Revision 1.15  1992/12/18  10:11:46  clive
 *  We also pass the current module forward for the source_displayer
 *
 *  Revision 1.14  1992/12/09  12:41:13  clive
 *  Added find_module
 *
 *  Revision 1.13  1992/12/08  12:09:44  daveb
 *  Added some sharing constraints.
 *
 *  Revision 1.12  1992/12/04  13:05:55  richard
 *  Make takes an extra parameter which is a list of modules which shouldn't
 *  be loaded from their compilation results but taked directly from there.
 *
 *  Revision 1.11  1992/12/03  20:32:17  daveb
 *  Added a sharing constraint.
 *
 *  Revision 1.10  1992/12/03  11:50:47  clive
 *  Added delete_module
 *
 *  Revision 1.9  1992/12/02  17:05:02  daveb
 *  Changes to propagate compiler options as parameters instead of references.
 *
 *  Revision 1.8  1992/11/30  17:44:15  clive
 *  Debugger function now takes up-to-date environment
 *
 *  Revision 1.7  1992/11/20  15:37:26  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.6  1992/11/18  17:45:22  clive
 *  Added a debugger to make
 *
 *  Revision 1.5  1992/11/17  17:26:07  matthew
 *  Changed Error structure to Info
 *
 *  Revision 1.4  1992/11/02  16:27:33  richard
 *  Changes to pervasives and representation of time.
 *
 *  Revision 1.3  1992/10/19  14:47:26  richard
 *  Added an Error exception to allow make to return partially augmented
 *  modules and cache tables in case of an error.
 *
 *  Revision 1.2  1992/10/16  11:06:57  clive
 *  Changes for windowing listener
 *
 *  Revision 1.1  1992/10/14  12:13:24  richard
 *  Initial revision
 *
 *)

require "../main/compiler";
require "inter_envtypes";
require "../utils/diagnostic";

signature INTERMAKE =
  sig
    structure Compiler : COMPILER
    structure Inter_EnvTypes : INTER_ENVTYPES
    structure Diagnostic : DIAGNOSTIC

    sharing Inter_EnvTypes.Options = Compiler.Options
    sharing Compiler.NewMap = Inter_EnvTypes.EnvironTypes.NewMap
    sharing type Compiler.Top_Env = Inter_EnvTypes.EnvironTypes.Top_Env

    type Project
    type ModuleId

    (* The Compiler.basis type includes a debug_info field.  When an
       evaluation has returned, the current basis contains the up-to-date
       debug_info.  But during an evaluation, the debug_info needs to
       be accumulated separately.  The current_debug_information function
       returns this value, and with_debug_information can be used to set
       it.  This latter is used during calls of InterLoad.load, which may
       evaluate code, which may enter the debugger, which accesses the
       current debug info.
       Possibly the debug info should be moved out of the compiler basis
       and into the user context. *)

    val with_debug_information :
      Compiler.DebugInformation ->
      (unit -> 'a) ->
      'a

    val current_debug_information : unit -> Compiler.DebugInformation

    val compile :
      ((MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T) ->
       (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T)) -> 
      Compiler.basis * Inter_EnvTypes.inter_env ->
      Compiler.Info.options * Compiler.Info.Location.T
      * Compiler.Options.options ->
      (string * MLWorks.Internal.Value.T) list option ->
      Project * ModuleId * Compiler.DebugInformation ->
      Compiler.result * MLWorks.Internal.Value.T * Compiler.DebugInformation
      (* N.B. This side-effects the project argument. *)

    val load :
      Compiler.Options.options ->
      Project * Compiler.Info.Location.T -> ModuleId -> 
      Compiler.result * MLWorks.Internal.Value.T
      (* N.B. This side-effects the project argument. *)

  end

