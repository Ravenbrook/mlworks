/*  ==== C WORD OPERATORS ====
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
 *  Word manipulation operators are required by the Initial Basis. Words
 *  represent unsigned natural numbers of a certain size.  As a first-cut
 *  implementation, this is provided via operations in C.  This will be
 *  slow - however, these could eventually be inlined and treated like our
 *  pervasive operators.
 *  
 *  Revision Log
 *  ------------
 *  $Log: words.h,v $
 *  Revision 1.3  1995/09/04 10:32:23  daveb
 *  Changed unsigned to word.
 *
 * Revision 1.2  1995/04/03  12:07:13  brianm
 * Adding num_to_word32() word32_to_num().
 * Updating to use allocate_word32() and CWORD32().
 * Made code more GC-safe by moving allocation to end of functions.
 *
 * Revision 1.1  1995/03/16  18:34:05  brianm
 * new unit
 * New file.
 *
 *
 */

#ifndef words_h
#define words_h

#include "mltypes.h"

extern void     words_init(void);
extern void     num_to_word32(word, mlval);
extern word  	word32_to_num(mlval);

#endif
