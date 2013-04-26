(*
 *  $Log: file_viewer.sml,v $
 *  Revision 1.4  1997/08/04 13:17:35  johnh
 *  [Bug #30111]
 *  File viewer no longer returns a quit function.
 *
 *  Revision 1.3  1996/06/18  12:44:23  stephenb
 *  Add ViewFailed exception.
 *
 *  Revision 1.2  1996/05/23  15:49:53  daveb
 *  Added source type, so that the file viewer can view a string or a location.
 *
 *  Revision 1.1  1996/04/23  13:17:23  daveb
 *  new unit
 *  File Viewer Tool.
 *

Copyright (C) 1996 Harlequin Ltd
*)

require "../basics/location";

signature FILE_VIEWER =
sig
  structure Location : LOCATION

  type ToolData
  type Widget

  datatype source = LOCATION of Location.T | STRING of string


  (* Can be raised by the viewer created by create to indicate that
   * it was not possible to open a viewer on the given file.
   *)
  exception ViewFailed of string


  (* create takes a parent windows, a tooldata value, and a boolean
     that indicates whether the viewer automatically views a new file when
     the user selects it, or whether they have to issue an explicit command.
     
     It returns a function to update the contents of the viewer. 
     The update function takes a boolean argument that
     indicates whether this is an implicit update or whether the user
     has given an explicit command (true = implicit). *)

  val create :
    (Widget * bool * ToolData) -> 
    (bool -> source -> unit)
end;
