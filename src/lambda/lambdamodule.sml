(*  ==== LAMBDA ENVIRONMENT/MODULE TRANSLATION ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  These functions deal with the packaging up of a lambda environment and
 *  lambda bindings (usually the result of compiling some topdecs) into a
 *  single lambda expression and a special lambda environment.
 *
 *  Revision Log
 *  ------------
 *  $Log: lambdamodule.sml,v $
 *  Revision 1.1  1992/10/01 13:47:58  richard
 *  Initial revision
 *
 *)

require "environtypes";

signature LAMBDAMODULE =
  sig
    structure EnvironTypes : ENVIRONTYPES

    val pack :
      EnvironTypes.Top_Env * EnvironTypes.LambdaTypes.binding list ->
      EnvironTypes.Top_Env * EnvironTypes.LambdaTypes.LambdaExp

    val unpack :
      EnvironTypes.Top_Env * EnvironTypes.LambdaTypes.LambdaExp ->
      EnvironTypes.Top_Env * EnvironTypes.LambdaTypes.binding list
  end;
