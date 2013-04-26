/*  ==== C WORD OPERATORS ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Implementation
 *  --------------
 *  Word values are unsigned natural numbers of some determined fixed size
 *  (in bits).
 *  
 *  This file contains multiplication, division and modulus operations on
 *  words of 30 and 32 bits, and conversion operations on 32-bit words.
 *  
 *  30-bit words are stored in integer values.  32-bit words are stored
 *  in string values (they are represented in 2's complement, not characters!).
 *  
 *  Revision Log
 *  ------------
 *  $Log: words.c,v $
 *  Revision 1.16  1997/04/10 13:56:03  andreww
 *  [Bug #2043]
 *  adding comment to check_int30 routine.
 *
 * Revision 1.15  1996/05/16  15:42:31  brianm
 * Returning check_int30 to previous state ...
 *
 * Revision 1.14  1996/05/16  14:37:10  brianm
 * Minor modification to check_int30 - correction for negative nums.
 *
 * Revision 1.13  1996/05/13  13:03:37  matthew
 * Adding real to word conversions
 *
 * Revision 1.12  1996/05/07  13:01:31  matthew
 * Updating for revised basis
 *
 * Revision 1.11  1995/09/15  10:49:22  daveb
 * I forgot to allow for the leading "0w" when calculating the maximum string
 * size in word32_to_string.
 *
 * Revision 1.10  1995/09/13  16:13:27  daveb
 * Fixing typo.
 *
 * Revision 1.8  1995/09/09  13:14:58  brianm
 * Added new functions for conversion between word32 and bytearrays.
 *
 * Revision 1.7  1995/09/07  12:13:54  jont
 * Modify word mod and div to return Div for division by zero rather
 * than Overflow
 *
 * Revision 1.6  1995/07/27  13:16:52  jont
 * Fixes to default word operations to treat arguments as unsigned
 *
 * Revision 1.5  1995/07/24  10:07:28  daveb
 * Fixed warning messages.
 *
 * Revision 1.4  1995/07/20  16:49:19  jont
 * Add default sized word functions for /, div and mod
 *
 * Revision 1.3  1995/04/03  12:31:01  brianm
 * Adding num_to_word32() word32_to_num().
 * Updating to use allocate_word32() and CWORD32().
 * Made code more GC-safe by moving allocation to end of functions.
 *
 * Revision 1.2  1995/03/22  16:55:29  brianm
 * Changing Word32 repn. to immutable byte vectors (i.e. strings).
 *
 * Revision 1.1  1995/03/16  18:35:41  brianm
 * new unit
 * New file.
 *
 * */

#include "mltypes.h"
#include "alloc.h"
#include "allocator.h"
#include "values.h"
#include "diagnostic.h"
#include "environment.h"
#include "exceptions.h"
#include "words.h"


/* Local defines */

#define bit(a)                (1u << (a))
#define bitblk(hi,lo)         (bit(hi) | (bit(hi) - bit(lo)))
#define appmask(x,m)          ((x) & (m))

#define raise_overflow   \
	exn_raise(perv_exn_ref_overflow)

static unsigned check_int30(unsigned argument)
{
   /* the following test makes sure that the top three bits of the
    * word are 0.  The top two take account of the bits required
    * for tagging. Bit 29 is the sign bit. We want this value to
    * be 0 too because we're not converting two's-bit negative numbers
    * into negative integers: just bit patterns into an integer.   Hence
    * overflow if bit 29 is set.  Note that since the argument
    * is unsigned it doesn't make sense to do a simple comparison
    * with ML_MAX_INT and ML_MIN_INT.
    */
   if (appmask(argument,bitblk(31,29)) != 0)  raise_overflow;
   return(argument);
}


/* External Functions */

extern void num_to_word32(unsigned num, mlval word32)
{
   unsigned *object;

   object = (unsigned *)CWORD32(word32);
   *object = num;
}

extern unsigned word32_to_num(mlval word32)
{
   unsigned *object;

   object = (unsigned *)CWORD32(word32);
   return(*object);
}


/* Functions exported to ML */

static mlval word32_to_int(mlval argument)
{  
   unsigned item;
   mlval result;

   item = word32_to_num(argument);
   result = MLINT(check_int30(item)); 
   return(result);
}

static mlval word32_to_word(mlval argument)
{  
   unsigned item;
   mlval result;

   item = word32_to_num(argument);
   result = MLINT(item); 
   return(result);
}

static mlval extend_int_to_word32(mlval argument)
{
   unsigned item;

   mlval result;

   item = (unsigned)CINT(argument);

   result = allocate_word32();
   num_to_word32(item,result);

   return(result);
}

static mlval int_to_word32(mlval argument)
{
   unsigned item;

   mlval result;

   item = (unsigned)CWORD(argument);

   result = allocate_word32();
   num_to_word32(item,result);

   return(result);
}

static mlval word32_to_bytearray(mlval argument)
{  
   unsigned item, *content;
   mlval result;

   item   = word32_to_num(argument);

   result = allocate_bytearray(4);

   content  = (unsigned *)CBYTEARRAY(result);
   *content = item;

   return(result);
}

static mlval bytearray_to_word32(mlval argument)
{  unsigned item, *content;

   mlval result;

   content = (unsigned *)CBYTEARRAY(argument);
   item = *content;

   result = allocate_word32();
   num_to_word32(item,result);

   return(result);
}

static mlval word32_to_string(mlval argument)
{  
   word *item;
   char *str;
   mlval result;

   /* The maximum value of a Word32 is 2^32-1 = 4294967295.  This is 10
      characters.  Add 1 for the trailing null, and 2 for the leading 0w. */
   str = (char *) malloc (13);

   item = CWORD32(argument);
   sprintf(str, "0w%lu", (unsigned long) *item);

   result = ml_string (str);
   free (str);

   return(result);
}

static mlval word32_times(mlval argument)
{  unsigned val, *val1, *val2;
   mlval result;

   val1 = (unsigned *)CWORD32(FIELD(argument,0));
   val2 = (unsigned *)CWORD32(FIELD(argument,1));

   val = (*val1 * *val2);

   result = allocate_word32();
   num_to_word32(val,result);

   return(result);
}

static mlval word32_div(mlval argument)
{  unsigned val, *val1, *val2;
   mlval result;

   val1 = (unsigned *)CWORD32(FIELD(argument,0));
   val2 = (unsigned *)CWORD32(FIELD(argument,1));

   if (*val2 == 0u) exn_raise(perv_exn_ref_div);

   val = (*val1 / *val2);

   result = allocate_word32();
   num_to_word32(val,result);

   return(result);
}


static mlval word32_mod(mlval argument)
{  unsigned val, *val1, *val2;
   mlval result;

   val1 = (unsigned *)CWORD32(FIELD(argument,0));
   val2 = (unsigned *)CWORD32(FIELD(argument,1));

   if (*val2 == 0u) exn_raise(perv_exn_ref_div);

   val = (*val1 % *val2);

   result = allocate_word32();
   num_to_word32(val,result);

   return(result);
}


static mlval word_times(mlval argument)
{
  unsigned val1 = CWORD(FIELD(argument, 0));
  unsigned val2 = CWORD(FIELD(argument, 1));
  return MLINT(val1 * val2);
}

static mlval word_div(mlval argument)
{
  unsigned val1 = CWORD(FIELD(argument, 0));
  unsigned val2 = CWORD(FIELD(argument, 1));
  if (val2 == 0u) exn_raise(perv_exn_ref_div);
  return MLINT(val1 / val2);
}

static mlval word_mod(mlval argument)
{
  unsigned val1 = CWORD(FIELD(argument, 0));
  unsigned val2 = CWORD(FIELD(argument, 1));
  if (val2 == 0u) exn_raise(perv_exn_ref_div);
  return MLINT(val1 % val2);
}

/* Convert between reals and words */

static mlval word_to_real (mlval argument)
{
  double x = (double)(CWORD (argument));
  mlval result = allocate_real ();
  SETREAL (result,x);
  return (result);
}

static mlval word32_to_real (mlval argument)
{
  double x = (double)*CWORD32 (argument);
  mlval result = allocate_real ();
  SETREAL (result,x);
  return (result);
}

/* These only need to work for whole reals */
static mlval real_to_word (mlval argument)
{
  unsigned n = (unsigned)GETREAL (argument);
  return MLINT (n);
}

static mlval real_to_word32 (mlval argument)
{
  unsigned int n = (unsigned int)GETREAL (argument);
  mlval result = allocate_word32();

  num_to_word32(n,result);

  return (result);
}

extern void words_init(void)
{
  env_function("word32 word to int",  word32_to_int);
  env_function("word32 extend int to word32",  extend_int_to_word32);
  env_function("word32 int to word32",  int_to_word32);
  env_function("word32 word32 to word",  word32_to_word);
  env_function("word32 word to string",	 word32_to_string);

  env_function("word word to real",	 word_to_real);
  env_function("word word32 to real",	 word32_to_real);

  env_function("word real to word",	 real_to_word);
  env_function("word real to word32",	 real_to_word32);

  env_function("word32 word to bytearray",  word32_to_bytearray);
  env_function("word32 bytearray to word",  bytearray_to_word32);

  env_function("word32 div",    word32_div);
  env_function("word32 mod",    word32_mod);
  env_function("word32 times",  word32_times);

  env_function("word multiply", word_times);
  env_function("word divide",   word_div);
  env_function("word modulus",  word_mod);
}
