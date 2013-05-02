/* rts/src/state.h
 *
 * The global state is declared here.
 *
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * $Log: state.h,v $
 * Revision 1.1  1995/03/30 13:51:48  nickb
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
#define GC_HEAP_START		((mlval *)CURRENT_THREAD->implicit.gc_base)
#define GC_HEAP_LIMIT		((mlval *)CURRENT_THREAD->implicit.gc_limit)
#define GC_STACK(thread)	(thread)->implicit.stack_limit

/* GC_SP(thread) and GC_RETURN are machine-specific, so are obtained
 * from mach_state.h */

extern void initialize_global_state(void);

