(*
 *
 * $Log: parser.sml,v $
 * Revision 1.2  1998/06/08 17:34:02  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 
parser.sml

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     19/02/91
Glasgow University and Rutherford Appleton Laboratory.

Functional parsing routines.

Based on a mixture of Larry Paulson's library of parsing functions
in SML in

  ML for the Working Programmer
  by Lawrence C. Paulson, Computer Laboratory, University of Cambridge.
  (Cambridge University Press, 1991)

Copyright (C) 1991 by Cambridge University Press.

Chris Reade's library of parsing functions from his book
and Guy Argo's library of parsing functions with error propagation
in LML together with lots of modifications of my own. 

--# and #-- thanks to Nick Cropper for pointing them out.

*)

functor ParseFUN (Lex: LEXICAL) : PARSE =
  struct

  type token = Lex.Token
  type 'a parser = token list -> 'a Search * string list * token list

  fun tok (Lex.Id s) = s
    | tok (Lex.Num n) = makestring n
    | tok (Lex.NL) = "NL"

  (* for building a set of error messages *)

  val U = uncurry (union eq)
  infix U

  exception SynError of string

(* some basic parsers.

empty : 'a list parser
	parser always succeeds, consumes nothing and returns empty list
eof   : 'a list parser
	parser succeeds on the end of input.
nl    : 'a list parser
	parser succeeds on the newline character, consumes the NL token,
	and returns the empty list.
fail  : parser always fails and consumes no input.
*)

  fun empty toks = (Match [],[],toks)
  
  fun fail toks = (NoMatch,[""],toks)
  
  fun eof [] = (Match [],[],[])   
    | eof (t::l) = 
      (NoMatch,["Not at end of input.  \""^tok t^"\" follows."],t::l)  
  
  fun nl (Lex.NL::l) = (Match [],[],l)  
    | nl (t::l)  = (NoMatch,["Not a Newline.  \""^tok t^"\" follows."],t::l) 
    | nl []      = (NoMatch,["Not a Newline but end of input."],[]) 

(*  more general basic parsers.
id  : string parser
	recognises any string
num : int parser
	recognises any integer
*)

  fun id (Lex.Id a :: toks) = (Match a,[],toks)
    | id toks = (NoMatch,["Identifier expected"],toks)

  fun num (Lex.Num a :: toks) = (Match a,[],toks)
    | num toks = (NoMatch,["Integer expected"],toks)

(* basic parser generators

$      :  string -> string parser
	succeeds on recognising the given string, which it returns.
*)

  fun $a (Lex.Id b :: toks) =
        if a=b then (Match a,[],toks) 
        else (NoMatch,["Symbol \""^a^"\" expected, \""^b^"\" found."],
              Lex.Id b :: toks)
    | $a (Lex.Num n :: toks) =
        (NoMatch,["Symbol \""^a^"\" expected, \""^makestring n^"\" found."],
              Lex.Num n :: toks)
    | $a (Lex.NL :: toks) =
        (NoMatch,["Symbol \""^a^"\" expected, NL found."], Lex.NL :: toks)
    | $a [] = (NoMatch,["Symbol \""^a^"\" expected, but no more input."],
              [])

  (*Application of f to the result of a phrase*)
  fun (ph >> f) toks = 
      (case ph toks of
        (Match x,es,toks2) => (Match (f x),es,toks2)
      | (NoMatch,es,toks2) => (NoMatch,es,toks)
      )

  (*Alternative phrases. Propagates the error messages *)
  fun (ph1 || ph2) toks = 
      (case ph1 toks of
       (Match x,es1,toks2) => (Match x,es1,toks2)
     | (NoMatch,es1,toks2) => (case ph2 toks2 of
       				(Match y,es2,toks3) => 
       					(Match y, es1 U es2, toks3) 
       			      | (NoMatch,es2,toks3) => (NoMatch,es1 U es2,toks)
       			      )
     )

  (*Consecutive phrases*)
  fun (ph1 -- ph2) toks = 
      (case ph1 toks of
       (Match x,es1,toks2) => (case ph2 toks2 of
       				(Match y,es2,toks3) => 
       					(Match (x,y), es1 U es2, toks3) 
       			      | (NoMatch,es2,toks3) => (NoMatch,es1 U es2,toks)
       			      )
     | (NoMatch,es1,toks2) => (NoMatch,es1,toks)
     )


  (* replace all the current error messages with a new one if failure.
     removes all the current error messages if success  *)

  fun change_errors s ph toks =
      (case ph toks of
        (Match x, es, toks) => (Match x, [] , toks)
      | (NoMatch, es, toks) => (NoMatch, [s], toks)
      )

  (* if successful parse, dumps all the error messages *)
  fun drop_errors ph toks = 
      (case ph toks of
        (Match x,es,toks') => (Match x,[],toks') 
      |          x         =>          x
      )
(* more basic parser generators
symbol : string -> string parser
	explodes the string and generates a 
Phrase consisting of symbolic string - remember lexed individually 
*)

  fun symbol s = 
      let val sps = rev (map $ (explode s))
      in fold (fn (a,b) => a -- b >> op^) (tl sps) (hd sps)
      end 

(*
notkey : string list -> string parser
	recognises any identifier which is not part of a list of keywords
*)

  fun notkey ss (Lex.Id a :: toks) = 
     if member ss a 
     then (NoMatch,["Keyword \""^a^"\" found, identifier expected"],Lex.Id a::toks)
     else (Match a,[],toks)
    | notkey ss toks = (NoMatch,["Identifier expected"],toks)

(*Zero or more phrases*)
  fun repeat ph toks = drop_errors (   ph -- repeat ph >> (op::)
                                    || empty   ) toks;

  fun infixes (ph,prec_of,apply) = 
    let fun over k toks = next k (ph toks)
        and next k (Match x, es,Lex.Id a::toks) = 
              if prec_of a < k then (Match x,es, Lex.Id a :: toks)
              else next k ((over (prec_of a) >> apply a x) toks)
          | next k (x,es, toks) = (x,es, toks)
    in  over 0  end;

  fun reader ph a =   (*Scan and parse, checking that no tokens remain*)
	 (case ph (Lex.scan a) of 
	      (Match x,es, []) => x
	    | (Match x,es, [Lex.NL]) => x
	    | (NoMatch,es, _ ) => 
	raise SynError ("Errors:\n"^ stringwith ("","\n","") es)
	    | (_,es, Lex.NL::t::_) => 
        raise SynError ("Extra characters in input. - \""^tok t^"\" next.\n"^
		stringwith ("","\n","") es)
	    | (_,es, t::_) => 
	raise SynError ("Extra characters in input. - \""^tok t^"\" next.\n"^
		stringwith ("","\n","") es)
	 )

   fun (p --# q) toks = (p -- q >> fst) toks
   fun (p #-- q) toks = (p -- q >> snd) toks

  end;
