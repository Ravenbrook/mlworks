/*  ==== FI EXAMPLES : Regular expression parser ====
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
 *  This module in C provides foreign functions to parse regular expressions.
 *
 *  Revision Log
 *  ------------
 *  $Log: regexp.c,v $
 *  Revision 1.2  1996/10/24 15:06:10  io
 *  [Bug #1547]
 *  fiddle with this
 *
 * Revision 1.1  1996/08/30  11:06:24  davids
 * new unit
 *
 *
 */

/* The following defines are used in the regexp.h included file below
 * Do not alter position
 */
#define INIT        register char *sp = instring;
#define GETC()      (*sp++)
#define PEEKC()     (*sp)
#define UNGETC(c)   (--sp)
#define RETURN(p)   return p
#define ERROR(c)    regerrno = c
#define ESIZE 1000

int regerrno;

#include <stdio.h>
#include <errno.h>
#include <regexp.h>
#include <malloc.h>

int regexp_search (char *string, char *regexp_string)
{
  char *expbuf;
  int result;
  extern int get_error(void);

  if ((expbuf=(char *)malloc (ESIZE)) == 0)
    perror ("malloc died due to ");

    
  if ((compile (regexp_string, expbuf, &expbuf[ESIZE], '\0')) == 0)
    get_error ();
  
  result = step (string, expbuf);
  free (expbuf);

  return result;
}

int get_error (void)
{
  return regerrno;
}

char *get_rest ()
{
  return loc1;
}

char *get_match (void)
{
  char *match_string;
  int size, i;

  size = loc2 - loc1;
  if ((match_string = (char *) malloc (size + 1)) == 0)
    perror ("malloc died due to ");


  for (i=0; i<size; i++)
    match_string [i] = loc1 [i];
    
  match_string [size] = '\0';

  return match_string;
}
