(* Object_Output the structure *)
(*
 * Functions to output code as genuine (.o) object files, either in assembler
 * format, or binary
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: __object_output.sml,v $
 * Revision 1.3  1998/08/27 13:04:32  jont
 * [Bug #30108]
 * Fix faulty require statement which prevents bootstrapping on I386
 *
 * Revision 1.2  1998/08/25  12:09:18  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../utils/__crash";
require "../basis/__list";
require "../utils/__lists";
require "../main/__info";
require "../main/__code_module";
require "../main/__project";
require "../basics/__module_id";
require "../rts/gen/__tags.sml";
require "__i386_assembly";
require "_i386_object_output";

structure Object_Output_ =
  I386_Object_Output
  (structure Crash = Crash_
   structure List = List
   structure Lists = Lists_
   structure Info = Info_
   structure Code_Module = Code_Module_
   structure Project = Project_
   structure ModuleId = ModuleId_
   structure Tags = Tags_
   structure I386_Assembly = I386_Assembly_)
