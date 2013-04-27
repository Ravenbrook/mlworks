/*  ==== PERVASIVE STREAMS ====
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
 *  The ML stream type is a pair record containing a FILE * and the `name'
 *  of the stream (usually the filename it was opened with).  A stream is
 *  marked as closed by setting the FILE * to NULL.
 *
 *  The std_in, std_out, and std_err streams visible from ML are global
 *  roots which are fixed up to point at the C stdin, stdout, and stderr
 *  streams, and so persist across images.  All other streams are kept on a
 *  weak list and splatted with NULL when an image is reloaded.
 *
 *  Revision Log
 *  ------------
 *  $Log: streams.c,v $
 *  Revision 1.11  1998/03/26 14:50:51  jont
 *  [Bug #30090]
 *  Remove MLWorks.IO based stuff
 *
 * Revision 1.10  1998/02/23  18:32:45  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.9  1997/05/09  13:39:17  jont
 * [Bug #30091]
 * Remove MLWorks.Internal.FileIO and related stuff
 *
 * Revision 1.8  1996/02/16  14:45:22  nickb
 * Change to declare_global().
 *
 * Revision 1.7  1996/02/13  17:36:41  jont
 * Add some type casts to allow compilation without warnings under VC++
 *
 * Revision 1.6  1996/01/11  17:28:32  nickb
 * Runtime error message buffer problem.
 *
 * Revision 1.5  1995/10/31  11:46:16  jont
 * Ensure write errors during flush and close are detected
 *
 * Revision 1.4  1995/01/13  14:58:53  jont
 * Change file opening to be binary mode
 *
 * Revision 1.3  1994/06/29  16:14:43  nickh
 * Add message stream functions.
 *
 * Revision 1.2  1994/06/09  14:52:52  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:28:21  nickh
 * new file
 *
 *  Revision 1.10  1994/01/28  17:39:42  nickh
 *  Moved extern function declarations to header files.
 *
 *  Revision 1.9  1993/11/18  10:55:54  nickh
 *  Add "stream closed" function to test closed-ness of a stream.
 *
 *  Revision 1.8  1993/11/16  17:38:42  nickh
 *  Added root declaration and retraction in open_in().
 *
 *  Revision 1.7  1993/10/12  16:14:15  matthew
 *  Merging bug fixes
 *
 *  Revision 1.6.1.2  1993/10/11  14:34:08  matthew
 *  Added call to fsync before closing a file
 *  Workaround for problem on Solbournes
 *
 *  Revision 1.6.1.1  1993/04/23  10:41:00  jont
 *  Fork for bug fixing
 *
 *  Revision 1.6  1993/04/23  10:41:00  jont
 *  Added a stream output byte function
 *
 *  Revision 1.5  1993/04/20  12:48:37  richard
 *  Replaced safe_exn_raise_format() with exn_raise_strings().
 *  Added several missing CSTRING() macros.
 *
 *  Revision 1.4  1993/03/31  17:04:53  jont
 *  Fixed output of filenames to be longer and to indicate when they are truncated
 *
 *  Revision 1.3  1993/02/01  16:13:16  richard
 *  Abolished SETFIELD and GETFIELD in favour of lvalue FIELD.
 *
 *  Revision 1.2  1992/12/24  12:47:59  clive
 *  Changed to error messages to avoid overflowing the buffer in exn_raise_format
 *
 *  Revision 1.1  1992/10/26  16:43:06  richard
 *  Initial revision
 *
 */

#include <stdio.h>
#include <string.h>

#include "streams.h"
#include "allocator.h"
#include "exceptions.h"
#include "utils.h"
#include "environment.h"

static mlval message_output(mlval arg)
{
  if (messager_function)
    messager_function(CSTRING(arg));
  else
    fputs(CSTRING(arg),stderr);
  return MLUNIT;
}

static mlval message_flush(mlval unit)
{
  if (messager_function) {
    if (message_flusher)
      message_flusher();
  } else if(fflush(stderr) == EOF)
    exn_raise_syserr(ml_string("Cannot flush message stream : error on stderr"), 0);
  return MLUNIT;
}

/*  === INITIALISE ===  */

void streams_init()
{
  env_function("stream message output",message_output);
  env_function("stream message flush",message_flush);
}
