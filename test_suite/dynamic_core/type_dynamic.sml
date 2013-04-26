(*

Result: OK
 
 * $Log: type_dynamic.sml,v $
 * Revision 1.6  1997/05/28 12:14:54  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.5  1996/05/23  10:29:11  matthew
 * Change to Shell.Options.
 *
 * Revision 1.4  1996/05/22  11:08:58  daveb
 * Type dynamic is now disabled by default, so added a call to set the option.
 *
 * Revision 1.3  1996/05/01  17:20:32  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1995/07/28  14:28:51  matthew
 * Changing type dynamic syntax.
 *
 * Revision 1.1  1995/01/10  11:26:54  matthew
 * new file
 *
 * Copyright (c) 1995 Harlequin Ltd.
 *)

Shell.Options.set (Shell.Options.Language.typeDynamic, true);

if #(type #(1) : int) = 1 then
  print"Dynamic type success\n"
else
  print"Dynamic type failure\n"

