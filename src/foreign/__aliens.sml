(*  ==== FOREIGN INTERFACE : ALIENS INTERFACE ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: __aliens.sml,v $
 *  Revision 1.4  1996/11/02 15:10:13  daveb
 *  Replaced use of utils/__stringlib.
 *
 *  Revision 1.3  1996/10/25  13:39:13  io
 *  [Bug #1547]
 *  updating for current naming conventions
 *
 *  Revision 1.2  1996/05/22  13:50:12  brianm
 *  Beta release modifications.
 *
 *  Revision 1.1  1996/05/19  11:46:37  brianm
 *  new unit
 *  Renamed file.
 *
 * Revision 1.5  1996/04/18  16:56:20  jont
 * initbasis becomes basis
 *
 * Revision 1.4  1996/03/07  11:48:56  jont
 * Changing newmap to map, NEWMAP to MAP, T to map
 *
 * Revision 1.3  1995/09/07  22:43:40  brianm
 * Modifications for reorganisation & documentation.
 *
 *  Revision 1.2  1995/07/18  12:17:13  brianm
 *  Changing names of deferred data-type operators (stream-edit)
 *
 *  Revision 1.1  1995/04/25  11:33:35  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "../utils/map";
require "../utils/lists";
require "types";
require "core";
require "utils";

require "../basis/__substring";
require "../utils/__btree";
require "../utils/__lists";
require "__types";
require "__core";
require "__utils";

require "aliens";

structure ForeignAliens_ : FOREIGN_ALIENS =
   struct

      structure Map       : MAP            = BTree_
      structure Lists = Lists_
      structure FICore    : FOREIGN_CORE   = ForeignCore_
      structure FIUtils   : FOREIGN_UTILS  = ForeignUtils_
      structure FITypes   : FOREIGN_TYPES  = ForeignTypes_

      open FITypes
      open FIUtils

   (* Mapping *)

      type ('a,'b)Map     = ('a,'b)Map.map

      type foreign_object = FICore.foreign_object
      type foreign_value  = FICore.foreign_value

      type info           = string

      val load_object       = fn s => FICore.load_object(s,FICore.LOAD_NOW)
      val find_value        = FICore.find_value
      val list_content      = FICore.list_content
      val call_foreign_fun  = FICore.call_foreign_fun

      val empty_map       = Map.empty'((op<):string*string->bool) : (string,string) Map
      val from_list       = Map.from_list'((op<):string*string->bool)

   (* Implementation auxiliaries *)

      fun is_sp c = c = #" "

      fun prefix s =
        Substring.string (Substring.takel (not o is_sp) (Substring.all s))

      fun prefix_split s =
        let val (x, y) = (Substring.splitl (not o is_sp) (Substring.all s))
        in 
          (Substring.string x, Substring.string (Substring.dropl is_sp y))
        end

      fun make_info_map sl = from_list (map prefix_split sl)


   (* Definitions *)

      abstype foreign_module =
              FMODULE of
                 { filename   : string,
                   object     : ( foreign_object      )box,
                   item_names : ( (string)list        )box,
                   info_map   : ( (string, string)Map )box
                 }

      with

      (* Implementations : auxilliaries *)

         val FI_module_register = ref([] : foreign_module list)

         fun fetch_module(f_mod as
                          FMODULE{filename,object,item_names,info_map}) =
             let val f_obj = load_object(filename)
             in
                 setBox object f_obj;
                 resetBox(item_names);   (* Reset these `cached' values *)
                 resetBox(info_map);     (* Reset these `cached' values *)
                 f_mod
             end

         fun extract_foreign_object(FMODULE{object, ...}) = getBox(object)

      (* Exported Definitions *)

         fun ensure_module(f_mod as FMODULE{object, ...}) =
             case extractBox(object) of
               NONE    => fetch_module(f_mod)
             |
               SOME(_) => f_mod

         fun reset_module(f_mod as
                          FMODULE{filename,object,item_names,info_map}) =
             (
               resetBox(object);
               resetBox(item_names);
               resetBox(info_map);
               f_mod
             )

         fun get_module_later(str) =
             let val f_mod =
                     FMODULE { filename   = str,
                               object     = voidBox(),
                               item_names = voidBox(),
                               info_map   = voidBox()
                             }
             in
                 FI_module_register := f_mod :: !FI_module_register;
                 f_mod
             end

         fun get_module_now(str) =
             let val f_mod = get_module_later(str)
             in
                 ensure_module(f_mod)
             end;
             

         fun get_item_names(FMODULE{item_names, object, ...}) =
             case extractBox(item_names) of
               NONE =>
                 (
                    case extractBox(object) of
                       NONE        => []
                    |
                       SOME(f_obj) =>
                          let val names = map prefix (list_content(f_obj))
                          in
                            (
                             setBox item_names names;
                             names
                            )
                          end
                 )
             |
               SOME(names) => names

         fun get_item_info(FMODULE{info_map, object, ...}) =
             case extractBox(info_map) of
               NONE =>
                 (
                    case extractBox(object) of
                      NONE        => empty_map
                    |
                      SOME(f_obj) =>
                         let val info = make_info_map (list_content(f_obj))
                         in
                           setBox (info_map) (info);
                           info
                         end
                 )
             |
               SOME(info) => info
      end


      abstype foreign_item =
              FITEM of
                 { name    : string,
                   value   : ( foreign_value  )box,
                   module  : ( foreign_module )box
                 }
      with

      (* Implementation auxiliaries *)

         val FI_item_register = ref([] : foreign_item list)

         local
             fun fetch_item'(f_item as FITEM{name,value,module}) =
                 let val f_mod = getBox(module)
                     val f_obj = extract_foreign_object(f_mod)
                     val f_val = find_value(f_obj,name)
                 in
                     setBox(value)(f_val);
                     f_item
                 end

             fun fetch_item''(f_item as FITEM{name,value,module}) =
                 let val f_mod = ensure_module(getBox(module))
                     val f_obj = extract_foreign_object(f_mod)
                     val f_val = find_value(f_obj,name)
                 in
                     setBox(module)(f_mod);
                     setBox(value)(f_val);
                     f_item
                 end
         in
             fun fetch_item(f_item) =
                 case f_item of
                    FITEM{module=(ref(SOME(_))), value=(ref(NONE)), ...} =>
                      fetch_item'(f_item)
                 |   
                    FITEM{module=(ref(NONE)), ...} =>
                      fetch_item''(f_item)
                 |
                   _ => f_item
         end

         fun extract_foreign_value(FITEM{value, ...}) = getBox(value)


      (* Exported Definitions *) 

         fun ensure_item(f_item as FITEM{name,value,module}) =
             case extractBox(value) of
               NONE    => fetch_item(f_item)
             |
               SOME(_) => f_item

         fun reset_item(f_item as FITEM{value, ...}) =
             (
 	       resetBox(value);
               (* Note that the module component isn't reset - this would
                  make the item useless (since it could not be reestablished)
                *)
               f_item
             )

         fun get_item_later(f_mod, name) =
             let val f_item =
                     FITEM { name   = name,
                             value  = voidBox(),
                             module = makeBox(f_mod)
                           }
             in
                 FI_item_register := f_item :: !FI_item_register;
                 f_item
             end

         fun get_item_now(f_mod, name) =
             let val f_item = get_item_later(f_mod, name)
             in
                 ensure_item(f_item)
             end
         end



      fun ensure_alien_modules () =
	Lists.iterate ensure_module (!FI_module_register)

      fun ensure_alien_items () =
	Lists.iterate ensure_item (!FI_item_register)

      fun ensureAliens () =
          (
             ensure_alien_modules();
             ensure_alien_items()
          )


      fun refresh_module (f_mod) =
          let val f_mod' = reset_module(f_mod)
          in
              ensure_module(f_mod')
          end


      fun refresh_item (f_item) =
          let val f_item' = reset_item(f_item)
          in
              ensure_item(f_item')
          end

      fun refresh_alien_modules () =
	Lists.iterate refresh_module (!FI_module_register)

      fun refresh_alien_items () =
	Lists.iterate refresh_item (!FI_item_register)

      fun refreshAliens () =
          (
             refresh_alien_modules();
             refresh_alien_items()
          )


      fun reset_alien_modules () =
	Lists.iterate reset_module (!FI_module_register)

      fun reset_alien_items () =
	Lists.iterate reset_item (!FI_item_register)

      fun resetAliens () =
          (
             reset_alien_modules();
             reset_alien_items()
          )


   (* FOREIGN FUNCTION CALLING *)

      fun call_alien_code(item,args,arity,res) =
          let val ffun = extract_foreign_value(ensure_item(item))
          in
              call_foreign_fun(ffun,args,arity,res)
          end
   end;
