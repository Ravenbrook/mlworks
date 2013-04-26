(* deliver-yacc.sml
 *
 * ML-Yacc Parser Generator (c) 1991 Andrew W. Appel, David R. Tarditi
 * adapted for Harlequin Ltd. MLWorks 1997, 1998
 *
 *)

require "$.basis.__text_io";
require "$.basis.__string";
require "$.basis.__command_line";
require "__link";

structure DeliverParseGen : sig

    val parseGen : unit -> unit

  end = struct
    fun err msg = TextIO.output (TextIO.stdErr, msg)

    fun parseGen () =
      let
        val argv = CommandLine.arguments()
        fun parse_gen () =
            (case argv
               of [file] => ParseGen.parseGen file
                | _ => err("Usage: ml-yacc filename\n")
		(* end case *))
	  in
            parse_gen()
            handle MLWorks.Interrupt => ()
                 | ex => err (String.concat
                    [ "? ml-yacc: uncaught exception ", exnMessage ex, "\n"
			  ])
	  end
  end;

fun deliver name = MLWorks.Deliver.deliver(name,DeliverParseGen.parseGen,MLWorks.Deliver.CONSOLE);

