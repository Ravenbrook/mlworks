(*
 *
 * $Log: termcap.sml,v $
 * Revision 1.2  1998/06/08 17:29:10  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*

Provide basic terminal controls features.

Currently set for a Sun window.

These will have to be changed for a different terminal type.

It uses the following control sequences.

	clear screen character	(ascii 12)
	escape character	(ascii 27)
	bell character		(ascii 7)

Cursor control (escape character given by ESC)
	cursor up  		ESC[A
	cursor down  		ESC[B
	cursor left		ESC[D
	cursor right 		ESC[C

Window attributes.
	window size (in rows (#R) and columns (#C) of characters)
				ESC[8;#R;#Ct
	icon associated with window ("FILE" - path-name of icon)
				ESC]I"FILE"ESC\
	title line of window ("TITLE" - string giving title)
				ESC]l"TITLE"ESC\

I have built in a default screen size.  This is initially set to 80 columns and
30 rows.  Calls to the Set_Screen_Size function, will resize the current teletype
window, and reset these values.  The current size can be interrogated by the 
get_screen_size function.

Highlighting
	set highlighting on 	ESC[7m
	set highlighting off 	ESC[m

Clearing lines and screens
	clear screen character	(ascii 12)
	clear line 		ESC[K
	clear display		ESC[J  (??)
	
The following functions are supplied.

ring_bell : unit -> unit
	- rings the keyboard bell
clear_screen : unit -> unit
	- clears the current terminal window
clear_display : unit -> unit
	- clears the current terminal window
clear_line : unit -> unit
	- clears the current line
up = fn : int -" : string
	- moves cursor up n lines - 0 puts at beginning of line
down : int -> unit
	- moves cursor down n lines - 0 puts at beginning of line
left : int -> unit
	- moves cursor left n characters
right : int -> unit
	- moves cursor right n characters
at : (int * int) -> unit
	- moves cursor to (rows * columns) (in characters and lines)
highlight_on : unit -> unit
	- turns highlighting on for subsequent output
highlight_off : unit -> unit
	- turns highlighting off for subsequent output
newline : unit -> unit
	- outputs a newline on the terminal
set_icon = fn : string -> unit
	- sets the current window icon to filename.
set_window_size = fn : (int * int) -> unit
	- resizes window to (rows * columns) (in characters and lines)
get_window_size = fn : unit -> (int * int)
	- returns current window size (rows * columns) (in characters and lines)
set_window_title = fn : string -> unit
	- overwrites title bar of window with string
	
*)

structure Termcap = 
struct

	local
	val write_terminal = write std_out
	val clear = chr 12
	val escape = chr 27
	val bell = chr 7

	val up_sequence = escape ^ "[A"
	val down_sequence = escape ^ "[B"
	val left_sequence = escape ^ "[D"
	val right_sequence = escape ^ "[C"

	fun U () = write_terminal up_sequence
	fun D () = write_terminal down_sequence
	fun L () = write_terminal left_sequence
	fun R () = write_terminal right_sequence
	
	val Screen_Size = ref (45, 90)
	in

	fun clear_screen () = write_terminal clear 
	fun ring_bell () = write_terminal bell 


	fun up 0 = (newline ();U ()) 
	  | up 1 = U ()
	  | up n = if n > 0 then (U () ; up (n-1)) else () 

	fun down 0 = (newline ();D ()) 
	  | down 1 = D ()
	  | down n = if n > 0 then (D () ; down (n-1)) else () 

	fun left 0 = () 
	  | left n = if n > 0 then (L () ; left (n-1)) else () 

	fun right 0 = () 
	  | right n = if n > 0 then (R () ; right (n-1)) else () 

	fun at (x,y) = write_terminal 
			(escape ^ "[" ^
			(makestring (x:int)) ^
			";" ^
			(makestring (y:int)) ^
			"H")  

	fun set_window_size(ROWS,COLS) = (Screen_Size := (ROWS,COLS);
			write_terminal 
			(escape ^ "[8;" ^
			(makestring (ROWS:int)) ^
			";" ^
			(makestring (COLS:int)) ^
			"t" ) )

	fun get_window_size () = ! Screen_Size 

	fun set_icon(ICONFILE) = write_terminal 
			(escape ^ "]I" ^
			ICONFILE ^ escape ^ 
			"\\" ) 

	fun set_window_title(TITLE) = write_terminal 
			(escape ^ "]l" ^
			TITLE ^  
			escape ^ "\\" ) 

	fun highlight_on () = write_terminal 
		  (escape ^ "[7m")  

	fun highlight_off () = write_terminal 
		  (escape ^ "[m")  

	fun clear_line () = write_terminal 
		  (escape ^ "[K")  

	fun clear_display () = write_terminal 
		  (escape ^ "[J")  
	
	end 	(* of local *)

end ;		(* of structure Termcap *)
