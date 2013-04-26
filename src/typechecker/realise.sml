(* realise.sml the signature *)
(*
$Log: realise.sml,v $
Revision 1.14  1993/11/15 12:35:49  nosa
Debugger structures for Modules Debugger.

Revision 1.13  1993/07/02  14:45:54  daveb
Added an extra boolean result to sigmatch.  This is true if an exception
in the structure is matched against a value specification.

Revision 1.12  1993/03/10  14:38:56  matthew
Options changes

Revision 1.11  1993/03/09  13:27:19  matthew
Options & Info changes

Revision 1.10  1993/02/22  10:14:35  matthew
Added completion_env parameter ot sigmatch
Removed RealiseError exception

Revision 1.9  1993/02/08  15:08:03  matthew
Changes for BASISTYPES signature

Revision 1.8  1993/02/01  14:21:03  matthew
Added sharing

Revision 1.7  1992/12/18  11:01:17  matthew
Propagating options to signature matching error messages.
,

Revision 1.6  1992/08/12  11:11:22  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.5  1992/08/11  11:24:50  matthew
removed type_eq_matters parameter from sigmatch

Revision 1.4  1992/04/27  11:43:36  jont
Added extra parameter to indicate when equality attributes of
types matter.

Revision 1.3  1991/11/21  16:53:24  jont
Added copyright message

Revision 1.2  91/11/19  12:19:08  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.1.1.1  91/11/19  11:13:01  jont
Added comments for DRA on functions

Revision 1.1  91/06/07  11:44:52  colin
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

(* This module checks a match between a signature and a structure. The
   implementation (_realise.sml) contains good comments on the process.
*)

require "basistypes";
require "../main/info";
require "../main/options";

signature REALISE = 
  sig
    structure BasisTypes : BASISTYPES
    structure Info : INFO
    structure Options : OPTIONS

    val sigmatch :
      (Info.options * Options.options) ->
      (Info.Location.T *
       BasisTypes.Datatypes.Env *
       int *
       BasisTypes.Sigma *
       BasisTypes.Datatypes.Structure)
      ->
      bool * bool * BasisTypes.Datatypes.DebuggerStr
      (* The first field of the result indicates whether the match was
	 successful.  The second indicates whether an excon in the structure
	 was matched against a value specification.  In this case the
	 lambda translator has to do extra work. *)

  end
