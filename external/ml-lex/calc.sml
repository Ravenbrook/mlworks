(* the following requires are only necessary in MLWorks *)
 
require "calc_lex";
require "$.basis.__string";
require "$.basis.__int";
require "$.basis.__text_io";

structure Calc =
 struct
   open CalcLex
   open UserDeclarations
   exception Error
   exception Finished
   fun parse strm =
    let
      val _ = print "type \"()\" to finish.\n"
      val say = print
      val input_line = fn f =>
          let fun loop result =
             let val c = TextIO.inputN (f,1)
	         val result = c :: result
             in if String.size c = 0 orelse c = "\n" then
	  	   String.concat (rev result)
	         else loop result
	     end
              val r = loop nil
          in if r = "()\n" then raise Finished else r
          end
      val lexer = makeLexer (fn n => input_line strm)
      val nexttok = ref (lexer())
      val advance = fn () => (nexttok := lexer(); !nexttok)
      val error = fn () => (say ("calc: syntax error on line" ^
                           (Int.toString(!linenum)) ^ "\n"); raise Error)
      val lookup = fn i =>
        if i = "ONE" then 1
        else if i = "TWO" then 2
        else  (say ("calc: unknown identifier '" ^ i ^ "'\n"); raise Error)
     fun STMT_LIST () =
         case !nexttok of
            EOF => ()
          | _ => (ignore(STMT()); STMT_LIST())
        
     and STMT() =
         (case !nexttok
           of EOS  => ()
            | PRINT => (ignore(advance()); ignore(say ((Int.toString (E():int)) ^ "\n")); ())
            | _ => (ignore(E()); ());
         case !nexttok
           of EOS => (advance())
            | _ => error())
     and E () = E' (T())
     and E' (i : int ) =
         case !nexttok of
            PLUS => (ignore(advance ()); E'(i+T()))
          | SUB => (ignore(advance ()); E'(i-T()))
          | RPAREN => i
          | EOF => i
          | EOS => i
          | _ => error()
     and T () =  T'(F())
     and T' i =
        case !nexttok of
            PLUS => i
          | SUB => i
          | TIMES => (ignore(advance()); T'(i*F()))
          | DIV => (ignore(advance ()); T'(i div F()))
          | EOF => i
          | EOS => i
          | RPAREN => i
          | _ => error()
     and F () =
        case !nexttok of
            ID i => (ignore(advance()); lookup i)
          | LPAREN =>
              let val v = (ignore(advance()); E())
              in if !nexttok = RPAREN then (ignore(advance ()); v) else error()
              end
          | NUM i => (ignore(advance()); i)
          | _ => error()
    in STMT_LIST () handle Error => parse strm
    end handle Finished => print "Finished.\n"
 end
