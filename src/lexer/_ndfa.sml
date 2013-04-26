(*
$Log: _ndfa.sml,v $
Revision 1.8  1993/03/02 14:12:00  jont
Some speed improvements

Revision 1.7  1992/10/29  16:16:31  jont
Redone using integer newmaps for efficiency

Revision 1.6  1992/10/02  16:36:45  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.5  1992/08/18  11:44:55  davidt
Now uses integers instead of strings to represent characters.

Revision 1.4  1992/08/14  19:19:44  davidt
Took out useless handler for NewMap.Undefined.

Revision 1.3  1992/05/07  11:38:28  richard
Changed NDFA to use integers instead of strings as transition labels.
Speed doubled.

Revision 1.2  1992/05/06  14:17:55  richard
Changed BalancedTree to generic Map

Revision 1.1  1991/10/10  15:13:56  davidt
Initial revision


Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/crash";
require "../utils/intnewmap";
require "ndfa";

functor Ndfa
  (structure Crash : CRASH
   structure Map : INTNEWMAP
     ) : NDFA =
struct
  type state = int
  type transitions = (int * state) list
  type action = int

  val no_action = 0
  val epsilon_char = ~1

  fun epsilon [] = []
    | epsilon (dest :: rest) = (epsilon_char, dest) :: epsilon rest

  fun single_char (c,dest) = [(c, dest)]

  (*
   get_char(c,trans,accum) accumulates the states reachable by transitions
   on the string c onto the list accum (may contain duplicates).
  *)
  
  fun get_char(_, [], states) = states
    | get_char(c:int, (char, state)::rest, states) =
      get_char(c, rest, if c = char then state::states else states)

  fun get_epsilon (transitions, states) =
    let
      fun find ([], states) = states
        | find ((char, state)::rest, states) =
          find (rest, if char = epsilon_char then state::states else states)
    in
      find (transitions, states)
    end

  fun mk_trans l = l

  datatype ndfa = NDFA of
    {trans : ((transitions * action)) Map.T,
     start : int, fresh : int}

  fun ordering (x : int, y : int) =  (x < y)

  val empty =
    NDFA {trans = Map.empty (*(ordering,op =)*), start = 0, fresh = 0}

  fun add_with_action (NDFA {trans, start, fresh}, transitions, action) =
    let
      val new_trans =
	Map.define (trans, fresh, (transitions, action))
    in
      NDFA {trans = new_trans, start = fresh, fresh = fresh + 1}
    end

  fun add (ndfa, transitions) =
    add_with_action (ndfa, transitions, no_action)

  fun add_final (ndfa, action) =
    add_with_action (ndfa, [], action)

  fun add_start (ndfa, state_list) =
    add (ndfa, epsilon state_list)

  fun add_rec (NDFA {trans, start, fresh}, state_fn) =
    let
      val t1 =
	epsilon [start, fresh + 1]
      val trans1 =
	Map.define (trans, fresh, (t1, no_action))
      val NDFA {trans = trans2, start = start2, fresh = fresh2} =
	state_fn (NDFA {trans = trans1, start = fresh, fresh = fresh + 2})
      val t2 =
	epsilon [start, start2]
      val trans2 =
	Map.define (trans2, fresh + 1, (t2, no_action))
    in
      NDFA {trans = trans2, start = fresh + 1, fresh = fresh2}
    end
  
  fun transitions (NDFA {trans, ...}, state) =
    #1 (Map.apply'(trans, state))

  fun start (NDFA {start, ...}) = start

  fun set_start (NDFA {trans, fresh, ...}, start) =
    NDFA {trans = trans, start = start, fresh = fresh}

  fun action (NDFA {trans, ...}, state) =
    #2 (Map.apply'(trans, state))

  fun num_states (NDFA {fresh, ...}) = fresh
end
