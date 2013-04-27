(*  ==== Mandelbrot demo  ====
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
 * $Log: motif:man-demo.sml,v 
 *  Revision 1.1  1996/10/03  14:46:03  john
 *  new uni
 *  Regorganising directory structure
 *
 *  Revision 1.8  1996/10/01  12:49:56  matthew
 *  Improving
 *
 *  Revision 1.7  1996/09/30  11:00:23  matthew
 *  Fixing problem with creation of gc1 -- needs to have main as drawable.
 *
 *  Revision 1.6  1996/08/20  09:58:24  johnh
 *  Added header.
 *
 *)

require "$.motif.__xm.sml";
require "$.basis.__array.sml";


(* Computation of the mandelbrot function itself *)
local
  (* For reference, a simple version *)
  fun julia (zreal,zim,creal,cim,max_iterations) =
    let
      fun loop (0,zim,zreal) = 0
        | loop (n,zim,zreal) =
          let
            val t1 = zreal * zreal
            val t2 = zim * zim
          in
            if t1 + t2 >= 4.0
              then n
            else
              let
                val zim = zim * zreal
                val zim = zim + zim + cim
                val zreal = creal + t1 - t2
              in
                loop (n-1,zim,zreal)
              end

          end
    in
      max_iterations - loop (max_iterations,zim,zreal)
    end
in
  fun mandel1 ((creal, cim), max_iterations) =
    julia (creal, cim, creal, cim, max_iterations-1)
end


(* complicated fast version *)
local
  val limit = 8.0
  val l_2 = limit*limit
  val l_4 = l_2 * l_2
  val l_8 = l_4 * l_4
  val l_16 = l_8 * l_8
  val l_32 = l_16 * l_16
  val l_64 = l_32 * l_32
  val l_128 = l_64 * l_64

  fun mandel_correct r =
    if r >= l_16 then
      if r >= l_64 then
        if r >= l_128 then 7 else 6
      else
        if r >= l_32 then 5 else 4
    else
      if r >= l_4 then
        if r >= l_8 then 3 else 2
      else
        if r >= l_2 then 1 else 0

  fun fast_mand (levels,re,im) =
    let
      val ci = im
      val cr = re
      fun fast_mand_loop (x,y,iters) = 
	let
	  (* unboxed local values *)
	  val ci = ci+0.0
	  val cr = cr+0.0

	  (* seven iterations in which we do not test the bound *)
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr
	  val f = x*y val g = x+y val x = x-y val y = f+f val x = x*g
	  val y = y+ci val x = x+cr

	  (* then one in which we do *)
          val f = x*x val g = y*y val e = f+cr val f = f+g val y = y*x
          val x = e-g val y = y+y+ci

	  val iters = iters-8
	in
	  if f < limit then
	    if iters > 0 then fast_mand_loop(x,y,iters)
	    else 0
	  else iters+(mandel_correct f)
	end
    in
      fast_mand_loop(0.0,0.0,levels)
    end
  
in
  fun mandel2 ((re,im),levels) =
    fast_mand(levels,re,im)
end

  fun man () =
  let
    val name = "mlworks"
    val class = "MLWorks"
        
    val title = "Mandelbrot"

    (* Use default size here *)
    val applicationShell =
      Xm.initialize
      (name, class,
       [(Xm.TITLE, Xm.STRING title),
        (Xm.ICON_NAME, Xm.STRING title)]);

    val main = Xm.Widget.createManaged ("drawPane", 
                                        Xm.Widget.DRAWING_AREA, 
                                        applicationShell,
                                        [])

    (* Associate a window with main *)
    val _ = Xm.Widget.realize applicationShell

    val window= Xm.Widget.window main
    val display = Xm.Widget.display main
    val screen = Xm.Widget.screen main

    exception Size (* Should never be raised *)
    fun size widget =
      case Xm.Widget.valuesGet (widget,[Xm.WIDTH,Xm.HEIGHT]) of
        [Xm.INT width,Xm.INT height] => (width,height) 
      | _ => raise Size

    (* Color allocation *)
    val colormap = Xm.Colormap.default screen

    val num_colors = 4
    val num_shades = 16
    val total_colors = num_colors * num_shades
    datatype Color = RGB of real * real * real
    val main_colors = Array.fromList[RGB (0.0,0.0,1.0),
                                     RGB (0.0,1.0,0.0),
                                     RGB (1.0,0.0,0.0),
                                     RGB (1.0,1.0,0.0)]

    val mono = ref false

    val (pixels,rotate_colors) =
      let
        val (_,pixels) = Xm.Colormap.allocColorCells (display,colormap,true,0,total_colors)
        val colors = Array.array (total_colors,RGB (0.0,0.0,0.0))
        fun make_shade (RGB (r,g,b),shade,num_shades) =
          if num_shades = 1 then RGB (r,g,b)
          else
            let
              val i = (real (num_shades - 1 - shade)) / (real (num_shades - 1));
              val r' = i*r
              val g' = i*g
              val b' = i*b
            in
              RGB (r',g',b')
            end
        fun clamp i = if i < 0 then total_colors - 1 else if i >= total_colors then 0 else i
        fun init_colors (col,shade,i) =
          if col >= num_colors then ()
          else
            if shade >= num_shades then init_colors (col+1,0,i)
            else 
              (Array.update (colors,i,make_shade (Array.sub (main_colors,col),
                                                  shade,
                                                  num_shades));
               init_colors (col,shade+1,clamp (i+1)))
        fun set_colors (count,i) =
            if count = total_colors
              then ()
            else
              let
                fun do_color (pixel,RGB c) =
                  Xm.Colormap.storeColor (display,colormap,pixel,c);
              in
                do_color (Array.sub (pixels,count),Array.sub(colors,i));
                set_colors (count+1,(i+1) mod total_colors)
              end
        val i = ref 0
        fun rotate_colors inc =
          (i := clamp (!i + inc); 
           set_colors (0,!i))
      in
        init_colors(0,0,0);
        set_colors(0,!i);
        (pixels,rotate_colors)
      end
    (* Get this error if we couldn't allocate all the colors *)
    handle Xm.XSystemError _ => 
      (mono := true;
       (Array.tabulate (total_colors,
                       fn i => if i mod 2 = 0 then Xm.Pixel.screenBlack screen
                               else Xm.Pixel.screenWhite screen),
        fn _ => ()))
      
    val gc_array = Array.tabulate (total_colors,
                                   fn i =>
                                   Xm.GC.create (display,window,
                                                 [Xm.GC.FOREGROUND (Array.sub (pixels,i))]))

    (* initial x,y and width *)
    val region = ref (0.0,0.0,0.0)
    val region_stack = ref []

    val start_values = (~2.5,~1.5,4.0)
    val _ = region := start_values

    fun draw_brot () =
        let
          val (w,h) = size main
          val (regx,regy,regw) = !region
          val scale = regw / (real w)
          (* window coord to complex *)
          fun to_complex (x,y) =
            ((scale * real x) + regx, (scale * real y)  + regy)
          fun pixel_to_gc n = Array.sub (gc_array,n mod total_colors);
          fun plot_point (x:int,y:int) =
            Xm.Draw.point (display,window,
                           pixel_to_gc (mandel2 (to_complex (x,y),100)),
                           x,y)

          (* aux1 and aux2 functions draw the image *)
          (* * column by column then row by row. *)
          fun aux1 x =
            if x = w then ()
            else
              let
                fun aux2 y =
                  if y = h then ()
                  else
                    (plot_point (x,y);
                     aux2 (y+1))
              in
                aux2 0;
                aux1 (x+1)
              end
        in
          aux1 0
        end          

    fun do_expose (Xm.Event.EXPOSE_EVENT {common,x,y,width,height,count}) =
      if count = 0 then  (* Only draw if this is the last notification *)
        draw_brot ()
      else ()

    fun expose_handler data =
      let
        val event = Xm.Event.convertEvent data
      in
        case event of
          Xm.Event.EXPOSE expose_event => do_expose expose_event
        | Xm.Event.GRAPHICS_EXPOSE expose_event => do_expose expose_event
        (* Could be a NoExpose event *)
        | _ => ()
      end

    fun clearit _ =
      Xm.Draw.clearArea (display,window,0,0,0,0,true)

    fun resize_callback data = 
      clearit ()

    (* Draw the zooming rectangle *)
    val gc1 = Xm.GC.create (display,window,
                            [Xm.GC.FUNCTION Xm.GC.INVERT])

    (* Coords for initial mouse press *)
    val press_coords = ref (0,0);

    (* Coords of current rectangle *)
    val clear = ref false
    val rect_coords = ref (0,0,0,0)

    (* Is there a previously drawn rectangle which needs to be deleted before *)
    (* drawing the next rectangle? *)
    fun maybe_clear_rec _ = 
      if !clear then 
        let
          val (rx1,ry1,rx2,ry2) = !rect_coords
        in
          Xm.Draw.rectangle (display,window,gc1,rx1,ry1,rx2,ry2); 
          clear := false
        end
      else ();

    (* In order for the rectangle to be drawn properly, the top left coordinates *)
    (* are given first, so a comparison is made between the coordinates to find  *)
    (* the top left pair. *)

    fun minmax (a,b) = if a<b then (a,b) else (b,a)

    fun correct_xy_values (x1,y1,x2,y2) = 
      (*  exercise for reader: express this more compactly *)
      (* x1, y1 is the initial position *)
      let 
        val (w,h) = size main
      in
        if (real (abs (x1 - x2)) * real h) / (real (abs (y1 -y2)) * real w) > 1.0
          then
            let
              val (ax,bx) = minmax (x1,x2)
              val (ay,by) = 
                if y1 < y2
                  then
                    let
                      (* proportion the rectangle as the window is *)
                      val by = y1 + floor (real h *  real (bx - ax) / real w)
                    in
                      (y1,by)
                    end
                else
                  let
                    val ay = y1 - floor (real h * real (bx - ax) / real w)
                  in
                    (ay,y1)
                  end
            in
              (ax,ay,bx,by)
            end
        else
          let        
              val (ay,by) = minmax (y1,y2)
              val (ax,bx) = 
                if x1 < x2
                  then
                    let
                      (* proportion the rectangle as the window is *)
                      val bx = x1 + floor (real w *  real (by - ay) / real h)
                    in
                      (x1,bx)
                    end
                else
                  let
                    val ax = x1 - floor (real w * real (by - ay) / real h)
                  in
                    (ax,x1)
                  end
          in
              (ax,ay,bx,by)
            end
      end
    fun motion_handler data = 
      case Xm.Event.convertEvent data of
          Xm.Event.MOTION_NOTIFY (Xm.Event.MOTION_EVENT {x,y,...}) =>
            let 
              val _ = maybe_clear_rec ()
              val (x1,y1) = !press_coords
              val (ax,ay,bx,by) = correct_xy_values (x1,y1,x,y)
            in
              Xm.Draw.rectangle (display,window,gc1,ax,ay,bx - ax,by - ay);
              rect_coords := (ax,ay,bx - ax,by - ay);
              clear := true
            end
        | _ => ()

    fun input_callback data =
      let
        val (reason,event) = Xm.Callback.convertAny data
      in
        case event of
          Xm.Event.BUTTON_PRESS 
          (Xm.Event.BUTTON_EVENT {x,y,...}) => 
            press_coords := (x,y)
        | (Xm.Event.BUTTON_RELEASE (Xm.Event.BUTTON_EVENT {x,y,...})) =>
            let 
              val (x1,y1) = !press_coords
              val (ax,ay,bx,by) = correct_xy_values (x1,y1,x,y);
              val (w,h) = size main
              val (regx,regy,regw) = !region
              val scale = regw / real w
              val newx = regx + scale * real ax
              val newy = regy + scale * real ay
              val neww = scale * real (bx - ax)
            in
              maybe_clear_rec();
              region_stack := !region :: !region_stack;
              region := (newx,newy,neww);
              clearit()
            end
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "x",...})) =>
            (if (!mono) then () else 
		Xm.Colormap.freeColors (display,colormap,pixels,0);
             Xm.Widget.destroy applicationShell)
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "r",...})) =>
            rotate_colors 1 
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "t",...})) =>
            rotate_colors ~1 
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "b",...})) =>
            (case !region_stack of
               reg :: rest =>
                 (region := reg;
                  region_stack := rest;
                  clearit())
             | _ => ())
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "c",...})) =>
            (region := start_values;
             region_stack := [];
             clearit ())
        | _ => ()
      end
  in
    Xm.Event.addHandler (main,[Xm.Event.EXPOSURE_MASK],true,expose_handler);
    Xm.Event.addHandler (main,[Xm.Event.BUTTON_MOTION_MASK],true,motion_handler);
    Xm.Callback.add (main,Xm.Callback.INPUT,input_callback)
  end;

  fun man_test () = (man ())
  fun man_runx () = Xm.mainLoop ();
  fun man_appl () = (man_test (); man_runx ());

