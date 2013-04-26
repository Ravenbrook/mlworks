/*  ==== RUNTIME VALUE PRINTER ====
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
 *  Implementation
 *  --------------
 *  The value printer is table-driven as far as possible.  This makes is
 *  nicely maintainable and extensible.  DON'T test for tags explicitly if
 *  you can possibly help it.
 *
 *  Revision Log
 *  ------------
 *  $Log: print.c,v $
 *  Revision 1.9  1997/06/03 12:54:15  jont
 *  [Bug #30076]
 *  Modify to make NONGC spills be counted in words
 *
 * Revision 1.8  1997/05/20  18:35:39  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.7  1996/02/14  15:07:46  jont
 * Changing ERROR to MLERROR
 *
 * Revision 1.6  1996/02/13  17:28:00  jont
 * Add some type casts to allow compilation without warnings under VC++
 *
 * Revision 1.5  1995/03/28  12:57:54  nickb
 * Add printing on the message stream.
 *
 * Revision 1.4  1994/06/23  13:38:04  nickh
 * Looks up CCODEINTERFN without checking it's valid.
 *
 * Revision 1.3  1994/06/21  16:00:18  nickh
 * New ancillary structure.
 *
 * Revision 1.2  1994/06/09  14:45:19  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:14:37  nickh
 * new file
 *
 *  Revision 1.2  1994/01/28  17:23:27  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.1  1993/04/21  13:01:28  richard
 *  Initial revision
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>

#include "ansi.h"
#include "print.h"
#include "mltypes.h"
#include "values.h"
#include "tags.h"
#include "extensions.h"
#include "utils.h"


struct print_options print_defaults = {0, 0, 0, 0};

static FILE *print_stream;
static int print_message_stream;

void print_a_bit(const char *string, ...);

void print_a_bit(const char *string, ...)
{
  va_list arg;
  va_start (arg,string);
  if (print_message_stream)
    vmessage_content(string,arg);
  else
    vfprintf(print_stream,string,arg);
  va_end(arg);
}

void p(struct print_options *options, int depth, int indent_next, mlval value);

static inline void indent(int depth)
{
  print_a_bit("\n");
  depth *= 2;
  while(depth--) print_a_bit(" ");
}

static void p_record(struct print_options *options,
		     int depth,
		     mlval value,
		     mlval primary,
		     mlval header,
		     mlval secondary)
{
  size_t i, length = LENGTH(header);

  if(options->tags && options->indent) indent(depth);
  print_a_bit("{");
  for(i=0; i<length; ++i)
  {
    if(i) print_a_bit(", ");
    p(options, depth+1, 1, FIELD(value, i));
  }
  if(options->indent) indent(depth);
  print_a_bit("}");
}

static void p_substring(const char *s, size_t length)
{
  while(length--)
  {
    char c = *s++;
    if(c == '"') print_a_bit("\\\"");
    else if(c == '\\') print_a_bit("\\\\");
    else if(c >= 21 && c < 127) print_a_bit("%c",c);
    else if(c == '\n') print_a_bit("\\n");
    else if(c == '\t') print_a_bit("\\t");
    else if((unsigned char)c <= 26) print_a_bit("\\^%c", c+64);
    else print_a_bit("\\%03u", (unsigned char)c);
  }
}

static void p_string(struct print_options *options,
		     int depth,
		     mlval value,
		     mlval primary,
		     mlval header,
		     mlval secondary)
{
  size_t length = LENGTH(header)-1;
  const char *s = CSTRING(value);

  print_a_bit("\"");
  if(options->string_length_max &&
     length > options->string_length_max)
  {
    p_substring(s, options->string_length_max);
    print_a_bit("...");
  }
  else
    p_substring(s, length);
  print_a_bit("\"");
}

static void p_array(struct print_options *options,
		    int depth,
		    mlval value,
		    mlval primary,
		    mlval header,
		    mlval secondary)
{
  size_t i, length = LENGTH(header);
  if(options->tags && options->indent) indent(depth);
  print_a_bit("[");
  for(i=0; i<length; ++i)
  {
    if(i) print_a_bit(", ");
    p(options, depth+1, 1, MLSUB(value, i));
  }
  if(options->indent) indent(depth);
  print_a_bit("]");
}

static void p_bytearray(struct print_options *options,
			int depth,
			mlval value,
			mlval primary,
			mlval header,
			mlval secondary)
{
  size_t i, length = LENGTH(header);
  unsigned char *bytes =
    primary == POINTER ?
      (unsigned char *)CSTRING(value) : CBYTEARRAY(value);

  if(options->tags && options->indent) indent(depth);
  print_a_bit("byte[");
  for(i=0; i<length; ++i)
  {
    if(i) print_a_bit(", ");
    if(options->indent && i%16 == 0) indent(depth+1);
    print_a_bit("%02X", bytes[i]);
  }
  if(options->indent) indent(depth);
  print_a_bit("]byte");
}

static void p_backptr(struct print_options *options,
		      int depth,
		      mlval value,
		      mlval primary,
		      mlval header,
		      mlval secondary)
{
  if(options->tags)
    print_a_bit("code %d of 0x%X ancillary 0x%X",
		CCODENUMBER(value), FOLLOWBACK(value), CCODEANCILLARY(value));

  if(options->tags && options->indent) indent(depth);
  print_a_bit("code{");
  if(options->indent) indent(depth+1);
  print_a_bit("name = ");
  p(options, depth+2, 0, CCODENAME(value));
  print_a_bit(", ");
  if(options->indent) indent(depth+1);
  print_a_bit("non_gc spills = %u words, leaf = %u, profile = %ux, intercept = %u, ",
	  CCODENONGC(value), CCODELEAF(value), CCODEPROFILE(value),
	  CCODEINTERCEPT(value));
  if (CCODE_CAN_INTERCEPT(value)) {
    if(options->indent) indent(depth+1);
    print_a_bit("interfn = ");
    p(options, depth+2, 0, CCODEINTERFN(value));
  }
  if(options->indent) indent(depth);
  print_a_bit("}code");
}

static void p_code(struct print_options *options,
		   int depth,
		   mlval value,
		   mlval primary,
		   mlval header,
		   mlval secondary)
{
  print_a_bit("code vector printer not implemented");
}

static void p_illegal_secondary(struct print_options *options,
				int depth,
				mlval value,
				mlval primary,
				mlval header,
				mlval secondary)
{
  print_a_bit("illegal");
}

static struct
{
  const char *name;
  void (*printer)(struct print_options *options,
		  int depth,
		  mlval value,
		  mlval primary,
		  mlval header,
		  mlval secondary);
} secondaries[64] =
{
  {NULL,	NULL},		{NULL,	NULL},
  {"RECORD",	p_record},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"STRING",	p_string},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"ARRAY",	p_array},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"BYTEARRAY", p_bytearray},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"BACKPTR",   p_backptr},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"CODE",      p_code},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"HEADER50",  p_illegal_secondary},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {"WEAKARRAY", p_array},	{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL},
  {NULL,	NULL},		{NULL,	NULL}
};


static void p_int(struct print_options *options,
		  int depth,
		  mlval value,
		  mlval primary)
{
  print_a_bit("%d", CINT(value));
}

static void p_header(struct print_options *options,
		     int depth,
		     mlval value,
		     mlval primary)
{
  print_a_bit("for %s length %u",
	  secondaries[SECONDARY(value)].name,
	  LENGTH(value));
}

static void p_illegal(struct print_options *options,
		      int depth,
		      mlval value,
		      mlval primary)
{
  print_a_bit("illegal");
}

static void p_pair(struct print_options *options,
		   int depth,
		   mlval value,
		   mlval primary)
{
  if(options->tags && options->indent) indent(depth);
  print_a_bit("{");
  p(options, depth+1, 1, FIELD(value, 0));
  print_a_bit(", ");
  p(options, depth+1, 1, FIELD(value, 1));
  if(options->indent) indent(depth);
  print_a_bit("}");
}

static void p_pointer(struct print_options *options,
		      int depth,
		      mlval value,
		      mlval primary)
{
  mlval header = GETHEADER(value), secondary = SECONDARY(header);
  const char *name = secondaries[secondary].name;

  if(name)
  {
    if(options->tags)
      print_a_bit("0x%X %s ", header, name);

    (*secondaries[secondary].printer)(options, depth, value,
				      primary, header, secondary);
  }
  else
    print_a_bit("0x%X bad secondary %d", header, secondary);
}

static void p_ref(struct print_options *options,
		  int depth,
		  mlval value,
		  mlval primary)
{
  mlval header = ARRAYHEADER(value), secondary = SECONDARY(header);

  const char *name = secondaries[secondary].name;

  if(name)
  {
    if(options->tags)
      print_a_bit("0x%X %s ", header, name);

    (*secondaries[secondary].printer)(options, depth, value,
				      primary, header, secondary);
  }
  else
    print_a_bit("0x%X bad secondary %d", header, secondary);
}

static struct
{
  const char *name;
  void (*printer)(struct print_options *options,
		  int depth,
		  mlval value,
		  mlval primary);
} primaries[8] =
{
  {"INTEGER0", p_int},
  {"PAIRPTR",  p_pair},
  {"HEADER",   p_header},
  {"REFPTR",   p_ref},
  {"INTEGER1", p_int},
  {"POINTER",  p_pointer},
  {"PRIMARY6", p_illegal},
  {"PRIMARY7", p_illegal}
};


static struct
{
  mlval value;
  const char *name;
} specials[] =
{
  {MLERROR, "ERROR"},
  {EVACUATED, "EVACUATED"},
  {DEAD, "DEAD"}
};


void p(struct print_options *options,
       int depth, int indent_next, mlval value)
{
  mlval primary = PRIMARY(value);
  int i;

  if(indent_next && options->indent) indent(depth);
  if(options->tags)
    print_a_bit("<0x%X %s ", value, primaries[primary].name);

  if(options->depth_max && (unsigned)depth > options->depth_max)
    print_a_bit("...");
  else
  {
    for(i=0; i<sizeof(specials)/sizeof(specials)[0]; ++i)
      if(value == specials[i].value)
      {
	print_a_bit(specials[i].name);
	goto special;
      }

    (*primaries[primary].printer)(options, depth, value, primary);

    special:;
  }

  if(options->tags) print_a_bit(">");
}

void print(struct print_options *options, FILE *stream, mlval value)
{
  print_stream = stream;
  print_message_stream = 0;
  p(options ? options : &print_defaults, 0, 0, value);
}

void message_print(struct print_options *options, mlval value)
{
  print_stream = NULL;
  print_message_stream = 1;
  p(options ? options : &print_defaults, 0, 0, value);
}
