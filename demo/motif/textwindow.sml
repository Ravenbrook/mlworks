(*  ==== Text Window demo  ====
 *
 *  Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: motif:textwindow.sml,v 
 *  Revision 1.1  1996/10/03  14:50:23  john
 *  new unit
 *  Reorganising directory structure
 *
 *  Revision 1.2  1996/08/20  16:18:12  johnh
 *  update the demo to refer to the existing Xm library.
 *
 *)

require "$.motif.__xm";

fun text_window {title, height, width} =

  let
    
    val appshell = Xm.initialize (title,
				     "appshellappclass", 
                                     [(Xm.DELETE_RESPONSE, Xm.DELETE_RESPONSE_VALUE Xm.DO_NOTHING)])
      
    val text_widget = Xm.Widget.createScrolledText
      (appshell, "text_widget",
       [(Xm.EDIT_MODE, Xm.EDIT_MODE_VALUE Xm.MULTI_LINE_EDIT),
	(Xm.HEIGHT, Xm.INT height),
	(Xm.WIDTH, Xm.INT width)])
      
    val _ = Xm.Widget.manage text_widget
      
    val _ = Xm.Widget.realize appshell
      
    val pos = ref 0
      
    fun output s = 
      let
	val length = size s
	val current = !pos
	val new = current + length
      in
	(Xm.Text.insert (text_widget,
			  current,
			  s);
	 pos := new)
      end
    fun destroy () = Xm.Widget.destroy appshell
  in
    (output,destroy)
  end

local
  fun doit(0,f,a) = ()
    | doit (n,f,a) = (ignore (f a);
		      doit (n-1,f,a))
  fun id x = x
  fun delay n = doit(n,id,())
  fun delayed_dot (d,out) = (delay d;
			     out ".")
  fun slow_line' (n,d,out) = (doit(n,delayed_dot,(d,out));
			     out "\n")
  fun slow_lines (wname,n,m,d,out) =
    (ignore (out("some dots : "^wname^"\n"));
     doit (n,slow_line',(m,d,out));
     out("done some dots for "^wname^"\n"))
in    
  fun slow_window(wname,h,w,n,m,d) =
    let val (ptw,dtw) = text_window{title = wname, height = h, width = w}
    in (slow_lines(wname:string,n,m,d,ptw);
	dtw())
    end
  fun dots () = slow_window("dots",200,200,20,20,50000)
  fun slow_line (n,out) = slow_line'(n,100000,out)
end












