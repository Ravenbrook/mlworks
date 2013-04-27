(*
 *  $Log: _sys_messages.sml,v $
 *  Revision 1.4  1998/02/17 18:11:28  johnh
 *  [Bug #30344]
 *  Allow windows to retain size and position.
 *
 *  Revision 1.3  1998/01/30  11:42:36  johnh
 *  [Bug #30071]
 *  Remove paths menu as part of Project Workspace changes.
 *
 *  Revision 1.2  1997/10/10  08:53:31  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
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

(* GUI stuff *)
require "capi";
require "menus";
require "gui_utils";
require "tooldata";

require "sys_messages";

functor SysMessages (
  structure Capi: CAPI
  structure ToolData : TOOL_DATA
  structure GuiUtils : GUI_UTILS
  structure Menus : MENUS
  
  sharing type GuiUtils.user_context = ToolData.ShellTypes.user_context
  sharing type Menus.Widget = ToolData.Widget = 
	       GuiUtils.Widget = Capi.Widget
  sharing type Menus.ButtonSpec = GuiUtils.ButtonSpec = ToolData.ButtonSpec
  sharing type GuiUtils.MotifContext = ToolData.MotifContext
): SYS_MESSAGES =

  struct
  
    type ToolData = ToolData.ToolData

    fun create
      (tooldata as ToolData.TOOLDATA
       {args,appdata,current_context,motif_context,tools}) =
      let
	val ToolData.APPLICATIONDATA {applicationShell,...} = appdata
	  
	val local_context = ref motif_context
	  
	fun get_current_user_context () =
	  GuiUtils.get_user_context (!local_context)
	  
	fun mk_tooldata () = tooldata

	val visible = ref false 

	val parent = applicationShell
        val (messagesShell, messFrame, messMenuBar, _) =
	  Capi.make_messages_popup (applicationShell, visible)

        val (messages_widget, messages)  = 
	  Capi.make_scrolled_text ("messages", messFrame, [])

	val buttonRC = Capi.make_managed_widget 
	  ("messagesRC", Capi.RowColumn, messFrame, [])

	fun clear_messages () = Capi.Text.set_string (messages, "")

	fun popup _ = 
	  (Capi.reveal messFrame;
	   Capi.to_front messagesShell; 
	   visible := true)

	fun popdown _ = 
	  (Capi.hide messagesShell; 
	   Capi.hide messFrame;
	   visible := false)

	val {update, ...} = 
	  Menus.make_buttons (buttonRC,
	    [Menus.PUSH ("clear_messages", clear_messages, fn _ => true),
	     Menus.PUSH ("close_messages", popdown, fn _ => true)])

	fun copy _ = 
	  Capi.clipboard_set (messages, Capi.Text.get_selection messages)

	val menuspec =
	  [ToolData.file_menu [("close", popdown, fn _ => true)],
	   ToolData.edit_menu (messFrame,
             {cut = NONE,
              paste = NONE,
              copy = SOME copy,
              delete = NONE,
	      edit_possible = fn _ => false,
              selection_made = fn _ => Capi.Text.get_selection messages <> "",
	      delete_all = SOME ("deleteAll", clear_messages, fn _ => true),
	      edit_source = []}),
	   ToolData.tools_menu (mk_tooldata, get_current_user_context),
	   ToolData.usage_menu ([], []),
	   ToolData.debug_menu []]

      in

	Capi.set_close_callback (messagesShell, popdown);
	Capi.set_message_widget messages;
	Menus.make_submenus (messMenuBar, menuspec);
	Capi.Layout.lay_out (messFrame, NONE,
	  [Capi.Layout.MENUBAR messMenuBar,
	   Capi.Layout.FLEX messages_widget, 
	   Capi.Layout.SPACE,
	   Capi.Layout.FIXED buttonRC]);
	popup

      end

  end;





