(*  ==== FOREIGN INTERFACE : C SIGNATURES ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *
 *
 *  Revision Log
 *  ------------
 *  $Log: c_signature.sml,v $
 *  Revision 1.2  1996/09/05 15:18:33  io
 *  [Bug #1547]
 *  update to current naming conventions
 *
 *  Revision 1.1  1996/05/24  01:19:17  brianm
 *  new unit
 *  New file.
 *
 * Revision 1.3  1996/03/28  14:14:03  matthew
 * Sharing changes
 *
 * Revision 1.2  1995/09/08  14:00:15  brianm
 * Further modification for updates and general reorganisation.
 *
 * Revision 1.1  1995/09/07  22:45:38  brianm
 * new unit
 * Rename due to reorganisation & documentation of FI.
 *
 *  Revision 1.1  1995/04/25  11:41:43  brianm
 *  new unit
 *  New file.
 *
 *
 *)

require "c_object";
require "types";

signature C_SIGNATURE =
  sig

    structure CObject : C_OBJECT

    type name      = CObject.name
    type filename
    type c_type    = CObject.c_type

  (* DECLARATION ENTRY *)

    datatype c_decl =
        UNDEF_DECL
    |
        VAR_DECL of { name : name, ctype : c_type }
    |
        FUN_DECL of { name   : name,
                      source : c_type list,
                      target : c_type }
    |
        TYPE_DECL of { name : name,
                       defn : c_type,
                       size : int }
    |
        CONST_DECL of { name : name, ctype : c_type }


    (* C Signature operations *)

    type c_signature

    val newSignature      : unit -> c_signature

    val lookupEntry : c_signature -> name -> c_decl
    val defEntry    : c_signature * c_decl -> unit
    val removeEntry   : c_signature * name -> unit

    val showEntries : c_signature -> c_decl list

    exception UnknownTypeName of string

    val normaliseType : c_signature -> (c_type -> c_type)

    val loadHeader : filename -> c_signature

  end; (* signature C_SIGNATURE *)
