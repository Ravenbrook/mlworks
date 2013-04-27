(* strenv.sml the functor *)

(* $Log: _strenv.sml,v $
 * Revision 1.15  1995/03/23 13:34:47  matthew
 * Removing SimpleTypes structue
 *
Revision 1.14  1995/02/06  16:13:46  matthew
Stuff

Revision 1.13  1992/12/14  16:18:25  jont
Anel's last changes

Revision 1.12  1992/10/27  19:15:21  jont
Modified to use less than functions for maps

Revision 1.11  1992/10/02  16:05:06  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.10  1992/08/18  16:06:19  jont
Removed irrelevant handlers and new exceptions

Revision 1.9  1992/08/11  15:32:42  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.8  1992/08/04  12:29:43  jont
Anel's changes to use NewMap instead of Map

Revision 1.7  1992/03/09  14:25:26  jont
Added require "valenv"

Revision 1.6  1992/02/11  10:10:06  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.5  1992/01/31  09:24:24  clive
Got the imperative attributes wrong on some of the array stuff

Revision 1.4  1992/01/22  16:27:15  clive
Added the Array exceptions to the variable environment

Revision 1.3  1992/01/15  12:23:37  clive
Added arrays to the initial basis

Revision 1.2  1992/01/07  19:28:42  colin
Added pervasive_strname_count giving strname id of first strname after
the pervasives have been defined and added code to reset strname counter

Revision 1.1  1991/11/18  14:51:34  richard
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

require "../typechecker/datatypes";

require "../typechecker/strenv";

functor Strenv ( structure Datatypes	: DATATYPES
                ) : STRENV =
  struct

    structure Datatypes = Datatypes

    open Datatypes

    val empty_strenv = SE (NewMap.empty (Ident.strid_lt, Ident.strid_eq))

    fun empty_strenvp (SE amap) = NewMap.is_empty amap

    fun lookup (strid,SE amap) = 
      NewMap.tryApply'(amap, strid)

    fun se_plus_se (SE amap,SE amap') =
      SE (NewMap.union(amap, amap'))

    fun add_to_se (strid,str,SE amap) =
      SE (NewMap.define (amap,strid,str))

    (* Build the initial structure environment *)
    val initial_se = empty_strenv
		    
  end
