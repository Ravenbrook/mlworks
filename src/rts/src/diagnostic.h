/*  === DIAGNOSTIC OUTPUT ===
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
 *  This header provides a macro which can be used in a program to
 *  provide diagnostic output to stderr with different levels of
 *  priority.  Output at level 0 is always displayed, but other levels
 *  are only output if the external unsigned int diagnostic_level is
 *  not less than that level.  In the MLWorks runtime system the
 *  diagnostic_level is set by the `-d' option on the command line.
 *
 *  NOTE:  The macro DIAGNOSTICS must be defined elsewhere (preferably as an
 *  argument to the compiler) in order to make the DIAGNOSTIC macro do
 *  anything.
 *
 *  $Id: diagnostic.h,v 1.4 1996/11/18 13:30:36 stephenb Exp $
 */


#ifndef diagnostic_h
#define diagnostic_h

extern unsigned int diagnostic_level;

#ifdef DIAGNOSTICS
#include "utils.h"
#define DIAGNOSTIC(level, format, p1, p2) \
do {					  \
  if ((level) <= diagnostic_level)	  \
    message_stderr(format, p1, p2);	  \
} while (0)

#else

#define DIAGNOSTIC(level, format, p1, p2)  \
do {                                       \
  /* do nothing */                         \
} while (0)

#endif

#endif
