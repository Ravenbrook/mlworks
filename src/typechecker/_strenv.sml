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

Copyright (C) 1991 Harlequin Ltd.
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
