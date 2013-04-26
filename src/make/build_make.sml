(* build_make.sml the signature *)
(*
$Log: build_make.sml,v $
Revision 1.8  1996/03/26 13:17:14  stephenb
Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
the deprecated OS interface.

 * Revision 1.7  1996/01/23  10:27:36  matthew
 * Adding nj-env.sml file
 *
Revision 1.6  1994/12/09  12:29:43  jont
Replace use of unix with generic os

Revision 1.5  1993/08/26  10:09:45  richard
Moved the declaration of require to after the use of change_nj.  The
latter now declares its own version in order to deal with the
pervasive modules correctly.

Revision 1.4  1992/08/07  15:00:15  davidt
Minor changes.

Revision 1.3  1992/05/18  16:07:51  clive
Adjusted the initial timer functions to make smlk images with this loaded
in compatible with our own compiler

Revision 1.2  1991/11/21  16:31:10  jont
Added copyright message

Revision 1.1  91/06/07  11:03:04  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
(* Before loading this you should make sure that your current directory is
   the directory containing this file *)

(*****
A make system for ML.
******
We have to use this build script given that we may not have
an import system available yet.
******
This can only be loaded into an NJML image in which import
is not a keyword.
*****)  

use "nj_env.sml"; (* Simulate the runtime environment *)
use "change_nj.sml";

fun require x = use (x ^ ".sml");

use "pathname.sml";
use "importer.sml";

use "../system/__old_os.sml";
use "_pathname.sml";
use "_importer.sml";

structure PathName_ = PathName (structure OldOs = OldOs_)
structure Importer_ = Importer (structure OldOs = OldOs_ and PathName = PathName_)

open Importer_
