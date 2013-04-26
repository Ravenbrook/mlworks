(*  ==== BASIS EXAMPLES : QUADRATURE signature ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module performs automatic quadrature using Simpson's rule.  It
 *  illustrates the use of the Real structure in the basis library.
 *
 *  Revision Log
 *  ------------
 *  $Log: quadrature.sml,v $
 *  Revision 1.1  1996/08/09 18:12:05  davids
 *  new unit
 *
 *
 *)

signature QUADRATURE =
  sig

    (* integrate (f, a, b, accuracy)
     Integrate the function 'f' between limits 'a' and 'b', to the accuracy
     specified.  If 'accuracy' is NONE then maximum accuracy will be used.
     If either of the limits is infinity or NaN, then Overflow or Div will
     be raised respectively.  If any value in the integral cannot be evaluated
     then Eval will be raised for that point. *)

    val integrate : (real -> real) * real * real * real option -> real

      
    (* differentiate f x
     Differentiate the function 'f' at the point 'x'. *)

    val differentiate : (real -> real) -> real -> real

  end

