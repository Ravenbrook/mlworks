(* environtypes.sml  the signature *)
(*
$Log: environtypes.sml,v $
Revision 1.17  1996/11/22 12:03:17  matthew
Removing reference to MLWorks.Option

 * Revision 1.16  1996/02/23  16:58:15  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.15  1995/12/22  17:01:09  jont
 * Remove Option in favour of MLWorks.Option
 *
Revision 1.14  1995/01/19  12:34:20  matthew
Tidying up

Revision 1.13  1994/02/21  18:51:07  nosa
Debugger environments for Modules Debugger.

Revision 1.12  1994/01/19  14:37:36  nosa
Paths in LAMBs for dynamic pattern-redundancy reporting

Revision 1.11  1993/07/05  12:41:06  daveb
Removed exception environments and interfaces.

Revision 1.10  1993/03/10  15:12:58  matthew
Added NewMap and type Interface

Revision 1.9  1993/01/26  09:33:40  matthew
Removed Interface structure.

Revision 1.8  1992/08/26  11:03:26  jont
Removed some redundant structures and sharing

Revision 1.7  1992/06/15  16:44:37  jont
Added EXTERNAL constructor to COMP

Revision 1.6  1992/06/10  13:10:09  jont
Changed to use newmap

Revision 1.5  1991/10/08  18:01:29  davidt
Changed the type comp so that record selection now retains the total
size of the record as well as just the index.

Revision 1.4  91/07/12  16:11:28  jont
Added exception environment to env

Revision 1.3  91/07/11  09:09:25  jont
Changed Fun_Env to use comp

Revision 1.2  91/07/08  17:52:05  jont
Added functor environment

Revision 1.1  91/06/11  16:54:54  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/map";
require "lambdatypes";

signature ENVIRONTYPES = sig
  structure NewMap : MAP
  structure LambdaTypes: LAMBDATYPES

  datatype ValSpec =
    STRIDSPEC of LambdaTypes.Ident.LongStrId |
    VARSPEC of LambdaTypes.LVar |
    NOSPEC

  datatype comp =
    EXTERNAL | (* Place holder to say translate otherwise *)
    LAMB of LambdaTypes.LVar * ValSpec |
    FIELD of {index : int, size : int} |  (* Field selectors in structures *)
    PRIM of LambdaTypes.Primitive (* Primitive functions, numbers on the wall *)

  datatype Env =
    ENV of (LambdaTypes.Ident.ValId, comp) NewMap.map *
           (LambdaTypes.Ident.StrId, Env * comp * bool) NewMap.map
    
  datatype Fun_Env =
    FUN_ENV of (LambdaTypes.Ident.FunId, comp * Env * bool) NewMap.map

  datatype Top_Env = TOP_ENV of Env * Fun_Env

  datatype Foo = LVARFOO of LambdaTypes.LVar | INTFOO of int

  datatype DebuggerExp =
    NULLEXP |
    LAMBDAEXP of {index : int, size : int} list * (LambdaTypes.LVar * LambdaTypes.LVar)
    * LambdaTypes.Tyfun ref option |
    LAMBDAEXP' of {index : int, size : int} list * Foo ref * LambdaTypes.Tyfun ref option |
    INT of int

  datatype DebuggerEnv = 
    DENV of (LambdaTypes.Ident.ValId, DebuggerExp) NewMap.map *
    (LambdaTypes.Ident.StrId, DebuggerStrExp) NewMap.map

  and DebuggerStrExp =
    LAMBDASTREXP of {index : int, size : int} list * (LambdaTypes.LVar * LambdaTypes.LVar) * LambdaTypes.Structure |
    LAMBDASTREXP' of {index : int, size : int} list * Foo ref * LambdaTypes.Structure |
    DENVEXP of DebuggerEnv


end

