(*  ==== FOREIGN INTERFACE : ALIENS INTERFACE ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  The general part of the FI is implemented in three layers:
 *  
 *     - FOREIGN_CORE
 *       provides basic OS-dependent `dynamic linking' functionality
 *       via the runtime.
 *  
 *     - FOREIGN_ALIENS
 *       provides an intermediate level of (general) foreign interface
 *       that facilitates renewal/reset of foreign_objects and values.  This
 *       allows lazy semantics for recovering objects on save/restore
 *       boundaries.
 *  
 *     - FOREIGN_STRUCTURE & FOREIGN_SIGNATURE
 *       provides users level access to the General part of the FI.
 *   
 *  
 *
 *  Revision Log
 *  ------------
 *  $Log: aliens.sml,v $
 *  Revision 1.3  1996/09/05 15:04:46  io
 *  [Bug #1547]
 *  update naming conventions
 *
 *  Revision 1.2  1996/05/21  13:29:55  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:39  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.3  1996/03/28  12:57:38  matthew
 * New sharing syntax etc.
 *
 * Revision 1.2  1995/09/07  22:43:43  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.1  1995/04/25  11:49:16  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "types";

signature FOREIGN_ALIENS =
   sig

     structure FITypes : FOREIGN_TYPES

     type address = FITypes.address
     type name = FITypes.name  
     type filename = FITypes.filename

      type ('a,'b)Map

      type foreign_module
      type foreign_item

      type info

      val get_module_later : filename -> foreign_module
      val get_item_later   : (foreign_module * name) -> foreign_item

      val get_module_now : filename -> foreign_module
      val get_item_now   : (foreign_module * name) -> foreign_item

      val get_item_names : foreign_module -> name list
      val get_item_info  : foreign_module -> (name, info) Map


      (* ACCESSING (individual) *)

      val ensure_module  : foreign_module -> foreign_module
      val ensure_item    : foreign_item -> foreign_item
      (* These ensure that the entities are present *)

      val reset_module : foreign_module -> foreign_module
      val reset_item   : foreign_item -> foreign_item
      (* These reset the state of entities *)

      val refresh_module  : foreign_module -> foreign_module
      val refresh_item    : foreign_item -> foreign_item
      (* These refresh the entities, even if already present *)

      (* ACCESSING (collective) *)

      val ensure_alien_modules : unit -> unit
      val ensure_alien_items   : unit -> unit
      val ensureAliens       : unit -> unit
      (* Ensures that all objects and associated values are available.
       * This preserves any existing entities that are present.
       *)

      val reset_alien_modules : unit -> unit
      val reset_alien_items   : unit -> unit
      val resetAliens       : unit -> unit
      (* Reset all objects and associated values - so that they are
       * obtained afresh when they are next requested - and not before.
       * This allows lazy semantics for establishing value associations.
       *)

      val refresh_alien_modules : unit -> unit
      val refresh_alien_items   : unit -> unit
      val refreshAliens       : unit -> unit
      (* Refresh objects and associated values immeadiately.
       * This reobtains all entities - even if they are
       * already present.
       *)


      (* FOREIGN FUNCTION CALLING *)

      val call_alien_code : foreign_item * address * int * address -> unit

   end;
