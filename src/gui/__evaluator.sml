(*
 * evaluator.sml the structure.
 * 
 * $Log: __evaluator.sml,v $
 * Revision 1.3  1996/01/24 16:03:56  daveb
 * Converting to source browser.
 *
 * Revision 1.2  1995/10/18  13:45:39  nickb
 * Add profiler to the shelldata made here.
 *
 * Revision 1.1  1995/07/26  14:41:34  matthew
 * new unit
 * New unit
 *
 *  Revision 1.12  1995/07/13  10:04:56  matthew
 *  Removing Parser structure
 *
 *  Revision 1.11  1995/07/04  14:34:36  matthew
 *  Removing Xm structure
 *
 *  Revision 1.10  1995/07/03  16:07:56  daveb
 *  Replaced input and output windows with a single console window.
 *
 *  Revision 1.9  1995/06/30  09:44:29  daveb
 *  Added Capi parameter.
 *
 *  Revision 1.7  1995/06/06  12:32:20  daveb
 *  Removed Crash parameter.
 *
 *  Revision 1.6  1995/05/26  15:27:46  daveb
 *  Removed UserOptions parameter.
 *
 *  Revision 1.5  1995/03/30  13:49:00  daveb
 *  Removed unused parameters.
 *
 *  Revision 1.4  1994/08/01  12:27:39  daveb
 *  Added Preferences argument.
 * 
 *  Revision 1.3  1994/07/05  14:28:34  daveb
 *  Added InputWindow argument.
 * 
 *  Revision 1.2  1994/06/29  13:19:52  daveb
 *  Added FileDialog argument.
 * 
 *  Revision 1.1  1994/06/21  18:53:12  daveb
 *  new file
 * 
 *  
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *  
 *)

require "../utils/__lists";
require "../main/__info";
require "../main/__preferences";
require "../main/__user_options";
require "../winsys/__capi";
require "../winsys/__menus";
require "__tooldata";
require "__gui_utils";
require "_evaluator";

structure Evaluator_ = Evaluator (
  structure Info = Info_
  structure Lists = Lists_
  structure Preferences = Preferences_
  structure UserOptions = UserOptions_
  structure ToolData = ToolData_
  structure GuiUtils = GuiUtils_
  structure Menus = Menus_
  structure Capi = Capi_
);
