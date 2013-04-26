(*
 *
 * $Log: prettyprint.sml,v $
 * Revision 1.2  1998/06/08 17:34:30  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(* 

MERILL  -  Equational Reasoning System in Standard ML.
Brian Matthews				     13/10/93
Glasgow University and Rutherford Appleton Laboratory.

prettyprint.sml 

Pretty-Printer for a general type - will be used for pretty-printing 
terms and equations.

Taken from Larry Paulson's book and modified by BMM.
*)

(**** ML Programs from the book

  ML for the Working Programmer
  by Lawrence C. Paulson, Computer Laboratory, University of Cambridge.
  (Cambridge University Press, 1991)

Copyright (C) 1991 by Cambridge University Press.
Permission to copy without fee is granted provided that this copyright
notice and the DISCLAIMER OF WARRANTY are included in any copy.

DISCLAIMER OF WARRANTY.  These programs are provided `as is' without
warranty of any kind.  We make no warranties, express or implied, that the
programs are free of error, or are consistent with any particular standard
of merchantability, or that they will meet your requirements for any
particular application.  They should not be relied upon for solving a
problem whose incorrect solution could result in injury to a person or loss
of property.  If you do use the programs or functions in such a manner, it
is at your own risk.  The author and publisher disclaim all liability for
direct, incidental or consequential damages resulting from your use of
these programs or functions.
****)

(*** Pretty printing.  See Oppen (1980).  From Chapter 8.  ***)

signature PRETTY = 
  sig
   type T
   val blo : int * T list -> T
   val str : string -> T
   val brk : int -> T
   val is_single : T -> bool	(* a function which tests if T is a single item - BMM 14/10/93 *)
   val pr  : T * int -> unit    (* no outstream - use write_terminal as this records in Log *)
   end;


functor PrettyFUN () : PRETTY =
  struct
  datatype T = 
      Block of T list * int * int 	(*indentation, length*)
    | String of string
    | Break of int			(*length*)

   fun is_single (Block(l,_,_)) = is_singleton l orelse null l (* a function which tests if T is a single item - BMM 14/10/93 *)
     | is_single (String _ ) = true 	
     | is_single _ = false

  (*Add the lengths of the expressions until the next Break; if no Break then
    include "after", to account for text following this block. *)

  fun breakdist (Block(_,_,len)::sexps, after) = len + breakdist(sexps, after)
    | breakdist (String s :: sexps, after) = size s + breakdist (sexps, after)
    | breakdist (Break _ :: sexps, after) = 0
    | breakdist ([], after) = after

(* old version - prints out strings individually *)

(*
 fun pr (sexp, margin) =
   let val space = ref margin

      (* fun blanks 0 = ()
         | blanks n = (space := !space - 1; " " ^ blanks(n-1))
      *)
       (* I think that this would be better *)

       fun blanks n = (space := !space - n ; write_terminal (spaces n))

       fun newline () = (write_terminal "\n";  space := margin)

       fun printing ([], _, _) = ()
	 | printing (sexp::sexps, blockspace, after) =
	  (case sexp of
	       Block(bsexps,indent,len) =>
		  printing(bsexps, !space-indent, breakdist(sexps,after))
	     | String s => (write_terminal s;   space := !space - size s)
	     | Break len => 
		 if len + breakdist(sexps,after) <= !space 
		 then blanks len
		 else (newline();  blanks(margin-blockspace));
	    printing (sexps, blockspace, after))
   in  printing([sexp], margin, 0)
   end
*)
(* new version which build string before printing. *)
  fun pr (sexp, margin) =
   let val space = ref margin

      (* fun blanks 0 = ()
         | blanks n = (space := !space - 1; " " ^ blanks(n-1))
      *)

       (* I think that this would be better *)
       fun blanks n = (space := !space - n ; spaces n)

       fun newline () = (space := margin ; "\n"  )

       fun printing ([], _, _) = ""
	 | printing (sexp::sexps, blockspace, after) =
	  (case sexp of
	       Block(bsexps,indent,len) =>
		  printing(bsexps, !space-indent, breakdist(sexps,after))
	     | String s => (space := !space - size s; s)
	     | Break len => 
		 if len + breakdist(sexps,after) <= !space 
		 then blanks len
		 else (newline() ^  blanks(margin-blockspace))
                 ) ^ printing (sexps, blockspace, after)
   in  write_terminal (printing([sexp], margin, 0))
   end

  fun length (Block(_,_,len)) = len
    | length (String s) = size s
    | length (Break len) = len

  val str = String  and  brk = Break

  fun blo (indent,sexps) =  Block(sexps,indent, foldl (C(add o length)) 0 sexps)  

  end;

(* (* This is here for merely diagnostic purposes when needed *)
signature TYPE = 
  sig
  datatype typ = Con of string * typ list | Var of string
  val pr : typ -> unit
  val typmap : typ
  val typ2 : typ
  end;
functor TypeFUN (Pretty: PRETTY) : TYPE =
  struct
  datatype typ = Con of string * typ list
	       | Var of string;

  local (** Displaying **)
    open Pretty

    fun typ (Var a) = str a
      | typ (Con("->",[S,T])) = blo(0, [atom S, str " ->", brk 1, typ T])
      | typ (Con(s,[S])) = blo(0, [atom S, str (" "^s), brk 1])
     and atom (Var a) = str a
       | atom T = blo(1, [str"(", typ T, str")"]);
  in
    fun pr T = Pretty.pr (typ T, 30)
  end

  val typmap = Con("->",[Con("->",[Var"a",Var"b"]),
			 Con("->",[Con("list",[Var"a"]),
				   Con("list",[Var"b"])
				  ]
			    )
			]
		  )
 val typ2 = Con("->",[typmap,typmap])
end;


structure P = PrettyFUN ();
structure T = TypeFUN (P);
open T;
pr typmap ;
newline ();
pr typ2 ;
newline ();
*)