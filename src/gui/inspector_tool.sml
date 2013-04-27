(*
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
 *  $Log: inspector_tool.sml,v $
 *  Revision 1.2  1996/01/19 10:54:01  matthew
 *  Changing interface to allow inspector reuse.
 *
 * Revision 1.1  1995/06/08  13:37:17  matthew
 * new unit
 * New unit
 *
 *  Revision 1.15  1995/06/08  13:37:17  daveb
 *  Removed Widget type.
 *
 *  Revision 1.14  1995/06/08  09:26:18  daveb
 *  Removed debugger function arguments.
 *
 *  Revision 1.13  1995/06/06  09:34:24  daveb
 *  Removed inspect_variable.
 *
 * 
 *  Revision 1.12  1995/03/02  17:10:37  daveb
 *  Added inspect_variable, with takes a context and looks the value up
 *  in that.
 *
 *  Revision 1.11  1995/01/13  15:27:06  daveb
 *  Replaced Option structure with references to MLWorks.Option.
 *  
 *  Revision 1.10  1994/07/12  15:42:32  daveb
 *  Replaced ToolData structure with ToolData type and Option structure.
 *  
 *  Revision 1.9  1994/02/21  20:55:43  nosa
 *  Boolean indicator for Monomorphic debugger decapsulation.
 *  
 *  Revision 1.8  1993/12/09  19:35:34  jont
 *  Added copyright message
 *  
 *  Revision 1.7  1993/08/06  13:59:28  nosa
 *  Debugger-window now passed to Inspector-tool functions.
 *  
 *  Revision 1.6  1993/05/07  10:51:24  daveb
 *  Added string argument to inspect_value - this is displayed in the input
 *  text widget on startup.
 *  
 *  Revision 1.5  1993/05/05  17:35:35  daveb
 *  Renamed inspect to create, and changed its type so that inspectors can
 *  be added to the list of tools on the Works menu.
 *  Added a debugger function to eval_string.
 *  
 *  Revision 1.4  1993/04/23  13:15:20  matthew
 *  Added inspect_value function
 *  
 *  Revision 1.3  1993/04/02  17:14:37  matthew
 *  inspect takes a ShellData argument -- this should probably be
 *  a ShellState though
 *  
 *  Revision 1.2  1993/04/01  09:41:08  matthew
 *  Added UserOptions parameter to inspect
 *  
 *  Revision 1.1  1993/03/26  16:50:17  matthew
 *  Initial revision
 *  
 *)

signature INSPECTORTOOL =
  sig
    type Type
    type ToolData
    type Widget

    val inspect_value :
      (Widget * bool * ToolData) -> 
      bool -> (* is this an automatic selection or not? *)
      string * (MLWorks.Internal.Value.ml_value * Type) ->
      unit
  end

