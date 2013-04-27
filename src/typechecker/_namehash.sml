(* _namehash.sml the functor *)
(*
$Log: _namehash.sml,v $
Revision 1.9  1996/10/29 13:42:07  io
[Bug #1614]
basifying String

 * Revision 1.8  1996/04/30  15:19:39  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.7  1995/03/24  14:54:20  matthew
 * Use Stamp instead of Tyname_id etc.
 *
Revision 1.6  1994/05/05  13:50:03  daveb
META_OVERLOADED has an extra argument.

Revision 1.5  1993/08/16  10:35:53  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.4  1993/07/09  12:34:31  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger.

Revision 1.3  1993/03/02  16:42:26  matthew
DataTypes to Datatypes
Changed use of Mapping to use of Types structure

Revision 1.2  1992/12/07  16:38:48  jont
Anel's last changes

Revision 1.1  1992/04/22  19:17:18  jont
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

require "^.utils.lists";
require "^.typechecker.types";
require "^.typechecker.namehash";

functor NameHash(
  structure Lists : LISTS
  structure Types : TYPES
                 ) : NAMEHASH =
  struct
    structure Datatypes = Types.Datatypes
    structure Ident = Datatypes.Ident

    fun sy_hash (str:string):int = Lists.reducel (fn (x,y)=>x+ord y) (size str, explode str)

    fun strname_hash(Datatypes.STRNAME id) =
      3 + Types.stamp_num id
    | strname_hash(Datatypes.NULLNAME id) =
      5 + Types.stamp_num id
    | strname_hash(Datatypes.METASTRNAME(ref s)) = strname_hash s

    fun tyname_hash(Datatypes.TYNAME{1=id, ...}) =
      3 + Types.stamp_num id
    | tyname_hash(Datatypes.METATYNAME{1=ref(Datatypes.ETA_TYFUN tyname),
				       ...}) =
      tyname_hash tyname
    | tyname_hash(Datatypes.METATYNAME{1=ref tyfun, ...}) =
      tyfun_hash tyfun

    and tyfun_hash(Datatypes.TYFUN(ty, _)) = type_hash ty
    | tyfun_hash(Datatypes.ETA_TYFUN tyname) = tyname_hash tyname
    | tyfun_hash(Datatypes.NULL_TYFUN (id,_)) = 5 + Types.stamp_num id

    and type_hash(Datatypes.METATYVAR(ref(_, ty,_), _, _)) = type_hash ty
    | type_hash(Datatypes.META_OVERLOADED {1=ref ty,...}) = type_hash ty
    | type_hash(Datatypes.TYVAR(_, Datatypes.Ident.TYVAR(sy, _, _))) =
      7 + sy_hash(Ident.Symbol.symbol_name sy)
    | type_hash(Datatypes.METARECTYPE(ref{3=ty, ...})) = type_hash ty
    | type_hash(ty as Datatypes.RECTYPE _) =
      let
	val domain = Types.rectype_domain ty
      in
	Lists.reducel
	(fn (x, Ident.LAB y) => x +
	 sy_hash(Ident.Symbol.symbol_name y))
	(11 + length domain, domain)
      end
    | type_hash(Datatypes.FUNTYPE(ty, ty')) =
      type_hash ty + type_hash ty'
    | type_hash(Datatypes.CONSTYPE(_, tyname)) = tyname_hash tyname
    | type_hash(Datatypes.DEBRUIJN _) = 13
    | type_hash Datatypes.NULLTYPE = 17
  end
