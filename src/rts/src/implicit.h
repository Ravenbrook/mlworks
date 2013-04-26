/*  ==== THE IMPLICIT VECTOR ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  The `implicit vector' is an extension to the global ML state which
 *  contains various values which ML needs to access fairly quickly.
 *
 *  IMPORTANT
 *  ---------
 *  This file is scanned automatically by implicit.awk and __implicit.awk to
 *  produce ML sources.
 *
 *  Revision Log
 *  ------------
 *  $Log: implicit.h,v $
 *  Revision 1.9  1998/07/28 10:37:44  jont
 *  [Bug #20133]
 *  Add an extra gc_limit slot so we can modify the other one when space profiling
 *
 * Revision 1.8  1995/06/19  14:32:05  nickb
 * Add space profiling offsets.
 *
 * Revision 1.7  1995/06/02  15:24:15  jont
 * Add field for stack limit register (for Intel)
 *
 * Revision 1.6  1995/05/03  09:19:58  matthew
 * Removing debugger slots from implicit vector
 *
 * Revision 1.5  1995/03/15  12:45:57  nickb
 * Introduce the threads system.
 *
 * Revision 1.4  1995/02/10  16:35:06  matthew
 * Adding implicit vector entries for step and breakpoint functions
 *
 * Revision 1.3  1994/09/19  11:48:50  jont
 * Add PC slots for gc, handler and stack_limit
 *
 * Revision 1.2  1994/06/09  14:38:26  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:05:37  nickh
 * new file
 *
 *  Revision 1.9  1993/11/05  15:09:58  jont
 *  Added check_event entries for leaf and non-leaf.
 *
 *  Revision 1.8  1993/04/21  14:16:12  jont
 *  Added leaf raise code
 *
 *  Revision 1.7  1993/04/14  13:24:03  richard
 *  Removed old junk.  Added entries for new tracing mechanism.
 *
 *  Revision 1.6  1992/11/11  11:38:07  clive
 *  Added the trace_hook
 *
 *  Revision 1.5  1992/07/10  14:19:27  richard
 *  Removed redundent memory_profiler entry.
 *
 *  Revision 1.4  1992/07/03  09:20:43  richard
 *  The implicit vector is now a struct, since it contains
 *  various things of various types.
 *
 *  Revision 1.3  1992/01/20  13:51:38  richard
 *  Added MODIFIED_REF_LINK.
 *
 *  Revision 1.2  1992/01/08  09:30:32  richard
 *  Tidied up the documentation and altered the declaration to make the
 *  machine scanning safer.
 *
 *  Revision 1.1  1991/10/24  16:11:49  davidt
 *  Initial revision
 */

#ifndef implicit_h
#define implicit_h

#include "types.h"
#include "mltypes.h"


/* The following declaration is scanned automatically by implicit.awk and */
/* __implicit.awk.  Each element of the struct must be one word in size. */

struct implicit_vector
{
  /* ref_chain              */  union ml_array_header *gc_modified_list;
  /* gc                     */  void (*gc)(void);
  /* gc_leaf                */  void (*gc_leaf)(void);
  /* external               */  void (*external)(void);
  /* extend                 */  void (*extend)(void);
  /* raise_code             */  void (*raise)(void);
  /* leaf_raise_code        */  void (*ml_raise_leaf)(void);
  /* replace		    */  void (*replace)(void);
  /* replace_leaf	    */  void (*replace_leaf)(void);
  /* intercept              */  void (*intercept)(void);
  /* intercept_leaf         */  void (*intercept_leaf)(void);
  /* interrupt              */  word interrupt;
  /* event_check	    */  void (*event_check) (void);
  /* event_check_leaf	    */  void (*event_check_leaf) (void);
  /* profile_alloc	    */  word ml_profile_alloc;
  /* profile_alloc_2	    */  word ml_profile_alloc_2;
  /* profile_alloc_3	    */  word ml_profile_alloc_3;
  /* profile_alloc_leaf     */  word ml_profile_alloc_leaf;
  /* profile_alloc_leaf_2   */  word ml_profile_alloc_leaf_2;
  /* profile_alloc_leaf_3   */  word ml_profile_alloc_leaf_3;
  /* gc_base		    */  word gc_base;
  /* gc_limit		    */  word gc_limit;
  /* real_gc_limit     	    */  word real_gc_limit;
  /* handler		    */  word handler;
  /* stack_limit	    */  word stack_limit;
  /* register_stack_limit   */  word register_stack_limit;
};

void initialize_top_thread_implicit(void);
void implicit_init(void);

#endif
