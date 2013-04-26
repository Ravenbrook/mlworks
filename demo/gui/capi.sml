(* === CAPI example ===
 * 
 * Copyright (C) 1998.  The Harlequin Group plc.  All rights reserved.
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
