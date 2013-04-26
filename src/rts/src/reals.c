/*  ==== PERVASIVE REALS ====
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
 *  $Log: reals.c,v $
 *  Revision 1.29  1998/10/08 13:03:18  jont
 *  [Bug #70189]
 *  Fix inadequacies in strtod when dealing with ~0.0
 *
 * Revision 1.28  1998/04/23  11:36:51  jont
 * [Bug #30397]
 * Make fmt test for nan before inf,
 * as the inf test will also detect nans under NT
 *
 * Revision 1.27  1998/04/21  09:27:08  mitchell
 * [Bug #30336]
 * Stop adding .0 when using GEN format
 *
 * Revision 1.26  1998/02/23  18:30:50  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.25  1998/02/05  16:40:55  jont
 * [Bug #70039]
 * Fix problem in copying for negative zeroes
 *
 * Revision 1.24  1998/02/05  14:51:22  jont
 * [Bug #70039]
 * Call function to check for negative zeroes where necessary
 *
 * Revision 1.23  1997/10/09  17:42:21  daveb
 * [Bug #30276]
 * The format function now sets the terminating null correctly when
 * removing the plus sign.
 * It also checks for illegal precision values.
 *
 * Revision 1.22  1997/10/09  10:29:20  jont
 * [Bug #30279]
 * Fix problems with pow involving infinities under linux
 *
 * Revision 1.21  1997/03/25  17:36:23  jont
 * [Bug #0]
 * Fix missing include of ctype.h
 *
 * Revision 1.20  1997/03/25  12:26:05  jont
 * Ensure relevant number of significant digits are printed
 * for reals following the E
 *
 * Revision 1.19  1997/02/28  13:00:50  matthew
 * Updating for exact integer conversion
 *
 * Revision 1.18  1996/10/17  14:04:56  jont
 * Merging in license server stuff
 *
 * Revision 1.17.2.2  1996/10/08  16:43:43  nickb
 * in_ml_fpe stuff goes.
 *
 * Revision 1.17.2.1  1996/10/07  16:15:09  hope
 * branched from 1.17
 *
 * Revision 1.17  1996/07/24  14:44:10  jont
 * Add include of syscalls.h
 *
 * Revision 1.16  1996/07/24  12:39:03  jont
 * Replace is_nan by library call isnan
 *
 * Revision 1.15  1996/07/23  09:50:12  jont
 * [Bug #1489]
 * Fix problems where some OSes incorrectly return -Inf for ln(negative number)
 *
 * Revision 1.14  1996/07/05  16:14:05  jont
 * Fix missing declare and retract root stuff
 *
 * Revision 1.13  1996/05/22  13:25:09  matthew
 * Adding precision to real printing.
 *
 * Revision 1.12  1996/05/20  12:43:53  matthew
 * Adding pow and atan2 functions
 *
 * Revision 1.11  1996/05/13  10:38:55  matthew
 * Renaming variable near since this is a keyword for many PC compilers
 *
 * Revision 1.10  1996/05/10  15:33:15  matthew
 * Fixing problem with removal of + sign in printed output
 *
 * Revision 1.9  1996/05/10  09:35:51  matthew
 * Extending for new basis
 *
 * Revision 1.8  1996/04/29  12:14:29  matthew
 * Improving printing of nans etc.
 *
 * Revision 1.7  1996/04/19  11:15:26  matthew
 * Changing exceptions
 *
 * Revision 1.6  1995/03/15  16:47:35  nickb
 * record expected exception, so signal handler can raise it.
 *
 * Revision 1.5  1994/11/08  17:17:37  matthew
 * Adding sqrt function for use by MIPS
 *
 * Revision 1.4  1994/06/29  14:25:06  jont
 * Remove floatingpoint.h and fix lack of return from non-void
 *
 * Revision 1.3  1994/06/14  14:41:38  jont
 * Add critical region support for FP signals
 *
 * Revision 1.2  1994/06/09  14:35:19  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:01:15  nickh
 * new file
 *
 *  Revision 1.9  1994/01/18  12:22:35  daveb
 *  Removed case from fpe_handler.
 *
 *  Revision 1.8  1993/11/18  13:29:47  daveb
 *  Minor correction to exception raising code in fpe_handler.
 *  Probably not important..
 *
 *  Revision 1.7  1993/06/02  13:08:10  richard
 *  Removed erroneous prototype for sscanf().
 *
 *  Revision 1.6  1993/01/06  11:19:58  richard
 *  Removed redundant operations.
 *  Added floating point exception handling to deal with all remaining
 *  Infinities and NaNs.
 *
 *  Revision 1.5  1993/01/04  12:25:49  richard
 *  Removed some experimental code that I had checked in by mistake.
 *
 *  Revision 1.4  1992/12/21  16:07:54  matthew
 *  Changed real printing precision to 16.  This is about as much as we can get.
 *
 *  Revision 1.3  1992/12/16  10:34:17  richard
 *  Conversion from reals to strings now uses strtod() which can detect
 *  range errors as well as format errors.
 *
 *  Revision 1.2  1992/12/08  12:21:55  richard
 *  Improved the printing of real numbers.  Numbers are printed to
 *  a greater precision and Infinity and NaN do not have `.0' appended.
 *
 *  Revision 1.1  1992/10/23  16:30:05  richard
 *  Initial revision
 *
 */

#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <ctype.h>

#include "reals.h"
#include "dtoa.h"
#include "os.h"
#include "gc.h"
#include "mltypes.h"
#include "values.h"
#include "exceptions.h"
#include "environment.h"
#include "allocator.h"
#include "diagnostic.h"
#include "interface.h"
#include "utils.h"
#include "syscalls.h"
#include "localreals.h"

static mlval root = MLUNIT;
static mlval root1 = MLUNIT;

static mlval ml_pow (mlval argument)
{
  double field0 = GETREAL(FIELD (argument,0));
  double field1 = GETREAL(FIELD (argument,1));
  mlval r = allocate_real();
  double result;
  if (localpower(field0, field1, &result)) {
    (void)SETREAL(r, result);
  } else {
    (void)SETREAL(r, pow (field0, field1));
  }
  return(r);
}

static mlval ml_arctan(mlval argument)
{
  double arg = GETREAL(argument);
  mlval r = allocate_real();
  (void)SETREAL(r, atan(arg));
  return(r);
}

static mlval ml_atan2(mlval argument)
{
  double field0 = GETREAL(FIELD (argument,0));
  double field1 = GETREAL(FIELD (argument,1));
  mlval r = allocate_real();
  (void)SETREAL(r, atan2(field0, field1));
  return(r);
}

static mlval ml_cos(mlval argument)
{
  double arg = GETREAL(argument);
  mlval r = allocate_real();
  (void)SETREAL(r, cos(arg));
  return(r);
}

static mlval ml_sin(mlval argument)
{
  double arg = GETREAL(argument);
  mlval r = allocate_real();
  (void)SETREAL(r, sin(arg));
  return(r);
}

static mlval ml_exp(mlval argument)
{
  double arg = GETREAL(argument);
  mlval r = allocate_real();
  (void)SETREAL(r, exp(arg));
  return(r);
}

static mlval do_sqrt(double arg)
{
  mlval r = allocate_real();
  (void)SETREAL(r, sqrt(arg));
  return(r);
}

static mlval ml_ln(mlval argument)
{
  double arg = GETREAL(argument);
  if (arg < 0.0) {
    return(do_sqrt(-1.0));
  } else {
    mlval r = allocate_real();
    (void)SETREAL(r, log(arg));
    /* Note, can't this raise an exception? */
    return(r);
  }
}

static mlval ml_sqrt(mlval argument)
{
  double arg = GETREAL(argument);
  return(do_sqrt(arg));
}

static int is_infinity (double x)
{
  return ((x != 0.0) && (x + x == x));
}

static mlval to_string(mlval arg)
{
  char buffer[40];
  size_t length;
  mlval string;

  double x = GETREAL (FIELD (arg,0));
  int prec = CINT (FIELD (arg,1));

  if (isnan(x))
    strcpy (buffer,"nan");
  else 
    if (is_infinity (x))
      if (x > 0.0) 
	strcpy (buffer,"inf");
      else strcpy (buffer,"~inf");
    else
      {
	size_t i, plus = 0;
	int point = 0;
	    
	sprintf(buffer, "%.*G", prec, x);

	length = strlen(buffer);

	for(i=0; i<length; ++i)
	  {
	    char c = buffer[i];

	    if(c == '-')
	      buffer[i] = '~';
	    else if(c == '.' || c == 'E')
	      point = 1;
	    else if(c == '+')
	      plus = i;
	  }
  
	if(plus)
	  {
	    for(i=plus; i<length; ++i)
	      buffer[i] = buffer[i+1];
	    length--;
	    
	  }
	
	if(!point)
	  {
	    buffer[length++] = '.';
	    buffer[length++] = '0';
	    buffer[length] = '\0';
	  }
      }

  length = strlen (buffer);
  string = allocate_string(length+1);
  strcpy(CSTRING(string), buffer);

 return(string);
}

static mlval decimal_rep (mlval arg)
{
  int dec;
  int sign;
  char * digits;
  mlval result;
  digits = dtoa (GETREAL(arg),0,100,&dec,&sign,NULL);
  root = allocate_string (strlen(digits) + 1);
  strcpy (CSTRING(root),digits);
  freedtoa (digits);
  result = allocate_record (3);
  FIELD (result,0) = root;
  FIELD (result,1) = MLINT (dec);
  FIELD (result,2) = sign ? MLTRUE : MLFALSE;
  return (result);
}

/* First arg of fmt is of datatype
   EXACT | SCI of int option | FIX of int option | GEN of int option
*/

/* The relevant tags */
#define EXACT_FORMAT 0
#define FIX_FORMAT 1
#define GEN_FORMAT 2
#define SCI_FORMAT 3

#define MAX_DIGITS 10

static mlval fmt (mlval arg)
{
  char buffer[40];
  size_t length;
  mlval string;
  mlval format = FIELD (arg, 0);
  double x = GETREAL (FIELD (arg,1));
  int prec = 0;
  /* Check the precision first */
  if (format != EXACT_FORMAT) {
    int format_type = CINT (FIELD (format, 0));
    int min_prec = 0;

    /* Minimum precision is 0 for SCI and FIX, 1 for GEN. */
    if (format_type == GEN_FORMAT) 
      min_prec = 1;

    if (FIELD (format,1) == MLINT (0)) {
      /* Argument is NONE => Default precision. */
      prec = -1;
    } else {
      prec = CINT (FIELD (FIELD (format,1),1));
      if (prec < min_prec)
        exn_raise(perv_exn_ref_size);
    }
  }

  if (isnan (x))
    strcpy (buffer,"nan");
  else
    if (is_infinity (x))
      if (x > 0.0) 
	strcpy (buffer,"+inf");
      else strcpy (buffer,"-inf");
    else
      if (format == EXACT_FORMAT) { /* EXACT conversion required */
	/* Note that this doesn't do the right thing with NaN's, but */
	/* this should be taken care of on the ML side of things */
	int dec;
	int sign;
	char * ptr = buffer;
	char * digits = dtoa (x,0,100,&dec,&sign,NULL);
	char * dptr = digits;
	if (sign)
	  *ptr++ = '~';
	*ptr++ = '0';
	*ptr++ = '.';
	/* Don't copy null byte here */
	while (*dptr)
	  *ptr++=*dptr++;
	if (dec != 0){
	  *ptr++ = 'E';
	  if (dec < 0) {
	    dec = -dec;
	    *ptr++ = '~';
	  }
	  /* Now add the exponent */
	  sprintf (ptr,"%d",dec);
	  ptr += strlen (ptr);
	}
	*ptr++ = '\000';
	freedtoa (digits);
      } else {
	/* Now we have to decipher the format */
	size_t i, plus = 0;
	int point = 0;
	int format_type = CINT (FIELD (format,0));

	if (format_type == FIX_FORMAT) /* FIX */
	  sprintf (buffer, "%.*f", prec < 0 ? 6 : prec, x);
	else if (format_type == GEN_FORMAT) /* GEN */
	  sprintf (buffer, "%.*G", prec < 0 ? 12 : prec,x);
	else if (format_type == SCI_FORMAT) /* SCI */
	  sprintf (buffer, "%.*E", prec < 0 ? 6 : prec, x);
	else sprintf(buffer, "%.18G", x);

	length = strlen(buffer);

	/* Now check for correct printing of negative zeroes */
	if (x == 0.0) {
	  switch (check_neg_zero(&x)) {
	  case 2: /* -0.0 */
	    /* May need to modify the output here */
	    if (*buffer != '-') {
	      /* Yes, we do need to modify */
	      if (*buffer == '+') {
		*buffer = '-';
	      } else {
		for (i = length+1; i > 0; i--) {
		  buffer[i] = buffer[i-1]; /* Move the characters along the buffer */
		};
		length++;
		*buffer = '-';
	      }
	    }
	  case 0: /* Not actually 0.0 at all */
	  case 1: /* +0.0 */
	  default: /* This shouldn't happen */
	    /* No action required here */
	    break;
	  }
	}

	for(i=0; i<length; ++i) {
	  char c = buffer[i];

	  if(c == '-')
	    buffer[i] = '~';
	  else if(c == '.' || c == 'E')
	    point = i;
	  else if(c == '+')
	    plus = i;
	}

	/* Win32 screws up G format by printing too many digits */
	/* in the exponent. So we contract that part if necessary */

	if (point && buffer[point] == 'E') {
	  char c = buffer[point+1];
	  if (c == '+' || c == '~') point++;
	  if (buffer[point+1] == '0' &&
	      isdigit(buffer[point+2]) &&
	      isdigit(buffer[point+3])) {
	    buffer[point+1] = buffer[point+2];
	    buffer[point+2] = buffer[point+3];
	    buffer[point+3] = '\0';
	  }
	}

	if(plus) {
	  for(i=plus; i<length; ++i)
	    buffer[i] = buffer[i+1];
	  length--;
	}
	
	if(!point && (format_type != GEN_FORMAT)
                  && !(format_type == FIX_FORMAT && prec == 0)) {
	  buffer[length++] = '.';
	  buffer[length++] = '0';
	  buffer[length] = '\0';
	}
      }

  length = strlen (buffer);
  string = allocate_string(length+1);
  strcpy(CSTRING(string), buffer);

  return(string);
}

static mlval from_string(mlval arg)
{
  double result;
  unsigned int length = CSTRINGLENGTH(arg)+1, i;
  char *original = CSTRING(arg);
  char *buffer = alloc(length, "Couldn't allocate buffer in ml_scan_real"), *end;
  int negative = 0;
  for (i=0; i<length; ++i) {
    if (!(isspace(original[i]))) {
      if (original[i] == '~') {
	original += i+1;
	negative = 1;
	length -= i+1;
      }
      break;
    }
  }
  for(i=0; i<length; ++i)
    switch(original[i])
    {
      case '~':
      buffer[i] = '-';
      break;

      case 'e': case '+':
      exn_raise(perv_exn_ref_string_to_real);

      default:
      buffer[i] = original[i];
    }

  errno = 0;
  result = strtod(buffer, &end);
  if (negative) result = -result;
  if(*end == '\0' && errno == 0)
  {
    mlval real = allocate_real();

    free(buffer);
    (void)SETREAL(real, result);
    return(real);
  }

  free(buffer);
  exn_raise(perv_exn_ref_string_to_real);
  return MLUNIT; /* NOT REACHED */
}


static mlval from_exp (mlval arg)
{
  double x = GETREAL(arg);
  int exp;
  double man;
  mlval result;

  man = frexp (x,&exp);
  root = allocate_real();
  SETREAL (root,man);
  result = allocate_record (2);
  FIELD (result,0) = MLINT (exp);
  FIELD (result,1) = root;
  root = MLUNIT;
  return (result);
}

static mlval load_exp (mlval arg)
{
  int exp = CINT (FIELD (arg,0));
  double man = GETREAL (FIELD (arg,1));
  mlval result = allocate_real();
  SETREAL (result,ldexp (man,exp));
  return (result);
}

static mlval split (mlval arg)
{
  double x = GETREAL(arg);
  double intpart;
  double fracpart = modf (x,&intpart);
  mlval result;

  root = allocate_real();
  SETREAL (root,fracpart);

  root1 = allocate_real();
  SETREAL (root1,intpart);

  result = allocate_record (2);

  FIELD (result,0) = root;
  FIELD (result,1) = root1;

  root = MLUNIT;
  root1 = MLUNIT;
  return (result);
  
}

#define MINLARGE (1<<31)
#define MAXLARGE (~(MINLARGE))

static int checklarge (double x)
{
  if (x > MAXLARGE || x < MINLARGE)
    exn_raise(perv_exn_ref_overflow);
  return ((int)x);
}

/* copied from basis/__prereal */
static double myround (double x)
{
  double new = floor (x);
  double diff = new - x;

  if (diff < 0.0)
    diff = -diff;

  if (diff < 0.5)
    return (new);
  else
    /* gee, what happens if the cast to int fails? */
    if ((diff > 0.5) || ((int)new % 2) == 1)
      return (new + 1.0);
    else return (new);
}

static double myceil (double x)
{
  return (- (floor (-x)));
}

static double mytrunc (double x)
{
  if (x >= 0)
    return (floor (x));
  else
    return (myceil (x));
}

/* mode is TO_NEAREST, TO_NEGINF, TO_POSINF,TO_ZERO */
static mlval to_large_int (mlval arg)
{
  int mode = CINT (FIELD (arg,0));
  double x = GETREAL (FIELD (arg,1));
  int n;
  mlval result = allocate_word32 ();
  switch (mode)
    {
    case (0):
      n = checklarge(myround (x));
      break;
    case (1):
      n = checklarge(floor (x));
      break;
    case (2):
      n = checklarge(myceil (x));
      break;
    case (3):
      n = checklarge(mytrunc (x));
      break;
    default:
      n = -1;
    }
  *CWORD32(result)=n;
  return result;
}

static mlval from_large_int (mlval arg)
{
  int n = (int)*CWORD32(arg);
  mlval result = allocate_real ();
  SETREAL (result,(double)n);
  return (result);
}

/* mode is TO_NEAREST, TO_NEGINF, TO_POSINF,TO_ZERO */
static mlval set_rounding_mode (mlval arg)
{
  int mode;
  switch (CINT (arg))
    {
    case 0:
      mode = 0;
      break;
    case 1:
      mode = 3;
      break;
    case 2:
      mode = 2;
      break;
    case 3:
      mode = 1;
      break;
    default:
      mode = -1;
    }
  os_set_rounding_mode (mode);
  return (MLUNIT);
}

static mlval get_rounding_mode (mlval arg)
{
  int mode;
  switch (os_get_rounding_mode ())
    {
    case 0:
      mode = 0;
      break;
    case 1:
      mode = 3;
      break;
    case 2:
      mode = 2;
      break;
    case 3:
      mode = 1;
      break;
    default:
      mode = -1;
    }
  return (MLINT(mode));
}

void reals_init()
{
  env_function("real arctan", ml_arctan);
  env_function("real atan2", ml_atan2);
  env_function("real cos", ml_cos);
  env_function("real exp", ml_exp);
  env_function("real ln", ml_ln);
  env_function("real sin", ml_sin);
  env_function("real square root", ml_sqrt);
  env_function("real pow", ml_pow);
  env_function("real to string", to_string);
  env_function("real fmt", fmt);
  env_function("real from string", from_string);
  env_function("real decimal rep", decimal_rep);
  env_function("real from exp", from_exp);
  env_function("real load exp", load_exp);
  env_function("real split", split);
  env_function("real from large int", from_large_int);
  env_function("real to large int", to_large_int);
  env_function("real set rounding mode", set_rounding_mode);
  env_function("real get rounding mode", get_rounding_mode);
  declare_root(&root, 0);
  declare_root(&root1, 0);
}
