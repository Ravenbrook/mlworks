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
 * Copyright (C) 1997.  The Harlequin Group Limited.  All rights reserved.
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
