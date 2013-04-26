require "sigs";
require "^.lib.base";
require "$.basis.__text_io";

(* ML-Yacc Parser Generator (c) 1989 Andrew W. Appel, David R. Tarditi *)

functor ParseGenParserFun(include sig
                           structure Parser : ARG_PARSER
                           structure Header : HEADER
                           sharing type Parser.result=Header.parseResult
                           sharing type Parser.arg = Header.inputSource = Parser.lexarg
                          end where type Parser.pos = int) : PARSE_GEN_PARSER =


 struct
      structure Header = Header
      val parse = fn file =>
          let
	      val in_str = TextIO.openIn file
	      val source = Header.newSource(file,in_str,TextIO.stdOut)
	      val error = fn (s : string,i:int,_) =>
		              Header.error source i s
	      val stream =  Parser.makeLexer (fn i => (TextIO.inputN(in_str,i)))
		            source
	      val (result,_) = (Header.lineno := 1; 
				Header.text := nil;
		                Parser.parse(15,stream,error,source))
	   in (TextIO.closeIn in_str; (result,source))
	   end
  end;
