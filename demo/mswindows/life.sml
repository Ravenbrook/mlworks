(*  ==== Life demo  ====
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
 * $Log: life.sml,v $
 * Revision 1.15  1998/11/09 11:31:51  johnh
 * [Bug #50105]
 * Make toplevel functions unique across demos to avoid conflicts when loading demo project.
 *
 *  Revision 1.14  1998/05/07  14:54:46  jkbrook
 *  [Bug #30388]
 *  Change Windows to WindowsGui
 *  Also put in ignores to get rid of warnings
 *
 *  Revision 1.13  1997/08/28  08:50:48  johnh
 *  [Bug #30257]
 *  Generations cannot overlap now, and background is always white.
 *
 *  Revision 1.12  1997/08/06  12:25:04  johnh
 *  [Bug #30130]
 *  Made a delivered life work properly and removed some fns from users view.
 *
 *  Revision 1.11  1997/08/05  14:45:45  daveb
 *  [Bug #30130]
 *  Stopped mainLoop from looping in the event of an exception.
 *  Added a "destroyed" flag to prevent the timer attempting to draw in the
 *  window after it has been destroyed.  Removed code that was creating bogus
 *  new generations.  Ensured that the initial state is always drawn.
 *  A little tidying up.
 *
 *  Revision 1.10  1997/06/16  13:01:12  jkbrook
 *  [Bug #30127]
 *  Merging changes from 1.0r2c1 into 2.0m0
 *
 *
 *  Revision 1.8.1.3  1997/05/15  13:22:08  daveb
 *  [Bug #30127]
 *  Updated copyright.
 *
 *  Revision 1.8.1.2  1997/05/15  08:47:06  daveb
 *  [Bug #20009]
 *  Making the demo unresizable.
 *
 *  Revision 1.8.1.1  1997/05/12  10:24:52  hope
 *  branched from 1.8
 *
 *  Revision 1.9  1997/05/14  13:43:52  johnh
 *  Solving the resize problem.
 *
 *  Revision 1.8  1997/04/11  09:22:53  johnh
 *  Remove references to MLWorks.Internal and tidy the messy code.
 *
 *  Revision 1.7  1997/04/10  16:19:02  daveb
 *  [Bug #2039]
 *  Removed use of Threads.  Also changed handler for WM_DESTROY to WM_CHANGE.
 *
 *  Revision 1.6  1997/01/07  16:34:48  io
 *  [Bug #1757]
 *  renamed __ieeereal
 *
 *  Revision 1.5  1996/12/06  11:13:25  johnh
 *  Removed some test code.
 *
 *  Revision 1.4  1996/12/02  13:55:53  johnh
 *  [Bug #1823]
 *  Removing references to capitypes and labelstrings.
 *
 *  Revision 1.3  1996/11/07  19:02:30  jkbrook
 *  Removing redundant references to structure Windows_
 *
 *  Revision 1.1  1996/10/11  14:10:15  johnh
 *  new unit
 *  Reorganised demo directory to include separate demos for mswindows and motif.
 *
 *
 *)

require "forms";

require "$.winsys.__windows_gui";
require "$.basis.__int"; 
require "$.basis.__real";
require "$.basis.__string";
require "$.basis.__text_io";
require "$.basis.__ieee_real";
require "$.basis.__array";
require "$.basis.__word"; 

val gunvals =
  [(2,20),(3,19),(3,21),(4,18),
   (4,22),(4,23),(4,32),(5,7),
   (5,8),(5,18),(5,22),(5,23),
   (5,29),(5,30),(5,31),(5,32),
   (5,36),(6,7),(6,8),(6,18),
   (6,22),(6,23),(6,28),(6,29),
   (6,30),(6,31),(6,36),(7,19),
   (7,21),(7,28),(7,31),(7,42),
   (7,41),(8,20),(8,28),(8,29),
   (8,30),(8,31),(8,42),(8,41),
   (9,29),(9,30),(9,31),(9,32)
   ]
    
local
  fun lshift (i1, i2) = Word.toInt (Word.<< (Word.fromInt i1, Word.fromInt i2))

  val size_exp = 3
  val block_size = lshift (1,size_exp)
    
  fun max (x:int,y) = if x > y then x else y
  fun min (x:int,y) = if x < y then x else y
    
  fun make_gen (n,m) =
    (Array.tabulate (n, fn _ => Array.array (m,0)),
     n,
     m)
    
  fun sub ((array,n,m),i,j) =
    if i < 0 then 0
    else if j < 0 then 0
    else if i >= n then 0
    else if j >= m then 0
	 else Array.sub (Array.sub (array,i),j)
	   
  fun mymod (i,n) =
    if i < 0 then mymod (i+n,n)
    else if i >= n then mymod (i-n,n)
	 else i
	   
  fun update ((array,n,m),i,j,x:int) =
    Array.update (Array.sub (array,mymod (i,n)),mymod (j,m),x)
    
  fun calc_val (array,i,j) =
    sub (array,i-1,j-1) +
    sub (array,i-1,j) +
    sub (array,i-1,j+1) +
    sub (array,i,j-1) +
    sub (array,i,j+1) +
    sub (array,i+1,j-1) +
    sub (array,i+1,j) +
    sub (array,i+1,j+1)
    
  fun calc_val ((a,n,m),i,j) : int =
    let
      val lix = if j = 0 then m-1 else j-1
      val mix = j
      val rix = if j = m-1 then 0 else j+1
      val top_row = Array.sub (a,if i=0 then n-1 else i-1)
      val mid_row = Array.sub (a,i)
      val bottom_row = Array.sub (a,if i = n-1 then 0 else i+1)
    in
      Array.sub (top_row,lix) +
      Array.sub (top_row,mix) +
      Array.sub (top_row,rix) +
      Array.sub (mid_row,lix) +
      Array.sub (mid_row,rix) +
      Array.sub (bottom_row,lix) +
      Array.sub (bottom_row,mix) +
      Array.sub (bottom_row,rix)
    end
  
  fun new (ina,i,j,outa) =
    let
      val newval =
	case calc_val (ina,i,j) of
	  2 => sub (ina,i,j)
	| 3 => 1
	| _ => 0
    in
      update (outa,i,j,newval)
    end
  
  fun clean (a,n,m) =
    let
      fun loop1 i =
	if i = n
	  then ()
	else
	  let
	    val suba = Array.sub (a,i)
	    fun loop2 j =
	      if j = m then ()
	      else 
		(Array.update (suba,j,0);
		 loop2 (j+1))
	  in
	    loop2 0;
	    loop1 (i+1)
	  end
    in
      loop1 0
    end
  
  fun gen (ina as (_,n,m),outa) =
    let
      fun loop1 i =
	if i = n
	  then ()
	else
	  let
	    fun loop2 j =
	      if j = m then ()
	      else 
		(new (ina,i,j,outa);
		 loop2 (j+1))
	  in
	    loop2 0;
	    loop1 (i+1)
	  end
    in
      clean outa;
      loop1 0;
      (outa,ina)
    end
  
  fun set (a,[]) = ()
    | set (a,(i,j)::rest) =
      (update (a,i,j,1);
       set (a,rest))
      
  fun move (a:int,b:int) l = map (fn (x,y) => (x+a,y+b)) l
    
  val initvals = move (10,10) crash
    
  fun init_gen (initvals,world_x,world_y) = 
    let
      val (a1,a2) = (make_gen (world_x,world_y),make_gen (world_x,world_y))
      val _ = set (a1,initvals)
    in
      (a1,a2)
    end
  
  val state = ref (make_gen (0,0),make_gen (0,0))
    
  (* Windows stuff *)

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

  fun make_life_widget (name,class,parent,height,width,attributes) = 
    let
      val window =
        WindowsGui.createWindow {class = class,
                         name = name,
                         width = width,
                         height = height,
                         parent = parent,
                         menu = WindowsGui.nullWord,
                         styles = attributes}
    in
      WindowsGui.showWindow (window,WindowsGui.SW_SHOWNORMAL);
      WindowsGui.updateWindow window;
      window
    end

  fun make_toplevel (world_x,world_y) =
    let
      val title = "test"
	
      (*  The extent of the drawing area *)
      val xextent = world_x * block_size
      val yextent = world_y * block_size

      val default_width = xextent
      val toplevel_width = default_width + 10
      val graphics_height = yextent
      val toplevel_height = graphics_height + 34
  
      val applicationShell = WindowsGui.mainInit ()

      val life = make_life_widget ("Life", "Frame", applicationShell, 
			toplevel_height, toplevel_width,
			[WindowsGui.WS_OVERLAPPED, 
			 WindowsGui.WS_SYSMENU,
			 WindowsGui.WS_MINIMIZEBOX])

      local 
	val hdc = WindowsGui.getDC life
      in 
	val on_brush = WindowsGui.createSolidBrush (WindowsGui.getTextColor hdc);
	val off_brush = WindowsGui.createSolidBrush (WindowsGui.getBkColor hdc);
	val _ = WindowsGui.releaseDC (life,hdc)
      end

      fun draw_image (x,y) = 
	let val hdc = WindowsGui.getDC life
	in (WindowsGui.fillRect (hdc,WindowsGui.RECT {left=x+1,top=y+1,right=x + block_size,
				bottom=y + block_size}, on_brush);
	    WindowsGui.releaseDC (life,hdc))
	end
	
      fun clear_image (x,y) =
	let val hdc = WindowsGui.getDC life
	in (WindowsGui.fillRect (hdc,WindowsGui.RECT {left=x+1,top=y+1,right=x + block_size,
				bottom=y + block_size}, off_brush);
	    WindowsGui.releaseDC (life,hdc))
	end

      fun make_rect (x,y) = WindowsGui.RECT {left=lshift (x,size_exp)+1,
					  top=lshift (y,size_exp)+1,
					  right=(lshift (x,size_exp)+1)+ block_size,
					  bottom=(lshift (y,size_exp)+1) +block_size}
	
      fun draw_picture _ =
	let
	  val ((gen1,_,_),(gen2,_,_)) = !state
	  val on_rects = ref []
	  val off_rects = ref []
	  val hdc = WindowsGui.getDC life
	  fun fill_rects (brush, []) = ()
	    | fill_rects (brush, (rect1::rest)) = 
		(WindowsGui.fillRect(hdc, rect1, brush); 
		 fill_rects (brush, rest))
	in
          Array.appi
	  (fn (i,a) =>
	   let
	     val max = Array.length a
	     val a2 = Array.sub (gen2,i)
	     fun loop j = 
	       if j = max then ()
	       else
		 let
		   val n = Array.sub (a,j)
		 in
		   if n = 1 then 
		     on_rects := make_rect (i,j) :: !on_rects
		   else
		     if n = Array.sub (a2,j)
		       then ()
		     else
		       off_rects := make_rect (i,j) :: !off_rects;
		       loop (j+1)
		 end
	   in
	     loop 0
	   end)
	  (gen1, 0, NONE);
	  fill_rects (off_brush,!off_rects);
	  fill_rects (on_brush, !on_rects);
	  WindowsGui.releaseDC (life, hdc)
	end
      
      val goforit = ref false
      val destroyed = ref false
	
      fun drawit _ =
	if not (!destroyed) then
          draw_picture ()
        else ()
	
      fun paint_event _ = (drawit (); NONE)

      fun clearit _ =
	let val hdc = WindowsGui.getDC life
	in (WindowsGui.fillRect (hdc, WindowsGui.RECT {left=0, top=0, right=toplevel_width,
						bottom=toplevel_height}, off_brush);
	    WindowsGui.releaseDC (life, hdc))
  	end

      fun resize_event data = (clearit(); NONE)
  
      val generating = ref false

      fun new_gen () =
	if !generating then () else
	  (generating := true;	
	   state := gen (!state);
	   drawit ();
	   generating := false)

      fun timer _ = 
        if (!goforit) then 
	  new_gen()
        else ()
	
      fun mouse_event event (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) = 
        let 
	  val xPos = WindowsGui.loword(lparam)
	  val yPos = WindowsGui.hiword(lparam)
        in
	  case event of 
	    WindowsGui.WM_LBUTTONDOWN => (
	      let
		val i = xPos div block_size
		val j = yPos div block_size
	      in
		if i >= 0 andalso i < world_x
		  andalso j >= 0 andalso j < world_y
		  then
		    let 
		      val ((a,_,_),_) = !state
		      val current = Array.sub (Array.sub (a,i),j)
		      val new = 1 - current
		    in
		      Array.update (Array.sub (a,i),j,new);
		      if new = 1 
			then draw_image (i*block_size,j*block_size)
		      else clear_image (i*block_size,j*block_size)
		    end
		else ()
	      end)
	  | _ => ();
	  NONE
        end

        val colorcount = ref 0

        fun delay 0 = ()
          | delay n = if n>0 then delay (n-1) else ()

	exception Quit

        fun do_key key = 
	  case key of
	     "x" => (ignore
                     (goforit := false;
		     destroyed := true;
		     WindowsGui.destroyWindow life;
		     raise Quit);
		     ())
	  |  "r" => (state :=init_gen (initvals,world_x,world_y);
		     clearit ();
		     drawit ())
	  |  "s" => (goforit := not (!goforit);
	             if !goforit then new_gen() else ())
	  |   _  => (if not (!goforit) then new_gen () else ())

      fun key_press (WindowsGui.WPARAM wparam, WindowsGui.LPARAM lparam) = 
        (do_key (str (chr (WindowsGui.wordToInt wparam))); NONE)

    in
      ignore (WindowsGui.setTimer (life, 30, timer));
      WindowsGui.addMessageHandler(life, WindowsGui.WM_LBUTTONDOWN, 
				mouse_event WindowsGui.WM_LBUTTONDOWN);  
      WindowsGui.addMessageHandler(life, WindowsGui.WM_PAINT, paint_event);
      WindowsGui.addMessageHandler(life, WindowsGui.WM_SIZE, resize_event); 
      WindowsGui.addMessageHandler(life, WindowsGui.WM_CHAR, key_press);
      WindowsGui.addMessageHandler(life, WindowsGui.WM_CLOSE,
                                   fn _ => (do_key "x";
                                            SOME WindowsGui.nullWord));
      clearit();
      drawit ()
    end;

  fun create (init,x,y) = 
    (state := init;
     make_toplevel (x,y))

in

  val world_x = 121
  val world_y = 37
  
  fun life (vals,x,y) = 
    (create (init_gen (vals,x,y),x,y);
     WindowsGui.mainLoop () handle _ => ())

  fun life_test () = life (initvals, world_x, world_y)

  fun life_appl (vals,x,y) () = 
    (create (init_gen (vals,x,y),x,y);
     WindowsGui.mainLoop () handle _ => WindowsGui.postQuitMessage 0)
 
end

