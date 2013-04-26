(* Module identifiers - for OS-independent recompilation.

$Log: module_id.sml,v $
Revision 1.15  1999/02/03 15:20:27  mitchell
[Bug #50108]
Change ModuleId from an equality type

 * Revision 1.14  1998/03/31  11:38:19  jont
 * [Bug #70077]
 * Remove to_host function as this is no longer used
 *
 * Revision 1.13  1997/05/01  12:20:47  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.12  1995/12/06  17:58:54  daveb
 * Added the is_pervasive predicate.
 *
Revision 1.11  1995/12/04  15:21:07  daveb
Added perv_from_string.

Revision 1.10  1995/09/06  15:36:13  jont
Provide non-faulting form of from_string

Revision 1.9  1995/04/19  11:38:15  jont
Add functionality to support object paths

Revision 1.8  1995/01/17  13:32:44  daveb
Removed the body of the ModuleId type.
Added the to_host and from_host functions.

Revision 1.7  1994/10/06  10:24:28  matthew
Added eq fun for module_ids

Revision 1.6  1994/02/02  12:05:28  daveb
changed from_unix_string (OS-specific) to from_require_string.

Revision 1.5  1993/11/09  11:29:07  daveb
Merged in bug fix.

Revision 1.4  1993/09/10  17:42:03  jont
Merging in bug fixes

Revision 1.3.1.3  1993/10/22  15:44:05  daveb
Removed create function, as require can no longer take module ids.
Changed from_string to recognise either / or . as separators.

Revision 1.3.1.2  1993/09/10  15:12:25  jont
Changed the order of the terms in a moduleid. This will be a compiler
efficiency issue

Revision 1.3.1.1  1993/08/27  14:37:32  jont
Fork for bug fixing

Revision 1.3  1993/08/27  14:37:32  daveb
Added a comparison function.

Revision 1.2  1993/08/24  14:08:33  daveb
Added location argument to from_string.
Added create function that checks that moduleids are alphanumeric.
Added comments.

Revision 1.1  1993/08/17  17:24:22  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd

*)

signature MODULE_ID =
sig
  eqtype Symbol
  type Location

  type Path
  (* The part of the module name before the final element.
     This type does not share with symbol list. *)

  type ModuleId
  (* A module identifier. *)

  val lt: ModuleId * ModuleId -> bool
  (* Ordering function. *)

  val eq: ModuleId * ModuleId -> bool
  (* Equality function. *)

  val is_pervasive: ModuleId -> bool
  (* Does the module_id refer to a pervasive module? *)

  val string: ModuleId -> string
  (* Converts a module id to a string, using dots as separators. *)

  val module_unit_to_string : ModuleId * string -> string
  (* Produce a file system string for the final part of the module name *)

  val from_string: string * Location -> ModuleId
  (* Converts a string to a module id, using dots as separators. *)

  val perv_from_string: string * Location -> ModuleId
  (* Converts a string to a module id, using dots as separators, and
     adds a leading space, to remove this id from the user's name space. *)

  val from_mo_string: string * Location -> ModuleId
  (* Converts a string to a module id, using dots as separators.
     Allows a leading space.*)

  val from_string': string -> ModuleId option
  (* Converts a string to a module id, using dots as separators. *)
  (* Returns NONE if failed *)

  val from_host: string * Location -> ModuleId
  (* Converts a string to a module id, using the separator for the host OS.
     Ignores any extension. *)

  exception NoParent
  (* raised when parent is applied to an empty path. *)

  val path: ModuleId -> Path
  (* Returns the path of the module id. *)

  val path_string: Path -> string
  (* Converts a path to a string, using dots as separators. *)

  val empty_path: Path
  (* The empty path. *)

  val add_path: Path * ModuleId -> ModuleId
  (* Adds the path of a module id to an existing path. *)

  val parent: Path -> Path
  (* Removes the final element from a path.  Used for domain-style
     abbreviation of module names. *)

  val from_require_string: string * Location -> ModuleId
  (* Hack for backwards compatibility. *)

  val perv_from_require_string: string * Location -> ModuleId
  (* Hack for backwards compatibility. *)
end;
