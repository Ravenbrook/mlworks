/*  ==== ARENA MANAGEMENT ====
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header defines values controlling the overall structure of
 *  the memory arena. It can be included by either C or asm sources,
 *  so contains no C declarations. C declarations concerned with the
 *  arena are in arena.h (which includes this header). For more
 *  information, see arena.h
 *
 *  $Id: arenadefs.h,v 1.3 1998/05/11 17:03:21 jont Exp $ */

#ifndef arenadefs_h
#define arenadefs_h

/* MLWorks only works in environments where "void *" and "word" have
 * ADDRESS_WIDTH bits. This is used to define the size of tables in
 * which any address can be looked up. */

#define ADDRESS_WIDTH	32

/* The "arena" is memory between 0 and 1 << ARENA_WIDTH. All the
   managed memory lies in this range. */

#define ARENA_WIDTH	32

/* We divide the whole address space into spaces, each of size 1 <<
 * SPACE_WIDTH. We manage the arena a space at a time. */

#define SPACE_WIDTH	24	/* 128 * 16Mb spaces */

/* some spaces are further subdivided into blocks, each of size 1 <<
   BLOCK_WIDTH */

#define BLOCK_WIDTH	16	/* 64Kb blocks */

#endif
