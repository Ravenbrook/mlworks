/*  ==== ROBUST MEMORY ALLOCATION ====
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
 *  Implementation
 *  --------------
 *  Simple address-ordered first fit, with a few limitations:
 * 
 *  - Freed memory is never returned to the arena;
 *  - Chunks of memory obtained from the arena are never merged;
 * - if swap runs out, the arena manager will do its "out of swap"
 *    routines, including a fatal runtime error; malloc() will not
 *    return NULL;
 *  - Attempting to allocate a single object larger than an arena "space"
 *    (currently 16Mb) causes a fatal error;
 *  - Allocating from a large block takes the tail; this interacts badly with
 *    shrinking reallocs and with the common case of a growing heap;
 *  - realloc() is just malloc/copy/free;
 *  - free() traverses the free list for merging, instead of using boundary
 *    tags.
 *
 *  Revision Log
 *  ------------
 *  $Log: alloc.c,v $
 *  Revision 1.22  1998/04/23 13:15:59  jont
 *  [Bug #70034]
 *  Rationalising names in mem.h
 *
 * Revision 1.21  1997/05/19  10:01:01  nickb
 * [Bug #30131]
 * General tidying up and improved commenting.
 *
 * Revision 1.20  1997/05/19  09:40:19  nickb
 * [Bug #30131]
 * Keep new blocks in strict address order.
 *
 * Revision 1.19  1997/05/16  15:35:44  nickb
 * [Bug #30131]
 * Improve free() and realloc() protection against bogus arguments.
 *
 * Revision 1.18  1997/05/16  15:23:16  nickb
 * [Bug #30131]
 * Reduce minimum object size.
 *
 * Revision 1.17  1997/05/16  15:21:18  nickb
 * [Bug #30131]
 * Remove DIAGNOSTICs which can cause fatal error.
 *
 * Revision 1.16  1997/05/16  15:20:27  nickb
 * [Bug #30131]
 * Remove unreachable code from realloc().
 *
 * Revision 1.15  1997/05/16  15:18:59  nickb
 * [Bug #30131]
 * Remove inline functions to make debugging easier.
 *
 * Revision 1.14  1997/05/16  15:17:55  nickb
 * [Bug #30131]
 * Make realloc() sign its offcuts so that free() doesn't warn on them.
 *
 * Revision 1.13  1997/05/02  16:40:14  jont
 * [Bug #20027]
 * Make extend take account of struct heap in call to make_heap
 *
 * Revision 1.12  1997/03/24  15:22:17  nickb
 * Stupid comment error.
 *
 * Revision 1.11  1997/03/24  15:03:32  nickb
 * Make malloc() and realloc() edge cases match the OS libraries.
 *
 * Revision 1.10  1996/07/31  11:46:03  stephenb
 * Update the malloc/calloc/free/realloc definitions so that their
 * signatures match the ANSI spec.
 *
 * Revision 1.9  1996/05/30  15:59:09  nickb
 * Add signature checking.
 *
 * Revision 1.8  1996/01/22  13:15:17  nickb
 * Add critical-region flag.
 * In due course malloc() will become re-entrant.
 * For now we have to fail gracefully.
 *
 * Revision 1.7  1995/08/30  13:15:42  jont
 * Add _msize replacement for bogus microsoft version
 * This is only a temporary measure
 *
 * Revision 1.6  1995/08/15  12:11:27  nickb
 * Foolish mistake.
 *
 * Revision 1.4  1994/10/14  15:45:55  nickb
 * Change diagnostic level of message given when freeing NULL (it was 0).
 *
 * Revision 1.3  1994/10/03  15:30:09  jont
 * Fix free to handle NULL pointers
 *
 * Revision 1.2  1994/06/09  14:31:38  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:56:23  nickh
 * new file
 *
 *  Revision 2.3  1994/01/28  17:21:56  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 2.2  1993/04/26  11:47:55  richard
 *  Increased diagnostic level of messages from realloc().
 *
 *  Revision 2.1  1993/01/26  10:29:30  richard
 *  A new version using a simple linked list scheme.  The old version has
 *  bugs in it somewhere, and in any case was very slow.  We are now less
 *  likely to have random memory scrawling bugs -- ML has been running
 *  reliably for some time.
 *
 *  Revision 1.13  1992/10/02  08:38:16  richard
 *  Changed types to become non-standard but compatable with GCC across
 *  platforms.
 *
 *  Revision 1.12  1992/07/20  13:14:22  richard
 *  Removed init_alloc(), and caused allocation to automatically request
 *  an initial area when first called.  This simplifies the interface to
 *  the memory manager.
 *
 *  Revision 1.11  1992/06/30  13:36:04  richard
 *  New areas of C heap are now allocated using a special function to
 *  avoid revealing anything about the memory configuration.
 *
 *  Revision 1.10  1992/04/10  11:17:44  clive
 *  I realloc a call to malloc meant that the side of the object being
 *  reallocated was calculated incorrectly
 *
 *  Revision 1.9  1992/03/27  14:58:54  richard
 *  Corrected several bugs and tidied up.
 *
 *  Revision 1.8  1992/03/12  17:10:31  richard
 *  Changed realloc() to deal with a NULL pointer properly.
 *
 *  Revision 1.7  1992/03/10  13:53:02  richard
 *  Chaned call to allocate_blocks() as memory arrangement has changed.
 *
 *  Revision 1.6  1992/02/13  16:14:17  clive
 *  Forgot to take out my debugging messages
 *
 *  Revision 1.4  1992/02/13  11:42:13  clive
 *  Typo in find_space : (i-1) instead of -1
 *
 *  Revision 1.3  1992/02/13  10:52:08  clive
 *  There was a typo += instead of -= in alloc
 *
 *  Revision 1.2  1992/01/20  13:20:16  richard
 *  Shifted diagnostic level of debugging messages up to 4.
 *
 *  Revision 1.1  1992/01/17  12:17:07  richard
 *  Initial revision
 */

/* Relevant documentation for memory management functions:

   ANSI/ISO C standard 7.10.3:

   "If the space cannot be allocated, a null pointer is returned."

   "If the size of the space requested is zero, the behavior is
   implementation-defined; the value returned shall be either a null
   pointer or a unique pointer."

   "[free] If ptr is a null pointer, no action occurs."

   "[realloc] If ptr is a null pointer, the realloc function behaves
   like the malloc function for the specified size. [...] If size is
   zero and ptr is not a null pointer, the object it points to is
   freed."
   
   Irix man page: "after free is performed this space is made
   available for further allocation, but its contents are left
   undisturbed."

   Irix man page: " When called with size of zero, malloc returns a
   valid pointer to a block of zero bytes.  Storage into a block of
   length zero will corrupt malloc's arena, and may have serious
   consequences."

   SunOS 4 man page: "For backwards compatibility, realloc() accepts a
   pointer to a block freed since the most recent call to malloc(),
   calloc(), realloc(), valloc(), or memalign()."
   [ we don't currently support this case ]

   Irix 5.3 libelf.a has code which frees the same object twice
   consecutively, so we have to handle that case also.

   Every operating system has different behaviour on the edge cases
   malloc(0), realloc(NULL,0), realloc(p,0). Sadly, some libraries,
   such as X, rely on this. We support it by calling os_allocator().
   See os.h and the implementations in OS/$OS/os.c. See 
  <URI:spring://MM_InfoSys/analysis/realloc> for more information.

 */

#include "alloc.h"
#include "utils.h"
#include "mem.h"
#include "diagnostic.h"
#include "extensions.h"
#include "os.h"

#include <stddef.h>
#include <memory.h>

#define ALIGN_BITS              3u            /* number of bits of alignment */
#define ALIGNMENT               (1u << ALIGN_BITS)
#define ALIGN(x)                (((x) + ALIGNMENT-1u) & ~(ALIGNMENT-1u))
#define ALIGNED(p)              ((((word)p) & (ALIGNMENT-1u)) == 0)

#define MINIMUM_CHUNK_SIZE      0x10000         /* see extend() */
#define MINIMUM_BLOCK_SIZE      ALIGN(16)       /* aligned, includes header */
#define BLOCK_TO_P(block)       ((char *)(block+1))
#define P_TO_BLOCK(p)           ((struct header *)((char *)(p)) - 1)

#define AFTER_BLOCK(block)      ((struct header *)((char *)(block) + (block)->size))

/* signature of allocated blocks */

#define MALLOC_SIG              ((struct header *)0xa110c51)


/*  == Block header structure ==
 *
 *  This header is stored at the start of each block, allocated or
 *  unallocated.  It must be of aligned length.
 */

struct header
{
  struct header *next;          /* pointer to next block on free list */
                                /* when allocated, this is MALLOC_SIG */
  size_t size;                  /* size of block including header */
};

static struct header *free_list = NULL;


/*  == Extend C heap ==
 *
 *  Calls the storage manager to fetch a new chunk of memory,
 *  initialises it as one large free block, and inserts that block on the
 *  free list. Chunks of memory are never merged and so allocated objects
 *  never cross the boundary between them.
 */

static void extend(size_t required)
{
  struct c_heap *heap;
  struct header *new;
  struct header *insert, **last;

  required += sizeof(struct c_heap);
  if (required < MINIMUM_CHUNK_SIZE)
    required = MINIMUM_CHUNK_SIZE;

  heap = make_heap(NULL, required);

  new = (struct header *)((char *)heap + ALIGN(sizeof(struct c_heap)));

  new->next = NULL;
  new->size = heap->size - ALIGN(sizeof(struct c_heap));

  /* insert new block into free list */
  insert = free_list;
  last = &free_list;
  while(insert && (insert < new)) {
    last = &insert->next;
    insert = insert->next;
  }
  *last = new;
  new->next = insert;
}

/*  == Calculate block length from request ==  */

static size_t block_size(size_t request)
{
  size_t rounded = ALIGN(request + sizeof(struct header));
  if (rounded < MINIMUM_BLOCK_SIZE)
    rounded = MINIMUM_BLOCK_SIZE;
  return rounded;
}

static int in_malloc_free = 0;

#define ENTER_MALLOC_FREE                                               \
        do {                                                            \
          if (in_malloc_free)                                           \
            error("Re-entering malloc() or free()");                    \
          else                                                          \
            in_malloc_free = 1;                                         \
        } while (0)

#define LEAVE_MALLOC_FREE                                               \
        do {                                                            \
          in_malloc_free = 0;                                           \
        } while(0)

/*  === ALLOCATE MEMORY ===
 *
 *  Searches the free list for the first block large enough to satisfy the
 *  request.  If the block is much larger than requested it is split into
 *  two.  If the end of the list is reached the C heap is extended by
 *  calling the storage manager.  Note that this version never returns NULL.
 */

void *malloc(size_t requested)
{
  size_t required;

  if (requested == 0)
    return os_allocator(OS_ALLOCATOR_MALLOC_ZERO, NULL);

  required = block_size(requested);

  ENTER_MALLOC_FREE;

  for(;;) {
    struct header *block = free_list;
    struct header **last = &free_list;

    while(block) {
      struct header *next = block->next;
      size_t size = block->size;

      if(size >= required) {    /* we have a fit */
        if(size < required + MINIMUM_BLOCK_SIZE) {
          *last = next;         /* return the whole block */
          block->next = MALLOC_SIG;
          LEAVE_MALLOC_FREE;
          return BLOCK_TO_P(block);
        } else {                /* return a tail of the block */
          size_t remaining = size-required;
          struct header *new = (struct header *)((char *)block + remaining);
          new->size = required;
          new->next = MALLOC_SIG;
          block->size = remaining;
          LEAVE_MALLOC_FREE;
          return BLOCK_TO_P(new);
        }
      }

      last = &block->next;
      block = next;
    }

    extend(required);
    /* have to rescan as the new block may be in the middle of the free list */
  }
}



/* Note that this implementation relies on the fact that
 * the malloc used (as defined above) never returns NULL.
 */
void *calloc(size_t number, size_t size)
{
  size_t total = number * size;
  return(memset(malloc(total), 0, total));
}



/* function to check that a pointer has been returned from
 * malloc(). For instance, Motif on Solaris calls free(garbage). */

static struct header *check_malloced(void *p)
{
  struct header *block;
  
  if (TYPE(p) != TYPE_C_HEAP) {
#ifdef DEBUG
    message_stderr("free/realloc(0x%08x), not in the heap",p);
#endif
    return NULL;
  }
  if (!ALIGNED(p)) {
#ifdef DEBUG
    message_stderr("free/realloc(0x%08x), not aligned",p);
#endif
    return NULL;
  }
  block = P_TO_BLOCK(p);
  if (block->next != MALLOC_SIG) {
#ifdef DEBUG
    message_stderr("free/realloc(0x%08x), not returned by malloc()",p);
#endif
    return NULL;
  }
  return block;
}

/* Free an allocated block of memory. Memory is never returned to the arena. */

void free(void *p)
{
  struct header *prev, *next, *block;
  if (p == NULL)
    return;

  block = check_malloced(p);
  if (block == NULL) /* not malloced */
    return;

  ENTER_MALLOC_FREE;
  
  if (free_list && (free_list <= block)) {
    /* find blocks immediately before and after */
    next = free_list;
    do {
      prev = next;
      next = prev->next;
    } while((next != NULL) && (next <= block));
    
    if (block < AFTER_BLOCK(prev)) {
      /* freeing already-free data */
      LEAVE_MALLOC_FREE;
      return;
    }
    /* insert into the list */
    block->next = next;
    prev->next = block;
    
    if (AFTER_BLOCK(block) == next) { /* merge with next */
      block->size += next->size;
      block->next = next->next;
    }
    if (AFTER_BLOCK(prev) == block) { /* merge with previous */
      prev->size += block->size;
      prev->next = block->next;
    }
  } else {
    /* before the first item */
    if (free_list && (AFTER_BLOCK(block) == free_list)) {
      /* merge with the first item */
      block->size += free_list->size;
      free_list = free_list->next;
    }
    /* add to the head of the list */
    block->next = free_list;
    free_list = block;
  }
  LEAVE_MALLOC_FREE;
}


/*  === REALLOCATE MEMORY ===
 *
 *  If the requested size is much smaller than the current size the block is
 *  split, otherwise a simple policy of allocating and moving the contents
 *  is followed.  This could be cleverer and steal memory from the following
 *  block instead, but such cases are relatively rare and it's probably not
 *  worth it.
 */

void *realloc(void *p, size_t requested)
{
  struct header *block;
  size_t required = block_size(requested);
  size_t size;

  if (requested == 0) {
    if (p == NULL)
      return os_allocator(OS_ALLOCATOR_REALLOC_NULL_ZERO, NULL);
    else
      return os_allocator(OS_ALLOCATOR_REALLOC_P_ZERO, p);
  }
  
  if (p == NULL)
    return(malloc(requested));

  block = check_malloced(p);
  if (block == NULL) /* this block never allocated */
    return NULL;

  size = block->size;

  if(size >= required) {
    /* don't copy */
    if(size >= required + MINIMUM_BLOCK_SIZE) {
      /* truncate */
      struct header *new = (struct header *)((char *)block + required);
      new->size = size-required;
      new->next = MALLOC_SIG;
      block->size = required;
      free(BLOCK_TO_P(new));
    }
    return(p);
  } else {
    char *new = malloc(requested);
    
    memcpy(new,p, size - sizeof(struct header));
    free(p);
    
    return(new);
  }
}  

#ifdef OS_NT
/* This function only to replace the bogus Microsoft version */
/* which assumes internals details of malloc/free */

size_t _msize(void *p)
{
  struct header *block = P_TO_BLOCK(p);
  return(block->size);
}
#endif
