/*  ==== GLOBAL MEMORY MANAGEMENT ====
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
 *  These declarations deal with the allocation of memory, including
 *  creation of generations, stacks, etc. for the garbage collector.
 *
 *  We deal with 5 kinds of objects: ML stack blocks, C stack blocks,
 * C heap blocks, generations, and static ML object spaces. The C
 * struct declarations are here, as are functions to make, delete,
 * resize, &c.
 *
 *  This module requests pieces of memory from the arena manager, in
 *  'blocks' (fixed size, typically 64k) and 'spaces' (variable size
 *  with fixed alignment, typically 16 Mb). Generations are given a
 *  space each. Static objects are allocated in static spaces. The ML
 *  stack and the C heap are allocated in blocks. See arena.h for more
 *  information.
 *
 *  We define several new types for memory: TYPE_STATIC, TYPE_GEN,
 *  TYPE_FROM, TYPE_STACK, TYPE_HEAP. These are used in the type maps
 *  defined by the arena manager.
 *
 *  For more information, see the comments below.
 *  
 *  Revision Log
 *  ------------
 *  $Log: mem.h,v $
 *  Revision 1.21  1998/10/23 14:17:30  jont
 *  [Bug #70219]
 *  Make stack backtrace function easily available
 *
 * Revision 1.20  1998/08/17  10:56:40  jont
 * [Bug #70153]
 * Add validate_ml_address
 *
 * Revision 1.19  1998/05/19  14:49:29  jont
 * [Bug #70120]
 * Add prototype for validate_address
 *
 * Revision 1.18  1998/04/24  10:19:26  jont
 * [Bug #70032]
 * gen->values now measured in bytes
 *
 * Revision 1.17  1998/04/23  14:09:29  jont
 * [Bug #70034]
 * Clean up TYPEs and structs
 *
 * Revision 1.16  1998/03/03  14:15:46  jont
 * [Bug #70018]
 * Add field to struct gen to indicate image save high water mark
 *
 * Revision 1.15  1996/10/29  16:06:43  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.14  1996/08/28  11:36:27  nickb
 * DEFAULT_ARENA_LIMIT should be in bytes, not megabytes.
 *
 * Revision 1.13  1996/08/23  15:24:22  nickb
 * Storage manager no longer has its own options.
 *
 * Revision 1.12  1996/05/21  15:43:26  nickb
 * Clear up comment for VALUE_GEN.
 *
 * Revision 1.11  1996/05/14  16:08:08  nickb
 * Add out-of-memory hook.
 *
 * Revision 1.10  1996/01/15  17:32:23  nickb
 * Remove "storage manager" interface; replace it with regular functions.
 *
 * Revision 1.9  1995/03/15  17:10:38  nickb
 * Add C stack support for threads.
 *
 * Revision 1.8  1995/03/07  16:12:38  nickb
 * Extend static object header to have a generation pointer.
 *
 * Revision 1.7  1995/03/02  10:55:21  nickb
 * space_gen becomes SPACE_GEN
 * Also new macros for static objects.
 *
 * Revision 1.6  1995/02/28  16:44:29  nickb
 * Partially implemented static objects.
 *
 * Revision 1.5  1995/02/27  16:50:22  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.4  1994/12/05  15:55:47  jont
 * Remove double align from large_object
 *
 * Revision 1.3  1994/10/21  14:37:35  nickb
 * Correct comment.
 *
 * Revision 1.2  1994/06/09  14:51:31  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:26:23  nickh
 * new file
 *
 *  Revision 2.5  1993/12/15  14:19:42  nickh
 *  Added a comment.
 *
 *  Revision 2.3  1993/10/12  16:11:23  matthew
 *  Merging bug fixes
 *
 *  Revision 2.2.1.2  1993/10/12  15:03:33  matthew
 *  Added extend_max_stack_block_count and set_max_stack_block_count
 *
 *  Revision 2.2.1.1  1992/10/15  16:44:20  jont
 *  Fork for bug fixing
 *
 *  Revision 2.2  1992/10/15  16:44:20  richard
 *  Removed the padding word from the large object header.  It was causing
 *  the mark word to be misaligned.
 *
 *  Revision 2.1  1992/08/04  10:31:51  richard
 *  New version using a separate arena manager.  This code
 *  now deals with descriptors only.
 *
 *  Revision 1.18  1992/07/28  15:05:51  jont
 *  Increased mamximum generations to 15
 *
 *  Revision 1.17  1992/07/27  15:06:23  richard
 *  Increased MAXBLKS to 8192.
 *
 *  Revision 1.16  1992/07/23  13:34:01  richard
 *  Added a `top' field to the large object header.
 *
 *  Revision 1.15  1992/06/30  14:14:32  richard
 *  Moved storage manager independent declarations to storeman.h.
 *  Changed some types in space and generation descriptors.
 *
 *  Revision 1.14  1992/06/29  14:57:36  richard
 *  Added GRAINROUNDUP.
 *
 *  Revision 1.13  1992/06/23  13:57:16  richard
 *  Added large_object and deallocate_blocks().
 *
 *  Revision 1.12  1992/03/19  16:44:20  richard
 *  Generation sizes are fetched from arrays defined in mem.h rather than
 *  calculated by macros.
 *
 *  Revision 1.11  1992/03/16  11:23:27  richard
 *  Moved MAXGEN here from mem.c.  Added BLKBASE macro.
 *
 *  Revision 1.10  1992/03/12  12:29:40  richard
 *  Added top_generation parameter to specify number of generations to
 *  allocate initially.
 *
 *  Revision 1.9  1992/03/10  17:25:29  richard
 *  Major revision:  Memory is now arranged in terms of spaces rather than
 *  generations, and descriptors for spaces and generations are allocated
 *  on the C heap rather than the ML one.  This should improved robustness
 *  and locality of reference when dealing with generation descriptors.
 *  genmap replaced with spacemap.
 *
 *  Revision 1.8  1992/02/13  15:04:13  clive
 *  First attempt at using allocate_blocks to get memory at loading time
 *
 *  Revision 1.7  1992/01/27  14:12:24  richard
 *  Added entry table, and exported make_gen() and unmake_gen() for use in the
 *  garbage collector controller.  Removed generation size macros: there are
 *  replaced by more general macros in "gc.h".
 *
 *  Revision 1.6  1992/01/20  11:43:40  richard
 *  Added entry list link structure to generation header.
 *
 *  Revision 1.5  1992/01/17  11:41:54  richard
 *  Removed dodgy version of malloc() and free().  See new alloc.h.
 *
 *  Revision 1.4  1992/01/08  11:47:58  richard
 *  Changed the type of stacktop to a void *.  Added INITIAL_STACK_SIZE.
 *
 *  Revision 1.3  1991/12/23  13:22:07  richard
 *  Changed the types of malloc and free to reflect ANSI definitions.
 *
 *  Revision 1.2  91/12/17  17:22:28  nickh
 *  added header and comment
 *  
 *  Revision 1.1  91/12/17  16:15:29  nickh
 *  Initial revision */

#ifndef mem_h
#define mem_h

#include "mltypes.h"
#include "types.h"
#include "arena.h"

/*  == ML stack area header ==
 *
 *  The stack structure appears immediately before the memory which makes up
 *  the stack.
 */

struct ml_stack
{
  struct ml_stack *parent;     	/* link to previous stack */
  struct stack_frame *top;	/* the top of the stack area */
};

/*  == C stack area header ==
 *
 *  The stack structure appears immediately before the memory which makes up
 *  the stack.
 */

struct c_stack
{
  struct stack_frame *top;	/* the top of the stack area */
  char *base;
};

/*  == C heap area header ==
 *
 *  The heap structure appears immediately before the memory which makes up
 *  the C heap area.
 */

struct c_heap
{
  struct c_heap *parent;		/* link to previous heap */
  size_t size;			/* total size of area, including this struct */
};

/*  == Static object descriptor ==
 *
 *  ML objects which should not be moved by the GC (e.g. large
 * objects, objects used in the foreign interface) are allocated in
 * spaces of their own (see static space descriptor, below) and
 * chained together using this descriptor.  Each generation (see
 * below) is on a doubly-linked list of static objects which it
 * logically contains.  This header must be 16 bytes long, and the
 * word immediately before the object must be the mark word.  */

struct ml_static_object
{
  struct ml_static_object *forward, *back;
  struct ml_heap *gen;		/* the generation of the object */
  word mark;			/* used to mark and sweep object in GC */
  mlval object[1];		/* the first word of the object */
};

/* STATIC_ALIGN  aligns values to 16-byte boundaries.
 * STATIC_SIZE   gives the total size of a static object including n user bytes
 * STATIC_HEADER gives the static object header given a ptr to the ML header
 */

#define STATIC_ALIGN(addr)	(((word)(addr)+15) & ~15u)
#define STATIC_SIZE(bytes)	STATIC_ALIGN((bytes) - sizeof(mlval) +   \
					     sizeof(struct ml_static_object))
#define STATIC_HEADER(ml_header)	((struct ml_static_object *)	\
					 (((byte*)(ml_header)) -	\
					  sizeof(struct ml_static_object) + \
					  sizeof(mlval)))

/*  == Static space descriptor ==
 * 
 * Static ML objects are in specially tagged spaces. Each such space
 * has a descriptor like the one below. These are on a doubly-linked
 * list in address order. 
 */

struct ml_static_space
{
  struct ml_static_space *forward, *back;
  unsigned int space;		/* space number occupied */
  size_t mapped;		/* number of bytes mapped for this space */
  size_t free;			/* number of bytes in 'holes' in this space */
  struct ml_static_object free_list; /* first hole */
};

/* SPACE_STATIC(space) gives the static space descriptor for the space */

#define SPACE_STATIC(space)	((struct ml_static_space *)space_info[space])

/*  == Generation descriptor ==
 *
 *  A generation contains data of a particular age.
 */

struct ml_heap
{
  int number;			   /* generation number */
  struct ml_heap *parent, *child;  /* adjacent generations */
  unsigned int space;		   /* space number occupied */
  float collect;		   /* used to time collections */
  size_t values;		   /* maximum extent in values */
  mlval *start, *end;		   /* current extent of memory in the space */
  mlval *top;			   /* top of live data in this space */
  mlval *image_top;		   /* top of live data for image save */
  union ml_array_header entry;     /* entry list */
  union ml_array_header last;      /* end of the entry list for image save */
  unsigned nr_entries;		   /* number of entries in the above list (for stats) */
  struct ml_static_object statics; /* chain of static objects `in' space */
  unsigned nr_static;		   /* number of static objects (for stats) */
};

/* GENERATION(obj) gives the generation of an ML value which points to
 *			 a true header (not a back pointer or shared closure).
 * VALUE_GEN(val)  gives the generation of any ML value except shared closures.
 */

#define GENERATION(ml_object)	(SPACE_TYPE(ml_object) == TYPE_ML_STATIC ?	      \
				 STATIC_HEADER(OBJECT((word)ml_object))->gen: \
				 space_gen[SPACE(ml_object)])

#define VALUE_GEN(ml_value)     (SPACE_TYPE(ml_value) == TYPE_ML_STATIC ?	      \
				 STATIC_HEADER(TRUE_HEAD(ml_value))->gen :    \
				 space_gen[SPACE(ml_value)])

/* ML uses spaces from the arena manager as generations and large
 * objects. It uses blocks as stack and C heap. */

#define TYPE_ML_HEAP	1	/* an ML heap generation */
#define TYPE_FROM	2	/* ditto, currently being copied from */
#define TYPE_ML_STACK	3	/* ML stack area */
#define TYPE_C_HEAP	4	/* C heap area */
#define TYPE_ML_STATIC	5	/* static ML objects */
#define TYPE_C_STACK	6	/* C stack area */

extern struct ml_heap *space_gen[SPACES_IN_ARENA];

/* functions on static objects */

extern struct ml_static_object *make_static_object(size_t bytes);
extern void unmake_static_object(struct ml_static_object *stat);

/* functions on generations */

extern struct ml_heap *make_ml_heap(size_t values, size_t extent);
extern void resize_ml_heap(struct ml_heap *gen, size_t extent);
extern void unmake_ml_heap(struct ml_heap *gen);

/* functions on C heap blocks */

extern struct c_heap *make_heap(struct c_heap *parent, size_t size);
extern struct c_heap *unmake_heap(struct c_heap *heap);

/* functions on stack blocks */

extern struct ml_stack *make_ml_stack(struct ml_stack *parent, size_t size);
extern struct ml_stack *unmake_ml_stack(struct ml_stack *stack);
extern void unwind_stack(struct stack_frame *sp);

extern struct c_stack *make_c_stack(void);
extern void free_c_stack(struct c_stack *stack);
extern void free_ml_stacks(struct ml_stack *stack);

/* stack overflow handling macros */

#define STACK_LIMIT(base)					\
  (struct ml_stack *)(((int)(base))+STACK_BUFFER+DEFAULT_STACK_SIZE)
#define STACK_BASE(limit)					\
  (struct ml_stack *)(((int)(limit))-STACK_BUFFER-DEFAULT_STACK_SIZE)

/* predicates on addresses */

extern int is_ml_stack (void *p);
extern int is_ml_heap (void *p);

/* This callback is called when the memory manager fails due to a lack
 * of underlying OS memory. It returns zero for abort or non-zero for
 * retry. 'attempt' is unique to a single request and all its retries.
 * 'extent' is the currently allocated arena, 'length' is the size of
 * the attempted request. */

extern int (*out_of_memory_dialog)(unsigned long int attempt,
				   size_t extent, size_t length);

/* A function for address validation during eg backtraces */

extern int validate_address(void *addr);

/* A function for ml address validation during eg profiling */

extern int validate_ml_address(void *addr);

/* Initialise the storage manager; this interface will change when the
   new GC adds options to the runtime. */

extern void sm_init(void);

/* For now, the only storage manager option is -limit n, where n
 * is a number of megabytes. The default is 100 megabytes. */

#define DEFAULT_ARENA_LIMIT	(100<<20)

extern size_t arena_limit;

/* Stack backtrace (easy version) */

extern void ml_backtrace(int depth_max);

#endif
