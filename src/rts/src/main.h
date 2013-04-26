/*  === TOP LEVEL OF RUNTIME SYSTEM ===
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
 *  This file contains the main() function, which parses the command
 *  line, loads and invokes the modules, etc.
 *
 *  Revision Log
 *  ------------
 *  $Log: main.h,v $
 *  Revision 1.3  1995/09/26 10:40:15  jont
 *  Add runtime to record the current executable
 *  for the benefit of executable image saving
 *
 * Revision 1.2  1994/06/09  14:42:10  nickh
 * new file
 *
 * Revision 1.1  1994/06/09  11:10:01  nickh
 * new file
 *
 *  Revision 1.6  1993/09/07  11:02:33  daveb
 *  Added -mono option.
 *
 *  Revision 1.5  1992/10/02  09:27:17  richard
 *  Added missing consts.
 *
 *  Revision 1.4  1992/09/01  11:25:48  richard
 *  Implemented argument passing to the modules.
 *
 *  Revision 1.3  1992/08/26  15:46:19  richard
 *  The module table is now a pervasive value.
 *
 *  Revision 1.2  1992/08/19  07:06:10  richard
 *  Added modules as an export.
 *
 *  Revision 1.1  1992/07/23  11:48:35  richard
 *  Initial revision
 *
 */

#ifndef main_h
#define main_h

extern mlval image_continuation;

extern int module_argc;		/* arguments to be passed to ML */
extern const char *const *module_argv;

extern int mono;		/* running on a mono screen? */

extern int main(int argc, const char *const *argv);

extern const char *runtime; /* The executable we started from */

#endif
