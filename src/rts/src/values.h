/*  ==== ML VALUE TOOLS ====
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
 *  Revision Log
 *  ------------
 *  $Log: values.h,v $
 *  Revision 1.25  1997/05/30 11:33:40  jont
 *  [Bug #30076]
 *  Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.24  1996/09/25  12:25:00  io
 * [Bug #1490]
 * update comment wrt src
 *
 * Revision 1.23  1996/09/18  15:13:48  io
 * [Bug #1490]
 * update ML_MAX_STRING
 *
 * Revision 1.22  1996/08/27  13:16:10  stephenb
 * mlupdate: change the type of subscript argument to a word
 * so it is less likely that someone will pass an MLINT as
 * a subscript rather than a plain C int.
 *
 * Also took the opportunity to rename mlupdate -> mlw_update
 * in line with rolling program to have "mlw" prefix on all
 * external symbols.
 *
 * Revision 1.21  1996/07/10  09:27:04  stephenb
 * Add some documentation to cons and update the mlw_option_make_some
 * description to indicate that the argument is now declared/retracted
 * as a root by mlw_option_make_some.
 *
 * Revision 1.20  1996/06/13  10:04:25  stephenb
 * Add mlw_ref_make, mlw_ref_value and mlw_ref_update.  The first two
 * are synonyms for existing routines the last hides the fact that
 * refs are one element arrays.
 *
 * Marked MLDEREF and ref as deprecated routines.
 *
 * Revision 1.19  1996/06/04  19:29:01  io
 * add exn Size
 *
 * Revision 1.18  1996/05/07  09:09:47  stephenb
 * Add support for Option type.
 *
 * Revision 1.17  1996/02/22  14:38:47  matthew
 * Adding MLBOOL and CBOOL
 *
 * Revision 1.16  1996/02/14  17:16:39  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.15  1996/01/31  12:40:47  jont
 * Add definitions for ML_MAX_INT32 and ML_MIN_INT32
 *
 * Revision 1.14  1995/09/13  16:12:57  daveb
 * Added type coercion to CWORD32.
 *
 * Revision 1.12  1995/08/08  09:55:28  matthew
 * Changing representation of word32's to strings
 *
 * Revision 1.11  1995/07/27  12:00:04  jont
 * Add CWORD for extracting unsigned values
 *
 * Revision 1.10  1995/07/13  10:24:37  nickb
 * Add objsize() and datasize() macros.
 *
 * Revision 1.9  1995/04/03  11:24:11  brianm
 * Adding CWORD32
 *
 * Revision 1.8  1995/03/30  15:04:26  nickb
 * Change exception packet macros.
 *
 * Revision 1.7  1995/03/07  16:03:15  nickb
 * Add OBJECT_SIZE macro.
 *
 * Revision 1.6  1994/07/25  15:36:13  jont
 * Move architecture dependent stuff into mach_values.h
 *
 * Revision 1.5  1994/07/19  16:59:02  jont
 * Add number of callee saves info
 *
 * Revision 1.4  1994/07/13  13:01:38  nickh
 * Make code item ancillary word easier to customize.
 *
 * Revision 1.3  1994/06/21  16:02:24  nickh
 * New ancillary structure and forced GC on image save.
 *
 * Revision 1.2  1994/06/09  14:46:21  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:16:41  nickh
 * new file
 *
 *  Revision 1.45  1993/06/02  13:15:36  richard
 *  Added parentheses suggested by GCC 2.
 *
 *  Revision 1.44  1993/04/19  13:08:09  richard
 *  Changed val_print() for new value printer.
 *  Removed rusty polymorphic equality.
 *
 *  Revision 1.43  1993/03/23  15:16:50  jont
 *  Modified defn of CBYTEARRAY to account for using ref tags
 *
 *  Revision 1.42  1993/03/11  18:17:43  jont
 *  Moved ANCILLARY_SLOT_SIZE into here from loader.c
 *
 *  Revision 1.41  1993/02/10  15:09:07  jont
 *  Changes for code vector reform.
 *
 *  Revision 1.40  1993/02/02  17:21:23  jont
 *  Added ISORDPTR and ISREFPTR to distinguish these types
 *
 *  Revision 1.39  1993/02/01  16:07:38  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.38  1993/01/14  14:55:07  daveb
 *  Changed definitions of MLHEAD and MLTAIL to use new list representation.
 *
 *  Revision 1.37  1992/10/26  13:03:22  richard
 *  Removed gross CCVNAME hack.
 *
 *  Revision 1.36  1992/08/24  15:47:02  richard
 *  Corrected bytearray and real number macros.
 *
 *  Revision 1.35  1992/08/19  15:50:31  richard
 *  Corrected the definition of CCVSTART and CCVEND.
 *
 *  Revision 1.34  1992/08/18  12:32:59  richard
 *  Added CCVEND().
 *
 *  Revision 1.33  1992/08/11  11:24:32  richard
 *  Added alignment predicates.
 *
 *  Revision 1.32  1992/08/07  13:48:57  clive
 *  Changed the functionality of some of the debugger functions - added support
 *  for tracing
 *
 *  Revision 1.31  1992/08/05  16:52:17  richard
 *  Code vectors are now tagged differently to strings.
 *
 *  Revision 1.30  1992/07/27  17:26:10  richard
 *  Added stuff to deal with exceptions.
 *
 *  Revision 1.29  1992/07/15  15:35:35  richard
 *  Changed MLSUB to use the new ml_array_header structure.
 *
 *  Revision 1.28  1992/07/14  10:05:57  richard
 *  Changed definition of FIXABLE to include WEAKARRAY objects.
 *  Reimplemented CCV macros to use code_vector_header structure.
 *  Corrected definition of MLSUB to use a type cast.
 *
 *  Revision 1.27  1992/07/03  07:21:03  richard
 *  Moved tags to tags.h so that they can be used from assembler.
 *
 *  Revision 1.26  1992/07/01  13:20:49  richard
 *  Added array handling macros.
 *
 *  Revision 1.25  1992/06/24  12:28:01  richard
 *  Added some extra macros to keep the new version of fixup() tidy.
 *
 *  Revision 1.24  1992/04/06  08:53:45  richard
 *  Changed evacuation to a uniform marker, freeing one header tag.
 *
 *  Revision 1.23  1992/04/01  09:59:29  richard
 *  Changed `CAR' and `CDR' to `HEAD' and `TAIL' on request from
 *  Jon who doesn't like using the names of ``registers on ancient
 *  machines''.
 *
 *  Revision 1.22  1992/03/23  12:27:33  richard
 *  Added `FIXABLE' predicate.
 *
 *  Revision 1.21  1992/03/18  13:31:21  richard
 *  Generalised parameter mechanism to val_print().
 *
 *  Revision 1.20  1992/03/11  12:31:04  richard
 *  The length of a C string is one less than the length in the header, which
 *  includes the terminating '\0'.
 *
 *  Revision 1.19  1992/03/06  14:32:09  clive
 *  Added string length
 *
 *  Revision 1.18  1992/02/25  15:46:09  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.17  1992/02/14  17:08:24  richard
 *  Added extra debugging information to val_print.  This is switched on with the
 *  `-i' option.  (See main.c)
 *
 *  Revision 1.16  1992/01/16  14:11:14  richard
 *  Added ARRAYHEADER and changed CARRAY as the primary tag for arrays is now
 *  REFPTR.  Changed some explicit uses of `5' to POINTER.
 *
 *  Revision 1.15  1992/01/15  09:29:25  richard
 *  Removed definition of NULL.  (Who put it there?)
 *
 *  Revision 1.14  1992/01/14  16:22:21  richard
 *  Added FOLLOWBACK.
 *
 *  Revision 1.13  1991/12/17  16:36:16  richard
 *  Fixed SETREAL..
 *
 *  Revision 1.12  91/12/17  16:26:31  nickh
 *  added P(x) to dereference a pointer value (used extensively in gc).
 *  
 *  Revision 1.11  91/12/17  14:25:49  richard
 *  Added macros for dealing with reals.
 *  
 *  Revision 1.10  91/12/16  12:53:41  richard
 *  Added SETCAR and SETCDR, polymorhpic equality, and list cons.
 *  
 *  Revision 1.9  91/12/13  15:52:34  richard
 *   Tidied up and added macros for dealing with some predefined ML types
 *  such as list.
 *  
 *  Revision 1.8  91/12/05  16:57:59  richard
 *  Added MLTRUE and MLFALSE.
 * 
 *  Revision 1.7  91/11/28  14:48:11  richard
 *  Added MLUNIT.
 * 
 *  Revision 1.6  91/10/22  11:48:06  davidt
 *  Put in various casts so that macros work correctly when
 *  passed values of pointer type.
 * 
 *  Revision 1.5  91/10/18  18:02:12  davidt
 *  Put in word_align and NFIELDS.
 * 
 *  Revision 1.4  91/10/17  15:19:54  davidt
 *  Major changes. This file now includes lots of utilities for
 *  creating and untagging ML values.
 * 
 *  Revision 1.3  91/10/16  15:33:42  davidt
 *  Putin double_align macro. I intend this file have general value
 *  manipulation utilities eventually.
 * 
 *  Revision 1.2  91/05/15  15:32:05  jont
 *  Revised interface for second version of load format
 * 
 *  Revision 1.1  91/05/14  11:10:32  jont
 *  Initial revision
 */


#ifndef values_h
#define values_h

#include "mltypes.h"
#include "implicit.h"
#include "tags.h"

#include <stddef.h>
#include <stdio.h>


#define word_align(x)		(((word)(x) + 3) & ~3u)
#define double_align(x) 	(((word)(x) + 7) & ~7u)
#define is_word_aligned(x)	(!((word)(x) & 3))
#define is_double_aligned(x)	(!((word)(x) & 7))


/*  == Primary tag manipulation ==
 *
 *  PRIMARY(x)    extracts the primary tag (see above) from value x
 *  OBJECT(x)     a pointer to the header of the object pointed to by x
 *  MLVALISPTR(x) true iff x is a pointer
 *  ISORDPTR	  true iff x is a PAIRPTR or RECORDPTR
 *  ISREFPTR	  true iff x is a reference type pointer
 *  MLINT(x)      makes a tagged integer value from an integer
 *  MLPTR(t,p)    makes a pointer to p with tag t
 *  CINT(x)       extracts the integer from an integer value
 *  CWORD(x)      extracts the word from an word value
 *  CPTR(x)       extracts the pointer from a pointer value
 *  DEREF(x)      extracts the value referenced by a reference pointer
 *  FOLLOWBACK(x) follows a BACKPTR to the main object (see secondaries)
 */

#define PRIMARY(x)	((mlval)(x) & 7)
#define OBJECT(x)	((mlval *)((x) & ~7u))
#define MLVALISPTR(x)	((mlval)(x) & 1)
#define ISORDPTR(x)	(((mlval)(x) & 3) == 1)
#define ISREFPTR(x)	(((mlval)(x) & 3) == 3)
#define MLINT(i)	((mlval)(i) << 2)
#define MLPTR(t,p)      ((mlval)(t) + (mlval)(p))
#define CINT(i)	((int)(i) >> 2)
#define CWORD(w)	((unsigned int)(w) >> 2)
#define CPTR(p)         ((mlval *)(p-1))
#define DEREF(x)        ((mlval)(*(mlval *)((x)+9)))
#define FOLLOWBACK(p)	((mlval)((word)(p)-LENGTH(*(word *)((word)(p)-POINTER))))

#define TRUE_HEAD(ml_value)	((PRIMARY(ml_value) == POINTER &&	      \
				  SECONDARY(*OBJECT(ml_value)) == BACKPTR) ?  \
				 OBJECT(FOLLOWBACK(ml_value)) :		      \
				 OBJECT(ml_value))

/*  == Secondary tag manipulation ==
 *
 *  Note: EQUALITY and POINTERS are only defined for normal objects.
 *
 *  SECONDARY(x)  extracts the secondary tag from header word x
 *  ISNORMAL(x)   true iff x is a header from an ordinary record (see above)
 *  EQUALITY(x)   true iff the record has simple equality
 *  POINTERS(x)   true iff the record contains pointers
 *  MAKEHEAD(t,l) make a header word for a record of length l with tag t
 *  LENGTH(x)     returns the length of the record
 *  WLENGTH(l)    converts a string length into a length in words
 *  FIXABLE(x)    false iff x is a STRING, BYTEARRAY, WEAKARRAY, or CODE
 *  OBJECT_SIZE(s,l)
	converts a secondary and length into the object size in bytes
 *  DATA_SIZE(s,l)
 	converts a secondary and length into the number of bytes of user data
 */

#define SECONDARY(x)	((x) & 63)
#define ISNORMAL(x)	(!((x) & 32))
#define EQUALITY(x)	(!((x) & 16))
#define POINTERS(x)	(!((x) & 8))
#define MAKEHEAD(t,l)	(((l) << 6) + (t))
#define LENGTH(x)	((x) >> 6)
#define WLENGTH(l)      (((l)+3) >> 2)
#define FIXABLE(x)	(((x) & 0xF) ^ 0xA)

#define OBJECT_SIZE(s,l) (PRIMARY(s) != HEADER ? 8 :		\
			  double_align((			\
			   (s) == RECORD    ? ((l)<<2) :	\
			   (s) == CODE      ? ((l)<<2) :	\
			   (s) == STRING    ? (l) :		\
			   (s) == BYTEARRAY ? (l) :		\
			   (s) == ARRAY     ? (((l)+2)<<2) :	\
			   (s) == WEAKARRAY ? (((l)+2)<<2) :	\
			   0)+4))

#define DATA_SIZE(s,l)	(PRIMARY(s) != HEADER ? 8 :     \
			 (s) == RECORD    ? ((l)<<2) :  \
			 (s) == CODE      ? ((l)<<2) :  \
			 (s) == ARRAY	  ? ((l)<<2) :  \
			 (s) == WEAKARRAY ? ((l)<<2) :  \
			 (s) == STRING    ? (l) :	\
			 (s) == BYTEARRAY ? (l) :	\
			 0)


/*  === ML OBJECTS ===  */

/*  == Strings ==
 *
 *  Strings are records with header tag STRING and length equal to the
 *  number of characters in the string.
 *
 *  CSTRING(x)  returns a char * pointing to the string from string value x
 *
 *  ML_MAX_STRING refers to the maximum length of an ml string
 *  update this wrt <URI:pervasive/__pervasive_library.sml#MLWorks.String.maxLen>
 */

#define CSTRING(p) ((char *)(p) - 1)
#define CSTRINGLENGTH(x) (LENGTH(GETHEADER(x))-1)
#define ML_MAX_STRING 16777195

/*  == Code vectors ==
 *
 *  Code vectors have a GC field at the beginning which points to an
 *  record (usually a pair) containing extra information about the
 *  code.  This is called the ancillary record, the field is called
 *  the ancillary field.  See the struct definition in mltypes.h, 
 *  the ANC_ macros in tags.h, and the code item macros below.
 *
 *  CCVANCILLARY(p)	fetches the ancillary record from a (whole) code vector
 *  CCODEANCILLARY(p)	as above but p is a code item within the vector
 */

#define CCVANCILLARY(p)		(((struct code_vector_header *)OBJECT(p))->ancillary)
#define CCODEANCILLARY(p)	CCVANCILLARY(FOLLOWBACK(p))

/*

The ancillary field of a code item (potentially one of many such in a
code vector) is 32 bits, containing the following fields, from msb to
lsb:

non_gcs		: the number of non-gc spills
stack_params	: the number of stacked arguments passed to the function
leaf		: a one-bit flag; is this a leaf procedure?
intercept	: the offset of the intercepting instructions
number		: the # of this code item within the code vector.
		  (and therefore an index into the tables pointed to
		   by the ancillary word in the code vector header)

The sizes of these fields (except 'leaf') depend on the following two
macros.  By changing these two values, the sizes of the fields in the
code item ancillary word can all be changed.

CCODE_NONGC_BITS	: how many bits in the 'non_gcs' field.
CCODE_NUMBER_BITS	: how many bits in the 'number' field.

*/

#include "mach_values.h"

/* macros for extracting the fields, and for constructing an ancillary
word:

   CCODEANCILL(p)	is the ancillary field of the code item.
   CCODENUMBER(p)	is the code number field (a C integer)
   CCODENONGC(p)	is the number of non-gc values field (a C integer)
   CCODEARGS(p)		is the number of stacked parameters on function entry
                        (a C integer)
   CCODESAVES(p)	is the callee saves field (a C integer)
   CCODELEAF(p)		is the leaf field (1 or 0)
   CCODEINTERCEPT(p)	is the intercept field (a C integer)

   CCODE_CAN_INTERCEPT(p) is a predicate: is there an intercept slot?

   CCODE_MAKE_ANCILL(saves,non_gcs,leaf,intercept,stack_params,no) makes an ancillary word.
*/

#define CCODEANCILL(p)	   (((struct code_item_header *)OBJECT(p))->ancill)
#define CCODENUMBER(p)	  (CCODEANCILL(p) & CCODE_MAX_NUMBER)
#define CCODENONGC(p)	  (CCODEANCILL(p) >> CCODE_NONGC_SHIFT)
#define CCODEARGS(p)	  ((CCODEANCILL(p) >> CCODE_ARGS_SHIFT) & CCODE_MAX_ARGS)
#define CCODESAVES(p)	  ((CCODEANCILL(p) >> CCODE_SAVES_SHIFT) & CCODE_MAX_SAVES)
#define CCODELEAF(p)	  ((CCODEANCILL(p) >> CCODE_LEAF_BIT) & 1u)
#define CCODEINTERCEPT(p) ((CCODEANCILL(p) >> CCODE_INTERCEPT_SHIFT) \
			   & CCODE_INTERCEPT_MASK)

#define CCODE_CAN_INTERCEPT(p) (CCODEINTERCEPT(p) != CCODE_NO_INTERCEPT)

#define CCODE_MAKE_ANCILL(saves, non_gcs,leaf,intercept,stack_params,no)	\
   ((((non_gcs) & CCODE_MAX_NONGC) << CCODE_NONGC_SHIFT)  |		\
    (((stack_params)   & CCODE_MAX_ARGS) << CCODE_ARGS_SHIFT) |		\
    (((saves) & CCODE_MAX_SAVES) << CCODE_SAVES_SHIFT)     |		\
    (((leaf) != 0) << CCODE_LEAF_BIT)                      |		\
    (((intercept) & CCODE_INTERCEPT_MASK) << CCODE_INTERCEPT_SHIFT) |	\
    ((no) & CCODE_MAX_NUMBER))

/* These macros allow one to obtain items from the ancillary record:
 * 
 * CCODEANCRECORD (p,label) returns the ancillary record labelled 'label'.
 * CCODEANCVALUE (p,label) returns the ancillary value labelled 'label'.
 *
 * CCODENAME(p) returns the code name (an ML string)
 * CCODEPROFILE(p) returns the profile record (a C pointer)
 * CCODE_SET_PROFILE(p,v) sets the profile record to v
 * CCODEINTERFN(p) returns the intercept function (an ML closure)
 * CCODE_SET_INTERFN(p,v) sets the intercept function to v
 * CCODESTART(p) is the address of the first instruction of code item p.
 *
 */

#define CCODEANCRECORD(p,label)	(FIELD(CCODEANCILLARY(p),	\
				       ANC_ ## label))
#define CCODEANCVALUE(p,label)	(FIELD(CCODEANCRECORD(p,label),	\
				       CCODENUMBER(p)))

#define CCODENAME(p)		CCODEANCVALUE(p,NAMES)
#define CCODEPROFILE(p)		CCODEANCVALUE(p,PROFILES)

#define CCODE_SET_PROFILE(p,v)	(CCODEANCVALUE(p,PROFILES) = v)

#define CCODEINTERFN(p)		(MLSUB(CCODEANCRECORD(p,INTERFNS),	\
				       CCODENUMBER(p)))
#define CCODE_SET_INTERFN(p,v)	(MLUPDATE(CCODEANCRECORD(p,INTERFNS),	\
					  CCODENUMBER(p), v))

#define CCODESTART(p)		(((struct code_item_header *)OBJECT(p))->instruction)

/*  == Arrays and bytearrays ==
 *
 *  CARRAY(r)      returns a pointer to the word array
 *  CBYTEARRAY(r)  returns a pointer to a byte array
 */

#define ARRAYHEADER(r)	(*(mlval *)((r)-REFPTR))
#define CARRAY(r)     	((word *)((r)-REFPTR+12))
#define CBYTEARRAY(r) 	((byte *)((r)+1))

/*  == Records and tuples ==
 *
 *  Note: These are only defined for values with tag POINTER or
 *        PAIRPTR.
 *
 *  NFIELDS(r)       return the number of fields in a record
 *  GETHEADER(r)     fetches the header word from a record, or makes one
 *                   of length 2 for pairs
 *  FIELD(r,i)	     the value at position i within a record (an lvalue)
 */

#define NFIELDS(r) ((PRIMARY(r) == PAIRPTR) ? 2 : LENGTH(*(mlval *)((r)-POINTER)))
#define GETHEADER(r) (PRIMARY(r) == PAIRPTR ? MAKEHEAD(RECORD, 2) : *(mlval *)((r)-POINTER))
#define FIELD(r,i)	(((mlval *)((r) - 1))[i])


/*  == Word32 values ==
 *
 *  Word32 are unsigned 32-bit natural numbers, represented as strings.
 */

#define CWORD32(v)  ((word *)CSTRING(v))
#define CINT32(v)   ((int *)CSTRING(v))


/*  == Booleans ==
 *
 *  False is represented by the integer 0, true by 1.
 */

#define MLFALSE MLINT(0)
#define MLTRUE  MLINT(1)

#define MLBOOL(x) ((x) ? MLTRUE : MLFALSE)
#define CBOOL(x) ((x) == MLTRUE)

/*  == Unit ==
 *
 *  Unit is represented by the integer 0.
 */

#define MLUNIT MLINT(0)



/*  == Lists ==
 *
 *  nil is represented by the integer 1, and x::y is represented by a
 *  record {x, y} (was {0, {x, y}} )
 *
 *  MLNIL        the value representing nil
 *  MLISNIL(x)   true iff the list x is nil
 *  MLHEAD(x)    the head of the list x, defined iff x is not nil
 *  MLTAIL(x)    the tail of the list x, defined iff x is not nil
 *
 */

#define MLNIL        MLINT(1)
#define MLISNIL(x)   ((x) == MLNIL)
#define MLHEAD(x)    FIELD(x, 0)
#define MLTAIL(x)    FIELD(x, 1)


/* Given two ML values x and y, constructs the list
 * x::y.  This (obviously) allocates and so you'll need to declare
 * either or both of head and tail as a root if you want to use 
 * them after the ml_cons call.
 */
mlval mlw_cons(mlval head, mlval tail);


/* A deprecated inteface to cons.  Here until all the old
 * code that uses cons directly is updated to call mlw_cons.
 */
#define cons(h, t) mlw_cons(h, t)





/*  == Arrays ==
 *
 *  MLSUB(a,x)       extract element x of array a
 *  MLUPDATE(a,x,y)  update element x of array a with y
 */

extern void mlw_update(mlval, word, mlval);
#define MLSUB(a,x)      (((union ml_array_header *)((a)-REFPTR))->the.element[x])
#define MLUPDATE(a,x,y) mlw_update(a,x,y)



/* == Refs ==
 *
 *   mlw_ref_make(v)      construct a reference to v.
 *   mlw_ref_value(r)     extract the value that the reference r refers to.
 *   mlw_ref_update(r, v) update the reference r so that it contains v.
 *
 * Note that mlw_ref_make allocates, so you will need to declare/retract
 * roots as necessary to take account of this.
 *
 * Implementation
 * --------------
 * 
 * References are implemented as one element arrays.
 */

extern mlval mlw_ref_make(mlval);
#define mlw_ref_value(r)     MLSUB(r, 0)
#define mlw_ref_update(r, v) mlw_update(r, 0, v)


/*
 * The above replaces and extends the following deprecated routines :-
 *
 *  MLDEREF(r)	     extract the value in ref cell r
 *  ref(x)	     create a ref cell containing x
 *
 */
#define ref(v)     mlw_ref_make(v)
#define MLDEREF(r) mlw_ref_value(r)





/*  == Reals ==
 *
 *  At the moment only one size (double) is supported.  A real is
 *  written into a string, and it indistinguishable from some strings.
 *  The macro MLISREAL tests whether it is _possible_ that it's a
 *  real, it might be a random bytearray.
 *    MLISREAL(s)   could bytearray s contain a real?
 *    SETREAL(s,r)  stores the double r in the bytearray s, returns s
 *    GETREAL(s)    retrieves a double from a bytearray
 */

#define MLISREAL(s)  (LENGTH(GETHEADER(s)) == 12)
#define SETREAL(s,r) (*(double *)(CSTRING(s)+4) = (r), s)
#define GETREAL(s)   (*(double *)(CSTRING(s)+4))

/*  == Integers ==
 *
 *  ML integers are 30 bits. Define ML_MAX_INT and ML_MIN_INT accordingly:
 */

#define ML_INT_BITS  (30)
#define ML_MAX_INT   ((1<<(ML_INT_BITS-1)) - 1)
#define ML_MIN_INT   (-(1<<(ML_INT_BITS-1)))

/*  == 32 bit integers
 *
 *  These are essentially C compatible integers
 */

#define ML_INT32_BITS  (32)
#define ML_MAX_INT32   ((int)0x7fffffff)
#define ML_MIN_INT32   ((int)0x80000000)

/*  == Exceptions ==
 *
 *  PACKET_NAME(p)    extracts the exception name from the packet p
 *  PACKET_CONTENT(p) extracts the exception argument from the packet p
 *  exn_name(n)     creates an exception name from a C string
 *  exn(n, a)       creates an exception packet from a name and an argument
 */

#define PACKET_NAME(p)		CSTRING(FIELD(FIELD(p, 0),1))
#define PACKET_CONTENT(p)	FIELD(p, 1)

extern mlval exn_name(const char *name);
extern mlval exn(mlval exn_name, mlval argument);



/* Some wrappers to abstract away the details of the Option type. */

#define mlw_option_make_none() MLINT(0)
#define mlw_option_is_none(opt) (opt == MLINT(0))
#define mlw_option_some(opt) FIELD(opt, 1)

/* Construct the equivalent of SOME arg.
 * This (obviously) allocates and so you'll need to declare
 * arg as a root if you need to access it after the call
 * to some.
 */
extern mlval mlw_option_make_some(mlval arg);


#endif
