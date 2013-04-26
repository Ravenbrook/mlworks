(* FILE SYSTEM INTERFACE *)
(*
 * This should be the version from the revised basis.
 * For now it just contains the expand_path and getdir functions.
 *
 * Copyright Harlequin Ltd. 1994.
 *
 * $Log: filesys.sml,v $
 * Revision 1.2  1995/04/12 13:21:41  jont
 * Change to FILE_SYS
 *
 * Revision 1.1  1995/01/25  17:02:32  daveb
 * new unit
 * The OS.FileSys structure from the basis.
 *
 *)

signature FILE_SYS =
sig
  exception BadHomeName of string

  val expand_path: string -> string
  (* Expands relative paths to absolute paths.  On Unix, also expands ~user
     abbreviations on and replaces symbolic links with their expansions. *)

  val getdir: unit -> string
  (* Returns the current working directory. *)
end
