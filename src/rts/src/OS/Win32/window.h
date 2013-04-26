/* Externally visible part of winmain stuff
 *
 * $Log: window.h,v $
 * Revision 1.3  1998/06/17 12:08:59  johnh
 * [Bug #50083]
 * Convert from short name to long name.
 *
 * Revision 1.2  1998/01/28  14:13:38  jont
 * [Bug #20103]
 * Add a declaration for Mlwdll_WinMain to allow main_stub to get at the real WinMain
 *
 * Revision 1.1  1996/02/12  11:58:42  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/winmain.h
 * The preferred name for this would be windows.h but there is a Win32
 * header file called windows.h and so it is easier to change the
 * name of this file than fiddle with include file paths.
 *
 * Revision 1.1  1995/10/17  13:45:31  jont
 * new unit
 *
 * Revision 1.2  1995/03/14  14:06:26  jont
 * Add IDM_CHAR
 *
 * Revision 1.1  1995/02/22  16:01:05  jont
 * new unit
 * No reason given
 *
 *
 * Copyright (C) 1995 Harlequin Ltd
 *
 */

#include <windows.h>
#include "mltypes.h"

#define IDM_NEW            100
#define IDM_OPEN           101
#define IDM_SAVE           102
#define IDM_SAVEAS         103
#define IDM_PRINT          104
#define IDM_PRINTSETUP     105
#define IDM_EXIT           106
#define IDM_UNDO           200
#define IDM_CUT            201
#define IDM_COPY           202
#define IDM_PASTE          203
#define IDM_LINK           204
#define IDM_LINKS          205
#define IDM_LISTENER       300
#define IDM_EVALUATOR      301
#define IDM_FILETOOL       302
#define IDM_CONTEXT        303
#define IDM_INSPECTOR      304
#define IDM_EDITOR         350
#define IDM_MISC           351
#define IDM_MODE           360
#define IDM_VALUE          361
#define IDM_HELPCONTENTS   400
#define IDM_HELPSEARCH     401
#define IDM_HELPHELP       402
#define IDM_ABOUT          403

#define IDM_CHAR           500

#define DLG_VERFIRST        400
#define DLG_VERLAST         404



BOOL InitApplication(HANDLE);
/*BOOL InitInstance(HANDLE, int);*/
LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);
LRESULT CALLBACK About  (HWND, UINT, WPARAM, LPARAM);

extern mlval main_loop(mlval);
extern char* get_long_name(char*);

#ifdef RUNTIME_DLL
extern mlw_ci_export int WINAPI Mlwdll_WinMain(HINSTANCE hinst,
		   HINSTANCE previnstance, 
		   LPSTR cmdline,
		   int showstate);
#endif
