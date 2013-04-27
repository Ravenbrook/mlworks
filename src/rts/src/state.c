/* rts/src/state.c
 * 
 * The global state is defined here.
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: state.c,v $
 * Revision 1.3  1998/06/10 09:53:12  jont
 * [Bug #70131]
 * Add name for toplevel thread
 *
 * Revision 1.2  1998/02/27  14:29:55  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.1  1995/03/30  13:52:57  nickb
 * new unit
 * Portable state information.
 *
 */

#include "state.h"
#include "interface.h"
#include "implicit.h"
#include "values.h"
#include "gc.h"

static char toplevel_thread_name[] = "toplevel (NULL) thread";

struct global_state global_state;

extern void initialize_global_state(void)
{
  int i;

  global_state.in_ML 			= 0;
  global_state.current_thread		= &TOP_THREAD;
  global_state.toplevel.name		= toplevel_thread_name;
  initialize_top_thread_implicit();
  initialize_top_thread_state();

  for (i=0 ; i < THREAD_ROOTS ; i++)
    TOP_THREAD.declared[i] 		= 0;

  TOP_THREAD.global			= &global_state;

  TOP_THREAD.children			= 0;
  TOP_THREAD.first_child		= &TOP_THREAD;
  TOP_THREAD.last_child			= &TOP_THREAD;
  TOP_THREAD.next_sib			= NULL;
  TOP_THREAD.last_sib			= NULL;
  TOP_THREAD.parent			= &TOP_THREAD;
  TOP_THREAD.next			= &TOP_THREAD;
  TOP_THREAD.last			= &TOP_THREAD;
  TOP_THREAD.number			= next_thread_number++;

  { /* the ML thread value */
    /* this call will cause the zeroth GC */
    mlval result = ref(THREAD_RUNNING);
    declare_root(&result, 0);
    TOP_THREAD.ml_thread = cons(result,(mlval)&TOP_THREAD);
    retract_root(&result);
    declare_root(&TOP_THREAD.ml_thread, 1);
  }
}
