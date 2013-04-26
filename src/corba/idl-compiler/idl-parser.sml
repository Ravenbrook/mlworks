(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/idl-parser.sml,v 1.9 1999/03/10 15:48:40 clive Exp $" *)

require "idl_grm";
require "idl_lex";
require "_idl_grm";
require "__absyn";
require "__emitter";

require "ml-yacc/lib/base.sml";
require "ml-yacc/lib/join.sml";
require "ml-yacc/lib/lrtable.sml";
require "ml-yacc/lib/parser2.sml";
require "ml-yacc/lib/stream.sml";

require "$.basis.__text_io";
require "$.basis.__int";

structure Emitter = Emitter

structure IDLLrVals =
  IDLLrValsFun(structure Token = LrParser.Token structure Absyn = Absyn);

structure IDLLex =
  IDLLexFun (structure Tokens = IDLLrVals.Tokens);

structure IDLParser =
  Join(structure ParserData = IDLLrVals.ParserData
       structure Lex= IDLLex
       structure LrParser=LrParser);

val invoke =
  fn lexstream =>
    let val print_error = fn (s,i:int,_) =>
      TextIO.print("Error: line " ^ (Int.toString i) ^ ", " ^ s ^ "\n")
    in
      IDLParser.parse (0, lexstream, print_error, ())
    end ;

fun preprocess (name, defines) =
  let
    val stream = TextIO.openIn name
    fun check_for_initial_sequence (string,seq) =
      if size(string) < size(seq)
      then false
      else if substring(string,0,size seq) = seq
           then true
           else false
    fun position (c,string,start) =
      let
        val len = size string
        fun search (pos) =
          if pos >= len
          then ~1
          else if substring(string,pos,1) = c
	       then pos
	       else search (pos+1)
      in
        if start < 0
        then ~1
        else search start
      end
    fun line_process sofar =
      let 
	val next_line = TextIO.inputLine stream
      in
        if next_line = ""
        then sofar
        else
          if check_for_initial_sequence (next_line, "#include")
          then 
	    let 
	      val start = position ("\"", next_line, 0)
	      val end' = position ("\"", next_line, start+1)
	      val included_file = name ^ "/../" ^ substring (next_line,start+1, end'-start-1)
            in
	     line_process
	     ((("#include_end \"" ^ included_file ^"\"\n") ::
	       preprocess(included_file,defines))
		@ 
		(("#include_begin \"" ^ included_file ^"\"\n") :: sofar))
	    end
          else line_process (next_line :: sofar)
      end
    val result = line_process []
    val _ = TextIO.closeIn stream
  in
    result
  end;


val input_on_file =
  fn name =>
   let 
     val _ = IDLLex.UserDeclarations.linenum := 0
     val data = ref (rev(preprocess (name,[])))
   in
     fn (_ : int) => 
        case !data of
          [] =>  ""
        | (res::rest) =>
             (data := rest; res)
   end;

val parse_file =
  fn name => invoke (IDLParser.makeLexer (input_on_file name));

val generate_signatures =
  fn name => 
  let
    val (tree,_) = parse_file name
  in
    map (fn x =>  map (fn x => TextIO.print (x ^ "\n")) x) (Emitter.generate_signatures tree)
  end
