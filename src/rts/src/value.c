/*  ==== PERVASIVE VALUES ====
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
 *  $Log: value.c,v $
 *  Revision 1.11  1998/02/23 18:42:35  jont
 *  [Bug #70018]
 *  Modify declare_root to accept a second parameter
 *  indicating whether the root is live for image save
 *
 * Revision 1.10  1997/03/27  12:49:26  andreww
 * [Bug #1989]
 * removing exn_name_string.
 *
 * Revision 1.9  1997/02/28  14:28:35  matthew
 * Adding null termination of string in real_to_string
 *
 * Revision 1.8  1997/02/10  14:06:28  matthew
 * Reverse bytes in string_to_real
 *
 * Revision 1.7  1996/05/28  11:25:55  daveb
 * value_print no longer takes a stream argument.  It always uses std_out.
 *
 * Revision 1.6  1996/02/14  17:31:56  jont
 * ISPTR becomes MLVALISPTR
 *
 * Revision 1.5  1994/12/08  13:50:57  matthew
 * Added code to reverse bytes of a real on I386
 *
 * Revision 1.4  1994/10/19  15:22:45  nickb
 * \\nThe method of declaring functions to be non-returning has changed.
 *
 * Revision 1.3  1994/06/29  14:55:16  jont
 * Fix non returning non-void functions
 *
 * Revision 1.2  1994/06/09  14:54:28  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:30:46  nickh
 * new file
 *
 *  Revision 1.4  1993/04/19  14:34:39  richard
 *  Changed val_print() for new value printer.
 *
 *  Revision 1.3  1993/02/01  16:04:31  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.2  1992/12/24  12:47:10  clive
 *  Changed to error messages to avoid overflowing the buffer in exn_raise_format
 *
 *  Revision 1.1  1992/11/05  16:39:20  richard
 *  Initial revision
 *
 */

#include <string.h>

#include "value.h"
#include "mltypes.h"
#include "values.h"
#include "gc.h"
#include "exceptions.h"
#include "environment.h"
#include "allocator.h"
#include "print.h"
#include "utils.h"

/* ml_eq_function is set to 1 if two non-equal function values are
 * compared with polymorphic equality */

int ml_eq_function = 0;

mlval values_root1, values_root2;

static mlval cast(mlval x)
{
  return(x);
}

static mlval ml_exn_name(mlval packet)
{
  if(PRIMARY(packet) == PAIRPTR)
  {
    mlval name = FIELD(packet, 0);

    if(PRIMARY(name) == PAIRPTR)
    {
      mlval ref = FIELD(name, 0);
      mlval string = FIELD(name, 1);

      if(PRIMARY(ref) == REFPTR && PRIMARY(string) == POINTER)
      {
	mlval ref_header = ARRAYHEADER(ref);

	if(SECONDARY(ref_header) == ARRAY &&
	   LENGTH(ref_header) == 1 &&
	   SECONDARY(GETHEADER(string)) == STRING)
	  return(string);
      }
    }
  }

  exn_raise_string(perv_exn_ref_value, "Value is not an exn");
  return MLUNIT; /* NOT REACHED */
}

static mlval exn_argument(mlval packet)
{
  if(PRIMARY(packet) == PAIRPTR)
  {
    mlval name = FIELD(packet, 0);

    if(PRIMARY(name) == PAIRPTR)
    {
      mlval ref = FIELD(name, 0);
      mlval string = FIELD(name, 1);

      if(PRIMARY(ref) == REFPTR && PRIMARY(string) == POINTER)
      {
	mlval ref_header = ARRAYHEADER(ref);

	if(SECONDARY(ref_header) == ARRAY &&
	   LENGTH(ref_header) == 1 &&
	   SECONDARY(GETHEADER(string)) == STRING)
	  return(FIELD(packet, 1));
      }
    }
  }

  exn_raise_string(perv_exn_ref_value, "Value is not an exn");
  return MLUNIT; /* NOT REACHED */
}


static mlval primary(mlval value)
{
  return(MLINT(PRIMARY(value)));
}

static mlval header(mlval value)
{
  mlval header, result;

  switch(PRIMARY(value))
  {
    case POINTER:
    header = GETHEADER(value);
    break;

    case REFPTR:
    header = ARRAYHEADER(value);
    break;

    default:
    exn_raise_string(perv_exn_ref_value, "Value has no header");
    return MLUNIT; /* NOT REACHED */
  }

  result = allocate_record(2);
  FIELD(result, 0) = MLINT(SECONDARY(header));
  FIELD(result, 1) = MLINT(LENGTH(header));

  return(result);
}

static mlval pointer(mlval argument)
{
  mlval primary = CINT(FIELD(argument, 1));

  if(PRIMARY(primary) != primary)
    exn_raise_string(perv_exn_ref_value, "Illegal primary tag");

  return(MLPTR(primary, OBJECT(FIELD(argument, 0))));
}

static mlval update_value(mlval argument)
{
  mlval *object = OBJECT(FIELD(argument, 0));
  mlval offset = CINT(FIELD(argument, 1));
  mlval value = FIELD(argument, 2);

  object[offset] = value;

  return(MLUNIT);
}

static mlval sub_value(mlval argument)
{
  mlval *object = OBJECT(FIELD(argument, 0));
  mlval offset = CINT(FIELD(argument, 1));

  return(object[offset]);
}

static mlval update_byte(mlval argument)
{
  byte *object = (byte *)OBJECT(FIELD(argument, 0));
  mlval offset = CINT(FIELD(argument, 1));
  byte b = CINT(FIELD(argument, 2));

  object[offset] = b;

  return(MLUNIT);
}

static mlval sub_byte(mlval argument)
{
  byte *object = (byte *)OBJECT(FIELD(argument, 0));
  mlval offset = CINT(FIELD(argument, 1));

  return(MLINT(object[offset]));
}

static mlval update_header(mlval argument)
{
  mlval *object = OBJECT(FIELD(argument, 0));
  int secondary = CINT(FIELD(argument, 1));
  size_t length = CINT(FIELD(argument, 2));


  if(SECONDARY(secondary) == secondary)
  {
    object[0] = MAKEHEAD(secondary, length);
    return(MLUNIT);
  }

  exn_raise_string(perv_exn_ref_value, "Illegal secondary tag");
  return MLUNIT; /* NOT REACHED */
}

static mlval value_print(mlval argument)
{
  struct print_options print_options, *pop = NULL;

  /*        datatype print_options =
              DEFAULT |
              OPTIONS of {depth_max	  	: int,
                          string_length_max	: int,
                          indent		: bool,
                          tags		  	: bool}   */

  if(MLVALISPTR(FIELD(argument, 0)))
  {
    mlval options = FIELD(FIELD(argument, 0), 1);

    print_options.depth_max = CINT(FIELD(options, 0));
    print_options.string_length_max = CINT(FIELD(options, 2));
    print_options.indent = FIELD(options, 1) == MLTRUE;
    print_options.tags = FIELD(options, 3) == MLTRUE;
    pop = &print_options;
  }

  print(pop, stdout, FIELD(argument, 1));

  return(MLUNIT);
}

static mlval list_to_tuple(mlval argument)
{
  mlval result;
  size_t length;
  mlval list;

  values_root1 = argument;

  length = 0;
  for(list=values_root1; list!=MLNIL; list=MLTAIL(list))
    ++length;

  result = allocate_record(length);
  
  length = 0;
  for(list=values_root1; list!=MLNIL; list=MLTAIL(list))
  {
    FIELD(result, length) = MLHEAD(list);
    ++length;
  }

  values_root1 = MLUNIT;

  return(result);
}

static mlval tuple_to_list(mlval arg)
{
  size_t length = LENGTH(GETHEADER(arg));
  mlval list;

  values_root1 = arg;
  values_root2 = MLNIL;

  while(length--)
    values_root2 = cons(FIELD(values_root1, length), values_root2);

  list = values_root2;
  values_root1 = values_root2 = MLUNIT;

  return(list);
}

static mlval string_to_real(mlval arg)
{
  mlval real;
  double r;

  if(CSTRINGLENGTH(arg) != sizeof(double))
    exn_raise_string(perv_exn_ref_value, "String is the wrong length to become a real");

  memcpy(&r, CSTRING(arg), sizeof(double));

  /* REVERSE_REAL_BYTES defined in mach_values.h for I386 */
  #ifdef REVERSE_REAL_BYTES
  {
    char *bottom = (char *)&r;
    char *top = bottom + sizeof(double) - 1;
    while (top > bottom)
      {
	char t = *bottom;
	*bottom = *top;
	*top = t;
	bottom++;
	top--;
      }
  }
  #endif

  real = allocate_real();
  (void)SETREAL(real, r);

  return(real);
}

static mlval real_to_string(mlval arg)
{
  double r = GETREAL(arg);
  mlval string = allocate_string(sizeof(double)+1);

  memcpy(CSTRING(string), &r, sizeof(double));

  /* REVERSE_REAL_BYTES defined in mach_values.h for I386 */
  #ifdef REVERSE_REAL_BYTES
  {
    char *bottom = CSTRING (string);
    char *top = bottom + sizeof(double) - 1;
    while (top > bottom)
      {
	char t = *bottom;
	*bottom = *top;
	*top = t;
	bottom++;
	top--;
      }
  }
  #endif

  /* and null terminate */

  *(CSTRING(string)+sizeof(double)) = '\000';
  return(string);
}

static mlval code_name(mlval argument)
{
  return(CCODENAME(argument));
}

extern void poly_equal_error (mlval left, mlval right)
{
  error ("Polymorphic equality found bad values when comparing 0x%X and 0x%X.",
	 left, right);
}

#ifdef MACH_POLY_EQ

#include "mach.h"

#else /* MACH_POLY_EQ */

/* A C version of polymorphic equality, for ease of porting */

#define TRUE 1
#define FALSE 0

static int c_poly_equal (mlval left, mlval right)
{
  if (left == right)		/* eq implies equality */
    return TRUE;
  else {
    word primary = PRIMARY(left);
    if (primary != PRIMARY(right)) /* primaries unequal implies inequality */
      return FALSE;
    else
      switch (primary) {
      case INTEGER0:		/* equal integers must be eq */
      case INTEGER1:
      case REFPTR:		/* equal ref ptrs must be eq */

	return FALSE;
	break;

      case PAIRPTR:		/* recurse */
	return (c_poly_equal (FIELD(left,0), FIELD(right,0)) &&
		c_poly_equal (FIELD(left,1), FIELD(right,1)));
	break;

      case POINTER:
	{
	  word header = GETHEADER(left);
	  if (header != GETHEADER(right)) /* headers unequal implies =/= */
	    return FALSE;

	  switch (SECONDARY(header)) {
	  case RECORD: {	/* iterate along the record, ...*/
	    size_t i, length = LENGTH(header);
	    for (i=0; i<length; i++)
	      if (!c_poly_equal (FIELD(left,i), FIELD(right,i)))
		return FALSE;	/* ... recursing */
	    return TRUE;
	    break;
	  }
	  case STRING: {	/* we don't care about speed */
	    size_t length = LENGTH(header);
	    if (memcmp(CSTRING(left),CSTRING(right),length) == 0)
	      return TRUE;
	    else
	      return FALSE;
	    break;
	  }
	    
	  case BYTEARRAY:		/* must be a real */
	    return (GETREAL(left) == GETREAL(right));
	    break;
	    
	  case CODE:		/* must be eq */
	  case WEAKARRAY:	/* must be eq */
	    return FALSE;
	    break;
	    
	  case BACKPTR:		/* must be eq; set a warning flag */
	    ml_eq_function = 1;
	    return FALSE;
	    break;
	    
	  case ARRAY:		/* arrays should have REFPTR primaries */
	  case HEADER50:	/* shouldn't exist */
	  default:
	    poly_equal_error(left,right);
	  }
	  
	case HEADER:		/* not a value */
	case PRIMARY6:		/* not a value */
	case PRIMARY7:		/* not a value */
	default:
	  poly_equal_error(left,right);
	}
      }
  }
  return 0; /* NOT REACHED */
}

static mlval poly_equal(mlval arg)
{
  mlval left = FIELD(arg,0);
  mlval right = FIELD(arg,1);

  if (c_poly_equal (left,right))
    return MLTRUE;
  else
    return MLFALSE;
}

static mlval poly_not_equal(mlval arg)
{
  mlval left = FIELD(arg,0);
  mlval right = FIELD(arg,1);

  if (c_poly_equal (left,right))
    return MLFALSE;
  else
    return MLTRUE;
}

#endif /* MACH_POLY_EQ */

void value_init()
{
  values_root1 = values_root2 = MLUNIT;
  declare_root(&values_root1, 0);
  declare_root(&values_root2, 0);

  ml_eq_function = 0;

  env_function("value cast", cast);
  env_function("value list to tuple", list_to_tuple);
  env_function("value tuple to list", tuple_to_list);
  env_function("value string to real", string_to_real);
  env_function("value real to string", real_to_string);
  env_function("value primary", primary);
  env_function("value header", header);
  env_function("value pointer", pointer);
  env_function("value update value", update_value);
  env_function("value sub value", sub_value);
  env_function("value update byte", update_byte);
  env_function("value sub byte", sub_byte);
  env_function("value update header", update_header);
  env_function("value exn name", ml_exn_name);
  env_function("value exn argument", exn_argument);
  env_function("value print", value_print);
  env_function("value code name", code_name);

#ifdef MACH_POLY_EQ
  env_asm_function("polymorphic equality", poly_equal);
  env_asm_function("polymorphic inequality", poly_not_equal);
#else /* MACH_POLY_EQ */
  env_function("polymorphic equality", poly_equal);
  env_function("polymorphic inequality", poly_not_equal);
#endif /* MACH_POLY_EQ */
}
