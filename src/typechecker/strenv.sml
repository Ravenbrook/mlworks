(* strenv.sml the signature *)

(* $Log: strenv.sml,v $
 * Revision 1.8  1997/05/01 12:56:04  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.7  1995/03/23  13:36:46  matthew
 * Removing pervasive_strname_count
 *
Revision 1.6  1995/02/06  16:19:23  matthew
Lookup functions return option

Revision 1.5  1993/03/09  13:04:47  matthew
Str to Structure

Revision 1.4  1993/02/08  13:30:56  matthew
Removed open Datatypes, Changes for BASISTYPES signature

Revision 1.3  1992/08/04  12:29:45  jont
Anel's changes to use NewMap instead of Map

Revision 1.2  1992/01/07  19:27:54  colin
> Added pervasive_strname_count giving strname id of first strname after
the pervasives have been defined and added code to reset strname counter

Revision 1.1  1991/11/13  13:47:51  richard
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


signature STRENV =

  sig

    structure Datatypes	: DATATYPES

    val empty_strenv : Datatypes.Strenv
    val empty_strenvp : Datatypes.Strenv -> bool
    val lookup : Datatypes.Ident.StrId * Datatypes.Strenv -> Datatypes.Structure option
    val se_plus_se : Datatypes.Strenv * Datatypes.Strenv -> Datatypes.Strenv
    val add_to_se : Datatypes.Ident.StrId * Datatypes.Structure * Datatypes.Strenv -> Datatypes.Strenv
    val initial_se : Datatypes.Strenv
  end

