(*
 * $Log: __proj_properties.sml,v $
 * Revision 1.5  1998/12/09 14:02:35  johnh
 * [Bug #70240]
 * Add project structure.
 *
*Revision 1.4  1998/12/08  10:16:00  johnh
*[Bug #190494]
*Add ModuleId structure.
*
*Revision 1.3  1998/06/17  15:51:55  johnh
*[Bug #30423]
*Add Incremental - used for clearing out units in a new project.
*
*Revision 1.2  1998/02/06  15:55:45  johnh
*new unit
*[Bug #30071]
*Project Properties of the new Project Workspace tool.
*
 *  Revision 1.1.1.7  1997/11/28  17:02:01  daveb
 *  [Bug #30071]
 *  Removed Getenv and OS parameters.
 *
 *  Revision 1.1.1.6  1997/11/18  17:43:33  daveb
 *  [Bug #30071]
 *  Replaced Path by OS.Path.
 *
 *  Revision 1.1.1.5  1997/11/10  09:32:36  johnh
 *  [Bug #30071]
 *  Add Getenv structure.
 *
 *  Revision 1.1.1.4  1997/11/03  16:52:48  daveb
 *  [Bug #30017]
 *  Added Info parameter.
 *
 *  Revision 1.1.1.3  1997/09/25  13:20:54  johnh
 *  [Bug #30071]
 *   Continuing work for Project Workspace - adding option for storing relative pathnames
 *
 *  Revision 1.1.1.2  1997/09/12  14:23:38  johnh
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
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

require "../basis/__list";
require "../system/__os";
require "../machine/__machspec";
require "../main/__toplevel";
require "../main/__info";
require "../main/__proj_file";
require "../main/__project";
require "../winsys/__capi";
require "../winsys/__menus";
require "../interpreter/__incremental";
require "../basics/__module_id";

require "_proj_properties";

structure ProjProperties_ =
  ProjProperties (
    structure List = List
    structure MachSpec = MachSpec_
    structure Info = Info_
    structure TopLevel = TopLevel_
    structure ProjFile = ProjFile_
    structure Project = Project_
    structure Capi = Capi_
    structure Menus = Menus_
    structure OS = OS
    structure Incremental = Incremental_
    structure ModuleId = ModuleId_
  );
