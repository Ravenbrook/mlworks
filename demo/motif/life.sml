(*  ==== Life demo  ====
 *
 *  Copyright (C) 1997  The Harlequin Group Limited.   All rights reserved.
 *
 * $Log: life.sml,v $
 * Revision 1.7  1998/11/09 11:44:44  johnh
 * [Bug #50105]
 * Make toplevel functions unique across demos to avoid conflicts when loading demo project.
 *
 *  Revision 1.6  1997/06/16  11:14:12  jkbrook
 *  [Bug #30127]
 *  Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.5  1997/05/09  08:52:33  daveb
 *  [Bug #20010]
 *  Ensured that single key presses are ignored when !runit = true.
 *
 *  Revision 1.4  1997/04/07  15:07:50  stephenb
 *  <URI:spring://ML_Notebook/Review/demo/motif/life.sml>
 *
 *  Revision 1.3  1997/01/06  14:59:19  matthew
 *  Various improvements
 *
 *  Revision 1.2  1996/11/05  17:19:56  jkbrook
 *  [Bug #1733]
 *  Removing references to redundant structure Xm_
 *
 *  Revision 1.1  1996/10/11  14:01:44  johnh
 *  new unit
 *  Reorganised demo directory to include separate demos for mswindows and motif.
 *
 *
 *)

require "forms";
require "$.motif.__xm";
require "$.basis.__array";

local

  type generation = {cells : int array array, columns: int, rows: int}

  type life_state = generation * generation

  val blockSize = 8  (* in pixels *)
    
  fun newVal ({cells, columns, rows}, i, j) : int =
    let
      val lix = if j = 0 then rows-1 else j-1
      val mix = j
      val rix = if j = rows-1 then 0 else j+1
      val topRow = Array.sub (cells, if i=0 then columns-1 else i-1)
      val midRow = Array.sub (cells, i)
      val bottomRow = Array.sub (cells, if i = columns-1 then 0 else i+1)
      val count =
        Array.sub (topRow, lix) +
        Array.sub (topRow, mix) +
        Array.sub (topRow, rix) +
        Array.sub (midRow, lix) +
        Array.sub (midRow, rix) +
        Array.sub (bottomRow, lix) +
        Array.sub (bottomRow, mix) +
        Array.sub (bottomRow, rix)
    in
      case count of
        2 => Array.sub (midRow, mix)
      | 3 => 1
      | _ => 0
    end
  
  fun update ({cells, columns, rows}, x, y, value:int) =
    Array.update (Array.sub (cells, x mod columns), y mod rows, value)
    
  fun new (inGen, x, y, outGen) =
    update (outGen, x, y, newVal (inGen, x, y))
  

  fun cleanGen {cells, columns, rows} =
    let
      fun cleanColumn i =
        if i = columns
          then ()
        else
          let
            val suba = Array.sub (cells, i)
            fun cleanRow j =
              if j = rows then
                ()
              else 
                (Array.update (suba, j, 0);
                 cleanRow (j+1))
          in
            cleanRow 0;
            cleanColumn (i+1)
          end
    in
      cleanColumn 0
    end

  
  fun nextGen ((current as {rows, columns, ...}), next) =
    let
      fun doColumns x =
        if x = columns then
          ()
        else
          let
            fun doRows y =
              if y = rows then
                ()
              else 
                (new (current, x, y, next);
                 doRows (y+1))
          in
            doRows 0;
            doColumns (x+1)
          end
    in
      cleanGen next;
      doColumns 0;
      (next, current)
    end

  
  fun updateFromList (gen, []) = ()
    | updateFromList (gen, (i, j)::rest) =
      (update (gen, i, j, 1);
       updateFromList (gen, rest))
      

  fun makeGen (columns, rows):generation =
    { cells = Array.tabulate (columns, fn _ => Array.array (rows, 0)),
      columns = columns,
      rows = rows }
    

  fun initState (columns, rows, initVals) = 
    let
      val (g1, g2) = (makeGen (columns, rows), makeGen (columns, rows))
      val _ = updateFromList (g1, initVals)
    in
      (g1, g2)
    end


  fun makeRect (x, y) =
    ((x * blockSize) + 1 ,(y * blockSize) + 1, blockSize - 2 , blockSize - 2)


  fun diffGen (state:life_state) =
    let
      val ({cells = currentCells, ...}, {cells = nextCells, ...}) = state
      val limit = Array.length currentCells
      fun scan (i, onRects, offRects) =
        if i = limit then
          (onRects, offRects)
        else
          let
            val a = Array.sub (currentCells, i)
            val max = Array.length a
            val a2 = Array.sub (nextCells, i)
            fun loop (j, onRects, offRects) = 
              if j = max then
                (onRects, offRects)
              else
                let
                  val n = Array.sub (a, j)
                in
                  if n = 1 then 
                    loop (j+1, makeRect (i, j)::onRects, offRects)
                  else if n = Array.sub (a2, j) then
                    loop (j+1, onRects, offRects)
                  else
                    loop (j+1, onRects, makeRect (i, j)::offRects)
                end
            val (onRects', offRects') = loop (0, onRects, offRects)
          in
            scan (i+1, onRects', offRects')
          end
    in
      scan (0, [], [])
    end




  fun makeToplevel (columns, rows, initvals) =
    let
      val state = ref (initState (columns, rows, initvals))
      val name = "mlworks"
      val class = "MLWorks"
        
      val title = "test"
        
      (*  The extent of the drawing area *)
      val xExtent = columns * blockSize
      val yExtent = rows * blockSize
        
      val applicationShell =
        Xm.initialize
        (name, class,
         [(Xm.TITLE, Xm.STRING title), (Xm.ICON_NAME, Xm.STRING title)]);
        
      val main =
        Xm.Widget.createManaged
        ("drawPane", Xm.Widget.DRAWING_AREA, applicationShell,
         [(Xm.WIDTH, Xm.INT xExtent), (Xm.HEIGHT, Xm.INT yExtent)])
        
      val _ = Xm.Widget.realize applicationShell
        
      val window= Xm.Widget.window main
      val display = Xm.Widget.display main
      val screen = Xm.Widget.screen main
        
      (*
       * The Crash exception indicates a problem has occured with X.
       * It is not explicitly caught anywhere since the usual action 
       * on catching it would be to terminate the program and that is
       * what happens as default when you don't catch an exception.
       *)
      exception Crash of string

      local
        val bg  =
          case Xm.Widget.valuesGet (main, [Xm.BACKGROUND]) of 
            [(Xm.PIXEL bg)] => bg
          | _ => raise Crash "get background failed"
        val onGc = Xm.GC.create (display, window, [Xm.GC.FOREGROUND 
                                                  (Xm.Pixel.screenBlack screen),
                                                  Xm.GC.BACKGROUND bg])
        val offGc = Xm.GC.create (display, window,[Xm.GC.FOREGROUND bg,
                                                   Xm.GC.BACKGROUND bg])
      in
        
        fun drawImage (x, y) =
          Xm.Draw.fillRectangle (display, window, onGc, 
                                 x+1, y+1, blockSize - 2, blockSize - 2)
        
        fun clearImage (x, y) =
          Xm.Draw.fillRectangle (display, window, offGc, 
                                 x+1, y+1, blockSize - 2, blockSize - 2)
        
        fun drawPicture () =
          let
            val (onRects, offRects) = diffGen (!state)
          in
            Xm.Draw.fillRectangles (display, window, offGc, offRects);
            Xm.Draw.fillRectangles (display, window, onGc, onRects);
            Xm.sync (display, false)
          end

      end



      val runit = ref false
        
      fun drawit () =
        (drawPicture ();
         if !runit then
           (state := nextGen (!state);
            drawPicture ();
            (* This generates an expose event *)
            Xm.Draw.clearArea (display, window, 0, 0, 1, 1, true))
         else
           ())
        
      
      (*
       * Doesn't pass along the affected region since the display update
       * routine just updates everything.
       *)
      fun doExpose (Xm.Event.EXPOSE_EVENT {common,x,y,width,height,count}) =
        drawit ()
        

      fun exposeHandler data =
        let
          val event = Xm.Event.convertEvent data
        in
          case event of
            Xm.Event.EXPOSE exposeEvent => doExpose exposeEvent
          | Xm.Event.GRAPHICS_EXPOSE exposeEvent => doExpose exposeEvent
          (* Could be a NoExpose event *)
          | _ => ()
        end
      
      fun clearit () =
        if Xm.Widget.isRealized main
          then Xm.Draw.clearArea (display, window, 0, 0, 0, 0, true)
        else ()
          
      fun resizeCallback data = clearit ()
        
      fun drawNextGen () =
        (state := nextGen (!state);
         drawit ())
        

      fun toggleCell (x, y) =
        let
          val i = x div blockSize
          val j = y div blockSize
        in
          if i >= 0 andalso i < columns andalso j >= 0 andalso j < rows then
            let 
              val ({cells, ...}, _) = !state
              val current = Array.sub (Array.sub (cells, i), j)
              val new = 1 - current
            in
              Array.update (Array.sub (cells, i), j, new);
              if new = 1 then
                drawImage (i * blockSize, j * blockSize)
              else
                clearImage (i * blockSize, j * blockSize)
            end
          else
            ()
         end


      fun inputCallback data =
        let
          val (_, event) = Xm.Callback.convertAny data
        in
          case event of
            Xm.Event.BUTTON_PRESS (Xm.Event.BUTTON_EVENT {x, y, ...}) => 
              toggleCell (x, y)
          | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "x", ...})) =>
              Xm.Widget.destroy applicationShell
          | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "r", ...})) =>
              (state := initState (columns, rows, initvals);
               clearit ())
          | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "s", ...})) =>
              (runit := not (!runit);
               if !runit then drawNextGen () else ())
          | (Xm.Event.KEY_PRESS _) =>
	      if not (!runit) then
                drawNextGen ()
	      else
		(* The next generation will be drawn anyway.  If we draw
		   it again here, the extra cycle of expose events will
		   override the keyboard input. *)
		()
          | _ => ()
        end

    in
      Xm.Event.addHandler (main, [Xm.Event.EXPOSURE_MASK], true, exposeHandler);
      Xm.Callback.add (main, Xm.Callback.INPUT, inputCallback);
      Xm.Callback.add (main, Xm.Callback.RESIZE, resizeCallback)
    end;

in  
  fun move (a:int,b:int) l = map (fn (x, y) => (x+a, y+b)) l
  val initvals = move (10, 10) crash
  val columns = 121
  val rows = 37
  fun life_runx () = Xm.mainLoop ()
  fun life_test () =  makeToplevel (columns, rows, initvals)
  fun life (columns, rows, vals) = makeToplevel (columns, rows, vals)
  fun life_appl () = (life_test (); life_runx ())
end
