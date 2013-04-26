(*

Result: OK
 
$Log: real_pattern.sml,v $
Revision 1.6  1997/11/21 10:52:52  daveb
[Bug #30323]

 * Revision 1.5  1997/05/28  12:14:33  jont
 * [Bug #30090]
 * Remove uses of MLWorks.IO
 *
 * Revision 1.4  1996/11/05  13:07:46  andreww
 * [Bug #1711]
 * real not eqtype in sml'96.
 *
 * Revision 1.3  1996/05/22  10:54:53  daveb
 * Renamed Shell.Module to Shell.Build.
 *
 * Revision 1.2  1996/05/01  17:38:43  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.1  1993/11/17  18:50:10  jont
 * Initial revision
 *
Copyright (c) 1993 Harlequin Ltd.
*)

Shell.Options.set(Shell.Options.Language.oldDefinition,true);

fun f 0.0 = 0.0
|   f x = (print(Real.toString x); print"\n"; f (x / 2.0))

val it = (f 0.0, f 1.0)
