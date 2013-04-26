(*
 *
 * $Log: t_output.sml,v $
 * Revision 1.2  1998/06/08 17:30:23  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

Provides basic functions for outputting to the terminal.

write_terminal : string -> unit
	- writes a string to the terminal window, at the current cursor
	 position.
write_at_cursor : (int * int) -> string -> unit
	- writes a string at the specified position.

write_highlighted : string -> unit
	- writes string highlighted at the current position.
*)


structure Terminal_Output = 
   struct
	local 
	val write_terminal = write std_out 
	in
	
	fun write_at_cursor (Row,Col) s = 
		(Termcap.at (Row,Col) ; write_terminal s)
	
	fun write_highlighted s = 
		(Termcap.highlight_on () ;
		 write_terminal s ;
		 Termcap.highlight_off ())
	end 
	
	
end ;
