(* MLWorks graphics demo *)

(* To use:
 *
 * make this file
 * > test (5,6) (* for example *)
 *
 * Press "x" to break out of event loop
 * Click in the window or press any key (apart from "x") for other happenings
 *)

require "$.motif.__xm";
local
  (* ix, iy are increments for moving dobbs image *)
  fun make_toplevel (ix, iy) = 
    let
      val name = "mlworks"
      and class = "MLWorks"
      and title = "test"

      (* Extent of drawing area *)
      and xextent = 700
      and yextent = 700

      val applicationShell = 
        Xm.initialize
        (name, class, [(Xm.TITLE, Xm.STRING title), (Xm.ICON_NAME, Xm.STRING title)]);
        
      val scroll = Xm.Widget.createManaged
        ("drawScroll", Xm.Widget.SCROLLED_WINDOW,applicationShell,[])
        
      val main =
        Xm.Widget.createManaged
        ("drawPane", Xm.Widget.DRAWING_AREA, scroll,[])
        
      val vscroll = Xm.Widget.createManaged
        ("drawVScroll", Xm.Widget.SCROLLBAR,scroll,
         [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.VERTICAL),
          (Xm.MAXIMUM, Xm.INT yextent)])
        
      val hscroll = Xm.Widget.createManaged
        ("drawHScroll", Xm.Widget.SCROLLBAR,scroll,
         [(Xm.ORIENTATION, Xm.ORIENTATION_VALUE Xm.HORIZONTAL),
          (Xm.MAXIMUM, Xm.INT xextent)])
        
      val _ = Xm.Widget.valuesSet
        (scroll,
         [(Xm.VERTICAL_SCROLLBAR,Xm.WIDGET vscroll),
          (Xm.HORIZONTAL_SCROLLBAR,Xm.WIDGET hscroll),
          (Xm.WORK_WINDOW,Xm.WIDGET main)])
        
      (* offset of start of window *)
      val xi_ref = ref 0
      val yi_ref = ref 0
        
      val _ = Xm.Widget.realize applicationShell
        
      fun env s = MLWorks.Internal.Value.cast (MLWorks.Internal.Runtime.environment s)
      val get_widget_resource : Xm.widget * string * string -> Xm.font = env "x get application resource"
        
      val myfont = get_widget_resource (applicationShell,"foo","Foo")
      val window= Xm.Widget.window main
      val display = Xm.Widget.display main
      val screen = Xm.Widget.screen main
      val pix1 = 
        let
          val pixmap = Xm.Pixmap.create (display,window,8,8,1)
          val gc1 = Xm.GC.create (display,pixmap,[Xm.GC.FONT myfont,
                                                  Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                  Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
          val gc2 = Xm.GC.create (display,pixmap,[Xm.GC.FONT myfont,
                                                  Xm.GC.FOREGROUND (Xm.Pixel.screenWhite screen),
                                                  Xm.GC.BACKGROUND (Xm.Pixel.screenBlack screen)])
          (* draw a pattern in the pixmap *)
          fun fill () =
            let
              fun aux1 8 = ()
                | aux1 i =
                let
                  fun aux2 8 = ()
                    | aux2 j =
                    (if (i+j) mod 3 = 0 then Xm.Draw.point (display,pixmap,gc1,i,j)
                     else Xm.Draw.point (display,pixmap,gc2,i,j);
                       aux2 (j+1))
                in
                  aux2 0;
                  aux1 (i+1)
                end
            in
              aux1 0
            end
        in
          fill ();
          (* ought to destroy gc1 and gc2 at this point *)
          pixmap
        end
      
      exception Size
      fun size widget =
        case Xm.Widget.valuesGet (widget,[Xm.WIDTH,Xm.HEIGHT]) of
          [Xm.INT width,Xm.INT height] => (width,height) 
        | _ => raise Size
            
      local
        val dobbs = Xm.Pixmap.get (screen,"minidobb.xbm",
                                   Xm.Pixel.screenBlack screen,Xm.Pixel.screenWhite screen)
          
        val dobbs_mask = Xm.Pixmap.get (screen,"minidobb-mask.xbm",
                                        Xm.Pixel.screenBlack screen,Xm.Pixel.screenWhite screen)
          
        val dobbs_mask_bitmap = Xm.Pixmap.create (display,window,64,75,1)
          
        val mask_gc = Xm.GC.create (display,dobbs_mask_bitmap,[Xm.GC.FONT myfont,
                                                               Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                               Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
          
        val _ = Xm.Draw.copyPlane (display,dobbs_mask,dobbs_mask_bitmap,mask_gc,0,0,64,75,0,0,1);
          
        val image_gc = Xm.GC.create (display,window,[Xm.GC.FONT myfont,
                                                     Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                     Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen),
                                                     Xm.GC.CLIP_MASK (Xm.GC.PIXMAP dobbs_mask_bitmap)])
      in
        fun draw_image (x,y) =
          let
            val xi = ~(!xi_ref)
            val yi = ~(!yi_ref)
          in
            Xm.GC.change (display,image_gc,
                          [Xm.GC.CLIP_X_ORIGIN (x+xi),
                           Xm.GC.CLIP_Y_ORIGIN (y+yi)]);
            Xm.Draw.copyArea (display,dobbs,window,image_gc,0,0,64,75,x+xi,y+yi)
          end
      end
    
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
                (coords := new_pos (main,!coords);
                 ignore (map (draw_image o #1) (rev (!coords)));
                 Xm.sync (display,false);
                 loop (n-1))
            in
              loop 100
            end
          
      local
        val gc1 = Xm.GC.create (display,window,[(* Xm.GC.FUNCTION Xm.GC.XOR, *)
                                                Xm.GC.FONT myfont,
                                                Xm.GC.LINE_WIDTH 20,
                                                Xm.GC.CAP_STYLE Xm.GC.CAP_ROUND,
                                                Xm.GC.JOIN_STYLE Xm.GC.JOIN_ROUND,
                                                Xm.GC.FILL_STYLE Xm.GC.FILL_STIPPLED,
                                                Xm.GC.STIPPLE pix1,
                                                Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
          
        val gc2 = Xm.GC.create (display,window,[Xm.GC.FONT myfont,
                                                Xm.GC.LINE_STYLE Xm.GC.LINE_ONOFF_DASH,
                                                Xm.GC.DASHES 7,
                                                Xm.GC.DASH_OFFSET 3,
                                                Xm.GC.CAP_STYLE Xm.GC.CAP_ROUND,
                                                Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
        val gc3 = Xm.GC.create (display,window,[Xm.GC.FONT myfont,
                                                Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                Xm.GC.BACKGROUND (Xm.Pixel.screenWhite screen)])
      in
        fun draw_picture () =
          let
            val xi = ~(!xi_ref)
            val yi = ~(!yi_ref)
            val (width,height) = (xextent,yextent)(* size main *)
            val x1 = 20
            val x2 = width - 20
            val y1 = 20
            val y2 = height - 20
            (* Change the GC here so we get the right offset for stippling *)
            val _ = Xm.GC.change (display,gc1,
                                  [Xm.GC.TS_X_ORIGIN xi,
                                   Xm.GC.TS_Y_ORIGIN yi])
          in
            Xm.Draw.point (display,window,gc3,100+xi,100+yi);
            Xm.Draw.points (display,window,gc3,[(350+xi,150+yi),(2,2),(2,2),(2,2),(2,2),(2,2),(2,2)],Xm.Draw.PREVIOUS);
            Xm.Draw.fillPolygon (display,window,gc1,[(40+xi,40+yi),(151+xi,167+yi),(199+xi,100+yi),(275+xi,232+yi)],Xm.Draw.COMPLEX,Xm.Draw.ORIGIN);
            Xm.Draw.segments (display,window,gc3,[(10+xi,320+yi,130+xi,440+yi),(140+xi,430+yi,20+xi,310+yi)]);
            Xm.Draw.fillRectangle (display,window,gc3,40+xi,280+yi,100,50);
            Xm.Draw.rectangle (display,window,gc3,20+xi,20+yi,200,150);
            Xm.Draw.rectangles (display,window,gc3,[(20+xi,40+yi,200,150),(22+xi,42+yi,200,150),(24+xi,44+yi,200,150)]);
            Xm.Draw.fillRectangles (display,window,gc3,[(140+xi,240+yi,100,50),(144+xi,244+yi,100,50),(148+xi,248+yi,100,50),(152+xi,252+yi,100,50)]);
            Xm.Draw.fillArc (display,window,gc1,280+xi,280+yi,140,130,0,64 * 360);
            Xm.Draw.arcs (display,window,gc3,[(280+xi,280+yi,140,130,0,64 * 360),(275+xi,285+yi,150,130,0,64 * 360),(270+xi,290+yi,160,130,0,64 * 360),(265+xi,295+yi,170,130,0,64 * 360)]);
            Xm.Draw.lines(display,window,gc1,[(x1+xi,y1+yi),(x1+xi,y2+yi),(x2+xi,y2+yi),(x2+xi,y1+yi),(y1+xi,x1+yi)],Xm.Draw.ORIGIN);
            Xm.Draw.line (display,window,gc2,x1+xi,y1+yi,x2+xi,y2+yi);
            Xm.Draw.line (display,window,gc2,x1+xi,y2+yi,x2+xi,y1+yi);
            Xm.Draw.imageString (display,window,gc1,20+xi,(height div 3)+yi,"Hello World");
            Xm.Draw.string (display,window,gc2,20+xi,2 * (height div 3)+yi,"Hello World");
            ignore (map (draw_image o #1) (rev (!coords)))
          end
        
        (* Scrolling *)
        (* These need to be a little careful about the way the copy area is done *)
        fun horizontal_scroll_callback data =
          let
            val new_xi = case Xm.Widget.valuesGet (hscroll,[Xm.VALUE]) of
			[Xm.INT x] => x
			| _ => raise Fail "new_xi"
            val (width,height) = size main
            val old_xi = !xi_ref
            val delta = old_xi-new_xi
          in
            xi_ref := new_xi;
            if delta > 0
              then Xm.Draw.copyArea (display,window,window,gc3,~delta,0,width+delta,height,0,0)
            else Xm.Draw.copyArea (display,window,window,gc3,0,0,width-delta,height,delta,0);
              draw_picture ()
          end

        fun vertical_scroll_callback data =
          let
            val new_yi = case Xm.Widget.valuesGet (vscroll,[Xm.VALUE]) of
				[Xm.INT y] => y
			| _ => raise Fail "new_yi"
            val (width,height) = size main
            val old_yi = !yi_ref
            val delta = old_yi-new_yi
          in
            yi_ref := new_yi;
            if delta > 0
              then Xm.Draw.copyArea (display,window,window,gc3,0,~delta,width,height+delta,0,0)
            else Xm.Draw.copyArea (display,window,window,gc3,0,0,width,height-delta,0,delta);
              draw_picture ()
          end
        
      end
    
      fun expose_callback data =
        draw_picture ()
        
      fun clearit _ =
        if Xm.Widget.isRealized main
          then Xm.Draw.clearArea (display,Xm.Widget.window main,0,0,0,0,true)
        else ()
          
      fun resize_callback data = clearit ()
        
      exception Halt
      
      fun input_callback data =
        let
          val (reason,event) = Xm.Callback.convertAny data
        in
          case event of
            Xm.Event.BUTTON_PRESS 
            (Xm.Event.BUTTON_EVENT {x,y,...}) => 
              (coords := ((x,y),(ix,iy)) :: !coords;
               draw_image (x,y))
          | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "x",...})) =>
             Xm.Widget.destroy applicationShell
          | (Xm.Event.KEY_PRESS _) =>
                bounce_dobbs ()
          | _ => ()
        end
    in

      Xm.Callback.add (main,Xm.Callback.EXPOSE,expose_callback);
      Xm.Callback.add (main,Xm.Callback.INPUT,input_callback);
      Xm.Callback.add (main,Xm.Callback.RESIZE,resize_callback);
      Xm.Callback.add (hscroll,Xm.Callback.VALUE_CHANGED,horizontal_scroll_callback);
      Xm.Callback.add (vscroll,Xm.Callback.VALUE_CHANGED,vertical_scroll_callback);
      Xm.Callback.add (hscroll,Xm.Callback.DRAG,horizontal_scroll_callback);
      Xm.Callback.add (vscroll,Xm.Callback.DRAG,vertical_scroll_callback)
    end;
    
in
  
  fun test data = make_toplevel data;
  fun runx () = Xm.mainLoop ();
  fun appl data = (test data; runx ())
    
end;



