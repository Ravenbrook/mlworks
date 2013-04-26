/* ==== I386 CODE MANIPULATION ====
 * 
 * Copyright (C) 1995 Harlequin Ltd.
 *
 * Description
 * -----------
 * This module contains any and all code for examining and
 * manipulating I386 code sequences.
 *
 * Revision Log
 * ------------
 * $Log: i386_code.h,v $
 * Revision 1.2  1995/12/12 17:48:56  nickb
 * Add general intel instruction parser, to enable space profiling.
 *
 * Revision 1.1  1995/11/24  11:39:10  nickb
 * new unit
 * I386 code mangling.
 *
 */

#ifndef i386_code_h
#define i386_code_h

#include "types.h"

extern word i386_fixup_sp(word esp, word eip, word edi, word ebp, word ecx);

/* If read_instr(&p) succeeds, it increments p by one instruction and
 * returns SUCCESS (== 1). If it fails, it prints a message to the
 * message stream and does not change p, returning FAILURE (== 0). */

extern int read_instr (byte **pptr);

#endif
