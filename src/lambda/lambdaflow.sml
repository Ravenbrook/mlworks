(*
 * $Log: lambdaflow.sml,v $
 * Revision 1.2  1997/04/22 11:50:28  matthew
 * Improving interaction between local functions and FP args
 *
 *  Revision 1.1  1997/01/06  10:32:41  matthew
 *  new unit
 *  New optimization stages
 *
 * Copyright (C) 1996 The Harlequin Group Limited.
*)
require "lambdatypes";

signature LAMBDAFLOW =
  sig
    structure LambdaTypes : LAMBDATYPES
    val preanalyse : LambdaTypes.LambdaExp -> LambdaTypes.LambdaExp
    val tail_convert : LambdaTypes.program -> LambdaTypes.program
    val lift_locals : LambdaTypes.program -> LambdaTypes.program
    val loop_analysis : LambdaTypes.program -> LambdaTypes.program
    val findfpargs : LambdaTypes.program -> LambdaTypes.program
  end



