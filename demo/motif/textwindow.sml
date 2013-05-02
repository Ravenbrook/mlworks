(*  ==== Text Window demo  ====
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












