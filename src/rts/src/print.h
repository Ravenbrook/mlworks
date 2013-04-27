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
 *  Description
 *  -----------
 *  The value printer uses runtime tagging information to print ML objects.
 *  This is a crucial tool for debugging.
 *
 *  Revision Log
 *  ------------
 *  $Log: print.h,v $
 *  Revision 1.3  1995/03/28 12:57:58  nickb
 *  Add printing on the message stream.
 *
 * Revision 1.2  1994/06/09  14:45:35  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:15:04  nickh
 * new file
 *
 *  Revision 1.1  1993/04/21  12:59:45  richard
 *  Initial revision
 *
 */

#ifndef print_h
#define print_h


#include "mltypes.h"

struct print_options
{
  size_t depth_max;		/* zero for no limit */
  size_t string_length_max;	/* zero for no limit */
  int indent;			/* indented layout */
  int tags;			/* show tagging information */
};

struct print_options print_defaults;

void print(struct print_options *options, FILE *stream, mlval value);

void message_print (struct print_options *options, mlval value);

#endif
