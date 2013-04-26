(*
 *
 * $Log: automata.sml,v $
 * Revision 1.2  1998/06/10 16:58:41  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(* August 1990, Jussi Rintanen, Helsinki University of Technology *)

(* The tree pattern matching automata builder

  This is the final version of the machine builder of ML-Twig.
  The machine builder takes as input a list of rules, constructs
  a finite state automaton directly from the tree patterns. In the prototype
  version, a string was constructed and returned, but the complexity of
  constructing large strings from small constituent strings by catenating
  them is not very good, so we have a separate function for printing
  the automaton.

*)

signature AUTOMATA =
  sig
    exception AutomatonError of string
    structure Parser : PARSER
    val build_automaton: outstream * Parser.symbol list * Parser.rule list -> unit
end;

(* This is the second version of ML-Twig Automata Builder.
We note, that the first version was purely functional (without side-effects)
and was based on a general structure constructing Aho-Corasick automata
for string matching. However, the first version was considered too complex
and inefficient, and we decided to rewrite it from scratch.
  This revised version constructs a trie, which is represented by an array.
The trie is built directly from tree patterns, and explicit construction
of path strings is avoided.
For detailed description we refer to [Aho,Corasick] and [Hoffmann,O'Donnell].
*)

functor MAKEautomata (structure Parser : PARSER): AUTOMATA =
  struct
    exception AutomatonError of string

    fun fatal s = raise AutomatonError s
      
(* This structure represents an abstract trie with extensions for
   string pattern matching automaton construction. We have assumed,
   that the implementation has side-effects, and for efficiency
   an array is used. *)
      
    structure Implementation :
      sig
	structure Parser : PARSER
	datatype alpha = Sym of Parser.symbol | Child of int
	type automaton
	val empty_automaton : unit -> automaton
	val add_arc : automaton * int * alpha -> automaton * int
	val add_finals : automaton * int * (int * int * Parser.symbol) list -> automaton
	val set_failure : automaton * int * int -> automaton
	val get_failure : automaton * int -> int
	val get_finals : automaton * int -> (int * int * Parser.symbol) list
	val get_transitions : automaton * int -> (alpha * int) list
	val last_state : automaton -> int
      end
    =
    struct
      structure Parser : PARSER = Parser
      open Parser
      datatype alpha = Sym of symbol | Child of int
      type state = ((int * int * symbol) list * (alpha * int) list * int)
      type automaton = state Array.array * int * int

      fun empty_automaton () = (Array.array (400, ([],[],0)), 400, 1)

      fun add_arc (trie as (a,b,c),i,iota) =
	let val (fs,ts,f) = Array.sub(a,i)
	  fun go nil = ~1 | go ((on,to) :: t) =	if iota = on then to else go t
	  val destination = go ts
	in
	  if destination <> ~1
	    then (trie,destination)
	  else
	    if b = c
	      then
		let val newsize = b*3 div 2
		  val newa = Array.array (newsize, ([],[],0))
		  val rec copya = fn 0 => Array.update(newa,0,Array.sub(a,0))
				   | n => (Array.update(newa,n,Array.sub(a,n)); 
					   copya (n-1))
		in
		  copya (b-1); ((newa,newsize,c+1),c)
		end
	    else (Array.update(a,i,(fs,(iota,c)::ts,f));((a,b,c+1),c))
	end
	  
      fun set_failure (trie as (a,b,c),i,f) =
	let val (fs,ts,f') = Array.sub(a,i)
	in
	  (Array.update (a,i,(fs,ts,f));
	   trie)
	end
      
      fun add_finals (trie as (a,b,c),i,f) =
	let val (fs,ts,s) = Array.sub(a,i)
	in
	  (Array.update (a,i,(f@fs,ts,s));
	   trie)
	end
      
      fun get_finals ((a,b,c),i) = let val (fs,ts,s) = Array.sub(a,i) in fs end
      fun get_failure ((a,b,c),i) = let val (fs,ts,s) = Array.sub(a,i) in s end
      fun get_transitions ((a,b,c),i) = let val (fs,ts,s) = Array.sub(a,i) in ts end
      fun last_state (a,b,c) = c-1

    end

    structure Parser = Parser

    open Implementation Parser

    val int2str : int -> string = makestring

    val accum = revfold

(* This function traverses a tree pattern and concurrently adds arcs
   to the trie representation of a tree pattern matching automaton. *)

    fun add_pattern (autom, rule1, nont, Leaf n, state, len) =
      let val (autom', state') = add_arc (autom, state, Sym n)
      in add_finals (autom', state', [(len,rule1,nont)]) end
      | add_pattern (autom, rule1, nont, Tree (n, cs), state, len) =
	let val (autom', state') = add_arc (autom, state, Sym n)
	  val (autom'''',_) =
	    accum
	    (fn (c,(autom'', cn)) =>
	       let val (autom''', state'') = add_arc (autom'', state', Child cn)
	       in
		 (add_pattern (autom''', rule1, nont, c, state'', len+1), cn + 1)
	       end)
	       cs (autom', 1)
	in
	  autom''''
	end

    fun go (au, s, i) =
      let
	val ts = get_transitions(au, s)
	val rec g = fn nil => ~1 | ((p,q)::t) => if p=i then q else g t
      in g ts
      end

    fun oflevel1 au = let val ts = get_transitions(au, 0)
		      in map (fn (p,q) => q) ts
		      end
			
    fun iterate (au, nil, nil) = au
      | iterate (au, nil, next) = iterate (au,next,nil)
      | iterate (au, h::t, next) =
	let val f = get_failure (au, h)
	  val ts = get_transitions (au, h)
	  val au' = accum (fn ((i,s),aut) =>
			   let val rec fail = fn state =>
			     if go (aut,state,i) <> ~1
			       then go (aut,state,i)
			     else if state=0
				    then 0
				  else fail (get_failure (aut, state))
			   in
			     add_finals(set_failure (aut, s, fail f),
					s,
					get_finals (aut, fail f))
			   end
			 ) ts au
	in
	  iterate (au',t,(map (fn (p,q) => q) ts) @ next)
	end

    fun construct_failure au = iterate (au, oflevel1 au, [])
      
    fun construct_automaton rules =
      let val t1 = (* Trie & final state values *)
	accum
	(fn (Rule(n,_,r,p,_,_),a) => add_pattern (a,n,r,p,0,1))
	   rules
	   (empty_automaton ())
      in
	construct_failure t1 (* Failure & final state values *)
      end

    fun symbol2str (Label s) = "XXX"^s
      | symbol2str (Node (s,_)) = s

    fun arc2str (Sym s) = symbol2str s
      | arc2str (Child n) = "(ARC "^(int2str n)^")"

    fun output_symbols (out,symbols) =
      (out "datatype symbols = ARC of int";
       app
       (fn s => out (" | "^(symbol2str s)))
	  symbols;
	  out "\n")

    fun output_finals' (out,au,n) =
      if n <= last_state au
	then
	  let val finals = get_finals (au,n)
	    fun outfinal (i,j,s) =
	      (out "(";
	       out (int2str i);
	       out ",";
	       out (int2str j);
	       out ",";
	       out (symbol2str s);
	       out ")")
	  in
	    out (int2str n);
	    out " => [";
	      case finals of
		nil => ()
	      | [h] => outfinal h
	      | (h::t) => (outfinal h;app (fn h => (out",";outfinal h)) t);
	    out "]\n  | ";
	    output_finals' (out,au,n+1)
	  end
      else ()

    fun output_finals (out,au) =
      (out "fun get_finals s =\n";
       out "  case s of\n";
       output_finals' (out,au,0);
       out "_ => nil\n\n")

    fun output_goto' (out,au,n) =
      if n <= last_state au
	then
	  let val transitions = get_transitions (au,n)
	  in
	    out (int2str n);
	    out " => (case a of ";
	    app
	    (fn (i,s) =>
	       (out (arc2str i);
	       out " => ";
	       out (int2str s);
	       out " | "))
	       transitions;
	     out " _ => ";
	     if n = 0 then (out "0")
	     else (out "go ("; out (int2str (get_failure (au,n))); out ",a)");
	    out ")\n  | ";
	    output_goto' (out,au,n+1)
	  end
      else ()

    fun output_goto (out,au)  =
      (out "fun go (s,a) =\n";
       out "  case s of\n";
       output_goto' (out,au,0);
       out "_ => 0\n\n")

    fun output_automaton (outstr,au,symbols) =
       let val out = fn s => output (outstr,s)
       in
	 output_finals (out,au);
	 output_goto (out,au);
	 out "val go_f = get_finals o go\n";
	 out "fun childsymbol s = ARC s\n";
	 out "val initialstate = 0\n";
	 out "type state = int\n"
       end
       
     fun build_automaton (outstr,symbols,rules) =
       output_automaton(outstr,construct_automaton rules,symbols)

  end;
