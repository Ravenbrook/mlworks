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
 *  This header defines values controlling the overall structure of
 *  the memory arena. It can be included by either C or asm sources,
 *  so contains no C declarations. C declarations concerned with the
 *  arena are in arena.h (which includes this header). For more
 *  information, see arena.h
 *
 *  $Id: arenadefs.h,v 1.3 1996/10/31 12:34:59 nickb Exp $
 */

#ifndef arenadefs_h
#define arenadefs_h

/* MLWorks only works in environments where "void *" and "word" have
 * ADDRESS_WIDTH bits. This is used to define the size of tables in
 * which any address can be looked up. */

#define ADDRESS_WIDTH	32

/* The "arena" is memory between 0 and 1 << ARENA_WIDTH. All the
   managed memory lies in this range. */

#define ARENA_WIDTH	31

/* We divide the whole address space into spaces, each of size 1 <<
 * SPACE_WIDTH. We manage the arena a space at a time. */

#define SPACE_WIDTH	24	/* 128 * 16Mb spaces */

/* some spaces are further subdivided into blocks, each of size 1 <<
   BLOCK_WIDTH */

#define BLOCK_WIDTH	16	/* 64Kb blocks */

#endif
