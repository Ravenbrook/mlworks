/* ==== I386 CODE MANIPULATION ====
 * 
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
