(* _strnames.sml the functor *)
(*
$Log: _strnames.sml,v $
Revision 1.17  1997/05/01 12:54:30  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.16  1995/03/28  16:24:35  matthew
 * Use Stamp instead of Tyname_id etc.
 *
Revision 1.15  1995/02/02  14:01:03  matthew
Removing debug stuff

Revision 1.14  1994/10/13  10:34:07  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.13  1993/05/21  12:45:18  matthew
Added Strname_id.Map.Undefined handler

Revision 1.12  1993/05/18  19:08:01  jont
Removed integer parameter

Revision 1.11  1992/11/23  17:03:16  jont
More simplifications to strname_eq and metastrname_eq

Revision 1.10  1992/10/30  15:17:36  jont
Added special maps for tyfun_id, tyname_id, strname_id

Revision 1.9  1992/10/01  11:12:28  jont
Improved strname_eq, and took out the debugging which was using half its time

Revision 1.8  1992/08/27  20:15:19  davidt
Yet more changes to get structure copying working better.

Revision 1.7  1992/08/27  19:01:50  davidt
Made various changes so that structure copying can be
done more efficiently.

Revision 1.6  1992/07/17  15:53:57  jont
Changed to use btrees for renaming of tynames and strnames

Revision 1.5  1992/07/04  17:15:58  jont
Anel's changes for improved structure copying

Revision 1.4  1992/05/05  14:09:23  jont
Anel's fixes

Revision 1.3  1992/01/27  20:15:37  jont
Added use of variable from ty_debug, with local copy, to control
debug output. For efficiency reasons

Revision 1.2  1991/11/21  16:47:58  jont
Added copyright message

Revision 1.1  91/06/07  11:38:40  colin
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

require "../utils/crash";
require "../utils/print";
require "../typechecker/datatypes";
require "stamp";
require "../typechecker/strnames";

functor Strnames(
  structure Datatypes : DATATYPES
  structure Stamp : STAMP
  structure Crash : CRASH
  structure Print : PRINT
  sharing type Datatypes.Stamp = Stamp.Stamp
  sharing type Datatypes.StampMap = Stamp.Map.T
    ) : STRNAMES =
  struct
    structure Datatypes = Datatypes
    open Datatypes
      
    (****
     Operations on the data structure for structure names.
     ****)

    local
      fun metap (METASTRNAME _) = true
	| metap (_) = false
    in
      fun string_strname (NULLNAME id) = 
	"NULLNAME" ^ Stamp.string_stamp id
	| string_strname (STRNAME id) = "m" ^ Stamp.string_stamp id
	| string_strname (METASTRNAME (ref name)) = 
(*	  if metap name 
	    then string_strname name
	  else *) "metastr (" ^ string_strname name ^ ")"
    end

    fun uninstantiated (METASTRNAME (ref (NULLNAME _))) = true
      | uninstantiated (METASTRNAME (ref name)) = uninstantiated name
      | uninstantiated (_) = false

    (****
     strname_eq returns false when comparing two uninstantiated 
     metastrnames not containing the same reference. 
     ****)

    local
      fun strip(m as METASTRNAME(ref name)) =
	(case name of
	   NULLNAME _ => m
	 | _ => strip name)
	| strip name = name
    in
      fun strname_eq(name, name') = strip name = strip name'

      fun metastrname_eq(name, name') =
	let
	  val name = strip name
	in
	  case name of
	    METASTRNAME _ => name = strip name'
	  | _ => false
	end

    end
	
    (****
     Order function on structure names.
     ****)

    fun strname_ord (STRNAME id, STRNAME id') = 
      Stamp.stamp_lt (id,id')
      | strname_ord (NULLNAME _,_) = false
      | strname_ord (_,NULLNAME _) = true
      | strname_ord (METASTRNAME (ref name),name') = strname_ord (name,name')
      | strname_ord (name,METASTRNAME (ref name')) = strname_ord (name,name')

    fun strip (name as METASTRNAME (ref (NULLNAME _))) = name
      | strip (METASTRNAME (ref name)) = strip name
      | strip name = name
      
    (****
     Used during copying of signatures when elaborating structure descriptions.
     ****)

    fun create_strname_copy rigid =
      let
        fun copy (strname_copies,METASTRNAME (ref (NULLNAME id))) = 
          (case Stamp.Map.tryApply'(strname_copies, id) of
             SOME _ => strname_copies
           | NONE =>
               let
                 val new_strname =
                   if rigid then STRNAME (Stamp.make_stamp())
                   else METASTRNAME (ref (NULLNAME (Stamp.make_stamp ())))
               in
                 Stamp.Map.define(strname_copies, id, new_strname)
               end)
          | copy (strname_copies,METASTRNAME (ref strname)) = 
            copy (strname_copies,strname)
          | copy (strname_copies,STRNAME stamp) = 
            (case Stamp.Map.tryApply'(strname_copies, stamp) of
               SOME _ => strname_copies
             | NONE =>
                 Stamp.Map.define(strname_copies, stamp, STRNAME (Stamp.make_stamp ())))
          | copy (strname_copies,NULLNAME _) = 
            Crash.impossible "create_strname_copy"
      in
        copy
      end

    fun strname_copy (name as METASTRNAME (ref (NULLNAME id)), strname_copies) = 
      (case Stamp.Map.tryApply'(strname_copies, id) of
         SOME newname => newname
       | _ => name)
      | strname_copy (METASTRNAME (ref strname), strname_copies) = 
	strname_copy (strname,strname_copies)
      | strname_copy (name as STRNAME id,strname_copies) =
          (case Stamp.Map.tryApply'(strname_copies, id) of
             SOME newname => newname
           | _ => name)
      | strname_copy (NULLNAME _, _) = Crash.impossible "strname_copy"
  end
