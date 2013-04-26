(*
 *
 * $Log: _code.sml,v $
 * Revision 1.2  1998/06/08 13:05:04  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*		Jo: A concurrent constraint programming language
			(Programming for the 1990s)
			
				Andrew Wilson
				
		       Description of internal code

			   9th November 1990
========================================================================
	                     the functor

version of July 1996 modified to use Harlequin MLWorks separate 
compilation system.
*)


require "store";
require "code";
require "__lowlevel";

	(* NOTE: VARIABLE has two integers after its name:	*)
	(*  the first gives an index into an array of object    *)
	(* references; the second an index into a suspension	*)
	(* queue.						*)

	(* The POINTER class is only used in the unification   	*)
	(* algorithm.						*)
	
	(* the PARAMETER class is used when matching procedure  *)
	(* calls to procedure clauses.  Necessary for matcher,  *)
	(* because they have no value when being matched!	*)

	(* the UNKNOWN class used to store the dynamic values of *)
	(* variables.						 *)





functor Code(structure Store: STORE):CODE =
struct

		(* object forms *)

  datatype sorts = variable | wildcard | atomic | tree | number
  datatype object = VOID
		  | UNKNOWN of int
		  | POINTER of string * int * bool ref * int ref * object ref
		  | VARIABLE of string * int 
	          | PARAMETER of string * int
  		  | WILDCARD
		  | ATOMIC of string
		  | HERBRAND of object * object list * object

                  | INFINITY	| MINFINITY
	          | NUMBER of real
		  | RANGE of object * bool * bool * object
		  | PLUS of object * object
		  | MINUS of object * object
		  | TIMES of object * object
		  | DIVIDES of object * object



  fun isUnknown(UNKNOWN _) = true
    | isUnknown(_) = false

  fun isNumber(NUMBER _) = true
    | isNumber(RANGE _) = true
    | isNumber(PLUS _) = true
    | isNumber(MINUS _) = true
    | isNumber(TIMES _) = true
    | isNumber(DIVIDES _) = true
    | isNumber(POINTER(_,_,_,_,v)) = isNumber(!v)
    | isNumber _ = false


  fun isConstant(INFINITY) = true
    | isConstant(MINFINITY) = true
    | isConstant(NUMBER _) = true
    | isConstant(POINTER(_,_,_,_,v)) = isConstant(!v)
    | isConstant _ = false



  fun isRange(RANGE _) = true
    | isRange(POINTER(_,_,_,_,v)) = isRange(!v)
    | isRange _ = false



	(* WORD:  for pretty printing code forms.		*)

    datatype word = combinator of string
		   | separator of string
		   | terminator of string
		   | openParen of string
		   | closeParen of string
		   | characters of string





	(* OBJECTTOWORDS: converts an object to a list of strings. *)
	(* each string is a separate word.  These words are used  *)
	(* by the listing pretty printer, when giving answers,    *)
	(* when tracing, and when examining the suspension queue. *)

  fun objectToWords(VOID) = [characters "nil"]
    | objectToWords(UNKNOWN x) = [characters ("?000_"^(makeString x))]
    | objectToWords(POINTER(_,_,_,_,v)) = objectToWords(!v)
    | objectToWords(VARIABLE(n,_)) = [characters n]
    | objectToWords(PARAMETER(n,_)) = [characters n]
    | objectToWords(WILDCARD) = [characters "_"]
    | objectToWords(ATOMIC a) = [characters a]
    | objectToWords(HERBRAND(n,kids,rest)) = 
	let
	   val functorword = objectToWords(n)
	   val children = kidsToWords(kids)
	   val restwords = objectToWords(rest)
	 in
	   functorword@
	   ((openParen "<")::(children))@
	   (case restwords
   	     of [characters "nil"] => [closeParen ">"]
	      | X::(openParen "<")::Y => 
		  if [X]=functorword 
			then (separator ",")::Y
			else ((separator "\\")::X::(openParen "<")::Y)@
			     [closeParen ">"]
	      | X => ((separator "\\")::X)@[closeParen ">"]
	   )
	 end

    | objectToWords(INFINITY) = [characters "inf"]
    | objectToWords(MINFINITY) = [characters "~inf"]
    | objectToWords(NUMBER x) = 
		let val xint = floor(x)
		 in
		   if xint= ~(floor(~x)) 
			then [characters (makeString xint)]
			else [characters (makeRealString x)]
		end

    | objectToWords(RANGE(lt,lte,gte,gt)) =
	(openParen (if lte then "[" else "("))::
	objectToWords(lt) @
	((separator ",")::objectToWords(gt)) @
	[closeParen (if gte then "]" else ")")]

    | objectToWords(PLUS(a,b)) = (characters "+")::
				(openParen "(")::
				objectToWords(a) @
			        ((separator ",")::
				  objectToWords(b) @ [closeParen ")"])

    | objectToWords(MINUS(a,b)) = (characters "-")::
				(openParen "(")::
				objectToWords(a) @
			        ((separator ",")::
				  objectToWords(b) @ [closeParen ")"])

    | objectToWords(TIMES(a,b)) = (characters "*")::
				(openParen "(")::
				objectToWords(a) @
			        ((separator ",")::
				  objectToWords(b) @ [closeParen ")"])

    | objectToWords(DIVIDES(a,b)) = (characters "/")::
				(openParen "(")::
				objectToWords(a) @
			        ((separator ",")::
				  objectToWords(b) @ [closeParen ")"])




  and kidsToWords ([a]) = objectToWords(a)
    | kidsToWords(a::b) = objectToWords(a)@((separator ",")::kidsToWords(b))
    | kidsToWords _ = raise Fail "Impossible case 1"


  fun objectListToWords([a]) = objectToWords(a)
    | objectListToWords(a::b) = objectToWords(a)@((separator ",")
					        ::objectListToWords(b))
    | objectListToWords _ = raise Fail "Impossible case 2"

  fun objectRefListToWords([a]) = objectToWords(!a)
    | objectRefListToWords(a::b) =
			objectToWords(!a)@((separator ",")
					  ::objectRefListToWords(b))
    | objectRefListToWords _ = raise Fail "Impossible case 3"












		(* constraint forms *)

  datatype constraint = known of object
  		      | fixed of object
		      | neg of constraint
		      | consistent of constraint
		      | eq of object * object
		      | greater of bool * object * object
		      | less of bool * object * object
		      | tt | ff
		      | none


    fun constraintToWords(known obj) = 
			[(characters "known"),
			 (openParen "(")] @
			 objectToWords(obj)@
			 [closeParen ")"]

      | constraintToWords(fixed obj) = 
			[(characters "fixed"),
			 (openParen "(")] @
			 objectToWords(obj)@ 
			 [closeParen ")"]

      | constraintToWords(neg c) = (characters "not ")::constraintToWords(c)
      | constraintToWords(consistent c) = (characters "con ")
				   	 ::constraintToWords(c)

      | constraintToWords(eq(a,b)) =
		objectToWords(a) @ ((characters "="):: objectToWords(b))

      | constraintToWords(greater(oreq,o1,o2)) =
		objectToWords(o1) @
		((characters (if oreq then ">=" else ">"))::
	 	 objectToWords(o2))

      | constraintToWords(less(oreq,o1,o2)) =
		objectToWords(o1) @
		((characters (if oreq then "<=" else "<"))::
	 	 objectToWords(o2))

      | constraintToWords(tt) = [characters "true"]
      | constraintToWords(ff) = [characters "false"]
      | constraintToWords(none) = []














		(*  agent forms *)


  datatype agent = success
		 | failure
		 | guard of constraint * agent
                 | select of constraint * agent
		 | tell of constraint
		 | call of string * object list
		 | par of agent list
		 | alt of agent list


      fun agentToWords(success) = [characters "success"]
	| agentToWords(failure) = [characters "failure"]

  	| agentToWords(guard(c,a)) = (openParen "(")::constraintToWords(c) @
				((characters "->")::
				 agentToWords(a)) @ [closeParen ")"]

  	| agentToWords(select(c,a)) = (openParen "(")::constraintToWords(c) @
				((characters "?")::
				 agentToWords(a)) @ [closeParen ")"]

        | agentToWords(tell(c)) = constraintToWords(c)

	| agentToWords(call(name,args)) = 
				((characters name)::
				 ((openParen "(")::
				  (args2list(args)@[closeParen ")"])))

	| agentToWords(par [a]) = agentToWords(a)

	| agentToWords(par(a::b)) = agentToWords(a)
	   @ ((combinator "&")::agentToWords(par b))

        | agentToWords(par _) = raise Fail "Impossible case 4"
	| agentToWords(alt [a]) = agentToWords(a)
	| agentToWords(alt(a::b)) = agentToWords(a)
	   @ ((combinator "|")::agentToWords(alt b))
        | agentToWords(alt _) = raise Fail "Impossible case 5"

     and args2list([a]) = objectToWords(a)
       | args2list(a::b) = objectToWords(a)@((separator ",")::args2list(b))
       | args2list [] = []


		(* clause form *)

  datatype clause = clause of string * object list * int * constraint * agent


  fun parAgents(par(a1),par(a2)) = par(a1@a2)
    | parAgents(par(a1),a2) = par(a1@[a2])
    | parAgents(a1,par(a2)) = par(a1::a2)
    | parAgents(a1,a2) = par([a1,a2])

  fun altAgents(alt(a1),alt(a2)) = alt(a1@a2)
    | altAgents(alt(a1),a2) = alt(a1@[a2])
    | altAgents(a1,alt(a2)) = alt(a1::a2)
    | altAgents(a1,a2) = alt([a1,a2])


		(* AND NOW, the actual code store *)
 

   exception NotFound = Store.NotFound

   val memory = ref(Store.newStore()): clause Store.store ref

   fun store(c as clause(name,_,_,_,_)) = memory:=Store.store(name,c,!memory)
   fun retrieve(name) = Store.retrieve(name,!memory)

   fun retrieveAll() = Store.retrieveAll(!memory)
   fun wipe(name) = memory:= Store.wipe(name,!memory)
   fun wipeAll() = memory:= Store.newStore()

     (* since reals no longer equality type, have to define our own
        equality. *)

   fun sameObjects(VOID,VOID) = true
     | sameObjects(UNKNOWN i,UNKNOWN j) = i=j
     | sameObjects(POINTER(s,i,br,ir,or),POINTER(s',i',br',ir',or')) =
           s=s' andalso i=i' andalso br=br' andalso ir=ir' andalso or=or'
     | sameObjects(VARIABLE(s,i),VARIABLE(s',i')) = s=s' andalso i=i'
     | sameObjects(PARAMETER(s,i),PARAMETER(s',i')) = s=s' andalso i=i'
     | sameObjects(WILDCARD,WILDCARD) = true
     | sameObjects(ATOMIC s,ATOMIC s') = s=s'
     | sameObjects(HERBRAND(o1,ol,o2),HERBRAND(o1',ol',o2')) =
           sameObjects(o1,o1') andalso sameObjects(o2,o2') andalso
           sameObjectLists(ol,ol')
     | sameObjects(INFINITY,INFINITY) = true
     | sameObjects(MINFINITY,MINFINITY) = true
     | sameObjects(NUMBER r,NUMBER r') = not(r<r' orelse r>r')
     | sameObjects(RANGE(o1,b1,b2,o2),RANGE(o1',b1',b2',o2')) =
           b1=b1' andalso b2=b2' andalso sameObjects(o1,o1')
           andalso sameObjects(o2,o2')
     | sameObjects(PLUS(o1,o2),PLUS(o1',o2')) =
           sameObjects(o1,o1') andalso sameObjects(o2,o2')
     | sameObjects(MINUS(o1,o2),MINUS(o1',o2')) =
           sameObjects(o1,o1') andalso sameObjects(o2,o2')
     | sameObjects(TIMES(o1,o2),TIMES(o1',o2')) =
           sameObjects(o1,o1') andalso sameObjects(o2,o2')
     | sameObjects(DIVIDES(o1,o2),DIVIDES(o1',o2')) =
           sameObjects(o1,o1') andalso sameObjects(o2,o2')
     | sameObjects _ = false
     
   and sameObjectLists ([],[]) = true
     | sameObjectLists (x::y,x'::y') = sameObjects(x,x') andalso
                                         sameObjectLists(y,y')
     | sameObjectLists _ = false
end

