(* identprint.sml the signature *)
(*
$Log: identprint.sml,v $
Revision 1.10  1996/06/04 10:49:36  jont
Add unbound flexible structure and tycon error messages

 * Revision 1.9  1995/02/06  15:22:52  matthew
 * Adding unbound value message functions
 *
Revision 1.8  1993/03/03  18:28:03  matthew
Options & Info changes

Revision 1.7  1993/02/01  14:44:17  matthew
Added sharing constraint

Revision 1.6  1992/11/26  12:54:38  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.5  1992/09/16  08:36:23  daveb
Renamed include_class to show_id_class and added it to the signature.

Revision 1.4  1991/11/21  15:59:25  jont
Added copyright message

Revision 1.3  91/11/19  12:16:20  jont
Merging in comments from Ten15 branch to main trunk

Revision 1.2.1.1  91/11/19  11:04:00  jont
Added comments for DRA on functions

Revision 1.2  91/07/23  14:42:24  davida
Altered to print class of ValIds.

Revision 1.1  91/06/07  10:56:26  colin
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

(* This module provides printing functions for all objects defined in
ident.sml *)


require "../main/options";
require "ident";

signature IDENTPRINT =
  sig
    structure Ident : IDENT
    structure Options  : OPTIONS

    val printValId : Options.print_options -> Ident.ValId -> string
    val debug_printValId : Ident.ValId -> string
    val printTyVar : Ident.TyVar -> string
    val printTyCon : Ident.TyCon -> string
    val printLab   : Ident.Lab   -> string
    val printStrId : Ident.StrId -> string
    val printSigId : Ident.SigId -> string
    val printFunId : Ident.FunId -> string

    val printPath  : Ident.Path  -> string

    val printLongValId : Options.print_options -> Ident.LongValId -> string
    val printLongTyCon : Ident.LongTyCon -> string
    val printLongStrId : Ident.LongStrId -> string

    val printSCon : Ident.SCon -> string

    val valid_unbound_strid_message : 
      Ident.StrId * Ident.LongValId * Options.print_options -> string
    val strid_unbound_strid_message : 
      Ident.StrId * Ident.LongStrId * Options.print_options -> string
    val tycon_unbound_strid_message : 
      Ident.StrId * Ident.LongTyCon -> string
    val tycon_unbound_flex_strid_message : 
      Ident.StrId * Ident.LongTyCon -> string
    val unbound_longvalid_message : 
      Ident.ValId * Ident.LongValId * string * Options.print_options -> string
    val unbound_longtycon_message : 
      Ident.TyCon * Ident.LongTyCon -> string
    val unbound_flex_longtycon_message : 
      Ident.TyCon * Ident.LongTyCon -> string
  end



