/*  ==== COMMAND LINE OPTIONS PARSER ====
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
 *
 *  Revision Log
 *  ------------
 *  $Log: options.c,v $
 *  Revision 1.3  1996/02/14 10:12:47  jont
 *  Add a type cast to avoid compiler warnings under VC++
 *
 * Revision 1.2  1994/06/09  14:44:33  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:13:20  nickh
 * new file
 *
 *  Revision 1.6  1994/01/26  17:03:41  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.5  1993/06/02  13:06:37  richard
 *  Improved the use of const on the argv parameter type.
 *
 *  Revision 1.4  1993/06/01  15:39:36  richard
 *  Removed unused variable.
 *
 *  Revision 1.3  1993/04/30  12:36:40  richard
 *  Multiple arguments can now be passed to the storage manager in a general
 *  way.
 *
 *  Revision 1.2  1992/09/01  11:19:01  richard
 *  Implemented delimited options.
 *
 *  Revision 1.1  1992/03/18  14:07:38  richard
 *  Initial revision
 *
 */


#include "ansi.h"
#include "options.h"
#include "utils.h"

#include <string.h>
#include <errno.h>


int option_parse(int *argcp,
		 argv_t *argvp,
		 struct option *options[])
{
  /* While there are strings left in the command line array... */
  while(*argcp != 0)
  {
    const char *arg = (*argvp)[0];
    int argc = *argcp;
    argv_t argv = *argvp;
    size_t i;

    /* If the argument isn't an option then we're finished. */
    if(arg[0] != OPTION_CHAR)
      return(1);

    *argcp -= 1;
    *argvp += 1;

    /* If the argument is the special double-option character then we're */
    /* finished, and argv points to the next argument. */
    if(arg[1] == OPTION_CHAR && arg[2] == '\0')
      return(1);

    for(i=0; options[i]->name != NULL; ++i)
      if(strcmp(options[i]->name, arg+1) == 0)
      {
	size_t n = options[i]->nr_arguments;

	/* If the option count is negative then it's a variable length */
	/* argument list delimited by the next argument. */

	if(n == -1)
	{
	  const char *delimiter;

	  if(*argcp < 2)
	  {
	    errno = EOPTIONARGS;
	    *argcp = argc;
	    *argvp = argv;
	    return(0);
	  }

	  options[i]->arguments = *argvp+1;

	  delimiter = (*argvp)[0];
	  do
	  {
	    ++options[i]->nr_arguments;
	    *argcp -= 1;
	    *argvp += 1;

	    if(*argcp == 0)
	    {
	      errno = EOPTIONDELIM;
	      *argcp = argc;
	      *argvp = argv;
	      return(0);
	    }
	  }
	  while(strcmp((*argvp)[0], delimiter) != 0);

	  *argcp -= 1;
	  *argvp += 1;
	  options[i]->specified = 1;
	}
	else
	{
	  /* It's an ordinary argument list of length n. */

	  if((unsigned)*argcp < n)
	  {
	    errno = EOPTIONARGS;
	    *argcp = argc;
	    *argvp = argv;
	    return(0);
	  }

	  options[i]->specified = 1;
	  options[i]->arguments = *argvp;

	  *argcp -= n;
	  *argvp += n;
	}

	goto found;
      }

    errno = EOPTIONUNKNOWN;
    *argcp += 1;
    *argvp -= 1;
    return(0);

    found: continue;
  }

  return(1);
}


int to_int(const char *s)
{
  int n;
  char dummy;

  if(sscanf(s, " %d%c", &n, &dummy) != 1)
    error("`%s' is not a number.", s);

  return(n);
}


unsigned int to_unsigned(const char *s)
{
  unsigned int n;
  char dummy;

  if(sscanf(s, " %u%c", &n, &dummy) != 1)
    error("`%s' is not an unsigned number.", s);

  return(n);
}

