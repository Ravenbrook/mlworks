(*
 *
 * $Log: parser.sml,v $
 * Revision 1.2  1998/06/10 16:57:58  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* April 1989, Jussi Rintanen, Helsinki University of Technology *)

(* Parser is a structure containing a type definition for
   specification elements and a function, which maps
   a specification file to a ML-representation of the specification.

   The ML-representation is a tuple of prologue/insert code-fragments,
   list of tree translation rules, default code fragment for cost,
   a string containing the name for the resulting structure, a datatype
   definition for the result type, and the list of symbols appearing in
   the specification.

*)

signature PARSER =
  sig

    exception ParserError of string

    datatype symbol = Node of string * int | Label of string

    datatype cost = Cost of string list | NoCost
    and action = Action of string list
    and tree_pattern = Leaf of symbol | Tree of (symbol * tree_pattern list)
    and ruletype = Ordinary | Topdown | Rewrite
    and rule = Rule of (int * ruletype * symbol * tree_pattern * cost * action)

    datatype code_fragment = Prologue of string list | Insert of string list

    val specification :	instream ->
	(code_fragment list * rule list * cost * string * string * symbol list)

end;

(*
   The parser is a straightforward predictive parser. It interfaces to the
   lexer through the signature LEXER declared elsewhere. The symbol table
   takes care of various book-keeping tasks of the parser and the
   type checking of the symbols appearing in the rules of a specification.
*)

(* The symbol table is represented by an object of type stable. Declare_label
   and declare_node are used by the functions parsing node and label
   declarations. They add a symbol to the symbol table. By check_symbol, the
   functions parsing rules, the tree pattern in rules, assert a property
   of a symbol. The symbol table checks whether it agrees, and if not,
   it raises the exception SymbolConflict. Otherwise it returns the
   type of the symbol. The function next_rule is used by the
   parser for numbering the rules.
*)

signature SYMBOLTABLE =
  sig
    exception SymbolConflict of string
    datatype class = NonTerminal | Terminal of int | Unknown

    type stable

    val empty_symboltable : stable

    val check_symbol : stable * string * class -> class
    val declare_label : stable * string * string -> stable
    val declare_node : stable * string * int -> stable

    val get_labels : stable -> (string * string) list
    val get_nodes' : stable -> (string * int) list

    val next_rule : stable -> int * stable

end;

structure Symboltable : SYMBOLTABLE =
  struct

    exception SymbolConflict of string

    datatype class = NonTerminal | Terminal of int | Unknown

    type stable = (string -> class) * int * (string * string) list * (string * int) list

    fun conflict s = raise SymbolConflict s

    val empty_symboltable =
      (fn s => conflict ("symbol "^s^" is not declared"),0,[],[])

    val int2str : int -> string = makestring

(* Check checks, whether a symbol is of correct type. It impossible for the
   parser to distinguish a label from a node symbol of arity 0 (a leaf symbol),
   and therefore the parser may assert the property unknown for labels and
   symbols of arity 0.
*)

    fun check_symbol ((symbols,rn,ls,ns),s,p') =
      let val p = symbols s
      in
	(case p of
	   NonTerminal =>
	     (case p' of
		Terminal _ => conflict ("symbol "^s^" was declared a node")
	      | _ => p)
	 | Terminal a =>
	     (case p' of
		Unknown =>
		  if a=0 then p
		  else conflict ("symbol "^s^" is a node symboll with arity "^(int2str a))
	      | Terminal a' => if a=a'
				 then p
			       else conflict ("symbol "^s^" is of arity "^(int2str a))
	      | _ => conflict ("symbol "^s^" is a node symbol"))
	 | _ => conflict "internal error, unknown symbol in table")
      end

(* Declare_label and declare_node just extend the function. *)

    fun declare_label (st as (symbols,rn,ls,ns),s,ty) =
      ((fn s' => if s' = s then NonTerminal else symbols s'),
       rn,(s,ty)::ls,ns)

    fun declare_node (st as (symbols,rn,ls,ns),s,a) =
      ((fn s' => if s' = s then Terminal a else symbols s'),
       rn,ls,(s,a)::ns)

    fun next_rule (symbols, rn, ls, ns) = (rn,(symbols, rn+1, ls, ns))

    fun get_labels (_,_,ls,_) = ls
    fun get_nodes' (_,_,_,ns) = ns
  end;


functor MAKEparser (structure Symboltable : SYMBOLTABLE
		    and Lexer : LEXER) : PARSER =
  struct
      
    open Symboltable Lexer
    
    exception ParserError of string

    datatype symbol = Node of string * int | Label of string

    datatype cost = Cost of string list | NoCost
    and action = Action of string list
    and tree_pattern = Leaf of symbol | Tree of (symbol * tree_pattern list)
    and ruletype = Ordinary | Topdown | Rewrite
    and rule = Rule of (int * ruletype * symbol * tree_pattern * cost * action)

    datatype code_fragment = Prologue of string list | Insert of string list

    val lexf : (unit -> lexresult) ref = ref (fn () => COLON)

    val int2str : int -> string = makestring

    fun error s =
      raise ParserError ("Error in Line "^(int2str (current_line()))^" : "^s)

    local
      fun digit c = ("0" <= c) andalso (c <= "9")
      fun str2int' (a,c::r) =
	if digit c
	  then str2int' (a*10 + ord c - ord "0" ,r)
	else (a,c::r)
	| str2int' r = r
    in
      fun str2int s =
	case str2int' (0,(explode s)) of
	  (i,[]) => i
	| _ => error "parser internal"
    end

    fun treeref_string' (s,[]) = s
      | treeref_string' (s, h::t) =
	treeref_string' ("(get_subtree (" ^ (int2str h) ^ "," ^ s ^ "))", t)

    fun treeref_string l = treeref_string' ("ir",l)

    fun parsespecification (s,st) =
      case lexer() of
	IDENTIFIER "prologue" => parse_prologue (s,st)
      | IDENTIFIER "insert" => parse_insert (s,st)
      | IDENTIFIER "node" => parse_node (s,st)
      | IDENTIFIER "label" => parse_label (s,st)
      | IDENTIFIER "default_cost" => parse_defaultcost (s,st)
      | IDENTIFIER "structure_name" => parse_structurename (s,st)
      | IDENTIFIER n =>
	  let val replacement = if n = "TOPDOWN" orelse n = "REWRITE"
				  then
				    case lexer() of
				      IDENTIFIER n' => n'
				    | _ => error ("identifier expected after rule kind specifier" ^n)
				else n
	      val _ = check_symbol (st,replacement,NonTerminal)
	  in parse_rule (case n of
			 "TOPDOWN" => Topdown
		       | "REWRITE" => Rewrite
		       | _ => Ordinary,
			   Label replacement, s, st)
	  end
      | EOF => (s,st)
      | _ => error "Syntax Error"

    and parse_prologue (([],a,b,c), st) =
      parsespecification (([Prologue (read_ml_semicolon ())],a,b,c), st)
      | parse_prologue _ = error "duplicate prologue"

    and parse_insert(([],a,b,c), st) = error "insert may not precede prologue"
      | parse_insert ((l,a,b,c), st) =
	parsespecification ((l @ [Insert (read_ml_semicolon ())],a,b,c), st)

    and parse_defaultcost ((a,b,NoCost,d),st) =
      parsespecification ((a,b,Cost (read_ml_semicolon ()),d), st)
      | parse_defaultcost _ = error "duplicate default cost"

    and parse_node (s, st) =
      case lexer() of
	IDENTIFIER id =>
	  (case lexer() of
	     LPAREN =>
	       (case lexer() of
		  INT i =>
		    (case lexer() of
		       RPAREN =>
			 (case lexer() of
			    COMMA => parse_node (s,declare_node (st, id, str2int i))
			  | SEMICOLON => parsespecification (s, declare_node (st, id, str2int i))
			  | _ => error ", or ; expected")
		     | _ => error "')' expected")
		| _ => error "integer expected")
	   | _ => error " ( expected")
      | _ => error "node declaration"

    and readtype () =
      case lexerS() of
	OTHER "|" => ("",OTHER "|")
      | SEMICOLON => ("",SEMICOLON)
      | EOF => error "premature eof"
      | t => let val (s,r) = readtype() in ((token2str t) ^ s,r) end
	  
    and parse_label (s, st) =
      case lexer() of
	IDENTIFIER id =>
	  (case lexer() of
	     IDENTIFIER "of" =>
	       let val (tyexpr, token) = readtype ()
	       in
		 case token of
		   OTHER "|" => parse_label (s,declare_label(st,id,tyexpr))
		 | SEMICOLON => parsespecification(s,declare_label(st,id,tyexpr))
		 | _ => error "label list"
	       end
	   | _ => error "label list"
	       )
      | _ => error "label list"
      
    and token2str t =
      case t of
	IDENTIFIER s => s
      | INT s => s
      | EQ => "="
      | COLON => ":"
      | SEMICOLON => ";"
      | COMMA => ","
      | LPAREN => "("
      | RPAREN => ")"
      | TREEREF _ => error "tree references not allowed here"
      | OTHER s => s
      | SPACE s => s
      | EOF => error "cannot convert EOF"

    and token2strX t =
      case t of
	IDENTIFIER s => s
      | INT s => s
      | EQ => "="
      | COLON => ":"
      | SEMICOLON => ";"
      | COMMA => ","
      | TREEREF l => treeref_string l
      | LPAREN => "("
      | RPAREN => ")"
      | OTHER s => s
      | SPACE s => s
      | EOF => error "cannot convert EOF"

    and read_ml_semicolon' () =
      case lexerS() of
      LPAREN => ("(" :: read_ml_semicolon'()) @ (")" :: (read_ml_semicolon'()))
      | RPAREN => []
      | EOF => error "premature EOF"
      | t => (token2str t):: (read_ml_semicolon' ())

    and read_ml_semicolon () =
      if lexer() <> LPAREN then error "'(' expected"
      else
	let val r = read_ml_semicolon' () in
	  if lexer() <> SEMICOLON then error "missing semicolon"
	  else r
	end

    and rulecode' () =
      case lexerS() of
      LPAREN => ("(" :: rulecode'()) @ (rulecode'())
      | RPAREN => [" )"]
      | EOF => error "premature EOF"
      | t => (token2strX t):: (rulecode' ())

    and rulecode () =
	if lexer() <> LPAREN then error "'(' expected"
	else "( " :: (rulecode'())

    and parse_restaction (rn, ty, nt, pattern, costcode, (a,l,b,c), st) =
      let val mlcode = Action (rulecode ())
      in
	if lexer() <> SEMICOLON then error "missing semicolon"
	else
	  let val ps = Rule(rn,ty,nt,pattern,costcode,mlcode)
	  in parsespecification ((a,ps::l,b,c), st)
	  end
      end

    and parse_restcost (rn, ty, nt, pattern, s as (a,l,b,c), st) =
      let val mlcode = Cost (rulecode ())
      in
	case lexer() of
	  EQ => parse_restaction(rn,ty,nt,pattern,mlcode, s, st)
	| _ => error " = expected"
      end

    and parse_rule (ty, nt, s as (a,l,b,c), st) =
      let val (pattern, token) = parse_pattern st
	val (rn,st') = next_rule st
      in
	case token of
	  COLON => parse_restcost (rn, ty, nt, pattern, s, st')
	| EQ =>
	    (case b of
	       NoCost => error "Must specify cost, no default cost defined"
	     | _ => parse_restaction (rn, ty, nt, pattern, NoCost, s, st'))
	| _ => error "one of : = expected"
      end

    and parse_pattern st =
      case lexer() of
	IDENTIFIER id =>
	  (case lexer() of
	     LPAREN => let val subtrees = parse_subtrees st
			   val arity = length subtrees
			   val _ = check_symbol (st, id, Terminal arity)
		       in
			 (Tree (Node (id,arity), subtrees), lexer())
		       end
	   | token => let val p = check_symbol (st, id, Unknown)
		      in
			(case p of
			   NonTerminal => Leaf (Label id)
			 | _ => Leaf (Node (id,0)),
			     token)
		      end)
      | _ => error "ill-formed tree pattern"

    and parse_subtrees st =
      let val (pat, token) = parse_pattern st
      in
	case token of
	  COMMA => let val rest = parse_subtrees st
		   in (pat :: rest)
		   end
	| RPAREN => [pat]
	| _ => error "one of , ) expected in tree pattern"
      end

    and parse_structurename ((a,b,c,_),st) =
      case lexer() of
        IDENTIFIER s => if lexer() = SEMICOLON
			  then parsespecification ((a,b,c,s),st)
			else error "missing ; after structure name"
      | _ => error "structure name was not given"

    and construct_resulttype st =
      let val (first, rest) = case (rev o get_labels) st of
	 first::rest => (first, rest)
       | _ => raise Bind
	  and makeCon = (fn (n,t) => "X_" ^ n ^ " of " ^ t)
      in
	fold (fn (a,b) => a ^ " | " ^ b)
	  (map makeCon rest)
	   (makeCon first)
      end

    and specification instream =
      let val dummy = (lexf := make_lexer instream)
	  val ((a,b,c,d), st) = parsespecification
	    (([],[],NoCost,"TreeProcessor"), empty_symboltable)
      in
	if b = nil orelse a = nil
	  then error "Prologue and rules are obligatory"
	else
	  (a,b,c,d,construct_resulttype st,
	   (map (fn (s,_) => Label s) (get_labels st))@
	   (map (fn n => Node n) (get_nodes' st)))
      end
    handle SymbolConflict s => error ("Symbol Table : "^s)
	 | LexError => error ("Lexical Error")

    and lexerS () = (!lexf)()
		   
    and lexer () =
      case lexerS () of	SPACE _ => lexer() | t => t

  end;
