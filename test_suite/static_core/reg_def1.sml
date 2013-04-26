(*

Result: OK
 
$Log: reg_def1.sml,v $
Revision 1.1  1994/06/06 14:55:19  jont
new file

Copyright (c) 1994 Harlequin Ltd.
*)
fun ml_debugger base_frame =
  let
    fun do_input frames =
      let 
	fun loop _ = raise Match

      in
	loop frames
      end

    fun tty_debugger (top_frame, empty) =
      if empty then
	()
      else
	do_input top_frame
  in
    tty_debugger
  end
