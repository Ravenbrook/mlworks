(*  ==== Tetris demo  ====
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
 * $Log: tetris.sml,v $
 * Revision 1.16  1998/11/09 11:33:55  johnh
 * [Bug #50105]
 * Make toplevel functions unique across demos to avoid conflicts when loading demo project.
 *
 *  Revision 1.15  1998/05/07  14:54:37  jkbrook
 *  [Bug #30388]
 *  Change Windows to WindowsGui and remove use of MLWorks.IO
 *  Also put in ignores to get rid of warnings
 *
 *  Revision 1.14  1997/08/06  12:54:15  johnh
 *  [Bug #30130]
 *  Fix similar bug as in life demo - leaving listener hanging.
 *
 *  Revision 1.13  1997/06/16  13:04:17  jkbrook
 *  [Bug #30127]
 *  Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.11.1.3  1997/05/15  13:22:32  daveb
 *  [Bug #30127]
 *  Updated copyright.
 *
 *  Revision 1.11.1.2  1997/05/15  08:46:58  daveb
 *  [Bug #20009]
 *  Making the demo unresizable.
 *
 *  Revision 1.11.1.1  1997/05/12  10:24:30  hope
 *  branched from 1.11
 *
 *  Revision 1.12  1997/05/14  14:48:52  johnh
 *  Making the demo unresizable.
 *
 *  Revision 1.11  1997/04/11  08:52:39  johnh
 *  Tidied some code and fix problems with adding revision comments.
 *
 *  Revision 1.1  1996/10/03  15:15:00  johnh
 *  new unit
 *  Added new windows version of tetris
 *
 *
*)


(* To play, type:  
 *	make_toplevel <your_name> <level 1 - 5>
 *)

require "$.winsys.__windows_gui";
require "$.basis.__int";
require "$.basis.__real";
require "$.basis.__string";
require "$.basis.__text_io";
require "$.basis.__io";
require "$.basis.__ieee_real";
require "$.basis.__char";
require "$.basis.__array";

local
  datatype WidgetClass = Text | Form 

  val xsize = 12
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

  fun make_grid (x,y,tf) =
    Array.tabulate
    (y, fn i => Array.array (x,tf))
      
  val score = ref 0

  fun boolToString true = "T"
    | boolToString false = "F"
      
  (* functions sub??? access arrays, for example accessing the high
   * score array to see if a high score has been beaten. *)
  fun sub2 (a,x,y) =
    Array.sub (Array.sub (a,y),x)
     handle Subscript => false
        
  fun sub_hs (a,y) = 
    Array.sub (a,y)
     handle Subscript => ("", 0)
	
  (* functions update??? update the appropriate arrays. *)
  fun update2 (a,x,y,v) =
    Array.update (Array.sub (a,y),x,v)
     handle Subscript => () 
        
  fun update_hs (a,y,v) = 
    Array.update (a,y,v)
     handle Subscript => ()
      
  (* Sets up the game grid *)
  val grid = make_grid (xsize,ysize,false)
  val update = make_grid (xsize,ysize,true)      

  fun print_grid () = 
    let 
      fun print xstr = TextIO.output (TextIO.stdOut, xstr)
      fun print_line x y = if x>xsize then 
				print "\n"
			   else (print ((boolToString (sub2 (grid, x,y))) ^ "   ");
				 print_line (x+1) y)
      fun print_grid' y = if y>ysize then print ""	
				else (print_line 0 y; print_grid' (y+1))
    in
      print_grid' 0
    end

  (* This checks the top line in the game grid to see if there are
   * any blocks there, and if there are then this is used to mark
   * the end of a game. *)
  fun not_end 0 = not (sub2(grid, 0, 1))
    | not_end n = (not (sub2(grid, n, 1))) andalso not_end (n-1);
        
  local 
    val a = 16807.0 and m = 2147483647.0
  in 
    fun nextrand seed = 
      let val t = a * seed
      in t - m * real(floor(t/m)) end
  end;

  val rand_num = ref (Int.toLarge 23478645);
  
  val current_shape = ref []
  val current_xy = ref (5,0)
  val current_points = ref []

  (* down, left and right move the shapes within the grid *)
  fun down ((x,y),shape) = ((x,y+1),shape)
    
  fun right ((x,y),shape) = ((x+1,y),shape)
    
  fun left ((x,y),shape) = ((x-1,y),shape)
    
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
           ignore (map
           (fn (x,y) =>
             (ignore (update2 (grid,x,y,false));
	     update2 (update,x,y,true)))
             old_points);
           ignore (map
           (fn (x,y) =>
            (ignore (update2 (grid,x,y,true));
	     update2 (update,x,y,true)))
             new_points);
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

  (*  The extent of the drawing area *)
  val xextent = xsize * block_size
  val yextent = ysize * block_size
  val default_width = xsize * block_size
  val toplevel_width = default_width + 10
  val graphics_height = ysize * block_size
  val toplevel_height = graphics_height + 34
  
  fun munge_string s =
    let
      fun munge ([],acc) = MLWorks.String.implode (rev acc)
        | munge ("\013" :: "\010" :: rest,acc) =
          munge (rest, "\010" :: "\013" :: acc)
        | munge ("\n"::rest,acc) = munge (rest,"\013\010" :: acc)
        | munge (c::rest,acc) = munge (rest,c::acc)
    in
      munge (MLWorks.String.explode s,[])
    end

  fun convert_class class =
    case class of
      Text => ("EDIT",[WindowsGui.WS_BORDER])
    | Form => ("Frame",[]) 

  fun set_text (window,s) =
    let
      val string_word = WindowsGui.makeCString (munge_string s)
    in
      ignore (WindowsGui.sendMessage (window,WindowsGui.WM_SETTEXT,
                            WindowsGui.WPARAM (WindowsGui.nullWord),
                            WindowsGui.LPARAM string_word));
      WindowsGui.free string_word
    end

  fun class_postaction (window,class) =
    case class of
      Text => set_text (window, "")
    | Form => ()

  fun create_revealed args =
    let
      val window = WindowsGui.createWindow args
    in
      WindowsGui.showWindow (window,WindowsGui.SW_SHOWNORMAL);
      WindowsGui.updateWindow window;
      window
    end

  fun make_managed_widget (name,class,parent,height,width,attributes) = 
    let
      val (class_name,styles) = convert_class class
      val window =
        create_revealed {class = class_name,
                         name = name,
                         width = width,
                         height = height,
                         parent = parent,
                         menu = WindowsGui.nullWord,
                         styles = styles @ attributes}
    in
      class_postaction (window,class);
      window
    end

  local 
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
		     in String.substring(l, 0, (String.size l) - 1)
			handle Subscript => "" end)
	   val some_lhs = Int.fromString (TextIO.inputLine (instrm))
	   val lhs = get_opt some_lhs
	 in
	   (update_hs (highscores, level - 1, (lname,lhs)); 
	    load_levels instrm)
	 end)
       else (TextIO.closeIn instrm)
  in	
    fun save_table filename = save_levels (TextIO.openOut filename) 5
    fun load_table filename = load_levels (TextIO.openIn filename)
	    handle IO.Io {function="openIn",...} => save_table filename
  end

  fun make_toplevel player level =
    let
      val deltime = (5 - level) * 50 + 30
      val del = ref deltime
      val _ = load_table "highscores.tet"; 

      (* This statement uses an MS Windows procedure to initialise the
       * main window of the game. *)
      val applicationShell = WindowsGui.mainInit ();

      val scoresMainWindow = make_managed_widget ("Scores", Form, applicationShell, 
        			350,275, 
        			[WindowsGui.WS_CAPTION,
        			WindowsGui.WS_SYSMENU,
        			WindowsGui.WS_MINIMIZEBOX])
      val scoresWindow = make_managed_widget ("", Text, scoresMainWindow,
        			350,272, 
        			[WindowsGui.ES_MULTILINE, WindowsGui.ES_READONLY,
        			WindowsGui.ES_AUTOVSCROLL, WindowsGui.WS_CHILD])

      val tetris = make_managed_widget ("Tetris", Form, applicationShell, 
        			toplevel_height, toplevel_width,
        			[WindowsGui.WS_SYSMENU,
				 WindowsGui.WS_MINIMIZEBOX,
				 WindowsGui.WS_OVERLAPPED])
    
      val _ = WindowsGui.showWindow (scoresWindow, WindowsGui.SW_SHOWDEFAULT)
      val _ = WindowsGui.showWindow (tetris, WindowsGui.SW_SHOWDEFAULT)

      val title = player

      local 
	val hdc = WindowsGui.getDC tetris
      in 
	val on_brush = WindowsGui.createSolidBrush (WindowsGui.getTextColor hdc);
	val off_brush = WindowsGui.createSolidBrush (WindowsGui.getBkColor hdc);
	val _ = WindowsGui.releaseDC (tetris,hdc)
      end

      fun draw_image (x,y) =
        let val hdc = WindowsGui.getDC tetris
        in 
	  (WindowsGui.fillRect (hdc,WindowsGui.RECT {left=x+1,top=y+1,right=x + block_size,
			      bottom=y + block_size}, on_brush);
	  WindowsGui.releaseDC (tetris,hdc))
        end

      fun clear_image (x,y) = (* change brush; draw_image; change brush *)
        let val hdc = WindowsGui.getDC tetris
        in 
	  (WindowsGui.fillRect (hdc, WindowsGui.RECT 
		{left=x+1,top=y+1, right=x + block_size, bottom=y + block_size}, 
		off_brush);
	  WindowsGui.releaseDC (tetris,hdc))
        end

      fun draw a =   (* a always = grid *)
        let
          fun yloop y =
            if y = Array.length a then ()
            else
              let
                val suba = Array.sub (a,y)
                fun subloop x =
                  if x = Array.length suba then ()
                  else
  		    (if Array.sub ((Array.sub (update,y)),x) then
                       ((if Array.sub (suba,x)
                        then
                           draw_image (x*16,y*16)
                        else
                           clear_image (x*16,y*16));
  		        update2 (update,x,y,false))
  		     else ();
                     subloop (x+1))
              in
                subloop 0;
                yloop (y+1)
              end
        in
          yloop 0
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
  			   Array.update (update, 0, Array.array (xsize,true));
                           draw grid)
                        | move_down n =
                          (Array.update (grid,n,Array.sub (grid,n-1));
  			   Array.update (update,n,Array.array (xsize,true));
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
	  if not (move down) then 
		(new_shape ();()) 
	  else ()
        end

      local 
	val (hname, hs) = sub_hs (highscores, level - 1)
      in
	val get_name = hname;
	val get_hs = hs;
      end

      val text_buf = ref "";
      fun hs_win hs_str = text_buf := (!text_buf) ^ hs_str

      local 
        fun get_hs2 l = sub_hs (highscores, l - 1)
        fun print_hs 6 = true
          | print_hs (n:int) = 
            let 
              val (cname, chs) = get_hs2 n
            in 
	      
              (hs_win ((Int.toString n) ^":    "^ Int.toString chs ^"   by   "^ 
			cname ^"\n");
	       ignore (print_hs (n+1));
               true)
            end
      in
        fun output_hs () = 
			
                       (text_buf := ""; hs_win "Level: Score by Player.\n\n"; 
  			ignore (print_hs 1); 
                        hs_win "------------------------\n\n";
  			set_text (scoresWindow, !text_buf ))
      end

      val _ = output_hs ();

      fun set_array the_array array_value = 
        let 
	  fun clear_line 0 y = update2 (the_array, 0,y,array_value)
	    | clear_line x y = (clear_line (x-1) y; 
				update2 (the_array, x, y, array_value))
	  fun clear_whole 0 = clear_line (xsize-1) 0
	    | clear_whole y = (clear_whole (y-1); 
			       clear_line (xsize-1) y)
        in
	  clear_whole (ysize - 1)
        end

      fun the_end () = 
        let 	
	  val _ = if get_hs < !score then
		(update_hs(highscores, level - 1, (player, !score));())
		else ()
        in
    	  (output_hs ();hs_win (player^" scored "^ Int.toString (!score) ^ " on level " 
	         ^ Int.toString level ^".\n\n");
	  set_text (scoresWindow, !text_buf);
	  save_table "highscores.tet")
        end

(* Keep this around as it might be brought back in to increase
 * the speed of the game as it progreses *)

(*    fun test_score () = case (!score) of 
			    50 => del := !del - 150000
			|  100 => del := !del - 150000
			|  150 => del := !del - 150000
			|  200 => del := 0
			|   _  => ()
*)

      val start = ref false;
      val locked = ref 0;

      exception Quit;

      fun do_key key = 
        (if ((!locked) = 0) then 
	    (locked := !locked + 1;
            ignore (case key of
               " " => if move down then true else 
		    if not_end xsize then (new_shape (); 
			score := !score + 1;
			true) else
		    	(ignore (the_end ();  
			hs_win "Press 'S' in the Tetris window to start.\n\n";
			set_text (scoresWindow, !text_buf);
			start := false);
			false)
            | "s" => (ignore (score := 0;
		    set_array update true;
		    set_array grid false;
		    draw grid;
		    start := true); 
		    false)
            | "l" => move right
            | "h" => move left
            | "i" => move rot
            | "o" => move (rot o rot o rot)
            | "x" => (ignore (WindowsGui.destroyWindow tetris; 
		    WindowsGui.destroyWindow scoresMainWindow;
		    raise Quit);
		    false)
            | _ => true);
	   locked := !locked - 1;
	   false)
         else false)

      fun delay 0 = () | delay n = 
        if n>0 then 
	  delay (n-1) 
        else ()

      fun timer _ = 
        if ((!start) andalso ((!locked) = 0)) then 
	  (ignore (do_key " ");
	   draw grid; ()) 
        else ()

      fun paint_event _ = 
        (set_array update true; draw grid; NONE)

      fun key_press (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) = 
         (ignore 
          (do_key (str (Char.toLower (chr (WindowsGui.wordToInt wparam))))); 
         draw grid; NONE)

    in
      ignore (WindowsGui.setTimer(tetris, !del, timer));
      WindowsGui.addMessageHandler (tetris, WindowsGui.WM_CLOSE, 
				   fn _ => (ignore (do_key "x"); 
					    SOME WindowsGui.nullWord));
      WindowsGui.addMessageHandler (tetris, WindowsGui.WM_PAINT, paint_event);
      WindowsGui.addMessageHandler (tetris, WindowsGui.WM_CHAR, key_press);

      (* The following code initialises the tetris window to start with a new game *)
      score := 0;
      set_array update true;
      set_array grid false;
      new_shape ();
      draw grid;
      start := true
    end

in

  fun tetris (name, level) = 
    (make_toplevel name level;
     WindowsGui.mainLoop () handle _ => ())

  fun tetris_appl (name, level) () = 
    (make_toplevel name level;
     WindowsGui.mainLoop () handle _ => WindowsGui.postQuitMessage 0)

  fun tetris_test () = tetris ("You", 3)

end


