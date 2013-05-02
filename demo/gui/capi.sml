(* === CAPI example ===
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
 * $Log: capi.sml,v $
 * Revision 1.2  1998/08/05 16:40:43  johnh
 * [Bug #30463]
 * Add make_form for use by guess demo.
 *
# Revision 1.1  1998/07/21  09:51:22  johnh
# new unit
# [Bug #30441]
# Part of an example of CAPI and projects.
#
 *)

signature CAPI = 
sig
  type Widget

  val initialize_application : string * string -> Widget
  val destroy : Widget -> unit

  val initialize_application_shell : Widget -> unit
  val initialize_toplevel : Widget -> unit

  val reveal : Widget -> unit
  val hide : Widget -> unit
  val to_front : Widget -> unit
  val set_label_string : Widget * string -> unit
  val parent : Widget -> Widget
  val widget_size : Widget -> int * int
  val widget_pos : Widget -> int * int
  val move_window : Widget * int * int -> unit
  val size_window : Widget * int * int -> unit
  val quit_loop : Widget -> unit

  val main_loop : unit -> unit

  (* Create a popup window with an ok button *)
  val send_message : Widget * string -> unit

  datatype WidgetAttribute =
      PanedMargin of bool
    | Position of    int * int
    | Size of        int * int
    | ReadOnly of    bool

  val make_window : string * Widget * WidgetAttribute list -> Widget * Widget

  val make_button : 
    {name: string,
     parent: Widget,
     attributes: WidgetAttribute list,
     sensitive: unit -> bool,
     action: unit -> unit} -> 
      Widget * (unit -> unit)

  val make_label : string * Widget * WidgetAttribute list -> Widget
  val make_subwindow : string * Widget * WidgetAttribute list -> Widget
  val make_text : string * Widget * WidgetAttribute list -> Widget

  datatype Callback = 
      Activate
    | Destroy
    | Unmap
    | Resize
    | ValueChange

  val add_callback : Widget * Callback * (unit -> unit) -> unit

  val get_text_string : Widget -> string
  val set_text_string : Widget * string -> unit

end
