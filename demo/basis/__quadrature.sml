(*  ==== BASIS EXAMPLES : Quadrature structure ====
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
 *  $Log: __quadrature.sml,v $
 *  Revision 1.2  1996/09/04 11:55:05  jont
 *  Make require statements absolute
 *
 *  Revision 1.1  1996/08/09  18:14:05  davids
 *  new unit
 *
 *
 *)


require "quadrature";
require "$.basis.__real";
require "$.basis.__math";


structure Quadrature : QUADRATURE =
  struct

    (* If a point x cannot be evaluated during integration, raise Eval x. *) 

    exception Eval of real


    (* This datatype allows the intervals in the integration to be subdivided
     without having to re-evaluate values each time.  The intervals are stored
     in a binary tree, with the leaf nodes containing:

     INTERVAL (left, mid, right, fLeft, fMid, fRight)

     where 'left', 'mid', 'right' give the respective positions in the interval
     and 'fLeft', 'fMid', 'fRight' give the respective function evaluations at
     these points. *)

    datatype intervals = NODE of intervals * intervals  
                       | INTERVAL of real * real * real * real * real * real 



    (* Calculate f(x).  If this gives infinity or NaN, then raise Eval x. *)

    fun evaluate (f, x) = 
      let
	val result = f x
      in
	if Real.isFinite result then
	  result
	else
	  raise Eval x
      end
	
   
    (* Subdivide the given intervals into intervals of half the size. Evaluate
     the function at those points which haven't been evaluated before. *)

    fun subdivide (NODE (leftIntervals, rightIntervals), f) =
      NODE (subdivide (leftIntervals, f),
	    subdivide (rightIntervals, f))

      | subdivide (INTERVAL (left, mid, right, fLeft, fMid, fRight), f) =
	let
	  val midLeft = (left + mid) / 2.0
	  val midRight = (mid + right) / 2.0
	  val fMidLeft = evaluate (f, midLeft)
	  val fMidRight = evaluate (f, midRight)
	in
	  NODE (INTERVAL (left, midLeft, mid, fLeft, fMidLeft, fMid),
		INTERVAL (mid, midRight, right, fMid, fMidRight, fRight))
	end


    (* Used a mixed error test to check for convergence. *)

    fun convergence (current, error, accuracy) =
      abs error <= accuracy * (1.0 + Real.abs current)


    (* Estimate the error in the current approximation of the integral. *)

    fun estimateError (s1, s2) =
      (s1 - s2) / 15.0


    (* Add up the integrals of each of the integrals.  Use Simpson's rule
     for numerical integration. *)

    fun simpsons (NODE (leftTree, rightTree)) =
      simpsons leftTree + simpsons rightTree

      | simpsons (INTERVAL (left, mid, right, fLeft, fMid, fRight)) =
	(right - left) / 6.0 * (fLeft + 4.0 * fMid + fRight)


    (* Calculate the integral of the given intervals.  If this approximation
     is within the specified accuracy, then return this result.  Otherwise
     subdivide the intervals and recalculate the integral. *)

    fun calcIntegral (allIntervals, lastSum, f, accuracy) =
      let
	val subIntervals = subdivide (allIntervals, f)
	val newSum = simpsons subIntervals
	val error = estimateError (lastSum, newSum)
      in
	if convergence (newSum, error, accuracy) then
	  newSum
	else
	  calcIntegral (subIntervals, newSum, f, accuracy)
      end


    (* Integrate the function 'f' between limits 'a' and 'b', to the accuracy
     specified.  If 'accuracy' is NONE then maximum accuracy will be used.
     If either of the limits is infinity or NaN, then Overflow or Div will
     be raised respectively.  If any value in the integral cannot be evaluated
     then Eval will be raised for that point.  These precautions stop the
     calculation going into an infinite loop. *)

    fun integrate (f, a, b, accuracy) =
      let
	val left = Real.checkFloat a
	val right = Real.checkFloat b
	val mid = (left + right) / 2.0
	val acc =
	  case accuracy of
	    NONE => 0.0
	  | SOME eta => eta
	val startInterval =
	  INTERVAL (left, mid, right,
		    evaluate (f, left), 
		    evaluate (f, mid),
		    evaluate (f, right))
      in
	calcIntegral (startInterval, simpsons (startInterval), f, acc)
      end

    
    (* Calculate a value for machine epsilon. *)
    val macheps = Real.nextAfter (1.0, Real.posInf) - 1.0

    (* This value of 'h' is optimal for numerical differentiation. *)
    val h = Math.sqrt macheps


    (* Differentiate the function 'f' at the point 'x'. *)

    fun differentiate f x = (f (x + h) - f (x)) / h

  end
