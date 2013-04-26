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
