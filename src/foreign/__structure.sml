(*  ==== FOREIGN INTERFACE : FOREIGN_STRUCTURE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: __structure.sml,v $
 *  Revision 1.2  1996/10/25 10:57:20  io
 *  [Bug #1547]
 *  updating for current naming convention
 *
 *  Revision 1.1  1996/05/24  01:19:16  brianm
 *  new unit
 *  New file.
 *
 *  Revision 1.1  1996/05/19  13:59:07  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.4  1996/05/01  11:46:04  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.3  1996/03/28  13:10:17  matthew
 * New sharing syntax etc.
 *
 * Revision 1.2  1996/03/07  11:50:25  jont
 * Changing newmap to map, NEWMAP to MAP, T to map
 *
 * Revision 1.1  1995/09/07  22:48:34  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:38:04  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "structure";
require "aliens";
require "types";
require "__aliens";
require "__types";

require "^.utils.map";
require "^.utils.__btree";
require "^.basis.__char";
require "^.basis.__list";
require "^.basis.__string";


structure Structure_ : FOREIGN_STRUCTURE =
   struct
     structure Map = BTree_
       
     structure FIAliens  : FOREIGN_ALIENS = ForeignAliens_
     structure FITypes   : FOREIGN_TYPES  = ForeignTypes_

   (* Mapping *)

     structure FITypes = FITypes
     type name = FITypes.name
     type filename = FITypes.filename
       
     type ('a,'b) Map = ('a,'b)Map.map

     exception Undefined = Map.Undefined

     type foreign_module    =  FIAliens.foreign_module

     val get_module_later   =  FIAliens.get_module_later
     val get_item_later     =  FIAliens.get_item_later

     val get_module_now     =  FIAliens.get_module_now
     val get_item_now       =  FIAliens.get_item_now

     val get_item_names     =  FIAliens.get_item_names
     val get_item_info      =  FIAliens.get_item_info

     val lookup             = Map.apply'


   (* Definitions *)

     datatype load_mode = IMMEDIATE_LOAD | DEFERRED_LOAD

     val files = ref([] : filename list)

     fun filesLoaded () = !files

     datatype value_type = CODE_VALUE | VAR_VALUE | UNKNOWN_VALUE

     fun load_module (fname,IMMEDIATE_LOAD)  =  get_module_now(fname)
       | load_module (fname,DEFERRED_LOAD)    =  get_module_later(fname)

     abstype fStructure =

        FCODESET of (filename * load_mode * foreign_module)

     with
       
        fun load_object_file(fname : filename, mode) =
            let 
	      fun adjoin (x,xs) = 
		let val mem : string -> bool = fn y=> (x=y)
		in
		  if List.exists mem xs then xs else (x::xs)
		end (* adjoin *)
	      val F_mod = load_module(fname,mode)
            in
              files := adjoin(fname,!files);
              FCODESET(fname,mode,F_mod)
            end

        fun file_info(FCODESET(fname,mode,_)) = (fname,mode)

        fun symbols(FCODESET(_,_,f_mod)) = get_item_names(f_mod)

        fun symbol_info(FCODESET(_,_,f_mod),str) =
            let val info_map = get_item_info(f_mod)
                val info = lookup(info_map,str)
            in
                case Char.toLower (String.sub (info, 0)) of
                  #"c" => CODE_VALUE |
                  #"v" => VAR_VALUE  |
                   _  => UNKNOWN_VALUE
            end handle Undefined => UNKNOWN_VALUE

        fun module(FCODESET(_,_,f_mod)) = f_mod

     end
   end;
