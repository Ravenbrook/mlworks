/*  === GARBAGE COLLECTION FIXUP ===
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
 * The innermost code of the garbage collector. It has to be separated
 * out from gc.c because it is also called from stacks.c:stack_crawl,
 * which is machine dependent.
 *
 *  Revision Log
 *  ------------
 *  $Log: fixup.h,v $
 *  Revision 1.9  1998/03/17 16:05:43  jont
 *  [Bug #30360]
 *  Modify fix_reg not to trap when finding header values.
 *
 * Revision 1.8  1996/12/19  09:33:05  stephenb
 * [Bug #1790]
 * fix_reg: wrap the macro body in a do { ... } while (0) to avoid
 * any incorrect binding problems.
 *
 * Revision 1.7  1996/08/19  14:43:08  nickb
 * Change error behaviour.
 *
 * Revision 1.6  1996/02/14  17:24:09  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.5  1995/07/26  13:58:16  nickb
 * Add measurements.
 *
 * Revision 1.4  1995/03/28  13:22:39  nickb
 * Thread system changes.
 *
 * Revision 1.3  1994/07/01  10:43:51  nickh
 * Remove SPARC-specific debugger trap generator.
 *
 * Revision 1.2  1994/06/09  14:44:16  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:12:56  nickh
 * new file
 *
 *
 */

#ifndef fixup_h
#define fixup_h

#include "values.h"
#include "tags.h"
#include "mltypes.h"

/*  == Fix: Collect one object ==
 *
 *  The macro fix() does the job of moving an ML object and marking the
 *  original as evacuated.  It takes a pointer to an ML value and, if it
 *  points to an object in a space of type FROM, copies the object to the
 *  `to' parameter and overwrites the original with a forwarding pointer.
 *  The original ML value is then updated to point to the new object and the
 *  `to' parameter is updated to point after the copied object.
 *
 *  Notes:
 *    1. If the macro MACH_FIXUP is defined (say, by the Makefile) then a
 *       machine specific version of fixup(), called mach_fixup() will be
 *       used.
 *    2. fixup() is a leaf procedure.  Error are detected by a macro which
 *       wraps up calls.  This may or may not help with register allocation.
 *
 */

extern void fixup_bad_header(mlval *what, mlval val, mlval header, mlval *obj);
extern void fixup_bad_primary(mlval *what, mlval val); 

#ifdef MACH_FIXUP

#include "mach_fixup.h"

#define fix(to, what)				\
do { mlval val = *(what);			\
  if (MLVALISPTR(val))				\
    to = mach_fixup(to, what, val);		\
} while(0)

#else /* use the C version */

extern mlval *fixup (mlval *to, mlval *what);

#ifdef MEASURE_FIXUP
extern void report_fixup(void);
#endif

#define fix(to, what) (to = fixup(to, what))

#endif /* MACH_FIXUP */

/*  == Scanning: Fixing a block of heap ==
 *
 *  Scanning is the act of running through a chunk of memory fixing up all
 *  the ML objects it contains.  Basically, every word is treated as a valid
 *  ML object and fixed, except for STRINGs, BYTEARRAYs, CODE vectors, and
 *  WEAKARRAYs which are skipped.  WEAKARRAYS are fixed specially.
 *
 *  Notes:
 *    1.  The `end' parameter is evaluated every time round the loop.  This
 *        allows it to be the same as the `to' parameter when fixing the to
 *        space.  (See gc.c:collect_gen())
 *    2.  For extensive notes on the cost of scan, and on possible
 *        improvements to the scan() code, see the comments in fixup.S
 */

#define scan(start, end, to)						      \
{									      \
  register mlval *f = (start);						      \
									      \
  while(f < (end))							      \
  {									      \
    mlval value = *f;							      \
									      \
    if(FIXABLE(value))							      \
    {									      \
      fix(to, f);							      \
      ++f;								      \
    }									      \
    else								      \
      switch(SECONDARY(value))						      \
      {									      \
	case WEAKARRAY:                                                       \
	f += LENGTH(value)+3;						      \
	break;								      \
									      \
	case CODE:							      \
	fix(to, f+1);							      \
	f += LENGTH(value)+1;						      \
	break;								      \
									      \
	case BYTEARRAY:							      \
	case STRING:							      \
	f = (mlval *)double_align((byte *)f + LENGTH(value) + sizeof(mlval)); \
      }									      \
  }									      \
}

/* When fixing values in a stack frame, we must not use scan(), as
 * it will do special things with header-valued register slots. So we
 * call fix_reg on each slot. */

#ifdef DEBUG
#define fix_reg(to, what)						\
do {									\
  mlval primary = PRIMARY(*(what));					\
									\
  if(primary == HEADER)							\
  {									\
    message("fix_reg: found header 0x%X at 0x%X.  Ignoring.",		\
            *(what), (what));						\
	      backtrace(GC_SP(CURRENT_THREAD),				\
			CURRENT_THREAD, max_backtrace_depth);		\
  }									\
									\
  fix(to, what);							\
} while (0)
#else /* DEBUG */
#define fix_reg fix
#endif /* DEBUG */

#endif /* fixup_h */
