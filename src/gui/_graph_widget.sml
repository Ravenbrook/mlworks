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
 *  $Log: _graph_widget.sml,v $
 *  Revision 1.37  1999/03/23 18:05:40  johnh
 *  [Bug #190539]
 *  Fix problem centerOnNode.
 *
 * Revision 1.36  1999/02/02  15:59:16  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.35  1998/02/19  19:42:05  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.34  1997/09/05  10:44:38  johnh
 * [Bug #30241]
 * Implementing proper Find Dialog.
 *
 * Revision 1.33  1997/08/06  14:40:08  brucem
 * [Bug #30202]
 * Add functionality to generic graphs in order to improve compilation manager dependency graphs.
 * Also added search facility (this relates to bugs #30202 and #30224).
 *
 * Revision 1.32  1997/05/02  17:26:09  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.31  1996/08/09  15:25:41  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.30  1996/05/28  14:45:08  matthew
 * Attempting to give dialogs more meaningful names
 *
 * Revision 1.29  1996/05/28  11:59:16  daveb
 * Removed unused debugging code (that referenced MLWorks.RawIO).
 *
 * Revision 1.28  1996/05/28  10:51:18  matthew
 * Updating
 *
 * Revision 1.27  1996/05/24  15:58:11  daveb
 * Changed behaviour of click - clicking an unselected item selects it;
 * clicking a selected item expands or contracts it.
 *
 * Revision 1.26  1996/05/24  14:34:40  daveb
 * Graph menu changes.
 *
 * Revision 1.25  1996/05/07  11:35:06  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.24  1996/05/01  10:48:21  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.23  1996/04/18  10:05:09  matthew
 * Adding start/stop graphics functions
 *
 * Revision 1.22  1996/04/04  10:58:56  matthew
 * Changing interface ot allow monitoring of options
 *
 * Revision 1.21  1996/02/02  12:44:18  daveb
 * Changed update behaviour of layout dialog, as it wasn't updating properly
 * after selecting expand_all_nodes.
 *
 * Revision 1.20  1996/01/25  13:06:43  matthew
 * Adding hightlighted flag to draw_item
 *
 * Revision 1.19  1996/01/17  11:28:50  matthew
 * Sorting out some minor problems
 *
 * Revision 1.18  1995/11/22  13:54:52  matthew
 * Renaming some buttons
 *
 * Revision 1.17  1995/11/16  14:14:13  matthew
 * Fiddling with button names
 *
 * Revision 1.16  1995/11/13  15:23:25  matthew
 * Restructuring use of OPTRADIO
 *
 * Revision 1.15  1995/10/19  12:35:10  matthew
 * Removing debug message
 *
 * Revision 1.14  1995/10/15  13:58:24  brianm
 * Added Extent datatype and modified GraphWidget.make interface to
 * include modified item_draw and item_extent functions.
 *
 * Revision 1.13  1995/10/13  15:50:50  brianm
 * Update to button action interface ...
 *
 * Revision 1.11  1995/10/10  16:06:30  brianm
 * Modifications to selection/expansion protocol + changes to GraphSpec.
 *
 * Revision 1.10  1995/10/09  08:29:37  brianm
 * Changed the graph widget repositioning interface and add interface to
 * set the button action functions.
 *
 * Revision 1.9  1995/10/06  11:35:46  brianm
 * Modifying make interface so that initialise takes the selection function
 * and added utilities for repositioning the graph selection.
 *
 * Revision 1.8  1995/10/05  13:56:03  brianm
 * Adding user-controlled graph positioning.
 *
 * Revision 1.7  1995/09/21  16:03:59  nickb
 * Capi.make_scrolled_graphics changed to Capi.make_graphics
 *
 * Revision 1.6  1995/09/18  14:06:40  brianm
 * Updating by adding Capi Point/Region datatypes
 *
 * Revision 1.5  1995/09/07  11:42:45  matthew
 * More stuff
 *
 * Revision 1.4  1995/09/06  14:08:10  matthew
 * General improvements
 *
 * Revision 1.3  1995/08/02  16:12:31  matthew
 * Adding graph menu
 *
 * Revision 1.2  1995/07/27  10:57:03  matthew
 * Moved capi etc. to gui
 *
 * Revision 1.1  1995/07/27  10:39:07  matthew
 * new unit
 * Moved from library
 *
 *  Revision 1.2  1995/07/26  13:19:13  matthew
 *  Adding check on initialization of Graphics Ports
 *
 *  Revision 1.1  1995/07/21  13:54:44  matthew
 *  new unit
 *  New graph unit
 *
*)

require "../utils/lists";
require "gui_utils";
require "menus";
require "capi";
require "^.basis.__list";

require "graph_widget";

functor GraphWidget (structure Lists : LISTS
                     structure Menus : MENUS
                     structure Capi : CAPI
		     structure GuiUtils : GUI_UTILS

                     sharing type Menus.Widget = Capi.Widget
                     sharing type Menus.OptionSpec = GuiUtils.OptionSpec

                       ) : GRAPH_WIDGET =
  struct

    type Point = Capi.Point
    type Region = Capi.Region

    type Widget = Capi.Widget
    type GraphicsPort = Capi.GraphicsPorts.GraphicsPort

    (* utils *)
    fun ++ x = x := !x + 1;
    fun -- x = x := !x - 1;
    fun max (x:int,y:int) = if x > y then x else y
    fun min (x:int,y:int) = if x < y then x else y

    fun mk_pt(x,y) = Capi.POINT{x=x,y=y}
    fun mk_reg(x,y,wid,hgt) = Capi.REGION{x=x,y=y,width=wid,height=hgt}

    (* These should be parameters *)
    val left_margin = 0
    val right_margin = 10
    val top_margin = 0
    val bottom_margin = 10

    (* NEXT = put the children below and right of (right and down)
              from the parent *)
    (* BELOW = put the children below the parent (like FileManager) *)
    (* CENTRE = put the children below (right) and on both sides of parent *)
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
       show_root_children : bool ref ,  (* expose root's children? *)
       indicateHiddenChildren : bool ref, (* draw a dotted line
                                             if children are hidden *)
       orientation : Orientation ref,
       line_style: LineStyle ref,
       horizontal_delta : int ref,
       vertical_delta : int ref,
       graph_origin : (int * int) ref,  (* origin for root and hence graph *) 
       show_all : bool ref}

    datatype Extent =
         EXTENT of { left : int, right : int, up : int, down : int } 

    datatype 'a node =
      NODE of {node : 'a,
               id : int, (* not currently used,
                            but useful for unique identification *)
               hide_children : bool ref,
               children : int list,

               hidden : bool ref,
               level : int ref,
               parent_count : int ref, 
               layout_children : int list ref,
               child_offset : int ref,
               selected : bool ref,
               x : int ref,
               y : int ref,
               extent : Extent ref }
      
    fun node_node (NODE {node,...}) = node
      
    fun reset_node
           (NODE {level,hidden,layout_children,
                  parent_count,child_offset,...}) =
	      (hidden := true;
	       level := 0;
	       parent_count := 0;
	       layout_children := [];
	       child_offset := 0)

    val point_extent = EXTENT {up=0,down=0,left=0,right=0}

    fun make_nodes (invisible, nodelist) =
      MLWorks.Internal.ExtendedArray.map_index
      (fn (id,(node,children)) =>
       NODE {node = node,
             hide_children = ref invisible,
             hidden = ref true,
             id = id,
             level = ref 0,
             parent_count = ref 0,
             children = children,
             layout_children = ref [],
             child_offset = ref 0,
             selected = ref false,
             x = ref 0,
             y = ref 0,
             extent = ref point_extent}
      )
      nodelist

    (* This is called from layout_items *)
    (* Return: (nodes, root, get_layout_children) 
       The `nodes' which is returned is the same as the parameter! *)
    fun set_layout (nodes,roots,show_all) =
      let

        fun get_node id = MLWorks.Internal.Array.sub (nodes,id)

        fun set_levels nodes =
          let

            fun get_shown_children (NODE {children,hide_children,...}) =
              if not show_all andalso !hide_children then []
              else children

           (* Need to: *)
           (* reinitialize nodes - set hidden to true etc. *)
           (* eliminate cyclic arcs *)
           (* count the number of visible forward arcs going to each node *)
           (* calculate layout_children *)
           (* assign a level & layout children to each node *)
           (* level (root) = 0; *)
           (* level (node) = max {level (node') | 
                                  node in noncyclic_children (node')} + 1 *)
           (* or we could assign layout_parent to each node (except roots) *)
           (* then layout_children (node) =
                     {node' | layout_parent (node') = node} *)

           (* so, assume G is non-cyclic
              (can eliminate back arcs to get G, if necessary) *)
           (* assign level and layout_parent such that: *)
           (* level (node) = 1 + level (layout_parent node) *)
           (* if G (parent,child) then level parent < level child *)

            val seen = ref []

            fun scan id =
              let
                val (NODE {hidden,hide_children,children,...}) = get_node id
                val children = if not show_all andalso !hide_children
                               then [] else children
              in
                hidden := false;
                List.app
                (fn child_id =>
                 let
                   val child = get_node child_id
                   val NODE {parent_count,...} = child
                 in
                   ++parent_count
                 end)
                children;
                List.app
                (fn child_id =>
                 if Lists.member (child_id,!seen)
                   then ()
                 else
                   (seen := child_id :: !seen;
                    scan child_id))
                children
              end

            fun set_level ([],n) = ()
              | set_level (nodeset,n) =
                let
                  val nextnodes = ref []
                  fun do_node (node as NODE {layout_children,...})=
                    List.app
                    (fn child_id =>
                     let
                       val child_node as NODE {level,parent_count,...} =
                         get_node child_id
                     in
                       --parent_count;
                       if !parent_count = 0
                         then
                           (level := n;
                            layout_children := child_id :: !layout_children;
                            nextnodes := child_node :: !nextnodes)
                       else ()
                     end)
                    (get_shown_children node)
                in
                  List.app do_node nodeset;
                  set_level (!nextnodes,n+1)
                end

          in
            scan 0;
            set_level ( map get_node roots, 1)
          end (* of fun set_levels *)

        fun set_layout_children (NODE {children,layout_children,...}) =
          let
            fun unique_children children =
              let
                val result = ref []
              in
                List.app
                (fn id => if Lists.member (id,!result)
                          then ()
                          else result := id :: !result)
                children;
                rev (!result)
              end
          in
            layout_children := 
              List.filter 
                (fn id => Lists.member (id,!layout_children))
                (unique_children children)
          end

        fun get_layout_children (NODE {layout_children,...}) =
          map (fn id => MLWorks.Internal.Array.sub (nodes,id))
              (!layout_children)

        val root = MLWorks.Internal.ExtendedArray.sub
                     (nodes, (case roots of (h::t) => h | _ => 0))

      in
        set_levels nodes;

        (* Now put the layout children into "canonical" form *)
        MLWorks.Internal.ExtendedArray.iterate set_layout_children nodes;

        (nodes, root, get_layout_children)
      end (* of fun set_layout *)
    

    (***Layout utilities***)
    (* Note: where in doubt, assume left/right, up/down and x/y are
             for a HORIZONTAL graph (i.e. children go right of their
             parents).  The function transform_pair converts to the
             correct context.  *)

    (* This function lays out items according to their size *)
    (* This is called when the user application uses the `initialise' function
       supplied by `make'. *)
    fun layout_items (gp          (* Graphics port *),
                      nodes       (* From the user's make_graph *),
                      roots       (* From the user's make_graph *),
                      node_extent (* Given by the user *),
                      gspec       (* layout style *) ) =
      let

        datatype 'a Layout = LAYOUT of 'a             (* root *) *
                                       int            (* height in pxls *) *
                                       'a Layout list (* subtrees *)

        val {child_position = ref_child_position,
             child_expansion = ref_child_expansion,
             default_visibility = ref_default_visibility,
             show_root_children = ref_show_root_children,
             indicateHiddenChildren = ref_indicateHiddenChildren,
             orientation = ref_orientation,
             line_style = ref_line_style,
             horizontal_delta = ref_horizontal_delta,
             vertical_delta = ref_vertical_delta,
             graph_origin = ref_graph_origin,
             show_all = ref_show_all} = gspec
          
        val (left_margin,top_margin) = !ref_graph_origin

        val orientation = !ref_orientation
        val horizontal_delta = !ref_horizontal_delta
        val vertical_delta = !ref_vertical_delta

        val child_position = !ref_child_position
        val child_expansion = !ref_child_expansion
        val hide_root_children = not(!ref_show_root_children)
            
        fun transform_pair (HORIZONTAL,point) = point
          | transform_pair (VERTICAL,(x,y)) = (y,x)

	val (horizontal_delta,vertical_delta) =
            transform_pair (orientation,(horizontal_delta,vertical_delta))

        fun transform_extent (HORIZONTAL,extent) = extent
          | transform_extent (VERTICAL,EXTENT{left,right,up,down}) =
               EXTENT{left=up,right=down,up=left,down=right}

        fun transform_block (HORIZONTAL,extent) = extent
          | transform_block (VERTICAL,(left,right,up,down)) =
              (up,down,left,right)

        val (left_margin,right_margin,top_margin,bottom_margin) =
            transform_block(orientation,
                            (left_margin, right_margin,
                             top_margin, bottom_margin)
                            )

        (* reinitialize various slots *)
        val _ = 
          (MLWorks.Internal.ExtendedArray.iterate reset_node nodes;
           MLWorks.Internal.ExtendedArray.iterate 
           (fn (NODE {node,extent,...}) => 
            extent := node_extent (node,gp))
           nodes)

        val _ =
          let
            val NODE {hide_children,...} = MLWorks.Internal.Array.sub (nodes,0)
          in
            hide_children := (hide_root_children andalso !hide_children)
                             (* expose root's children?
			        - and once exposed, keep them exposed ...
                              *)
          end

        val (nodes,root,get_layout_children) =
          set_layout (nodes,roots,!ref_show_all)
          
        fun get_node_extent (NODE {extent, ...}) = 
          transform_extent (orientation,!extent)
          
        fun root_coords (x:int,y:int,left,right,up,down,th) =
          case child_position  of
            CENTRE =>
              (x+left,
               y + up + ((th - up - down) div 2))
          | NEXT => (x+left,y+up)
          | BELOW => (x+left,y+up)
             
        (* lays out children assuming root has position 0,0 *)
        fun layout (root as NODE {child_offset,...}) =
          let
            val children = get_layout_children root
            val EXTENT{left,right,up,down} = get_node_extent root
          in
            case children of
              [] => LAYOUT (root,up+down,[])
                   (* this is the return value of layout for a trivial tree *)
            | _ =>
                let
                  val subtrees = map layout children
                  fun get_children_height ([],acc) = acc
                    | get_children_height 
                        ([LAYOUT (node, totalh, subtrees)], acc) = 
                      totalh + acc
                    | get_children_height
                        (LAYOUT (node,totalh,subtrees)::rest,acc) = 
                      get_children_height (rest,totalh + vertical_delta + acc)
                  val root_height = up + down
                  val total_height = 
                    let 
                      val is_next = 
                        case child_position of
                          NEXT => true
                        | CENTRE => true
                        | BELOW => false
                    in
                      if is_next
                        then
                          let
                            val children_height = 
                              get_children_height (subtrees,0)
                          in
                            if root_height > children_height
                            then
                              (child_offset := 
                                 (root_height - children_height) div 2;
                               root_height)
                            else
                              children_height
                          end
                      else
                        root_height + vertical_delta + 
                        get_children_height (subtrees,0)
                    end
                in
                  LAYOUT (root,total_height,subtrees)
                end
          end (* of fun layout *)
        
        fun real_layout (x,y,LAYOUT (root,th,subtrees)) =
          (* x is the width so far of the tree *)
          (* y is the _top_ of the vertical space allocated *)
          let
            val NODE {x=x_ref,y=y_ref,child_offset,...} = root
            val EXTENT{left,right,up,down} = get_node_extent root

            fun dosubtrees ([],y) = ()
              | dosubtrees ((tree as LAYOUT (node,th,_))::rest,y) =
                let
                  val new_x = 
                    case child_position of 
                      NEXT => x+left+right+horizontal_delta
                    | CENTRE => x+left+right+horizontal_delta
                    | BELOW => x + horizontal_delta
                in
                  real_layout (new_x,y,tree);
                  dosubtrees (rest,y+th+vertical_delta)
                end

            val (root_x,root_y) = 
              transform_pair (orientation,root_coords
                               (x, y, left, right, up, down, th))

          in
            x_ref := root_x;
            y_ref := root_y;
            dosubtrees (subtrees,
                        case child_position of 
                          NEXT => y + !child_offset
                        | CENTRE => y + !child_offset
                        | BELOW => up + down + vertical_delta + y)
          end
        
        fun dimensions (layout as LAYOUT (node,th,subtrees)) =
          let
            val height = top_margin + th + bottom_margin
            fun get_width (LAYOUT (node,th,[])) = 
              let 
                val EXTENT{left,right,up,down} = get_node_extent node
              in
                left+right
              end
              | get_width (LAYOUT (node,th,subtrees)) =
                let
                  fun do_subtrees ([],max_width) = max_width
                    | do_subtrees (subtree::rest,max_width) =
                      let
                        val width = horizontal_delta + get_width subtree
                      in
                        do_subtrees (rest, if width > max_width 
                                           then width else max_width)
                      end
                  val width = do_subtrees (subtrees,0)
                  val EXTENT{left,right,up,down} = get_node_extent node
                in
                  case child_position of
                    NEXT => left+ right + width
                  | CENTRE => left+ right + width
                  | BELOW => width
                end
            val width = left_margin + get_width layout + right_margin
          in
            transform_pair ( orientation, (width, height) )
          end
        
        val layout = layout root
        val (x_width,y_height) = dimensions layout
      in
        real_layout (left_margin,top_margin,layout);
        (nodes,x_width+12,y_height+12)
         (* Completely arbitrary extra margin just in case graph overspills
            or previous calculations are wrong.  *)
      end (* of fun layout_items *)




    (* `make' builds an instance of the graph widget *)
    (* See the signature for an explanation of parameters and return values *)
    fun make (name, title, parent_title, widget, graph_spec,
              make_graph, draw_item, item_extent) =
      let
        val GRAPH_SPEC gspec = graph_spec
        val selected_node = ref NONE

        fun get_line_end
             (NODE {x,y,extent = ref (EXTENT{left,right,up,down}),...}) =
          case !(#orientation gspec) of
            HORIZONTAL => mk_pt(!x-left-1, !y + down - ((up+down) div 2))
          | VERTICAL =>   mk_pt(!x,        !y-up)

        fun get_line_start
            (NODE {x,y,extent=ref (EXTENT{left,right,up,down}),...},
             child_no,child_count) =
          let
            val is_next =
              case !(#child_position gspec) of
                NEXT => true
              | CENTRE => true
              | BELOW => false
          in
            if is_next
              then
                (case !(#orientation gspec) of
                   HORIZONTAL => mk_pt(!x,!y)
                 | VERTICAL =>
                     let
                       val x' = !x - left
                       val y' = !y+down
                     in
                       mk_pt(x'+ ((child_no + 1) *
                                  (left+right)) div
                             (child_count + 1), y')
                     end)
            else
                 mk_pt(!x-left+3, !y)
          end

        fun get_region
             (NODE {x,y,extent = ref (EXTENT{left,right,up,down}),...}) =
          let
            val width = left + right
            val height = up + down
          in 
	    case !(#orientation gspec) of
	      HORIZONTAL =>
                mk_reg(!x-left-1, !y + down - ((up+down) div 2), width, height)
	    | VERTICAL =>
                mk_reg(!x, !y-up, width, height)
          end

        fun draw_line (gp,p as Capi.POINT{x,y},p' as Capi.POINT{x=x',y=y'}) =
          case !(#line_style gspec) of
            STRAIGHT => 
              Capi.GraphicsPorts.draw_line (gp,p,p')
          | STEP => 
              (case !(#orientation gspec) of
                 HORIZONTAL =>
                   (Capi.GraphicsPorts.draw_line (gp,p,mk_pt(x,y'));
                    Capi.GraphicsPorts.draw_line (gp,mk_pt(x,y'),p'))
               | VERTICAL =>
                   (Capi.GraphicsPorts.draw_line (gp,p,mk_pt(x',y));
                    Capi.GraphicsPorts.draw_line (gp,mk_pt(x',y),mk_pt(x',y')))
              )
        
        fun drawDottedLine (gp, p, p') =
          (Capi.GraphicsPorts.setAttributes
            (gp,[Capi.GraphicsPorts.LINE_STYLE
                   Capi.GraphicsPorts.LINEONOFFDASH]);
           draw_line (gp, p, p');
           Capi.GraphicsPorts.setAttributes
            (gp,[Capi.GraphicsPorts.LINE_STYLE Capi.GraphicsPorts.LINESOLID])
          )

        fun child_invisibility() = not(!(#default_visibility gspec))

        (*  The extent of the drawing area *)
        val layout_info = ref NONE
        fun get_extent () = 
          case !layout_info of
            SOME (layout,width,height) =>
              (width,height)
          | _ => (100, 100) (* Arbitrary value, but this bit
                               of code is never actually used *)

        val (nodelist,roots) = make_graph ()
        val nodes_ref = ref (make_nodes (child_invisibility(),nodelist))
        val roots_ref = ref roots

        (* We access the dc for text extents, so require the wrapper *)
        fun do_layout gp =
          Capi.GraphicsPorts.with_graphics gp
          (fn _ =>
             layout_info := 
              SOME (layout_items (gp,!nodes_ref,!roots_ref,item_extent,gspec)))
          ()

        (* This function draws short dotted lines descending
           from a node to indicate that it has hidden children *)
        fun indicateHiddenChildren
              (gp, node as NODE {x, y,
                                 extent=ref(EXTENT{left, right, up, down}),
                                 children,  ...}) =
           let
             val numKids = List.length children
             val childNum = ref 0
             val (xBasic, yBasic) = 
                  if (!(#child_position gspec))<>BELOW
                  then
                     case !(#orientation gspec) of
                       HORIZONTAL =>
                         (!x+right+(!(#horizontal_delta gspec)),
                          !y - up - (!(#vertical_delta gspec)) div 2)
                     | VERTICAL =>
                        (!x -left-(!(#horizontal_delta gspec)) div 2,
                         !y + (!(#vertical_delta gspec)) div 2)
                  else (!x-left+3, !y)
             val (xRange, yRange) =
               case !(#orientation gspec) of
                 HORIZONTAL =>
                  (0,
                   (!(#vertical_delta gspec) + up + down) )
               | VERTICAL =>
                  ((left+right+(!(#horizontal_delta gspec))) ,
                   0)
           in
             while(!childNum < numKids) do 
              let
                val p = get_line_start (node, !childNum, numKids)
                val p' = mk_pt (xBasic + (((!childNum)+1)*xRange) div (numKids+1),
                                yBasic + (((!childNum)+1)*yRange) div (numKids+1))
              in
                drawDottedLine (gp, p, p');
                ++childNum
              end
           end

        (* This draws the graph *)
        fun draw_graph gp =
          case !layout_info of
            SOME (layout,width,height) =>
              let
                (* Draw the lines to a node's children *)
                fun do_node1 
                    (node as NODE {x, y,
                                   extent=ref(EXTENT{left, right, up, down}),
                                   hidden,hide_children,children,level,...}) =
                  if !hidden orelse 
                     (not (!(#show_all gspec)) andalso !hide_children)
                  then 
                     if not (!hidden) andalso
                        (!(#indicateHiddenChildren gspec)) andalso
                        (List.length children > 0)
                     then indicateHiddenChildren (gp, node)
                     else ()
                  else
                    let
                      val numKids = List.length children
                      val kidNum = ref 0
                    in
                      (* The lines are sorted left-right before 
                         plotting to prevent unsightly crossovers *)
                      (* For better results, sort by gradient (trickier
                         as the relative co-ordinate needs to be known --
                         rather than the absolute). *)
                      List.app
                        (fn p' => (* Draw the lines *)
                           let
                             val p = get_line_start (node, !kidNum, numKids)
                             val _ = ++ kidNum
                           in draw_line (gp, p, p') end )
                        (Lists.msort (* Sort left to right *)
                          (fn (Capi.POINT{x,y},Capi.POINT{x=x',y=y'}) =>
                            case !(#orientation gspec) of
                              VERTICAL => x<x'
                            | HORIZONTAL => y<y')
                          (List.mapPartial (* find points to draw to *)
                            (fn id => 
                               let
                                 val kid as NODE {level=level',...} =
                                   MLWorks.Internal.Array.sub (layout, id)
                                 val p' = get_line_end kid
                               in
                                 if (!level < !level') then (SOME p') else NONE
                               end)
                            children))
                    end

                (* Draw the node *)
                fun do_node2 (NODE {node,x,y,hidden,children,selected,...}) =
                  if !hidden then ()
                  else draw_item (node,!selected,gp,mk_pt(!x,!y))


              in
                MLWorks.Internal.ExtendedArray.iterate do_node1 layout;
                MLWorks.Internal.ExtendedArray.iterate do_node2 layout
              end
          | _ => ()

        (* This draws a bit of the graph (by clipping)
           it is called by Capi *)
        fun draw (gp,region) =
          (Capi.GraphicsPorts.set_clip_region (gp,region);
           draw_graph gp;
           Capi.GraphicsPorts.clear_clip_region gp)

        fun get_nodes () =
          case !layout_info of
            SOME (layout,_,_) => layout
          | _ => raise Div

        (* Set up the graphics port, supplying `draw' as the redraw function *)
        val (scroll,gp,set_scrollbars,set_position) = 
          Capi.GraphicsPorts.make_graphics
	  (name, title, draw, get_extent, (true, true), widget)

        fun centerOnNode (nodeId : int) : unit =
            let
              val _ = do_layout gp
              val NODE{x, y, ...} =
                MLWorks.Internal.Array.sub(!nodes_ref, nodeId)
              val (xSize, ySize) = Capi.widget_size scroll
              val (newX, newY) =
                    (!x - (xSize div 2), !y - (ySize div 2))
            in
              set_position (mk_pt(newX, newY));
              set_scrollbars()
            end (* of fun centerOnNode *)

        (* This is replaced when the calling routine initialises the graph *)
        val select_fn_hook = ref(fn (_) => ())

        (* This function is returned to the caller, it creates the graph
           and sets up the selection function *)
        fun initialize (select_fn) =
          (select_fn_hook := select_fn;
           Capi.GraphicsPorts.initialize_gp gp;
           centerOnNode ((fn (h::t) => h | _ => 0)(!roots_ref)))

        (* This returns boolean saying if children _need_ to be expanded *)
        fun test_expand_children ([],_) = false
          | test_expand_children (children,hide_children) =
	    if !(#show_all gspec) then false else
	    ( case !(#child_expansion gspec) of
		ALWAYS =>
		   if !hide_children
		   then ( hide_children := false;
			  true
			)
		   else false
	      | TOGGLE =>
		   let val hide = !hide_children
		   in
		     hide_children := not hide;
		     true
		   end
	      | SOMETIMES(hfun) =>
		   let val hide = !hide_children
		       val new_hide = hfun(hide)
		   in
		     hide_children := new_hide;
		     (hide <> new_hide)
		   end
	    )

        (* This is called when the user clicks on a node,
           it can pass a message to the calling function using the
           selection function *)
        fun do_select
              (thisnode as 
               NODE {node,hide_children,children,x,y,selected,...}) =
	    ( (!select_fn_hook) (node,get_region(thisnode));
                   (* `select_fn' may use point info to move gp etc.
		      Hence do `select_fn' first to ensure all updates are done
		      consistently. *)
	      let
                val draw_item' = Capi.GraphicsPorts.with_graphics gp draw_item 
		val old_x = !x
		val old_y = !y
		val Capi.POINT{x=ix,y=iy} = Capi.GraphicsPorts.get_offset gp
	      in
		if !selected then
		  if test_expand_children(children,hide_children) then
		    (do_layout gp;
		     Capi.GraphicsPorts.set_offset
                          (gp,mk_pt(ix + !x - old_x, iy + !y - old_y));
		     set_scrollbars ()
                    )
                  else
		    ()
		else
		  ( case !selected_node of
		      NONE => ()
		    | SOME (NODE {node,x,y,selected,...}) =>
		        ( selected := false; 
                          draw_item' (node,false,gp,mk_pt(!x,!y)) );
		    selected := true;
		    selected_node := SOME thisnode;
		    draw_item' (node,true,gp,mk_pt(!x,!y))
		  )
		  (* only bother doing this if the graph is
                     actually going to change *)
	      end
            )
        
        fun do_press (x,y) =
          let
            val nodes = get_nodes ()
            fun find 0 = ()
              | find n =
                let
                  val (node as NODE {hidden, 
                                     x = ref x',
                                     y = ref y',
                                     extent = ref
                                       (EXTENT{left,right,up,down}),...} ) =
                    MLWorks.Internal.Array.sub (nodes,n-1)
                in
                  if not (!hidden) andalso x >= x'-left andalso
                     x < x' + right andalso y >= y'-up andalso y < y' + down
                  then do_select node 
                  else find (n-1)
                end
          in
            find (MLWorks.Internal.Array.length nodes)
          end

        fun is_vertical _ = !(#orientation gspec) = VERTICAL
        fun set_vertical b = 
	  (#orientation gspec := (if b then VERTICAL else HORIZONTAL);
	   true)

        fun is_horizontal _ = !(#orientation gspec) = HORIZONTAL
        fun set_horizontal b =
	  (#orientation gspec := (if not b then VERTICAL else HORIZONTAL);
	   true)

        fun is_straight _ = !(#line_style gspec) = STRAIGHT
        fun set_straight b = 
	  (#line_style gspec := (if b then STRAIGHT else STEP);
	   true)

        fun is_step _ = !(#line_style gspec) = STEP
        fun set_step b = 
	  (#line_style gspec := (if not b then STRAIGHT else STEP);
	   true)

        fun is_next _ = !(#child_position gspec) = NEXT
        fun set_next b = 
	  ((if b then #child_position gspec := NEXT else ());
	   true)

        fun is_centre _ = !(#child_position gspec) = CENTRE
        fun set_centre b =
	  ((if b then #child_position gspec := CENTRE else ());
	   true)

        fun is_below _ = !(#child_position gspec) = BELOW
        fun set_below b = 
	  ((if b then #child_position gspec := BELOW else ());
	   true)

        fun is_show_all _ = !(#show_all gspec)

        fun update () = 
          if Capi.GraphicsPorts.is_initialized gp
            then
              let
                val _ = Capi.set_busy scroll
                val (nodelist, roots) = make_graph ()
              in
                nodes_ref := (make_nodes (child_invisibility (),nodelist));
                roots_ref := roots;
                selected_node := NONE;
                centerOnNode ((fn h::t => h | _ => 0)(!roots_ref));
                Capi.unset_busy scroll
              end
          else ()

        fun redraw_graph () = 
          if Capi.GraphicsPorts.is_initialized gp
            then
              (Capi.set_busy scroll;
               do_layout gp;
               set_scrollbars ();
               Capi.unset_busy scroll)
          else ()

        val (popup_menu,_) =
          Menus.create_dialog
          (widget,
           parent_title ^ ": Graph Layout",
           "graphLayoutMenu",
	   fn _ => redraw_graph (),
           [Menus.OPTLABEL "orientation",
            Menus.OPTRADIO [Menus.OPTTOGGLE
                              ("horizontal",is_horizontal,set_horizontal),
                            Menus.OPTTOGGLE
                              ("vertical",is_vertical,set_vertical)],
            Menus.OPTSEPARATOR,
            Menus.OPTLABEL "lineStyle",
            Menus.OPTRADIO [Menus.OPTTOGGLE ("step",is_step,set_step),
                            Menus.OPTTOGGLE
                              ("straight",is_straight,set_straight)],
            Menus.OPTSEPARATOR,
            Menus.OPTLABEL "childPosition",
            Menus.OPTRADIO [Menus.OPTTOGGLE ("below",is_below,set_below),
                            Menus.OPTTOGGLE ("centre",is_centre,set_centre),
                            Menus.OPTTOGGLE ("next",is_next,set_next)],
            Menus.OPTSEPARATOR,
            Menus.OPTTOGGLE ("indicate_hidden",
                             fn _ => !(#indicateHiddenChildren gspec),
                             fn b =>((#indicateHiddenChildren gspec) := b;
                                     true)),
            Menus.OPTSEPARATOR,
            Menus.OPTINT ("horizontalSpacing",
                          fn _ => !(#horizontal_delta gspec),
                          fn n =>
			  n > 0 andalso ((#horizontal_delta gspec) := n;
					 true)),
            Menus.OPTINT ("verticalSpacing",
                          fn _ => !(#vertical_delta gspec),
                          fn n => 
			  n > 0 andalso ((#vertical_delta gspec) := n;
					 true))
          ])

        (* Button action function hooks *)
        val left_button_action = ref (fn (pa,_) => pa ())
        val middle_button_action = ref (fn _ => ())
        val right_button_action = ref (fn _ => (* popup_menu *)())

        fun set_button_actions {left,middle,right} = 
	    ( left_button_action   := left;
	      middle_button_action := middle;
	      right_button_action  := right
	    )

        val input_x = ref 0
        val input_y = ref 0

        fun press_action () = do_press(!input_x,!input_y) 

        fun input_action (button,Capi.POINT {x,y}) =
          let
            val pt = mk_pt(x,y)
          in
            input_x := x;
            input_y := y;
            case button of
              Capi.Event.LEFT =>
                (!left_button_action)(press_action,pt)
            | Capi.Event.RIGHT =>
                (!right_button_action)(press_action,pt)
            | _ => 
                (!middle_button_action)(press_action,pt)
          end

	fun initialiseSearch getDefault (matchWhole, matchPart) = 
	  let
	    val nodeIndex = ref 0

	    fun startSearch () = 
                (* Hide all children *)
                MLWorks.Internal.ExtendedArray.iterate
                     (fn (NODE{hide_children,...}) => hide_children := true)
                     (!nodes_ref)

            (* The function which actually does the search *)
            fun search searchString miniSearchFn =
              let
                (* Traverse all below a node *)
                fun traverse n =
                  let
                     val (this as
                       NODE{node, children, hide_children, ...}) = 
                          MLWorks.Internal.Array.sub(!nodes_ref, n)
                     val iMatch = miniSearchFn searchString node
                  in
		    if iMatch then 
		      (do_select this;
		       centerOnNode n)
		    else ();
		    hide_children := false;
                    iMatch
                  end (* of fun traverse *)

		fun find_one n = 
		  if n = MLWorks.Internal.Array.length (!nodes_ref) then false
		  else
		    (nodeIndex := n+1;
		    if traverse n then true else find_one (n+1))

              in
		find_one (!nodeIndex) 
              end (* of fun search *)

	    fun doSearch {searchStr, wholeWord, matchCase, searchDown} = 
	      let val miniSearchFn = if wholeWord then matchWhole else matchPart
	      in
		if (search searchStr miniSearchFn) then 
		  redraw_graph()
		else
		  (nodeIndex := 0;
		   startSearch();
		   redraw_graph();
		   Capi.beep widget)
	      end

	     val find_dialog = 
		Capi.find_dialog (widget, doSearch, 
				  {findStr = "",
				   caseOpt = NONE,
				   wordOpt = SOME false,
				   downOpt = NONE})
	  in 
	    startSearch();
	    fn () => (ignore(find_dialog()); ())
							    
	  end  (* of initialiseSearch *)

      in
        Capi.GraphicsPorts.add_input_handler (gp,input_action);

        {widget=scroll,
         initialize=initialize,
         update=update,
         popup_menu=popup_menu,
         set_position=set_position,
         set_button_actions=set_button_actions,
         initialiseSearch=initialiseSearch
        }

      end (* of fun make *)


  datatype Position  = NONE | TOP  | CENTER | BOTTOM | LEFT | RIGHT | ORIGIN

  fun printpos(NONE) = "none"
    | printpos(TOP) = "top"
    | printpos(CENTER) = "centre"
    | printpos(BOTTOM) = "bottom"
    | printpos(LEFT) = "left"
    | printpos(RIGHT) = "right"
    | printpos(ORIGIN) = "origin"

 val toolbar_width = 15

  fun reposition_graph_selection (graph_window,set_position) =
    let
      val v_position = ref(NONE)
      val h_position = ref(NONE)

      val v_offset = ref(0)
      val h_offset = ref(0)

      fun is_none_vp ()      = (!v_position = NONE)
      fun is_top_vp ()       = (!v_position = TOP)
      fun is_center_vp ()    = (!v_position = CENTER)
      fun is_bottom_vp ()    = (!v_position = BOTTOM)

      fun set_none_vp (b)    = ((if b then v_position := NONE else ());
				true)
      fun set_top_vp (b)     = ((if b then v_position := TOP else ());
				true)
      fun set_center_vp (b)  = ((if b then v_position := CENTER else ());
				true)
      fun set_bottom_vp (b)  = ((if b then v_position := BOTTOM else ());
				true)

      fun is_none_hp ()      = (!h_position = NONE)
      fun is_left_hp ()      = (!h_position = LEFT)
      fun is_center_hp ()    = (!h_position = CENTER)
      fun is_right_hp ()     = (!h_position = RIGHT)
      fun is_origin_hp ()    = (!h_position = ORIGIN)

      fun set_none_hp (b)    = ((if b then h_position := NONE else ());
				true)
      fun set_left_hp (b)    = ((if b then h_position := LEFT else ());
				true)
      fun set_center_hp (b)  = ((if b then h_position := CENTER else ());
				true)
      fun set_right_hp (b)   = ((if b then h_position := RIGHT else ());
				true)
      fun set_origin_hp (b)  = ((if b then h_position := ORIGIN else ());
				true)

      val seln_posn_spec = 
        [Menus.OPTLABEL "verticalSelection",
         Menus.OPTSEPARATOR,
         Menus.OPTRADIO
         [Menus.OPTTOGGLE ("vnone"      ,  is_none_vp,    set_none_vp),
          Menus.OPTTOGGLE ("top"        ,  is_top_vp,     set_top_vp),
          Menus.OPTTOGGLE ("vcentre"     ,  is_center_vp,  set_center_vp),
          Menus.OPTTOGGLE ("bottom"     ,  is_bottom_vp,  set_bottom_vp)],
         Menus.OPTINT ("labelOffset",
                       fn _ => !v_offset,
                       fn n =>  n > 0 andalso (v_offset := n; true)),
         Menus.OPTSEPARATOR,
         Menus.OPTLABEL "horizontalSelection",
         Menus.OPTSEPARATOR,
         Menus.OPTRADIO
         [Menus.OPTTOGGLE ("hnone"     ,  is_none_hp,    set_none_hp),
          Menus.OPTTOGGLE ("horigin"   ,  is_origin_hp,  set_origin_hp),
          Menus.OPTTOGGLE ("left"     ,  is_left_hp,    set_left_hp),
          Menus.OPTTOGGLE ("hcentre"   ,  is_center_hp,  set_center_hp),
          Menus.OPTTOGGLE ("right"    ,  is_right_hp,   set_right_hp)],
          Menus.OPTINT ("labelOffset",
                       fn _ => !h_offset,
                       fn n => n > 0 andalso (h_offset := n; true))]

      (* Repositioning functions *)

      val lower_h = 10
      val lower_v = 10

      fun hnorm(n) = max (lower_h,n)
      fun vnorm(n) = max (lower_v,n)

      fun compute_h_posn (x,r_width,w_wid) =
	  case (!h_position) of
	    LEFT     =>
               let val left = !h_offset + lower_h
	       in
		   max(0, x - left)
	       end
	  | CENTER   =>
               let val left   = hnorm ((w_wid - r_width) div 2)
                   val new_x  = x - left
	       in
		   if new_x < 0
                   then max(0, x - (w_wid div 4))
                   else new_x
	       end
	  | RIGHT    =>
               let val left = hnorm (w_wid - (r_width + !h_offset))
                   val new_x  = x - left
	       in
		   max(0, new_x)
	       end
	  | ORIGIN  =>  0
	  | _ =>  ~1

      fun compute_v_posn (y,r_height,w_hgt) =
          let 
          in
	      case (!v_position) of
		TOP      =>
                  let val top = !v_offset + lower_v
                      val new_y = y - top
                  in
                      max(0, new_y)
                  end
	      | CENTER   =>
                  let val top = vnorm ((w_hgt - r_height) div 2)
                      val new_y = y - top
                  in
		      if new_y < 0
		      then max(0, y - (w_hgt div 4))
		      else new_y
                  end
	      | BOTTOM   => 
                  let val top = vnorm (w_hgt - (r_height + !v_offset))
                      val new_y = y - top
                  in
                      max(0, new_y)
                  end
	      | _ =>  ~1
          end

      fun reposition (region as
                      Capi.REGION{x,y,width=r_width,height=r_height}) =
	  let val (w_wid,w_hgt) = Capi.widget_size(graph_window)

              val w_wid  = w_wid  - toolbar_width
	      val w_hgt  = w_hgt  - toolbar_width

	      val new_x  = compute_h_posn(x,r_width,w_wid)
	      val new_y  = compute_v_posn(y,r_height,w_hgt)
	  in
	     set_position (mk_pt(new_x,new_y))

          end

      val last_region = ref(Capi.REGION{x=0,y=0,width=0,height=0})

      fun reposition_fn (region) = ( reposition(region); last_region := region)

      fun update_region () = reposition (!last_region)

      fun popup_fn (shell) =
          #1 (Menus.create_dialog
	      (shell, "Selection Position",
               "graphSelnPosnMenu",
               update_region, seln_posn_spec)
              )
    in
	{ reposition_fn=reposition_fn,
          redisplay_fn=update_region,
	  popup_fn = popup_fn,
	  h_position = h_position,
          v_position = v_position,
          h_offset = h_offset,
          v_offset = v_offset
	}
    end
  end

