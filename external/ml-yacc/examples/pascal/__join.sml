require "pascal_lex";
require "pascal_grm";
require "_pascal_grm";
require "$.lib.join";
require "$.lib.parser2";
require "$.basis.__int";
require "$.basis.__string";
require "$.basis.__io";
require "$.basis.__text_io";

local

structure PascalLrVals = PascalLrValsFun(structure Token = LrParser.Token)
structure PascalLex = PascalLexFun(structure Tokens = PascalLrVals.Tokens)
structure PascalParser = Join(structure Lex= PascalLex
		              structure LrParser = LrParser
		              structure ParserData = PascalLrVals.ParserData)

exception Finished
fun fst (a,_) = a

in

structure Parser =
struct
  
  val parse = fn s =>
    let val dev = TextIO.openIn s
      val stream = PascalParser.makeLexer(fn i => TextIO.inputN(dev,i))
      val _ = PascalLex.UserDeclarations.lineNum := 1
      val error = fn (e,i:int,_) => 
        TextIO.print(s ^ "," ^ " line " ^ (Int.toString i) ^ 
                     ", Error: " ^ e ^ "\n")
    in (fst(PascalParser.parse(30,stream,error,()))
        handle PascalParser.ParseError => TextIO.print "Parse Error\n")
      before TextIO.closeIn dev
    end handle IO.Io _ => TextIO.print "File Error\n"



  val keybd = fn () =>
    let
      val _ = TextIO.print "type \"finished\" on a separate line to finish.\n"
      val dev = TextIO.stdIn
      
      (* note: some implementations of ML, such as SML of NJ,
       have more efficient versions of input_line in their built-in
       environment
       *)
      
      val input_line = fn f =>
        let fun loop result =
          let val c = TextIO.inputN (f,1)
            val result = c :: result
          in if String.size c = 0 orelse c = "\n" then
            String.concat (rev result)
             else loop result
          end
        val r = loop nil
        in if r = "finished\n" then raise Finished else r
        end
      val stream = PascalParser.makeLexer (fn i => input_line dev)
      val _ = PascalLex.UserDeclarations.lineNum := 1
      val error = fn (e,i:int,_) => 
        TextIO.print("std_in," ^ " line " ^ (Int.toString i) ^ 
                     ", Error: " ^ e ^ "\n")
    in fst(PascalParser.parse(0,stream,error,()))
    end handle Finished => (TextIO.print "finished.\n")
             | PascalParser.ParseError => (TextIO.print "Parse error.\n")
end  
end
