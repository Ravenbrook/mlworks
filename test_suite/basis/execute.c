/* A test program for the SML Basis Library.
 * This will test {Unix,Windows}.{simpleE,e}xecute
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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

