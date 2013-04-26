/*  === TOP LEVEL OF RUNTIME SYSTEM ===
 *
 *  Copyright (C) 1996 Harlequin Ltd.
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
