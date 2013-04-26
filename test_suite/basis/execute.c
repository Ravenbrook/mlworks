/* A test program for the SML Basis Library.
 * This will test {Unix,Windows}.{simpleE,e}xecute
 *
 * Copyright (C) 1999 Harlequin Group plc.  All rights reserved.
 *
 * $Log: execute.c,v $
 * Revision 1.1  1999/03/18 12:04:00  daveb
 * new unit
 * Used by the win32/execute.sml test.
 *
 */

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

#define BUFFER_SIZE 256
char buffer[BUFFER_SIZE];

/* Note: we can't rely on stderr, so indicate errors
 * by the exit status.
 */
int main () {
  /* puts adds a newline */
  if (EOF == puts ("Initial output on stdout"))
    exit(1);
  fflush (stdout);

  if (NULL == fgets (buffer, BUFFER_SIZE, stdin))
    exit(2);
  /* fgets copies the newline, unless it reads
     exactly BUFFER_SIZE-1 characters. */
  buffer[BUFFER_SIZE - 1] = '\n';
  /* Use printf to avoid an extra newline, and
     to cope with non-constant argument */
  if (printf ("%s", buffer) < 0)
    exit(3);

  /* fputs doesn't add a newline */
  if (EOF == fputs ("Final output on stderr\n", stderr))
    exit(4);

  /* Return a particular non-zero number, so that we
   * can test the return type.  This number must fit
   * in 8 bits for Unix.
   */
  exit(78);
}

