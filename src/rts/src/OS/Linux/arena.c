/*  ==== ARENA MANAGEMENT ====
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
 *  The system call mmap() is used to map in areas of virtual memory at
 *  fairly arbitrary addresses throughout the arena.  The functions map()
 *  and unmap() deal with this.  In particular, map() always succeeds or
 *  causes an error.
 *
 *  Revision Log
 *  ------------
 *  $Log: arena.c,v $
 *  Revision 1.15  1998/09/30 11:40:10  jont
 *  [Bug #70108]
 *  Fix problems with caddr_t under Red Hat 5
 *
 * Revision 1.14  1998/08/04  15:16:05  jont
 * [Bug #20134]
 * Implement system_validate_address
 *
 * Revision 1.13  1998/07/15  13:28:44  jont
 * [Bug #20124]
 * Add implementation of system_valid_address
 *
 * Revision 1.12  1998/05/21  14:39:39  jont
 * [Bug #70030]
 * Allow block_free to free entire space if all blocks now freed
 *
 * Revision 1.11  1998/05/15  16:08:38  jont
 * [Bug #70029]
 * Modify to allow OS to place mmapped areas
 *
 * Revision 1.10  1996/10/29  17:27:54  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.9  1996/05/31  15:25:17  nickb
 * Add test code and fix arena exhaustion.
 *
 * Revision 1.8  1996/05/31  09:19:28  nickb
 * Remove PLOCK.
 *
 * Revision 1.7  1996/05/14  16:33:25  nickb
 * Improve out-of-memory behaviour.
 *
 * Revision 1.6  1995/08/22  14:33:02  nickb
 * Add inclusion of <unistd.h>
 *
 * Revision 1.5  1995/04/05  14:03:03  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.4  1995/03/28  14:57:45  io
 * add nonzero exit status for EOF case when no vm avail
 *
 * Revision 1.3  1995/03/01  13:45:11  nickb
 * Add interface for holes and make space_gen array general.
 *
 * Revision 1.2  1994/10/13  13:06:02  nickb
 * \\nAllow multiple block spaces, so blocks can occupy more of arena.
 *
 * Revision 1.1  1994/10/04  16:25:59  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:25:14  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:50:00  nickh
 * new file
 *
 *  Revision 1.9  1994/01/28  17:47:14  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.8  1993/12/14  17:41:08  nickh
 *  Added comment, a couple of minor fixes resulting from a code read-through.
 *
 *  Revision 1.7  1993/06/02  13:11:46  richard
 *  Added parentheses suggested by GCC 2.
 *
 *  Revision 1.6  1992/12/14  12:25:29  daveb
 *  Instead of suspending when we run out of virtual memory, we now prompt
 *  the user to continue or quit.
 *
 *  Revision 1.5  1992/10/19  11:43:36  richard
 *  Changed the grain rounding mechanism to lessen the overhead of small
 *  spaces.
 *
 *  Revision 1.4  1992/10/02  08:32:30  richard
 *  Added missing include of utils.h.
 *
 *  Revision 1.3  1992/08/27  16:20:08  richard
 *  Changed output of suspension message again.
 *
 *  Revision 1.2  1992/08/25  15:12:18  richard
 *  Improved the messages.
 *
 *  Revision 1.1  1992/08/04  11:35:46  richard
 *  Initial revision
 *
 */

#include "ansi.h"
#include "arena.h"
#include "mem.h"
#include "types.h"
#include "diagnostic.h"
#include "utils.h"
#include "syscalls.h"

#include <stddef.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

#include <sys/mman.h>
#include <sys/types.h>
#include <fcntl.h>

/* Red Hat seems confused about what caddr_t should be */
/* and what should be able to see it */
#define caddr_t __caddr_t

/* type and extent tables */

byte space_type[NR_SPACES];
size_t space_extent[NR_SPACES];
void *space_info[NR_SPACES];

/* The first block space has a statically-allocated map. Later block
   spaces have their maps in a reserved region within the first block
   space. The pointer 'block_maps' indicates the next available
   location for a map in this region */

/* Now modified */
/* first_block_space_map is still the pointer
   to the map for the initial block space.
   Later block spaces have their maps allocated
   within the space allocated as block_maps, according
   to their space number,
   ie for block j in space i, its type is block_maps[i][j]
   But we still use the space_info array as Iliffe vectors
   for speed rather than calculating each time.
   This also ensures that we don't use the wrong block_map
   for the initial block space */


byte first_block_space_map[BLOCKS_PER_SPACE];
byte *block_maps = NULL;

size_t arena_extent = 0;
#ifdef COLLECT_STATS
size_t max_arena_extent = 0;
#endif

static int page_size;

/* arena_state is UNINITIALIZED until the arena has been initialized.
 * See arena_init() and block_alloc() below.
 *
 * GCC 2.x calls __main() before main(). __main() can call malloc().
 * Our malloc(), on first call, calls block_alloc() to get some heap.
 * If the arena has been initialized, we simply allocate a block.
 * Otherwise we initialize the arena then. */

enum {
  UNINITIALIZED = 0,
  INITIALIZING,
  INITIALIZED};

static int arena_state = UNINITIALIZED;

/* grains. The purpose of grain_round is to round its argument (a
number of bytes) up to a convenient size, where "convenient" means "a
multiple of 2^n (where n<=20), which does not waste more than
GRAIN_OVERHEAD bytes per 0x100". */

#define MAX_GRAIN_SIZE		0x100000	/* 1Mb */
#define GRAIN_OVERHEAD		0x10		/* per 0x100 */
#define GRAINROUND(grain, size)	(((size)+(grain)-1) & ~((grain)-1))

static size_t grain_round(size_t size)
{
  int grain;
  /* we round at least to the nearest page */
  size_t rounded = GRAINROUND(page_size, size);
  /* maximum is the maximum acceptable size (any more wastes too much) */
  size_t maximum = (size * (0x100+GRAIN_OVERHEAD))/ 0x100;

  if(rounded > 0)
    for(grain = MAX_GRAIN_SIZE; grain >= page_size; grain >>= 1)
    {
      rounded = GRAINROUND(grain, size);

      if (rounded < maximum)
	break;
    }

  return(rounded);
}

static unsigned long map_attempt = 0;

static void map(void *start, size_t length)
{
  map_attempt ++;

  if (arena_state != INITIALIZED)
    error_without_alloc("Trying to map memory before arena initialized.\n");

  while(length > 0 &&
	mmap((caddr_t)start, length,
	     PROT_READ | PROT_WRITE | PROT_EXEC,
	     MAP_FIXED | MAP_PRIVATE | MAP_ANON,
	     -1, 0) == (caddr_t)-1)
    switch(errno) {
      /* The Linux kernel sources tell me that this can fail with either
       * ENOMEM or EAGAIN */
    case ENOMEM:
    case EAGAIN:

      if ((out_of_memory_dialog == NULL) ||
	  ((*out_of_memory_dialog)(map_attempt, arena_extent, length) == 0))
	error_without_alloc("Out of virtual memory.\n");
      break;

    default:
      error("mmap(0x%08x, 0x%08x) has returned an unexpected error code %d",
	    start, length, errno);
    }

  arena_extent += length;
#ifdef COLLECT_STATS
  if (arena_extent > max_arena_extent)
    max_arena_extent = arena_extent;
#endif
}

static void unmap(void *start, size_t length)
{
  /* We simply rereserve this via mmap but with no backing store, rather than unmapping */
  int space = SPACE(start);
  off_t offset = (unsigned long)start - (unsigned long)(SPACE_BASE(space));
  if (length > 0 &&
      mmap((caddr_t)start, length, PROT_NONE, MAP_FIXED | MAP_PRIVATE | MAP_ANON,
	   -1, offset) == (caddr_t)-1) {
    error("unmap has failed with an unexpected error code %d meaning %s\n",
	  errno, strerror(errno));
  };
  arena_extent -= length;
}

#ifdef DEBUG

void test_mapping(void)
{
  int i,j;
  byte *block_map;
  for (i=0 ; i<NR_SPACES; ++i) {
    switch (space_type[i]) {
    case TYPE_RESERVED:
      /* these are reserved */
      message("space at 0x%08x reserved",SPACE_BASE(i));
      break;
    case TYPE_BLOCKS:
      /* test each block */
      block_map = SPACE_MAP(i);
      message("testing block space at 0x%08x",SPACE_BASE(i));
      for (j=0; j < BLOCKS_PER_SPACE; j++) {
	switch (block_map[j]) {
	case TYPE_FREE:
	  message("  testing block at 0x%08x",BLOCK_BASE(i,j));
	  map (BLOCK_BASE(i,j), BLOCK_SIZE);
	  unmap (BLOCK_BASE(i,j), BLOCK_SIZE);
	  break;
	default:
	  message("  block at 0x%08x has type %d",
		  BLOCK_BASE(i,j),block_map[j]);
	}
      }
      break;
    case TYPE_FREE:
      /* test the whole space */
      message("testing space at 0x%08x",SPACE_BASE(i));
      map(SPACE_BASE(i), SPACE_SIZE);
      unmap(SPACE_BASE(i), SPACE_SIZE);
      break;
    default:
      message("space at 0x%08x used with type %d",
	      SPACE_BASE(i), space_type[i]);
    }
  }
}

#endif

/* It seems that mmap()s past 0x60000000 will break Linux. */
/* FIXME: no longer needed */
#define ARENA_LIMIT 0x60000000

/*
 * Attempt to reserve a space within the arena
 * Return 0 for success, 1 for failure
 * The arena maps will be updated, so functions searching
 * for a SPACE of type TYPE_FREE can redo their searches
 */

static int reserve_arena_space(caddr_t *base)
{
  int space;
  void* addr = *base;
  *base = mmap(addr, SPACE_SIZE, PROT_NONE, MAP_PRIVATE | MAP_ANON,
	       -1, (off_t)0);
  if (*base == (caddr_t)-1) {
    /* Failed to reserve */
    return 1;
  }

  /* FIXME: no longer needed
  if ((unsigned long)(*base) > ARENA_LIMIT) {
    DIAGNOSTIC(1, "  mmaped address %p is above ARENA_LIMIT %p; retrying",
	       *base, ARENA_LIMIT);
    *base = addr;
    return reserve_arena_space (base);
  }
  */

  space = SPACE(((word)(*base)) + (SPACE_SIZE) -1);
  if ((caddr_t)(SPACE_BASE(space)) != *base) {
    /* Oh dear, we've got an unaligned piece of space */
    /* Unmap it, get double then junk the bits on the ends */
    if (munmap(*base, SPACE_SIZE) == -1) {
      error("munmap(1)(0x%x, 0x%x) has returned an unexpected error code %d meaning %s", *base, SPACE_SIZE, errno, strerror(errno));
    }
    *base = mmap((caddr_t)0, 2*(SPACE_SIZE), PROT_NONE, MAP_PRIVATE | MAP_ANON,
		 -1, (off_t)0);
    if (*base == (caddr_t)-1) {
      /* Failed to reserve */
      return 1;
    }
    /* Now unmap the bits over at the start and end */
    space = SPACE(((word)(*base)) + (SPACE_SIZE) -1);
    if ((caddr_t)(SPACE_BASE(space)) != *base) {
      /* unmap the leftover at the start */
      if (munmap(*base, (unsigned long)(SPACE_BASE(space))-(unsigned long)(*base)) == -1) {
	error("munmap(2)(0x%x, 0x%x) has returned an unexpected error code %d meaning %s", *base, (unsigned long)(SPACE_BASE(space))-(unsigned long)(*base), errno, strerror(errno));
      }
    }
    if (((unsigned long)(SPACE_BASE(space+1))) !=
	((unsigned long)(*base)) + 2 *(SPACE_SIZE)) {
      /* unmap the leftover at the end */
      if (munmap((caddr_t)(SPACE_BASE(space+1)),
		 (unsigned long)(*base)-((unsigned long)(SPACE_BASE(space-1)))) == -1) {
	error("munmap(3)(0x%x, 0x%x) has returned an unexpected error code %d meaning %s", SPACE_BASE(space+1), (unsigned long)(*base)-((unsigned long)(SPACE_BASE(space-1))), errno, strerror(errno));
      }
    }
  }
  space_type[space]   = TYPE_FREE;
  space_extent[space] = 0;
  SPACE_MAP(space) = NULL;
  return 0;
}

/*
 * Non-returning version of reserve_arena_space
 * for use by space_alloc
 */
static void acquire_arena_space(void)
{
  caddr_t base;
  if (reserve_arena_space(&base)) {
    error("Run out of arena spaces.");
  }
}

static void release_arena_space(int space)
{
  if (munmap((caddr_t)(SPACE_BASE(space)), SPACE_SIZE) == -1) {
    error("munmap(4)(0x%x, 0x%x) has returned an unexpected error code %d meaning %s", SPACE_BASE(space), errno, strerror(errno));
  }
  /* Now mark the space reserved */
  space_type[space]   = TYPE_RESERVED;
  space_extent[space] = (size_t)-1;
  SPACE_MAP(space)    = NULL;
}

#ifdef DEBUG
void test_validate_address(void)
{
  unsigned int i = 0;
  do {
    if (system_validate_address((void *)i)) {
      printf("Address 0x%x ok\n", i);
    } else {
      printf("Address 0x%x bad\n", i);
    }
    i += page_size;
  } while (i != 0);
}
#endif

void arena_init(void)
{
  int first_block_space = 0, i;

  switch (arena_state) {

  case UNINITIALIZED: {
    arena_state = INITIALIZING;
    page_size = getpagesize();

    /* First mark all spaces reserved */
    for (i = 0; i < NR_SPACES; i++) {
      space_type[i]   = TYPE_RESERVED;
      space_extent[i] = (size_t)-1;
      SPACE_MAP(i)    = NULL;
    }

    /* Now allocate the spaces we want */
    for (i = 0; i < 2; i++) {
      int space;
      caddr_t base = (caddr_t)((i + 1) * SPACE_SIZE); /* Hack RB 2013-05-18 because mmap was returning addresses above ARENA_LIMIT */
      if (reserve_arena_space(&base)) {
	error_without_alloc("Arena initializing unable to reserve memory\n");
      }
      space = SPACE(((word)base) + (SPACE_SIZE) -1);
      if (first_block_space == 0) {
	/* Allocate first block space to what we've just got */
	int i;
	first_block_space = space;
	for (i=0; i < BLOCKS_PER_SPACE; ++i) {
	  first_block_space_map[i] = TYPE_FREE;
	}
	SPACE_MAP(first_block_space) = first_block_space_map;
	space_type[first_block_space] = TYPE_BLOCKS;
	space_extent[first_block_space] = (size_t)-2;
      }
    }

    arena_extent = 0;
#ifdef COLLECT_STATS
    max_arena_extent = 0;
#endif
    arena_state = INITIALIZED;

    /* The arena is now initialized, so we can call block_alloc */
    block_maps = block_alloc(TYPE_RESERVED,
			     (unsigned long)SPACES_IN_ARENA*BLOCKS_PER_SPACE);
    break;
  }
  case INITIALIZING:
    error_without_alloc("Allocation during arena startup.");
  case INITIALIZED:
    /* Could get to here if we alloc before arena_init gets called. */
    break;
  default:
    error_without_alloc("Arena state inconsistent.");
  }
}

void space_free(byte *space)
{
  int space_no = SPACE(space);
  unmap(space, space_extent[space_no]);
  release_arena_space(space_no);
}

void space_resize(byte *space, size_t extent)
{
  unsigned int space_no = SPACE(space);
  size_t current = space_extent[space_no];

  extent = grain_round(extent);

  if(extent > current)
    map(space+current, extent-current);
  else if(current > extent)
    unmap(space+extent, current-extent);

  space_extent[space_no] = extent;
}

byte *space_alloc(byte type, size_t extent)
{
  unsigned int i;

  if (extent > SPACE_SIZE) {
    error("Allocating too large a space");
  }

  while(1) {
    for(i=0; i<SPACES_IN_ARENA; ++i)
      if(space_type[i] == TYPE_FREE) {
	space_type[i] = type;
	space_extent[i] = 0;
	space_resize(SPACE_BASE(i), extent);
	return SPACE_BASE(i);
      }
    acquire_arena_space();
  }

  error("Run out of arena spaces.");
}

/* Allow general mapping holes inside spaces; note that both of these
 * functions can be no-ops to start with */

void space_allow_hole(byte *hole, size_t extent)
{
}

void space_remove_hole(byte *hole, size_t extent)
{
}

byte *block_alloc(byte type, size_t size)
{
  int s, b, found = 0, blocks = BLOCKS(size);
  byte *block_map;
  byte *space;

  if (arena_state != INITIALIZED)
    arena_init();

  if (blocks > BLOCKS_PER_SPACE)
    error("Trying to allocate too many contiguous blocks.");

  for(s=0; s<SPACES_IN_ARENA; ++s) {
    if (space_type[s] == TYPE_BLOCKS) {
      block_map = SPACE_MAP(s);
      for (b=0; b<BLOCKS_PER_SPACE; b++) {
	if (block_map[b] == TYPE_FREE) {
	  found ++;
	  if(found >= blocks) {
	    int start = b+1-found, k;

	    for(k=start; k<=b; ++k)
	      block_map[k] = type;
	    map(BLOCK_BASE(s,start), GRAINROUND(page_size, size));
	    return(BLOCK_BASE(s,start));
	  }
	}
	else
	  found = 0;
      }
      found = 0;
    }
  }

  /* None of the existing block spaces have room; let's make a new one */

  space = space_alloc(TYPE_BLOCKS,0);    /* allocate the new space */
  s = SPACE(space);
  block_map = SPACE_MAP(s) = block_maps + s*BLOCKS_PER_SPACE;
  /* This is where the map is */

  for(b=0; b< blocks; ++b)
    block_map[b] = type;
  for (b=blocks; b < BLOCKS_PER_SPACE; b++)
    block_map[b] = TYPE_FREE;		 /* ... and initialize it */

  map(space, GRAINROUND(page_size, size));
  return(space);
}

void block_free(byte *block, size_t size)
{
  unsigned int space_nr = SPACE(block);
  unsigned int block_nr = BLOCK_NR(block);
  size_t blocks = BLOCKS(size);
  byte *block_map = SPACE_MAP(space_nr);
  int i;
  int ok = 1;

  for(i=0; i<blocks; ++i)
    block_map[block_nr+i] = TYPE_FREE;

  /* See if we can free the entire space */
  for (i=0; i<BLOCKS_PER_SPACE; i++) {
    if (block_map[i] != TYPE_FREE) {
      ok = 0;
      break;
    }
  }
  unmap(block, GRAINROUND(page_size, size));
  if (ok) {
    /* Free the entire space */
    release_arena_space(space_nr);
  }
}

int system_validate_address(void *addr)
{
  unsigned long page_mask = -1 ^ (page_size-1);
  unsigned long start_addr = ((unsigned long)addr) & page_mask;
  int pid = getpid();
  char buffer[256];
  FILE *file;
  sprintf(buffer, "/proc/%d/maps", pid);
  file = fopen(buffer, "r");
  if (file == NULL) {
    error("system_validate_address fails with errno %d(%s) to open '%s'\n", errno, strerror(errno), buffer);
  }
  do {
    unsigned long start, end;
    char *ptr;
    if (fread(buffer, 1, 17, file) != 17) {
      fclose(file);
      return 0;
    }
    buffer[17] = '\0';
    start = strtoul(buffer, &ptr, 16);
    if (ptr - buffer != 8) {
      error("system_validate_address: address start wrong size in '%s'", buffer);
    }
    end = strtoul(buffer+9, &ptr, 16);
    if (ptr - buffer != 17) {
      error("system_validate_address: address end wrong size in '%s'", buffer);
    }
    if (start <= start_addr && start_addr < end) {
      fclose(file);
      return 1;
    }
    while (!feof(file) && fgetc(file) !='\n') {
      /* Skip to end of line */
    }
  } while(1);
  fclose(file);
  return 0;
}
