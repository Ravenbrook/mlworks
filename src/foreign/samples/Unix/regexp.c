/*  ==== FI EXAMPLES : Regular expression parser ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
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
