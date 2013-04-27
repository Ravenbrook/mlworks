(* Windows menu bar utilites *)
(*

$Log: __menus.sml,v $
Revision 1.12  1999/03/23 14:44:45  johnh
[Bug #190536]
Add version.

 * Revision 1.11  1998/04/01  12:18:19  jont
 * [Bug #70086]
 * Windows_ has become WindowsGui_
 *
 * Revision 1.10  1997/10/29  09:34:14  johnh
 * [Bug #30059]
 * __control_names.sml now kept in rts\gen.
 *
 * Revision 1.9  1997/10/13  12:30:58  johnh
 * [Bug #30059]
 * Implement interface to Win32 resource dialogs.
 *
 * Revision 1.8  1997/07/14  12:05:28  johnh
 * [Bug #30124]
 * Using Getenv.get_source_path to find help documentation.
 *
 * Revision 1.7  1996/10/31  17:05:02  daveb
 * Renamed Windows_ to Windows, as users will see it.
 *
 * Revision 1.6  1996/05/01  12:08:52  matthew
 * Removing Integer structure
 *
 * Revision 1.5  1996/01/31  12:09:38  matthew
 * Adding CapiTypes
 *
 * Revision 1.4  1995/08/29  12:30:18  matthew
 * Including Integer structure
 *
 * Revision 1.3  1995/08/15  13:43:00  matthew
 * Adding Lists and Crash structures
 *
 * Revision 1.2  1995/08/10  09:24:01  matthew
 * Making it all work
 *
 * Revision 1.1  1995/08/03  12:50:47  matthew
 * new unit
 * MS Windows GUI
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *)

require "../utils/__lists";
require "../utils/__crash";
require "../system/__getenv";
require "__windows_gui";
require "__capitypes";
require "__labelstrings";
require "../rts/gen/__control_names";
require "../main/__version";


require "_menus";

structure Menus_ = Menus(structure Lists = Lists_
                         structure Crash = Crash_
                         structure WindowsGui = WindowsGui
                         structure LabelStrings = LabelStrings_
                         structure CapiTypes = CapiTypes_
			 structure ControlName = ControlName
			 structure Getenv = Getenv_
 			 structure Version = Version_
                           );
