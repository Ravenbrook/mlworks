(*  ==== PERVASIVE LIBRARY UTILITIES ====
 *               STRUCTURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: __library.sml,v $
 *  Revision 1.14  1998/01/30 09:44:20  johnh
 *  [Bug #30326]
 *  Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.13.2.2  1997/11/20  17:00:02  daveb
 * [Bug #30326]
 *
 * Revision 1.13.2.1  1997/09/11  20:56:29  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.13  1997/05/12  16:01:39  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.12  1996/11/18  16:29:58  matthew
 * Removing LambdaSub
 *
 * Revision 1.11  1995/02/13  13:15:41  matthew
 * Adding NewMap
 *
 *  Revision 1.10  1993/08/03  16:14:32  daveb
 *  Added ModuleId parameter.
 *
 *  Revision 1.9  1992/11/21  19:22:19  jont
 *  Replaced MachSpec with MachPerv
 *
 *  Revision 1.8  1992/09/03  16:40:07  richard
 *  Moved the special names out of the compiler as a whole.
 *
 *  Revision 1.7  1992/08/19  18:22:45  davidt
 *  Removed redundant structure arguments.
 *
 *  Revision 1.6  1992/05/05  13:18:23  jont
 *  Added auglambda parameter
 *
 *  Revision 1.5  1992/02/11  13:17:17  richard
 *  Changed the application of the Diagnostic functor to take the Text
 *  structure as a parameter.  See utils/diagnostic.sml for details.
 *
 *  Revision 1.4  1991/11/28  16:31:14  richard
 *  Tidied up documentation and added Diagnostic module.  The functor
 *  has been rewritten at this stage.
 *
 *  Revision 1.3  91/10/29  14:22:15  jont
 *  Added machspec parameter
 *  
 *  Revision 1.2  91/10/22  16:53:53  davidt
 *  Now builds using the Crash_ structure.
 *  
 *  Revision 1.1  91/09/05  11:07:03  jont
 *  Initial revision
 *  
 *  Copyright (c) 1991 Harlequin Ltd.
 *)

require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__lists";
require "../utils/__crash";
require "../utils/__btree";
require "../lambda/__auglambda";
require "../lambda/__lambdaprint";
require "../machine/__machperv";
require "__mlworks_io";

require "_library";

structure Library_ = Library(
  structure Diagnostic = Diagnostic ( structure Text = Text_ )
  structure AugLambda = AugLambda_
  structure NewMap = BTree_
  structure Lists = Lists_
  structure Crash = Crash_
  structure LambdaPrint = LambdaPrint_
  structure MachPerv = MachPerv_
  structure Io = MLWorksIo_
)
