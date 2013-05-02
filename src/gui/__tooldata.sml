(* Types for passing to motif tools.
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
 *  $Log: __tooldata.sml,v $
 *  Revision 1.2  1997/05/16 15:36:50  johnh
 *  Reorganising menus for Motif.
 *
 * Revision 1.1  1995/07/26  14:38:41  matthew
 * new unit
 * New unit
 *
 *  Revision 1.7  1995/07/03  16:17:16  matthew
 *  Capification
 *
 *  Revision 1.6  1995/05/29  14:22:53  daveb
 *  Added MotifUtils parameter.
 *
 *  Revision 1.5  1995/04/28  12:31:28  daveb
 *  Moved all the user_context stuff from ShellTypes into a separate file.
 *
 *  Revision 1.4  1995/03/15  16:09:40  daveb
 *  Added Map parameter.
 *  
 *  Revision 1.3  1993/11/03  18:15:37  daveb
 *  Merged in bug fix.
 *  
 *  Revision 1.2.1.2  1993/11/03  17:53:34  daveb
 *  Added UserOptions parameter.
 *  
 *  Revision 1.2.1.1  1993/04/30  10:24:48  jont
 *  Fork for bug fixing
 *  
 *  Revision 1.2  1993/04/30  10:24:48  daveb
 *  Added Menus parameter.
 *  
 *  Revision 1.1  1993/04/16  17:18:48  matthew
 *  Initial revision
 *  
 *)

require "../interpreter/__shell_types";
require "../interpreter/__user_context";
require "../winsys/__capi";
require "../winsys/__menus";
require "../utils/__btree";
require "../utils/__lists";
require "../main/__user_options";
require "__gui_utils";

require "_tooldata";

structure ToolData_ =
  ToolData
    (structure ShellTypes = ShellTypes_
     structure UserContext = UserContext_
     structure GuiUtils = GuiUtils_
     structure Capi = Capi_
     structure Map = BTree_
     structure UserOptions = UserOptions_
     structure Menus = Menus_
     structure Lists = Lists_);
