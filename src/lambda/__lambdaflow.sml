(*
 * $Log: __lambdaflow.sml,v $
 * Revision 1.2  1997/04/24 13:30:48  matthew
 * Adding LambdaPrint
 *
 *  Revision 1.1  1997/01/06  10:32:53  matthew
 *  new unit
 *  New optimization stages
 *
 Copyright (C) 1996 The Harlequin Group Limited.
*)

require "../utils/__inthashtable";
require "../utils/__crash";
require "../debugger/__runtime_env";
require "../machine/__machspec";
require "__simpleutils";
require "__lambdaprint";

require "_lambdaflow";

structure LambdaFlow_ = LambdaFlow  (structure SimpleUtils = SimpleUtils_
                                     structure LambdaPrint = LambdaPrint_
                                     structure MachSpec = MachSpec_
                                     structure Crash = Crash_
                                     structure IntHashTable = IntHashTable_
                                     structure RuntimeEnv = RuntimeEnv_)

