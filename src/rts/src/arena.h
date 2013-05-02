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
 *  Description
 *  -----------
 *  This library manages the address space of the runtime system process,
 *  otherwise known as the `arena'.
 *
 *  The arena is the area of address space between address 0 and 1 <<
 *  ARENA_WIDTH. It is divided into a number of large `spaces' of size
 *  1 << SPACE_WIDTH.
 * 
 *  Some spaces are further subdivided into blocks of size 1 <<
 *  BLOCK_WIDTH. Contiguous sets of blocks are allocated and freed in
 *  a manner similar to malloc(). Virtual memory is only mapped for
 *  those blocks which are currently allocated.
 *
 *  Virtual memory is mapped for a non-block space from its base to
 *  its "extent". "Holes" may be allowed in the VM mapping of such a
 *  space.
 *
 *  Each block or space is allocated a `type'.  The client of this code is
 *  free to use types from 1 to 127.  Other types are reserved.  TYPE(addr)
 *  returns the type of the block or space which contains the address addr.
 *  SPACE_TYPE(addr) is a faster version which returns the type of a space
 *  or TYPE_BLOCKS for block spaces.
 *
 *  Revision Log
 *  ------------
 *  $Log: arena.h,v $
 *  Revision 1.2  1998/07/15 12:49:44  jont
 *  [Bug #20134]
 *  Add interface for address validation outside of ml heap
 *
 * Revision 1.1  1998/01/16  17:42:04  jont
 * new unit
 * Common version of this once OS specific stuff
 *
 * Revision 1.7  1996/10/29  17:15:38  nickb
 * Fix space lookup for pointers with top bit set.
 *
 * Revision 1.6  1996/05/31  14:28:36  nickb
 * Add test_mapping();
 *
 * Revision 1.5  1995/08/22  13:31:53  nickb
 * Add some type information to aid compilation under Linux.
 *
 * Revision 1.4  1995/04/05  14:00:27  nickb
 * Add maximum memory use reporting.
 *
 * Revision 1.3  1995/03/01  13:38:24  nickb
 * Add interface for holes and make space_gen array general.
 *
 * Revision 1.2  1994/10/13  13:29:52  nickb
 * Allow multiple block spaces, so blocks can occupy more of arena.
 *
 * Revision 1.1  1994/10/04  16:31:54  jont
 * new file
 *
 * Revision 1.2  1994/06/09  14:25:33  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  10:50:17  nickh
 * new file
 *
 *  Revision 1.5  1994/01/28  17:47:24  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.3  1993/12/14  16:33:24  nickh
 *  Fixed a precedence error in ADDRESS_WIDTH.
 *
 *  Revision 1.2  1993/06/02  13:11:58  richard
 *  Added parentheses suggested by GCC 2.
 *
 *  Revision 1.1  1992/08/04  10:40:48  richard
 *  Initial revision
 *
 */


#ifndef arena_h
#define arena_h

#include "types.h"
#include <stddef.h>
#include "arenadefs.h"

/* SPACE_SIZE is the size of a single space, in bytes 			*/
/* NR_SPACES is the number of spaces in the whole address space		*/
/* SPACES_IN_ARENA is the number of spaces in the arena			*/
/* BLOCK_SIZE is the size of a single block, in bytes 			*/
/* BLOCKS_PER_SPACE is the number of blocks in the arena		*/

#define SPACE_SIZE	(1 << SPACE_WIDTH)
#define NR_SPACES	(1 << (ADDRESS_WIDTH-SPACE_WIDTH))
#define SPACES_IN_ARENA (1 << (ARENA_WIDTH-SPACE_WIDTH))
#define BLOCK_SIZE	(1 << BLOCK_WIDTH)
#define BLOCKS_PER_SPACE (1 << (SPACE_WIDTH-BLOCK_WIDTH))

#define SPACE(addr)	((word)(addr) >> SPACE_WIDTH)
#define SPACE_BASE(s)	((byte *)((s) << SPACE_WIDTH))
#define SPACE_OFFSET(a) ((byte*)(a) - SPACE_BASE(SPACE(a)))
#define BLOCK_BASE(s,b) (SPACE_BASE(s) + ((b) << BLOCK_WIDTH))
#define BLOCK_NR(addr)  (SPACE_OFFSET(addr) >> BLOCK_WIDTH)
#define BLOCKS(size)	(((size) + BLOCK_SIZE-1) >> BLOCK_WIDTH)
#define BLOCKROUND(size) (BLOCKS(size) << BLOCK_WIDTH)

extern byte space_type[NR_SPACES];
extern size_t space_extent[NR_SPACES];

/* space_info[s] is a pointer to information about the space. For
   block spaces, it is a pointer to the block type map for that space.
   For other spaces, it is at the disposal of the client. */

extern void *space_info[NR_SPACES];
#define SPACE_MAP(space)	((byte*) space_info[space])

#define TYPE(addr) \
   (space_type[SPACE(addr)] != TYPE_BLOCKS ?	\
       space_type[SPACE(addr)] : 		\
       (SPACE_MAP(SPACE(addr))[BLOCK_NR(addr)]))

#define SPACE_TYPE(addr) (space_type[SPACE(addr)])

#define TYPE_RESERVED	((byte)-2)
#define TYPE_BLOCKS	((byte)-1)
#define TYPE_FREE	((byte)0)

/* Total amount of memory mapped */

extern size_t arena_extent;

#ifdef COLLECT_STATS
/* we keep track of the largest heap usage */
extern size_t max_arena_extent;
#endif

extern void arena_init(void);
extern byte *block_alloc(byte type, size_t size);
extern void block_free(byte *block, size_t size);
extern byte *space_alloc(byte type, size_t extent);
extern void space_free(byte *space);
extern void space_resize(byte *space, size_t extent);
extern void space_allow_hole(byte *hole, size_t extent);
extern void space_remove_hole(byte *hole, size_t extent);
extern int system_validate_address(void *addr);

#ifdef DEBUG
extern void test_mapping(void);
#endif

#endif
