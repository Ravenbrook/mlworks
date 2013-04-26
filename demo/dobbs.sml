(*  ==== Bouncing Dobbs demo  ====
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 * $Log: dobbs.sml,v $
 * Revision 1.3  1998/05/06 15:46:39  johnh
 * [Bug #30392]
 * Fix compiler warnings.
 *
 *  Revision 1.2  1997/07/15  14:41:21  brucem
 *  [Bug #30199]
 *  Changes of structure names.
 *  Removed spurious font value, set window size.
 *
 *  Revision 1.1  1996/08/16  11:35:20  johnh
 *  new unit
 *  Separated this demo from the man-demo.sml.
 *
 *)

require "$.motif.__xm";
require "$.basis.__array";

local

  fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)
  val sync_graphics_exposures : unit -> unit = env "x sync graphics exposures"
in
  fun max (x:int,y) = if x > y then x else y
  fun min (x:int,y) = if x < y then x else y

fun make_toplevel (ix, iy) = 
  let 
    val name = "mlworks"
    val class = "MLWorks"
   
    val dobbtitle = "Bouncing Dobbs"
    val applicationShell = 
      Xm.initialize (name, class, 
       [(Xm.TITLE, Xm.STRING dobbtitle), (Xm.ICON_NAME, Xm.STRING dobbtitle)]);

    val dobbmain = Xm.Widget.createManaged
      ("drawPanedobb", Xm.Widget.DRAWING_AREA, applicationShell,
        [(Xm.HEIGHT, Xm.INT 300), (Xm.WIDTH, Xm.INT 300)])

    val xi_ref = ref 0
    val yi_ref = ref 0
    val _ = Xm.Widget.realize applicationShell

    fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)
    val get_widget_resource : Xm.widget * string * string -> Xm.font = env "x get application resource"

    val window= Xm.Widget.window dobbmain
    val display = Xm.Widget.display dobbmain
    val screen = Xm.Widget.screen dobbmain

    val dobbs_path = "minidobb.xbm"
    val dobbs_mask_path = "minidobb-mask.xbm"
    exception Size
    fun size widget =
      case Xm.Widget.valuesGet (widget,[Xm.WIDTH,Xm.HEIGHT]) of
        [Xm.INT width,Xm.INT height] => (width,height) 
      | _ => raise Size

    val colormap = Xm.Colormap.default screen
    (* Handle color allocation failure here *)

    val (pixel1,pixel1',pixel2,pixel2',do_colors) =
        let
          val (_,pixels) = Xm.Colormap.allocColorCells (display,colormap,true,0,4)
          val pixel1 = Array.sub (pixels,0)
          val pixel1' = Array.sub (pixels,1)
          val pixel2 = Array.sub (pixels,2)
          val pixel2' = Array.sub (pixels,3)
          datatype Color = NAME of string | RGB of real * real * real
          val colors_ref = ref [RGB (1.0,1.0,0.0),NAME"slate grey",NAME "maroon",NAME "turquoise"]
          fun rot(a::b) = b @ [a]
            | rot x = x
          fun do_colors () =
            (case !colors_ref of
               [c1,c2,c3,c4] =>
                 let
                   fun do_color (pixel,NAME s) =
                     Xm.Colormap.storeNamedColor (display,colormap,pixel,s)
                     | do_color (pixel,RGB c) =
                       Xm.Colormap.storeColor (display,colormap,pixel,c);
                 in
                   colors_ref := rot (!colors_ref);
                   do_color (pixel1, c1);
                   do_color (pixel1',c2);
                   do_color (pixel2, c3);
                   do_color (pixel2',c4)
                 end
             | _ => ())
        in
          (pixel1,pixel1',pixel2,pixel2',do_colors)
        end
        handle Xm.XSystemError _ => 
           (Xm.Pixel.screenBlack screen,Xm.Pixel.screenWhite screen,
           Xm.Pixel.screenBlack screen,Xm.Pixel.screenWhite screen,
           fn _ => ())

    val dobbs1 = Xm.Pixmap.get (screen,dobbs_path,
                                pixel1,pixel1')
    val dobbs2 = Xm.Pixmap.get (screen,dobbs_path,
                                pixel2,pixel2')

    val dobbs_mask_bitmap = 
        let
          val dobbs_mask = Xm.Pixmap.get (screen,dobbs_mask_path,
                                          Xm.Pixel.screenBlack screen,Xm.Pixel.screenWhite screen)
          val dobbs_mask_bitmap = Xm.Pixmap.create (display,window,64,75,1)
          val mask_gc = Xm.GC.create (display,dobbs_mask_bitmap,[Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                                 Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
        in
          Xm.Draw.copyPlane (display,dobbs_mask,dobbs_mask_bitmap,mask_gc,0,0,64,75,0,0,1);
          Xm.GC.free (display,mask_gc);
          (* Xm.Pixmap.free (display,dobbs_mask); *)(* Pixmap.get is cached, so don't free it! *)
          dobbs_mask_bitmap
        end

    val image_gc = Xm.GC.create (display,window,[  Xm.GC.FOREGROUND pixel1,
                                                   Xm.GC.BACKGROUND pixel2,
                                                   Xm.GC.CLIP_MASK (Xm.GC.PIXMAP dobbs_mask_bitmap)])

    fun draw_image (xorigin,yorigin,w,h) (x,y) =
        let
          (* offset from origin *)
          val xi = ~(!xi_ref)
          val yi = ~(!yi_ref)
          (* Actual boundaries of box to draw *)
          val x1 = max (xorigin,x+xi)
          val y1 = max (yorigin,y+yi)
          val x2 = min (xorigin+w,x+xi+64)
          val y2 = min (yorigin+h,y+yi+75)
        in
          if x2 > x1 andalso y2 > y1
            then
              (Xm.GC.change (display,image_gc,
                             [Xm.GC.CLIP_X_ORIGIN (x+xi),
                              Xm.GC.CLIP_Y_ORIGIN (y+yi)]);
               Xm.Draw.copyArea (display,dobbs1,window,image_gc,x1-x-xi,y1-y-yi,x2-x1,y2-y1,x1,y1))
          else ()
        end

      fun draw_image_all (x,y) =
        let
          val xi = ~(!xi_ref)
          val yi = ~(!yi_ref)
        in
          Xm.GC.change (display,image_gc,
                        [Xm.GC.CLIP_X_ORIGIN (x+xi),
                         Xm.GC.CLIP_Y_ORIGIN (y+yi)]);
          Xm.Draw.copyArea (display,dobbs1,window,image_gc,0,0,64,75,x+xi,y+yi)
        end

      fun abs_draw_image (x,y) =
        (Xm.GC.change (display,image_gc,
                       [Xm.GC.CLIP_X_ORIGIN (x-32),
                        Xm.GC.CLIP_Y_ORIGIN (y-37)]);
         Xm.Draw.copyArea (display,dobbs2,window,image_gc,0,0,64,75,x-32,y-37))
        
    (* The bouncing dobbs feature *)

    fun new_pos (widget,coords) =
      let
        val (width,height) = size widget
        fun doone ((x,y),(ix,iy)) =
          let
            val x' = x + ix
            val y' = y + iy
            val ix = 
              if x' < 0 orelse x' > (width-64)
                then ~ix
              else ix
            val iy = 
              if y' < 0 orelse y' > (height-75)
                then ~iy
              else iy;
            val newx = x + ix
            val newy = y + iy
          in
            ((newx,newy),(ix,iy))
          end
      in
        map doone coords
      end

    val coords = ref [] : ((int * int) * (int * int)) list ref

    fun bounce_dobbs () =
      case !coords of
        [] => ()
      | _ => 
          let
            fun loop 0 = ()
              | loop n =
                (coords := new_pos (dobbmain,!coords);
                 ignore (map (draw_image_all o #1) (rev (!coords)));
                 Xm.sync (display,false);
                 loop (n-1))
          in
            loop 100
          end
      
(*    fun do_expose (Xm.Event.EXPOSE_EVENT {common,x,y,width,height,count}) =
      if count = 0 then draw_brot () else ()

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
*)
    fun clearit _ =
      if Xm.Widget.isRealized dobbmain
        then Xm.Draw.clearArea (display,Xm.Widget.window dobbmain,0,0,0,0,true)
      else ()

    fun resize_callback data = 
      clearit ()

    fun input_callback data =
      let
        val (reason,event) = Xm.Callback.convertAny data
      in
        case event of
          Xm.Event.BUTTON_PRESS 
          (Xm.Event.BUTTON_EVENT {x,y,...}) => 
            (coords := ((x-32,y-37),(ix,iy)) :: !coords;
             draw_image_all (x-32,y-37))
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "x",...})) =>
             Xm.Widget.destroy applicationShell
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "c",...})) =>
            (clearit (); coords := []) (*: ((int * int) * (int * int)) list ref*)
        | (Xm.Event.KEY_PRESS _) =>
            bounce_dobbs ()
        | _ => ()
      end
  in
(*    Xm.Event.addHandler (dobbmain,[Xm.Event.EXPOSURE_MASK],true,expose_handler);*)
    Xm.Callback.add (dobbmain,Xm.Callback.INPUT,input_callback)
  end;

end;
