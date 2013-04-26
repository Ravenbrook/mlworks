/*
 * initialise.c
 * Initialise the run-time system.
 * $Log: initialise.c,v $
 * Revision 1.11  1998/11/10 15:58:02  mitchell
 * [Bug #70242]
 * Initialise sockets support
 *
 * Revision 1.10  1997/04/30  13:51:11  stephenb
 * Add a call to mlw_c_init to support new C interface.
 *
 * Revision 1.9  1996/08/27  14:23:44  nickb
 * storeman arguments no longer passed to initializer.
 *
 * Revision 1.8  1996/02/16  12:43:28  nickb
 * Change to declare_global().
 *
 * Revision 1.7  1995/03/15  15:18:10  nickb
 * Change to thread system.
 *
 * Revision 1.6  1994/09/16  10:16:09  jont
 * Change for smaller handler frames
 *
 * Revision 1.5  1994/07/19  09:21:17  nickh
 * Abstract state initialising into state_initialise().
 *
 * Revision 1.4  1994/07/18  14:33:42  jont
 * Add initialisation of c_state
 *
 * Revision 1.3  1994/07/12  13:40:20  jont
 * Add call to stubs_init
 *
 * Revision 1.2  1994/06/09  14:38:49  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:06:03  nickh
 * new file
 *
 * Revision 1.31  1993/06/22  11:04:53  richard
 * Moved and tidied the code to produce the static top-level exception
 * handler record.  This code was formerly _before_ the initialization
 * of the global root package, so it tended to forget the address.
 *
 * Revision 1.30  1993/06/02  13:03:26  richard
 * Improved the use of const in the argv argument type.
 *
 * Revision 1.29  1993/04/30  14:31:01  jont
 * Changed to distinguish the real base of the stack from the stack limit pointer
 *
 * Revision 1.28  1993/04/30  12:36:43  richard
 * Multiple arguments can now be passed to the storage manager in a general
 * way.
 *
 * Revision 1.27  1993/04/28  15:33:23  jont
 * Make the top level handler a real handler
 *
 * Revision 1.26  1993/03/11  16:44:30  richard
 * Removed an unused root in the implicit vector.
 *
 * Revision 1.25  1992/11/16  13:34:04  clive
 * Need to declare the trace_hook as a root
 *
 * Revision 1.24  1992/10/26  14:07:15  richard
 * Removed stuff related to debugger and added initialisation of
 * the event handler.
 *
 * Revision 1.23  1992/08/19  14:01:12  clive
 * The fix for the ^C exiting problem
 *
 * Revision 1.22  1992/08/17  10:56:24  richard
 * Corrected the initialisation of the interrupt handler.  This must
 * use sigvec() to be well defined.
 *
 * Revision 1.21  1992/07/31  13:32:08  clive
 * Set up interrupt signal handler
 *
 * Revision 1.20  1992/07/29  14:28:48  richard
 * Added profile_init().
 *
 * Revision 1.19  1992/07/24  10:41:12  richard
 * Added NULL hooks to calls to declare_global().
 *
 * Revision 1.18  1992/07/23  11:51:17  richard
 * Changed several declare_roots to declare_global so that they are
 * preserved over image saves and restores.  (See global.h and main.c.)
 *
 * Revision 1.17  1992/07/20  14:13:36  richard
 * The initial ML stack and signal stack are allocated here rather
 * than in the memory manager.  This simplifies the requirements on the
 * memory manager, and allows several signals to share the signal stack.
 *
 * Revision 1.16  1992/07/16  16:14:46  richard
 * Initialised ml_state.base and GC_SP.
 *
 * Revision 1.15  1992/07/14  10:59:51  richard
 * Added missing load_init(), and removed obsolete profiler
 * interrupt setup.  Initialised gc_clock to zero.
 *
 * Revision 1.14  1992/07/03  09:31:44  richard
 * Set up the interrupt flag in the implicit vector.
 *
 * Revision 1.13  1992/07/01  14:45:44  richard
 * Declared garbage collectible things in ml_state as C roots so
 * that the GC doesn't need to know about them.  Changed module
 * table initialisation.
 *
 * Revision 1.12  1992/06/11  11:48:03  clive
 * Moved the setting up of the interrupt stack to this function
 *
 * Revision 1.11  1992/03/12  16:06:33  richard
 * Added pervasives_init().
 *
 * Revision 1.9  1992/01/22  12:55:17  richard
 * Added code to empty the modified ref chain.
 *
 * Revision 1.8  1992/01/14  10:13:38  richard
 * Removed top-level handler record initialization.  The top-level handler is
 * now represented by a zero.
 *
 * Revision 1.7  1991/12/23  15:12:37  richard
 * Added code to generate and initialize a top level handler record.
 *
 * Revision 1.6  91/12/17  16:31:28  nickh
 *  Now calls mem_init (from mem.c) which does most of the actual work. Note
 * that malloc will not work until mem_init has been called, so this must be
 * done before anything else.
 * 
 * Revision 1.5  91/10/29  14:11:06  davidt
 * Heap initialisation is now done in the garbage collector. The initial
 * ML state is now set up here to have a zero sized heap.
 * 
 * Revision 1.4  91/10/28  12:22:02  davidt
 * Trivial changes to comments.
 * 
 * Revision 1.3  91/10/24  17:16:56  davidt
 * Now initialises the toplevel exception handler.
 * 
 * Revision 1.2  91/10/24  16:07:59  davidt
 * Now sets up the pointer to the implicit vector.
 * 
 * Revision 1.1  91/10/23  15:44:25  davidt
 * Initial revision
 * 
 * 
 * Copyright (c) Harlequin 1991.
 */


#include "initialise.h"
#include "modules.h"
#include "mem.h"
#include "gc.h"
#include "stacks.h"
#include "implicit.h"
#include "state.h"
#include "utils.h"
#include "values.h"
#include "pervasives.h"
#include "profiler.h"
#include "loader.h"
#include "main.h"
#include "global.h"
#include "event.h"
#include "environment.h"
#include "tags.h"
#include "diagnostic.h"
#include "os.h"
#include "signals.h"
#include "stubs.h"
#include "threads.h"
#include "sockets.h"
#include "mlw_ci_init.h"


void initialise()
{
  image_continuation = MLUNIT;
  declare_global("image continuation", &image_continuation, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  profile_init();
  load_init();
  pervasives_init();
  ev_init();
  os_init();
  signals_init();
  threads_init();
  implicit_init();
  mlw_ci_init();
  sockets_init();

  gc_clock = 0.0;
  in_GC = 0;
}
