(*  ==== FOREIGN INTERFACE : CORE INTERFACE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  The implementation uses Word values of appropriate size to
 *  represent addresses and memory pointers.  The interface is
 *  provided via the libdl conformant C library provided by the
 *  underlying OS (see rts/foreign_loader.h and
 *  also rts/OS/*/arch/*/foreign_loader.c).
 *
 *  Revision Log
 *  ------------
 *  $Log: __core.sml,v $
 *  Revision 1.3  1996/05/20 20:39:47  io
 *  [Bug #1547]
 *  [Bug #1547]
 *  current naming conventions
 *
 *  Revision 1.2  1996/05/20  20:39:47  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:37  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.3  1996/03/20  15:06:16  matthew
 * Language revision
 *
 * Revision 1.2  1995/05/03  19:28:49  brianm
 * Updated due to changes of low-level libdl interface.
 * Changed construction of list_content - string list is now
 * built inside ML not C (for GC safety).
 * Also added a load_mode flag to load_object ...
 *
 * Revision 1.1  1995/03/27  15:31:12  brianm
 * new unit
 * Core Foreign interface (was _foreign_interface.sml).
#
 *  Revision 1.3  1995/03/24  15:31:14  brianm
 *  Updated to use Word32.word values (instead of int * int) to
 *  encode addresses.
 * 
 *  Revision 1.2  1995/03/08  14:22:13  brianm
 *  Minor corrections.
 * 
 *  Revision 1.1  1995/03/01  11:02:10  brianm
 *  new unit
 *  Foreign Interface functor body.
 * 
 *
 *)

require "types";
require "__types";

require "core";

structure ForeignCore_ : FOREIGN_CORE =
  struct

    structure FITypes : FOREIGN_TYPES = ForeignTypes_
    structure FITypes = FITypes
    open FITypes

  (* Mapping *)

    val MLWcast         = MLWorks.Internal.Value.cast
    val MLWenvironment  = MLWorks.Internal.Runtime.environment

    val env = MLWenvironment


  (* Implementation auxiliaries *)

    exception Unavailable   

    local

       val open_symtab_file  : string -> bool  =  env "open symtab file";
       val next_symtab_entry : unit -> string  =  env "next symtab entry";
       val close_symtab_file : unit -> unit    =  env "close symtab file";

    in

       fun get_item_list(sofar) =
           let val next = next_symtab_entry()
           in
             if next = "" then sofar
                          else get_item_list(next :: sofar)
           end

       fun get_symtab(file) =
           let val check = open_symtab_file(file)
           in
               if check
               then let val content = get_item_list([])
                    in
                      close_symtab_file();
                      content
                    end
               else raise Unavailable
           end
    end


  (* Exported definitions *)

    datatype load_mode = LOAD_LATER | LOAD_NOW

    abstype foreign_object = FOBJ of (string * (string list) * address)
    with
        val load_foreign_object : (string * load_mode) -> address
            =  env "load foreign object"

        fun load_object(s:string,lm:load_mode) =
            let val mem    = load_foreign_object(s,lm)
                val symtab = get_symtab(s)
            in
                FOBJ(s,symtab,mem)
            end

        fun list_content (FOBJ(_,obj_lst,_)) = obj_lst;  
    end

    abstype foreign_value  = FVAL of word32
    with

       val find_value  : (foreign_object * string) -> foreign_value
           =  env "lookup foreign value"
  
       val call_unit_fun : foreign_value -> unit
           =  env "call unit function"

       val call_foreign_fun : (foreign_value * address * int * address) -> unit 
           =  env "call foreign function"

    end

  end;
