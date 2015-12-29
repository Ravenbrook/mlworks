/* rts/src/state.h
 *
 * The global state is declared here.
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
 * $Log: state.h,v $
 * Revision 1.2  1998/07/28 13:39:55  jont
 * [Bug #20133]
 * Add GC_HEAP_REAL_LIMIT
 *
 * Revision 1.1  1995/03/30  13:51:48  nickb
 * new unit
 * Portable state information.
 *
 */

#include "threads.h"
#include "types.h"
#include "mach_state.h"

extern struct global_state global_state;

#define CURRENT_THREAD		global_state.current_thread
#define TOP_THREAD		global_state.toplevel

#define GC_MODIFIED_LIST	CURRENT_THREAD->implicit.gc_modified_list
#define GC_HEAP_START		(*(mlval **)&CURRENT_THREAD->implicit.gc_base)
#define GC_HEAP_LIMIT		(*(mlval **)&CURRENT_THREAD->implicit.gc_limit)
#define GC_HEAP_REAL_LIMIT	(*(mlval **)&CURRENT_THREAD->implicit.real_gc_limit)
#define GC_STACK(thread)	(thread)->implicit.stack_limit

/* GC_SP(thread) and GC_RETURN are machine-specific, so are obtained
 * from mach_state.h */

extern void initialize_global_state(void);

