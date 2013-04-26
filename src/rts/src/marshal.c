/*  ==== MARSHALLING ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: marshal.c,v $
 *  Revision 1.3  1996/02/13 17:20:35  jont
 *  Add some type casts to allow compilation without warnings under VC++
 *
 * Revision 1.2  1994/06/09  14:42:31  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:10:27  nickh
 * new file
 *
 *  Revision 1.2  1993/06/02  13:05:50  richard
 *  Added extra parentheses around conditionals as suggested by GCC 2.
 *
 *  Revision 1.1  1992/10/29  12:59:35  richard
 *  Initial revision
 *
 */

#include <stdarg.h>
#include <stddef.h>
#include <errno.h>

#include "marshal.h"


static char *marshal_long(char *out, unsigned long int i)
{
  while(i & ~0x7Fu)
  {
    *out++ = (char)((i & 0x7F) | 0x80);
    i >>= 7;
  }

  *out++ = (char)i;

  return(out);
}

static char *unmarshal_long(char *in, unsigned long int *ip)
{
  char c;
  unsigned long int i = 0;
  int shift = 0;

  do
  {
    c = *in++;
    i |= (c & 0x7F) << shift;
    shift += 7;
  }
  while(c & ~0x7F);

  *ip = i;
  return(in);
}

char *marshal(char *out, const char *desc, ...)
{
  va_list arg;
  char code;

  va_start(arg, desc);

  while((code = *desc++))
    switch(code)
    {
      /* Characters are encoded as themselves. */

      case 'c':
      *out++ = va_arg(arg, int);
      break;

      /* Integers are encoded in 7-bit chunks with the eighth bit indicating */
      /* that there is another chunk to come. */

      case 's':
      out = marshal_long(out, (unsigned long int)va_arg(arg, unsigned short int));
      break;

      case 'i':
      out = marshal_long(out, (unsigned long int)va_arg(arg, unsigned int));
      break;

      case 'l':
      out = marshal_long(out, (unsigned long int)va_arg(arg, unsigned long int));
      break;

      default:
      errno = EMARSHALDESC;
      return(NULL);
    }

  va_end(arg);

  return(out);
}

char *unmarshal(char *in, const char *desc, ...)
{
  va_list arg;
  char code;

  va_start(arg, desc);

  while((code = *desc++))
    switch(code)
    {
      /* Characters are encoded as themselves. */

      case 'c':
      *va_arg(arg, char *) = *in++;
      break;

      /* Integers are encoded in 7-bit chunks with the eighth bit indicating */
      /* that there is another chunk to come. */

      case 's':
      {
	unsigned long int l;
	in = unmarshal_long(in, &l);
	*va_arg(arg, unsigned short int *) = (unsigned short int)l;
      }
      break;

      case 'i':
      {
	unsigned long int l;
	in = unmarshal_long(in, &l);
	*va_arg(arg, unsigned int *) = (unsigned int)l;
      }
      break;

      case 'l':
      {
	unsigned long int l;
	in = unmarshal_long(in, &l);
	*va_arg(arg, unsigned long int *) = l;
      }
      break;

      default:
      errno = EMARSHALDESC;
      return(NULL);
    }

  va_end(arg);

  return(in);
}

