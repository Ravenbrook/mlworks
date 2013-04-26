(*  ==== INITIAL BASIS : textbinio functor ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __bin_io.sml,v $
 *  Revision 1.3  1996/07/17 15:51:49  andreww
 *  [Bug #1453]
 *  Updating to bring inline with the new basis document of May 30 '96
 *
 *  Revision 1.2  1996/06/24  12:15:57  andreww
 *  renaming PrimIO structure to avoid confusion.
 *
 *  Revision 1.1  1996/05/31  13:04:15  andreww
 *  new unit
 *  Revised basis entry for BinIO structure.
 *
 *
 *)

require "_bin_io";
require "__bin_prim_io";
require "^.system.__os_prim_io";

structure BinIO = BinIO(structure BinPrimIO = BinPrimIO
                        structure OSPrimIO = OSPrimIO);


