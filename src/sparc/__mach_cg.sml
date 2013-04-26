(* __mach_cg.sml the structure *)
(*
$Log: __mach_cg.sml,v $
Revision 1.30  1993/11/18 12:35:46  jont
Changed to be in terms of __sparc_mach_cg

Revision 1.29  1993/05/18  16:23:27  jont
Removed integer parameter

Revision 1.28  1993/03/10  18:45:42  matthew
Signature revisions

Revision 1.27  1993/03/04  14:01:13  matthew
Options & Info changes

Revision 1.26  1993/02/04  16:12:04  jont
Added Tags parameter

Revision 1.25  1992/11/06  14:32:18  matthew
Changed Error structure to Info

Revision 1.24  1992/08/10  10:38:55  davidt
String structure is now pervasive.

Revision 1.23  1992/08/04  16:43:02  jont
Removed references to save

Revision 1.22  1992/07/07  10:37:59  clive
Added call point information recording

Revision 1.21  1992/06/29  14:45:07  jont
Added sexpr parameter

Revision 1.20  1992/05/06  10:46:32  richard
Changed BalancedTree to generic Map

Revision 1.19  1992/05/01  10:03:01  jont
Added require "__balancedtree"

Revision 1.18  1992/04/27  15:51:46  jont
Added balancedtree

Revision 1.17  1992/02/13  15:20:32  clive
Timer code added

Revision 1.16  1992/02/12  15:03:33  richard
Added Option to parameters.

Revision 1.15  1992/02/11  14:31:42  richard
Changed the application of the Diagnostic functor to take the Text
structure as a parameter.  See utils/diagnostic.sml for details.

Revision 1.14  1992/02/07  11:25:52  richard
Changed Table to BTree to reflect changes in MirRegisters.

Revision 1.13  1992/01/09  15:10:55  clive
Added diagnostic structure

Revision 1.12  1992/01/08  09:53:11  clive
Explicit_vector offsets now read from the implicit structure in the rts directory

Revision 1.11  1991/11/21  15:08:44  jont
Added save parameter

Revision 1.10  91/11/11  15:56:30  jont
Added Reals parameter

Revision 1.9  91/10/29  16:42:21  davidt
Now builds using Print_ structure.

Revision 1.8  91/10/28  14:11:28  jont
Added MirRegisters parameter

Revision 1.7  91/10/22  18:16:44  jont
Added Sparc_Schedule parameter

Revision 1.6  91/10/14  13:50:39  jont
*** empty log message ***

Revision 1.5  91/10/11  17:24:17  jont
Added Set_ to list of parameters

Revision 1.4  91/10/09  11:13:55  jont
Added Integer_

Revision 1.3  91/10/07  16:32:01  jont
Added Sparc_Assembly parameter

Revision 1.2  91/10/07  12:06:08  richard
Changed dependency on MachRegisters to MachSpec.

Revision 1.1  91/10/04  16:20:52  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "__sparc_mach_cg";

structure Mach_Cg_ = Sparc_Mach_Cg_
