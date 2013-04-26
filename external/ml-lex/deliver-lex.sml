(* deliver-lex.sml
 *)

require "__lexgen";
require "$.basis.__list";
require "$.basis.__string";
require "$.basis.__text_io";
require "$.basis.__command_line";

structure DeliverLexGen : sig

    val lexGen : unit -> unit

  end = struct

    fun err msg = TextIO.output(TextIO.stdErr, String.concat msg)

    fun lexGen () =
          let
            val args = CommandLine.arguments()
	    fun lex_gen () = 
              (case args
		 of [] => err ["sml-lex", ": missing filename\n"]
		  | files => List.app LexGen.lexGen files
		(* end case *))
	  in
            (lex_gen())
            handle MLWorks.Interrupt => err ["sml-lex", ": Interrupt\n"]
                 | any => err [
                          "sml-lex", 
                               ": uncaught exception ", exnMessage any, "\n"
                               ]

          end
  end;
   
fun deliver name = MLWorks.Deliver.deliver (name, DeliverLexGen.lexGen,MLWorks.Deliver.CONSOLE);


