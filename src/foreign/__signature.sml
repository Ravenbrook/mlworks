(*  ==== FOREIGN INTERFACE : FOREIGN_SIGNATURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: __signature.sml,v $
 *  Revision 1.2  1996/10/25 12:56:57  io
 *  [Bug #1547]
 *  updating to current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:15  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  11:46:37  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.4  1996/04/18  16:56:43  jont
 * initbasis becomes basis
 *
 * Revision 1.3  1996/03/20  15:11:33  matthew
 * Language revision
 *
 * Revision 1.2  1996/03/07  11:49:54  jont
 * Changing newmap to map, NEWMAP to MAP, T to map
 *
 * Revision 1.1  1995/09/07  22:49:07  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:37:07  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.1  1995/03/27  15:48:27  brianm
 * new unit
 * New file.
 *
 *)

require "../utils/__btree";
require "signature";


structure Signature_ : FOREIGN_SIGNATURE =
   struct

     structure Map = BTree_

   (* Mapping *)

     type ('a,'b)Map = ('a,'b)Map.map

     fun empty_map ()      =  Map.empty' ((op<):string*string->bool)
     val apply'            =  Map.apply'
     val define'           =  Map.define'
     val undefine          =  Map.undefine
     val to_list_ordered   =  Map.to_list_ordered 


   (* Exported Definitions *)
     type 'a option = 'a option
     abstype ('entry) fSignature =
             FCODEINFO of ((string,'entry)Map)ref
     with

     (* foreign signature operations *)

        fun newSignature () =
            FCODEINFO(ref(empty_map ()))

        fun lookupEntry (FCODEINFO(ref(map)),nm) =
            SOME(apply'(map,nm)) handle Undefined => NONE

        fun defEntry (FCODEINFO(map_r),itm) =
            map_r := define'(!map_r,itm)

        fun removeEntry(FCODEINFO(map_r),nm) =
            map_r := undefine(!map_r,nm)

        fun showEntries (FCODEINFO(ref(map))) =
            to_list_ordered(map)
     end 
   end;
