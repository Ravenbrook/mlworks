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
 *  This file is simply a stub to load the runtime DLL and call it, passing
 *  it the runtime arguments.
 *
 *  Revision Log
 *  ------------
 *  $Log: main_stub.c,v $
 *  Revision 1.1  1998/01/28 14:36:43  jont
 *  new unit
 *  The windows version has become system specific, so main_stub has to move into OS
 *  It has to provide WinMain
 *
 * Revision 1.1  1997/05/22  11:20:21  andreww
 * new unit
 * [Bug #30045]
 * Small piece of C to act as a workaround rts that calls the runtime DLL.
 *
 *
 *
 */

#include <windows.h>   /* required for all Windows applications */
#include "mltypes.h"
#include "values.h"
#include "main_stub.h"
#include "mlw_dll.h"
#ifndef RUNTIME_DLL
#define RUNTIME_DLL 1
#endif
#include "window.h"

mlval image_continuation = MLUNIT;

int module_argc = 0;
const char *const *module_argv = NULL;

int mono = 0;
const char *runtime;

/* I guess if we do want to pass the instance information to the functions */
/* above, we could put it in appropriate global variables */

int WINAPI WinMain(HINSTANCE hinst,
		   HINSTANCE previnstance, 
		   LPSTR cmdline,
		   int showstate)
{
  return Mlwdll_WinMain(hinst, previnstance, cmdline, showstate);
}

int main(int argc, const char *const *argv)
{
  return mlw_main(argc,argv);
}
