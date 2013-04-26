(*
 * Copyright (c) 1995 Harlequin Ltd.
 *  $Log: graph_widget.sml,v $
 *  Revision 1.16  1997/09/05 10:43:34  johnh
 *  [Bug #30241]
 *  Implement proper find dialog.
 *
 * Revision 1.15  1997/08/04  10:00:12  brucem
 * [Bug #30202]
 * Added comment explaining how to use function make,
 * Added search facility.
 *
 * Revision 1.14  1996/05/28  14:23:24  matthew
 * Adding parent_title parameter to make
 *
 * Revision 1.13  1996/05/07  11:33:46  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.12  1996/04/04  11:30:06  matthew
 * Changing interface ot allow monitoring of options
 *
 * Revision 1.11  1996/01/25  13:07:56  matthew
 * Adding highlighted flag to draw_item
 *
 * Revision 1.10  1995/10/15  13:43:45  brianm
 * Added Extent datatype and modified GraphWidget.make interface to
 * include modified item_draw and item_extent functions.
 *
 * Revision 1.9  1995/10/13  15:46:17  brianm
 * Update to button action interface ...
 *
 * Revision 1.8  1995/10/10  14:53:51  brianm
 * Modifications to selection/expansion protocol + changes to GraphSpec.
 *
 * Revision 1.7  1995/10/09  01:23:56  brianm
 * Slightly changing the graph selection repositioning interface.
 *
 * Revision 1.6  1995/10/06  12:31:46  brianm
 * Modifying make interface so that initialise takes the selection function
 * and added utilities for repositioning the graph selection.
 *
 * Revision 1.5  1995/10/05  13:46:54  brianm
 * Adding user-controlled graph positioning.
 *
 * Revision 1.4  1995/09/07  09:39:54  matthew
 * Extending GraphSpec type
 *
 * Revision 1.3  1995/09/06  13:55:37  matthew
 * General improvements
 *
 * Revision 1.2  1995/08/02  15:06:07  matthew
 * Changing interface to grapher
 *
 * Revision 1.1  1995/07/27  10:39:30  matthew
 * new unit
 * Moved from library
 *
 *  Revision 1.2  1995/07/26  13:19:25  matthew
 *  Adding name and title to make function
 *
 *  Revision 1.1  1995/07/20  16:16:34  matthew
 *  new unit
 *  New graph unit
 *
*)
signature GRAPH_WIDGET =
  sig
    type Point
    type Region
    type Widget
    type GraphicsPort

    (* NEXT = put the children next to the parent *)
    (* BELOW = put the children below the parent (like FileManager) *)
    datatype ChildPosition = NEXT | BELOW | CENTRE

    (* ALWAYS - always expand children (but never contract) *)
    (* TOGGLE - toggle between hidden/exposed               *)
    (* SOMETIMES(hfun) - parent-controlled exposure of children :-) *)
    datatype ChildExpansion = ALWAYS | TOGGLE | SOMETIMES of (bool -> bool)

    (* Horizontal = root on left hand side *)
    (* Vertical = root on top *)
    datatype Orientation = HORIZONTAL | VERTICAL

    datatype LineStyle = STRAIGHT | STEP

    datatype GraphSpec = 
      GRAPH_SPEC of 
      {child_position : ChildPosition ref,
       child_expansion : ChildExpansion ref,
       default_visibility : bool ref,
       show_root_children : bool ref,  (* expose root's children? *) 
       indicateHiddenChildren : bool ref,
       orientation : Orientation ref,
       line_style: LineStyle ref,
       horizontal_delta : int ref,
       vertical_delta : int ref,
       graph_origin : (int * int) ref,  (* origin for root and hence graph *) 
       show_all : bool ref}


    (* Extents:

       Graph node are presently rectangular regions - with origin located
       centrally.  This means that layout algorithms are neutral to the
       orientation HORIZONTAL or VERTICAL.  The dimensions of the region
       occupied by a graph node are represented as offsets from this point
       i.e. left, right, up, down.  These dimensions are collectively called
       an Extent.
    *)
    datatype Extent = EXTENT of { left : int, right : int, up : int, down : int } 


    (* `make' builds an instance of the graph widget *)
    (* Use:
           make name title parent_title parent graph_spec make_graph
                draw_item item_extent
          name : string
          title : string
          parent_title : string
          parent : widget
          graph_spec : GraphSpec  -- describes the style
          make_graph : () -> (nodes array , roots list) 
                       --  returns a pair of nodes and roots
          draw_item : (...) -> unit  -- a function to draw a node
          item_extend : (...) -> unit  -- a function to give the size of a node
       Returns:
           {widget, initialise, update, popup_menu, set_position,
            set_button_actions, initialiseSearch}
         widget : widget  -- the widget
         initialise : (... -> ... ) -> unit
                  -- takes a function to be executed when a node is selected
         update : (...) -> unit  -- redraws the graph
         popup_menu : unit -> unit 
               -- can be added to a menu to bring up the dialog box
         set_position : (...) -> (...)
         set_button_actions : (...) -> (...)
         initialiseSearch : (unit -> string) -> (string -> '_a -> bool) list
                            -> unit -> unit
               -- takes unit -> string getDefault function
                  two match functions - one for matching against whole words and
			the other for partial matches
                  returns a unit -> unit which can be put on menus
      *)
    val make : 
        string * string * string * Widget *
        GraphSpec * 
        (unit -> ('_a * int list) MLWorks.Internal.Array.array * int list) * 
        ('_a * bool * GraphicsPort * Point -> unit)  *
        ('_a * GraphicsPort -> Extent)
        ->
           {widget: Widget,
            initialize : ('_a * Region -> unit)  -> unit,
            update : unit -> unit,
            popup_menu : unit-> unit,
            set_position : Point -> unit,
            set_button_actions : {  left    : ((unit -> unit) * Point -> unit),
                                    right   : ((unit -> unit) * Point -> unit),
                                    middle  : ((unit -> unit) * Point -> unit)
                                 } -> unit,
            initialiseSearch :
             (unit -> string) ->
             ((string -> '_a -> bool) * (string -> '_a -> bool)) ->
             unit -> unit
           }


     (* Graph selection repositioning utility *)

     datatype Position  = NONE | TOP  | CENTER | BOTTOM | LEFT | RIGHT | ORIGIN

     val reposition_graph_selection :
         ( Widget * (Point -> unit) ) ->
           { reposition_fn : Region -> unit, (* Perform repositioning *)
             redisplay_fn  : unit -> unit,  (* redisplay in current position *)
             popup_fn      : Widget -> (unit -> unit),(* Popup menu *)
             v_position    : Position ref,  (* Vert. Position *)
             h_position    : Position ref,  (* Hori. Position *)
             v_offset      : int ref,  (* Vert. Offset   *)
             h_offset      : int ref      (* Hori. Offset   *)
           }
  end

