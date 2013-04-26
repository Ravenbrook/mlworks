(*
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
 *  $Log: __graph_widget.sml,v $
 *  Revision 1.3  1995/10/14 21:19:09  brianm
 *  Adding GuiUtils_ dependency ...
 *
 * Revision 1.2  1995/08/02  12:40:22  matthew
 * Adding Menus
 *
 * Revision 1.1  1995/07/27  10:38:43  matthew
 * new unit
 * Moved from library
 *
 *  Revision 1.2  1995/07/26  14:25:12  matthew
 *  Restructuring directories
 *
 *  Revision 1.1  1995/07/20  14:25:16  matthew
 *  new unit
 *  New graph unit
 *
*)

require "../utils/__lists";
require "../winsys/__capi";
require "../winsys/__menus";
require "__gui_utils";

require "_graph_widget";

structure GraphWidget_ = GraphWidget (structure Lists = Lists_
                                      structure Capi = Capi_
                                      structure Menus = Menus_
                                      structure GuiUtils = GuiUtils_
                                        )
