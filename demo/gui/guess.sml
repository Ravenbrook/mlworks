(* === Guess demo ===
 * 
 * Copyright (C) 1998.  The Harlequin Group plc.
 * 
 * $Log: guess.sml,v $
 * Revision 1.3  1999/03/18 12:19:53  johnh
 * [Bug #190530]
 * Don't use Real.fromInt - no need if Time.toReal is used.
 *
# Revision 1.2  1998/08/05  16:51:46  johnh
# [Bug #30463]
# separate out the call to main_loop.
#
# Revision 1.1  1998/07/21  09:53:43  johnh
# new unit
# [Bug #30441]
# Part of an example of CAPI and projects.
#
 *)

require "__capi";
require "__int";
require "__time";
require "__real";
require "random";

fun display_guess() = 
  let
    val shell = Capi.initialize_application ("MLWorks","Guess example")

    val going = ref false
    val now = Time.now()

    val mainWindow = 
      Capi.make_subwindow ("Guess my number (1-1000)", shell, 
			   [(Capi.Position (100,100)),
			    (Capi.Size (500, 200))]);

    val guess_label = 
      Capi.make_label ("Your guess:", mainWindow, [(Capi.Position (0, 0)),
						   (Capi.Size (200, 30))]);

    val guess_text = 
      Capi.make_text ("guess_text", mainWindow, [(Capi.Position (200, 0)),
						 (Capi.Size (50, 30)),
						 (Capi.ReadOnly false)]);

    val tries_label = 
      Capi.make_label ("Number of tries:", mainWindow, [(Capi.Position (0, 30)),
							(Capi.Size (200, 30))]);
    val tries_text = 
      Capi.make_text ("tries_text", mainWindow, [(Capi.Position (200, 30)),
						 (Capi.Size (50, 30)),
						 (Capi.ReadOnly true)]);

    val my_number = ref 0
    val low = ref 1
    val high = ref 1000

    val region_label = 
      Capi.make_label ("The number is somewhere between 1 and 1000", mainWindow,
			[(Capi.Position (0, 62)),
			 (Capi.Size (500, 25))])

    fun update_region_label () = 
      let
	val low_str = Int.toString (!low)
	val high_str = Int.toString (!high)
      in
	Capi.set_label_string (region_label, 
	  "The number is somewhere between " ^ low_str ^ " and " ^ high_str)
      end

    val update = ref update_region_label

    fun start () =
      let 
	fun get_num () = 
	  let
	    val msecs = Time.toReal (Time.- (Time.now(), now))
	  in
	    msecs
	    handle _ => 6688.0
	  end

	val seed = get_num()
	val rand_num = (nextrand (seed))
      in
	my_number := rand_num;
	low := 1;
	high := 1000;
	going := true;
	(!update)();
	Capi.set_text_string (guess_text, "0");
	Capi.set_text_string (tries_text, "0")
      end

    val (startButton, start_update) = 
      Capi.make_button {name = "Start again", 
			parent = mainWindow,
			attributes = [(Capi.Position (0, 87)),
				      (Capi.Size (80, 30))],
			sensitive = fn () => not (!going),
			action = start}

    fun guess () = 
      let
	val guess_val = 
	  getOpt (Int.fromString (Capi.get_text_string guess_text), 0)
	val tries = 
	  getOpt (Int.fromString (Capi.get_text_string tries_text), 0) + 1
      in
	Capi.set_text_string (tries_text, Int.toString tries);
	if guess_val < (!my_number) then
	  (if guess_val > (!low) then low := guess_val else ();
	   (!update)())
	else if (guess_val > (!my_number)) then
	  (if guess_val < (!high) then high := guess_val else ();
	   (!update)())
	else
	  (going := false;
	   (!update)();
	   Capi.set_label_string(region_label,"The number is " ^ Int.toString guess_val);
	   Capi.send_message (shell, "Well done, your guess was spot on!"))
      end

    val (guessButton, guess_update) = 
      Capi.make_button {name = "Guess", 
			parent = mainWindow, 
			attributes = [(Capi.Position (82, 87)),
				      (Capi.Size (80, 30))],
			sensitive = fn () => (!going),
			action = guess}

    fun resign () = 
      let 
	val num_string = Int.toString (!my_number)
	val tries = Capi.get_text_string tries_text
      in
	going := false;
	(!update)();
	Capi.send_message (shell, "You've given up after " ^ tries ^ " tries.  The number you tried to guess was " ^ num_string)
      end

    val (resignButton, resign_update) = 
      Capi.make_button {name = "Give up", 
			parent = mainWindow, 
			attributes = [(Capi.Position (164, 87)),
				      (Capi.Size (80, 30))],
			sensitive = fn () => (!going),
			action = resign}

    fun quit () = 
      (Capi.destroy mainWindow;  Capi.quit_loop shell)

    val (closeButton, close_update) = 
      Capi.make_button {name = "Close",
			parent = mainWindow,
			attributes = [(Capi.Position (246, 87)),
				      (Capi.Size (80, 30))],
			sensitive = fn () => true,
			action = quit}

  in
    update := (fn () => (update_region_label();
	       start_update();
	       guess_update();
	       resign_update()));
    app (fn w => Capi.reveal w) 
	       [mainWindow, 
		guess_label, 
		guess_text,
		tries_label,
		tries_text,
		region_label,
		startButton,
		guessButton,
		resignButton,
		closeButton];
    (!update)();
    Capi.initialize_application_shell shell
  end

fun guess () = (display_guess(); Capi.main_loop())

