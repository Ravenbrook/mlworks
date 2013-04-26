(*  ==== INITIAL BASIS : textbinio functor ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __text_io.sml,v $
 *  Revision 1.3  1996/07/17 15:51:29  andreww
 *  [Bug #1453]
 *  Updating to bring inline with the new basis document of May 30 '96
 *
 *  Revision 1.2  1996/06/24  12:15:41  andreww
 *  renaming PrimIO structure to avoid confusion.
 *
 *  Revision 1.1  1996/06/03  14:09:52  andreww
 *  new unit
 *  Revised basis visible structure TextIO
 *
 *
 *)

require "_text_io";
require "__text_prim_io";
require "^.system.__os_prim_io";

structure TextIO = TextIO(structure TextPrimIO = TextPrimIO
                          structure OSPrimIO = OSPrimIO);


