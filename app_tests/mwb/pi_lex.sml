(*
 *
 * $Log: pi_lex.sml,v $
 * Revision 1.2  1998/06/11 13:10:15  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
functor PILexFun(structure Tokens: PI_TOKENS)=
   struct
    structure UserDeclarations =
      struct
structure Tokens = Tokens

type pos = int
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult= (svalue,pos) token
type arg = int ref * int ref

(*val lineNum = ref 0*)
(* val pcount = ref 0 *)
(* val pos = ref 0 *)
val error = fn (e,l : int,_) =>
              (output(std_out,"line " ^ (makestring l) ^
                               ": " ^ e ^ "\n"))

fun eof (lno:int ref,pc:int ref) =
    (if !pc > 0 then print("EOF with unclosed parentheses\n")
     else ();
     Tokens.EOF(!lno,!lno))

structure KeyWord : sig
			val cvstringtoint : string -> 
				 int
	     		val find : string ->
				 (string * int * int -> (svalue,int) token) option
	  	    end =
  struct

	val cvstringtoint = fn str =>
	    let fun mkint (nil, s:int) = s
	          | mkint (c::Rest, s) =
	            mkint (Rest, ((ord c)-(ord "0"))+10*s)
	    in
		mkint (explode str, 0)
	    end

	val TableSize = 21
	val HashFactor = 5

	val hash = fn s =>
	   fold (fn (c,v)=>(v*HashFactor+(ord c)) mod TableSize) (explode s) 0


	val HashTable = Array.array(TableSize,nil) :
		 (string * (string * int * int -> (svalue,int) token)) list array


	val add = fn (s,v) =>
	 let val i = hash s
	 in Array.update(HashTable,i,(s,v) :: (Array.sub(HashTable, i)))
	 end

        val find = fn s =>
	  let val i = hash s
	      fun f ((key,v)::r) = if s=key then SOME v else f r
	        | f nil = NONE
	  in  f (Array.sub(HashTable, i))
	  end
 
	val _ = 
	    (List.app add
	[("t",Tokens.TAU),

	 ("all",Tokens.ALL),
	 ("agent",Tokens.AGENT),
	 ("check",Tokens.CHECK),
	 ("clear",Tokens.CLEAR),
	 ("deadlocks",Tokens.DEAD),
	 ("debug",Tokens.DEBUG),
	 ("env",Tokens.ENVIRONMENT),
	 ("eq",Tokens.EQ),
	 ("eqd",Tokens.EQD),
	 ("input",Tokens.INPUT),
	 ("rewrite",Tokens.REWRITE),
	 ("remember",Tokens.REMEMBER),
	 ("set",Tokens.SET),
	 ("show",Tokens.SHOW),
	 ("step",Tokens.STEP),
	 ("ztep",Tokens.ZTEP),
	 ("size",Tokens.SIZE),
	 ("tables",Tokens.TABLES),
	 ("threshold",Tokens.THRESHOLD),
	 ("time",Tokens.TIMEr),
	 ("traces",Tokens.TRACES),
	 ("transitions",Tokens.TRANS),
	 ("version",Tokens.VERSION),
	 ("wtransitions",Tokens.WTRANS),
	 ("weq",Tokens.WEQ),
	 ("weqd",Tokens.WEQD),
	 ("help",Tokens.HELP),
	 ("quit",Tokens.QUIT),
	 ("true",Tokens.TRUE),
	 ("false",Tokens.FALSE),
	 ("on",Tokens.ON),
	 ("off",Tokens.OFF),

	 ("TT",Tokens.TT),
	 ("FF",Tokens.FF),
	 ("Sigma",Tokens.SIGMA),
	 ("Bsigma",Tokens.BSIGMA),
	 ("Pi",Tokens.PI),
	 ("exists",Tokens.EXISTS),
	 ("not",Tokens.NOT),
	 ("nu",Tokens.NU),
	 ("mu",Tokens.MU)
	])
   end
   open KeyWord

end (* end of user routines *)
exception LexError (* raised if illegal leaf action tried *)
structure Internal =
	struct

datatype yyfinstate = N of int
type statedata = {fin : yyfinstate list, trans: string}
(* transition & final state table *)
val tab = let
val s0 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
val s1 =
"\005\005\005\005\005\005\005\005\005\040\042\005\005\005\005\005\
\\005\005\005\005\005\005\005\005\005\005\005\005\005\005\005\005\
\\040\039\036\035\005\005\034\033\031\030\005\029\028\005\027\026\
\\025\023\023\023\023\023\023\023\023\023\005\022\021\020\019\018\
\\005\016\016\016\016\016\016\016\016\016\016\016\016\016\016\016\
\\016\016\016\016\016\016\016\016\016\016\016\015\013\012\011\005\
\\005\006\006\006\006\006\006\006\006\006\006\006\006\006\006\006\
\\006\006\006\006\006\006\006\006\006\006\006\010\009\008\006\005\
\\005"
val s3 =
"\043\043\043\043\043\043\043\043\043\043\046\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\044\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\043\
\\043"
val s6 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\007\000\000\007\000\000\000\000\000\000\000\000\
\\007\007\007\007\007\007\007\007\007\007\000\000\000\000\000\000\
\\000\007\007\007\007\007\007\007\007\007\007\007\007\007\007\007\
\\007\007\007\007\007\007\007\007\007\007\007\000\000\000\000\007\
\\000\007\007\007\007\007\007\007\007\007\007\007\007\007\007\007\
\\007\007\007\007\007\007\007\007\007\007\007\000\000\000\000\000\
\\000"
val s13 =
"\000\000\000\000\000\000\000\000\000\000\014\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
val s16 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\017\000\000\017\000\000\000\000\000\000\000\000\
\\017\017\017\017\017\017\017\017\017\017\000\000\000\000\000\000\
\\000\017\017\017\017\017\017\017\017\017\017\017\017\017\017\017\
\\017\017\017\017\017\017\017\017\017\017\017\000\000\000\000\017\
\\000\017\017\017\017\017\017\017\017\017\017\017\017\017\017\017\
\\017\017\017\017\017\017\017\017\017\017\017\000\000\000\000\000\
\\000"
val s23 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\024\024\024\024\024\024\024\024\024\024\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
val s31 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\032\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
val s36 =
"\037\037\037\037\037\037\037\037\037\037\000\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\038\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\037\
\\037"
val s40 =
"\000\000\000\000\000\000\000\000\000\041\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\041\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
val s44 =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\045\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\\000"
in Vector.vector
[{fin = [], trans = s0},
{fin = [], trans = s1},
{fin = [], trans = s1},
{fin = [], trans = s3},
{fin = [], trans = s3},
{fin = [(N 64)], trans = s0},
{fin = [(N 15),(N 64)], trans = s6},
{fin = [(N 15)], trans = s6},
{fin = [(N 32),(N 64)], trans = s0},
{fin = [(N 40),(N 64)], trans = s0},
{fin = [(N 30),(N 64)], trans = s0},
{fin = [(N 58),(N 64)], trans = s0},
{fin = [(N 28),(N 64)], trans = s0},
{fin = [(N 54),(N 64)], trans = s13},
{fin = [(N 2)], trans = s0},
{fin = [(N 26),(N 64)], trans = s0},
{fin = [(N 18),(N 64)], trans = s16},
{fin = [(N 18)], trans = s16},
{fin = [(N 50),(N 64)], trans = s0},
{fin = [(N 36),(N 64)], trans = s0},
{fin = [(N 20),(N 64)], trans = s0},
{fin = [(N 34),(N 64)], trans = s0},
{fin = [(N 46),(N 64)], trans = s0},
{fin = [(N 12),(N 64)], trans = s23},
{fin = [(N 12)], trans = s23},
{fin = [(N 9),(N 12),(N 64)], trans = s23},
{fin = [(N 52),(N 64)], trans = s0},
{fin = [(N 42),(N 64)], trans = s0},
{fin = [(N 44),(N 64)], trans = s0},
{fin = [(N 38),(N 64)], trans = s0},
{fin = [(N 24),(N 64)], trans = s0},
{fin = [(N 22),(N 64)], trans = s31},
{fin = [(N 71)], trans = s0},
{fin = [(N 56),(N 64)], trans = s0},
{fin = [(N 62),(N 64)], trans = s0},
{fin = [(N 60),(N 64)], trans = s0},
{fin = [(N 64)], trans = s36},
{fin = [], trans = s36},
{fin = [(N 68)], trans = s36},
{fin = [(N 48),(N 64)], trans = s0},
{fin = [(N 7),(N 64)], trans = s40},
{fin = [(N 7)], trans = s40},
{fin = [(N 4)], trans = s0},
{fin = [(N 78)], trans = s0},
{fin = [(N 78)], trans = s44},
{fin = [(N 76)], trans = s0},
{fin = [(N 73)], trans = s0}]
end
structure StartStates =
	struct
	datatype yystartstate = STARTSTATE of int

(* start state definitions *)

val COMM = STARTSTATE 3;
val INITIAL = STARTSTATE 1;

end
type result = UserDeclarations.lexresult
	exception LexerError (* raised if illegal leaf action tried *)
end

fun makeLexer yyinput = 
let 
	val yyb = ref "\n" 		(* buffer *)
	val yybl = ref 1		(*buffer length *)
	val yybufpos = ref 1		(* location of next character to use *)
	val yygone = ref 1		(* position in file of beginning of buffer *)
	val yydone = ref false		(* eof found yet? *)
	val yybegin = ref 1		(*Current 'start state' for lexer *)

	val YYBEGIN = fn (Internal.StartStates.STARTSTATE x) =>
		 yybegin := x

fun lex (yyarg as (lineNo:int ref,pCount:int ref)) =
let fun continue() : Internal.result = 
  let fun scan (s,AcceptingLeaves : Internal.yyfinstate list list,l,i0) =
	let fun action (i,nil) = raise LexError
	| action (i,nil::l) = action (i-1,l)
	| action (i,(node::acts)::l) =
		case node of
		    Internal.N yyk => 
			(let val yytext = substring(!yyb,i0,i-i0)
			     val yypos = i0+ !yygone
			open UserDeclarations Internal.StartStates
 in (yybufpos := i; case yyk of 

			(* Application actions *)

  12 => (Tokens.NUM (cvstringtoint yytext, !lineNo, !lineNo))
| 15 => (case find yytext of SOME v => v(yytext,!lineNo,!lineNo)
			       | _ => Tokens.ACT(yytext,!lineNo,!lineNo))
| 18 => (case find yytext of SOME v => v(yytext,!lineNo,!lineNo)
			       | _ => Tokens.ID(yytext,!lineNo,!lineNo))
| 2 => (inc lineNo; continue())
| 20 => (Tokens.EQUALS(!lineNo,!lineNo))
| 22 => (inc pCount; Tokens.LPAR(!lineNo,!lineNo))
| 24 => (dec pCount; Tokens.RPAR(!lineNo,!lineNo))
| 26 => (Tokens.LBRACK(!lineNo,!lineNo))
| 28 => (Tokens.RBRACK(!lineNo,!lineNo))
| 30 => (Tokens.LBRACE(!lineNo,!lineNo))
| 32 => (Tokens.RBRACE(!lineNo,!lineNo))
| 34 => (Tokens.isLESS(!lineNo,!lineNo))
| 36 => (Tokens.isGREATER(!lineNo,!lineNo))
| 38 => (Tokens.PLUS(!lineNo,!lineNo))
| 4 => (inc lineNo; if !pCount > 0 then continue()
			       else Tokens.EOL(!lineNo,!lineNo))
| 40 => (Tokens.PAR(!lineNo,!lineNo))
| 42 => (Tokens.DOT(!lineNo,!lineNo))
| 44 => (Tokens.COMMA(!lineNo,!lineNo))
| 46 => (Tokens.SEMICOLON(!lineNo,!lineNo))
| 48 => (Tokens.BANG(!lineNo,!lineNo))
| 50 => (Tokens.QUERY(!lineNo,!lineNo))
| 52 => (Tokens.SLASH(!lineNo,!lineNo))
| 54 => (Tokens.BACKSLASH(!lineNo,!lineNo))
| 56 => (Tokens.QUOTE(!lineNo,!lineNo))
| 58 => (Tokens.HAT(!lineNo,!lineNo))
| 60 => (Tokens.SHARP(!lineNo,!lineNo))
| 62 => (Tokens.AMPERSAND(!lineNo,!lineNo))
| 64 => (error ("ignoring bad character "^yytext,!lineNo,!lineNo);
	             continue())
| 68 => (Tokens.STRING(substring(yytext,1,(size yytext)-2),!lineNo,!lineNo))
| 7 => (continue())
| 71 => (YYBEGIN COMM; continue())
| 73 => (inc lineNo; continue())
| 76 => (YYBEGIN INITIAL; continue())
| 78 => (continue())
| 9 => (Tokens.NIL(!lineNo,!lineNo))
| _ => raise Internal.LexerError

		) end )

	val {fin,trans} = Vector.sub(Internal.tab, s)
	val NewAcceptingLeaves = fin::AcceptingLeaves
	in if l = !yybl then
	     if trans = #trans(Vector.sub(Internal.tab,0))
	       then action(l,NewAcceptingLeaves
) else	    let val newchars= if !yydone then "" else yyinput 1024
	    in if (size newchars)=0
		  then (yydone := true;
		        if (l=i0) then UserDeclarations.eof yyarg
		                  else action(l,NewAcceptingLeaves))
		  else (if i0=l then yyb := newchars
		     else yyb := substring(!yyb,i0,l-i0)^newchars;
		     yygone := !yygone+i0;
		     yybl := size (!yyb);
		     scan (s,AcceptingLeaves,l-i0,0))
	    end
	  else let val NewChar = ordof(!yyb,l)
		val NewState = if NewChar<128 then ordof(trans,NewChar) else ordof(trans,128)
		in if NewState=0 then action(l,NewAcceptingLeaves)
		else scan(NewState,NewAcceptingLeaves,l+1,i0)
	end
	end
(*
	val start= if substring(!yyb,!yybufpos-1,1)="\n"
then !yybegin+1 else !yybegin
*)
	in scan(!yybegin (* start *),nil,!yybufpos,!yybufpos)
    end
in continue end
  in lex
  end
end
