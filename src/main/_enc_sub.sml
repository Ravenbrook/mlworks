(* _enc_sub.sml the functor *)
(*
$Log: _enc_sub.sml,v $
Revision 1.17  1996/03/28 11:10:59  matthew
Adding where type clause

 * Revision 1.16  1996/02/22  14:02:04  jont
 * Replacing Map with NewMap
 *
 * Revision 1.15  1995/03/24  16:06:24  matthew
 * Use Stamp instead of Tyname_id etc.
 *
Revision 1.14  1994/05/05  13:49:40  daveb
(DataTypes.META_OVERLOADED now has extra arguments.

Revision 1.13  1993/12/03  14:09:56  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.12  1993/09/22  10:01:12  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.11  1993/07/19  11:27:12  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger.

Revision 1.10  1992/12/07  17:38:24  jont
Anel's last changes

Revision 1.9  1992/10/01  11:38:05  jont
Improved map_eq and type_same

Revision 1.8  1992/09/21  10:44:56  clive
Changed hashtables to a single structure implementation

Revision 1.7  1992/09/08  22:40:42  jont
Allowed NULLTYPES in valenvs, these are inserted by nameset copying

Revision 1.6  1992/08/28  15:25:32  davidt
Now uses NewMap.eq instead of NewMap.to_list (which should
have been NewMap.to_list_ordered anyway!).

Revision 1.5  1992/08/06  16:20:32  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/08/06  16:20:32  jont
Anel's changes to use NewMap instead of Map

Revision 1.4  1992/07/24  15:38:12  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.3  1992/03/19  14:34:17  jont
Added some more hashtables

Revision 1.2  1992/03/16  16:21:52  jont
Added hash tables for encoding of common types (fun, rec, cons) and also
metatynames.

Revision 1.1  1992/01/22  16:28:10  jont
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../utils/diagnostic";
require "../utils/lists";
require "../utils/crash";
require "../typechecker/datatypes";
require "enc_sub";

functor Enc_Sub(
  structure DataTypes : DATATYPES where type Stamp = int
  structure Diagnostic : DIAGNOSTIC
  structure Lists : LISTS
  structure Crash : CRASH
) : ENC_SUB =
struct
  structure Diagnostic = Diagnostic
  structure DataTypes = DataTypes
  structure NewMap = DataTypes.NewMap

  fun pair_eq(first_eq, second_eq) ((a, b), (a', b')) =
    first_eq(a, a') andalso second_eq(b, b')

  fun list_eq eqfn (lista, listb) =
    let
      fun list_subeq([], []) = true
	| list_subeq (x :: xs, y :: ys) =
	  eqfn(x, y) andalso list_subeq (xs, ys)
	| list_subeq _ = false
    in
      list_subeq(lista, listb)
    end

  fun map_eq (map1, map2) = NewMap.eq type_same (map1, map2)
(*
    list_eq (pair_eq(op=, type_same)) (Map.assoc map1, Map.assoc map2)
*)

  and type_same(DataTypes.METATYVAR arg, DataTypes.METATYVAR arg') =
    arg = arg'
  | type_same(DataTypes.META_OVERLOADED arg, DataTypes.META_OVERLOADED arg') =
    arg = arg'
  | type_same(DataTypes.TYVAR arg, DataTypes.TYVAR arg') =
    arg = arg'
  | type_same(DataTypes.METARECTYPE arg, DataTypes.METARECTYPE arg') =
    arg = arg'
  | type_same(DataTypes.RECTYPE arg, DataTypes.RECTYPE arg') =
    map_eq (arg, arg')
  | type_same(DataTypes.FUNTYPE(ty1, ty2), DataTypes.FUNTYPE(ty1', ty2')) =
    type_same(ty1, ty1') andalso type_same(ty2, ty2')
  | type_same(DataTypes.CONSTYPE(l, t), DataTypes.CONSTYPE(l', t')) =
    tyname_same(t, t') andalso list_eq type_same (l, l')
  | type_same(DataTypes.DEBRUIJN arg, DataTypes.DEBRUIJN arg') =
    ((fn ty=>(#1(ty),#2(ty),#3(ty)))arg) = ((fn ty=>(#1(ty),#2(ty),#3(ty)))arg')
  | type_same(DataTypes.NULLTYPE, DataTypes.NULLTYPE) = true
  | type_same _ = false

  and tyname_same(DataTypes.TYNAME{1=id, ...}, DataTypes.TYNAME{1=id', ...}) =
    id = id'
  | tyname_same(DataTypes.METATYNAME arg, DataTypes.METATYNAME arg') =
    arg = arg'
  | tyname_same _ = false

  fun tyfun_same(DataTypes.TYFUN(ty1, i1), DataTypes.TYFUN(ty2, i2)) =
    type_same(ty1, ty2) andalso i1 = i2
  | tyfun_same(DataTypes.ETA_TYFUN tyname, DataTypes.ETA_TYFUN tyname') =
    tyname_same(tyname, tyname')
  | tyfun_same(DataTypes.NULL_TYFUN (id,_), DataTypes.NULL_TYFUN (id',_)) = id = id'
  | tyfun_same _ = false

  fun type_from_scheme(DataTypes.SCHEME(_, (ty,_))) = ty
  | type_from_scheme(DataTypes.UNBOUND_SCHEME (ty,_)) = ty
  | type_from_scheme _ = Crash.impossible"type_from_scheme"

  fun type_same_sort(scheme1, scheme2) =
    case (type_from_scheme scheme1, type_from_scheme scheme2) of
      (DataTypes.FUNTYPE _, DataTypes.FUNTYPE _) => true
    | (DataTypes.CONSTYPE _, DataTypes.CONSTYPE _) => true
    | _ => false

  fun tyname_valenv_same(DataTypes.VE(_, ve1), DataTypes.VE(_, ve2)) =
    NewMap.eq type_same_sort (ve1, ve2)

  fun type_hash(DataTypes.METATYVAR(ref(i, ty,_), _, _)) =
    3 + i + type_hash ty
  | type_hash(DataTypes.META_OVERLOADED {1=ref ty,...}) = 5 + type_hash ty
  | type_hash(DataTypes.TYVAR(ref (i,_,_), tyvar)) = 7 + i
  | type_hash(DataTypes.METARECTYPE(ref(i, _, ty, _, _))) =
    11 + i + type_hash ty
  | type_hash(DataTypes.RECTYPE(lab_ty_map)) =
    NewMap.fold
    (fn (i, _, ty) => i + type_hash ty)
    (13, lab_ty_map)
  | type_hash(DataTypes.FUNTYPE(ty1, ty2)) = 17 + type_hash ty1 + type_hash ty2
  | type_hash(DataTypes.CONSTYPE(ty_list, tyname)) =
    Lists.reducel
    (fn (i, ty) => i + type_hash ty)
    (tyname_hash tyname + 19, ty_list)
  | type_hash(DataTypes.DEBRUIJN(i, b1, b2,_)) = 23 + i
  | type_hash(DataTypes.NULLTYPE) = 47
    
  and tyname_hash(DataTypes.TYNAME{1=tyname_id, ...}) =
    29 + tyname_id
  | tyname_hash(DataTypes.METATYNAME{1 = ref tyfun, ...}) =
    31 + tyfun_hash tyfun
  and tyfun_hash(DataTypes.TYFUN(ty, i)) =
    41 + type_hash ty + i
  | tyfun_hash(DataTypes.ETA_TYFUN tyname) = 43 + tyname_hash tyname
  | tyfun_hash(DataTypes.NULL_TYFUN (id,_)) = 47 + id

  fun symbol_hash symbol = size(DataTypes.Ident.Symbol.symbol_name symbol)

  fun valid_hash(DataTypes.Ident.VAR sy) = symbol_hash sy
  | valid_hash(DataTypes.Ident.CON sy) = symbol_hash sy
  | valid_hash(DataTypes.Ident.EXCON sy) = symbol_hash sy
  | valid_hash(_) = Crash.impossible "TYCON':valid_hash:enc_sub"

  fun tyname_valenv_hash(DataTypes.VE(_, amap)) =
    let
      val assoc = NewMap.to_list_ordered amap
    in
      Lists.reducel
      (fn (i, (valid, typescheme)) =>
       i + valid_hash valid +
       (case type_from_scheme typescheme of
	  DataTypes.FUNTYPE _ => 3
	| DataTypes.CONSTYPE _ => 5
	| DataTypes.NULLTYPE => 5 (* This one from modified signatures *)
	| _ => Crash.impossible"tyname_valenv_hash"))
      (Lists.length assoc, assoc)
    end

end
