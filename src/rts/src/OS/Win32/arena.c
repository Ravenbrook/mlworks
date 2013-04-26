/*  ==== ARENA MANAGEMENT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: arena.c,v $
 *  Revision 1.11  1998/08/07 12:58:46  jont
 *  [Bug #70111]
 *  Don't lose memory we can't use.
 *
 * Revision 1.10  1998/07/15  15:21:30  jont
 * [Bug #20134]
 * Provide address validation outside of ml heap
 *
 * Revision 1.9  1998/07/14  12:27:15  jont
 * [Bug #70113]
 * Modify to reserve only when required, and not to demand contiguity
 *
 * Revision 1.8  1998/05/22  10:55:07  jont
 * [Bug #70030]
 * Modify block_free to free entire space where appropriate
 *
 * Revision 1.7  1998/01/23  15:59:16  jont
 * [Bug #30340]
 * Loop to repeat the mmap after out of memory dialog says do so
 *
 * Revision 1.6  1996/10/31  12:02:57  nickb
 * Oops. The most recent change broke the Win32 arena.
 *
 * Revision 1.5  1996/10/29  17:28:27  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.4  1996/07/31  11:32:50  stephenb
 * Replaced the #include of syscalls.h with <windows.h> since
 * syscalls.h no longer contains copies of the declarations
 * in <windows.h>
 *
 * Revision 1.3  1996/05/31  15:32:20  nickb
 * Add test_mapping().
 *
 * Revision 1.2  1996/05/14  16:31:57  nickb
 * Improve out-of-memory behaviour.
 *
 * Revision 1.1  1996/03/06  11:23:04  stephenb
 * new unit
 * This replaces src/rts/src/OS/{NT,Win95}/arena.c
 *
 * Revision 1.7  1995/10/09  14:54:17  jont
 * Improve space number algorithm to allow transfer of images between
 * NT and Win95.
 *
 * Revision 1.6  1995/08/02  14:23:05  jont
 * Remove windows.h from include list
 *
 * Revision 1.5  1995/04/05  14:12:43  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.4  1995/03/01  13:45:52  nickb
 * Add interface for holes and make space_gen array general.
 *
 * Revision 1.3  1995/02/03  17:41:30  jont
 * Further fix to error handling from VirtualAlloc
 *
 * Revision 1.2  1995/02/03  17:29:44  jont
 * Handle errors from VirtualAlloc gracefully
 *
 * Revision 1.1  1994/12/12  14:21:20  jont
 * new file
 *
 * Revision 1.2  1994/10/13  13:06:02  nickb
 * Allow multiple block spaces, so blocks can occupy more of arena.
 *
 * Revision 1.1  1994/10/04  16:25:59  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:25:14  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:50:00  nickh
 * new file
 */

#include <windows.h>		/* SYSTEM_INFO, MEM_RESERVE, ... etc. */
#include "ansi.h"
#include "arena.h"
#include "mem.h"
#include "types.h"
#include "diagnostic.h"
#include "utils.h"

#include <stddef.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <stdio.h>

#include <sys/types.h>
#include <fcntl.h>
#include <signal.h>

/* type and extent tables */

byte space_type[NR_SPACES];
size_t space_extent[NR_SPACES];
void *space_info[NR_SPACES];
void *free_map[NR_SPACES];

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

/* free_map gives us a mapping from space number to
   the actual address returned by VirtualAlloc when
   we allocated this space. We need this because
   VirtualFree has a crap interface demanding that
   we can only release memory in the same size chunks
   as allocated by VirtualAlloc. Since VirtualAlloc can
   give us stuff which is unaligned with our arena spaces
   we sometimes have to accept pieces which are too big
   and ignore the bits on the ends. But we need the
   original addresses when we release. */

byte first_block_space_map[BLOCKS_PER_SPACE];
byte *block_maps = NULL;

size_t arena_extent = 0;
#ifdef COLLECT_STATS
size_t max_arena_extent = 0;
#endif

static int zero_device;
static int page_size;

#define BACKOFF_LIMIT	5

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
  INITIALIZED
};

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

  if(length > 0) {
    while (VirtualAlloc((LPVOID)start, (DWORD)length,
			MEM_COMMIT,
			PAGE_EXECUTE_READWRITE) == NULL) {
      unsigned int error = GetLastError();
      if ((out_of_memory_dialog == NULL) ||
	  ((*out_of_memory_dialog)(map_attempt, arena_extent, length) == 0))
	error_without_alloc("Out of virtual memory.\n");
    }
  }
  arena_extent += length;
#ifdef COLLECT_STATS
  if (arena_extent > max_arena_extent)
    max_arena_extent = arena_extent;
#endif
}

static void unmap(void *start, size_t length)
{
  if(length > 0 &&
     !VirtualFree(start, (DWORD)length, MEM_DECOMMIT))
    error("VirtualFree has returned an unexpected error code %lu", GetLastError());

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
 * This function is a bit of a pi's ear due to the lousy
 * MS interface VirtualAlloc/Free
 * In particular, when releasing memory, you can only
 * release at an address returned by VirtualAlloc. Hence
 * the technique used by the other arena managers of allocating
 * twice as much and then freeing the bits on the end doesn't work.
 * MPS used to just take the hit of using twice as much VM,
 * but we don't want this. So we try to do an allocation that
 * will leave the next allocation aligned.
 */

static int reserve_arena_space(LPVOID *base)
{
  int space;
  *base = VirtualAlloc(NULL, SPACE_SIZE, MEM_RESERVE, PAGE_NOACCESS);
  if(*base == NULL) {
    /* Failed to reserve */
    return 1;
  }
  space = SPACE(*base);
  if ((SPACE_BASE(space)) != *base) {
    /* Oh dear, we've got an unaligned piece of space */
    /* Unmap it, get the extra we need then junk the bit at the start */
    LPVOID base1;
    unsigned long new_size =
      (unsigned long)(SPACE_BASE(space+1)) - (unsigned long)*base;
    if (!VirtualFree(*base, 0, MEM_RELEASE)) {
      error("VirtualFree has returned an unexpected error code %lu", GetLastError());
    }
    /* We try to be friendly here, by allocating the bit to fill the gap we can't */
    /* use, then allocating the bit we want, and then freeing the bit we first */
    /* allocated. If that fails we do the unfriendly thing and lose some VM */
    base1 = VirtualAlloc(NULL, new_size, MEM_RESERVE, PAGE_NOACCESS);
    if(base1 == NULL) {
      /* Failed to reserve */
      /* If we can't reserve the little bit, we won't succeed with the bigger bit */
      return 1;
    }
    *base = VirtualAlloc(NULL, SPACE_SIZE, MEM_RESERVE, PAGE_NOACCESS);
    if(*base == NULL) {
      /* Failed to reserve */
      /* This was the bit we really wanted */
      return 1;
    }
    /* Now get rid of the bit at the start */
    if (!VirtualFree(base1, 0, MEM_RELEASE)) {
      error("VirtualFree has returned an unexpected error code %lu", GetLastError());
    }
    space = SPACE(*base);
    if (*base == SPACE_BASE(space)) {
      free_map[space] = *base;
      /* This is what we hope will happen, to keep the VM usage clean */
    } else {
      /* Ok, go for the algorithm that loses a bit of VM */
      /* First release the bit that failed */
      if (!VirtualFree(*base, 0, MEM_RELEASE)) {
	error("VirtualFree has returned an unexpected error code %lu", GetLastError());
      }
      new_size += SPACE_SIZE;
      do {
	*base = VirtualAlloc(NULL, new_size, MEM_RESERVE, PAGE_NOACCESS);
	if(*base == NULL) {
	  /* Failed to reserve */
	  return 1;
	}
	/* Now check that we have covered an entire space */
	space = SPACE(*base);
	if (*base == SPACE_BASE(space)) {
	  free_map[space] = *base;
	  break;
	  /* Unexpected case, but we'll settle for it */
	}
	if ((unsigned long)*base <= (unsigned long)SPACE_BASE(space+1) &&
	    (unsigned long)*base + new_size >= (unsigned long)SPACE_BASE(space+2)) {
	  space++;
	  free_map[space] = *base;
	  *base = SPACE_BASE(space);
	  break;
	  /* The case we expected */
	}
	/* Still not enough room */
	/* Increase extra and try again */
	new_size = (SPACE_SIZE) + (unsigned long)(SPACE_BASE(space+1)) - (unsigned long)*base;
	if (!VirtualFree(*base, 0, MEM_RELEASE)) {
	  error("VirtualFree has returned an unexpected error code %lu", GetLastError());
	}
      } while(1);
    }
    /* We don't unmap the space bit at the start */
    /* because the crap interface of VirtualFree won't do it */
    /* See comment above */
  } else {
    free_map[space] = *base;
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
  void *base;
  if (reserve_arena_space(&base)) {
    error("Run out of arena spaces.");
  }
}

static void release_arena_space(int space)
{
  if (!VirtualFree(free_map[space], 0, MEM_RELEASE)) {
    error("VirtualFree has returned an unexpected error code %lu", GetLastError());
  }
  /* Now mark the space reserved */
  space_type[space]   = TYPE_RESERVED;
  space_extent[space] = (size_t)-1;
  SPACE_MAP(space)    = NULL;
}

void arena_init(void)
{
  int first_block_space=0 ,i;
  
  switch (arena_state) {
    
  case UNINITIALIZED: {
    SYSTEM_INFO sysinfo;

    arena_state = INITIALIZING;

    /* First mark all spaces reserved */
    for (i = 0; i < NR_SPACES; i++) {
      space_type[i]   = TYPE_RESERVED;
      space_extent[i] = (size_t)-1;
      SPACE_MAP(i)    = NULL;
    }

    /* Now allocate the spaces we want */
    for (i = 0; i < 2; i++) {
      int space;
      void *base;
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

    GetSystemInfo(&sysinfo);
    page_size = sysinfo.dwPageSize;

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
  unsigned int space_no = SPACE(space);
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
  unsigned i;
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
    space_type[space_nr] = TYPE_FREE;
    space_extent[space_nr] = 0;
    SPACE_MAP(space_nr) = NULL;
  }
}

int system_validate_address(void *addr)
{
  /* A function for validating addresses outside the ml heap */
  MEMORY_BASIC_INFORMATION info;
  (void)VirtualQuery(addr, &info, sizeof(info));
  if ((info.AllocationProtect & PAGE_NOACCESS) || (info.AllocationProtect & PAGE_EXECUTE)) {
    return 0; /* Can't access if execute only or no access */
  }
  return (info.State & MEM_COMMIT); /* Need area to be committed */
}
