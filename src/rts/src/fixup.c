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
 *  The innermost code of the garbage collector. A C version. An asm
 * version of this routine will usually be used. See fixup.h and gc.c
 *
 *  Revision Log
 *  ------------
 *  $Log: fixup.c,v $
 *  Revision 1.11  1996/08/19 14:53:08  nickb
 *  Change error behaviour.
 *
 * Revision 1.10  1996/02/16  11:34:26  jont
 * Change ISPTR to MLVALISPTR
 *
 * Revision 1.9  1995/07/26  13:58:16  nickb
 * Add measurements.
 *
 * Revision 1.8  1995/06/07  14:38:14  jont
 * Add consistency checking on secondary tags for REFs
 *
 * Revision 1.7  1995/05/26  13:01:29  nickb
 * Need to add a comment about shared closures.
 *
 * Revision 1.6  1995/05/24  12:35:17  nickb
 * Fix static shared closures correctly.
 *
 * Revision 1.5  1995/03/07  11:19:34  nickb
 * Correct behaviour for backpointers in static objects.
 *
 * Revision 1.4  1995/02/27  16:15:31  nickb
 * TYPE_LARGE becomes TYPE_STATIC
 *
 * Revision 1.3  1994/09/23  14:27:46  nickb
 * C version of copying bytearrays gets the length wrong.
 *
 * Revision 1.2  1994/06/09  14:51:47  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:26:44  nickh
 * new file
 *
 *
 */

#include "tags.h"
#include "values.h"
#include "mltypes.h"
#include "types.h"
#include "fixup.h"
#include "mem.h"
#include "utils.h"

extern void fixup_bad_header(mlval *what, mlval val, mlval header, mlval *obj)
{
  message("GC fixup of 0x%08x at 0x%08x: "
	  "found header 0x%08x at 0x%08x with bad tag 0x%02x "
	  "-- fixed to MLERROR",
	  val,  what, header, obj, SECONDARY(header));
  *what = MLERROR;
}

extern void fixup_bad_primary(mlval *what, mlval val)
{
  message("GC fixup of 0x%08x at 0x%08x: bad tag %02x -- fixed to MLERROR",
	  val, what, PRIMARY(val));
  *what = MLERROR;
}

/* If MACH_FIXUP is defined, we use assembly code to do a fixup - see
 * fixup.h, mach_fixup.h, mach_fixup.S */

#ifndef MACH_FIXUP

/*  == Fix: Collect one object ==
 *
 *  The macro fix(), defined in fixup.h, does the job of moving an ML
 * object and marking the original as evacuated. It calls fixup(),
 * defined here, to do the core work.  It takes a pointer to an ML
 * value and, if it points to an object in a space of type FROM,
 * copies the object to the `to' parameter and overwrites the original
 * with a forwarding pointer.  The original ML value is then updated
 * to point to the new object and the `to' parameter is updated to
 * point after the copied object.
 *
 *  Notes:
 *    1. If the macro MACH_FIXUP is defined (say, by the Makefile) then a
 *       machine specific version of fixup(), called mach_fixup() will be
 *       used. See mach_fixup.h and mach_fixup.S
 *    2. fixup() is a leaf procedure.  Errors are detected by a macro which
 *       wraps up calls.  This may or may not help with register allocation.
 *    3. Because of the simple-minded way in which arrays are copied (for
 *       speed) collection cannot decrease the generation of an object.
 *       This is unlikely to be a problem.
 *    4. For extensive notes on frequencies of the different cases in
 *       fixup, see the comments in mach_fixup.S
 */

/* We do some measurement, if MEASURE_FIXUP is defined. */

#ifdef MEASURE_FIXUP
struct large {
  unsigned long high;	/* top 32 bits */
  unsigned long low;	/* bottom 20 bits */
};

#define HIGH12(x)	((x)>>20)
#define LOW20(x)	(((x)<<12)>>12)

#define inc_large(large)						\
do {									\
  unsigned long l = (large).low+1;					\
  (large).high += HIGH12(l);						\
  (large).low = LOW20(l);						\
} while(0)

#define large_zero_p(large)	(((large).low == 0) && ((large).high == 0))
#define double_large(large) (((double)(large).high)*1048576.0+(large).low)

#define LNAME(x)	fixup_record ## x

#define FIX_DECLARE(x)	struct large LNAME(x) = {0,0}
#define FIX_RECORD(x)	inc_large(LNAME(x))
#define FIX_DOUBLE(x)	double_large(LNAME(x))
#define FIX_ZERO_P(x)	large_zero_p(LNAME(x))

#else

#define FIX_DECLARE(x)
#define FIX_RECORD(x)

#endif

FIX_DECLARE(fix);
FIX_DECLARE(nonptr);
FIX_DECLARE(notfrom);
FIX_DECLARE(stat);
FIX_DECLARE(evac);
FIX_DECLARE(pair);
FIX_DECLARE(pointer);
FIX_DECLARE(string);
FIX_DECLARE(string_real);
FIX_DECLARE(string_real_code);
FIX_DECLARE(string_real_code_record);
FIX_DECLARE(copy_loop);
FIX_DECLARE(backptr);
FIX_DECLARE(evac_backptr);
FIX_DECLARE(shared_closure);
FIX_DECLARE(shared_step);
FIX_DECLARE(evac_shared);
FIX_DECLARE(refptr);
FIX_DECLARE(bytearray);
FIX_DECLARE(array_weak);

/* Probabilities are given for each branch, based on two tests:
 * MLWorks compiling itself, and an hour-long test of the Lego system.
 * They're derived from the statistics listed in arch/SPARC/fixup.S */

extern mlval *fixup(mlval *to, mlval *what)
{
  mlval *object, *actual;
  mlval value, fixed, subfixed, header, word1, primary, back;
  int type;
  signed long length;

  value = *what;
  FIX_RECORD(fix);

  if(!MLVALISPTR(value)) {		/* 27.5% (Lego), 47.4% (MLWorks) */
    FIX_RECORD(nonptr);
    return(to);
  }

  object = OBJECT(value);		/* Obtain a pointer to the object */
  type = SPACE_TYPE(value);		/* and the type of the block it's in */

  /* If the object is not in a FROM block (i.e., not in the from space) then */
  /* it should not be collected. */

  if(type != TYPE_FROM) {      /* 50.2% (Lego), 26.5% (MLWorks) */
    FIX_RECORD(notfrom);
    /* If the object is in a TYPE_STATIC then it is a specially allocated */
    /* large object.  Large objects are collected by mark-and-sweep (see */
    /* collect_gen()), so mark the object. */

    if(type == TYPE_STATIC) {
      FIX_RECORD(stat);
      if (PRIMARY(value) == POINTER)
	if (SECONDARY(object[0]) == BACKPTR)
	  /* follow the backptr */
	  object = (mlval *)((word)object - LENGTH(object[0]));
	else while (object[0] == 0)
	  /* step back through the shared closure */
	  object -= 2;
      object[-1] = 0;
    }

    return(to);
  }

  header = object[0];
  word1  = object[1];

  /* If the object has been evacuated then fix the value to the fixed */
  /* version. */

  if(header == EVACUATED) {	/* 20.4% (Lego), 11.7% (MLWorks) */
    FIX_RECORD(evac);
    *what = word1;
    return(to);
  }

  /* Extract the primary tag of the value and calculate the fixed version, */
  /* i.e., the value to which the object will be fixed if it is copied */
  /* simply. */

  primary   = PRIMARY(value);
  fixed     = MLPTR(to, primary);

  switch(primary)
  {
    /* To fix a pair copy the two words and evacuate the original. */

    case PAIRPTR:		/* 91.1% (Lego), 80.7% (MLWorks) */
    FIX_RECORD(pair);
    object[0] = EVACUATED;
    object[1] = *what = fixed;
    to[0] = header;
    to[1] = word1;
    return(to+2);

    case POINTER:		/* 8.5% (Lego), 16.1% (MLWorks) */
    FIX_RECORD(pointer);
    /* Check that the object is not part of a shared closure before */
    /* continuing. */

    if(header != 0) {		/* 99.51% (Lego), 99.97% (MLWorks) */
      length = LENGTH(header);

      switch(SECONDARY(header)) {
	/* Strings can be fixed in the same way as records, */
	/* but first, round their length up into words. */

	/* Bytearrays with POINTER pointers are boxed floats. */

	case STRING:		/* 6.4% (Lego), 7.9% (MLWorks) */
	FIX_RECORD(string);
        case BYTEARRAY:		/* boxed floats; hardly any */
	FIX_RECORD(string_real);
	length = WLENGTH(length);

	/* Code vectors can be fixed as records. */

	case CODE:		/* code vectors; hardly any */
	FIX_RECORD(string_real_code);
	case RECORD:		/* 90.94% (Lego), 91.95% (MLWorks) */
	FIX_RECORD(string_real_code_record);
	object[0] = EVACUATED;
	object[1] = *what = fixed;
	to[0] = header;
	to[1] = word1;
	while((length-=2) >= 0)	{
	  FIX_RECORD(copy_loop);
	  to += 2;
	  object += 2;
	  to[0] = object[0];
	  to[1] = object[1];
	}
	return(to+2);

	/* The length of a backpointer is an amount to subtract from the */
	/* value in order to find the actual code object of which it is a */
	/* part.  cf shared closures (below) */

	case BACKPTR:		/* 2.16% (Lego), 0.11% (MLWorks) */
	FIX_RECORD(backptr);
	actual = (mlval *)((word)object - length);
	header = actual[0];
	word1  = actual[1];

	/* If the whole code vector has been evacuated then just fix the */
	/* value and mark the substring to make future fixups go faster. */

	if(header == EVACUATED)	{ /* 72.54% (Lego), 76.99% (MLWorks) */
	  FIX_RECORD(evac_backptr);
	  object[0] = EVACUATED;
	  object[1] = *what = word1 + length;
	  return(to);
	}

	/* Evacuate the whole code vector. */

	subfixed = fixed + length;
	length = LENGTH(header);
	actual[0] = EVACUATED;
	actual[1] = fixed;
	to[0] = header;
	to[1] = word1;
	while((length-=2) >= 0) {
	  FIX_RECORD(copy_loop);
	  to += 2;
	  actual += 2;
	  to[0] = actual[0];
	  to[1] = actual[1];
	}

	/* Now that the whole code vector has been copied elsewhere it is */
	/* alright to overwrite the substring header with an evacuation */
	/* marker. */

	object[0] = EVACUATED;
	object[1] = *what = subfixed;
	return(to+2);
      }

      fixup_bad_header(what,value,header,object);
      return to;
    }

    /* The header was zero, and therefore the object was a shared closure. */
    /* Search backward in steps of two words until the actual header is */
    /* found.  cf backpointers (above) */

    /* 0.49% (Lego), 0.03% (MLWorks) */
    FIX_RECORD(shared_closure);
    actual = object - 2;
    while((header = actual[0]) == 0) {
      FIX_RECORD(shared_step);
      actual -= 2;
    }
    back = (byte *)object - (byte *)actual;
    word1 = actual[1];

    /* If the whole closure has been evacuated then just fix the original */
    /* value and mark the subclosure to make future fixups faster. */

    /* Note that this is a safe thing to do, as future fixups which
     * hit later in the same shared closure will treat this subclosure
     * as the header of the whole thing, but get the right answer
     * nevertheless! */

    if(header == EVACUATED) {	/* 85.01% (Lego), 84.59% (MLWorks) */
      FIX_RECORD(evac_shared);
      object[0] = EVACUATED;
      object[1] = *what = word1 + back;
      return(to);
    }

    /* Evacuate the entire closure. */

    length = LENGTH(header);
    actual[0] = EVACUATED;
    actual[1] = fixed;
    to[0] = header;
    to[1] = word1;
    while((length -= 2) >= 0) {
      FIX_RECORD(copy_loop);
      to += 2;
      actual += 2;
      to[0] = actual[0];
      to[1] = actual[1];
    }

    /* Now that the whole closure has been evacuated it is alright to */
    /* overwrite the subclosure with an evacuation marker to make future */
    /* fixups go faster. */

    object[0] = EVACUATED;
    object[1] = *what = fixed + back;
    return(to+2);

    /* An array is treated like a record except that some entry list */
    /* fiddling takes place. */

    case REFPTR:		/* 0.39% (Lego), 3.21% (MLWorks) */
    FIX_RECORD(refptr);
    object[0] = EVACUATED;
    object[1] = *what = fixed;
    to[0] = header;
    to[1] = word1;

    /* bytearrays have refptr pointers but no entry list slots */

    if (SECONDARY(header) == BYTEARRAY) { /* 0.26% (Lego), 0.01% (MLWorks) */
      FIX_RECORD(bytearray);
	length = WLENGTH(LENGTH(header));
	while((length-=2) >= 0) {
	  FIX_RECORD(copy_loop);
	  to += 2;
	  object += 2;
	  to[0] = object[0];
	  to[1] = object[1];
	}
	return(to+2);
    }
    /* If the backward pointer in the entry list chain is non-zero then the */
    /* array is on a list and the adjacent arrays must be updated to point */
    /* to the new copy. */

    if (SECONDARY(header) == ARRAY || SECONDARY(header) == WEAKARRAY) {
      /* 99.74% (Lego), 99.99% (MLWorks) */
      FIX_RECORD(array_weak);
      /* Only do this stuff if it really is an array. We want to catch errors */
      back = object[2];
      if(back != 0)
	*(mlval **)(word1+8) = *(mlval **)(back+4) = to;

      /* Evacuate the rest of the array like a record. */

      to[2] = back;
      to[3] = object[3];
      length = LENGTH(header);
      while((length-=2) >= 0) {
	FIX_RECORD(copy_loop);
	  to += 2;
	  object += 2;
	  to[2] = object[2];
	  to[3] = object[3];
	}
      return(to+4);
    }
    fixup_bad_header(what, value, header, object);
    return to;
  }

  fixup_bad_primary(what, value);
  return to;
}

#ifdef MEASURE_FIXUP

#include "ansi.h"

#define percentage(frac,total)	(total == 0.0 ? 0.0 : (100.0*frac/total))
#define fraction(frac,total)	(total == 0.0 ? 0.0 : (frac/total))
#define get(x)		double x = FIX_DOUBLE(x)

extern void report_fixup(void)
{
  get(fix);
  get(nonptr);
  get(notfrom);
  get(stat);
  get(evac);
  get(pair);
  get(pointer);
  get(string);
  get(string_real);
  get(string_real_code);
  get(string_real_code_record);
  get(copy_loop);
  get(backptr);
  get(evac_backptr);
  get(shared_closure);
  get(shared_step);
  get(evac_shared);
  get(refptr);
  get(bytearray);
  get(array_weak);

  double ptr = fix-nonptr;
  double fromptr = ptr-notfrom;
  double copied = fromptr-evac;
  double real = string_real-string;
  double code = string_real_code - string_real;
  double record = string_real_code_record - string_real_code;
  double copies =
    (copy_loop + pair +
     string_real_code_record +
     backptr - evac_backptr +
     shared_closure - evac_shared +
     refptr + array_weak)*8.0;

  printf("Fixup statistics:\n\n"
         "Total calls of fixup .  .  .   : %12.0f\n"
         "  non-pointers                 : %12.0f (%5.2f%%)\n"
         "  not from space     .  .  .   : %12.0f (%5.2f%% of ptrs)\n"
         "    static objects             : %12.0f (%5.2f%% of non-from ptrs)\n"
         "  already evacuated  .  .  .   : %12.0f (%5.2f%% of from ptrs)\n",
	 fix, nonptr, percentage(nonptr,fix),
	 notfrom, percentage(notfrom,ptr),
	 stat, percentage(stat,notfrom),
	 evac, percentage(evac,fromptr));

  printf("  copied                       : %12.0f (%5.2f%% of from ptrs)\n"
	 "    pairs            .  .  .   : %12.0f (%5.2f%% of copied objs)\n"
	 "    pointers                   : %12.0f (%5.2f%% of copied objs)\n"
	 "      records        .  .  .   : %12.0f (%5.2f%% of copied ptrs)\n",
	 copied, percentage(copied, fromptr),
	 pair, percentage(pair,copied),
	 pointer, percentage(pointer,copied),
	 record, percentage(record,pointer));

  printf("      strings                  : %12.0f (%5.2f%% of copied ptrs)\n"
	 "      reals          .  .  .   : %12.0f (%5.2f%% of copied ptrs)\n"
	 "      code objects             : %12.0f (%5.2f%% of copied ptrs)\n"
	 "      backptrs       .  .  .   : %12.0f (%5.2f%% of copied ptrs)\n",
	 string, percentage(string,pointer),
	 real, percentage(real,pointer),
	 code, percentage(code,pointer),
	 backptr, percentage(backptr,pointer));

  printf("        evacuated              : %12.0f (%5.2f%% of backptrs seen)\n"
	 "      shared closures   .  .   : %12.0f (%5.2f%% of copied ptrs)\n"
	 "        steps                  : %12.0f (%6.3f per shared closure)\n"
	 "        evacuated    .  .  .   : %12.0f (%5.2f%% shared closures)\n",
	 evac_backptr, percentage(evac_backptr,backptr),
	 shared_closure, percentage(shared_closure,pointer),
	 shared_step, fraction(shared_step, shared_closure),
	 evac_shared, percentage(evac_shared,shared_closure));

  printf("    ref ptrs                   : %12.0f (%5.2f%% of copied objs)\n"
	 "      arrays and weak arrays   : %12.0f (%5.2f%% copied ref ptrs)\n"
	 "      bytearrays   .  .  .     : %12.0f (%5.2f%% copied ref ptrs)\n"
	 "\n  Total copy loop iterations   : %12.0f (%6.3f per fixup)\n"
	 "  Total bytes copied           : %12.0f (%6.3f per fixup)\n",
	 refptr, percentage(refptr,copied),
	 array_weak, percentage(array_weak,refptr),
	 bytearray, percentage(bytearray,refptr),
	 copy_loop, fraction(copy_loop,fix),
	 copies, fraction(copies,fix));
}

#endif

#endif /* MACH_FIXUP */
