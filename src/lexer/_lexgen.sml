(*
$Log: _lexgen.sml,v $
Revision 1.63  1998/02/19 14:39:58  jont
[Bug #30341]
Fix where type ... and syntax

 * Revision 1.62  1998/01/30  09:40:56  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.61  1997/11/13  11:17:55  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 * Revision 1.60.2.2  1997/11/20  17:08:59  daveb
 * [Bug #30326]
 *
 * Revision 1.60.2.1  1997/09/11  20:56:12  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.60  1997/05/28  12:05:35  daveb
 * [Bug #30090]
 * Converted lexer to Basis IO.
 *
 * Revision 1.59  1996/11/06  10:55:14  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.58  1996/10/30  15:53:01  io
 * moving String from toplevel
 *
 * Revision 1.57  1996/09/25  10:22:46  matthew
 * Take account of pushed back tokens in eof function
 *
 * Revision 1.56  1996/09/18  15:24:23  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.55  1996/05/07  10:30:22  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.54  1996/04/30  17:36:53  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.53  1996/04/29  13:22:08  matthew
 * Adding Int structure
 *
 * Revision 1.52  1996/03/27  16:56:27  matthew
 * Updating for new language definition
 *
 * Revision 1.51  1996/02/23  16:12:29  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.50  1995/10/10  13:14:10  daveb
 * Removed spurious call to break.
 *
Revision 1.49  1995/03/17  12:13:29  matthew
Removing redundant requires

Revision 1.48  1995/02/23  18:20:59  matthew
Change to Option structure

Revision 1.47  1994/10/24  13:44:43  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.46  1994/08/25  15:12:50  matthew
Commented out call to timer as can't run under NJ.

Revision 1.45  1994/08/25  15:00:03  matthew
Time making the lexer tables.
Bytearrays work now.

Revision 1.44  1994/07/22  15:10:37  matthew
Tried changing arrays to bytearrays.  This failed.  The code is commented out.

Revision 1.43  1994/03/08  14:41:50  daveb
Minor improvements to error messages.  First index of locations now
defined by values in Info.Location.

Revision 1.42  1993/12/23  13:25:06  daveb
Removed mkInteractiveTokenStream.

Revision 1.41  1993/08/12  13:31:22  jont
Modified to allow multiple ungets

Revision 1.40  1993/06/16  10:42:51  matthew
Added single character unGetToken function and lastToken function

Revision 1.39  1993/06/09  16:25:14  matthew
Added text_preprocess function

Revision 1.38  1993/05/18  16:15:37  jont
Removed integer parameter

Revision 1.37  1993/04/01  12:37:42  daveb
Removed the pushback facility of TokenStreams, as its never used.
Added the eof argument to mkLineTokenStream for use with the incremental
parser.

Revision 1.36  1993/03/30  10:01:30  daveb
getToken now takes a Lexerstate argument, and calls the appropriate
function for the state.  Thus we can lex comments and strings that extend
over multiple lines in the shell.
Tokenstream is now a datatype, to make type checking easier.

Revision 1.35  1993/03/24  11:25:20  daveb
lex now takes an options parameter, passed to it by getToken.

Revision 1.34  1993/03/02  15:31:12  jont
Some speed improvements

Revision 1.33  1993/01/15  14:10:55  jont
Modified to give ranges for locations, from start to end of token

Revision 1.32  1992/12/21  11:07:59  matthew
Change to allow token streams to be created with a given initial line number.

Revision 1.31  1992/12/10  19:27:25  matthew
Print non-printable characters sensibly in error messages.

Revision 1.30  1992/12/08  15:01:18  matthew
Hack to handle unclosed comments and strings

Revision 1.29  1992/11/30  15:40:01  jont
removed function involving map in favour of Lists.reducel

Revision 1.28  1992/11/20  13:47:19  matthew
Added an "unget" facility.

Revision 1.27  1992/11/19  14:33:10  matthew
Added flush_to_nl

Revision 1.26  1992/11/17  14:25:32  matthew
Changed Error structure to Info

Revision 1.25  1992/11/09  18:38:22  daveb
Added clear_eof function.

Revision 1.24  1992/10/30  16:38:31  matthew
Changed file token stream to not be interactive.

Revision 1.23  1992/10/14  11:30:52  richard
Added line number to token stream input functions.
Added mkFileTokenStream.

Revision 1.22  1992/10/02  16:39:26  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.21  1992/09/04  08:36:06  richard
Installed central error reporting mechanism.

Revision 1.20  1992/09/01  10:18:10  richard
Added missing require.

Revision 1.19  1992/08/31  17:04:01  richard
Replaced LexBasics error handler by proper global error handler,
and propagated more information through to the action functions
so that they can report error positions accurately.

Revision 1.18  1992/08/26  13:02:32  matthew
Added interactive slot to token streams.

Revision 1.17  1992/08/18  15:07:50  davidt
Made various changes to work with new inbuffer and ndfa signatures.

Revision 1.16  1992/08/15  14:31:59  davidt
Did a few optimisations and removed the stuff to do with the self reference.

Revision 1.15  1992/08/14  17:43:28  jont
Removed all currying from inbuffer

Revision 1.14  1992/08/05  14:40:42  jont
Removed some structures and sharing

Revision 1.13  1992/07/28  14:33:18  jont
Removed Array parameter, so it now uses pervasive Array.
Decurried numerous functions that didn't need it.

Revision 1.12  1992/07/28  11:49:07  matthew
Put in error message when EOF is encountered, and a token is being built.
This is intended for strings, but doesn't work as strings are returned as
a sequence of IGNORE tokens.

Revision 1.11  1992/05/19  17:03:29  clive
Fixed line position output from lexer

Revision 1.10  1992/05/14  12:00:35  richard
Added IGNORE token to remove recursion from lexing of comments and strings.

Revision 1.9  1992/05/06  10:35:06  richard
Changed BalancedTree to generic Map

Revision 1.8  1992/04/13  13:38:09  clive
First version of the profiler

Revision 1.7  1992/04/02  12:13:07  matthew
Changed EOF handling to allow tail recursion

Revision 1.6  1992/03/23  15:27:04  matthew
Added line numbering

Revision 1.5  1992/03/10  12:26:02  matthew
Errors signalling changed to call report_lex_error and continue rather than raise
an exception.

Revision 1.4  1992/01/31  18:23:48  jont
Removed use of myarray, replaced by array.sml

Revision 1.3  1992/01/28  15:09:25  jont
Added type information to allow our typechecker to elaborate it

Revision 1.2  1991/10/11  13:36:25  davidt
Major modifications, including a more abstract implementation of ndfa's
(more efficient as well). This generator is still pretty slow compared
to `flex' and other generators written in C but I don't want to do any
more optimisations without a profiler. Currently the subsets generated
by the subset construction are sorted using quicksort, this could actually
be done on O(n) time because we know the range of numbers we are sorting
(0 ... number of states in ndfa) and hence we could use an array sort
(or whatever its called). However, I'm not convinced this is where all
the time is being spent. Replacing balanced trees with hash tables
might well give a bigger performance win.

Revision 1.1  91/09/06  16:48:36  nickh
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../basis/__int";
require "../basis/__text_io";
require "../basis/__text_prim_io";

require "../utils/lists";
require "../utils/map";
require "../utils/mlworks_timer";
require "../basics/token";
require "ndfa";
require "lexrules";
require "lexer";

functor LexGen (structure Lists : LISTS
		structure Map : MAP
                structure Timer : INTERNAL_TIMER
		structure Token : TOKEN
		structure Ndfa : NDFA where type action = int where type state = int
		structure LexRules : LEXRULES
                sharing type LexRules.Result = Token.Token
                  
                  ) : LEXER = 
struct
  structure Token = Token
  structure RegExp = LexRules.RegExp
  structure Info = LexRules.Info
  structure InBuffer = LexRules.InBuffer
  
  type Options = LexRules.options
  type Result = LexRules.Result

  local
    val column = ref 0
  in
    fun printDot () =
      let
	val c = !column
      in
	if c = 70 then
	  (print ".\n"; column := 0)
	else
	  (print "."; column := c + 1)
      end
  end

  (* returns a counting function from m+1 *)
	
  fun counter m = let val n = ref m in fn () => (n := (!n)+1; !n) end
  
  (* insertion-sort on int lists *)
  
  fun quicksort ([], accum) = accum
    | quicksort (pivot :: rest, accum) = 
      partition (pivot, [], [], rest, accum)

  and partition (pivot, left, right, [], accum) =
    quicksort (left, pivot :: quicksort (right, accum))
    | partition (pivot, left, right, y::ys, accum) =
      if (y : int) < pivot then partition (pivot, y :: left, right, ys, accum)
      else if y > pivot then partition (pivot, left, y :: right, ys, accum)
	   else partition (pivot, left, right, ys, accum)

  val canonical = fn L => quicksort (L,[]) 

  (* first int is the node number, which we use to form subsets.  second
   int is the action number (there is a fixed list of actions), which we
   use to do comparisons. This is 0 if this node is non-accepting, and
   higher action numbers take precedence *)
      
  (* the first int is the node number, the second int is the action number *)
      
  datatype DfaNode = D of MLWorks.Internal.ByteArray.bytearray * int * int
      
  (* The int array array is the transitions, the int array is the
   actions. The initial state is always state 1, the unreachable state is
   always state 0 *)
      
  datatype Dfa = DFA of MLWorks.Internal.ByteArray.bytearray MLWorks.Internal.Array.array * int MLWorks.Internal.Array.array
      
  (*
   trans_subset returns the node-numbers of all the transitions from all
   the nodes in the subset
   *)
      
  fun loop (_, _, [], accum) = accum
    | loop (char, ndfa, state :: rest, accum) =
      loop (char, ndfa, rest, Ndfa.get_char (char, Ndfa.transitions (ndfa,state), accum))

  fun trans_subset arg (*(char, ndfa, subset)*) =
    Lists.filter(loop arg(*(char, ndfa, subset,[])*))

  (* epsclosure: returns the epsilon-closure of the subset in the ndfa *)
      
  fun epsclosure'(_, [], subset) = subset
    | epsclosure'(ndfa, state :: rest, subset) =
      let
	val new = Lists.filter (Ndfa.get_epsilon (Ndfa.transitions (ndfa, state), rest))
      in
	epsclosure'(ndfa, new, state :: subset)
      end

  fun epsclosure arg = canonical (epsclosure' arg)

  (*
   Returns the highest action number from a list of node numbers. Need
   this because when we transform to DFA, this action is the one we want
   for each subset node. If none of the nodes have an action, return 0.
  *)
      
  fun best_action(ndfa, l) =
    Lists.reducel
    (fn (m, state) =>
     let
       val an = Ndfa.action(ndfa, state)
     in
       if an > m then an else m
     end)
    (0, l)
			   
  (*
   This function will consider the empty state (corresponding to no
   NDFA states) as distinct from other states, so we should get
   termination for free by checking for that state. Alternatively, it
   would be nice to spot that state separately so that we don't have to
   record transitions to it in the list. Alternatively too, it doesn't
   matter since this DFA is only temporary.
  *)

  local      
    fun loop (n :: ns, res:int) = loop (ns, n + res)
      | loop ([], res) = res
    val total = fn L => loop (L,0) 
  in
    fun transform ndfa =
      let
	val nextnode = counter 1
	val init = epsclosure(ndfa, [Ndfa.start ndfa], [])
	val unmarkedstates = (ref []) : (int list * int) list ref
	(* state zero is empty (terminating), state 1 is initial *)
	val markedstates = (ref [D (MLWorks.Internal.ByteArray.array(256,0),0,0)]) : DfaNode list ref
	val currentstate = ref (init,1)
	(* keep a `hash-value' (the total) with each state to speed searching *)

	local
	  fun loop ([],[]) = false
	    | loop (_ ,[]) = false
	    | loop ([], _) = true
	    | loop ((h1:int)::t1,h2::t2) =
	      if h1 < h2 then true
	      else if h1 > h2 then false
		   else loop (t1,t2)
	in
	  fun ordering ((hash1:int, subset1), (hash2, subset2)) =
	    if hash1 < hash2 then true
	    else if hash1 > hash2 then false
		 else loop (subset1, subset2)
	end

	local
	  fun loop ([],[]) = true
	    | loop (_ ,[]) = false
	    | loop ([], _) = false
	    | loop ((h1:int)::t1,h2::t2) =
	      if h1 < h2 then false
	      else if h1 > h2 then false
		   else loop (t1,t2)
	in
	  fun ordering_eq ((hash1:int, subset1), (hash2, subset2)) =
	    if hash1 < hash2 then false
	    else if hash1 > hash2 then false
		 else loop (subset1, subset2)
	end

	val states = ref (Map.from_list (ordering,ordering_eq) [((0, []), 0), ((total init, init), 1)])
	
	(* Adds a state to the unmarked list and gives it a number *)
	fun addstate (t,l) =
	  let
	    val nodeno = nextnode ()
	    val actno = best_action(ndfa, l)
	  in
	    unmarkedstates := (l,nodeno) :: (!unmarkedstates);
	    states := Map.define (!states, (t,l), nodeno);
	    printDot();
	    nodeno
	  end

	(* Returns number of this state, adding if necessary *)
	fun find subset =
	  let
	    val t = total subset
	  in
	    case Map.tryApply'(!states, (t,subset)) of
	      SOME answer => answer
	    | _ => addstate(t,subset)
	  end

	(* Returns the transition table: an int array *)
	fun loop (res, c, subset, ndfa) =
	  if c < 0 then res
	  else loop(find(epsclosure(ndfa, trans_subset(c, ndfa, subset, []), [])) ::
		    res, c-1, subset, ndfa)

        (* If we are using bytearrays, better check this *)
        exception NotAByte
        fun check [] = ()
          | check (n::rest) = 
            if n < 0 orelse n > 255
              then raise NotAByte
            else check rest

 	fun transtable subset = 
          let
            val elements = (loop([], 255, subset, ndfa))
            val _ = check elements
          in
(*
            app
            (fn n => output(std_out,Int.toString n ^ ", "))
            elements;
            output(std_out,"\n");
*)
            MLWorks.Internal.ByteArray.arrayoflist elements
          end

	(* Recurses down the list of unmarked states.... *)
	fun doit () =
	  let
	    val (s,n) = !currentstate
	  in
	    (markedstates := (D(transtable s,n,best_action(ndfa, s))) :: (!markedstates);
	     (fn [] => () | (s::ss) => (unmarkedstates := ss;
					currentstate := s;
					doit ()))
	     (!unmarkedstates))
	  end
	(* I can't find a better way to format this.
	 We are applying the fnexp to !unmarkedstates *)
	val _ = doit ()
	val maxnode = nextnode () 
	val trans = MLWorks.Internal.Array.array (maxnode,MLWorks.Internal.ByteArray.array(0,0))
	val actions = MLWorks.Internal.Array.array(maxnode,0)
	fun addit (D(t,n,a)) =
	  (MLWorks.Internal.Array.update(trans,n,t); MLWorks.Internal.Array.update(actions,n,a))
	val _ = app addit (!markedstates)
      in
	DFA(trans,actions)
      end
  end
				      
  (* So now we have ndfa's, dfa's, and a function from one to the other.
   Now we need to get regexps into ndfa's, glue the ndfa's together,
   transform into a dfa, and keep the actions all the way through *)
   
  (* first a function regexp * node list * int * counter -> node list * int
     
   (adds nodes to the list, returning a new list which excludes the start
    and end nodes).  The int arguments is final node number, the int result
    is initial node number (The function generates a number for the
    initial node, and adds it to the list). This uses the constructions
    from the Dragon book (well, sort of). *)
         
  fun re2ndfa regexp ndfa =
    case regexp of
      RegExp.EPSILON =>
	Ndfa.add(ndfa, Ndfa.epsilon [Ndfa.start ndfa])
    | RegExp.NODE s =>
	let
	  fun loop (res, x) =
	    if x < 0 then res
	    else loop(Ndfa.add (res, Ndfa.single_char (MLWorks.String.ordof(s, x), Ndfa.start res)), x-1)
	in
	  loop(ndfa, size s - 1)
	end
    | RegExp.CLASS s =>
	let
	  val start = Ndfa.start ndfa
	    
	  fun loop (res, x) =
	    if x < 0 then Ndfa.mk_trans res
	    else loop ((MLWorks.String.ordof(s, x), start) :: res, x-1)
	in
	  Ndfa.add(ndfa, loop([], size s - 1))
	end
    | RegExp.BAR(s,t) =>
	let
	  val ndfa1 = re2ndfa s ndfa
	  val ndfa2 = re2ndfa t (Ndfa.set_start(ndfa1, Ndfa.start ndfa))
	  val transitions = Ndfa.epsilon [Ndfa.start ndfa1, Ndfa.start ndfa2]
	in
	  Ndfa.add (ndfa2, transitions)
	end
    | RegExp.DOT(s,t) =>
	re2ndfa s (re2ndfa t ndfa)
    | RegExp.STAR s =>
	Ndfa.add_rec (ndfa, re2ndfa s)

    (* Now a function regexp * action * node list * counter -> node list * int
     
     This adds the regexp with the given action, to the node list,
     returning the list and the initial node *)
   
    (* Now a function regexp list * counter -> node list * int list * int,
     where the int list is the list of initial nodes and the int is one
     more than the number of actions. The resulting actions start with 1 at
     the tail of the list of regexps *)
   
    fun convert_regexps [] = (Ndfa.empty, [], 1)
      | convert_regexps (regexp :: rest) =
	let
	  val (ndfa, initials, action) = convert_regexps rest
	  val ndfa' = Ndfa.add_final (ndfa, action)
	  val ndfa'' = re2ndfa regexp ndfa'
	in
	  (ndfa'', (Ndfa.start ndfa'') :: initials, action + 1)
	end
			
    (* Now a function (regexp * (string -> result)) list -> ndfa * ((string -> result) array) *)
  
    fun convert_rules rules =
      let
	val (regexps, actions) = Lists.unzip rules
	val (ndfa, initials, _) = convert_regexps regexps
	val ndfa' = Ndfa.add_start (ndfa, initials)
      in
	(ndfa', MLWorks.Internal.Array.arrayoflist (rev actions))
      end
		   
    (* last but by no means least, (regexp * (string -> result)) list -> dfa * ((string -> result) array) *)

    fun make_dfa rules =
      let
	val (ndfa, actions) = convert_rules rules
	val dfa as DFA(trans, _) = transform ndfa
      in
	print("\nDFA has " ^ Int.toString(MLWorks.Internal.Array.length trans) ^ " states\n");
	(dfa, actions)
      end

(* NJ doesn't like this as the timer functions are unimplemented *)

(*
    val make_dfa =
      fn rules => Timer.xtime ("Making DFA",true,fn () => make_dfa rules)
*)

    (* now lexing itself. lex makes a dfa-walker *)

    fun chr_to_string n =
      if n >= ord #" " andalso n < 127
          then (str o chr) n
      else
        if n < (ord #" ")
          then "^" ^ (str o chr) (n + 64)
        else
          "\\" ^ Int.toString n

    (* Change so that single tokens can be pushed back onto the stream *)
    (* The Token list ref is the list of last tokens read *)

    datatype TokenStream =
      TOKEN_STREAM of 
       {buffer : InBuffer.InBuffer, 
        source_name : string, 
        interactive : bool,
	line_and_col : (int * int) ref, 
        pushed_back : (Token.Token * Info.Location.T) list ref}
      
    fun lex (dfa as DFA (trans,action_numbers), actions)
	    ((error_info, options),
	     ts as TOKEN_STREAM {buffer, source_name = filename,...}
	    ) =
      let
	val startpoint = InBuffer.getpos buffer
        val location =
          Info.Location.POSITION (filename, InBuffer.getlinenum buffer, InBuffer.getlinepos buffer)

	fun lex1 (string,state,finishaction,finishstring,finishpoint,found_one_earlier) =
	  if InBuffer.eof buffer then
	    if found_one_earlier then
	      (InBuffer.position(buffer, finishpoint);
	       MLWorks.Internal.Array.sub (actions,finishaction-1) (location, buffer, finishstring, (error_info, options))
	      )
	    else
              (case string of
                 [] => ()
               | _ =>
                   Info.error
                   error_info
                   (Info.RECOVERABLE, location,
                    "Unexpected end of file");
               LexRules.eof)
	  else
	    let
	      val c = InBuffer.getchar buffer
	      val string = c :: string
	      val newstate = MLWorks.Internal.ByteArray.sub (MLWorks.Internal.Array.sub (trans,state), c)
	    in
	      if newstate = 0 then
		if found_one_earlier then
		  (InBuffer.position(buffer, finishpoint);
		   MLWorks.Internal.Array.sub (actions,finishaction-1) (location, buffer, finishstring, (error_info,options))
		  )
		else
		  (InBuffer.position(buffer, startpoint);
		   let
		     val discard_char = InBuffer.getchar buffer
		   in
                     Info.error
                     error_info
                     (Info.RECOVERABLE, 
                      location, 
                      "Illegal character `" ^ (chr_to_string discard_char) ^ "'");
		     lex (dfa,actions) ((error_info,options), ts)
		   end)
	      else
		let
		  val act = MLWorks.Internal.Array.sub(action_numbers,newstate)
		in
		  if act > 0 then
		    lex1(string,newstate,act,string,InBuffer.getpos buffer,true)
		  else
                    lex1(string,newstate,finishaction,finishstring,finishpoint,found_one_earlier)
		end
	    end

          fun unexpected _ =
            Info.error' error_info
			(Info.FAULT, location, "Unexpected lexical error")
      in
	lex1([], 1, ~1, [], startpoint, false)
      end

    (* lexer takes a (regexp * action) list and produces buffer -> result *)
    (* added an "interactive" boolean *)

    val lexer = (lex o make_dfa) LexRules.rules

    fun fix_input f = (!MLWorks.Internal.text_preprocess) f

    fun mkTokenStream (f, name_of_file) =
      let
	val buffer = InBuffer.mkInBuffer (fix_input f)
      in
	TOKEN_STREAM{buffer=buffer, source_name=name_of_file, interactive=false,
		     line_and_col=
   		       ref(Info.Location.first_line, Info.Location.first_col),
		     pushed_back=ref []}
      end
    
    fun mkLineTokenStream (f, name_of_file, line, eof) =
      let
	val buffer = InBuffer.mkLineInBuffer (fix_input f, line, eof)
      in
	TOKEN_STREAM{buffer=buffer, source_name=name_of_file, interactive=false,
		     line_and_col=ref(line,Info.Location.first_col),
		     pushed_back=ref []}
      end
    
    fun mkFileTokenStream (instream, name_of_file) =
      let
        val (TextPrimIO.RD {readVec, ...}, vec) =
          TextIO.StreamIO.getReader (TextIO.getInstream instream)

        fun input_fn _ = case readVec of
          NONE => raise Fail "readVec not supported.\n"
        | SOME rv => rv 4096
        (* The figure of 4096 has been empirically determined for the lexer. *)
      in
	mkTokenStream (input_fn, name_of_file)
      end
    
    (* The action taken by getToken depends on the lexer state.  IGNORE tokens
       are dealt with here, both for abstraction and for efficiency.  Other
       tokens are returned.  EOFs in comments or strings are handled
       appropriately by the parser functions in ../parser/_parser. *)
    fun getToken error_info
      (options, Token.IN_COMMENT n,
       ts as TOKEN_STREAM{buffer=b, source_name=file, ...}) =
      (case LexRules.read_comment (b, n) of
         Token.IGNORE =>
           getToken error_info (options, Token.PLAIN_STATE, ts)
       | t => t)
      | getToken error_info
	(options, Token.IN_STRING s,
	 ts as TOKEN_STREAM{buffer=b, source_name=file, line_and_col=ref (line, col),
			     ...}) =
	let
	  val result =
	    LexRules.continue_string
	    (Info.Location.EXTENT {name = file, s_line = line, s_col = col,
				   e_line = line, e_col = col},
	     b, error_info, s)
	in
	  result
	end
      | getToken error_info (options, Token.PLAIN_STATE,
			     ts as TOKEN_STREAM{buffer=b, pushed_back=list as ref ((x,_) :: xs),
                                                ...}) =
        (list := xs;
	 x)

      | getToken error_info (options, Token.PLAIN_STATE,
			     ts as TOKEN_STREAM{buffer=b, line_and_col=loc, pushed_back=ref [],
						...}) =
          let
            fun get Token.IGNORE =
	      (loc := (InBuffer.getlinenum b, InBuffer.getlinepos b);
	       get (lexer ((error_info, options), ts))
	      )
	      |get other = other
	    val result = get Token.IGNORE
          in
	    result
          end

    fun associated_filename (TOKEN_STREAM{source_name, ...}) = source_name
    fun locate (TOKEN_STREAM {buffer, source_name, pushed_back,line_and_col,...}) =
      case !pushed_back of
        (_,loc) :: _ => loc
      | _ =>
          let
            val ref (s_line, s_col) = line_and_col
          in
            Info.Location.EXTENT
            {name=source_name, s_line=s_line, s_col=s_col,
             e_line=InBuffer.getlinenum buffer, e_col=InBuffer.getlinepos buffer}
          end
    fun eof (TOKEN_STREAM{buffer=b, pushed_back, ...}) = 
      !pushed_back = [] andalso InBuffer.eof b
    fun clear_eof (TOKEN_STREAM{buffer=b, ...}) = InBuffer.clear_eof b
    fun is_interactive (TOKEN_STREAM{interactive, ...}) = interactive
    fun flush_to_nl (TOKEN_STREAM{buffer=b, ...}) = InBuffer.flush_to_nl b

    fun ungetToken (tokloc, TOKEN_STREAM{pushed_back, ...}) =
      pushed_back := tokloc :: !pushed_back

  end
