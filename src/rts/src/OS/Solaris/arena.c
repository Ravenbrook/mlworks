/*  ==== ARENA MANAGEMENT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *  The system call mmap() is used to map in areas of virtual memory at
 *  fairly arbitrary addresses throughout the arena.  The functions map()
 *  and unmap() deal with this.  In particular, map() always succeeds or
 *  causes an error.
 *
 *  Based on SunOS version 1.9.
 *
 *  $Log: arena.c,v $
 *  Revision 1.13  1998/07/15 13:45:52  jont
 *  [Bug #20124]
 *  Add implementation of system_valid_address
 *
 * Revision 1.12  1998/05/20  16:42:48  jont
 * [Bug #70030]
 * Allow block_free to remove entire space if all free
 *
 * Revision 1.11  1998/05/15  13:10:54  jont
 * [Bug #70029]
 * Allow space_resize to fail if memory cannot be allocated
 * This can only happen on extension, not retraction
 *
 * Revision 1.10  1996/10/29  17:27:01  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.9  1996/05/31  10:42:31  nickb
 * Correct mmap failure switch and add some testing code.
 *
 * Revision 1.8  1996/05/31  09:20:02  nickb
 * Remove PLOCK.
 *
 * Revision 1.7  1996/05/14  16:32:48  nickb
 * Improve out-of-memory behaviour.
 *
 * Revision 1.6  1995/04/05  14:02:00  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.5  1995/03/28  15:04:16  io
 * add nonzero exit status for EOF case when no vm avail
 *
 * Revision 1.4  1995/03/01  13:46:26  nickb
 * Add interface for holes and make space_gen array general.
 *
 * Revision 1.3  1995/02/23  13:27:38  nickb
 * Remove BSDisms.
 *
 * Revision 1.2  1994/10/13  13:01:08  nickb
 * Allow multiple block spaces, so blocks can occupy more of arena.
 *
 * Revision 1.1  1994/07/08  10:42:42  nickh
 * new file
 *
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

#include <limits.h>

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

static int zero_device;
static int reserve_device;
static int page_size;
static long sys_page_size;

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

  DIAGNOSTIC(2, "mmap trying to place 0x%x bytes at 0x%x", length, start);
  while(length > 0 &&
	mmap((caddr_t)start, length,
	     PROT_READ | PROT_WRITE | PROT_EXEC,
	     MAP_FIXED | MAP_PRIVATE,
	     zero_device, 0) == MAP_FAILED)
    switch(errno) {

/* Solaris mmap errno codes which could be meaningful for us:

     EAGAIN There was insufficient room to reserve swap space for
            the mapping.
     ENOMEM MAP_FIXED was specified and the range [addr,  addr  +
            len)  exceeds that allowed for the address space of a
            process, [...]
*/
    case EAGAIN:
    case ENOMEM:
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
  /* We simply rereserve this via mmap on reserve_device,
   * rather than unmapping */
  int space = SPACE(start);
  off_t offset = (unsigned long)start - (unsigned long)(SPACE_BASE(space));
  if (length > 0 &&
      mmap((caddr_t)start, length, PROT_NONE, MAP_FIXED | MAP_SHARED,
	   reserve_device, offset) == MAP_FAILED) {
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

/*
 * Attempt to reserve a space within the arena
 * Return 0 for success, 1 for failure
 * The arena maps will be updated, so functions searching
 * for a SPACE of type TYPE_FREE can redo their searches
 */

static int reserve_arena_space(caddr_t *base)
{
  int space;
  *base = mmap((caddr_t)0, SPACE_SIZE, PROT_NONE, MAP_SHARED,
	       reserve_device, (off_t)0);
  if (*base == MAP_FAILED) {
    /* Failed to reserve */
    return 1;
  }
  space = SPACE(((word)(*base)) + (SPACE_SIZE) -1);
  if ((caddr_t)(SPACE_BASE(space)) != *base) {
    /* Oh dear, we've got an unaligned piece of space */
    /* Unmap it, get double then junk the bits on the ends */
    if (munmap(*base, SPACE_SIZE) == -1) {
      error("munmap(1)(0x%x, 0x%x) has returned an unexpected error code %d meaning %s", *base, SPACE_SIZE, errno, strerror(errno));
    }
    *base = mmap((caddr_t)0, 2*(SPACE_SIZE), PROT_NONE, MAP_SHARED,
		 reserve_device, (off_t)0);
    if (*base == MAP_FAILED) {
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
  /*
  printf("arena_init reserved 0x%x bytes at 0x%x\n", SPACE_SIZE, *base);
  */
  space_type[space]   = TYPE_FREE;
  space_extent[space] = 0;
  SPACE_MAP(space) = NULL;
  /*
  printf("reserve_arena_space at 0x%x\n", (unsigned)*base);
  */
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

void arena_init(void)
{
  int first_block_space = 0, i;

  switch (arena_state) {
    
  case UNINITIALIZED: {
    arena_state = INITIALIZING;
    sys_page_size = sysconf(_SC_PAGESIZE);
    /* implicit promotion to long for following arithmetic calculation */
    if(INT_MAX < sys_page_size) {
      error_without_alloc("Ridiculously large page size.");
    }
    /* narrowing from long to int is now okay */
    page_size = sys_page_size;
    
    zero_device = open("/dev/zero", O_RDONLY);
    if(zero_device == -1)
      error_without_alloc("Arena initializing unable to open /dev/zero.");
    reserve_device = open("/etc/passwd", O_RDONLY);
    if(reserve_device == -1)
      error_without_alloc("Arena initializing unable to open /etc/passwd.");
    
    /* First mark all spaces reserved */
    for (i = 0; i < NR_SPACES; i++) {
      space_type[i]   = TYPE_RESERVED;
      space_extent[i] = (size_t)-1;
      SPACE_MAP(i)    = NULL;
    }

    /* Now allocate the spaces we want */
    for (i = 0; i < 2; i++) {
      int space;
      caddr_t base;
      if (reserve_arena_space(&base)) {
	error_without_alloc("Arena initializing unable to reserve memory\n");
      }
      space = SPACE(((word)base) + (SPACE_SIZE) -1);
      /*
      printf("arena_init reserved 0x%x bytes at 0x%x\n", SPACE_SIZE, base);
      */
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
  /*
  printf("space_free: at 0x%x\n", (unsigned)space);
  */
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

  /*
  printf("space_alloc: 0x%x\n", extent);
  */
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
  return 1; /* Dummy until we find a real implementation */
  /* madvise may do the trick here */
}
