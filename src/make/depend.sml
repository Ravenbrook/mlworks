(* depend.sml *)
(*
 * $Log: depend.sml,v $
 * Revision 1.2  1995/12/07 17:05:53  daveb
 * Corrected copyright date.
 *
 *  Revision 1.1  1995/12/05  10:58:17  daveb
 *  new unit
 *  Read dependency information from .sml files (taken from make/_recompile).
 *
 *  
 * Copyright (c) 1995 Harlequin Ltd.
 *)

require "../main/info";

signature DEPEND =
  sig
    structure Info : INFO
    type ModuleId

    val get_imports :
      bool * Info.options * string -> ModuleId list
    (* reads the required compilation units from the file.  The boolean
       should be set to true is this is a pervasive file, and false if not. *)
  end
