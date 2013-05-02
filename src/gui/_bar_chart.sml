(*
 * Bar Chart Widget
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
 *  $Log: _bar_chart.sml,v $
 *  Revision 1.14  1997/09/18 14:52:23  brucem
 *  [Bug #30153]
 *  Remove references to Old.
 *
 * Revision 1.13  1997/05/06  09:09:29  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.12  1997/03/17  16:17:00  johnh
 * [Bug #1954]
 * Added a check to avoid an infinite loop which caused this bug.
 *
 * Revision 1.11  1996/11/06  13:25:33  andreww
 * [Bug #1711]
 * Real is not an equality type.
 *
 * Revision 1.10  1996/11/06  11:15:32  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.9  1996/10/09  11:53:12  io
 * moving String from toplevel
 *
 * Revision 1.8  1996/08/12  15:49:42  nickb
 * Change behaviour of the selected bar.
 * Note that some of this code is getting rather complex.
 *
 * Revision 1.7  1996/08/09  15:25:54  nickb
 * Option dialog setter functions now return accept/reject.
 *
 * Revision 1.6  1996/05/01  10:58:03  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.5  1996/04/30  10:03:18  matthew
 * Replacing MLWorks.Integer with basis file
 *
 * Revision 1.4  1996/04/18  10:22:03  matthew
 * Adding start/stop graphics functions
 *
 * Revision 1.3  1995/11/14  14:01:31  matthew
 * Changing the way input is done in graphics ports
 *
 *  Revision 1.2  1995/10/24  13:26:35  nickb
 *  Always draw some x-axis, and improve the y-axis for empty graphs.
 *
 *  Revision 1.1  1995/10/18  12:08:38  nickb
 *  new unit
 *  New bar chart widget.
 *
*)

require "../basis/__real";
require "../basis/__int";

require "capi";
require "menus";
require "bar_chart";
require "../utils/lists";
require "../utils/crash";

functor BarChart (structure Capi : CAPI
		  structure Menus : MENUS
		  structure Lists : LISTS
		  structure Crash : CRASH
		    sharing type Capi.Widget = Menus.Widget) : BAR_CHART =
  struct
    (* types *)


    type Widget = Capi.Widget

    datatype bar = Bar of
      {height: real,
       key: string,
       click_action: int -> unit}

    datatype chart_spec = ChartSpec of
      {maximum_bars : int,
       bar_width : int,
       maximum_tick_space : int,
       ideal_label_space : int}
      
    (* useful values *)

    local
      fun first_n' (a,0,_) = rev a
	| first_n' (a,n,[]) = rev a
	| first_n' (a,n,x::xs) = first_n' (x::a,n-1,xs)
    in
      fun first_n (n,l) = first_n' ([],n,l)
    end

    (* choosing ticks for the y axis *)
    (* the string is the label, the int is the number of pixels from zero *)
      
    datatype tick = Tick of string * int 
      
    local
      (* the tick mechanism works by scaling so that the maximum lies
       * between 1.0 and 10.0. We choose an axis maximum, then pick a
       * label interval according to the chart spec. The tick interval is
       * just a small integral fraction of the label interval *)

      val possible_axis_maxima = [(1.0,[0.1,0.2,0.25,0.5]), (* empty graph *)
				  (1.1,[0.1,0.55]),
				  (1.2,[0.1,0.2,0.3,0.4,0.6]),
				  (1.5,[0.1,0.25,0.3,0.5]),
				  (2.0,[0.2,0.4,0.5,1.0]),
				  (2.5,[0.5,1.25]),
				  (3.0,[0.2,0.25,0.5,0.75,1.0,1.5]),
				  (4.0,[0.4,0.5,0.8,1.0,2.0]),
				  (5.0,[0.5,1.0,1.25,2.5]),
				  (6.0,[0.5,1.0,1.5,2.0,3.0]),
				  (8.0,[0.5,1.0,2.0,4.0]),
				  (10.0,[0.5,1.0,1.25,2.0,2.5,5.0])]
      fun find_maximum x =
	let
	  fun this_max ((pair as (max,ls))::rest) =
	    if max >= x then pair
	    else this_max rest
	    | this_max [] = Crash.impossible "impossible maximum"
	in
	  this_max possible_axis_maxima
	end

      (* producing a label *)
      local
	fun scale_up (pre,[],0) = (rev pre)
	  | scale_up ([],post,0) = (#"0":: #"."::post)
	  | scale_up (pre,post,0) = ((rev pre)@(#"."::post))
	  | scale_up (pre,p::post,n) = scale_up(p::pre,post,n-1)
	  | scale_up (pre,[],n) = scale_up(#"0"::pre,[],n-1)
	    
	fun scale_down (pre,[],0) = (rev pre)
	  | scale_down ([],post,0) = (#"0":: #"."::post)
	  | scale_down (pre,post,0) = ((rev pre)@(#"."::post))
	  | scale_down (#"0"::pre,[],n) = scale_down (pre,[],n-1)
	  | scale_down (p::pre,post,n) = scale_down(pre,p::post,n-1)
	  | scale_down ([],post,n) = scale_down([], #"0"::post,n-1)
	fun scale_label (pre,post,n) =
	  if n < 0 then scale_down (pre,post,~n)
	  else scale_up (pre,post,n)
      in
	fun make_label (x,scale) =
	  let
	    (* 2-3 sig figs *)
	    val x100 = floor (x * 100.0 + 0.5)
	    val pre = rev (explode (Int.toString x100))
	  in
	    implode (scale_label (pre,[],scale-2))
	  end
      end
    
      (* identifying the scale *)
      fun find_scale (n,x,s) =
	if x > 1.0 then
	  if x <= 10.0 then (n,x,s)
	  else find_scale (n+1, x/10.0,s*10.0)
	else if Real.==(x,0.0) then (n,x,s)
	     else find_scale (n-1, x*10.0,s/10.0)
	  
    in
      fun ticks
	(ChartSpec {ideal_label_space,
		    maximum_tick_space,
		    ...})
	(maximum, pixels) = 
	let
	  val (scale,scaled_maximum,scaling) = find_scale(0,maximum,1.0)
	      
	  val (scaled_axis_maximum, possible_min_labels) =
	    find_maximum scaled_maximum

	  val scaled_pixel' = scaled_axis_maximum / (real pixels)

	  (* There is a check here to ensure that if scaled_pixel is negative, then
	   * it is set to 1.0 (arbitrary value) so that an infinite loop does
	   * not occur later (in find_ticks_per_pixel).  The value 1.0 is only 
	   * arbitrary because if scaled_pixel does happen to be negative then 
	   * there will be visible effect anyway. *)
	  val scaled_pixel = if scaled_pixel' < 0.0 then 1.0 else scaled_pixel'
	  val true_pixel = scaled_pixel * scaling
	  fun pixel x = floor (x/scaled_pixel)
	    
	  fun label_here x = Tick (make_label(x,scale), pixel x)
	  fun tick_here x = Tick ("",pixel x)
	    
	  (* find the label interval *)
	  val ideal_label = (real ideal_label_space) * scaled_pixel

	  fun best_label (y,x::xs) =
	    let
	      val old_prop = if y < ideal_label then ideal_label/y
			     else y/ideal_label
	      val new_prop = x/ideal_label
	    in
	      if old_prop > new_prop
		then best_label (x,xs)
	      else best_label (y,xs)
	    end
	    | best_label (lab,[]) = lab

	  val label_interval =
	    best_label (scaled_axis_maximum,possible_min_labels)

	  (* find the tick interval *)
	  val max_tick_interval = (real maximum_tick_space) * scaled_pixel
	    
	  fun find_ticks_per_label n =
	    let val tick_interval = label_interval / (real n)
	    in
	      if tick_interval < max_tick_interval then (n,tick_interval)
	      else find_ticks_per_label (n+1)
	    end
	  
	  val (ticks_per_label,tick_interval) = find_ticks_per_label 1
	    
	  (* make a complete list of the ticks *)
	  val fuzz = tick_interval/2.0
	  fun ticks_list (acc,cur,next_ab) =
	    if cur-fuzz > scaled_axis_maximum then acc
	    else
	      let
		val (tick,next_ab) =
		  case next_ab of
		    0 => (label_here cur,ticks_per_label-1)
		  | _ => (tick_here cur, next_ab-1)
	      in
		ticks_list (tick::acc,cur+tick_interval,next_ab)
	      end
	  in
	    (ticks_list ([],tick_interval,ticks_per_label-1), true_pixel) 
	  end
    end
  
    (* making a bar chart *)

    local

      (* constants, which possibly should be in the chart spec *)
      val lower_margin = 10
      val upper_margin = 10
      val left_margin = 10
      val right_margin = 10
      val extra_axis_length = 10
      val inter_bar_height = 3
      val tick_length = 5
      val tick_margin = 3

    in

      fun make (initial_chart_spec, set_chart_spec, bar_list_fn, parent) = 
	let
	  (* this ref holds information about the current bar chart *)
	  val chart_info = ref NONE

          (* this ref holds the chart spec *)
	  val chart_spec_ref = ref initial_chart_spec

          (* this ref holds the list of bars for the current chart *)
	  val (bar_list, initial_select) = bar_list_fn()
	  val bar_list_ref = ref bar_list
	  val selected_bar = ref initial_select

	  fun extent () =
	    case !chart_info of 
	      NONE => (300,300) (* dummy value *)
	    | SOME {width, height, ...} => (width, height)
		
	  fun make_chart_info (gp, chart_spec, bar_list) = 
	    let
	      val ChartSpec {maximum_bars, bar_width, ...} = chart_spec
	      val widget = Capi.GraphicsPorts.gp_widget gp
	      val (pane_width, pane_height) = Capi.widget_size widget
	      val bars_provided = length bar_list
	      val bars = if bars_provided > maximum_bars
			   then maximum_bars else bars_provided
	      val display_bars = first_n (bars,bar_list)
	      local
		fun maxfold (max,Bar{height,...}) =
		  if height > max then height else max
	      in
		val max_height = Lists.reducel maxfold (0.0,display_bars)
		val max_height = if Real.==(max_height,0.0) then 1.0
                                 else max_height
	      end
	      val (ticks,pixel) =
		ticks chart_spec (max_height,
				  pane_height - lower_margin - upper_margin)
	      fun extent (t as Tick (l,_)) =
		let val {width,font_descent,...} =
		  Capi.GraphicsPorts.text_extent (gp,l)
		in (width, font_descent,t)
		end
	      val ticks = map extent ticks
	      local
		fun maxfold (max, (width,_,_)) =
		  if width > max then width else max
	      in
		val max_label_width = Lists.reducel maxfold (0,ticks)
	      end
	      val axis_width =
		max_label_width + left_margin + tick_length + tick_margin
	      val width =
		axis_width + bars * bar_width +
		extra_axis_length + right_margin
	    in
	      {ticks = ticks,
	       pixel = pixel,
	       bars = display_bars,
	       axis_width = axis_width,
	       width = width,
	       height = pane_height}
	    end
	  
	  fun do_chart_info gp =
            Capi.GraphicsPorts.with_graphics gp
            (fn _ => chart_info := SOME (make_chart_info
                                                (gp,!chart_spec_ref,
						 !bar_list_ref)))
            ()

	  (* actually drawing the bars and y axis *)
	  local
	    fun draw_bar (gp, height, selected,
			  bar_left, bar_width, bar_height) =
	      ((if selected then Capi.GraphicsPorts.fill_rectangle
		else Capi.GraphicsPorts.draw_rectangle)
		  (gp, Capi.REGION {x=bar_left,
				    y= height-lower_margin-bar_height,
				    width = bar_width,
				    height = bar_height});
	       Capi.GraphicsPorts.draw_line
	       (gp, Capi.POINT {x=bar_left+bar_width, y = height-lower_margin},
		Capi.POINT {x=bar_left+bar_width,
			    y=height-lower_margin-inter_bar_height}))
		  
	    fun draw_axis (gp, ticks, pane_height, axis_width) =
	      let
		fun draw_tick (width,descent,Tick (label, height)) = 
		  let
		    val label_x =
		      axis_width - tick_length - tick_margin - width
		    val tick_y = pane_height-lower_margin-height
		    val label_y = tick_y + descent
		  in
		    Capi.GraphicsPorts.draw_image_string
		    (gp,label,Capi.POINT {x=label_x,y=label_y});
		    Capi.GraphicsPorts.draw_line
		    (gp,Capi.POINT {x=axis_width-tick_length, y=tick_y},
		     Capi.POINT {x=axis_width, y=tick_y})
		  end
	      in
		(Lists.iterate draw_tick ticks;
		 Capi.GraphicsPorts.draw_line
		 (gp,Capi.POINT {x=axis_width,y=upper_margin},
		  Capi.POINT {x=axis_width, y=pane_height-lower_margin}))
	      end
	  in
	    (* drawing some region *)
	    fun draw (gp,region) = 
	      case !chart_info of
		SOME {ticks, pixel, bars, width, height, axis_width} =>
		let
		  val Capi.REGION {x=region_x, width = region_width,...} =
		    region
		  val Capi.POINT{x=xi,...} = Capi.GraphicsPorts.get_offset gp
		  val region_left = xi+region_x
		  val region_right = region_left + region_width
		  val ChartSpec {bar_width,...} = !chart_spec_ref
		  fun draw_bars (bar_left,bar,[]) = 
		    Capi.GraphicsPorts.draw_line
		    (gp,Capi.POINT {x=bar_left, y=height-lower_margin},
		     Capi.POINT {x=bar_left+extra_axis_length,
				 y=height-lower_margin})
		    | draw_bars (bar_left,bar,
				 (Bar{height=bar_height,...}) ::bars) = 
		      if (bar_left > region_right) then ()
		      else 
			((if (bar_left+bar_width >= region_left) then
			    draw_bar (gp,height,bar = !selected_bar,bar_left,
				      bar_width, floor (bar_height/pixel))
			  else ());
		         draw_bars (bar_left+bar_width, bar+1, bars))
		in
		  Capi.GraphicsPorts.set_clip_region (gp,region);
		  (if region_left < axis_width
		     then draw_axis (gp,ticks, height, axis_width)
		   else ());
		  draw_bars (axis_width,0,bars);
		  Capi.GraphicsPorts.clear_clip_region gp
		end
	      | _ => ()
	  end
	
	  val (scroll_pane, gp, set_scrollbars, set_position) = 
	    Capi.GraphicsPorts.make_graphics
	    ("barChart", "bar chart", draw, extent, (true, false), parent)

	  fun resize _ = (do_chart_info gp;
			  set_scrollbars ())
		
	  fun update () = 
	    if Capi.GraphicsPorts.is_initialized gp then
	      let val (bar_list, selection) = bar_list_fn()
	      in
		(bar_list_ref := bar_list;
		 selected_bar := selection;
		 do_chart_info gp;
		 set_scrollbars ())
	      end
	    else
	      ()

	  (* the layout popup *)
	  local
	    (* there must be a better way than this *)
	    fun set_chart_spec (max_bars,bar_width,max_ticks,ideal_lab) =
	      chart_spec_ref := ChartSpec {maximum_bars = max_bars,
					   bar_width = bar_width,
					   maximum_tick_space = max_ticks,
					   ideal_label_space = ideal_lab}
	    fun get_chart_spec () = 
	      let val ChartSpec {maximum_bars, bar_width,
				 maximum_tick_space, ideal_label_space} =
		!chart_spec_ref
	      in (maximum_bars,bar_width,maximum_tick_space,ideal_label_space)
	      end

	    fun get_max_bars () =
	      let val ChartSpec {maximum_bars,...} = !chart_spec_ref
	      in maximum_bars
	      end
	    fun set_max_bars new_val = new_val > 0 andalso 
	      let val (_,bw,max_tick,ideal) = get_chart_spec()
	      in (set_chart_spec (new_val,bw,max_tick,ideal);
		  true)
	      end
	    
	    fun get_bar_width () =
	      let val ChartSpec {bar_width,...} = ! chart_spec_ref
	      in bar_width
	      end
	    fun set_bar_width new_val =
	      new_val > 1 andalso new_val < 500 andalso
	      let val (bars,_,max_tick,ideal) =get_chart_spec()
	      in (set_chart_spec (bars,new_val,max_tick,ideal);
		  true)
	      end
	    
	    fun get_max_tick () =
	      let val ChartSpec {maximum_tick_space,...} = ! chart_spec_ref
	      in maximum_tick_space
	      end
	    fun set_max_tick new_val =
	      new_val > 9 andalso new_val < 1000 andalso
	      let val (bars,bw,_,ideal) =get_chart_spec()
	      in (set_chart_spec (bars,bw,new_val,ideal);
		  true)
	      end

	    fun get_ideal_label () =
	      let val ChartSpec {ideal_label_space,...} = ! chart_spec_ref
	      in ideal_label_space
	      end
	    fun set_ideal_label new_val =
	      new_val > 9 andalso new_val < 1000 andalso
	      let val (bars,bw,max_tick,_) =get_chart_spec()
	      in (set_chart_spec (bars,bw,max_tick,new_val);
		  true)
	      end
	  in
	    val (popup_menu,_) =
	      Menus.create_dialog
	      (parent,
	       "Chart Layout Popup",
	       "chartLayoutPopup",
	       fn _ => (do_chart_info gp;
			set_scrollbars()),
	       [Menus.OPTINT ("maximumBars", get_max_bars, set_max_bars),
		Menus.OPTINT ("barWidth", get_bar_width, set_bar_width),
		Menus.OPTSEPARATOR,
		Menus.OPTINT ("maximumTickSpace",get_max_tick, set_max_tick),
		Menus.OPTINT ("idealLabelSpace", get_ideal_label,
			      set_ideal_label)])
	  end

	  fun popup () = 
	    (popup_menu ();
	     set_chart_spec (!chart_spec_ref))

	  (* what to do with a left click *)
	  fun do_press x =
	    case !chart_info of 
	      SOME {axis_width,bars,...} =>
		let
		  val ChartSpec {bar_width,...} = !chart_spec_ref
		  fun do_click_action (_,[]) = ()
		    | do_click_action (0,(Bar {click_action,...})::_) =
		      click_action (!selected_bar)
		    | do_click_action (n,_::bars) = do_click_action (n-1,bars)
		  val selected = (x-axis_width) div bar_width
		  val widget = Capi.GraphicsPorts.gp_widget gp
		  val (pane_width, pane_height) = Capi.widget_size widget
		in
		  if (x < axis_width) then ()
		  else
		    (selected_bar := selected;
		     Capi.GraphicsPorts.redisplay gp;
		     do_click_action (selected,bars))
		end
	    | _ => ()


	  (* all input handling *)
	  fun input_function (button,Capi.POINT{x,...}) =
            case button of
              Capi.Event.LEFT => do_press x
            | Capi.Event.RIGHT => popup ()
            | _ => ()

	  fun set_callbacks gp =
	    let val widget = Capi.GraphicsPorts.gp_widget gp
	    in
	      Capi.Callback.add (widget, Capi.Callback.Resize, resize);
	      Capi.GraphicsPorts.add_input_handler (gp, input_function)
	    end

	  fun initialize () = 
	    (Capi.GraphicsPorts.initialize_gp gp;
	     set_callbacks gp;
	     do_chart_info gp;
	     set_scrollbars ())
	in
	  {widget = scroll_pane,
	   initialize = initialize,
	   update = update,
	   popup = popup}
	end
    end
  end
