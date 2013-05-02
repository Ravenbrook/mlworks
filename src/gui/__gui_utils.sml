(*
 * $Log: __gui_utils.sml,v $
 * Revision 1.12  1998/01/27 16:07:24  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.11  1997/10/22  12:53:58  johnh
 * [Bug #30233]
 * Get names of custom editors from editor\custom.
 *
 * Revision 1.10.2.2  1997/11/24  11:49:02  johnh
 * [Bug #30071]
 * Remove paths menu hence PathTool structure.
 *
 * Revision 1.10.2.1  1997/09/11  20:51:44  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.10  1997/06/09  10:26:07  johnh
 * [Bug #30068]
 * Remove Trace structure - no longer needed.
 *
 * Revision 1.9  1997/03/25  10:26:10  matthew
 * Adding MachSpec parameter
 * ,
 *
 * Revision 1.8  1997/03/19  11:21:06  matthew
 * Adding Types structure
 *
 * Revision 1.7  1996/06/24  11:58:12  daveb
 * Removed SaveImage.preference_file_name, because Getenv.get_preferences_filename
 * now does this job.
 *
 * Revision 1.6  1996/05/20  13:03:35  daveb
 * Added SaveImage parameter.
 *
 * Revision 1.5  1996/04/30  09:28:07  matthew
 * Changing to new basis
 *
 * Revision 1.4  1995/12/13  14:57:28  jont
 * Add ml_debugger parameter
 *
 * Revision 1.3  1995/12/12  16:49:10  daveb
 * Added PathTool parameter.
 *
 * Revision 1.2  1995/10/04  12:54:10  daveb
 * Added Entry parameter.
 *
 * Revision 1.1  1995/07/26  14:39:50  matthew
 * new unit
 * New unit
 *
 *  Revision 1.9  1995/07/13  14:12:59  matthew
 *  Adding some debugger utilities
 *
 *  Revision 1.8  1995/07/04  13:44:14  matthew
 *  Capification
 *
 *  Revision 1.7  1995/05/30  17:40:44  daveb
 *  Added Preferences parameter.
 *
 *  Revision 1.6  1995/04/28  12:37:50  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.5  1995/04/18  10:13:15  matthew
 *  Adding Trace structure
 *
 *  Revision 1.4  1994/08/24  21:50:30  brianm
 *  Adding value menu implementation ...
 *
 *  Revision 1.3  1993/12/10  10:19:08  daveb
 *  Added ShellTypes argument.
 *
 *  Revision 1.2  1993/04/27  12:57:13  daveb
 *  Added Menus and UserOptions parameters.
 *
 *  Revision 1.1  1993/04/21  12:51:27  daveb
 *  Initial revision
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)

require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__lists";
require "../utils/__crash";
require "../main/__user_options";
require "../main/__preferences";
require "../machine/__machspec";
require "../interpreter/__user_context";
require "../interpreter/__shell_utils";
require "../interpreter/__entry";
require "../system/__getenv";
require "../typechecker/__types";
require "../editor/__custom";

require "_gui_utils";

structure GuiUtils_ =
  GuiUtils (
    structure Capi = Capi_
    structure Lists = Lists_
    structure Crash = Crash_
    structure UserOptions = UserOptions_
    structure Preferences = Preferences_
    structure MachSpec = MachSpec_
    structure Menus = Menus_
    structure UserContext = UserContext_
    structure ShellUtils = ShellUtils_
    structure Entry = Entry_
    structure Getenv = Getenv_
    structure Types = Types_
    structure CustomEditor = CustomEditor_
  );
