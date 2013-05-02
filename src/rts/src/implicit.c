/*  ==== THE IMPLICIT VECTOR ====
 *
 *  Copyright (C) 1991 Harlequin Ltd
 *
 *  IMPORTANT
 *  ---------
 *  This file is scanned automatically to produce the file
 *  implicit.sml so follow the instructions in the comments when
 *  modifying it.
 *
 *  Revision Log
 *  ------------
 *  $Log: implicit.c,v $
 *  Revision 1.9  1995/12/11 15:43:18  nickb
 *  Add space profiling for MIPS.
 *
 * Revision 1.8  1995/06/19  14:36:10  nickb
 * Add profiling slots.
 *
 * Revision 1.7  1995/06/02  15:06:28  jont
 * Add field for stack limit register (for Intel)
 *
 * Revision 1.6  1995/05/03  09:23:44  matthew
 * Removing debugger slots from implicit vector
 *
 * Revision 1.5  1995/03/28  13:06:10  nickb
 * Introduce the threads system.
 *
 * Revision 1.4  1995/02/10  16:35:52  matthew
 * Adding implicit vector entries for step and breakpoint functions
 *
 * Revision 1.3  1994/09/19  11:50:19  jont
 * Add PC slots for gc, handler and stack_limit
 *
 * Revision 1.2  1994/06/09  14:37:02  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:03:54  nickh
 * new file
 *
 *  Revision 1.19  1993/11/05  14:32:16  jont
 *  Added check_event entries for leaf and non-leaf.
 *
 *  Revision 1.18  1993/04/22  16:50:46  jont
 *  Added leaf raise code
 *
 *  Revision 1.17  1993/04/14  13:24:05  richard
 *  Removed old junk.  Added entries for new tracing mechanism.
 *
 *  Revision 1.16  1992/11/11  11:38:16  clive
 *  Added a trace hook
 *
 *  Revision 1.15  1992/07/31  07:55:28  richard
 *  Added ml_trap, which might be useful.
 *
 *  Revision 1.14  1992/07/27  14:05:54  richard
 *  poly_equal was never used.
 *  ml_external is now ml_lookup_pervasive.
 *
 *  Revision 1.13  1992/07/22  13:39:37  clive
 *  Zeroed out profiler slot
 *
 *  Revision 1.12  1992/07/10  14:19:29  richard
 *  Removed redundent memory_profiler entry.
 *
 *  Revision 1.11  1992/07/03  13:51:11  richard
 *  The implicit vector is now a struct, since it contains
 *  various things of various types.
 *
 *  Revision 1.10  1992/06/17  13:38:14  richard
 *  Added ml_gc_leaf to implicit vector.
 *
 *  Revision 1.9  1992/05/08  16:32:06  clive
 *  Added code for memory profiling
 *
 *  Revision 1.8  1992/04/13  16:23:05  clive
 *  First version of the profiler
 *
 *  Revision 1.7  1992/03/25  09:52:37  richard
 *  Added ml_poly_equal to implicit vector.
 *
 *  Revision 1.6  1992/03/24  16:08:27  richard
 *  Removed obsolete `ml_preserve' from implicit vector.
 *
 *  Revision 1.5  1992/01/20  13:51:29  richard
 *  Added ref_chain.
 *
 *  Revision 1.4  1992/01/14  14:51:26  richard
 *  Added raise_code.
 *
 *  Revision 1.3  1992/01/08  12:48:16  richard
 *  Tidied up documentation, changed the names of the externals to be more
 *  meaningful and added a new external `extend'.
 *
 *  Revision 1.2  1992/01/03  12:44:30  richard
 *  Added ml_preserve to the implicit vector.
 *
 *  Revision 1.1  1991/10/24  16:24:22  davidt
 *  Initial revision
 */

#include "mltypes.h"
#include "values.h"
#include "state.h"
#include "interface.h"
#include "environment.h"
#include "global.h"

/* there is no longer a struct implicit_vector called implicit_vector;
 * its role has been subsumed by global_state.toplevel.implicit */

void initialize_top_thread_implicit(void)
{
  TOP_THREAD.implicit.gc 		= ml_gc;
  TOP_THREAD.implicit.gc_leaf	 	= ml_gc_leaf;
  TOP_THREAD.implicit.external		= ml_lookup_pervasive;
  TOP_THREAD.implicit.extend		= ml_disturbance;
  TOP_THREAD.implicit.raise		= ml_raise;
  TOP_THREAD.implicit.ml_raise_leaf	= ml_raise_leaf;
  TOP_THREAD.implicit.replace		= ml_replace;
  TOP_THREAD.implicit.replace_leaf	= ml_replace_leaf;
  TOP_THREAD.implicit.intercept		= ml_intercept;
  TOP_THREAD.implicit.intercept_leaf	= ml_intercept_leaf;
  TOP_THREAD.implicit.event_check	= ml_event_check;
  TOP_THREAD.implicit.event_check_leaf	= ml_event_check_leaf;

  TOP_THREAD.implicit.interrupt		= 0;
  TOP_THREAD.implicit.handler		= 0;
  TOP_THREAD.implicit.stack_limit	= 0;
  TOP_THREAD.implicit.register_stack_limit = 0;
  TOP_THREAD.implicit.gc_modified_list	= NULL;
  TOP_THREAD.implicit.gc_base		= 0;
  TOP_THREAD.implicit.gc_limit		= 0;

#ifdef IMPLICIT_PROFILE_CODE
  {
    size_t bytes =
      ((char*)(&implicit_profile_alloc_code_end))-
	((char*)(&implicit_profile_alloc_code));

    memcpy (((char*)&TOP_THREAD.implicit.ml_profile_alloc),
	    ((char*)(&implicit_profile_alloc_code)),
	    bytes);
  }
#else
  TOP_THREAD.implicit.ml_profile_alloc      = (word)ml_profile_alloc;
  TOP_THREAD.implicit.ml_profile_alloc_leaf = (word)ml_profile_alloc_leaf;
#endif
}

/* don't do anything here now */
void implicit_init(void)
{
}
