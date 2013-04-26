(*
 *
 * $Log: dio.sml,v $
 * Revision 1.2  1998/06/08 17:48:22  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

(*

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     13/04/91
Glasgow University and Rutherford Appleton Laboratory.

dio.sml

Functions for solving and displaying Linear Homogeneous Diophantine Equations.

Based on Clausen and Fortenbacher's Graph Traversal Method.
See there for more details on it solution method.

But does not at present use the preprocessing method which uses a injective form.

This method has been optimised as much as I can which seems worthwhile.


depends on:
	library.sml
	commonio.sml

*)


signature DIO =
  sig
          val solve_dio_equation : int list -> int list -> int -> (int list * int list) list
          val show_dio_solutions : unit -> unit
  end ;

structure Dio : DIO = 
  struct

open Array
infix 9 sub

datatype Dio_Equation = Dio of (int *	(* the number of a coeffs *)
                                int *	(* the number of b coeffs *)
                                int list *	(* the a coeffs *)
                                int list *	(* the b coeffs *)
                                int 	(* difference ie c *)
                               ) 

(* 
homogenous : Dio_Equation -> bool

a function to test the homogeniety of the Diophantine equation.
*)

fun homogenous (Dio(_,_,_,_,c)) = c = 0 

(* 
defect : Dio_Equation -> int list * int list -> int
calculates the value of a diophantine equation at the value of the two
lists - the first for the positive args, the second for the negative.
*)

fun read_n_times 0 s = []
  | read_n_times n s = 
                 (write_terminal s ;
  		  case (Strings.stringtoint o 
  		        Strings.drop_last o 
  		        read_line_terminal) () of
  		  OK m => m :: read_n_times (n - 1) s
  		  | Error _ => (write_terminal "Only enter integers\n" ;
  		                read_n_times n s)
  		 ) 

(*
read_dio_equation : unit ->  Dio_Equation

function for entering an equation from the terminal
*)

fun read_dio_equation () =
    let val m = hd (read_n_times 1 "number of lhs coefficients:  ")
        val n = hd (read_n_times 1 "number of rhs coefficients:  ")
        val a = (write_terminal("lhs coefficients:\n");
                 read_n_times m "a = ")
        val b = (write_terminal("rhs coefficients:\n");
                 read_n_times n "b = ")
        val c = hd (read_n_times 1 "inhomogenous part\n    c = ")
    in Dio(m,n,a,b,c)
    end 


(*
write_dio_equation : unit ->  string

function for printing a printable form of a diophantine equation.
*)

local
fun mk_coeff_strs s (n:int,l:int list) = 
    let fun coeffs m n l = cons
           (makestring(hd l) ^ "*" ^ s ^ makestring n) 
           (if m = n 
            then []
            else coeffs m (n+1) (tl l)
           )
    in coeffs n 1 l
    end 
in
fun write_dio_equation (Dio(m,n,a,b,c)) =
    let val As = mk_coeff_strs "x" (m,a)
        val bs = mk_coeff_strs "y" (n,b)
    in stringwith ("", " + ", "") As 
       ^
       stringwith (" - "," - "," = "^makestring c) bs
    end 
end 


(* 
the algorithm we use for finding the solutions of diophantine equations, 
actually uses a graph representation of the equation.  

Thus we give a datatype for this graph.  In traversing the graph, 
we need to keep track of whether the node have been visited before. 
This is done with a boolean flag for each node.

Three basic operations are needed on the graphs.

dio_graph_edges : Dio_Graph -> int -> int list
	Finds the successor nodes of a given node
marked_node : Dio_Graph -> int -> bool
	checks to see whether a given node has been visited before
mark_node : Dio_Graph -> int -> bool
	mark a given node as been visited 

We also have a function 

make_graph : Dio_Equation -> Dio_Graph

Which converts a given equation into a graph.

*)

abstype Dio_Graph = Graph of (int list) array * bool list *	 (* for -ve d *)
			       (int list * bool) *	 (* for d = 0 *)
                              (int list) array * bool list	 (* for +ve d *)
  with

  fun dio_graph_edges (Graph(negd,negb,zerod,posd,posb)) d = 
      (case intorder d 0 of
        GT => posd sub (d-1)
      | LT => negd sub (abs d -1)
      | EQ => fst zerod
      handle Nth => failwith "Integer Out of Range of Graph\n"
      )

  fun marked_node (Graph(negd,negb,zerod,posd,posb)) d = 
      (case intorder d 0 of
        GT => nth (posb , (d-1))
      | LT => nth (negb , (abs d -1))
      | EQ => snd zerod
      handle Nth => failwith "Integer Out of Range of Graph\n"
      )

  fun mark_node (Graph(negd,negb,zerod,posd,posb)) d = 
      (case intorder d 0 of
        GT => Graph(negd,negb,zerod,posd,exchange posb (d-1) true)
      | LT => Graph(negd,exchange negb (abs d -1) true,zerod,posd,posb)
      | EQ => Graph(negd,negb,(fst zerod,true),posd,posb) 
      handle Nth => failwith "Integer Out of Range of Graph\n"
      ) 

  fun make_graph (Dio(m,n,a,b,c)) =
      let fun mk_pos_graph al d = (map (add d) al) 
          fun mk_neg_graph bl d = (map (minus d) bl) 
          val lb = ~ (max (maximum b,c))
          val ub = maximum a 
          val negds = ints ~1 lb
          val posds = ints 1 ub
      in Graph(arrayoflist (map (mk_pos_graph a) negds),
               copy (abs lb) false,
               (mk_pos_graph a 0,false),
               arrayoflist (map (mk_neg_graph b) posds),
               copy ub false)
      end 
  end  (* of abstype Dio_Graph *)

datatype Side = Left | Right


(* for the solutions of the diophantine equations we need some functions on pairs of lists *)

fun null_solution m n = (copy m 0,copy n 0)

local
fun inc_list (a::l) 1 = a+1::l
  | inc_list (a::l) n = a:: inc_list l (n-1) 
  | inc_list [] n = []
in
fun inc_right (l1,l2) k = (l1,inc_list l2 k)
fun inc_left  (l1,l2) k = (inc_list l1 k,l2)
end (* of local *)

fun show_solution (l1:int list,l2:int list) = stringlist makestring ("<",", ",">") l1
		     ^ "   " ^ stringlist makestring ("<",", ",">") l2 ;

(*
Now we come to the solving of the diophantine equation from the graph representation of
the diophantine equation.
*)

(* 
first we give 

verify_solution : Dio_Graph ->  (int list * int list) -> int -> int -> int 

which given a solution as its second argument, verifies whether it there is a minimal solution
in the graph less than it. 

Note that when this is called, it is called with a candidate 1 less (in the last non-zero position)
than the solution.  This is because if it is given the minimal solution, it will reject it as being
less than itself !
*)

fun verify_solution G Sol apos bpos node = 
    let val edges = dio_graph_edges G node
        val (side,mono_edges) = if node <= 0 
                                then (Left  , drop (apos-1) edges) 
                                else (Right , drop (bpos-1) edges)
    in verify_path G Sol side apos bpos mono_edges
    end 

and verify_path G (a::ais,bl) Left apos bpos (e :: re) = 
    if a = 0
    then verify_path G (ais,bl) Left (apos + 1) bpos re
    else if e = 0         (* We have have found a smaller monotone path *)
	 then false  (* found a smaller path and so can fail *)
         else (verify_solution G ((a-1)::ais,bl) apos bpos e)
                 andalso
              (verify_path G (ais,bl) Left (apos + 1) bpos re)

  | verify_path G (al,b::bis) Right apos bpos (e :: re) = 
    if b = 0
    then verify_path G (al,bis) Right apos (bpos + 1) re
    else if e = 0         (* We have have found a smaller monotone path *)
	 then ((*if !Show then write_terminal ("Found Smaller Solution \n") 
               else () ;*)
               false )  (* found a smaller path and so can fail *)
         else (verify_solution G (al,(b-1)::bis) apos bpos e)
                 andalso
              (verify_path G (al,bis) Right apos (bpos + 1) re)
  | verify_path G Sol side apos bpos [] = true

  | verify_path G ([],[]) side apos bpos es = true (* Not Sure *)
  | verify_path G ([],bis) Left apos bpos es = true (* Not Sure *)
  | verify_path G (ais,[]) Right apos bpos es = true (* Not Sure *)

(* 
Secondly we have

find_solutions : Dio_Graph ->  (int list * int list) list -> (int list * int list) -> int -> int -> int 

This is tail recursive - it keeps the current list of solutions as its second argument.

The candidate solution is the third argument.  This is successively incremented as the
path through the graph is followed under the control of the apos and the bpos arguments.
This ensures a maximal path - but not necessarily a minimal solution.  The verify_solution
routine is called to verify the solution when it is found. 

*)

fun find_solutions G PrevSols CurrSol apos bpos node = 
    let val edges = dio_graph_edges G node
        val (side,mono_edges) = if node <= 0 
                                then (Left  , drop (apos-1) edges) 
                                else (Right , drop (bpos-1) edges)
    in extend_path G PrevSols CurrSol side apos bpos mono_edges
    end 

and extend_path G PrevSols CurrSol Left apos bpos (e :: re) = 
    if e = 0  (* We have have found a new monotone path *)

    then extend_path G (if verify_solution G CurrSol 1 1 0  (* if verifies as a solution *)
                        then (inc_left CurrSol apos :: PrevSols)  (* keep as a possible solution *)
                        else PrevSols) 
                    CurrSol Left (apos + 1) bpos re

    else if marked_node G e (* We have visited this node before on this walk *)

         then extend_path G PrevSols CurrSol Left (apos + 1) bpos re (* drop this path *)

         else extend_path G (find_solutions (mark_node G e) PrevSols
				             (inc_left CurrSol apos) apos bpos e)
			 CurrSol Left (apos + 1) bpos re 

  | extend_path G PrevSols CurrSol Right apos bpos (e :: re) = 
    if e = 0  (* We have have found a new monotone path *)

    then extend_path G (if verify_solution G CurrSol 1 1 0 (* if verifies as a solution *)
                        then (inc_right CurrSol bpos  :: PrevSols)	(* keep as a possible solution *)
                        else PrevSols) 
                     CurrSol Right apos (bpos + 1) re

    else if marked_node G e (* We have visited this node before on this walk *)
         then extend_path G PrevSols CurrSol Right apos (bpos + 1) re (* drop this path *)

         else extend_path G (find_solutions (mark_node G e) PrevSols 
	                                    (inc_right CurrSol bpos) apos bpos e) 
			  CurrSol Right apos (bpos + 1) re 

  | extend_path G PrevSols CurrSol side apos bpos [] = PrevSols


fun solve_dio_graph (dio as Dio(m,n,a,b,c)) = 
    find_solutions (make_graph dio) [] (null_solution m n) 1 1 (~c)

fun solve_dio_equation ais bis c =
    solve_dio_graph (Dio(List.length ais,List.length bis,ais,bis, c))

fun show_dio_solutions  () = 
    let val de = read_dio_equation ()
        val d = write_terminal (write_dio_equation de ^ "\n")
        val sols = Timer.timer (fn () => solve_dio_graph de)
    in write_terminal "Press return for Solutions" ;
        ignore(input(std_in,1)) ;
        write_terminal ("Number of Solutions = "^ (makestring (List.length (map ((outputc std_out) o (noc "\n") o show_solution)
        sols)))^"\n")
    end 

  end ; (* of structure Dio *)
