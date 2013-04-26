(* __mir_utils.sml the structure *)
(*
$Log: __mir_utils.sml,v $
Revision 1.9  1995/09/04 14:00:20  daveb
Added BigNum32 parameter.

Revision 1.8  1995/03/17  19:51:58  daveb
Removed unused parameters.

Revision 1.7  1995/02/07  17:07:34  matthew
Removing unused LambdaSub

Revision 1.6  1993/07/20  13:55:00  jont
Added BigNum parameter

Revision 1.5  1993/05/18  14:15:15  jont
Removed Integer parameter

Revision 1.4  1992/08/19  18:08:05  davidt
Took out redundant structure arguments.

Revision 1.3  1992/08/07  18:00:06  davidt
String structure is now pervasive.

Revision 1.2  1992/05/08  17:11:56  jont
Added auglambda

Revision 1.1  1992/04/07  17:08:30  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/_diagnostic";
require "../utils/__sexpr";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/__bignum";
require "../main/__pervasives";
require "../main/__library";
require "../typechecker/__types";
require "__mirregisters";
require "__mir_env";
require "_mir_utils";

structure Mir_Utils_ = Mir_Utils(
  structure Diagnostic =
    Diagnostic(structure Text = Text_)
  structure Sexpr = Sexpr_
  structure Lists = Lists_
  structure Crash = Crash_
  structure BigNum = BigNum_
  structure BigNum32 = BigNum32_
  structure Pervasives = Pervasives_
  structure Library = Library_
  structure Types = Types_
  structure MirRegisters = MirRegisters_
  structure Mir_Env = Mir_Env_
);
