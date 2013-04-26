(*  ==== LAMBDA ENVIRONMENT/MODULE TRANSLATION ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __lambdamodule.sml,v $
 *  Revision 1.1  1992/10/01 13:51:36  richard
 *  Initial revision
 *
 *)

require "../utils/__crash";
require "../utils/__lists";
require "__environ";
require "_lambdamodule";

structure LambdaModule_ =
  LambdaModule (structure Environ = Environ_
                structure Lists = Lists_
                structure Crash = Crash_);
