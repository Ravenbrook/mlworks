(*
 * $Log: __sectioned_file.sml,v $
 * Revision 1.1  1998/06/08 12:14:02  mitchell
 * new unit
 * [Bug #30418]
 * Support for structured project files
 *
 *
 * Copyright (C) 1998.  The Harlequin Group Limited.  All rights reserved.
 *
 *)

require "^.basis.__text_io";
require "^.system.__os";

require "_sectioned_file";

structure SectionedFile =
  SectionedFile (
    structure TextIO = TextIO
    structure OS = OS
  )


