/*  ==== GLOBAL MEMORY MANAGEMENT ====
 *
 *  Copyright (C) 1992 Harelquin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: mem.c,v $
 *  Revision 1.23  1998/10/23 14:09:15  jont
 *  [Bug #70219]
 *  Make stack backtrace function easily available
 *
 * Revision 1.22  1998/08/17  11:34:54  jont
 * [Bug #70153]
 * Add validate_ml_address
 *
 * Revision 1.21  1998/07/15  15:21:02  jont
 * [Bug #20134]
 * Use address validation outside of ml heap
 *
 * Revision 1.20  1998/07/09  12:19:44  jont
 * [Bug #70122]
 * Update space_gen when arrays are unmade to avoid dangling pointers
 *
 * Revision 1.19  1998/05/20  14:03:21  jont
 * [Bug #70035]
 * Add a validate address function
 *
 * Revision 1.18  1998/04/24  13:11:25  jont
 * [Bug #70032]
 * gen->values now measured in bytes
 *
 * Revision 1.17  1998/04/23  14:12:19  jont
 * [Bug #70034]
 * Rationalising names in mem.h
 *
 * Revision 1.16  1997/04/11  13:49:24  stephenb
 * [Bug #1659]
 * Double C_STACK_SIZE to avoid the stack overflowing when
 * MakeCachedDirEntry in the OpenWindows library is called
 * which wants to allocate 65K of stack!
 *
 * Revision 1.15  1996/10/29  16:07:52  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.14  1996/08/23  15:24:32  nickb
 * Extend generation structure to allow better GC triggering.
 *
 * Revision 1.13  1996/05/14  16:08:57  nickb
 * Add out-of-memory hook.
 *
 * Revision 1.12  1996/02/13  17:24:57  jont
 * Add some type casts to allow compilation without warnings under VC++
 *
 * Revision 1.11  1996/01/16  11:52:02  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.10  1996/01/09  11:19:20  nickb
 * change event signalling for stack overflow.
 *
 * Revision 1.9  1995/07/17  08:58:41  nickb
 * Change to definition of OBJECT_SIZE macro.
 *
 * Revision 1.8  1995/03/28  13:08:08  nickb
 * Add C stack support for threads.
 *
 * Revision 1.7  1995/03/07  16:25:51  nickb
 * Extend static object header to have a generation pointer.
 *
 * Revision 1.6  1995/03/02  11:48:05  nickb
 * Finish static object allocation code
 *
 * Revision 1.4  1995/02/27  16:54:55  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.3  1994/10/13  12:36:28  nickb
 * Change to the arena manager to allow arbitrary numbers of blocks.
 *
 * Revision 1.2  1994/06/09  14:46:37  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:17:11  nickh
 * new file
 *
 *  Revision 2.13  1994/01/28  17:47:57  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 2.11  1993/12/15  14:45:17  nickh
 *  Added get_stack_block_limit() and some comments.
 *
 *  Revision 2.10  1993/10/12  16:12:50  matthew
 *  Merging bug fixes
 *
 *  Revision 2.9.1.2  1993/10/12  15:02:19  matthew
 *  Added stack_block_count stuff -- do a kill 30 if limit exceeded and go into debugger
 *  If stack_block_count <= 0, then behave as before
 *
 *  Revision 2.9.1.1  1993/06/02  13:14:00  jont
 *  Fork for bug fixing
 *
 *  Revision 2.9  1993/06/02  13:14:00  richard
 *  Improved the use of const on the argv parameter type.
 *
 *  Revision 2.8  1993/04/30  14:29:31  jont
 *  Changed to distinguish the real base of the stack from the stack limit
 *  pointer
 *
 *  Revision 2.7  1993/04/30  12:54:10  richard
 *  Multiple arguments can now be passed to the storage manager in a general
 *  way.
 *
 *  Revision 2.6  1993/04/28  13:24:57  richard
 *  Increased diagnostic levels.
 *  Rewrote Matthew's code for caching stack blocks.
 *
 *  Revision 2.5  1993/01/27  13:36:40  matthew
 *  Added a cache of stack blocks that get reused rather than deallocated.
 *
 *  Revision 2.4  1992/12/07  16:53:37  richard
 *  Corrected method of creation the heap on the first call.
 *
 *  Revision 2.3  1992/08/18  11:20:01  richard
 *  Changed the types of is_ml_stack and is_ml_heap.
 *
 *  Revision 2.2  1992/08/17  10:48:01  richard
 *  Added a missing newline at the end of sm_size_help.
 *
 *  Revision 2.1  1992/08/04  11:25:59  richard
 *  New version using a separate arena manager.  This code
 *  now deals with descriptors only.
 *
 *  Revision 1.23  1992/07/28  15:06:51  jont
 *  Increased mamximum generations to 15
 *
 *  Revision 1.22  1992/07/27  15:04:54  richard
 *  Corrected the check for memory overflow.
 *
 *  Revision 1.21  1992/07/21  15:25:16  richard
 *  Removed call to init_alloc() according to new interface with runtime
 *  system.  Added a help string for the `-size' option.  Changed the
 *  generation configuration as an experiment.
 *
 *  Revision 1.20  1992/07/16  16:14:56  richard
 *  Added an efficient implementation of is_ml_frame().  Removed the
 *  stack base field from stack descriptors.  GC_SP is no longer
 *  initialised here.
 *
 *  Revision 1.19  1992/07/14  15:43:10  richard
 *  Added stack_base field to stacks.  Initially set GC_HEAP_START
 *  and _LIMIT to zero to force a call to the GC.
 *
 *  Revision 1.18  1992/07/01  11:26:40  richard
 *  Changed the types of some fields in generation and space
 *  structures to reduce the number of casts.  Removed references
 *  to ml_state in favour of stuff declared in storeman.h.
 *
 *  Revision 1.17  1992/06/29  15:00:04  richard
 *  Added some missing initialization.  Implemented experimental
 *  memory mapping scheme.
 *
 *  Revision 1.17  1992/06/26  15:57:01  richard
 *  Added some missing initialization of large space pointers.
 *  Installed an experimental memory mapping scheme.
 *
 *  Revision 1.16  1992/06/23  14:15:28  richard
 *  Implemented deallocate_blocks() and resize() to introduce some hysteresis
 *  into process extension.
 *
 *  Revision 1.15  1992/06/04  10:32:36  richard
 *  Changed generation size tables to something more sensible.
 *  Added check for maximum number of generations.
 *
 *  Revision 1.14  1992/03/19  16:50:06  richard
 *  Generation sizes are fetched from arrays defined in mem.h rather than
 *  calculated by macros.
 *
 *  Revision 1.13  1992/03/16  14:23:54  richard
 *  Corrected definition of unmake_space().  Moved MAXGEN to mem.h.
 *
 *  Revision 1.12  1992/03/12  12:42:17  richard
 *  Added top_generation parameter to specify number of generations to
 *  allocate initially.
 *
 *  Revision 1.10  1992/02/13  15:08:30  clive
 *  First attempt at using allocate_blocks to get memory at loading time
 *
 *  Revision 1.9  1992/01/27  14:13:07  richard
 *  Changed the way the malloc() zone is set up.  Changed make_gen() to
 *  make_semispace() and wrote a new make_gen() which makes a whole
 *  generation.  Added entry table with initialization.  Removed
 *  initial creation of generations: they are now created on demand by
 *  the garbage collector controller.
 *
 *  Revision 1.8  1992/01/20  11:43:42  richard
 *  Added initialization of entry lists in generations.
 *
 *  Revision 1.7  1992/01/17  11:43:18  richard
 *  Removed fragile version of malloc() and free().  See new alloc.h.
 *
 *  Revision 1.6  1992/01/13  14:41:40  richard
 *  Added unmake_stack.
 *
 *  Revision 1.5  1992/01/08  12:50:50  richard
 *  Added a stack size parameter to make_stack().
 *
 *  Revision 1.4  1991/12/23  13:24:01  richard
 *  Added some missing type casts now that we have some more ANSI-like
 *  headers.
 *
 *  Revision 1.3  91/12/19  16:08:46  richard
 *  Rewrote get_blocks so that it works.  Changed crash output so
 *  that it fits in with the rest of the system.
 *
 *  Revision 1.2  91/12/17  17:23:01  nickh
 *  added header and comment.
 *
 *  Revision 1.1  91/12/17  16:17:58  nickh
 *  Initial revision
 */

#include "syscalls.h"
#include "mem.h"
#include "gc.h"
#include "arena.h"
#include "types.h"
#include "state.h"
#include "utils.h"
#include "values.h"
#include "alloc.h"
#include "diagnostic.h"
#include "extensions.h"
#include "options.h"
#include "event.h"
#include "pervasives.h"
#include "stubs.h"
#include "os.h"
#include "stacks.h"

#include <errno.h>
#include <sys/types.h>

struct ml_heap *space_gen[SPACES_IN_ARENA];

/*  === STACK AND HEAP AREAS ===
 *
 *  These are allocated from the `blocked' part of the arena.
 */

/*  == Stack block cache ==
 *
 *  Stack blocks are cached in a simple free list in order to provide some
 *  hysteresis on stack extensions.  This prevents too many allocations and
 *  deallocations of blocks from the arena.
 */

#define STACK_CACHE_SIZE_MAX	10

static struct ml_stack *stack_cache = NULL;
static size_t stack_cache_size = 0, stack_total = 0;

static stack_blocks = 0;

/*  == Making and unmaking stacks == */

struct ml_stack *make_ml_stack(struct ml_stack *parent, size_t size)
{
  struct ml_stack *stack;

  DIAGNOSTIC(4, "make_ml_stack(0x%lX, 0x%lX)", parent, size);

  /* If there is a stack block on the free list and it is large enough, use */
  /* it first. */

  if(stack_cache && (byte *)stack_cache->top - (byte *)stack_cache >= (int)size) {
    stack = stack_cache;
    stack_cache = stack->parent;
    stack->parent = parent;
    --stack_cache_size;
  } else {
    int max_blocks =
      (max_stack_blocks == MLUNIT) ? 0 :
	CINT(DEREF(max_stack_blocks));

    /* allocate a new stack block */
    size = BLOCKROUND(size);
    stack = (struct ml_stack *)block_alloc(TYPE_ML_STACK, size);
    stack->parent = parent;
    stack->top    = (struct stack_frame *)((byte *)stack + size);
    DIAGNOSTIC(4, "  at 0x%lX with top at 0x%X", stack, stack->top);

    /* check for stack overflow. If overflowed, we record an event */
    stack_blocks++;
    if ((max_blocks > 0) &&
	(stack_blocks > max_blocks))
      record_event(EV_STACK,(word)0);

    stack_total += size;
    DIAGNOSTIC(1, "Stack increased to %uK", stack_total>>10, 0);
  }

  return(stack);
}

struct ml_stack *unmake_ml_stack(struct ml_stack *stack)
{
  struct ml_stack *parent = stack->parent;

  DIAGNOSTIC(4, "unmake_ml_stack(0x%lX) parent 0x%lX", stack, stack->parent);

  if(stack_cache_size >= STACK_CACHE_SIZE_MAX)
  {
    /* free this block */
    size_t size = (byte *)stack->top - (byte *)stack;
    block_free((byte *)stack, size);
    stack_total -= size;
    --stack_blocks;
    DIAGNOSTIC(1, "Stack decreased to %uK", stack_total>>10, 0);
  }
  else
  {
    /* return this block to the stack cache */
    stack->parent = stack_cache;
    stack_cache = stack;
    ++stack_cache_size;
  }

  return(parent);
}

/* unwind a stack back to a particular frame; this is called from
 * an assembly-language routine to unwind when handling exceptions */

void unwind_stack(struct stack_frame *sp)
{
  struct ml_stack *stack = STACK_BASE(GC_STACK(CURRENT_THREAD));

  while(sp < (struct stack_frame *)stack || sp >= stack->top)
    stack = unmake_ml_stack(stack);

  GC_STACK(CURRENT_THREAD) = (mlval) STACK_LIMIT(stack);
}



/*
** The maximum initial stack space (in words) needed by any architecture.
** Currently, the maximum value comes from the SPARC where 16 words
** are needed for a register window.
*/
#define C_STACK_ADJUST 16


/*
** The original value (65536) was chosen so that it was (to quote NickB) :-
**
**   big enough to run MLWorks, small enough that it won't bloat memory
**   even if we have lots of threads
**
** It has been doubled as the initial fix to bug 1659.  The size should
** be re-evaluated again when bug/task 2047 is tackled.
*/
#define C_STACK_SIZE (2*65536)


struct c_stack *make_c_stack(void)
{
  struct c_stack *stack = 
    (struct c_stack *)alloc(sizeof (struct c_stack),"C stack descriptor");

  stack->base = (char*)block_alloc(TYPE_C_STACK,C_STACK_SIZE);
  stack->top =
    (struct stack_frame *)((word)stack->base + C_STACK_SIZE-C_STACK_ADJUST);
  return stack;
}



void free_c_stack(struct c_stack *stack)
{
  block_free((byte*)stack->base,C_STACK_SIZE);
  free(stack);
}

void free_ml_stacks(struct ml_stack *stack)
{
  while(stack)
    stack = unmake_ml_stack(stack);
}

/* == Areas for the C heap in the block area == */

struct c_heap *make_heap(struct c_heap *parent, size_t size)
{
  struct c_heap *heap;

  size = BLOCKROUND(size);

  heap = (struct c_heap *)block_alloc(TYPE_C_HEAP, size);

  heap->parent = parent;
  heap->size = size;

  DIAGNOSTIC(4, "make_heap(0x%lX, 0x%lX)", parent, size);
  DIAGNOSTIC(4, "  at 0x%lX", heap, 0);

  return(heap);
}

struct c_heap *unmake_heap(struct c_heap *heap)
{
  struct c_heap *parent = heap->parent;

  DIAGNOSTIC(4, "unmake_heap(0xX) parent 0x%X", heap, parent);

  block_free((byte *)heap, heap->size);

  return(parent);
}

/* == pointer predicates == */

int is_ml_stack(void *p)
{
  return(TYPE(p) == TYPE_ML_STACK);
}

int is_ml_heap(void *p)
{
  unsigned char type = TYPE(p);

  return(type == TYPE_ML_HEAP || type == TYPE_FROM || type == TYPE_ML_STATIC);
}

/*  === STATIC OBJECTS ===
 *
 *  Static objects occupy special spaces in the arena. They are
 * allocated according to a simple first-fit algorithm in the first
 * static space which will accommodate them. */

static struct ml_static_space *static_spaces;

/* allocate a new static space. */

static struct ml_static_space *make_new_static_space(void)
{
  byte *space_ptr = space_alloc(TYPE_ML_STATIC, 0);
  struct ml_static_space *result = 
    (struct ml_static_space *)
      alloc(sizeof(struct ml_static_space),
	    "creating descriptor for space reserved for static objects"); 
  result->forward = static_spaces;
  result->back = static_spaces->back;
  result->forward->back = result;
  result->back->forward = result;
  result->space = SPACE(space_ptr);
  result->mapped = 0;
  result->free_list.mark = 0;
  result->free_list.gen = NULL;
  result->free_list.forward = &result->free_list;
  result->free_list.back = &result->free_list;
  SPACE_STATIC(SPACE(space_ptr)) = result;
  return result;
}
  
/* initialize the static object world by creating a single static space */

static void init_static_objects(void)
{
  /* initialize the first 'static' space */
  static_spaces =
    (struct ml_static_space *)
      alloc(sizeof(struct ml_static_space),
	    "creating descriptor for dummy static object space"); 
  static_spaces->forward = static_spaces;
  static_spaces->back     = static_spaces;
  static_spaces->space    = 0;
  static_spaces->mapped  = SPACE_SIZE;
  static_spaces->free    = 0;
  static_spaces->free_list.mark = 0;
  static_spaces->free_list.gen = NULL;
  static_spaces->free_list.forward = &static_spaces->free_list;
  static_spaces->free_list.back = &static_spaces->free_list;
}

/* Allocate a static object. We do this by first looking for a hole of
 * sufficient size, and failing that by extending one of the static
 * spaces.
 *
 * Notice that holes use the 'mark' slot of the header to register the
 * size in bytes of the hole, including the header. */

struct ml_static_object *make_static_object(size_t bytes)
{
  struct ml_static_space *mappable, *current;
  size_t size = STATIC_SIZE(bytes);
  struct ml_static_object *result;
  
  DIAGNOSTIC(4,"make_static_object(%d)",bytes,0);
  
  if (size > SPACE_SIZE)
    error("Trying to make a static object size %d > %d",size, SPACE_SIZE);
  
  mappable = NULL;
  current = static_spaces->forward;
  while (current != static_spaces) {
    DIAGNOSTIC(5,"  trying space %d",current->space,0);
    if (size <= SPACE_SIZE - current->mapped)
      mappable = current;
    if (size <= current->free) {
      result = current->free_list.forward;
      while(result != &current->free_list) {
	if (size <= result->mark) {
	  DIAGNOSTIC(5,"    hole at 0x%8x size %d",result, result->mark);
	  current->free -= size;
	  if (size == result->mark) {
	    space_remove_hole((byte*)result, size);
	    result->back->forward = result->forward;
	    result->forward->back = result->back;
	    result->mark = 0;
	    return result;
	  } 
	  /* allocate the object in a suffix of this hole */
	  result->mark -= size;
	  result = (struct ml_static_object *)
	    ((byte*)result + result->mark);
	  space_remove_hole((byte*)result, size);
	  result->mark = 0;
	  return result;
	} else
	  /* try the next hole */
	  result = result->forward;
      }
    }
    current = current->forward;
  }

  /* if we get to here, there is no hole large enough, so we map the
   * object at the end of one of the static spaces. If none of the
   * gaps at the end of the static spaces are large enough, we make a
   * new static space. */

  if (!mappable)
    mappable = make_new_static_space();

  DIAGNOSTIC(5,"  appending to space %d",mappable->space,0);
  /* put it at the end of the mappable space */
  result = (struct ml_static_object *)
    (SPACE_BASE(mappable->space) + mappable->mapped);
  mappable->mapped += size;
  space_resize(SPACE_BASE(mappable->space), mappable->mapped);
  result->mark = 0;
  return result;
}

/* Remove a static object. This is called from the GC when it detects
 * that a static object is no longer reachable. It simply adds the
 * object to the free list for that space and merges it with adjacent
 * objects. */

void unmake_static_object(struct ml_static_object *stat)
{
  unsigned int space = SPACE(stat);
  struct ml_static_space *stat_space = SPACE_STATIC(space);
  struct ml_static_object *before, *after;
  mlval header = stat->object[0];
  mlval secondary = SECONDARY(header);
  mlval length = LENGTH(header);

  DIAGNOSTIC(4, "unmake_static_object(0x%X)", stat, 0);

  stat->mark = STATIC_SIZE(OBJECT_SIZE(secondary,length));
  stat->gen = NULL;
  stat_space->free += stat->mark;

  after = &stat_space->free_list;
  do {
    after = after->forward;
  } while (after < stat && after != &stat_space->free_list);
  before = after->back;

  if ((byte*)stat + stat->mark == (byte*) after) {
    stat->mark += after->mark;
    stat->forward = after->forward;
  } else
    stat->forward = after;
  
  if ((byte*)before + before->mark == (byte*) stat) {
    before->mark += stat->mark;
    before->forward = stat->forward;
    stat = before;
  } else
    stat->back = before;
  
  stat->back->forward = stat;
  stat->forward->back = stat;
  
  space_allow_hole((byte*)&stat->object[0],
		   stat->mark-sizeof(struct ml_static_object)+sizeof(mlval));
}

/* When the static objects code breaks, this function is useful to be
   called from gdb:

void print_static_objects(void)
{
  struct ml_static_space *current = static_spaces->forward;
  struct ml_heap *gen = creation;
  printf("free objects: \n");
  while(current != static_spaces) {
    struct ml_static_object *free = current->free_list.forward;
    printf(" static space %d: 0x%x-0x%x\n",current->space,
	   SPACE_BASE(current->space),
	   SPACE_BASE(current->space)+current->mapped);
    while(free != &current->free_list) {
      printf("  object 0x%x-0x%x, size 0x%x\n",free,
	     ((byte*) free) + free->mark,
	     free->mark);
      free = free->forward;
    }
    current = current->forward;
  }
  printf("live objects: \n");
  while (gen != NULL) {
    struct ml_static_object *obj = gen->statics.forward;
    printf(" generation %d\n",gen->number);
    while(obj != &gen->statics) {
      mlval header = obj->object[0];
      mlval secondary = SECONDARY(header);
      mlval length = LENGTH(header);
      size_t size = STATIC_SIZE(OBJECT_SIZE(secondary,length));
      printf("  object 0x%x-0x%x, values 0x%x\n",obj,
	     ((byte*) obj) + size, size);
      obj = obj->forward;
    }
    gen = gen->parent;
  }
}

*/

/*  === GENERATIONS ===
 *
 * Each generation occupies a single `space' in the arena and has a
 * descriptor on the C heap.
 * values and extent are given in bytes
 */

struct ml_heap *make_ml_heap(size_t values, size_t extent)
{
  struct ml_heap *gen;
  byte *space;

  DIAGNOSTIC(2, "make_gen(values = %u, extent = %u)", values, extent);

  if(values > SPACE_SIZE)
    error("An attempt was made to create a generation of size %u",
	  values * sizeof(mlval));

  space = space_alloc(TYPE_ML_HEAP, extent);
  gen = alloc(sizeof(struct ml_heap), "Unable to allocate generation descriptor.");

  gen->number	= 0;
  gen->parent	= gen->child = NULL;
  gen->values	= values;
  gen->start	= (mlval *)space;
  gen->end	= gen->start + space_extent[SPACE(space)]/sizeof(mlval);
  gen->top	= gen->start;
  gen->space    = SPACE(space);
  gen->collect	= (float)0.0;
  gen->entry.the.forward = gen->entry.the.back = &gen->entry;
  gen->nr_entries = 0;
  gen->statics.forward = gen->statics.back = &gen->statics;
  gen->nr_static = 0;

  space_gen[SPACE(space)] = gen;

  DIAGNOSTIC(3, "  descriptor 0x%X  space %d", gen, space);
  DIAGNOSTIC(3, "  start 0x%X  end 0x%X", gen->start, gen->end);

  return(gen);
}

void unmake_ml_heap(struct ml_heap *gen)
{
  space_gen[SPACE(gen->start)] = NULL;
  space_free((byte *)gen->start);
  free(gen);
}

void resize_ml_heap(struct ml_heap *gen, size_t extent)
{
  unsigned int space = gen->space;
  size_t e = extent;

  DIAGNOSTIC(2, "resize_gen(gen = 0x%X, extent = %u)", gen, extent);
  DIAGNOSTIC(3, "  start 0x%X  end 0x%X", gen->start, gen->end);

  if(e > SPACE_SIZE)
    error("An attempt was made to extend a generation to size %u", e);

  space_resize((byte *)gen->start, e);
  gen->end = gen->start + space_extent[space]/sizeof(mlval);

  DIAGNOSTIC(3, "  new end 0x%X", gen->end, 0);
}
  


/*  === INITIALISE MEMORY ===  */

size_t arena_limit;

void sm_init(void)
{
  int i;
  arena_init();
  arena_limit = DEFAULT_ARENA_LIMIT;

  for(i=0; i<SPACES_IN_ARENA; ++i)
    space_gen[i] = NULL;

  init_static_objects();

  /* Make sure that the first allocation enters the gc() and causes the heap */
  /* to be created. */

  creation = NULL;
}

int (*out_of_memory_dialog)(unsigned long int attempt,
			    size_t extent, size_t length) = NULL;

int validate_ml_address(void *addr)
{
  int space = SPACE(addr);
  int type = space_type[space];
  switch(type) {
  case TYPE_RESERVED:
    /* Not managed by the mm */
    /* Possibly in the text or data segments */
    return system_validate_ml_address(addr);
  case TYPE_FREE:
    /* Managed by the mm, but not in use */
    return 0;
  case TYPE_BLOCKS:
    /* Managed for stacks and heaps */
    switch (TYPE(addr)) {
    case TYPE_ML_STACK:
    case TYPE_C_HEAP:
    case TYPE_C_STACK:
      return 1;
    case TYPE_FREE:
      return 0;
    default:
      error_without_alloc("Unknown block type found in validate_ml_address");
    }
  case TYPE_ML_HEAP:
  case TYPE_FROM:
    /* FROM is just a special case of ML_HEAP */
  case TYPE_ML_STATIC:
    return (((void *)(SPACE_BASE(space))) <= addr) && (addr <= ((void *)((SPACE_BASE(space)) + space_extent[space])));
  default:
    error_without_alloc("Unknown space type found in validate_ml_address");
  }
}

int validate_address(void *addr)
{
  if (validate_ml_address(addr)) {
    return 1;
  } else {
    int space = SPACE(addr);
    int type = space_type[space];
    switch(type) {
    case TYPE_RESERVED:
      /* Not managed by the mm */
      /* Possibly in the text or data segments */
      return system_validate_address(addr);
    default:
      /* Don't bother with system_validate_address for this case */
      return 0;
    }
  }
}

extern void ml_backtrace(int depth_max)
{
  backtrace((struct stack_frame *)&(CURRENT_THREAD->ml_state.sp), CURRENT_THREAD, depth_max);
}
