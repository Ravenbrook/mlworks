(*  ==== Tetris demo  ====
 *
 *  Copyright (C) 1997  The Harlequin Group Limited.   All rights reserved.
 *
 * $Log: motif:tetris.sml,v 
 *  Revision 1.1  1996/10/03  14:50:00  john
 *  new unit
 *  Regorganising directory structure
 *
 *  Revision 1.4  1996/08/22  10:55:37  johnh
 *  Added a window displaying the high scores.
 *
 *  Revision 1.2  1996/07/30  10:42:04  io
 *  [Bug #1498]
 *
 *  Revision 1.1  1996/02/26  17:05:27  matthew
 *  new unit
 *  New demo
 *
*)

(* To play, type:  
 *	tetris <your_name> <level 1 - 5>
 *)

require "$.motif.__xm";
require "$.basis.__int";
require "$.basis.__real";
require "$.basis.__string";
require "$.basis.__text_io";
require "$.basis.__io";
require "$.basis.__ieee_real";
require "textwindow";

local
structure Array = MLWorks.Internal.Array
val xsize = 10
val ysize = 30

val block_size = 16
(* These are the primitive shapes of the game which get rotated into the
 * various orientations used in the game. *)
val square = [(~1,~1),(~1,0),(0,~1),(0,0)]
val line = [(~2,0),(~1,0),(0,0),(1,0)]
val step = [(~1,0),(0,0),(0,~1),(1,~1)]
val el = [(~1,~1),(~1,0),(0,0),(1,0)]
val tee = [(0,~1),(~1,0),(0,0),(1,0)]

(* reflection - used in reflect the shapes into new shapes *)
fun refl l = 
   map (fn (x:int,y:int) => (y,x)) l

(* rotation - again used to create new shapes *)
fun rot l = 
   map (fn (x:int,y:int) => (~y,x)) l

val shapes =
  [step,
   square,
   line,
   tee,
   refl step,
   el,
   rot (rot tee),
   rot line,
   refl el]

(* make a high score table *)
fun make_high_scores y = 
  Array.tabulate (y, fn i => 
	("No-one   ", 0))

val highscores = make_high_scores 6;

fun make_high_score_window() = text_window {height=300, width = 230, 
                                            title="Tetris High Scores"};

val high_score_window_fns : ((string -> unit) * (unit -> unit)) option ref = 
  ref (SOME(make_high_score_window()));

(* functions sub??? access arrays, for example accessing the high
 * score array to see if a high score has been beaten. *)
fun sub2 (a,x,y) =
  Array.sub (Array.sub (a,y),x)
  handle Array.Subscript => false
        
fun sub_hs (a,y) = 
  Array.sub (a,y)
  handle Array.Subscript => ("", 0)
	
  (* functions update??? update the appropriate arrays. *)
fun update2 (a,x,y,v) =
  Array.update (Array.sub (a,y),x,v)
  handle Array.Subscript => ()
        
fun update_hs (a,y,v) = 
  Array.update (a,y,v)
  handle Array.Subscript => ()

fun get_hs2 l = sub_hs (highscores, l - 1)
fun print_hs (6, hs_win : string -> unit) = ()
  | print_hs (n:int, hs_win) = 
    let 
      val (cname, chs) = get_hs2 n
    in 
      (hs_win ((Int.toString n) ^":    "^ Int.toString chs ^"   by   "^ cname ^"\n") ;
       print_hs (n+1, hs_win))
    end

fun get_level n = sub_hs (highscores, n)
fun save_levels outstrm 0 = ()
  | save_levels outstrm n = 
     let 
       val (lname,lhs) = get_level (n-1)
     in
       (TextIO.output (outstrm, Int.toString n ^ "\n");
        TextIO.output (outstrm, lname ^ "\n");
	TextIO.output (outstrm, Int.toString lhs ^ "\n");
	save_levels outstrm (n-1);
        TextIO.closeOut outstrm)
     end
fun load_levels instrm = 
    if (not (TextIO.endOfStream instrm)) then
       (let
	  fun get_opt NONE = 0
            | get_opt (SOME s) = s

	  val some_level = Int.fromString (TextIO.inputLine (instrm))
          val level = get_opt some_level
          val lname = (let val l = TextIO.inputLine (instrm) 
	                in String.substring(l, 0, (String.size l) - 1) end)
	  val some_lhs = Int.fromString (TextIO.inputLine (instrm))
          val lhs = get_opt some_lhs
	in
	  (update_hs (highscores, level - 1, (lname,lhs)); 
	   load_levels instrm)
       end)
     else (TextIO.closeIn instrm)



fun get_highscore_window_printer() =
  case high_score_window_fns of
    ref(SOME(hs_win, _)) => hs_win
  | _ => let val p as (hs_win, _) = make_high_score_window()
          in (high_score_window_fns := SOME p; 
              load_table "highscores.tet"; 
              hs_win) end

and output_hs () = 
      let val hs_win = get_highscore_window_printer()
       in (hs_win "Level: Score by Player.\n\n"; 
           print_hs (1, hs_win); hs_win "------------------------\n\n")
      end

and save_table filename = save_levels (TextIO.openOut filename) 5

and load_table filename = 
      (load_levels (TextIO.openIn filename)
         handle IO.Io {function="openIn",...} => save_table filename;	
       output_hs())

in
val _ = load_table "highscores.tet"; 

fun close_high_score_window() =
  case high_score_window_fns of
    ref(SOME(_, close)) => (high_score_window_fns := NONE; close())
  | _ => ();

(* eg. tetris "John" 2; *)
fun tetris player level =
  let
    val deltime = (5 - level) * 200000 + 100000
    val del = ref deltime
    fun make_grid (x,y) =
      Array.tabulate
      (y,
       fn i => Array.array (x,false))
      
    val score = ref 0
      
      (* Sets up the game grid *)
    val grid = make_grid (xsize,ysize)
      
      (* This checks the top line in the game grid to see if there are
       * any blocks there, and if there are then this is used to mark
       * the end of a game. *)
    fun not_end 0 = not (sub2(grid, 0, 0))
      | not_end n = (not (sub2(grid, n, 0))) andalso not_end (n-1);
        
    local val a = 16807.0 and m = 2147483647.0
    in fun nextrand seed = 
      let val t = a * seed
      in t - m * real(floor(t/m)) end
    end;

    val rand_num = ref (Int.toLarge 23478645);
  
    val current_shape = ref []
    val current_xy = ref (5,0)
    val current_points = ref []
      
      (* down, left and right move the shapes within the grid *)
    fun down (xy,shape) =
      let
        val (x,y) = xy
      in
        ((x,y+1),shape)
      end
    
    fun right (xy,shape) =
      let
        val (x,y) = xy
      in
        ((x+1,y),shape)
      end
    
    fun left (xy,shape) =
      let
        val (x,y) = xy
      in
        ((x-1,y),shape)
      end
    
    (* rot and crot functions are used to rotate a shape within the game grid *) 
    fun rot (xy,shape) =
      (xy,map (fn (x:int,y:int) => (y,~x)) shape)
    fun crot (xy,shape) = 
      (xy,map (fn (x:int,y:int) => (~y,x)) shape)
      
    fun get_current_points (xy,shape) =
      let
        val (cx,cy) = xy
      in
        map (fn (x:int,y:int) => (x+cx,y+cy)) shape
      end
    
    (* This function is used to make sure that a new position of the current
     * shape is legal, ie. does not cross the boundary of another shape or
     * cross the boundary of the game grid. *)
    fun allowable [] = true
      | allowable ((x,y) :: rest) =
        x >= 0 andalso x < xsize
        andalso y < ysize
        andalso
        (not (sub2 (grid,x,y)))
        andalso
        allowable rest
        
    fun member (a,[]) = false
      | member (a,(b::c)) = a = b orelse member (a,c)
        
    fun diff ([],l) = []
      | diff (a::b,l) =
        if member (a,l) then diff (b,l)
        else a :: diff (b,l)
          
    fun move f =
      let
        val old_points = !current_points
        val (new_xy,new_shape) = f (!current_xy,!current_shape)
        val new_points = get_current_points (new_xy,new_shape)
        val newbits = diff (new_points,old_points)
      in
        if allowable newbits
          then
            (current_points := new_points;
             current_xy := new_xy;
             current_shape:= new_shape;
             app
             (fn (x,y) =>
              update2 (grid,x,y,false))
             old_points;
             app
             (fn (x,y) =>
              update2 (grid,x,y,true))
             new_points;
             true)
        else
          false
      end

    exception no_shape;

    local 
      fun update_rand () = 
          (rand_num := Real.toLargeInt IEEEReal.TO_NEAREST (nextrand 
                       (Real.fromLargeInt (!rand_num)));())

      fun get_shape 0 (a::rest) = a
        | get_shape n (a::rest) = get_shape (n-1) rest
        | get_shape _ [] = raise no_shape;
    in 
      fun next_shape () = (update_rand ();
                           get_shape (Int.fromLarge ((!rand_num) mod 9)) shapes)
    end
  
    val name = "mlworks"
    val class = "MLWorks"
      
   val title = player
      
    (*  The extent of the drawing area *)
    val xextent = xsize * block_size;
    val yextent = ysize * block_size;

    (* This statement uses a motif procedure to initialise the X window of
     * the game. *)
    val applicationShell =
      Xm.initialize
      (name, class,
       [(Xm.TITLE, Xm.STRING title), (Xm.ICON_NAME, Xm.STRING title)]);

    (* A widget is a means of offering various degrees of user interface
     * functionality to a programmer.  A drawing area widget is needed
     * to draw the grid and the shapes. *)
    val main =
      Xm.Widget.createManaged
      ("drawPane", Xm.Widget.DRAWING_AREA,applicationShell,
       [(Xm.WIDTH,Xm.INT xextent),(Xm.HEIGHT,Xm.INT yextent)])


    (* This statement brings the window to the attention of the window
     * manager, hence starts it. *)
    val _ = Xm.Widget.realize applicationShell

    val window= Xm.Widget.window main
    val display = Xm.Widget.display main
    val screen = Xm.Widget.screen main

    exception Crash

    val bg  = case Xm.Widget.valuesGet (main,[Xm.BACKGROUND]) of 
      [(Xm.PIXEL bg)] => bg
      | _ => raise Crash

    val on_gc = Xm.GC.create (display,window,[Xm.GC.FOREGROUND (Xm.Pixel.screenBlack screen),
                                                 Xm.GC.BACKGROUND bg])
    val off_gc = Xm.GC.create (display,window,[Xm.GC.FOREGROUND bg,
                                               Xm.GC.BACKGROUND bg])

    fun draw_image (x,y) =
      Xm.Draw.fillRectangle (display,window,on_gc,x+1,y+1,block_size -2 ,block_size -2)

    fun clear_image (x,y) =
      Xm.Draw.fillRectangle (display,window,off_gc,x+1,y+1,block_size -2,block_size -2)

    fun draw a =
      let
        fun yloop y =
          if y = Array.length a then ()
          else
            let
              val suba = Array.sub (a,y)
              fun subloop x =
                if x = Array.length suba then ()
                else
                  (if Array.sub (suba,x)
                     then
                       draw_image (x*16,y*16)
                   else
                     clear_image (x*16,y*16);
                     subloop (x+1))
            in
              subloop 0;
              yloop (y+1)
            end
      in
        yloop 0;
        Xm.sync (display,false)
      end

    val xref = ref (xsize div 2)

    fun arot a =
      let
        fun loop 0 = ()
          | loop i =
            (Array.update (a,i,Array.sub (a,i-1));
             loop (i-1))
      in
        loop (Array.length a - 1)
      end


    (* This function clears rows within the grid which are complete. *)
    fun elim_clear_rows () =
      let
        fun doit n =
          if n = 0
            then ()
          else
            let
              val row = Array.sub (grid,n)
              fun check n =
                if n = Array.length row
                  then true
                else Array.sub (row,n) andalso check (n+1)
            in
              if check 0
                then
                  let
                    fun move_down 0 =
                      (Array.update (grid,0,Array.array (xsize,false));
                       draw grid)
                      | move_down n =
                        (Array.update (grid,n,Array.sub (grid,n-1));
                         move_down (n-1))
                  in
                    move_down n;
                    doit n
                  end
              else
                doit (n-1)
            end
      in
        doit (Array.length grid - 1)
      end

    fun new_shape () =
      let
        val _ = elim_clear_rows ()
        val shape = next_shape ()
        val dx = !xref
        val _ = xref := (dx + 4) mod xsize
      in
        current_shape := shape;
        current_xy := (dx,0);
        current_points := [];
	if not (move down) then (new_shape ();()) else ();
        ()
      end

    local 
	val (hname, hs) = sub_hs (highscores, level - 1)
    in
	val get_name = hname;
	val get_hs = hs;
    end

    val _ = get_highscore_window_printer(); (* Force highscore window to be displayed *)

    fun the_end () = 
      let 	
	val _ = if get_hs < !score then
		(update_hs(highscores, level - 1, (player, !score));())
		else ()
        val hs_win = get_highscore_window_printer()
      in
    	(hs_win (player^" scored "^ Int.toString (!score) ^ " on level " 
	^ Int.toString level ^".\n\n");
	save_table "highscores.tet"; output_hs ())
      end

    fun test_score () = case (!score) of 
			    50 => del := !del - 150000
			|  100 => del := !del - 150000
			|  150 => del := !del - 150000
			|  200 => del := 0
			|   _  => ()

    fun do_key key =
      case key of
        " " => if move down then true else 
		if not_end xsize then (new_shape (); 
			score := !score + 1;test_score ();true) else
		    (the_end ();
            Xm.Widget.destroy applicationShell			;false)
      | "l" => move right
      | "h" => move left
      | "i" => move rot
      | "o" => move (rot o rot o rot)
      | _ => true

    fun delay 0 = () | delay n = if n>0 then delay (n-1) else ()

    fun do_expose (Xm.Event.EXPOSE_EVENT {common,x,y,width,height,count}) =
      if count = 0 then 
        (draw grid;
         ignore(do_key " ");
         delay (!del);
         Xm.Draw.clearArea (display,window,0,0,1,1,true))
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

    (* Callbacks are functions which are called typically as a result of 
     * an action taken by the user.  This function is called when a key
     * is pressed, specifically it exits the application when 'x' is pressed. *)
    fun input_callback data =
      let
        val (reason,event) = Xm.Callback.convertAny data
      in
        case event of
          (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key = "x",...})) =>
            Xm.Widget.destroy applicationShell
        | (Xm.Event.KEY_PRESS (Xm.Event.KEY_EVENT {key ,...})) =>
            (ignore(do_key key);
             draw grid)
        | _ => ()
      end

  in
    new_shape ();
    draw grid; 

(* Event handlers capture events and pass them to the appropriate function,
 * for example, in this case, expose events are passed to the function:
 * 'expose_handler'. *)
    Xm.Event.addHandler (main,[Xm.Event.EXPOSURE_MASK],true,expose_handler);
    Xm.Callback.add (main,Xm.Callback.INPUT,input_callback)
  end

end


