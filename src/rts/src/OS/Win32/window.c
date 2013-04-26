/* INTERFACE to NT, plus startup code
 *
 * $Log: window.c,v $
 * Revision 1.82  1999/03/23 14:53:27  johnh
 * [Bug #190536]
 * Pick up different about box depending on type of edition.
 *
 * Revision 1.81  1999/03/15  22:37:31  mitchell
 * [Bug #190512]
 * Don't print version and countdown when displaying advert splash screen
 *
 * Revision 1.80  1999/03/09  15:57:11  mitchell
 * [Bug #190509]
 * Update version strings to 2.1
 *
 * Revision 1.79  1999/03/09  10:39:07  mitchell
 * [Bug #190512]
 * Add advert splash screen
 *
 * Revision 1.78  1998/08/14  10:51:58  mitchell
 * [Bug #30473]
 * Fix & simplify get_multi_strings function
 *
 * Revision 1.77  1998/07/30  16:35:42  jkbrook
 * [Bug #30456]
 * Update version to 2.0(c0)
 *
 * Revision 1.76  1998/07/24  09:33:47  johnh
 * [Bug #30438]
 * Implement BitBlt.
 *
 * Revision 1.75  1998/07/23  16:23:39  johnh
 * [Bug #30451]
 * Implement SetBkMode and GetBkMode to fix splash screen.
 *
 * Revision 1.74  1998/07/21  08:51:38  johnh
 * [Bug #30448]
 * Implement KillTimer.
 *
 * Revision 1.73  1998/07/09  13:26:03  johnh
 * [Bug #30400]
 * add uninitialize function to return from tty properly.
 *
 * Revision 1.72  1998/07/02  10:44:13  johnh
 * [Bug #30431]
 * Add GWL style to extend Capi.
 *
 * Revision 1.71  1998/06/25  09:20:33  johnh
 * [Bug #30433]
 * Use new spalsh screen which does not need copyright info added to it.
 *
 * Revision 1.70  1998/06/17  14:51:18  johnh
 * [Bug #50083]
 * Fix multiple selection problem - wrong filename format.
 *
 * Revision 1.69  1998/06/12  11:19:04  jkbrook
 * [Bug #30415]
 * Update version info for 2.0b2
 *
 * Revision 1.68  1998/06/11  09:30:39  johnh
 * [Bug #30411]
 * Free edition splash screen changes.
 *
 * Revision 1.67  1998/06/08  10:58:15  jont
 * [Bug #30369]
 * Fix compiler warning
 *
 * Revision 1.66  1998/06/01  15:12:46  johnh
 * [Bug #30369]
 * Make open file dialog allow multiple selections.
 *
 * Revision 1.65  1998/05/26  15:31:22  mitchell
 * [Bug #30411]
 * Support for time-limited runtime
 *
 * Revision 1.64  1998/04/17  14:15:44  johnh
 * [Bug #30318]
 * Implement LoadLibrary and FreeLibrary.
 *
 * Revision 1.63  1998/04/07  09:38:48  johnh
 * [Bug #50067]
 * Updated index of FIND_MSG within message_values list and added a check to warn if out of step.
 *
 * Revision 1.62  1998/03/17  12:16:51  jkbrook
 * [Bug #70018]
 * Restore change after bad checkout for 30368
 *
 * Revision 1.61  1998/03/16  16:58:02  jkbrook
 * [Bug #30368]
 * Update version info for 2.0b0
 *
 * Revision 1.60  1998/03/03  17:11:11  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.59  1998/02/06  17:51:40  jkbrook
 * [Bug #30315]
 * Adjust splash-screen text placement
 *
 * Revision 1.58  1998/01/30  13:36:32  johnh
 * [Bug #30071]
 * Make Project Workspace changes.
 *
 * Revision 1.57  1998/01/28  14:14:38  jont
 * [Bug #20103]
 * Add Mlw_WinMain which is the same as WinMain, but callable from main_stub
 * when we're making a dll based version
 *
 * Revision 1.56  1998/01/12  14:43:42  jkbrook
 * [Bug #30315]
 * Updating version strings for 2.0m2 and changing copyright strings
 *
 * Revision 1.55  1997/10/29  11:45:30  johnh
 * [Bug #30187]
 * Fix getScrollInfo.
 *
 * Revision 1.54  1997/10/27  12:22:08  johnh
 * [Bug #30059]
 * Implement interface to Win32 resource dialogs.
 *
 * Revision 1.53  1997/10/21  14:23:27  daveb
 * [Bug #30291]
 * Made despatch_ml_message return a word, not an option.
 *
 * Revision 1.52  1997/10/16  14:06:50  johnh
 * [Bug #30193]
 *  Implement SetWindowPos Win32 API fn.
 *
 * Revision 1.51  1997/10/10  14:15:02  johnh
 * [Bug #01860]
 * Use explorer style file dialogs.
 *
 * Revision 1.50  1997/10/03  13:27:08  jkbrook
 * [Bug #30272]
 * Updating version strings for 2.0m1
 *
 * Revision 1.49.2.3  1997/11/24  14:39:40  johnh
 * [Bug #30071]
 * Generalise open_file_dialog.
 *
 * Revision 1.49.2.2  1997/09/12  14:55:34  johnh
 * [Bug #30071]
 * Redesign Compilation Manager -> Project Workspace.
 * Add dialog support functions.
 *
 * Revision 1.49  1997/09/05  15:53:08  johnh
 * [Bug #30241]
 * Implementing proper Find Dialog.
 *
 * Revision 1.48  1997/07/21  10:19:31  andreww
 * [Bug #30045]
 * This file calls the top-level runtime main function.  This function
 * is called main in the ordinary case, and run_main when the runtime
 * is a dynamic library.
 *
 * Revision 1.47  1997/07/18  13:44:29  johnh
 * [Bug #20074]
 * Add retry id.
 *
 * Revision 1.46  1997/06/16  11:15:45  daveb
 * [Bug #30169]
 * Updated version strings for 2.0m0.
 * Replaced hard-wired string lengths with calls to strlen().
 *
 * Revision 1.45  1997/05/22  10:32:59  johnh
 * [Bug #01702]
 * Using FormatMessage to obtain error messages from error codes.
 *
 * Revision 1.42.1.3  1997/05/22  10:08:52  daveb
 * [Bug #30126]
 * Replaced hard-wired string lengths with calls to strlen().
 *
 * Revision 1.42.1.2  1997/05/15  09:10:24  daveb
 * [Bug #30126]
 * Updated copyright string for release 1.0r2c1.
 *
 * Revision 1.44  1997/05/21  08:51:29  johnh
 * Implementing toolbar.
 *
 * Revision 1.43  1997/05/16  10:31:47  johnh
 * Adding support functions for implementing single menu bar.
 *
 * Revision 1.42  1997/03/25  17:27:38  johnh
 * [Bug #1992]
 * Added WM_CONTEXTMENU message value.
 *
 * Revision 1.41  1997/03/17  17:14:09  johnh
 * [Bug #1948]
 * Added a check in open_dir_dialog to fix an NT 3.51 problem.
 *
 * Revision 1.39  1997/03/13  13:49:08  johnh
 * [Bug #1772]
 * Added environment variables for IDOK and IDCANCEL Win32 values.
 *
 * Revision 1.38  1997/02/27  16:30:45  johnh
 * [Bug #1591]
 * Added two variables to store the current directory and filesys dir.
 *
 * Revision 1.37  1997/02/27  14:50:12  jont
 * [Bug #1691]
 * Convert printfs into diagnostics
 *
 * Revision 1.36  1997/02/06  13:29:13  johnh
 * Undo last bug as it reintroduces a previous bug (see v 1.25 below).
 *
 * Revision 1.34  1996/12/19  14:49:53  stephenb
 * [Bug #1801]
 * Ensure that the return value of every call to malloc is tested.
 *
 * Revision 1.32  1996/12/12  14:16:27  daveb
 * Added dummy hook function to file dialogs.  On NT 4.0, this forces them
 * to use the old-style dialog box.  This works around a problem on some
 * NT 4.0 machines, where MLWorks crashed when trying to find the new-style
 * dialogs.  We don't know the underlying reason for this problem.
 *
 * Revision 1.31  1996/12/04  11:58:56  daveb
 * Changed open_file_dialog to be more intelligent about the mask argument.
 *
 * Revision 1.30  1996/11/22  10:50:10  daveb
 * Checking for failure in get_bitmap.
 *
 * Revision 1.29  1996/11/20  17:15:52  johnh
 * Added CreateWindowEx including x, and y coordinates.
 *
 * Revision 1.28  1996/11/19  16:52:30  johnh
 * Changed do_input to process dialog messages as main_loop does.
 *
 * Revision 1.27  1996/11/18  15:24:19  daveb
 * Added Splash screen.
 *
 * Revision 1.26  1996/11/13  15:07:43  daveb
 * Minor change to diagnostic message
 *
 * Revision 1.25  1996/11/12  10:22:09  jont
 * Prevent GetOpenFileName from changing directory under our feet.
 *
 * Revision 1.24  1996/10/31  15:49:40  johnh
 * Implementing Interrupt button on Podium.
 *
 * Revision 1.23  1996/10/22  14:18:37  jont
 * [Bug #1406]
 * Improve images save size by taking tail of list before calling ml
 *
 * Revision 1.22  1996/10/07  15:05:24  johnh
 * Added scrolling functionality.
 *
 * Revision 1.21  1996/10/03  16:06:33  johnh
 * [Bug #1621]
 * Fixed unwanted warnings.
 *
 * Revision 1.20  1996/09/25  15:47:10  johnh
 * [Bug #1613]
 * Added get_scroll_info and set_pixel and also added a check to ensure that.
 * the WindowSystemError is not redefined on compiling Windows.sml in Gui.
 *
 * Revision 1.17  1996/07/26  15:05:38  daveb
 * [Bug #1478]
 * Added WM_USER[0-5] messages.
 *
 * Revision 1.16  1996/07/05  08:28:39  stephenb
 * Fix #1459 - Win32: window.c caches root.
 * Fixed up as many as I could find.  There could still be some
 * non-obvious ones though.  Also removed list_list_length since
 * it was never called and removed some commented out functions.
 *
 * Revision 1.15  1996/07/02  13:15:54  nickb
 * Unwind some of the last change as it was causing mysterious segmentation
 * faults.
 *
 * Revision 1.14  1996/07/02  12:26:07  nickb
 * Fix various incorrect uses of declare_root and retract_root.
 *
 * Revision 1.13  1996/07/01  09:21:50  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.12  1996/06/18  13:21:09  daveb
 * Added DEFAULT_GUI_FONT.  Made dialogs always use MS Sans Serif 8 point font.
 * Stopped win32_error from printing a string to stdout.
 *
 * Revision 1.11  1996/06/13  12:47:04  daveb
 * Added WM_SYSCOMMAND, ml_convert_sc_value, and SW_RESTORE etc.
 *
 * Revision 1.10  1996/06/11  13:26:24  jont
 * Undo changes for version 1.9, these don't work properly
 *
 * Revision 1.9  1996/06/05  09:34:24  nickb
 * Improve delivery.
 *
 * Revision 1.8  1996/06/04  11:04:21  nickb
 * Tidy up root declarations.
 *
 * Revision 1.7  1996/05/29  11:13:04  matthew
 * Adding quitonexit stuff
 *
 * Revision 1.6  1996/05/28  16:44:43  jont
 * Add save_image_dialog for images saving
 *
 * Revision 1.5  1996/04/10  12:14:03  matthew
 * Changing to being a windows application!!
 *
 * Revision 1.4  1996/04/04  09:46:06  matthew
 * Fixing problem with fetching from clipboard.
 *
 * Revision 1.3  1996/03/08  11:07:21  matthew
 * Extending for library
 *
 * Revision 1.2  1996/03/05  11:53:27  stephenb
 * Merge in winmain.c 1.18 -> 1.19 changes made by Matthew.
 * The log message for this change was "Extending".
 *
 * Revision 1.1  1996/03/04  11:00:49  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/winmain.c
 *
 * Revision 1.18  1996/02/16  12:52:19  nickb
 * Change to declare_global().
 *
 * Revision 1.17  1996/02/02  15:25:56  matthew
 * Reorganizing
 *
 * Revision 1.16  1996/01/31  14:55:14  matthew
 * Changing the way we do rectangles
 *
 * Revision 1.15  1996/01/25  12:24:06  matthew
 * Adding set_text_color etc.
 *
 * Revision 1.14  1996/01/17  17:05:34  nickb
 * Disable interrupt handling except when a handler is defined.
 *
 * Revision 1.13  1996/01/12  16:34:05  matthew
 * Adding WM_NOREDRAW message
 * Adding WM_SETREDRAW message
 *
 * Revision 1.12  1996/01/12  10:25:49  daveb
 * Added open_file_dialog, open_dir_dialog and save_as_dialog.
 *
 * Revision 1.11  1996/01/09  15:03:22  matthew
 * Fixing bungles of previous checkin.
 *
 * Revision 1.10  1996/01/09  14:17:40  nickb
 * Add console control handler.
 *
 * Revision 1.9  1996/01/04  16:17:47  matthew
 * Adding GetStockObject etc.
 *
 * Revision 1.8  1995/12/20  15:17:23  matthew
 * Adding some color functions
 *
 * Revision 1.7  1995/12/18  17:01:58  matthew
 * Adding new window styles
 *
 * Revision 1.6  1995/12/14  15:33:00  matthew
 * Changing message handling
 *
 * Revision 1.5  1995/12/07  17:07:39  matthew
 * Putting WM_CUT in the correct place in the ordering
 *
 * Revision 1.4  1995/12/06  17:32:09  matthew
 * Fixing some problems with registering popups
 * Fixing problem with dialog boxes on Win95
 * Adding clipboard functions
 *
 * Revision 1.3  1995/11/22  12:50:52  matthew
 * Changing command handlers
 *
 * Revision 1.2  1995/11/14  15:41:43  matthew
 * Extending for graphics
 *
 * Revision 1.1  1995/10/17  13:45:15  jont
 * new unit
 *
 * Revision 1.8  1995/09/19  16:02:01  matthew
 * Adding DeleteMenu and RemoveMenu
 *
 * Revision 1.7  1995/09/04  15:11:02  matthew
 * More stuff
 *
 * Revision 1.6  1995/08/31  10:11:34  matthew
 * Adding extra menu functions
 *
 * Revision 1.5  1995/08/25  10:21:46  matthew
 * more work (dialog boxes and window procedures)
 *
 * Revision 1.4  1995/08/15  14:08:19  matthew
 * More work
 *
 * Revision 1.3  1995/08/11  13:16:02  matthew
 * Extending for capi stuff
 *
 * Revision 1.2  1995/03/14  14:06:54  jont
 * More code
 *
 * Revision 1.1  1995/03/01  16:40:16  jont
 * new unit
 * No reason given
 *
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
 */

/******************************************************************************

        InitApplication() - initializes window data and registers window
        InitInstance() - saves instance handle and creates main window
        WndProc() - processes messages for the podium
        CenterWindow() - used to center the "About" box over application window
        About() - processes messages for "About" dialog box

****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "ansi.h"
#include "mltypes.h"
#include "main.h"
#include "mlw_dll.h"
#include "utils.h"
#include "values.h"
#include "global.h"
#include "exceptions.h"
#include "environment.h"
#include "interface.h"
#include "gc.h"
#include "allocator.h"
#include "diagnostic.h"
#include "event.h"
#include "signals.h"
#include "license.h"

#include <windows.h>   /* required for all Windows applications */
#include <commctrl.h>
#if !defined(_WIN32) && !defined(WIN32)
#include <ver.h>
#endif
#include "window.h"   /* specific to this program */

/* runtime-as-a-dll specific stuff */

#ifdef RUNTIME_DLL
#define run_main(argc,argv) mlw_main(argc,argv)
#else
#define run_main(argc,argv) main(argc,argv)
#endif

/* Some utilities */

static inline mlval box(UINT x)
{
  mlval b = allocate_string(sizeof(x));
  memcpy(CSTRING(b), (char *)&x, sizeof(x));
  return(b);
}

static inline UINT unbox(mlval b)
{
  UINT x;
  memcpy((char *)&x, CSTRING(b), sizeof(x));
  return(x);
}

/* Now some convenient macros */

#define CHWND(x) ((HWND)unbox (x))
#define MLHWND(x) ((mlval)box ((UINT)x))

#define CHMENU(x) ((HMENU)unbox (x))
#define MLHMENU(x) ((mlval)box ((UINT)x))

#define CHDC(x) ((HDC)unbox (x))
#define MLHDC(x) ((mlval)box ((UINT)x))

#define MLBOOL(x) ((x) ? MLTRUE : MLFALSE)
#define CBOOL(x) ((x) == MLTRUE)

#define MLNONE (MLINT (0))

static size_t list_length (mlval arg)
{
  size_t len= 0;
  while (arg != MLNIL) {
    len++;
    arg= FIELD(arg,1);
  }
  return len;
}


/* This stuff is MLWorks specific */

static HINSTANCE hInst;          /* current instance */

char szAppName[] = "MLWorks";   /* The name of this application */
char szTitle[]   = "MLWorks"; /* The title bar text */
char szToplevel[] = "Toplevel";
char szFrame[] = "Frame";

char szVersion[] = "Version 2.1";

static mlval perv_exn_ref_win;
static mlval windows_exns_initialised;
static HBITMAP hbm;
static HFONT splash_font;
static HFONT version_font;

static HANDLE hAccelTable;

static HWND applicationShell = NULL;
static HWND interrupt_window = NULL;
static BOOL interrupt_pressed = FALSE;

static BOOL safe_to_call_ml ()
{
  return (!in_GC);
}

/* WINDOW PROCEDURES */

/* Mechanism 1 -- menu commands */

/* this is a linked list of ML triples */
/* There should be some function for deleting the entries for a window */

static mlval menu_table = MLNIL;

static mlval add_menu_command (mlval arg)
{
  mlval cell;
  DIAGNOSTIC(4, "add_menu_command %u", unbox(FIELD(arg,1)), 0);
  declare_root (&arg, 0);
  cell = allocate_record (2);
  retract_root (&arg);
  FIELD (cell,0) = arg;
  FIELD (cell,1) = menu_table;
  menu_table = cell;
  return MLUNIT;
}


/* apply_menu_command:  Processes messages for menus.

   Returns:  TRUE if message handled, FALSE otherwise.

   Called by:  MLWndProc, MLDlgProc.

   Comment:  Scans the menu_table until it finds an entry that matches the
	window and menu entry.  If it finds one, it calls the appropriate
	callback -- unless MLWorks is in the middle of a GC.  Always returns
	TRUE if a handler is found, even if it isn't called.
*/
static BOOL apply_menu_command (UINT cmd,UINT event,HWND hwnd)
{
  mlval list= menu_table;

  while (list != MLNIL) {
    mlval item = FIELD (list,0);
    HWND w = CHWND (FIELD (item,0));
    UINT c = unbox (FIELD (item,1));
    if (cmd == c && (w == NULL || w == hwnd))	{
      /* We are going to call into ML, so do some checks */
      if (!safe_to_call_ml ()) {
	DIAGNOSTIC(1, "WARNING: Aborting unsafe call to ML", 0, 0);
	return TRUE;
      } else {
	mlval arg;
	mlval mlhwnd= MLHWND(hwnd);
	    
	declare_root(&item, 0);
	declare_root(&mlhwnd, 0);
	arg = allocate_record(2);
	retract_root(&mlhwnd);
	retract_root(&item);

	FIELD(arg,0)= mlhwnd;
	FIELD(arg,1)= MLINT (event);
	    
	callml(arg, FIELD(item,2));
	    
	return TRUE;
      }
    }
    list= FIELD(list,1);
  }

  return FALSE;
}



/* Mechanism 2 -- message handlers */
/* See _windows for the type of this */

static mlval handler_map = MLNIL;

static mlval get_handler_map (mlval arg)
{
  return (handler_map);
}

static mlval set_handler_map (mlval arg)
{
  handler_map = arg;
  return MLUNIT;
}

/* call_ml_message_proc:  process callbacks for Windows messages.

    Returns:  The result of the message handler.

    Called from:  despatch_ml_message, MLDlgProc.

    Comment:  This handles any messages other than WM_INITDIALOG
	and those WM_COMMAND messages handled by do_help or
        apply_menu_command.  It scans down the list of stored handler
        lists until it finds the one for the current window.  It then
	scans that list for the appropriate event handler and calls
 	it -- unless MLWorks is in a garbage collection.  If the ML
	event handler returns SOME(w), then call_ml_message_proc 
	returns w.  If the handler returns NONE (or if the handler
	doesn't exist, or MLWorks is in a GC), then the C handler
        function is called, and call_ml_message_proc returns the
	result of that call.

*/
static LRESULT call_ml_message_proc (HWND hwnd,         /* window handle */
				     UINT message,      /* type of message */
				     WPARAM wparam,     /* additional information */
				     LPARAM lparam)     /* additional information */
{
  mlval hmap = handler_map;
  mlval wlist = MLNIL;
  mlval hlist = MLNIL;
  mlval result = mlw_option_make_none();

  WNDPROC cproc = NULL;

  /* scan down the handler list */
  while (hmap != MLNIL) {
    mlval hd= FIELD(hmap, 0);
    if (CHWND (FIELD(hd, 0)) == hwnd) {
      mlval entry= FIELD(hd, 1);
      cproc= (WNDPROC)unbox(FIELD(entry, 0));
      wlist= MLSUB(FIELD(entry, 1), 0);
      break;
    }
    hmap= FIELD(hmap,1);
  }

  /* Now wlist contains the message handlers for the window (or nil) */
  /* cproc contains the c handler to call */

  /* If MLWorks is doing a GC, then we can't call into ML.  So don't
     bother searching the handler list. */
  if (!safe_to_call_ml()) {
    DIAGNOSTIC(1, "WARNING: Aborting unsafe call to ML", 0, 0);
  } else {
    while (wlist != MLNIL) {
      mlval hd = FIELD(wlist, 0);
      if (unbox(FIELD(hd, 0)) == message) {
        hlist= MLSUB(FIELD(hd, 1), 0);
        break;
      }
      wlist= FIELD(wlist, 1);
    }
  
    /* Now assemble the ml argument for the window procedure */

    if (hlist != MLNIL) {
      mlval arg, mlwparam, mllparam;

      declare_root(&hlist, 0);
      mlwparam= box(wparam);
      declare_root(&mlwparam, 0);
      mllparam= box(lparam);
      declare_root(&mllparam, 0);
      arg= allocate_record (2);
      declare_root(&arg, 0);
      FIELD(arg,0)= mlwparam;
      FIELD(arg,1)= mllparam;
      retract_root(&mlwparam);
      retract_root(&mllparam);
      
      /* Now hlist contains the list of handlers for this message */
      while (hlist != MLNIL && result == MLINT(0)) {
        mlval arg2 = FIELD(hlist, 0);
        /* Move to tail of list before calling ml */
        /* If the call is to delivery, this means */
        /* we don't deliver the interactive system as well */
        hlist= FIELD(hlist, 1);
        result= callml(arg, arg2);
      }
      /* NOTE these roots are not going to be retracted if an 
       * exception occurs whilst in the ML code called by the above 
       * callml.  See bug #1451.
       */
      retract_root(&arg);
      retract_root(&hlist);
    }
  }

  if (!mlw_option_is_none(result))
    return unbox(mlw_option_some(result));

  if (cproc == NULL)
    return DefWindowProc(hwnd, message, wparam, lparam) ;

  /* Finally */
  return CallWindowProc(cproc, hwnd, message, wparam, lparam);
}

/* despatch_ml_message: handles window messages, other than help messages,
	and messages sent to dialog boxes. 

   Returns:  the result of the message handler.

   Called from:  MLWndProc.

   Comment:  Call apply_menu_command to process WM_COMMAND messages;
	pass others on to call_ml_message_proc.
*/

static LRESULT despatch_ml_message (HWND hwnd,         /* window handle */
				    UINT message,      /* type of message */
				    WPARAM wparam,     /* additional information */
				    LPARAM lparam)     /* additional information */
{
  int wmId, wmEvent;

  /* lets put the message handling in here for the moment */
  switch (message) {
  case WM_COMMAND:
    /* Message packing of wParam and lParam have changed for Win32, let us */
    /* handle the differences in a conditional compilation: */
#if defined (_WIN32) || defined(WIN32)
    wmId    = LOWORD(wparam);
    wmEvent = HIWORD(wparam);
#else
    wmId    = wparam;
    wmEvent = HIWORD(lparam);
#endif
    DIAGNOSTIC (2, "Command %u, event %u received in MLWndProc",
		wmId, wmEvent);
    if (apply_menu_command (wmId,wmEvent,hwnd))
      return 0;
    /* Drop through */
  default:
    return call_ml_message_proc(hwnd, message, wparam, lparam);
  }
}

/* do_help: Process messages for the help menu.

   Returns:  TRUE is the message is handled, false otherwise.

   Called: from MLWndProc.

   Comments:
        To process the IDM_ABOUT message, call MakeProcInstance() to get the
        current instance address of the About() function.  Then call Dialog
        box which will create the box according to the information in your
        generic.rc file and turn control over to the About() function.  When
        it returns, free the instance address.
*/
/* It would be nice to do this in ML, but there you go */
static BOOL do_help (HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
  FARPROC lpProcAbout; /* pointer to the "About" function */
  int wmId, wmEvent;

  switch (message) {

  case WM_COMMAND:  /* message: command from application menu */

    /* Message packing of wParam and lParam have changed for Win32, let us */
    /* handle the differences in a conditional compilation: */
#if defined (_WIN32) || defined(WIN32)
    wmId    = LOWORD(wParam);
    wmEvent = HIWORD(wParam);
#else
    wmId    = wParam;
    wmEvent = HIWORD(lParam);
#endif

    /* Handle help messages here */
    switch (wmId) {
    case IDM_ABOUT:
      lpProcAbout = MakeProcInstance((FARPROC)About, hInst);

      if ((license_edition != PERSONAL) && (!act_as_free)) {
	DialogBox(hInst,                 /* current instance */
		  "ABOUTPROFESSIONAL",   /* dlg resource to use */
		  hWnd,                  /* parent handle */
		  (DLGPROC)lpProcAbout);  /* About() instance address */
      } else {
	DialogBox(hInst,                 /* current instance */
		  "ABOUTPERSONAL",   /* dlg resource to use */
		  hWnd,                  /* parent handle */
		  (DLGPROC)lpProcAbout);  /* About() instance address */
      }

      FreeProcInstance(lpProcAbout);
      return (TRUE);

    case IDM_HELPCONTENTS:
      if (!WinHelp (hWnd, "rts/runtime.HLP", HELP_KEY,(DWORD)(LPSTR)"CONTENTS")) {
	MessageBox (GetFocus(),
		    "Unable to activate help",
		    szAppName, MB_SYSTEMMODAL|MB_OK|MB_ICONHAND);
      }
      return (TRUE);

    case IDM_HELPSEARCH:
      if (!WinHelp(hWnd, "GENERIC.HLP", HELP_PARTIALKEY, (DWORD)(LPSTR)"")) {
	MessageBox (GetFocus(),
		    "Unable to activate help",
		    szAppName, MB_SYSTEMMODAL|MB_OK|MB_ICONHAND);
      }
      return (TRUE);

    case IDM_HELPHELP:
      if(!WinHelp(hWnd, (LPSTR)NULL, HELP_HELPONHELP, 0)) {
	MessageBox (GetFocus(),
		    "Unable to activate help",
		    szAppName, MB_SYSTEMMODAL|MB_OK|MB_ICONHAND);
      }
      return (TRUE);

    default:
      return (FALSE);
    }
  default:          /* Passes it on if unprocessed */
    return (FALSE);
  }
}

/****************************************************************************

        FUNCTION: MLWndProc(HWND, UINT, WPARAM, LPARAM)

        PURPOSE:  Processes messages (other than those for Dialog Boxes --
		  see MLDlgProc).

        MESSAGES:

        WM_COMMAND    - application menu (About dialog box)
        WM_DESTROY    - destroy window

  	RETURNS:

	Return value depends on the message.  WM_COMMAND should return 0
	if handled.

        COMMENTS:
 
	Call do_help to process help menu commands.  Otherwise pass the
	message on to despth_ml_message.

****************************************************************************/

LRESULT CALLBACK MLWndProc(
                HWND hWnd,         /* window handle */
                UINT message,      /* type of message */
                WPARAM wParam,     /* additional information */
                LPARAM lParam)     /* additional information */
{
  /* See if it is a help message */
  if (do_help (hWnd,message,wParam,lParam))
    return (0);

  /* Otherwise see if ML will handle it */
  return despatch_ml_message(hWnd,message,wParam,lParam);
}

/****************************************************************************

        FUNCTION: InitApplication(HINSTANCE)

        PURPOSE: Initializes window data and registers window class

        COMMENTS:

                This function is called at initialization time only if no other
                instances of the application are running.  This function performs
                initialization tasks that can be done once for any number of running
                instances.

                In this case, we initialize a window class by filling out a data
                structure of type WNDCLASS and calling the Windows RegisterClass()
                function.  Since all instances of this application use the same window
                class, we only need to do this when the first instance is initialized.


****************************************************************************/

BOOL InitApplication(HINSTANCE hInstance)
{
  WNDCLASS wc, toplevel, frame;

  /* Do we really need all three classes here? */
  /* Fill in window class structure with parameters that describe the */
  /* main window. */

  wc.style         = CS_HREDRAW | CS_VREDRAW;/* Class style(s) */
  wc.lpfnWndProc   = (WNDPROC)MLWndProc;       /* Window Procedure */
  wc.cbClsExtra    = 0;                      /* No per-class extra data. */
  wc.cbWndExtra    = 0;                      /* No per-window extra data. */
  wc.hInstance     = hInstance;              /* Owner of this class */
  wc.hIcon         = LoadIcon (hInstance, szAppName); /* Icon name from .RC */
  wc.hCursor       = LoadCursor(NULL, IDC_ARROW);/* Cursor */
  wc.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);/* Default color */
  wc.lpszMenuName  = NULL;
  wc.lpszClassName = szAppName;              /* Name to register as */
  if (!RegisterClass(&wc)) return FALSE;

  /* Now create a toplevel window */
  toplevel.style         = CS_HREDRAW | CS_VREDRAW;/* Class style(s) */
  toplevel.lpfnWndProc   = (WNDPROC)MLWndProc;       /* Window Procedure */
  toplevel.cbClsExtra    = 0;                      /* No per-class extra data. */
  toplevel.cbWndExtra    = 0;                      /* No per-window extra data. */
  toplevel.hInstance     = hInstance;              /* Owner of this class */
  toplevel.hIcon         = LoadIcon (hInstance, szAppName); /* Icon name from .RC */
  toplevel.hCursor       = LoadCursor(NULL, IDC_ARROW);/* Cursor */
  toplevel.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);/* Default color */
  toplevel.lpszMenuName  = NULL;
  toplevel.lpszClassName = szToplevel;                 /* Name to register as */
  if (!RegisterClass(&toplevel)) return FALSE;

  /* Now create a "generic" subwindow window class */
  frame.style         = CS_HREDRAW | CS_VREDRAW;/* Class style(s) */
  frame.lpfnWndProc   = (WNDPROC)MLWndProc; /*  */
  frame.cbClsExtra    = 0;                      /* No per-class extra data. */
  frame.cbWndExtra    = 0;                      /* No per-window extra data. */
  frame.hInstance     = hInstance;              /* Owner of this class */
  frame.hIcon         = NULL;
  frame.hCursor       = LoadCursor(NULL, IDC_ARROW);/* Cursor */
  frame.hbrBackground = (HBRUSH)(COLOR_WINDOW+1);/* Default color */
  frame.lpszMenuName  = NULL;
  frame.lpszClassName = szFrame;                 /* Name to register as */
  return (RegisterClass(&frame));
}


/****************************************************************************

        FUNCTION:  InitInstance(HINSTANCE, int)

        PURPOSE:  Saves instance handle and creates main window

        COMMENTS:

                This function is called at initialization time for every instance of
                this application.  This function performs initialization tasks that
                cannot be shared by multiple instances.

                In this case, we save the instance handle in a static variable and
                create and display the main program window.

****************************************************************************/

/* This does little more than create a top level window  and assign to hInst */

BOOL InitInstance(HINSTANCE hInstance, int nCmdShow, HWND *window)
{
        HWND            hWnd; /* Main window handle. */

        /* Save the instance handle in static variable, which will be used in */
        /* many subsequent calls from this application to Windows. */

        hInst = hInstance; /* Store instance handle in our global variable */

        /* Create a main window for this application instance. */

        hWnd = CreateWindow(
                szAppName,           /* See RegisterClass() call. */
                szTitle,             /* Text for window title bar. */
                WS_OVERLAPPEDWINDOW, /* Window style. */
                CW_USEDEFAULT,       /* Horizontal default position */
                0,                   /* Ignored since x = CW_USEDEFAULT */
                /*CW_USEDEFAULT*/300,/* Horizontal width */
                300,                 /* Vertical height */
                                     /* Use default positioning */
                NULL,                /* Overlapped windows have no parent. */
                NULL,                /* Use the window class menu. */
                hInstance,           /* This instance owns this window. */
                NULL                 /* We don't use any data in our WM_CREATE */
        );

	applicationShell = hWnd;

        /* If window could not be created, return "failure" */
        if (!hWnd) 
	  {
	    return (FALSE);
	  }
	*window = hWnd;

        return (TRUE);              /* We succeeded... */

}


/****************************************************************************

        FUNCTION: CenterWindow (HWND, HWND)

        PURPOSE:  Center one window over another

        COMMENTS:

        Dialog boxes take on the screen position that they were designed at,
        which is not always appropriate. Centering the dialog over a particular
        window usually results in a better position.

****************************************************************************/

/* This should be doable in ML also */
/* Just used in the About function */
BOOL CenterWindow (HWND hwndChild, HWND hwndParent)
{
        RECT    rChild, rParent;
        int     wChild, hChild, wParent, hParent;
        int     wScreen, hScreen, xNew, yNew;
        HDC     hdc;

        /* Get the Height and Width of the child window */
        GetWindowRect (hwndChild, &rChild);
        wChild = rChild.right - rChild.left;
        hChild = rChild.bottom - rChild.top;

        /* Get the Height and Width of the parent window */
        GetWindowRect (hwndParent, &rParent);
        wParent = rParent.right - rParent.left;
        hParent = rParent.bottom - rParent.top;

        /* Get the display limits */
        hdc = GetDC (hwndChild);
        wScreen = GetDeviceCaps (hdc, HORZRES);
        hScreen = GetDeviceCaps (hdc, VERTRES);
        ReleaseDC (hwndChild, hdc);

        /* Calculate new X position, then adjust for screen */
        xNew = rParent.left + ((wParent - wChild) /2);
        if (xNew < 0) {
                xNew = 0;
        } else if ((xNew+wChild) > wScreen) {
                xNew = wScreen - wChild;
        }

        /* Calculate new Y position, then adjust for screen */
        yNew = rParent.top  + ((hParent - hChild) /2);
        if (yNew < 0) {
                yNew = 0;
        } else if ((yNew+hChild) > hScreen) {
                yNew = hScreen - hChild;
        }

        /* Set it, and return */
        return SetWindowPos (hwndChild, NULL,
                xNew, yNew, 0, 0, SWP_NOSIZE | SWP_NOZORDER);
}


/****************************************************************************

        FUNCTION: About(HWND, UINT, WPARAM, LPARAM)

        PURPOSE:  Processes messages for "About" dialog box

        MESSAGES:

        WM_INITDIALOG - initialize dialog box
        WM_COMMAND    - Input received

        COMMENTS:

        Display version information from the version section of the
        application resource.

        Wait for user to click on "Ok" button, then close the dialog box.

****************************************************************************/

LRESULT CALLBACK About(
                HWND hDlg,           /* window handle of the dialog box */
                UINT message,        /* type of message */
                WPARAM wParam,       /* message-specific information */
                LPARAM lParam)
{
        static  HFONT hfontDlg;
        LPSTR   lpVersion;       
        DWORD   dwVerInfoSize;
        DWORD   dwVerHnd;
        UINT    uVersionLen;
        WORD    wRootLen;
        BOOL    bRetCode;
        int     i;
        char    szFullPath[256];
        char    szResult[256];
        char    szGetName[256];

        switch (message) {
                case WM_INITDIALOG:  /* message: initialize dialog box */
                        /* Create a font to use */
                        hfontDlg = CreateFont(14, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0,
                                VARIABLE_PITCH | FF_SWISS, "");

                        /* Center the dialog over the application window */
                        CenterWindow (hDlg, GetDesktopWindow ());

                        /* Get version information from the application */
                        GetModuleFileName (hInst, szFullPath, sizeof(szFullPath));
                        dwVerInfoSize = GetFileVersionInfoSize(szFullPath, &dwVerHnd);
                        if (dwVerInfoSize) {
                                /* If we were able to get the information, process it: */
                                LPSTR   lpstrVffInfo;
                                HANDLE  hMem;
                                hMem = GlobalAlloc(GMEM_MOVEABLE, dwVerInfoSize);
                                lpstrVffInfo  = GlobalLock(hMem);
                                GetFileVersionInfo(szFullPath, dwVerHnd, dwVerInfoSize, lpstrVffInfo);
                                lstrcpy(szGetName, "\\StringFileInfo\\040904E4\\");
                                wRootLen = lstrlen(szGetName);

                                /* Walk through the dialog items that we want to replace: */
                                for (i = DLG_VERFIRST; i <= DLG_VERLAST; i++) {
                                        GetDlgItemText(hDlg, i, szResult, sizeof(szResult));
                                        szGetName[wRootLen] = (char)0;
                                        lstrcat (szGetName, szResult);
                                        uVersionLen   = 0;
                                        lpVersion     = NULL;
                                        bRetCode      =  VerQueryValue((LPVOID)lpstrVffInfo,
                                                (LPSTR)szGetName,
                                                (LPVOID)&lpVersion,
#if defined (_WIN32) || defined(WIN32)
                                                (LPDWORD)&uVersionLen); /* For MIPS strictness */
#else
                                                (UINT *)&uVersionLen);
#endif

                                        if ( bRetCode && uVersionLen && lpVersion) {
                                                /* Replace dialog item text with version info */
                                                lstrcpy(szResult, lpVersion);
                                                SetDlgItemText(hDlg, i, szResult);
                                                SendMessage (GetDlgItem (hDlg, i), WM_SETFONT, (UINT)hfontDlg, TRUE);
                                        }
                                } /* for (i = DLG_VERFIRST; i <= DLG_VERLAST; i++) */

                                GlobalUnlock(hMem);
                                GlobalFree(hMem);
                        } /* if (dwVerInfoSize) */

                        return (TRUE);

                case WM_COMMAND:                      /* message: received a command */
                        if (LOWORD(wParam) == IDOK        /* "OK" box selected? */
                        || LOWORD(wParam) == IDCANCEL) {  /* System menu close command? */
                                EndDialog(hDlg, TRUE);        /* Exit the dialog */
                                DeleteObject (hfontDlg);
                                return (TRUE);
                        }
                        break;
        }
        return (FALSE); /* Didn't process the message */

        lParam; /* This will prevent 'unused formal parameter' warnings */
}

/* This is needed for window subclassing */
static mlval get_ml_window_proc (mlval arg) 
{
  return (box ((UINT)MLWndProc));
}

static BOOL initialised;

static mlval main_init(mlval argument)
{
  static HWND window;

  if (!initialised) {
    if (!InitInstance(hInst, SW_SHOWDEFAULT, &window)) {
      error("Unable to initialise instance");
    }
    initialised = TRUE;
  }

  return MLHWND(window);
}

static mlval uninitialise_mlworks(mlval arg)
{
  initialised = FALSE;
  return MLUNIT;
}

static mlval set_interrupt_window (mlval arg)
{
  interrupt_window = CHWND(arg);
  return MLUNIT;
}

/* mlw_expose_windows is called periodically by 
 * <URI:/src/OS/Win32/os.c:os_update_windows>.  
 * This opportunity is used to handle any messages such as expose
 * messages, correspnding to the MLWorks environment.  More 
 * importantly it checks to see if the interrupt button on the 
 * podium is clicked and if so then an interrupt signal is sent
 * so that any computation or compilation is interrupted.
 */
extern void mlw_expose_windows(void)
{
  MSG msg;
  mlval unit = MLUNIT;

  if ((applicationShell == NULL) || (interrupt_window == NULL))
    return;
  
  while (PeekMessage(&msg, interrupt_window, 0, 0, PM_REMOVE))
  { 
    switch (msg.message) {
    case WM_LBUTTONDOWN:
      if (interrupt_pressed) { 
	record_event(EV_INTERRUPT, (word) 0);
	interrupt_pressed = FALSE;
      }
      else
	DispatchMessage(&msg);
      break; 
    default:
      DispatchMessage(&msg);
    }
  }

  while (PeekMessage(&msg, NULL, 0, 0, PM_REMOVE))
  {
    TranslateMessage(&msg);
    DispatchMessage(&msg);
  }

}

static mlval interrupt(mlval arg)
{
  interrupt_pressed = TRUE;
  return MLUNIT;
}

static mlval ml_window_updates_toggle(mlval arg)
{
  BOOL updates_start = CBOOL(arg);

  window_update_interval = 200;  /* check for interrupt and handle window 
				  * updates 5 times a second. */
  if (updates_start)
    signal_window_updates_start();
  else
    signal_window_updates_stop();

  return MLUNIT;
}

/* Utility function here */

/* Find the root of the window.  This is where accelerator commands get sent to */
static HWND window_root (HWND w)
{
  HWND parent = GetParent (w);
  while (parent != NULL)
    {
      w = parent;
      parent = GetParent (w);
    }
  return (w);
}

/* Both of the next functions pass on accelerator messages to the relevant root widget */

#define MAX_REGISTERED_WINDOWS 128
static HWND registered_windows[MAX_REGISTERED_WINDOWS];

static void init_registered_windows ()
{
  int i;
  for (i=0;i<MAX_REGISTERED_WINDOWS;i++)
    registered_windows[i]=(HWND)NULL;
}

static mlval register_popup_window (mlval arg)
{
  HWND hwnd = CHWND (arg);
  int i;
  for (i=0;i<MAX_REGISTERED_WINDOWS;i++) {
    if (!registered_windows[i]) {
      registered_windows[i] = hwnd;
      return MLUNIT;
    }
  }
  DIAGNOSTIC(0, "Out of space for registering window", 0, 0);
  return MLUNIT;
}

static mlval unregister_popup_window (mlval arg)
{
  HWND hwnd = CHWND (arg);
  int i;
  for (i=0;i<MAX_REGISTERED_WINDOWS;i++)
    {
      if (registered_windows[i] == hwnd)
	{
	  registered_windows[i] = (HWND)NULL;
	  return MLUNIT;
	}
    }
  DIAGNOSTIC(0, "Window not found in unregister window", 0, 0);
  return MLUNIT;
}

/* Scan down all of the registered dialogs */
BOOL static do_dialog_messages (MSG *message)
{
  int i;
  for (i=0;i<MAX_REGISTERED_WINDOWS;i++)
    {
      HWND hwnd = registered_windows[i];
      if (hwnd && IsWindow (hwnd) && IsDialogMessage (hwnd,message))
	return (TRUE);
    }
  return (FALSE);
}

static int quit_on_exit_flag = FALSE;

static mlval quit_on_exit (mlval arg)
{
  quit_on_exit_flag = TRUE;
  return MLUNIT;
}

static mlval main_loop(mlval unit)
{
  MSG msg;

  /* Acquire and dispatch messages until a WM_QUIT message is received. */

  while (GetMessage(&msg, /* message structure */
         (HWND) NULL,   /* handle of window receiving the message */
         0,             /* lowest message to examine */
         0))            /* highest message to examine */
    {
      if (!TranslateAccelerator(applicationShell, hAccelTable, &msg))
	if (!do_dialog_messages (&msg))
	  {
	    TranslateMessage(&msg);/* Translates virtual key codes */
	    DispatchMessage(&msg); /* Dispatches message to window */
	  }
    }

  if (quit_on_exit_flag)
    exit (0);

  return MLUNIT;
}



static mlval do_input (mlval unit)
{
  MSG msg;

  /* Acquire and dispatch a single message unless a WM_QUIT message is received. */

  if (GetMessage(&msg, /* message structure */
		 (HWND) NULL,   /* handle of window receiving the message */
		 0,             /* lowest message to examine */
		 0))            /* highest message to examine */
    {
      if (!TranslateAccelerator(applicationShell, hAccelTable, &msg)) 
	if (!do_dialog_messages (&msg)) {
	  TranslateMessage(&msg);/* Translates virtual key codes */
	  DispatchMessage(&msg); /* Dispatches message to window */
	}
      return MLFALSE;
    }
  else
    return MLTRUE;
}


static int current_splash_kind;

static mlval get_splash_bitmap(mlval arg){
  HWND hwindow = CHWND(FIELD(arg, 0));
  int kind = CINT(FIELD(arg, 1));
  HANDLE hfbm;
  BITMAPFILEHEADER bmfh;
  BITMAPINFOHEADER bmih;
  DWORD dwRead;
  HGLOBAL hmem1, hmem2;
  BITMAPINFO *lpbmi;
  LONG *lpvBits;
  BITMAP bm;
  RECT rect;
  BOOL fDisplayBitmap;
  HDC hdc, hdcMem;
  HFONT oldFont;
  char filename[MAX_PATH];
  int i, not_found;

  GetModuleFileName (hInst, filename, sizeof(filename));

  not_found = 1;
  for(i=strlen(filename); i>0 && not_found; i--)
    if (filename[i] == '\\') {
      filename[i] = 0;
      not_found = 0;
    }

  current_splash_kind = kind;

  switch (kind) {
  case 0 : sprintf(filename, "%s\\splash.bmp", filename); break;
  case 1 : sprintf(filename, "%s\\splash_free.bmp", filename); break;
  case 2 : sprintf(filename, "%s\\splash_advert.bmp", filename); break;
  default: sprintf(filename, "%s\\splash_free.bmp", filename); break;
  }

  hfbm = CreateFile(filename, GENERIC_READ, 
		    FILE_SHARE_READ, (LPSECURITY_ATTRIBUTES) NULL, 
		    OPEN_EXISTING, FILE_ATTRIBUTE_READONLY, 
		    (HANDLE) NULL); 
 
  if (hfbm == INVALID_HANDLE_VALUE)
    goto createfile_failed;

  /* Retrieve the BITMAPFILEHEADER structure. */ 
  if (ReadFile(hfbm, &bmfh, (DWORD) sizeof(BITMAPFILEHEADER), 
	       &dwRead, (LPOVERLAPPED) NULL) == FALSE)
    goto could_not_read_bitmap_file_header; 

  /* Retrieve the BITMAPINFOHEADER structure. */ 
  if (ReadFile(hfbm, &bmih, sizeof(BITMAPINFOHEADER), 
	       &dwRead, (LPOVERLAPPED) NULL) == FALSE) 
    goto could_not_read_bitmap_file_header; 
 
  /* Allocate memory for the BITMAPINFO structure. */ 
  if (bmih.biBitCount == 24) 
    hmem1 = GlobalAlloc(GHND, sizeof(BITMAPINFOHEADER));
  else
    hmem1 = GlobalAlloc(GHND, sizeof(BITMAPINFOHEADER) + 
       			((bmih.biClrUsed ?
			    bmih.biClrUsed :
			    (1<<bmih.biBitCount)) * sizeof(RGBQUAD)));
  if (hmem1 == NULL)
    goto could_not_create_bitmap_info_structure;

  lpbmi = GlobalLock(hmem1); 
  if (lpbmi == NULL)
    goto could_not_lock_bitmap_info_structure;

  /* 
   * Load BITMAPINFOHEADER into the BITMAPINFO 
   * structure. 
   */ 
  
  lpbmi->bmiHeader.biSize = bmih.biSize; 
  lpbmi->bmiHeader.biWidth = bmih.biWidth; 
  lpbmi->bmiHeader.biHeight = bmih.biHeight; 
  lpbmi->bmiHeader.biPlanes = bmih.biPlanes; 
  lpbmi->bmiHeader.biBitCount = bmih.biBitCount; 
  lpbmi->bmiHeader.biCompression = bmih.biCompression; 
  lpbmi->bmiHeader.biSizeImage = bmfh.bfSize - bmfh.bfOffBits;
  /* This was set to bmih.biSizeImage, but one bitmap we used had
   * an inconsistent value for this field.
   */
  lpbmi->bmiHeader.biXPelsPerMeter = bmih.biXPelsPerMeter; 
  lpbmi->bmiHeader.biYPelsPerMeter = bmih.biYPelsPerMeter; 
  lpbmi->bmiHeader.biClrUsed = bmih.biClrUsed; 
  lpbmi->bmiHeader.biClrImportant = bmih.biClrImportant; 
  
  /* 
   * Retrieve the color table. 
   * 1 << bmih.biBitCount == 2 ^ bmih.biBitCount 
   */ 
  if (bmih.biBitCount != 24) 
    if (ReadFile(hfbm, lpbmi->bmiColors, 
	         ((bmih.biClrUsed ? bmih.biClrUsed
			 : (1<<bmih.biBitCount)) * sizeof(RGBQUAD)), 
	         &dwRead, (LPOVERLAPPED) NULL) == FALSE)
      goto could_not_read_color_table; 
 
  /* 
   * Allocate memory for the required number of 
   * bytes. 
   */ 
  hmem2 = GlobalAlloc(GHND, (bmfh.bfSize - bmfh.bfOffBits)); 
  if (hmem2 == NULL)
    goto could_not_create_bitmap;

  lpvBits = GlobalLock(hmem2); 
  if (lpvBits == NULL)
    goto could_not_lock_bitmap;
  
  /* Retrieve the bitmap data. */ 
  if (ReadFile(hfbm, lpvBits, 
	       (bmfh.bfSize - bmfh.bfOffBits), 
	       &dwRead, (LPOVERLAPPED) NULL) == FALSE)
    goto could_not_read_bitmap; 
 
  /* 
   * Create a bitmap from the data stored in the 
   * .BMP file. 
   */ 

  hdc = GetDC(hwindow); 
  if (hdc == NULL)
    goto could_not_get_dc;

  hbm = CreateDIBitmap(hdc, &bmih, CBM_INIT, lpvBits, lpbmi, DIB_RGB_COLORS); 
  if (hbm == NULL)
    goto could_not_create_DIbitmap;


  /* 
   * Unlock the global memory objects and 
   * close the .BMP file. 
   */ 
  GlobalUnlock(hmem2); 
  GlobalFree(hmem2); 
  GlobalUnlock(hmem1); 
  GlobalFree(hmem1); 
  CloseHandle(hfbm); 
 
  /* Set the fDisplayBitmap flag. */ 
  fDisplayBitmap = TRUE; 
  
  /* Paint the window (and draw the bitmap). */ 
  if (GetClientRect(hwindow, &rect) == FALSE)
    goto could_not_get_rect; 
  if (InvalidateRect(hwindow, &rect, TRUE) == FALSE)
    goto could_not_invalidate_rect; 

  ShowWindow(hwindow, SW_SHOWNORMAL);
  UpdateWindow(hwindow); 
  /* Not much that we can do if UpdateWindow fails. */
  
  splash_font = CreateFont(11, 0,0,0, 300, 0,0,0,
			   ANSI_CHARSET, OUT_DEFAULT_PRECIS,
			   CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY,
			   VARIABLE_PITCH | FF_SWISS, "myfont");
  if (splash_font == NULL)
    goto could_not_create_font;
  
  oldFont = SelectObject(hdc, splash_font);
  if (oldFont == NULL)
    goto could_not_select_font;

  hdcMem = CreateCompatibleDC(hdc); 
  if (hdcMem == NULL)
    goto could_not_create_compatible_dc;
  if (SelectObject(hdcMem, hbm) == NULL)
    goto could_not_select_bitmap;
  if (GetObject(hbm, sizeof(BITMAP), (LPSTR) &bm) == 0)
    goto could_not_get_bitmap; 
  if (BitBlt(hdc, 0, 0, bm.bmWidth, bm.bmHeight, 
	     hdcMem, 0, 0, SRCCOPY) == FALSE)
    goto bitblt_failed; 
  DeleteDC(hdcMem); 
 
  version_font = CreateFont(30, 10,0,0, 300, 0,0,0,
			   ANSI_CHARSET, OUT_DEFAULT_PRECIS,
			   CLIP_DEFAULT_PRECIS, PROOF_QUALITY,
			   VARIABLE_PITCH | FF_SWISS, "Arial");
  
  if (kind != 2) {
    SelectObject(hdc, version_font);
    SetBkMode(hdc, TRANSPARENT);
    TextOut(hdc, 352, 18, szVersion, strlen(szVersion));
    SelectObject(hdc, oldFont);
  }

  /* Not much that we can do if TextOut or the last call to SelectObject
   * fail.
   */
  return MLTRUE;

 bitblt_failed: 
 could_not_get_bitmap: 
 could_not_select_bitmap:
  DeleteDC(hdcMem); 
 could_not_create_compatible_dc:
  SelectObject(hdc, oldFont);
 could_not_select_font:
 could_not_create_font:
  return MLTRUE;

 could_not_invalidate_rect:
 could_not_get_rect:
  return MLFALSE;

 could_not_create_DIbitmap:
 could_not_get_dc:
 could_not_read_bitmap:
  GlobalUnlock(hmem2); 
 could_not_lock_bitmap:
  GlobalFree(hmem2); 
 could_not_create_bitmap:
 could_not_read_color_table:
  GlobalUnlock(hmem1); 
 could_not_lock_bitmap_info_structure:
  
  GlobalFree(hmem1); 
 could_not_create_bitmap_info_structure:
 could_not_read_bitmap_file_header:
  CloseHandle(hfbm); 
 createfile_failed:
  return MLFALSE;
}

static mlval paint_splash_bitmap(mlval arg)
{
  BITMAP bm;
  HDC hdcMem;
  HDC hdc = CHDC(arg);
  HFONT oldFont;

  SetBkMode(hdc, OPAQUE);
  oldFont = SelectObject(hdc, splash_font);
  hdcMem = CreateCompatibleDC(hdc); 
  SelectObject(hdcMem, hbm); 
  GetObject(hbm, sizeof(BITMAP), (LPSTR) &bm); 
  BitBlt(hdc, 0, 0, bm.bmWidth, bm.bmHeight, 
	 hdcMem, 0, 0, SRCCOPY); 
  DeleteDC(hdcMem); 

  if (current_splash_kind != 2) {
    SelectObject(hdc, version_font);
    SetBkMode(hdc, TRANSPARENT);
    TextOut(hdc, 352, 18, szVersion, strlen(szVersion));
    SelectObject(hdc, oldFont); 
  }
  return MLUNIT;
}


/* MESSAGE WINDOWS */
/* This is accessed directly from the Capi */

static HWND message_widget;

static int count_newlines (const char *s)
{
  int count = 0;
  char last = 0;
  while (*s)
    {
      if (last != 13 && *s == 10)
	count++;
      last = *s;
      s++;
    }
  return (count);
}

static void munge_string (const char *from, char *to)
{
  char last = 0;
  while (*from)
    {
      if (last != 13 && *from == 10)
	*to++ = 13;
      *to++ = *from++;
    }
  *to = 0;
}



static void message_widget_output(const char *message)
{
  int count = count_newlines (message);

  /* This is only safe if the window procedure doesn't call ML */
  /* and also its parent's window procedure shouldn't call ML */

  if (count_newlines == 0) {
    SendMessage(message_widget, EM_REPLACESEL, (WPARAM)NULL, (LPARAM)message);
  } else {
    char *buff = alloc(strlen(message) + count + 1, "message_widget_output");
    munge_string(message,buff);
    SendMessage(message_widget, EM_REPLACESEL, (WPARAM)NULL, (LPARAM)buff);
    free(buff);
  }
}

static void message_widget_flush(void)
{
}

static mlval set_message_widget (mlval arg)
{
  message_widget = CHWND(arg);

  messager_function = message_widget_output;
  message_flusher = message_widget_flush;
  return MLUNIT;
}

static mlval no_message_widget (mlval unit)
{
  messager_function = NULL;
  return MLUNIT;
}

/* LIBRARY */

/* This is where the library code starts */

/* MISCELLANEOUS STUFF */
/* These are really just here for interacting with C */
/* They aren't part of the "real" windows interface */


/*
 * The return value of malloc is not tested here, instead
 * it is left to the ML side of things to decide what to
 * do if malloc returns NULL.
 */
static mlval ml_malloc(mlval arg)
{
  return box((UINT)malloc(CINT(arg)));
}


static mlval ml_free(mlval arg)
{
  free((char *)unbox(arg));
  return MLUNIT;
}

static mlval word_to_string (mlval arg)
{
  return (ml_string ((char *)unbox(arg)));
}

static mlval set_byte (mlval arg)
{
  char *ptr = (char *)unbox(FIELD (arg,0));
  int offset = CINT (FIELD (arg,1));
  char value = (char) CINT (FIELD(arg,2));
  *(ptr+offset) = value;
  return MLUNIT;
}

/* need to free the returned value from this */
static mlval make_c_string (mlval arg)
{
  char *string = CSTRING (arg);
  int len = strlen(string) + 1;
  char *buff = alloc(len, "make_c_string");
  strcpy(buff, string);
  return box((UINT)buff);
}

/* Error functions */

static void report_error(char* message)
{
  exn_raise_string(perv_exn_ref_win, message);
}

/* This seems to be the best we can do */
static void win32_error(char* err_message)
{
  LPSTR message, lpMsgBuf;
  DWORD bit32array[2];
  mlval ml_message;
  
  FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM,
		NULL, GetLastError(),
		MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
		(LPTSTR)&lpMsgBuf, 0, NULL);

  bit32array[0] = (DWORD)err_message;
  bit32array[1] = (DWORD)lpMsgBuf;

  FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_STRING |
		FORMAT_MESSAGE_ARGUMENT_ARRAY,
		(LPSTR)"%1: %2", 0, 0, (LPSTR)&message, 0, (va_list*)bit32array);

  MessageBox(NULL, message, "Windows API Error", MB_OK | MB_ICONERROR);
  LocalFree(lpMsgBuf);
  ml_message = ml_string(message);
  LocalFree(message);

  exn_raise_ml_string(perv_exn_ref_win, ml_message);
}

/* Basis datatypes */
  
/* this should use some sort of predefined type */    
static UINT convert_flags (mlval list, UINT values[])
{
  UINT result = 0L;
  while (list != MLNIL)
    {
      result |= values [CINT (FIELD (list,0))];
      list = FIELD (list,1);
    }
  return (result);
}

/* An enumeration of the supported messages.
   This should be in ASCII lexicographic order (exception: the WM_USER values
   should be last), and be consistent with *windows.sml.
   It would be nice to auto generate this lot.
 */

/* This is a placeholder for the FINDMSGSTRING message which is registered later */
/* Do not use 0xFFFFFFFF as this represents (-1) which is used elsewhere.  We are 
 * not even sure that 0x0FFFFFFF will never be used and so we also perform the 
 * check for what's expected.  The check also needs updated (FIND_MSG_INDEX value) 
 * every time any changes are made to the number of entries in the message_value 
 * list before the FIND_MSG entry - see winmain_init below.
 */
#define FIND_MSG 0x0FFFFFFF
#define FIND_MSG_INDEX 96

static UINT message_values[] =
{
  (UINT)BM_GETCHECK,
  (UINT)BM_GETSTATE,
  (UINT)BM_SETCHECK,
  (UINT)BM_SETSTATE,
  (UINT)BM_SETSTYLE,

  (UINT)BN_CLICKED,
  (UINT)BN_DISABLE,
  (UINT)BN_DOUBLECLICKED,
  (UINT)BN_HILITE,
  (UINT)BN_PAINT,
  (UINT)BN_UNHILITE,
  
  (UINT)CBN_CLOSEUP,
  (UINT)CBN_DBLCLK,
  (UINT)CBN_DROPDOWN,
  (UINT)CBN_EDITCHANGE,
  (UINT)CBN_EDITUPDATE,
  (UINT)CBN_ERRSPACE,
  (UINT)CBN_KILLFOCUS,
  (UINT)CBN_SELCHANGE,
  (UINT)CBN_SELENDCANCEL,
  (UINT)CBN_SELENDOK,
  (UINT)CBN_SETFOCUS,

  (UINT)CB_ADDSTRING,
  (UINT)CB_DELETESTRING,
  (UINT)CB_DIR,
  (UINT)CB_FINDSTRING,
  (UINT)CB_FINDSTRINGEXACT,
  (UINT)CB_GETCOUNT,
  (UINT)CB_GETCURSEL,
  (UINT)CB_GETDROPPEDCONTROLRECT,
  (UINT)CB_GETDROPPEDSTATE,
  (UINT)CB_GETDROPPEDWIDTH,
  (UINT)CB_GETEDITSEL,
  (UINT)CB_GETEXTENDEDUI,
  (UINT)CB_GETHORIZONTALEXTENT,
  (UINT)CB_GETITEMDATA,
  (UINT)CB_GETITEMHEIGHT,
  (UINT)CB_GETLBTEXT,
  (UINT)CB_GETLBTEXTLEN,
  (UINT)CB_GETLOCALE,
  (UINT)CB_GETTOPINDEX,
  (UINT)CB_INITSTORAGE,
  (UINT)CB_INSERTSTRING,
  (UINT)CB_LIMITTEXT,
  (UINT)CB_RESETCONTENT,
  (UINT)CB_SELECTSTRING,
  (UINT)CB_SETCURSEL,
  (UINT)CB_SETDROPPEDWIDTH,
  (UINT)CB_SETEDITSEL,
  (UINT)CB_SETEXTENDEDUI,
  (UINT)CB_SETHORIZONTALEXTENT,
  (UINT)CB_SETITEMDATA,
  (UINT)CB_SETITEMHEIGHT,
  (UINT)CB_SETLOCALE,
  (UINT)CB_SETTOPINDEX,
  (UINT)CB_SHOWDROPDOWN,

  (UINT)DM_GETDEFID,
  (UINT)DM_SETDEFID,

  (UINT)EM_CANUNDO,
  (UINT)EM_EMPTYUNDOBUFFER,
  (UINT)EM_FMTLINES,
  (UINT)EM_GETFIRSTVISIBLELINE,
  (UINT)EM_GETHANDLE,
  (UINT)EM_GETLINE,
  (UINT)EM_GETLINECOUNT,
  (UINT)EM_GETMODIFY,
  (UINT)EM_GETPASSWORDCHAR,
  (UINT)EM_GETRECT,
  (UINT)EM_GETSEL,
  (UINT)EM_GETWORDBREAKPROC,
  (UINT)EM_LIMITTEXT,
  (UINT)EM_LINEFROMCHAR,
  (UINT)EM_LINEINDEX,
  (UINT)EM_LINELENGTH,
  (UINT)EM_LINESCROLL,
  (UINT)EM_REPLACESEL,
  (UINT)EM_SCROLL,
  (UINT)EM_SCROLLCARET,
  (UINT)EM_SETHANDLE,
  (UINT)EM_SETMODIFY,
  (UINT)EM_SETPASSWORDCHAR,
  (UINT)EM_SETREADONLY,
  (UINT)EM_SETRECT,
  (UINT)EM_SETRECTNP,
  (UINT)EM_SETSEL,
  (UINT)EM_SETTABSTOPS,
  (UINT)EM_SETWORDBREAKPROC,
  (UINT)EM_UNDO,

  (UINT)EN_CHANGE,
  (UINT)EN_ERRSPACE,
  (UINT)EN_HSCROLL,
  (UINT)EN_KILLFOCUS,
  (UINT)EN_MAXTEXT,
  (UINT)EN_SETFOCUS,
  (UINT)EN_UPDATE,
  (UINT)EN_VSCROLL,

  (UINT)FIND_MSG,

  /* NB: N < _ < n in ascii ordering */
  (UINT)LBN_DBLCLK,
  (UINT)LBN_ERRSPACE,
  (UINT)LBN_KILLFOCUS,
  (UINT)LBN_SELCANCEL,
  (UINT)LBN_SELCHANGE,
  (UINT)LBN_SETFOCUS,

  (UINT)LB_ADDFILE,
  (UINT)LB_ADDSTRING,
  (UINT)LB_DELETESTRING,
  (UINT)LB_DIR,
  (UINT)LB_FINDSTRING,
  (UINT)LB_FINDSTRINGEXACT,
  (UINT)LB_GETANCHORINDEX,
  (UINT)LB_GETCARETINDEX,
  (UINT)LB_GETCOUNT,
  (UINT)LB_GETCURSEL,
  (UINT)LB_GETHORIZONTALEXTENT,
  (UINT)LB_GETITEMDATA,
  (UINT)LB_GETITEMHEIGHT,
  (UINT)LB_GETITEMRECT,
  (UINT)LB_GETLOCALE,
  (UINT)LB_GETSEL,
  (UINT)LB_GETSELCOUNT,
  (UINT)LB_GETSELITEMS,
  (UINT)LB_GETTEXT,
  (UINT)LB_GETTEXTLEN,
  (UINT)LB_GETTOPINDEX,
  (UINT)LB_INSERTSTRING,
  (UINT)LB_RESETCONTENT,
  (UINT)LB_SELECTSTRING,
  (UINT)LB_SELITEMRANGE,
  (UINT)LB_SELITEMRANGEEX,
  (UINT)LB_SETANCHORINDEX,
  (UINT)LB_SETCARETINDEX,
  (UINT)LB_SETCOLUMNWIDTH,
  (UINT)LB_SETCOUNT,
  (UINT)LB_SETCURSEL,
  (UINT)LB_SETHORIZONTALEXTENT,
  (UINT)LB_SETITEMDATA,
  (UINT)LB_SETITEMHEIGHT,
  (UINT)LB_SETLOCALE,
  (UINT)LB_SETSEL,
  (UINT)LB_SETTABSTOPS,
  (UINT)LB_SETTOPINDEX,
  
  (UINT)TB_GETSTATE,
  (UINT)TB_SETSTATE,

  (UINT)WM_ACTIVATE,
  (UINT)WM_ACTIVATEAPP,
  (UINT)WM_CANCELMODE,
  (UINT)WM_CHAR,
  (UINT)WM_CHARTOITEM,
  (UINT)WM_CHILDACTIVATE,
  (UINT)WM_CLOSE,
  (UINT)WM_COMMAND,
  (UINT)WM_CONTEXTMENU,
  (UINT)WM_COPY,
  (UINT)WM_COPYDATA,
  (UINT)WM_CREATE,
  (UINT)WM_CTLCOLORBTN,
  (UINT)WM_CTLCOLOREDIT,
  (UINT)WM_CUT,
  (UINT)WM_DEADCHAR,
  (UINT)WM_DESTROY,
  (UINT)WM_ENABLE,
  (UINT)WM_ENDSESSION,
  (UINT)WM_ERASEBKGND,
  (UINT)WM_GETFONT,
  (UINT)WM_GETMINMAXINFO,
  (UINT)WM_GETTEXT,
  (UINT)WM_GETTEXTLENGTH,
  (UINT)WM_HOTKEY,
  (UINT)WM_HSCROLL,
  (UINT)WM_INITDIALOG,
  (UINT)WM_INITMENU,
  (UINT)WM_KEYDOWN,
  (UINT)WM_KEYUP,
  (UINT)WM_KILLFOCUS,
  (UINT)WM_LBUTTONDBLCLK,
  (UINT)WM_LBUTTONDOWN,
  (UINT)WM_LBUTTONUP,
  (UINT)WM_MBUTTONDBLCLK,
  (UINT)WM_MBUTTONDOWN,
  (UINT)WM_MBUTTONUP,
  (UINT)WM_MOUSEACTIVATE,
  (UINT)WM_MOUSEMOVE,
  (UINT)WM_MOVE,
  (UINT)WM_NCACTIVATE,
  (UINT)WM_NCCALCSIZE,
  (UINT)WM_NCCREATE,
  (UINT)WM_NCDESTROY,
  (UINT)WM_NCHITTEST,
  (UINT)WM_NCLBUTTONDBLCLK,
  (UINT)WM_NCLBUTTONDOWN,
  (UINT)WM_NCLBUTTONUP,
  (UINT)WM_NCMBUTTONDBLCLK,
  (UINT)WM_NCMBUTTONDOWN,
  (UINT)WM_NCMBUTTONUP,
  (UINT)WM_NCMOUSEMOVE,
  (UINT)WM_NCRBUTTONDBLCLK,
  (UINT)WM_NCRBUTTONDOWN,
  (UINT)WM_NCRBUTTONUP,
  (UINT)WM_NOTIFY,
  /* In the book but not defined! */
  /* (UINT)WM_OPENICON, */
  (UINT)WM_PAINT,
  (UINT)WM_PARENTNOTIFY,
  (UINT)WM_PASTE,
  (UINT)WM_POWER,
  (UINT)WM_QUERYENDSESSION,
  (UINT)WM_QUERYOPEN,
  (UINT)WM_QUEUESYNC,
  (UINT)WM_QUIT,
  (UINT)WM_RBUTTONDBLCLK,
  (UINT)WM_RBUTTONDOWN,
  (UINT)WM_RBUTTONUP,
  (UINT)WM_SETCURSOR,
  (UINT)WM_SETFOCUS,
  (UINT)WM_SETFONT,
  (UINT)WM_SETREDRAW,
  (UINT)WM_SETTEXT,
  (UINT)WM_SHOWWINDOW,
  (UINT)WM_SIZE,
  (UINT)WM_SIZING,
  (UINT)WM_SYSCHAR,
  (UINT)WM_SYSCOMMAND,
  (UINT)WM_SYSDEADCHAR,
  (UINT)WM_SYSKEYDOWN,
  (UINT)WM_SYSKEYUP,
  (UINT)WM_UNDO,
  (UINT)WM_USER,
  (UINT)WM_USER + 1,
  (UINT)WM_USER + 2,
  (UINT)WM_USER + 3,
  (UINT)WM_USER + 4,
  (UINT)WM_USER + 5,
  (UINT)WM_VSCROLL,
  (UINT)WM_WINDOWPOSCHANGED,
  (UINT)WM_WINDOWPOSCHANGING


/* In the book but not defined! */
/*
  (UINT)WN_DELETEITEM,
  (UINT)WN_VKEYTOITEM
*/
  };

static UINT convert_message (mlval arg)
{
  return (message_values[CINT (arg)]);
}

static mlval ml_convert_message (mlval arg)
{
  return (box (convert_message (arg)));
}

static UINT sb_values[] =
{
  SB_BOTH,
  SB_BOTTOM,
  SB_CTL,
  SB_ENDSCROLL,
  SB_HORZ,
  SB_LINEDOWN,
  SB_LINELEFT,
  SB_LINERIGHT,
  SB_LINEUP,
  SB_PAGEDOWN,
  SB_PAGELEFT,
  SB_PAGERIGHT,
  SB_PAGEUP,
  SB_THUMBPOSITION,
  SB_THUMBTRACK,
  SB_TOP,
  SB_VERT
};

static UINT convert_sb_value (mlval arg)
{
  DIAGNOSTIC(4, "convert_sb_value:%d", CINT(arg), 0);
  return (sb_values[CINT (arg)]);
}

static mlval ml_convert_sb_value (mlval arg)
{
  return (MLINT (convert_sb_value (arg)));
}

static UINT sc_values[] =
{
  SC_CLOSE,
  SC_CONTEXTHELP,
  SC_DEFAULT,
  SC_HOTKEY,
  SC_HSCROLL,
  SC_KEYMENU,
  SC_MAXIMIZE,
  SC_MINIMIZE,
  SC_MOUSEMENU,
  SC_MOVE,
  SC_NEXTWINDOW,
  SC_PREVWINDOW,
  SC_RESTORE,
  SC_SCREENSAVE,
  SC_SIZE,
  SC_TASKLIST,
  SC_VSCROLL
};

static UINT convert_sc_value (mlval arg)
{
  return (sc_values[CINT (arg)]);
}

static mlval ml_convert_sc_value (mlval arg)
{
  return (MLINT (convert_sc_value (arg)));
}

static UINT wa_values[] =
{
  WA_ACTIVE,
  WA_CLICKACTIVE,
  WA_INACTIVE
};

static UINT convert_wa_value(mlval arg)
{
  return wa_values[CINT(arg)];
}

static mlval ml_convert_wa_value(mlval arg)
{
  return MLINT(convert_wa_value(arg));
}

static UINT esb_values [] =
{
  ESB_DISABLE_BOTH,
  ESB_DISABLE_DOWN,
  ESB_DISABLE_LEFT,
  ESB_DISABLE_LTUP,
  ESB_DISABLE_RIGHT,
  ESB_DISABLE_RTDN,
  ESB_DISABLE_UP,
  ESB_ENABLE_BOTH
};

static UINT convert_esb_value (mlval arg)
{
  return (esb_values[CINT (arg)]);
}

/* it's important for this to be in lexical ordering */
static UINT style_values[] =
{ 
  BS_3STATE,
  BS_AUTO3STATE,
  BS_AUTOCHECKBOX,
  BS_AUTORADIOBUTTON,
  BS_CHECKBOX,
  BS_DEFPUSHBUTTON,
  BS_GROUPBOX,
  BS_LEFTTEXT,
  BS_OWNERDRAW,
  BS_PUSHBUTTON,
  BS_RADIOBUTTON,
  BS_USERBUTTON,

  CBS_AUTOHSCROLL,
  CBS_DISABLENOSCROLL,
  CBS_DROPDOWN,
  CBS_DROPDOWNLIST,
  CBS_HASSTRINGS,
  CBS_NOINTEGRALHEIGHT,
  CBS_OEMCONVERT,
  CBS_OWNERDRAWFIXED,
  CBS_OWNERDRAWVARIABLE,
  CBS_SIMPLE,
  CBS_SORT,

  DS_ABSALIGN,
  DS_LOCALEDIT,
  DS_MODALFRAME,
  DS_NOIDLEMSG,
  DS_SETFONT,
  DS_SETFOREGROUND,
  DS_SYSMODAL,

  ES_AUTOHSCROLL,
  ES_AUTOVSCROLL,
  ES_CENTER,
  ES_LEFT,
  ES_LOWERCASE,
  ES_MULTILINE,
  ES_NOHIDESEL,
  ES_OEMCONVERT,
  ES_PASSWORD,
  ES_READONLY,
  ES_RIGHT,
  ES_UPPERCASE,
  ES_WANTRETURN,

  LBS_DISABLENOSCROLL,
  LBS_EXTENDEDSEL,
  LBS_HASSTRINGS,
  LBS_MULTICOLUMN,
  LBS_MULTIPLESEL,
  LBS_NODATA,
  LBS_NOINTEGRALHEIGHT,
  LBS_NOREDRAW,
  LBS_NOTIFY,
  LBS_OWNERDRAWFIXED,
  LBS_OWNERDRAWVARIABLE,
  LBS_SORT,
  LBS_STANDARD,
  LBS_USETABSTOPS,
  LBS_WANTKEYBOARDINPUT,

  SBS_BOTTOMALIGN,
  SBS_HORZ,
  SBS_LEFTALIGN,
  SBS_RIGHTALIGN,
  SBS_SIZEBOX,
  SBS_SIZEBOXBOTTOMRIGHTALIGN,
  SBS_SIZEBOXTOPLEFTALIGN,
  SBS_TOPALIGN,
  SBS_VERT,

  SS_BLACKFRAME,
  SS_BLACKRECT,
  SS_CENTER,
  SS_GRAYFRAME,
  SS_GRAYRECT,
  SS_ICON,
  SS_LEFT,
  SS_LEFTNOWORDWRAP,
  SS_NOPREFIX,
  SS_RIGHT,
  SS_SIMPLE,
  SS_WHITEFRAME,
  SS_WHITERECT,

  TBSTYLE_ALTDRAG,
  TBSTYLE_TOOLTIPS,
  TBSTYLE_WRAPABLE,

  WS_BORDER,
  WS_CAPTION,
  WS_CHILD,
  WS_CLIPCHILDREN,
  WS_CLIPSIBLINGS,
  WS_DISABLED,
  WS_DLGFRAME,
  WS_GROUP,
  WS_HSCROLL,
  WS_ICONIC,
  WS_MAXIMIZE,
  WS_MAXIMIZEBOX,
  WS_MINIMIZE,
  WS_MINIMIZEBOX,
  WS_OVERLAPPED,
  WS_OVERLAPPEDWINDOW,
  WS_POPUP,
  WS_POPUPWINDOW,
  WS_SYSMENU,
  WS_TABSTOP,
  WS_THICKFRAME,
  WS_TILEDWINDOW,
  WS_VISIBLE,
  WS_VSCROLL
  };

static UINT convert_styles (mlval styles)
{
  return (convert_flags (styles,style_values));
}

static mlval ml_convert_window_style(mlval arg)
{
  return box(style_values[CINT(arg)]);
}

static UINT ex_style_values[] = 
{
  WS_EX_DLGMODALFRAME,
  WS_EX_STATICEDGE,
  WS_EX_WINDOWEDGE
};

static UINT convert_ex_styles (mlval ex_styles)
{
  return (convert_flags (ex_styles, ex_style_values));
}

static UINT menu_flag_values[] =
{
  MF_BITMAP,
  MF_BYCOMMAND,
  MF_BYPOSITION,
  MF_CHECKED,
  MF_DISABLED,
  MF_ENABLED,
  MF_GRAYED,
  MF_MENUBARBREAK,
  MF_MENUBREAK,
  MF_OWNERDRAW,
  MF_POPUP,
  MF_SEPARATOR,
  MF_STRING,
  MF_UNCHECKED
};

static UINT convert_menu_flags (mlval menu_flags)
{
  return (convert_flags (menu_flags,menu_flag_values));
}

static UINT convert_menu_flag (mlval menu_flag)
{
  return (menu_flag_values[CINT(menu_flag)]);
}

/* WINDOW FUNCTIONS */

static UINT sw_values[] =
{
  SW_HIDE,
  SW_MAXIMIZE,
  SW_MINIMIZE,
  SW_RESTORE,
  SW_SHOW,
  SW_SHOWDEFAULT,
  SW_SHOWMAXIMIZED,
  SW_SHOWMINIMIZED,
  SW_SHOWMINNOACTIVE,
  SW_SHOWNA,
  SW_SHOWNOACTIVATE,
  SW_SHOWNORMAL
  };

static UINT convert_sw_arg (mlval arg)
{
  return (sw_values[CINT (arg)]);
}

static UINT gw_values[] =
{
  GW_CHILD,
  GW_HWNDFIRST,
  GW_HWNDLAST,
  GW_HWNDNEXT,
  GW_HWNDPREV,
  GW_OWNER
};

static UINT convert_gw_arg (mlval arg)
{
  return (gw_values[CINT (arg)]);
}

static mlval min_window_size (mlval arg)
{
  WPARAM wparam = (WPARAM)unbox (FIELD (arg, 0));
  LPARAM lparam = (LPARAM)unbox (FIELD (arg, 1));
  int min_x = CINT(FIELD (arg, 2));
  int min_y = CINT(FIELD (arg, 3));
  LPRECT lprc = (LPRECT) lparam;

  /* The window size is set by changing the absolute positions of the
   * sides of the window.  The window edge to be changed is determined by
   * which edge the user tried to resize from. */

  if ((lprc->right - lprc->left) < min_x) 
    switch (wparam) {
    case WMSZ_BOTTOMLEFT:
    case WMSZ_LEFT:
    case WMSZ_TOPLEFT:
      lprc->left = lprc->right - min_x;
      break;
    case WMSZ_BOTTOMRIGHT:
    case WMSZ_RIGHT:
    case WMSZ_TOPRIGHT:
      lprc->right = lprc->left + min_x;
      break;
    }
  
  if ((lprc->bottom - lprc->top) < min_y)
    switch (wparam) {
    case WMSZ_BOTTOMLEFT:
    case WMSZ_BOTTOM:
    case WMSZ_BOTTOMRIGHT:
      lprc->bottom = lprc->top + min_y;
      break;
    case WMSZ_TOPLEFT:
    case WMSZ_TOP:
    case WMSZ_TOPRIGHT:
      lprc->top = lprc->bottom - min_y;
      break;
    }

  return MLUNIT;
}

/* Ch. 1 General windows functions */

static mlval any_popup (mlval arg)
{
  return (MLBOOL (AnyPopup()));
}

static mlval bring_window_to_top (mlval arg)
{
  BringWindowToTop (CHWND (arg));
  return MLUNIT;
}

static mlval center_window(mlval arg)
{
  HWND window = CHWND(FIELD(arg, 0));
  HWND wall = CHWND(FIELD(arg, 1));

  if (!CenterWindow(window, wall)) 
    win32_error("CenterWindow failed");

  return MLUNIT;
}

static mlval child_window_from_point (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  mlval p = FIELD (arg,1);
  POINT point;
  point.x = CINT (FIELD (p,0));
  point.y = CINT (FIELD (p,1));
  return MLHWND (ChildWindowFromPoint (hwnd,point));
}

static mlval close_window (mlval arg)
{
  CloseWindow (CHWND (arg));
  return MLUNIT;
}

/* Perhaps this should be closer to the Windows function */
static mlval create_window(mlval arg)
{
  HWND            hWnd; /* Main window handle. */
  /* ml records must be in alphabetical order */
  /* params are in order {class,height,menu,name,parent,styles,width} */
  char* class = CSTRING (FIELD (arg,0));
  int height = CINT (FIELD (arg,1));
  HMENU hmenu = CHMENU (FIELD (arg,2));
  char* name = CSTRING (FIELD (arg,3));
  HWND parent = CHWND(FIELD (arg,4));
  mlval styles = FIELD (arg,5);
  int width = CINT (FIELD (arg,6));

  /* Create a child window */

  hWnd = CreateWindow(class,              /* See RegisterClass() call. */
		      name,                /* Text for window title bar. */
		      convert_styles (styles), /* Window style. */
		      CW_USEDEFAULT,       /* Horizontal default position */
		      0,                   /* Ignored since x = CW_USEDEFAULT */
		      width,               /* Horizontal width */
		      height,              /* Vertical height */
		      parent,
		      hmenu,                /* Use the window class menu. */
		      hInst,               /* This instance owns this window. */
		      NULL                 /* We don't use any data in our WM_CREATE */
		      );

  /* If window could not be created, fail */
  if (!hWnd)
    win32_error ("Failed to create window");

  return MLHWND(hWnd);
}

static mlval create_window_ex(mlval arg)
{
  HWND            hWnd; /* Main window handle. */
  /* ml records must be in alphabetical order */
  /* params are in order 
     {class,ex_style,height,menu,name,parent,styles,width,x,y} */
  char* class = CSTRING (FIELD (arg,0));
  mlval ex_styles = FIELD (arg,1);
  int height = CINT (FIELD (arg,2));
  HMENU hmenu = CHMENU (FIELD (arg,3));
  char* name = CSTRING (FIELD (arg,4));
  HWND parent = CHWND(FIELD (arg,5));
  mlval styles = FIELD (arg,6);
  int width = CINT (FIELD (arg,7));
  int xpos = CINT (FIELD (arg,8));
  int ypos = CINT (FIELD (arg,9));

  /* Create a child window */

  hWnd = CreateWindowEx(convert_ex_styles(ex_styles), /* Extended styles */
			class,              /* See RegisterClass() call. */
			name,               /* Text for window title bar. */
			convert_styles (styles), /* Window style. */
			xpos,            /* Horizontal position */
			ypos,            /* Vertical position */
			width,           /* Horizontal width */
			height,          /* Vertical height */
			parent,
			hmenu,           /* Use the window class menu. */
			hInst,           /* This instance owns this window. */
			NULL             /* We don't use any data in our WM_CREATE */
		      );

  /* If window could not be created, fail */
  if (!hWnd)
    win32_error ("Failed to create window");

  return MLHWND(hWnd);
}

static mlval destroy_window (mlval arg)
{
  DestroyWindow (CHWND (arg));
  return MLUNIT;
}

static BOOL CALLBACK MLEnumProc (HWND hwndChild,LPARAM lParam)
{
  DIAGNOSTIC(4, "MLEnumProc on %u", hwndChild, 0);
  /* We should check we are not in a GC here really I suppose maybe */
  callml (MLHWND (hwndChild),*(mlval *)lParam);
  return TRUE;
}

static mlval enum_windows (mlval callback)
{
  BOOL result;
  declare_root (&callback, 0);
  result = EnumWindows (MLEnumProc,(LPARAM)(&callback));
  retract_root (&callback);
  if (!result)
    win32_error ("EnumWindows failed");
  return MLUNIT;
}

static mlval enum_child_windows (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  BOOL result;
  mlval callback = FIELD (arg,1);
  declare_root (&callback, 0);
  result = EnumChildWindows (hwnd,MLEnumProc,(LPARAM)(&callback));
  retract_root (&callback);
  if (!result)
    win32_error ("EnumChildWindows failed");
  return MLUNIT;
}

static mlval find_window (mlval arg)
{
  LPCTSTR classname = CSTRING (FIELD (arg,0));
  LPCTSTR windowname = CSTRING (FIELD (arg,1));
  return (MLHWND (FindWindow (classname,windowname)));
}

static mlval get_client_rect (mlval arg)
{
  HWND hwnd = CHWND (arg);
  RECT rect;
  mlval result;
  GetClientRect (hwnd,&rect);
  result = allocate_record (4);
  /* order is bottom,left,right,top */
  FIELD (result,0) = MLINT (rect.bottom);
  FIELD (result,1) = MLINT (rect.left);
  FIELD (result,2) = MLINT (rect.right);
  FIELD (result,3) = MLINT (rect.top);
  return (result);
}

static mlval get_desktop_window (mlval arg)
{
  return (MLHWND (GetDesktopWindow ()));
}

static mlval get_foreground_window (mlval arg)
{
  return (MLHWND (GetForegroundWindow ()));
}

static mlval get_last_active_popup (mlval arg)
{
  return (MLHWND (GetLastActivePopup (CHWND (arg))));
}

static mlval get_next_window (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT cmd = convert_gw_arg (FIELD (arg,1));
  return MLHWND (GetNextWindow (hwnd,cmd));
}

static mlval get_parent (mlval arg)
{
  return MLHWND(GetParent (CHWND (arg)));
}

static mlval get_top_window (mlval arg)
{
  return MLHWND(GetTopWindow (CHWND (arg)));
}

static mlval get_window (mlval arg)
{
  HWND hwnd = CHWND(FIELD (arg,0));
  UINT gw_value= convert_gw_arg(FIELD(arg,1));
  return MLHWND(GetWindow(hwnd,gw_value));
}

static mlval get_window_rect (mlval arg)
{
  HWND hwnd = CHWND (arg);
  RECT rect;
  mlval result;
  GetWindowRect (hwnd,&rect);
  result = allocate_record (4);
  /* order is bottom,left,right,top */
  FIELD (result,0) = MLINT (rect.bottom);
  FIELD (result,1) = MLINT (rect.left);
  FIELD (result,2) = MLINT (rect.right);
  FIELD (result,3) = MLINT (rect.top);
  return (result);
}

static mlval get_window_placement(mlval arg)
{
  HWND hwnd = CHWND(arg);
  mlval result;
  mlval minpos;
  mlval maxpos;
  mlval normal;
  WINDOWPLACEMENT place;
  int success;

  place.length = sizeof(WINDOWPLACEMENT);

  success = GetWindowPlacement(hwnd, &place);
  if (!success) win32_error("GetWindowPlacement failed");

  normal = allocate_record(4);
  FIELD(normal, 0) = MLINT(place.rcNormalPosition.bottom);
  FIELD(normal, 1) = MLINT(place.rcNormalPosition.left);
  FIELD(normal, 2) = MLINT(place.rcNormalPosition.right);
  FIELD(normal, 3) = MLINT(place.rcNormalPosition.top);

  declare_root(&normal, 0);
  minpos = allocate_record(2);
  FIELD(minpos, 0) = MLINT(place.ptMinPosition.x);
  FIELD(minpos, 1) = MLINT(place.ptMinPosition.y);

  declare_root(&minpos, 0);
  maxpos = allocate_record(2);
  FIELD(maxpos, 0) = MLINT(place.ptMaxPosition.x);
  FIELD(maxpos, 1) = MLINT(place.ptMaxPosition.y);

  declare_root(&maxpos, 0);

  result = allocate_record(4);
  if (place.showCmd == SW_MINIMIZE)
    FIELD(result, 0) = MLINT(1);
  else if (place.showCmd == SW_MAXIMIZE)
    FIELD(result, 0) = MLINT(2);
  else
    FIELD(result, 0) = MLINT(0);
  FIELD(result, 1) = minpos;
  FIELD(result, 2) = maxpos;
  FIELD(result, 3) = normal;

  retract_root(&normal);
  retract_root(&minpos);
  retract_root(&maxpos);

  return result;
}

static mlval is_child (mlval arg)
{
  return (MLBOOL (IsChild (CHWND (FIELD (arg,0)),
			   CHWND (FIELD (arg,1)))));
}

static mlval is_iconic (mlval arg)
{
  return (MLBOOL (IsIconic (CHWND (arg))));
}

static mlval is_window (mlval arg)
{
  return (MLBOOL (IsWindow (CHWND (arg))));
}

static mlval is_window_unicode (mlval arg)
{
  return (MLBOOL (IsWindowUnicode (CHWND (arg))));
}

static mlval is_window_visible (mlval arg)
{
  return (MLBOOL (IsWindowVisible (CHWND (arg))));
}

static mlval is_zoomed (mlval arg)
{
  return (MLBOOL (IsZoomed (CHWND (arg))));
}

static mlval move_window (mlval arg)
{
  HWND window = CHWND(FIELD (arg,0));
  int x = CINT (FIELD (arg,1));
  int y = CINT (FIELD (arg,2));
  int width = CINT (FIELD (arg,3));
  int height = CINT (FIELD (arg,4));
  int foo = FIELD (arg,5) != MLFALSE;


  MoveWindow (window,x,y,width,height,foo);
  return MLUNIT;
}

static mlval set_foreground_window (mlval arg)
{
  HWND hwnd = CHWND (arg);
  if (!SetForegroundWindow (hwnd))
    win32_error ("SetForegroundWindow failed");
  return MLUNIT;
}

static mlval set_parent (mlval arg)
{
  HWND child = CHWND (FIELD (arg,0));
  HWND parent = CHWND (FIELD (arg,1));
  return MLHWND (SetParent (child,parent));
}

static mlval set_window_text (mlval arg)
{
  HWND window = CHWND (FIELD (arg,0));
  LPCTSTR text = CSTRING (FIELD (arg,1));
  if (!SetWindowText (window,text))
    win32_error ("SetWindowText failed");
  return MLUNIT;
}

static mlval set_window_pos(mlval arg)
{
  HWND window = CHWND(FIELD(arg, 0));
  mlval dimen = FIELD(arg, 1);

  /* Ensure these fields are in alphabetical 
     order as they are stored in an ML record */
  int height = CINT(FIELD(dimen, 0));
  int width = CINT(FIELD(dimen, 1));
  int x = CINT(FIELD(dimen, 2));
  int y = CINT(FIELD(dimen, 3));

  if (!SetWindowPos(window, NULL, x, y, width, height, SWP_NOZORDER))
    win32_error("SetWindowPos failed");
  return MLUNIT;
}

static mlval show_owned_popups (mlval arg)
{
  HWND window = CHWND (FIELD (arg,0));
  BOOL b = CBOOL (FIELD (arg,1));
  if (!ShowOwnedPopups (window,b))
    win32_error ("ShowOwnedPopups failed");
  return MLUNIT;
}

static mlval show_window (mlval arg)
{
  ShowWindow (CHWND(FIELD (arg,0)),convert_sw_arg (FIELD (arg,1)));
  return MLUNIT;
}

static mlval update_window (mlval arg)
{
  UpdateWindow (CHWND(arg));
  return MLUNIT;
}

static mlval window_from_point (mlval arg)
{
  POINT point;
  point.x = CINT (FIELD (arg,0));
  point.y = CINT (FIELD (arg,1));
  return MLHWND (WindowFromPoint (point));
}

static mlval get_minmax_info(mlval arg)
{
  LPMINMAXINFO lpminmax = (LPMINMAXINFO)unbox(arg);
  mlval maxsize; 
  mlval maxpos;
  mlval mintrack;
  mlval maxtrack;

  mlval result;

  maxsize = allocate_record(2);
  FIELD(maxsize, 0) = MLINT(lpminmax->ptMaxSize.x);
  FIELD(maxsize, 1) = MLINT(lpminmax->ptMaxSize.y);
  declare_root(&maxsize, 0);

  maxpos = allocate_record(2);
  FIELD(maxpos, 0) = MLINT(lpminmax->ptMaxPosition.x);
  FIELD(maxpos, 1) = MLINT(lpminmax->ptMaxPosition.y);
  declare_root(&maxpos, 0);

  mintrack = allocate_record(2);
  FIELD(mintrack, 0) = MLINT(lpminmax->ptMinTrackSize.x);
  FIELD(mintrack, 1) = MLINT(lpminmax->ptMinTrackSize.y);
  declare_root(&mintrack, 0);

  maxtrack = allocate_record(2);
  FIELD(maxtrack, 0) = MLINT(lpminmax->ptMaxTrackSize.x);
  FIELD(maxtrack, 1) = MLINT(lpminmax->ptMaxTrackSize.y);
  declare_root(&maxtrack, 0);

  result = allocate_record(4);
  FIELD(result, 0) = maxsize;
  FIELD(result, 1) = maxpos;
  FIELD(result, 2) = mintrack;
  FIELD(result, 3) = maxtrack;
  retract_root(&maxsize);
  retract_root(&maxpos);
  retract_root(&mintrack);
  retract_root(&maxtrack);

  return result;
}

static mlval set_minmax_info(mlval arg)
{
  LPMINMAXINFO lpminmax = (LPMINMAXINFO)unbox(FIELD(arg, 0));
  mlval maxsize = FIELD(arg, 1);
  mlval maxpos = FIELD(arg, 2);
  mlval mintrack = FIELD(arg, 3);
  mlval maxtrack = FIELD(arg, 4);
  
  lpminmax->ptMaxSize.x = CINT(FIELD(maxsize, 0));
  lpminmax->ptMaxSize.y = CINT(FIELD(maxsize, 1));

  lpminmax->ptMaxPosition.x = CINT(FIELD(maxpos, 0));
  lpminmax->ptMaxPosition.y = CINT(FIELD(maxpos, 1));

  lpminmax->ptMinTrackSize.x = CINT(FIELD(mintrack, 0));
  lpminmax->ptMinTrackSize.y = CINT(FIELD(mintrack, 1));

  lpminmax->ptMaxTrackSize.x = CINT(FIELD(maxtrack, 0));
  lpminmax->ptMaxTrackSize.y = CINT(FIELD(maxtrack, 1));

  return box((UINT)lpminmax);
}

/* Ch. 2 Messages & Message Queues */

static mlval get_input_state (mlval arg)
{
  return (MLBOOL (GetInputState()));
}

static mlval get_message_pos (mlval arg)
{
  long pos = GetMessagePos();
  mlval result = allocate_record (2);
  FIELD (result,0) = MLINT (LOWORD (pos));
  FIELD (result,1) = MLINT (HIWORD (pos));
  return (result);
}
  
static mlval get_message_time (mlval arg)
{
  return (CINT (GetMessageTime()));
}

static mlval in_send_message (mlval arg)
{
  return (MLBOOL (InSendMessage()));
}

static mlval post_message (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT message = convert_message (FIELD (arg,1));
  WPARAM wparam = (WPARAM)unbox (FIELD (arg,2));
  LPARAM lparam = (LPARAM)unbox (FIELD (arg,3));
  if (!PostMessage (hwnd,message,wparam,lparam))
    win32_error ("PostMessage failed");
  return MLUNIT;
}

static mlval post_quit_message (mlval arg)
{
  PostQuitMessage (CINT (arg));
  return MLUNIT;
}

static mlval send_message (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT message = convert_message (FIELD (arg,1));
  WPARAM wparam = (WPARAM)unbox(FIELD (arg,2));
  LPARAM lparam = (LPARAM)unbox(FIELD (arg,3));
  LRESULT lresult;
  DIAGNOSTIC(4, "Sending message %u to %u", message, hwnd);
  lresult = SendMessage (hwnd,message,wparam,lparam);
  return (box (lresult));
}

/* Ch. 3 Window Classes */

static mlval get_window_long (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int offset = CINT (FIELD (arg,1));
  return (box ((UINT)GetWindowLong (hwnd,offset)));
}

static mlval set_window_long (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int offset = CINT (FIELD (arg,1));
  int value = (LONG) (unbox (FIELD (arg,2)));
  UINT result;
  result = (UINT)SetWindowLong (hwnd,offset,value);
  DIAGNOSTIC(4, "set_window_long %d[%d]", hwnd, offset);
  DIAGNOSTIC(4, "to %d, returns %d",value,result);
  return (box (result));
}

/* Ch. 5 Keyboard Input */
static mlval enable_window (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  BOOL enabled = CBOOL (FIELD (arg,1));
  return (MLBOOL (EnableWindow (hwnd,enabled)));
}

static mlval get_active_window (mlval arg)
{
  return (MLHWND (GetActiveWindow ()));
}

static mlval get_focus (mlval arg)
{
  return (MLHWND (GetFocus ()));
}

static mlval is_window_enabled (mlval arg)
{
  HWND hwnd = CHWND (arg);
  return (MLBOOL (IsWindowEnabled (hwnd)));
}

static mlval set_active_window (mlval arg)
{
  return (MLHWND (SetActiveWindow (CHWND (arg))));
}

static mlval set_focus (mlval arg)
{
  return (MLHWND (SetFocus (CHWND (arg))));
}

/* Ch. 6 Mouse input */
static mlval get_capture (mlval arg)
{
  return (MLHWND (GetCapture ()));
}

static mlval release_capture (mlval arg)
{
  if (!ReleaseCapture ())
    win32_error ("ReleaseCapture failed");
  return MLUNIT;
}


static mlval set_capture (mlval arg)
{
  return (MLHWND (SetCapture (CHWND (arg))));
}

/* Ch. 7 Timers */
static int timer_id = 1;
static int next_timer_id ()
{
  return (timer_id++);
}

static mlval timer_handlers = MLNIL;

VOID CALLBACK MLTimerProc (HWND hwnd,
			   UINT msg,
			   UINT id,
			   DWORD time)
{
  mlval hlist = timer_handlers;
  while (hlist != MLNIL)
    {
      mlval entry = FIELD (hlist,0);
      UINT thisid = CINT (FIELD (entry,0));
      if (id == thisid)
	{
	  callml (MLUNIT,FIELD (entry,1));
	  break;
	}
      hlist = FIELD (hlist, 1);
    }
}

static mlval set_timer (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT id = next_timer_id ();
  UINT timeout = CINT (FIELD (arg,1));
  mlval entry, listcell;
  UINT result;

  declare_root(&arg, 0);
  entry = allocate_record(2);
  FIELD(entry,0)= MLINT(id);
  FIELD(entry,1)= FIELD(arg,2);
  retract_root(&arg);

  declare_root (&entry, 0);
  listcell= allocate_record (2);
  FIELD(listcell,0)= entry;
  FIELD(listcell,1)= timer_handlers;
  retract_root(&entry);
  timer_handlers= listcell;
  result= SetTimer(hwnd, id, timeout, (TIMERPROC)MLTimerProc);
  if (!result)
    win32_error ("SetTimer failed");

  if (hwnd == NULL) 
    return box(result);
  else
    return box(id);
}

static mlval kill_timer (mlval arg)
{
  HWND hwnd = CHWND(FIELD(arg, 0));
  UINT id = (UINT)unbox(FIELD(arg, 1));
  UINT result;

  result = KillTimer(hwnd, id);
  if (!result)
    win32_error("KillTimer failed");

  return MLUNIT;
}

/* Ch. 10  Buttons */

static mlval screen_to_client (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  mlval p = FIELD (arg,1);
  LONG x = CINT (FIELD (p,0));
  LONG y = CINT (FIELD (p,1));
  POINT point;
  mlval result;
  point.x = x;
  point.y = y;
  ScreenToClient (hwnd,&point);
  result = allocate_record (2);
  FIELD (result,0) = MLINT(point.x);
  FIELD (result,1) = MLINT(point.y);
  return (result);
}



static mlval client_to_screen(mlval arg)
{
  HWND hwnd= CHWND(FIELD(arg,0));
  mlval p= FIELD (arg,1);
  LONG x= CINT(FIELD (p,0));
  LONG y= CINT(FIELD (p,1));
  POINT point;
  mlval result;
  point.x= x;
  point.y= y;
  ClientToScreen (hwnd,&point);
  result= allocate_record (2);
  FIELD(result,0)= MLINT(point.x);
  FIELD(result,1)= MLINT(point.y);
  return result;
}



static int gwl_values[] =
{
  DWL_DLGPROC,
  DWL_MSGRESULT,
  DWL_USER,

  GWL_EXSTYLE,
  GWL_HINSTANCE,
  GWL_HWNDPARENT,
  GWL_ID,
  GWL_STYLE,
  GWL_USERDATA,
  GWL_WNDPROC
};



static mlval convert_gwl_value (mlval arg)
{
  int result = gwl_values [CINT (arg)];
  DIAGNOSTIC(4, "convert_gwl_value: %d -> %d", CINT (arg), result);
  return MLINT(result);
}



/* Ch. 16 MENUS */

static mlval append_menu (mlval arg)
{
  HMENU hmenu= CHMENU(FIELD(arg,0));
  UINT menu_flags= convert_menu_flags(FIELD(arg,1));
  UINT value= unbox(FIELD (arg,2));
  LPCTSTR item= CSTRING(FIELD(arg,3));
  if (!AppendMenu (hmenu,menu_flags,value,item))
    win32_error ("AppendMenu failed");
  return MLUNIT;
}

static mlval check_menu_item (mlval arg)
{
  HMENU hmenu = CHMENU (FIELD (arg,0));
  UINT item = unbox (FIELD (arg,1));
  UINT flags = convert_menu_flags (FIELD (arg,2));
  return (box (CheckMenuItem (hmenu,item,flags)));
}

static mlval create_menu (mlval arg)
{
  HMENU hmenu;
  hmenu = CreateMenu ();
  if (hmenu == NULL) win32_error ("CreateMenu failed");
  return (MLHMENU (hmenu));
}

static mlval create_popup_menu (mlval arg)
{
  HMENU hmenu;
  hmenu = CreatePopupMenu ();
  if (hmenu == NULL)
    win32_error ("CreateMenu failed");
  return (MLHMENU (hmenu));
}

static mlval delete_menu (mlval arg)
{
  HMENU hmenu = CHMENU (FIELD (arg,0));
  UINT item = unbox (FIELD (arg,1));
  UINT flag = convert_menu_flag (FIELD (arg,2));
  if (!DeleteMenu (hmenu,item,flag))
    win32_error("DeleteMenu failed");
  return MLUNIT;
}

static mlval destroy_menu (mlval arg)
{
  if (!DestroyMenu (CHMENU (arg)))
    win32_error ("DestroyMenu failed");
  return MLUNIT;
}

static mlval draw_menu_bar (mlval arg)
{
  if (!DrawMenuBar (CHWND (arg)))
    win32_error ("DrawMenuBar failed");
  return MLUNIT;
}

static mlval enable_menu_item (mlval arg)
{
  HMENU hmenu= CHMENU(FIELD(arg,0));
  UINT item= unbox(FIELD(arg,1));
  UINT flags= convert_menu_flags(FIELD(arg,2));
  return box(EnableMenuItem(hmenu,item,flags));
}

static mlval get_menu (mlval arg)
{
  HMENU hmenu = GetMenu (CHWND (arg));
  if (hmenu == NULL) win32_error ("GetMenu failed");
  return MLHMENU(hmenu);
}

static mlval get_menu_item_id (mlval arg)
{
  HMENU hmenu = CHMENU (FIELD (arg,0));
  int pos = CINT (FIELD (arg,1));
  return box(GetMenuItemID (hmenu,pos));
}

static mlval get_menu_item_count (mlval arg)
{
  return GetMenuItemCount (CHMENU (arg));
}

static mlval get_submenu (mlval arg)
{
  HMENU hmenu = GetSubMenu (CHMENU (FIELD (arg,0)),CINT (FIELD (arg,1)));
  if (hmenu == NULL) win32_error ("GetSubMenu failed");
  return (MLHMENU (hmenu));
}

static mlval get_system_menu (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  BOOL revert = CBOOL (FIELD (arg,1));
  return (MLHMENU (GetSystemMenu (hwnd,revert)));
}

static mlval remove_menu (mlval arg)
{
  HMENU hmenu = CHMENU (FIELD (arg,0));
  UINT item = unbox (FIELD (arg,1));
  UINT flag = convert_menu_flag (FIELD (arg,2));
  if (!RemoveMenu (hmenu,item,flag))
    win32_error("RemoveMenu failed");
  return MLUNIT;
}

static mlval set_menu (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  HMENU hmenu = CHMENU (FIELD (arg,1));
  if (!SetMenu (hwnd,hmenu))
    win32_error ("SetMenu failed");
  return MLUNIT;
}

static UINT resource_types[] =
{
  (UINT) RT_ACCELERATOR,
  (UINT) RT_ANICURSOR,
  (UINT) RT_ANIICON,
  (UINT) RT_BITMAP,
  (UINT) RT_CURSOR,
  (UINT) RT_DIALOG,
  (UINT) RT_FONT,
  (UINT) RT_FONTDIR,
  (UINT) RT_GROUP_CURSOR,
  (UINT) RT_GROUP_ICON,
  (UINT) RT_ICON,
  (UINT) RT_MENU,
  (UINT) RT_MESSAGETABLE,
  (UINT) RT_RCDATA,
  (UINT) RT_STRING,
  (UINT) RT_VERSION
};

static UINT convert_res_type(mlval res_type)
{
  return (resource_types[CINT(res_type)]);
}

static mlval find_resource(mlval arg)
{
  HINSTANCE inst = (HINSTANCE)unbox(FIELD(arg,0));
  LPCSTR resourceName = CSTRING(FIELD(arg,1));
  LPCSTR resType = (LPCSTR)convert_res_type(FIELD(arg,2));
  HRSRC resHand = FindResource(inst, resourceName, resType);

  if (resHand == NULL)
    win32_error("FindResource failed");

  return box((UINT)resHand);
}

static mlval lock_resource(mlval arg)
{
  HGLOBAL res = (HGLOBAL)unbox(arg);

  if (LockResource(res) == NULL) 
    win32_error("LockResource failed");

  return MLUNIT;
}

static mlval load_resource(mlval arg)
{
  HINSTANCE inst = (HINSTANCE)unbox(FIELD(arg,0));
  HRSRC resHand = (HRSRC)unbox(FIELD(arg,1));
  HGLOBAL resGlobal = LoadResource(inst, resHand);

  if (resGlobal == NULL) 
    win32_error("LoadResource failed");

  return box((UINT)resGlobal);
}

static mlval get_module_handle(mlval arg)
{
  LPCSTR filename = CSTRING(arg);

  if (filename == "")
    return box((UINT)GetModuleHandle(NULL));
  else
    return box((UINT)GetModuleHandle(filename));
}

static mlval load_library(mlval arg)
{
  LPCSTR filename = CSTRING(arg);
  HINSTANCE inst = LoadLibrary(filename);

  if (inst == NULL)
    win32_error("LoadLibrary failed");

  return box((UINT)inst);
}

static mlval free_library(mlval arg)
{
  HINSTANCE inst = (HINSTANCE)unbox(arg);
  BOOL success = FreeLibrary(inst);

  if (!success) 
    win32_error("FreeLibrary failed");

  return MLBOOL((UINT)success);
}

/* DIALOGS */

static UINT mb_style_values[] =
{
  MB_ABORTRETRYIGNORE,
  MB_APPLMODAL,
  MB_ICONASTERISK,
  MB_ICONEXCLAMATION,
  MB_ICONHAND,
  MB_ICONINFORMATION,
  MB_ICONQUESTION,
  MB_ICONSTOP,
  MB_OK,
  MB_OKCANCEL,
  MB_RETRYCANCEL,
  MB_YESNO,
  MB_YESNOCANCEL
  };

static UINT convert_mb_styles (mlval mb_styles)
{
  return (convert_flags (mb_styles,mb_style_values));
}

static mlval message_box (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  LPCTSTR message = CSTRING (FIELD (arg,1));
  LPCTSTR caption = CSTRING (FIELD (arg,2));
  UINT styles = convert_mb_styles (FIELD (arg,3));
  int result = MessageBox (hwnd,message,caption,styles);
  if (result == 0)
    win32_error ("MessageBox failed");
  return (MLINT (result));
}

static mlval message_beep (mlval arg)
{
  UINT value = mb_style_values [CINT (arg)];
  MessageBeep (value);
  return MLUNIT;
}

/* MLDlgProc -- handles messages for dialog boxes.

   Returns:  TRUE is message handled, FALSE otherwise.

   Called by:  Windows itself.

   Comment:  Calls apply_menu_command for WM_COMMAND messages;
	call_ml_message_proc for other messages.
*/

BOOL APIENTRY MLDlgProc (HWND hwnd, UINT message, WPARAM wParam, LPARAM lParam)
{
  int wmId, wmEvent;

  switch (message) {

  case WM_INITDIALOG:
    return (TRUE);
    break;

  case WM_COMMAND:  /* message: command from application menu */

    /* Message packing of wParam and lParam have changed for Win32, let us */
    /* handle the differences in a conditional compilation: */
#if defined (_WIN32) || defined(WIN32)
    wmId    = LOWORD(wParam);
    wmEvent = HIWORD(wParam);
#else
    wmId    = wParam;
    wmEvent = HIWORD(lParam);
#endif

    if (apply_menu_command (wmId,wmEvent,hwnd))
      return TRUE;
    /* Drop through to default case */
  default:
    call_ml_message_proc (hwnd,message,wParam,lParam);
    /* Return false so that the default handler is also called. */
    return FALSE;
  }
  return FALSE;
}

static mlval create_dialog(mlval arg)
{
  HINSTANCE inst = (HINSTANCE)unbox(FIELD(arg,0));
  HWND owner = CHWND(FIELD(arg,1));
  char *dialog = CSTRING(FIELD(arg,2));
  HWND res_dialog;

  res_dialog = CreateDialog(inst, dialog, owner, (DLGPROC)MLDlgProc);
  if (res_dialog == NULL) 
    win32_error("CreateDialog failed");

  return MLHWND(res_dialog);
}

static char convert_digit (int n)
{
  if (n < 10)
    return (n + '0');
  else
    return (n - 10 + 'A');
}

static char hidig (char n)
{
  return (convert_digit ((n >> 4) & 15));
}
static char lodig (char n)
{
  return (convert_digit (n & 15));
}

#if 0 /* Unused, left in in case debugging required */
static void print_bytes (char *from, char *to)
{
  int count = 0;
  while (from != to)
    {
      printf ("%c%c ",hidig (*from),lodig (*from));
      from++;
      count++;
      if (count == 16)
	{
	  printf ("\n");
	  count = 0;
	}
    }
  if (count > 0)
    printf ("\n");
}
#endif

#define WBUFFLEN 512

static HGLOBAL make_dialog_template (mlval template)
{
  /* extract the TEMPLATE fields */
  /* record components are height,items,nitems,styles,title,width,x,y */
  short height = CINT (FIELD (template,0));
  mlval items = FIELD (template,1);
  WORD nitems = CINT (FIELD (template,2));
  mlval styles = FIELD (template,3);
  char *title = CSTRING (FIELD (template,4));
  short width = CINT (FIELD (template,5));
  short x = CINT (FIELD (template,6));
  short y = CINT (FIELD (template,7));

  HGLOBAL hgbl;
  LPDLGTEMPLATE lpdt;
  LPDLGITEMTEMPLATE lpdit;
  LPWORD lpw;
  LPWSTR lpwsz;

  LPWSTR wbuffer;

  hgbl = GlobalAlloc (GMEM_ZEROINIT,4096); /* Loads of room */
  if (!hgbl) report_error ("GlobalAlloc failed");

  wbuffer = (LPWSTR)alloc(WBUFFLEN + WBUFFLEN, "make_dialog_template");

  lpdt = (LPDLGTEMPLATE) GlobalLock (hgbl);

/*
  printf ("%x\n",lpdt);
  printf ("Making box %s, %d subitems\n", title, nitems);
*/

  /* Define main dialog box components */
  lpdt->style = (DWORD)convert_styles (styles);
  lpdt->style |= DS_SETFONT;
  lpdt->dwExtendedStyle = (DWORD)0;
  lpdt->cdit = nitems;
  lpdt->x = x; lpdt->y = y;
  lpdt->cx = width; lpdt->cy = height;

  lpw = (LPWORD) (lpdt + 1); /* point to after the TEMPLATE object */
  *lpw++ = 0; /* no menu */
  *lpw++ = 0; /* default dialog box class */
  lpwsz = (LPWSTR) lpw;
  MultiByteToWideChar (CP_ACP,MB_PRECOMPOSED,title,-1,wbuffer,WBUFFLEN);
  wcscpy (lpwsz,wbuffer); /* copy title */
  lpw = (LPWORD)(lpwsz + wcslen (lpwsz) + 1); /* increment pointer */
  *lpw++ = 8;	/* 8 point font */
  lpwsz = (LPWSTR) lpw;
  MultiByteToWideChar (CP_ACP,MB_PRECOMPOSED,"MS Sans Serif",-1,wbuffer,WBUFFLEN);
  wcscpy (lpwsz,wbuffer); /* copy title */
  lpw = (LPWORD)(lpwsz + wcslen (lpwsz) + 1); /* increment pointer */

  /* and now do the dialog items */
  while ((items != MLNIL) && nitems > 0)
    {
      mlval item = FIELD (items,0);
      /* fields are class,height,id,styles,text,width,x,y */
      char *class = CSTRING (FIELD (item,0));
      short height = CINT (FIELD (item,1));
      WORD id = unbox (FIELD (item,2));
      DWORD styles = convert_styles (FIELD (item,3));
      char *text = CSTRING (FIELD (item,4));
      short width = CINT (FIELD (item,5));
      short x = CINT (FIELD (item,6));
      short y = CINT (FIELD (item,7));

      nitems --;
      /* printf ("Making item %s, %s at %d, %d, %d, %d\n", class,text,x,y,width,height); */
      /* first word align lpw */
      lpw = (LPWORD)word_align (lpw);
      /* Now fill in the item template */
      lpdit = (LPDLGITEMTEMPLATE) lpw;
      /* printf ("%x\n",lpdit); */
      lpdit->x = x; lpdit->y = y;
      lpdit->cx = width; lpdit->cy = height;
      lpdit->id = id;
      lpdit->style = styles;
      lpdit->dwExtendedStyle = 0;

      lpwsz = (LPWSTR) (lpdit + 1); /* make a string pointer */
      MultiByteToWideChar (CP_ACP,MB_PRECOMPOSED,class,-1,wbuffer,WBUFFLEN);
      /* printf ("Converted class %s to %S\n",class,wbuffer); */
      wcscpy (lpwsz,wbuffer);
      lpwsz = (LPWSTR)(lpwsz + wcslen (lpwsz) + 1); /* move pointer to next string */
      MultiByteToWideChar (CP_ACP,MB_PRECOMPOSED,text,-1,wbuffer,WBUFFLEN);
      /* printf ("Converted text %s to %S\n",text,wbuffer); */
      wcscpy (lpwsz,wbuffer);
      lpw = (LPWORD)(lpwsz + wcslen (lpwsz) + 1); /* set up word pointer */
      *lpw++ = 0; /* no creation data */
      items = FIELD (items,1);
    } /* phew */
  /* useful for diagnostic purposes */
  /* print_bytes ((char *)hgbl,(char *) lpw); */

  GlobalUnlock (hgbl);
  free ((char *) wbuffer);
  return (hgbl);
}

/* Takes an ML template object and a parent window */
static mlval create_dialog_indirect (mlval arg)
{
  mlval template = FIELD (arg,0);
  HWND owner = CHWND (FIELD (arg,1));
  HGLOBAL hgbl;
  HWND dbox;
  hgbl = make_dialog_template (template);

  /* printf ("Creating dialog\n"); */
  dbox = CreateDialogIndirect (hInst,(LPDLGTEMPLATE)hgbl,owner,(DLGPROC)MLDlgProc);
  GlobalFree (hgbl);
  if (!dbox)
    win32_error ("CreateDialogIndirect failed");
  return (MLHWND (dbox));
}

static mlval dialog_box (mlval arg)
{
  return MLUNIT;
}

static mlval dialog_box_indirect (mlval arg)
{
  mlval template = FIELD (arg,0);
  HWND owner = CHWND (FIELD (arg,1));
  HGLOBAL hgbl;
  int result;
  hgbl = make_dialog_template (template);

  /* printf ("Creating modal dialog\n"); */
  result = DialogBoxIndirect (hInst,(LPDLGTEMPLATE)hgbl,owner,(DLGPROC)MLDlgProc);
  GlobalFree (hgbl);
  return (MLINT (result));
}

static mlval end_dialog (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int result = CINT (FIELD (arg,1));
  if (!EndDialog (hwnd,result))
    win32_error ("EndDialog failed");
  return MLUNIT;
}

static mlval get_dlg_item (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int id = unbox (FIELD (arg,1));
  return (MLHWND (GetDlgItem (hwnd,id)));
}

static mlval get_dlg_ctrl_id (mlval arg)
{
  HWND hwnd = CHWND (arg);
  return MLINT(GetDlgCtrlID(hwnd));
}

static mlval get_dialog_base_units (mlval arg)
{
  return (box ((UINT) GetDialogBaseUnits()));
}

static mlval get_find_flags(mlval arg)
{
  LPFINDREPLACE lpfindreplace = (LPFINDREPLACE)unbox(arg);
  mlval result;
  mlval searchStr;

  searchStr = ml_string(lpfindreplace->lpstrFindWhat);
  declare_root(&searchStr, 0);

  result = allocate_record(6);
  FIELD(result, 0) = FR_DIALOGTERM & lpfindreplace->Flags;
  FIELD(result, 1) = FR_FINDNEXT & lpfindreplace->Flags;
  FIELD(result, 2) = FR_MATCHCASE & lpfindreplace->Flags;
  FIELD(result, 3) = FR_DOWN & lpfindreplace->Flags;
  FIELD(result, 4) = searchStr;
  FIELD(result, 5) = FR_WHOLEWORD & lpfindreplace->Flags;
  retract_root(&searchStr);

  return result;
}

static char search_string[256];

static mlval find_dialog(mlval arg)
{
  HWND parent = CHWND(FIELD(arg, 0));
  char *initStr = CSTRING(FIELD(arg, 1));
  mlval caseOpt = FIELD(arg, 2);
  mlval downOpt = FIELD(arg, 3);
  mlval wordOpt = FIELD(arg, 4);
  LPFINDREPLACE find = (LPFINDREPLACE)malloc(sizeof(FINDREPLACE));
  HWND dialog;

  BOOL showCase = (caseOpt != MLINT(0));
  BOOL showDir = (downOpt != MLINT(0));
  BOOL showWord = (wordOpt != MLINT(0));

  BOOL matchCase = showCase ? CBOOL(FIELD(caseOpt, 1)) : FALSE;
  BOOL searchDown = showDir ? CBOOL(FIELD(downOpt, 1)) : FALSE;
  BOOL wholeWord = showWord ? CBOOL(FIELD(wordOpt, 1)) : FALSE;

  if (find == NULL) 
    win32_error("malloc failed during FindText");

  strncpy(search_string, initStr, 256);
  search_string[255] = '\0';

  find->lStructSize = sizeof(FINDREPLACE);
  find->hwndOwner = parent;
  find->hInstance = hInst;
  find->Flags = 
    FR_ENABLEHOOK | 
    (showCase ? 0 : FR_HIDEMATCHCASE) |
    (showDir ? 0 : FR_HIDEUPDOWN) |
    (showWord ? 0 : FR_HIDEWHOLEWORD) |
    (matchCase ? FR_MATCHCASE : 0) |
    (searchDown ? FR_DOWN : 0) |
    (wholeWord ? FR_WHOLEWORD : 0);
  find->lpstrFindWhat = search_string;
  find->lpstrReplaceWith = NULL;
  find->wFindWhatLen = 256;
  find->wReplaceWithLen = 0;
  find->lCustData = (LPARAM) NULL;
  find->lpfnHook = MLDlgProc;
  find->lpTemplateName = NULL;

  if ((dialog = FindText(find)) == NULL) 
    win32_error("FindText failed");

  return MLHWND(dialog);
}

/* CONTROLS */

/*
static mlval create_status_window (mlval arg)
{
  LONG style = CINT (FIELD (arg,0));
  char *text = CSTRING (FIELD (arg,1));
  HWND hwnd = CHWND (FIELD (arg,2));
  UINT wID = unbox (FIELD (arg,3));

  return (MLHWND (CreateStatusWindow (style,text,hwnd,wID)));

}
*/

static UINT tb_button_states[] = 
{
  TBSTATE_CHECKED,
  TBSTATE_ENABLED,
  TBSTATE_HIDDEN,
  TBSTATE_INDETERMINATE,
  TBSTATE_PRESSED,
  TBSTATE_WRAP
};

static UINT convert_tb_states(mlval states)
{
  return convert_flags(states,tb_button_states);
}

static mlval ml_convert_tb_states(mlval arg)
{
  return box((UINT)convert_flags(arg, tb_button_states));
}

static UINT tb_button_styles[] =
{
  TBSTYLE_BUTTON,
  TBSTYLE_CHECK,
  TBSTYLE_CHECKGROUP,
  TBSTYLE_GROUP,
  TBSTYLE_SEP
};

static UINT convert_tb_styles(mlval styles)
{
  return convert_flags(styles,tb_button_styles);
}

static mlval create_toolbar_ex(mlval arg)
{
  HWND toolbar = NULL;
  HWND tooltips = NULL;
  UINT bitmapResID = (UINT)unbox(FIELD(arg,0));
  mlval button_list = FIELD(arg,1);
  int nBitmaps = CINT(FIELD(arg,2));
  int nButtons = CINT(FIELD(arg,3));
  HWND parent = CHWND(FIELD(arg,4));
  mlval styles = FIELD(arg,5);
  UINT toolbarID = (UINT)unbox(FIELD(arg,6));  
  int xBitmap = CINT(FIELD(arg,7));
  int xButton = CINT(FIELD(arg,8));
  int yBitmap = CINT(FIELD(arg,9));
  int yButton = CINT(FIELD(arg,10));
  size_t len = list_length(button_list);
  LPTBBUTTON button_data = (LPTBBUTTON)malloc(len * sizeof(TBBUTTON));
  LPTBBUTTON ptr = button_data; 
  int counter = 0;
  DWORD tbstyles = convert_styles(styles);

  if (button_data == NULL) 
    win32_error("malloc failed during CreateToolbarEx");

/* button_data does not need to be freed as win32_error causes
 * the environment to exit and hence the malloc'd memory is 
 * automatically freed. 
 */
  if (len != (UINT)nButtons) 
    win32_error("argument mismatch in CreateToolbarEx");

  while (button_list != MLNIL) {
    mlval button = FIELD(button_list,0);
    int iBitmap = CINT(FIELD(button,0));
    UINT idCommand = (UINT)unbox(FIELD(button,1)); 
    mlval bStates = FIELD(button,2);
    mlval bStyles = FIELD(button,3);
    DWORD dwData = unbox(FIELD(button,4));
    int iString = CINT(FIELD(button,5));
    
    ptr->iBitmap = iBitmap;
    ptr->idCommand = idCommand;
    ptr->fsState = convert_tb_states(bStates);  
    ptr->fsStyle = convert_tb_styles(bStyles);  
    ptr->dwData = dwData;
    ptr->iString = iString;
    button_list = FIELD(button_list,1); 
    ptr++;
  }

  toolbar = CreateToolbarEx(parent, tbstyles, toolbarID, nBitmaps, 
			    hInst, bitmapResID, button_data, nButtons, xButton, 
			    yButton, xBitmap, yBitmap, sizeof(TBBUTTON));

  free(button_data);
  if (toolbar == NULL)
    win32_error("CreateToolbarEx failed");

  tooltips = (HWND)SendMessage(toolbar, TB_GETTOOLTIPS, 0, 0);
  if (tooltips != NULL)
    SetWindowLong(tooltips, GWL_STYLE, TTS_ALWAYSTIP);

  return MLHWND(toolbar);
}

static mlval process_notify(mlval arg)
{
  HWND widget = CHWND(FIELD(arg,0));
  WPARAM wparam = (WPARAM)unbox(FIELD(arg,1));
  LPARAM lparam = (LPARAM)unbox(FIELD(arg,2));
  LPNMHDR header = (LPNMHDR)lparam;

  switch (header->code) {

/* This code is adapted from example code given in the SDK.  
 * See 'Processing ToolTip Notification Messages' under 
 * Win32 Programmers Reference->Overviews->Window Controls 
 */
  case TTN_NEEDTEXT:
    {
      int but_index;
      TBBUTTON button_info;
      LPTOOLTIPTEXT lpttt;
      UINT idButton;
      
      lpttt = (LPTOOLTIPTEXT)lparam;
      lpttt->hinst = hInst;
      idButton = lpttt->hdr.idFrom;
      
      but_index = 
	SendMessage(widget, TB_COMMANDTOINDEX, (WPARAM)idButton, (LPARAM)0);
      
      if (SendMessage(widget, TB_GETBUTTON, (WPARAM)but_index, 
		      (LPARAM)(LPTBBUTTON)&button_info))
	lpttt->lpszText = (char*)button_info.dwData;   
      else
	lpttt->lpszText = "";
      
      break;
    }
  default:
    break;
  }
  
  return MLUNIT;
}

/* BUTTON CONTROLS */

static mlval check_dlg_button (mlval arg)
{
  HWND dialog = CHWND (FIELD (arg,0));
  int id = unbox (FIELD (arg,1));
  int value = CINT (FIELD (arg,2));
  if (!CheckDlgButton(dialog,id,value))
    win32_error ("CheckDlgButton failed");
  return MLUNIT;
}

static mlval check_radio_button (mlval arg)
{
  HWND dialog = CHWND (FIELD (arg,0));
  int firstid = unbox (FIELD (arg,1));
  int lastid = unbox (FIELD (arg,2));
  int checkid = unbox (FIELD (arg,3));
  /* printf ("CheckRadioButton: %d %d %d\n", firstid, lastid,checkid); */
  if (!CheckRadioButton(dialog,firstid,lastid,checkid))
    win32_error ("CheckRadioButton failed");
  return MLUNIT;
}

static mlval is_dlg_button_checked (mlval arg)
{
  HWND dialog = CHWND (FIELD (arg,0));
  int id = unbox (FIELD (arg,1));
  return (MLINT (IsDlgButtonChecked(dialog,id)));
}

/*
 * A dummy dialog hook for use by the various *_dialog routines below.
 * 
 * This was added to cure a problem with GetSaveFileName and GetOpenFileName
 * killing MLWorks with no message when any of the *_dialog routines below
 * was called on greg's NT 4.0 machine when configured as standalone.
 * Jeff also experienced this behaviour.
 * It isn't clear how or why it cures the problem.
 */
static UINT WINAPI dummy_dialog_hook(HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
  return FALSE;  /* allow standard processing */
}

static char current_dir[MAX_PATH];
static char current_filesys_dir[MAX_PATH];

static char* get_init_dir(char *error_txt)
{
  char fixed_buffer[MAX_PATH];
  char *buffer = fixed_buffer;
  DWORD buffer_size = MAX_PATH;
  DWORD size = GetCurrentDirectory(buffer_size, buffer);

  if (size == 0)
    report_error(error_txt);
  if (size >= buffer_size) 
    report_error("Path length too long");
  
  if (strcmp(current_filesys_dir, buffer)) {
    strcpy(current_filesys_dir, buffer);
    strcpy(current_dir, buffer);
  }
  
  return current_dir;
}

char* get_long_name (char* short_name)
{
  OSVERSIONINFO verInfo;
  static char fullPath[MAX_PATH];
  DWORD version;
  
  verInfo.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
  if (GetVersionEx (&verInfo))
    version = verInfo.dwMajorVersion;
  else
    win32_error("Could not get version information");
  
  if (version != 3) {
    SHFILEINFO psfi;
    char file_str[MAX_PATH];
    char* temp;
    
    strcpy(file_str, short_name);
    sprintf(fullPath, "%s", strtok(file_str, "\\"));
    temp = strtok(NULL, "\\");
    while (temp != NULL) {
      char temp_store[MAX_PATH];

      sprintf(temp_store, "%s\\%s", fullPath, temp);
      SHGetFileInfo(temp_store, 0, &psfi, sizeof(SHFILEINFO), SHGFI_DISPLAYNAME);
      sprintf(fullPath, "%s\\%s", fullPath, psfi.szDisplayName);
      temp = strtok(NULL, "\\");
    }
  } else {
    strcpy(fullPath, short_name);
  }
  
  return fullPath;
}

static mlval save_dialog (mlval arg)
{
  HWND parent = CHWND(FIELD(arg,0));
  char *desc = CSTRING(FIELD(arg,1));  
  char *ext = CSTRING(FIELD(arg,2));  
  char filename[MAX_PATH];
  OPENFILENAME ofn;
  LPSTR buff = alloc(strlen(desc) + strlen(ext) + 4, "save_dialog"); 

  lstrcpy(buff, desc);
  lstrcat(buff, " *.");
  lstrcat(buff, ext);
  buff[strlen(desc)] = '\0';
  buff[strlen(desc) + 3 + strlen(ext)] = '\0';

  filename[0] = '\0';

  memset (&ofn, 0, sizeof (OPENFILENAME));
  ofn.lStructSize = sizeof (OPENFILENAME);
  ofn.hwndOwner = parent;
  ofn.lpstrFilter = buff;
  free(buff);
  ofn.nFilterIndex = 1;
  ofn.lpstrFile = filename;
  ofn.nMaxFile = sizeof(filename);
  ofn.lpstrInitialDir = get_init_dir("Save dialog failed");
  ofn.Flags = OFN_OVERWRITEPROMPT | OFN_HIDEREADONLY | OFN_NOCHANGEDIR;
  ofn.lpfnHook = NULL; /* dummy_dialog_hook; */
  ofn.lpstrDefExt = ext;

  if (GetSaveFileName(&ofn)) {
    strncpy(current_dir, get_long_name(ofn.lpstrFile), ofn.nFileOffset);
    current_dir[ofn.nFileOffset] = '\0';
    return ml_string (ofn.lpstrFile);
  } else {
    return ml_string ("");
  }
}

static mlval get_multi_strings (char* directory, char* file_list)
{ /* file_list is a list of files, separated by spaces.  If the original 
   * long name of the file had a space then the short form is used. */

  char* separator;
  char* file;
  char full_path[MAX_PATH];
  HANDLE handle;
  WIN32_FIND_DATA found;
  mlval string, list;

  separator = strstr(file_list, " ");
  if (separator)       /* There are multiple files, but pretend */
    *separator = '\0'; /* there's just one for now              */
  file = file_list;

  /* The filename is potentially in short form, so convert to long form */
  sprintf(full_path, "%s\\%s", directory, file);
  handle = FindFirstFile(full_path, &found);
  sprintf(full_path, "%s\\%s", directory, found.cFileName);
  FindClose(handle);

  string = ml_string(full_path);  /* Do NOT inline this */

  if (separator) /* Cons this file  to the list of remaining files */
    list = mlw_cons(string, get_multi_strings(directory, separator+1));
  else /* make a singleton list */
    list = mlw_cons(string, MLNIL);

  return list;
}


static mlval open_file_dialog (mlval arg)
{
  HWND parent = CHWND (FIELD (arg,0));
  char *desc = CSTRING(FIELD(arg,1));  
  char *ext = CSTRING (FIELD (arg,2));
  BOOL multi = CBOOL(FIELD(arg, 3));
  char filename[MAX_PATH * 50];
  OPENFILENAME ofn;
  LPSTR buff = alloc(strlen(desc) + strlen(ext) + 4, "open_dialog"); 
  BOOL result;

  lstrcpy(buff, desc);
  lstrcat(buff, " *.");
  lstrcat(buff, ext);
  buff[strlen(desc)] = '\0';
  buff[strlen(desc) + 3 + strlen(ext)] = '\0';

  filename[0] = '\0';

  memset (&ofn, 0, sizeof (OPENFILENAME));
  ofn.lStructSize = sizeof (OPENFILENAME);
  ofn.hwndOwner = parent;
  ofn.lpstrFilter = buff;
  ofn.nFilterIndex = 1;
  ofn.lpstrFile = filename;
  ofn.nMaxFile = sizeof(filename);
  ofn.lpstrFileTitle = NULL;
  ofn.nMaxFileTitle = 0;
  ofn.lpstrInitialDir = get_init_dir("Open file dialog failed");
  if (multi) 
    ofn.Flags = 
      OFN_ALLOWMULTISELECT | 
      OFN_PATHMUSTEXIST | 
      OFN_FILEMUSTEXIST |
      OFN_HIDEREADONLY | 
      OFN_NOCHANGEDIR;
  else
    ofn.Flags = 
      OFN_PATHMUSTEXIST | 
      OFN_FILEMUSTEXIST | 
      OFN_HIDEREADONLY | 
      OFN_NOCHANGEDIR;
  ofn.lpfnHook = dummy_dialog_hook;
  ofn.lpstrDefExt = ext;

  result = GetOpenFileName(&ofn);

  free(buff);

  if (result) {
    /* The character before the first file is either a \ if there is only one
     * file or a space if there are multiple files */
    strncpy(current_dir, ofn.lpstrFile, ofn.nFileOffset-1);
    current_dir[ofn.nFileOffset-1] = '\0';

    if (multi) 
      return get_multi_strings(get_long_name(current_dir), 
                               &ofn.lpstrFile[ofn.nFileOffset]);
    else {
      mlval ml_result = ml_string(ofn.lpstrFile);
      return mlw_cons(ml_result, MLNIL);
    }
  } else {
    return MLNIL;
  }
}

/* The following hook function was nicked from scriptworks */
static UINT WINAPI open_dir_hook (HWND hDlg, UINT message, WPARAM wParam, LPARAM lParam)
{
  static char* dirname;
  static OPENFILENAME *pofn;	/* Not sure why this is static */

  switch(message)
  {
    case WM_INITDIALOG:
       /* If the scriptworks code is to be believed, the lParam parameter
          contains the whole OPENFILENAME structure, not just the lCustData. */
       pofn  = (OPENFILENAME * ) lParam;
       dirname = (char *) (pofn->lCustData);
       EnableWindow(GetDlgItem(hDlg, edt1), FALSE);
       EnableWindow(GetDlgItem(hDlg, lst1), FALSE);
       EnableWindow(GetDlgItem(hDlg, cmb1), FALSE);
       return TRUE;

    case WM_COMMAND:
       if(LOWORD(wParam) == IDOK)
       {
         GetCurrentDirectory(MAX_PATH, dirname);
         EndDialog(hDlg, TRUE);
         return TRUE;
       }
       else
         return FALSE;

    default:
         break;
  }
  return FALSE;  /* allow standard processing */
}

static mlval open_dir_dialog (mlval arg)
{
  HWND parent = CHWND (arg);
  char dirname[MAX_PATH];
  OPENFILENAME ofn;

  dirname[0] = '\0';

  memset (&ofn, 0, sizeof (OPENFILENAME));
  ofn.lStructSize = sizeof (OPENFILENAME);
  ofn.hwndOwner = parent;
  ofn.lpstrFilter = "All files (*.*)\0*.*\0";
  ofn.nFilterIndex = 1;
  ofn.lpstrInitialDir = get_init_dir("Open directory dialog failed");
  ofn.Flags = OFN_ENABLEHOOK | OFN_HIDEREADONLY | OFN_NOCHANGEDIR;
  ofn.lpfnHook = open_dir_hook;
  ofn.lCustData = (DWORD) dirname;
  ofn.lpstrTitle = "Select Directory";

  if (GetOpenFileName(&ofn)) {
    /* The following check is a workaround for a bug in NT 3.51 */
    if (ofn.lpstrFile == NULL) ofn.nFileOffset = 0;  
    strncpy(current_dir, ofn.lpstrFile, ofn.nFileOffset);
    current_dir[ofn.nFileOffset] = '\0';
    return ml_string (get_long_name(dirname));
  } else {
    return ml_string ("");
  }
}

/* SCROLLBARS */

static mlval enable_scroll_bar (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT flags = convert_sb_value (FIELD (arg,1));
  UINT arrows = convert_esb_value (FIELD (arg,2));
  if (!EnableScrollBar (hwnd,flags,arrows))
    win32_error ("EnableScrollBar failed");
  return MLUNIT;
}

static mlval get_scroll_pos (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int fnbar = convert_sb_value (FIELD (arg,1));
  int result = GetScrollPos (hwnd,fnbar);
  return (MLINT (result));
}

static mlval get_scroll_info (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int fnbar = convert_sb_value (FIELD (arg,1));
  SCROLLINFO lpsi;
  mlval result, mlsize, mlmask, mlpage;
  int returned;

  lpsi.fMask = SIF_ALL;
  lpsi.cbSize = sizeof(lpsi);
  returned = GetScrollInfo(hwnd, fnbar, &lpsi);

  mlsize = box ((UINT) (lpsi.cbSize));
  declare_root(&mlsize, 0);
  mlmask = box ((UINT) (lpsi.fMask));
  declare_root(&mlmask, 0);
  mlpage = box ((UINT) (lpsi.nPage));
  declare_root(&mlpage, 0);

  result = allocate_record (8);
  FIELD (result, 0) = MLINT(returned);
  FIELD (result, 1) = mlsize;
  FIELD (result, 2) = mlmask;
  FIELD (result, 3) = MLINT(lpsi.nMin);
  FIELD (result, 4) = MLINT(lpsi.nMax);
  FIELD (result, 5) = mlpage;
  FIELD (result, 6) = MLINT(lpsi.nPos);
  FIELD (result, 7) = MLINT(lpsi.nTrackPos);

  retract_root(&mlpage);
  retract_root(&mlmask);
  retract_root(&mlsize);

  return (result);
}

static mlval get_scroll_range (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int fnbar = convert_sb_value (FIELD (arg,1));
  int minpos;
  int maxpos;
  mlval result;
  if (!GetScrollRange (hwnd,fnbar,&minpos,&maxpos))
    win32_error ("GetScrollRange failed");
  result = allocate_record(2);
  FIELD (result,0) = MLINT(minpos);
  FIELD (result,1) = MLINT(maxpos);
  return (result);
}

static mlval set_scroll_pos (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int fnbar = convert_sb_value (FIELD (arg,1));
  int pos = CINT (FIELD (arg,2));
  BOOL redraw = CBOOL (FIELD (arg,3));
  SetScrollPos (hwnd,fnbar,pos,redraw);
  return MLUNIT;
}

static mlval set_scroll_range (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  int fnbar = convert_sb_value (FIELD (arg,1));
  int minpos = CINT (FIELD (arg,2));
  int maxpos = CINT (FIELD (arg,3));
  BOOL redraw = CBOOL (FIELD (arg,4));
  if (!SetScrollRange (hwnd,fnbar,minpos,maxpos,redraw))
    win32_error ("SetScrollRange failed");
  return MLUNIT;
}

static mlval show_scroll_bar (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  UINT flags = convert_sb_value (FIELD (arg,1));
  BOOL b = CBOOL (FIELD (arg,2));
  if (!ShowScrollBar (hwnd,flags,b))
    win32_error("ShowScrollBar failed");
  return MLUNIT;
}

/* GRAPHICS */

static int rop_values [] = 
{
  BLACKNESS,
  DSTINVERT,
  MERGECOPY,
  MERGEPAINT,
  NOTSRCCOPY,
  NOTSRCERASE,
  PATCOPY,
  PATINVERT,
  PATPAINT,
  SRCAND,
  SRCCOPY,
  SRCERASE,
  SRCINVERT,
  SRCPAINT,
  WHITENESS
};

static int convert_rop_value(mlval value)
{
  return (rop_values[CINT(value)]);
}

static mlval bit_blt(mlval arg)
{
  int index=0;
  HDC hdcDest = CHDC(FIELD(arg, index++));
  HDC hdcSrc = CHDC(FIELD(arg, index++));
  int height = CINT(FIELD(arg, index++));
  UINT ropMode = convert_rop_value(FIELD(arg, index++));
  int width = CINT(FIELD(arg, index++));
  int xDest = CINT(FIELD(arg, index++));
  int xSrc = CINT(FIELD(arg, index++));
  int yDest = CINT(FIELD(arg, index++));
  int ySrc = CINT(FIELD(arg, index++));

  if (!BitBlt(hdcDest, xDest, yDest, width, height, hdcSrc, xSrc, ySrc, ropMode)) 
    win32_error("BitBlt failed");

  return MLUNIT;
}

/* DEFAULT_GUI_FONT is defined for versions of windows >= 4.00 */
static int stock_object_values [] =
{
  ANSI_FIXED_FONT,
  ANSI_VAR_FONT,
  BLACK_BRUSH,
  BLACK_PEN,
  DEFAULT_GUI_FONT,
  DEFAULT_PALETTE,
  DKGRAY_BRUSH,
  GRAY_BRUSH,
  HOLLOW_BRUSH,
  LTGRAY_BRUSH,
  NULL_BRUSH,
  NULL_PEN,
  OEM_FIXED_FONT,
  SYSTEM_FIXED_FONT,
  SYSTEM_FONT,
  WHITE_BRUSH,
  WHITE_PEN
};

static UINT object_types [] =
{
  OBJ_PEN,
  OBJ_BRUSH,
  OBJ_PAL,
  OBJ_FONT,
  OBJ_BITMAP
};

static mlval cancel_dc (mlval arg)
{
  if (!CancelDC (CHDC (arg)))
    win32_error ("CancelDC failed");
  return MLUNIT;
}

static mlval create_compatible_dc (mlval arg)
{
  return MLHDC(CreateCompatibleDC (CHDC (arg)));
}

static mlval delete_object (mlval arg)
{
  if (!DeleteObject ((HGDIOBJ)unbox (arg)))
    win32_error ("DeleteObject failed");
  return MLUNIT;
}

static mlval get_current_object (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  UINT type = object_types[CINT (FIELD (arg,1))];
  return (box ((UINT)GetCurrentObject (hdc,type)));
}

static mlval get_dc (mlval arg)
{
  HWND window = CHWND(arg);
  return (box ((UINT)GetDC (window)));
}

static mlval get_dc_org_ex (mlval arg)
{
  HDC hdc = CHDC (arg);
  POINT p;
  mlval result;
  if (!GetDCOrgEx (hdc,&p))
    win32_error ("GetDCOrg failed");
  result = allocate_record (2);
  FIELD (result,0) = MLINT (p.x);
  FIELD (result,1) = MLINT (p.y);
  return (result);
}

static mlval set_pixel (mlval arg)
{
  HDC hdc = (HDC) (unbox (FIELD (arg, 0)));
  int x = CINT (FIELD (arg, 1));
  int y = CINT (FIELD (arg, 2));
  COLORREF pixColor = (COLORREF) unbox(FIELD (arg,3));
  mlval result;

  COLORREF retColor = SetPixel (hdc,x,y,pixColor);
  if (retColor == -1) 
    win32_error ("SetPixel failed");
  result = box (retColor);

  return result;
}

static mlval get_stock_object (mlval arg)
{
  HGDIOBJ obj = GetStockObject (stock_object_values [CINT (arg)]);
  
  if (!obj)
    exn_raise_string(perv_exn_ref_win, "GetStockObject failed");
  else
    return (box ((UINT)obj));
}

static mlval release_dc (mlval arg)
{
  HWND window = CHWND (FIELD (arg,0));
  HDC hdc = (HDC) unbox (FIELD (arg,1));
  ReleaseDC (window,hdc);
  return MLUNIT;
}

static mlval restore_dc (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int n = CINT (FIELD (arg,1));
  if (!RestoreDC (hdc,n))
    win32_error ("RestoreDC failed");
  return MLUNIT;
}

static mlval save_dc (mlval arg)
{
  HDC hdc = CHDC (arg);
  int result = SaveDC (hdc);
  if (result == 0)
    win32_error ("SaveDC failed");
  return (MLINT (result));
}

static mlval select_object (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  HGDIOBJ obj = (HGDIOBJ)unbox(FIELD (arg,1));
  HGDIOBJ result = SelectObject(hdc,obj);
  if (result == NULL)
    win32_error ("SelectObject failed");
  return (box ((UINT) result));
}

/* Brushes */

static UINT hatch_styles [] =
{
  HS_BDIAGONAL,
  HS_CROSS,
  HS_DIAGCROSS,
  HS_FDIAGONAL,
  HS_HORIZONTAL,
  HS_VERTICAL
};

static mlval create_hatch_brush (mlval arg)
{
  UINT style = hatch_styles [CINT (FIELD (arg,0))];
  COLORREF color = (COLORREF)unbox(FIELD (arg,1));
  HBRUSH brush = CreateHatchBrush (style,color);
  if (brush == NULL)
    win32_error ("CreateHatchBrush failed");
  return (box ((UINT)brush));
}

static mlval create_solid_brush (mlval arg)
{
  COLORREF color = (COLORREF)unbox(arg);
  HBRUSH brush = CreateSolidBrush (color);
  if (brush == NULL)
    win32_error ("CreateSolidBrush failed");
  return (box ((UINT)brush));
}

/* PENS */
static UINT pen_styles [] =
{
  PS_DASH,
  PS_DASHDOT,
  PS_DASHDOTDOT,
  PS_DOT,
  PS_NULL,
  PS_SOLID,
  PS_INSIDEFRAME
};

static mlval create_pen (mlval arg)
{
  UINT style = pen_styles [CINT (FIELD (arg,0))];
  int width = CINT (FIELD (arg,1));
  COLORREF color = (COLORREF)unbox(FIELD (arg,2));
  HPEN pen = CreatePen (style,width,color);
  if (pen == NULL)
    win32_error ("CreatePen failed");
  return (box ((UINT)pen));
}
/* Drawing of one sort and another */

static UINT ml_to_arc_direction (mlval arg)
{
  if (arg == MLINT (0))
    return (AD_CLOCKWISE);
  else
    return (AD_COUNTERCLOCKWISE);
}

static mlval arc_direction_to_ml (UINT arg)
{
  if (arg == AD_CLOCKWISE)
    return (MLINT (0));
  else
    return (MLINT (1));
}

static mlval angle_arc (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  DWORD a3 = CINT (FIELD (arg,3));
  FLOAT a4 = (FLOAT)GETREAL(FIELD (arg,4));
  FLOAT a5 = (FLOAT)GETREAL(FIELD (arg,5));
  if (!AngleArc (hdc,a1,a2,a3,a4,a5))
    win32_error ("AngleArc failed");
  return MLUNIT;
}

static mlval arc (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  int a5 = CINT (FIELD (arg,5));
  int a6 = CINT (FIELD (arg,6));
  int a7 = CINT (FIELD (arg,7));
  int a8 = CINT (FIELD (arg,8));
  if (!Arc (hdc,a1,a2,a3,a4,a5,a6,a7,a8))
    win32_error ("Arc failed");
  return MLUNIT;
}

static mlval arc_to (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  int a5 = CINT (FIELD (arg,5));
  int a6 = CINT (FIELD (arg,6));
  int a7 = CINT (FIELD (arg,7));
  int a8 = CINT (FIELD (arg,8));
  if (!ArcTo (hdc,a1,a2,a3,a4,a5,a6,a7,a8))
    win32_error ("ArcTo failed");
  return MLUNIT;
}

static mlval get_arc_direction (mlval arg)
{
  return (arc_direction_to_ml (GetArcDirection (CHDC (arg))));
}

static mlval move_to (mlval arg)
{
  HDC hdc = (HDC)unbox(FIELD (arg,0));
  int x = CINT (FIELD (arg,1));
  int y = CINT (FIELD (arg,2));
  LPPOINT p = (LPPOINT)unbox (FIELD (arg,3));
  MoveToEx (hdc,x,y,p);
  return MLUNIT;
}

static mlval line_to (mlval arg)
{
  HDC hdc = (HDC)unbox(FIELD (arg,0));
  int x = CINT (FIELD (arg,1));
  int y = CINT (FIELD (arg,2));
  LineTo (hdc,x,y);
  return MLUNIT;
}

static mlval set_arc_direction (mlval arg)
{
  HDC hdc = (HDC)unbox(FIELD (arg,0));
  UINT dir = ml_to_arc_direction (FIELD (arg,1));
  int result = SetArcDirection (hdc,dir);
  if (result == 0)
    win32_error ("SetArcDirection failed");
  return (arc_direction_to_ml (result));
}

static mlval chord (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  int a5 = CINT (FIELD (arg,5));
  int a6 = CINT (FIELD (arg,6));
  int a7 = CINT (FIELD (arg,7));
  int a8 = CINT (FIELD (arg,8));
  if (!Chord (hdc,a1,a2,a3,a4,a5,a6,a7,a8))
    win32_error ("Chord failed");
  return MLUNIT;
}

static mlval ellipse (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  if (!Ellipse (hdc,a1,a2,a3,a4))
    win32_error ("Ellipse failed");
  return MLUNIT;
}

static mlval fill_rect (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  mlval mlrect = FIELD (arg,1);
  HBRUSH brush = (HBRUSH)unbox (FIELD (arg,2));
  RECT r;
  r.bottom = CINT (FIELD (mlrect,0));
  r.left = CINT (FIELD (mlrect,1));
  r.right = CINT (FIELD (mlrect,2));
  r.top = CINT (FIELD (mlrect,3));
  if (!FillRect (hdc,&r,brush))
    win32_error ("FillRect failed");
  return MLUNIT;
}

static mlval frame_rect (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  mlval mlrect = FIELD (arg,1);
  HBRUSH brush = (HBRUSH)unbox (FIELD (arg,2));
  RECT r;
  r.bottom = CINT (FIELD (mlrect,0));
  r.left = CINT (FIELD (mlrect,1));
  r.right = CINT (FIELD (mlrect,2));
  r.top = CINT (FIELD (mlrect,3));
  if (!FrameRect (hdc,&r,brush))
    win32_error ("FillRect failed");
  return MLUNIT;
}

static mlval invert_rect (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  mlval mlrect = FIELD (arg,1);
  RECT r;
  r.bottom = CINT (FIELD (mlrect,0));
  r.left = CINT (FIELD (mlrect,1));
  r.right = CINT (FIELD (mlrect,2));
  r.top = CINT (FIELD (mlrect,3));
  if (!InvertRect (hdc,&r))
    win32_error ("FillRect failed");
  return MLUNIT;
}

static mlval pie (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  int a5 = CINT (FIELD (arg,5));
  int a6 = CINT (FIELD (arg,6));
  int a7 = CINT (FIELD (arg,7));
  int a8 = CINT (FIELD (arg,8));
  if (!Pie (hdc,a1,a2,a3,a4,a5,a6,a7,a8))
    win32_error ("Pie failed");
  return MLUNIT;
}

static mlval rectangle (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  if (!Rectangle (hdc,a1,a2,a3,a4))
    win32_error ("Rectangle failed");
  return MLUNIT;
}

static mlval round_rect (mlval arg)
{
  HDC hdc = CHDC (FIELD (arg,0));
  int a1 = CINT (FIELD (arg,1));
  int a2 = CINT (FIELD (arg,2));
  int a3 = CINT (FIELD (arg,3));
  int a4 = CINT (FIELD (arg,4));
  int a5 = CINT (FIELD (arg,5));
  int a6 = CINT (FIELD (arg,6));
  if (!RoundRect (hdc,a1,a2,a3,a4,a5,a6))
    win32_error ("RoundRect failed");
  return MLUNIT;
}

static int bk_mode [] = 
{
  OPAQUE,
  TRANSPARENT
};

static int convert_bk_mode(mlval arg)
{
  return (bk_mode[CINT(arg)]);
}

static mlval get_bk_mode(mlval arg)
{
  HDC hdc = CHDC(arg);
  int return_mode = GetBkMode(hdc);

  if (!return_mode)
    win32_error("GetBkMode failed");

  /* OPAQUE result maps to 0 as the ML datatype is alphabetically ordered. */
  if (return_mode == OPAQUE)
    return MLINT(0);
  else
    return MLINT(1);
}

static mlval set_bk_mode(mlval arg)
{
  HDC hdc = CHDC(FIELD(arg, 0));
  int mode = convert_bk_mode(FIELD(arg, 1));
  int return_mode = SetBkMode(hdc, mode);

  if (!return_mode) 
    win32_error("SetBkMode failed");

  if (return_mode == OPAQUE) 
    return MLINT(0);
  else
    return MLINT(1);
}

/* COLORS */

static int get_color_values [] =
{
  COLOR_ACTIVEBORDER,
  COLOR_ACTIVECAPTION,
  COLOR_APPWORKSPACE,
  COLOR_BACKGROUND,
  COLOR_BTNSHADOW,
  COLOR_BTNTEXT,
  COLOR_CAPTIONTEXT,
  COLOR_GRAYTEXT,
  COLOR_HIGHLIGHT,
  COLOR_HIGHLIGHTTEXT,
  COLOR_INACTIVEBORDER,
  COLOR_INACTIVECAPTION,
  COLOR_INACTIVECAPTIONTEXT,
  COLOR_MENU,
  COLOR_SCROLLBAR,
  COLOR_WINDOW,
  COLOR_WINDOWFRAME,
  COLOR_WINDOWTEXT
};

static mlval get_sys_color (mlval arg)
{
  DWORD result = GetSysColor (get_color_values [CINT (arg)]);
  /* Do we need an error check? */
  return (box (result));
}

/* Returns the previous background color */
static mlval set_bk_color (mlval arg)
{
  HDC hdc = (HDC)unbox (FIELD (arg,0));
  COLORREF color = (COLORREF)unbox (FIELD (arg,1));
  return (box (SetBkColor (hdc,color)));
}

static mlval get_bk_color (mlval arg)
{
  HDC hdc = (HDC)unbox (arg);
  return (box (GetBkColor (hdc)));
}

static mlval set_text_color (mlval arg)
{
  HDC hdc = (HDC)unbox (FIELD (arg,0));
  COLORREF color = (COLORREF)unbox (FIELD (arg,1));
  return (box (SetTextColor (hdc,color)));
}

static mlval get_text_color (mlval arg)
{
  HDC hdc = (HDC)unbox (arg);
  return (box (GetTextColor (hdc)));
}

static mlval text_out (mlval arg)
{
  HDC hdc = (HDC) unbox (FIELD (arg,0));
  int x = CINT (FIELD (arg,1));
  int y = CINT (FIELD (arg,2));
  mlval mlstring = FIELD (arg,3);
  LPCTSTR lpstring = CSTRING (mlstring);
  int len = CSTRINGLENGTH (mlstring);
  if (!TextOut (hdc,x,y,lpstring,len))
    win32_error ("TextOut failed");
  return MLUNIT;
}

static mlval get_text_extent_point (mlval arg)
{
  HDC hdc = (HDC) unbox (FIELD (arg,0));
  mlval mlstring = FIELD (arg,1);
  LPCTSTR lpstring = CSTRING (mlstring);
  SIZE size;
  mlval result;
  int len = CSTRINGLENGTH (mlstring);
  if (!GetTextExtentPoint32 (hdc,lpstring,len,&size))
    win32_error ("GetTextExtentPoint32 failed");
  result = allocate_record (2);
  FIELD (result,0) = MLINT (size.cx);
  FIELD (result,1) = MLINT (size.cy);
  return (result);
}

static mlval validate_rect (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  CONST RECT *rectp;
  mlval a = FIELD (arg,1);
  if (a == MLINT (0))
    rectp = NULL;
  else
    {
      RECT r;
      mlval mlrect = FIELD (a,1); /* Get carried value */
      r.bottom = CINT (FIELD (mlrect,0));
      r.left = CINT (FIELD (mlrect,1));
      r.right = CINT (FIELD (mlrect,2));
      r.top = CINT (FIELD (mlrect,3));
      rectp = &r;
    }

  if (!ValidateRect (hwnd,rectp))
      win32_error ("ValidateRect failed");
  return MLUNIT;
}

static mlval invalidate_rect (mlval arg)
{
  HWND hwnd = CHWND (FIELD (arg,0));
  CONST RECT *rectp;
  mlval a = FIELD (arg,1);
  if (a == MLINT (0))
    rectp = NULL;
  else
    {
      RECT r;
      mlval mlrect = FIELD (a,1); /* Get carried value */
      r.bottom = CINT (FIELD (mlrect,0));
      r.left = CINT (FIELD (mlrect,1));
      r.right = CINT (FIELD (mlrect,2));
      r.top = CINT (FIELD (mlrect,3));
      rectp = &r;
    }

  if (!InvalidateRect (hwnd,rectp,MLBOOL (FIELD (arg,2))))
      win32_error ("ValidateRect failed");
  return MLUNIT;
}

static mlval window_from_dc (mlval arg)
{
  HDC hdc = (HDC) unbox (arg);
  return (MLHWND (WindowFromDC (hdc)));
}

/* mix modes for drawing */

static int rop2_values [] =
{
  R2_BLACK,
  R2_COPYPEN,
  R2_MASKNOTPEN,
  R2_MASKPEN,
  R2_MASKPENNOT,
  R2_MERGENOTPEN,
  R2_MERGEPEN,
  R2_MERGEPENNOT,
  R2_NOP,
  R2_NOT,
  R2_NOTCOPYPEN,
  R2_NOTMASKPEN,
  R2_NOTMERGEPEN,
  R2_NOTXORPEN,
  R2_WHITE,
  R2_XORPEN
};

static int convert_rop2_value (mlval n)
{
  return (rop2_values [CINT (n)]);
}

static mlval rop2_value_to_ml (int n)
{
  int lim = sizeof (rop2_values) / sizeof (int);
  int i;
  for (i=0;i<lim;i++)
    if (n == rop2_values[i])
      return (MLINT (i));
  exn_raise_string(perv_exn_ref_win, "Bad rop2 value");
  return MLUNIT;
}

static mlval get_rop2 (mlval arg)
{
  HDC hdc = (HDC)unbox(arg);
  return (rop2_value_to_ml (GetROP2 (hdc)));
}

static mlval set_rop2 (mlval arg)
{
  HDC hdc = (HDC)unbox (FIELD (arg,0));
  int mode = convert_rop2_value (FIELD (arg,1));
  int previous = SetROP2 (hdc,mode);
  return (rop2_value_to_ml (previous));
}

/* Ch 21 Cursors */

static CHAR* cursor_shape [] = 
{
  IDC_APPSTARTING,
  IDC_ARROW,
  IDC_CROSS,
  IDC_IBEAM,
  IDC_ICON,
  IDC_NO,
  IDC_SIZE,
  IDC_SIZEALL,
  IDC_SIZENESW,
  IDC_SIZENS,
  IDC_SIZEWE,
  IDC_UPARROW,
  IDC_WAIT
};

/* Need some functions for creating etc. cursors */
static mlval clip_cursor (mlval arg)
{
  if (arg == MLNONE)
    {
      if (!ClipCursor (NULL))
	win32_error ("ClipCursor failed");
      return MLUNIT;
    }
  else
    {
      RECT r;
      arg = FIELD (arg,1); /* get carried value */
      /* field order is: bottom,left,right,top */
      r.bottom = CINT (FIELD (arg,0));
      r.left = CINT (FIELD (arg,1));
      r.right = CINT (FIELD (arg,2));
      r.top = CINT (FIELD (arg,3));
      if (!ClipCursor (&r))
	win32_error ("ClipCursor failed");
      return MLUNIT;
    }
}

static mlval get_clip_cursor (mlval arg)
{
  RECT r;
  mlval result;
  if (!GetClipCursor (&r))
    win32_error ("GetClipCursor failed");
  result = allocate_record (4);
  FIELD (result,0) = MLINT (r.bottom);
  FIELD (result,1) = MLINT (r.left);
  FIELD (result,2) = MLINT (r.right);
  FIELD (result,3) = MLINT (r.top);
  return (result);
}

static mlval get_cursor_pos (mlval arg)
{
  POINT p;
  mlval result;
  if (!GetCursorPos (&p))
    win32_error ("GetCursorPos failed");
  result = allocate_record (2);
  FIELD (result,0) = MLINT (p.x);
  FIELD (result,1) = MLINT (p.y);
  return result;
}

static mlval set_cursor_pos (mlval arg)
{
  int x = CINT (FIELD (arg,0));
  int y = CINT (FIELD (arg,1));
  if (!SetCursorPos (x,y))
    win32_error ("SetCursorPos failed");
  return MLUNIT;
}

static mlval show_cursor (mlval arg)
{
  BOOL b = CBOOL (arg);
  return (MLINT (ShowCursor (b)));
}

static mlval set_cursor(mlval arg)
{
  HCURSOR new_cursor = (HCURSOR)unbox(arg);

  return box((UINT)SetCursor(new_cursor));
}

static mlval load_cursor(mlval arg)
{
  char* shape = cursor_shape[CINT(arg)];

  return box((UINT)LoadCursor(NULL, shape));
}

/* Accelerator tables */

static mlval copy_accelerator_table (mlval arg)
{
  error ("copy_accelerator_table unimplemented");
  return MLUNIT;
}

static BYTE accelerator_flags[] =
{
  FALT,
  FCONTROL,
  FNOINVERT,
  FSHIFT,
  FVIRTKEY
};


static BYTE convert_accelerator_flags (mlval arg)
{
  BYTE result = 0;
  while (arg != MLNIL) {
    result |= accelerator_flags[CINT (FIELD (arg,0))];
    arg= FIELD(arg,1);
  }
  return result;
}



/* The argument is a list of accelerator objects */
static mlval create_accelerator_table (mlval arg)
{
  HACCEL result;
  size_t len = list_length(arg);
  LPACCEL data = (LPACCEL)alloc(len*sizeof(ACCEL), "create_accelerator_table");
  LPACCEL ptr = data;
  while (arg != MLNIL)
    {
      mlval item = FIELD (arg,0);
      BYTE flags = convert_accelerator_flags (FIELD (item,0));
      WORD key = CINT (FIELD (item,1));
      WORD cmd = CINT (FIELD (item,2));
      /* printf ("Converting %d,%d,%d\n",flags,key,cmd); */ 
      ptr->fVirt = flags;
      ptr->key = key;
      ptr->cmd = cmd;
      arg = FIELD (arg,1);
      ptr++;
    }
  /* printf ("Creating accelerator table, size %d\n",len); */
  result = CreateAcceleratorTable (data,len);
  free (data);
  if (!result)
    win32_error ("CreateAcceleratorTable failed");
  return box((UINT)result);
}



static mlval destroy_accelerator_table (mlval arg)
{
  if (!DestroyAcceleratorTable((HACCEL)unbox(arg)))
    win32_error("DestroyAcceleratorTable failed");
  return MLUNIT;
}



/* where should this get the HINSTANCE value from? */
static mlval load_accelerators (mlval arg)
{
  HINSTANCE hinst= (HINSTANCE)unbox(FIELD(arg,0));
  LPCTSTR name= CSTRING (FIELD (arg,1));
  HACCEL result= LoadAccelerators(hinst,name);
  if (!result)
    win32_error("LoadAccelerators failed");
  return (box ((UINT)result));
}

/* Currently not used */
static mlval translate_accelerators (mlval arg)
{
  error ("translate_accelerators unimplemented");
  return MLUNIT;
}

static mlval set_accelerator_table (mlval arg)
{
  HACCEL table = (HACCEL)unbox(arg);
  int size = CopyAcceleratorTable (table,(LPACCEL)NULL,0);
  hAccelTable = table;
  return MLUNIT;
}

/* Clipboard functions */

/* This should return a bool -- the Open may fail if another */
/* process has opened the clipboard */

mlval open_clipboard (mlval arg)
{
  return (MLBOOL (OpenClipboard (CHWND (arg))));
}

mlval close_clipboard(mlval arg)
{
  if (!CloseClipboard())
    win32_error ("CloseClipboard failed");
  return MLUNIT;
}

mlval empty_clipboard(mlval arg)
{
  if (!EmptyClipboard())
    win32_error ("EmptyClipboard failed");
  return MLUNIT;
}

/* This just deals with text information right now */
mlval set_clipboard_data (mlval arg)
{
  char *data= CSTRING(arg);
  char *copy;
  HANDLE hgbl = GlobalAlloc (GMEM_DDESHARE | GMEM_MOVEABLE,
			     strlen (data) + 1);
  if (hgbl == NULL)
    report_error ("GlobalAlloc failed in set_clipboard_data");
  copy = (char *)GlobalLock (hgbl);
  strcpy (copy,data);
  GlobalUnlock (hgbl);
  SetClipboardData (CF_TEXT,hgbl);
  return MLUNIT;
}

/* This also just deals with text information */
mlval get_clipboard_data (mlval unit)
{
  mlval result;
  char *data;
  HANDLE hgbl = GetClipboardData (CF_TEXT);
  if (hgbl == NULL)
    {
      result= ml_string("");
    }
  else
    {
      data = (char *)GlobalLock (hgbl);
      result = allocate_string (strlen (data)+1);
      strcpy (CSTRING (result),data);
      GlobalUnlock (hgbl);
    }

  return (result);
}

/* I guess if we do want to pass the instance information to the functions */
/* above, we could put it in appropriate global variables */

#ifdef RUNTIME_DLL
extern mlw_ci_export int WINAPI Mlwdll_WinMain(HINSTANCE hinst,
		   HINSTANCE previnstance, 
		   LPSTR cmdline,
		   int showstate)
#else
extern int WINAPI WinMain(HINSTANCE hinst,
		   HINSTANCE previnstance, 
		   LPSTR cmdline,
		   int showstate)
#endif
{
  int argc = 0;
  int i;
  char **argv;
  char *cline;
 
  /* skip leading whitespace */
  while (*cmdline == ' ' || *cmdline == '\t')
    cmdline++;
  cline = alloc(strlen(cmdline) + 1, "WinMain.cmdline");
  strcpy (cline,cmdline);
  while (*cmdline)
    {
      argc++;
      while (*cmdline && *cmdline != ' ' && *cmdline != '\t')
	cmdline++;
      while (*cmdline == ' ' || *cmdline == '\t')
	cmdline++;
    }
  /* Have one extra argument */
  argc = argc + 1;
  argv = (char**)alloc(argc * sizeof(char *), "WinMain.argv");
  i = 0;
  /* Add a dummy first argument as windows doesn't supply this */
  argv [i++] = "rts\runtime";
  while (*cline)
    {
      argv [i++] = cline;
      while (*cline && *cline != ' ' && *cline != '\t')
	cline++;
      while (*cline == ' ' || *cline == '\t')
	*cline++ = 0;
    }

  return (run_main (argc,argv));
}

/* Global root management */

/* This gets called at load time if a global root is not present in an image */
static void win_global_root_restore(const char *name, mlval *root)
{
  *root = MLNIL;
}

/* This gets called at save/deliver time */
static mlval win_global_root_save(const char *name, mlval *root, int deliver)
{
  /* if we are delivering, clear the root down so the image is small */
  if (deliver)
    *root = MLNIL;
  /* in any case, return DEAD so the root doesn't get recorded */
  return DEAD;
}

/* This gets called at save/deliver time */
static mlval win_internal_root_save(const char *name, mlval *root, int deliver)
{
  /* always clear the root down */
  *root = MLNIL;
  /* and return DEAD so the root doesn't get recorded */
  return DEAD;
}

/* Initialization */

void winmain_init(void)
{
  UINT i=0;
  InitCommonControls();

  while (message_values[i] != FIND_MSG) {
    i++;
  }

  /* You will need to update FIND_MSG_INDEX if there are a different number
   * of entries in the message_values list before the FIND_MSG entry.
   */
  if (i != FIND_MSG_INDEX) 
    DIAGNOSTIC (1, 
       "You may have an invalid index of FIND_MSG - see src/OS/Win32/window.c\n", 0, 0);

  message_values[i] = RegisterWindowMessage(FINDMSGSTRING);

  hInst = (HINSTANCE)GetModuleHandle(NULL);
  if (!InitApplication(hInst)) { /* Initialize shared thing */
    error("Unable to initialise application");     /* Exits if unable to initialize */
  };
  hAccelTable = LoadAccelerators (hInst, szAppName);

  /* global roots used to clean the heap on image save and delivery */
  declare_global("nt menu table", &menu_table, GLOBAL_UNMATCHED_ERROR,
		 win_global_root_save, NULL, win_global_root_restore);
  declare_global("nt handler map", &handler_map, GLOBAL_UNMATCHED_ERROR,
		 win_global_root_save, NULL, win_global_root_restore);
  declare_global("nt timer handlers", &timer_handlers, GLOBAL_UNMATCHED_ERROR,
		 win_global_root_save, NULL, win_global_root_restore);

  init_registered_windows ();

  /* MLWORKS SPECIFIC FUNCTIONS */
  env_function("nt get handler map", get_handler_map);
  env_function("nt set handler map", set_handler_map);

  env_function("nt add menu command", add_menu_command);
  env_function("nt main loop", main_loop);
  env_function("nt quit on exit", quit_on_exit);
  env_function("nt do input", do_input);
  env_function("nt main init", main_init);
  env_function("uninitialise mlworks", uninitialise_mlworks);
  env_function("nt get ml window proc", get_ml_window_proc);
  env_function("nt set accelerator table",set_accelerator_table);
  env_function("nt register popup window", register_popup_window);
  env_function("nt unregister popup window", unregister_popup_window);

  /* Message widget interface */
  env_function("nt set message widget", set_message_widget);
  env_function("nt no message widget", no_message_widget);


  /* THE LIBRARY FUNCTIONS */

  /* Miscellaneous */
  env_function("nt ml malloc", ml_malloc);
  env_function("nt make c string", make_c_string);
  env_function("nt ml free",ml_free);
  env_function("nt word to string",word_to_string);
  env_function("nt set byte",set_byte);
  env_function("win32 min window size", min_window_size);

  /* Data conversion functions */
  env_function("nt convert gwl value",convert_gwl_value);
  env_function("nt convert message",ml_convert_message);
  env_function ("nt ml convert sb value", ml_convert_sb_value);
  env_function ("nt ml convert sc value", ml_convert_sc_value);
  env_function("win32 ml convert wa value", ml_convert_wa_value);
  env_function("win32 convert tb states", ml_convert_tb_states);
  env_function("win32 convert window style", ml_convert_window_style);

  /* Yer actual windows functions */
  /* Ch. 1 General windows functions */
  env_function("nt any popup", any_popup);
  env_function("nt bring window to top", bring_window_to_top);
  env_function("win32 center window", center_window);
  env_function("nt close window", close_window);
  env_function("nt child window from point", child_window_from_point);
  env_function("nt create window", create_window);
  env_function("win32 create window ex", create_window_ex);
  env_function("nt destroy window", destroy_window);
  env_function("nt enum child windows", enum_child_windows);
  env_function("nt enum windows", enum_windows);
  env_function("nt find window", find_window);
  env_function("nt get client rect", get_client_rect);
  env_function("nt get desktop window", get_desktop_window);
  env_function("nt get foreground window", get_foreground_window);
  env_function("nt get last active popup", get_last_active_popup);
  env_function("nt get next window", get_next_window);
  env_function("nt get top window", get_top_window);
  env_function("nt get parent", get_parent);
  env_function("nt get window", get_window);
  env_function("nt get window rect", get_window_rect);
  env_function("win32 get window placement", get_window_placement);
  env_function("nt is child", is_child);
  env_function("nt is iconic", is_iconic);
  env_function("nt is window", is_window);
  env_function("nt is window unicode", is_window_unicode);
  env_function("nt is window visible", is_window_visible);
  env_function("nt is zoomed", is_zoomed);
  env_function("nt move window", move_window);
  env_function("nt set foreground window", set_foreground_window);
  env_function("nt set parent", set_parent);
  env_function("nt set window text", set_window_text);
  env_function("win32 set window pos", set_window_pos);
  env_function("nt show owned popups", show_owned_popups);
  env_function("nt show window", show_window);
  env_function("nt update window", update_window);
  env_function("nt window from point",window_from_point);
  env_function("win32 get minmax info", get_minmax_info);
  env_function("win32 set minmax info", set_minmax_info);

  /* Ch. 2 Messages & Message Queues */
  env_function("nt get input state",get_input_state);
  env_function("nt get message pos",get_message_pos);
  env_function("nt get message time", get_message_time);
  env_function("nt in send message", in_send_message);
  env_function("nt post message", post_message);
  env_function("nt post quit message", post_quit_message);
  env_function("nt send message", send_message);

  /* Ch.3 Window Classes */

  env_function("nt get window long", get_window_long);
  env_function("nt set window long", set_window_long);

  /* Ch. 4 Window Procedures */

  /* Ch. 5 Keyboard input */

  /* Omitted functions for manipulating keys & the keyboard */
  env_function("nt enable window", enable_window);
  env_function("nt get active window", get_active_window);
  env_function("nt get focus", get_focus);
  env_function("nt is window enabled", is_window_enabled);
  env_function("nt set active window", set_active_window);
  env_function("nt set focus", set_focus);

  /* Ch. 6 Mouse Input */

  env_function ("nt get capture", get_capture);
  env_function ("nt release capture",release_capture);
  env_function ("nt set capture", set_capture);

  /* Ch. 7 Timers */

  env_function ("nt kill timer", kill_timer);
  env_function ("nt set timer", set_timer);
  
  /* Ch. 8 Hooks */

  /* Ch. 9 Controls */
/*  env_function ("nt create status window", create_status_window);*/
  env_function("win32 create toolbar ex", create_toolbar_ex);

  /* Ch. 10 Buttons */
  env_function ("nt check dlg button",check_dlg_button);
  env_function ("nt check radio button",check_radio_button);
  env_function ("nt is dlg button checked",is_dlg_button_checked);

  /* Ch. 11 List Boxes */

  /* Ch. 12 Edit Controls */

  /* Ch. 13 Combo Boxes */

  /* Ch. 14 Scroll Bars */
  env_function ("nt enable scroll bar", enable_scroll_bar);
  env_function ("nt get scroll pos",get_scroll_pos);
  env_function ("nt get scroll range",get_scroll_range);
  env_function ("nt set scroll pos",set_scroll_pos);
  env_function ("nt set scroll range",set_scroll_range);
  env_function ("nt show scroll bar", show_scroll_bar);
  env_function ("nt get scroll info", get_scroll_info);

  /* Ch. 15 Static Controls */

  /* Ch. 16 Menus */
  env_function("nt append menu", append_menu);
  env_function("nt check menu item", check_menu_item);
  env_function("nt create menu", create_menu);
  env_function("nt create popup menu", create_popup_menu);
  env_function("nt delete menu", delete_menu);
  env_function("nt destroy menu", destroy_menu);
  env_function("nt draw menu bar", draw_menu_bar);
  env_function("nt enable menu item", enable_menu_item);
  env_function("nt get menu", get_menu);
  env_function("nt get menu item id", get_menu_item_id);
  env_function("nt get menu item count", get_menu_item_count);
  env_function("nt get submenu", get_submenu);
  env_function("nt get system menu", get_system_menu);
  env_function("nt remove menu", remove_menu);
  env_function("nt set menu", set_menu);

  /* Ch. 17 Keyboard Accelerators */
  env_function ("nt copy accelerator table", copy_accelerator_table);
  env_function ("nt create accelerator table",create_accelerator_table);
  env_function ("nt destroy accelerator table", destroy_accelerator_table);
  env_function ("nt load accelerators", load_accelerators);
  env_function ("nt translate accelerators",translate_accelerators);

  /* Ch.18 Dialogs */
  env_function("nt create dialog",create_dialog);
  env_function("nt create dialog indirect",create_dialog_indirect);
  env_function("nt dialog box",dialog_box);
  env_function("nt dialog box indirect",dialog_box_indirect);
  env_function("nt end dialog",end_dialog);
  env_function("nt get dialog base units",get_dialog_base_units);
  env_function("nt get dlg item",get_dlg_item);
  env_function("win32 get dlg ctrl id", get_dlg_ctrl_id);
  env_function("nt message box",message_box);

  env_value("win32 cancel id", MLINT(IDCANCEL));
  env_value("win32 ok id", MLINT(IDOK));
  env_value("win32 retry id", MLINT(IDRETRY));
  env_value("win32 abort id", MLINT(IDABORT));
  env_value("win32 ignore id", MLINT(IDIGNORE));
  env_value("win32 no id", MLINT(IDNO));
  env_value("win32 yes id", MLINT(IDYES));
  

  /* Ch. 19 Rectangles */

  /* Ch. 20 Painting and Drawing */
  env_function ("win32 get bk mode", get_bk_mode);
  env_function ("win32 set bk mode", set_bk_mode);

  env_function ("nt get bk color", get_bk_color);
  env_function ("nt get rop2", get_rop2);
  env_function ("nt set bk color", set_bk_color);
  env_function ("nt set rop2", set_rop2);
  env_function ("nt set pixel", set_pixel); 
  env_function ("nt validate rect", validate_rect);
  env_function ("nt invalidate rect", invalidate_rect);
  env_function ("nt window from dc", window_from_dc);
  
  /* Ch. 21 Cursors */

  env_function ("nt clip cursor", clip_cursor);
  env_function ("nt get clip cursor", get_clip_cursor);
  env_function ("nt get cursor pos", get_cursor_pos);
  env_function ("nt set cursor pos", set_cursor_pos);
  env_function ("nt show cursor", show_cursor);
  env_function("win32 set cursor", set_cursor);
  env_function("win32 load cursor", load_cursor);

  /* Ch. 22 Carets */

  /* Ch. 23 Icons */

  /* Ch. 24 Window Properties */

  /* Ch. 25 Clipboard */
  env_function("nt close clipboard",close_clipboard);
  env_function("nt empty clipboard",empty_clipboard);
  env_function("nt get clipboard data",get_clipboard_data);
  env_function("nt open clipboard",open_clipboard);
  env_function("nt set clipboard data",set_clipboard_data);

  /* Ch. 26 DDE */

  /* Ch. 27 MDI */

  /* PART TWO: Graphics Device Interface */

  /* Ch. 28 Device Contexts */
  env_function ("nt cancel dc", cancel_dc);
  env_function ("nt create compatible dc", create_compatible_dc);
  env_function ("nt delete object", delete_object);
  env_function ("nt get current object", get_current_object);
  env_function ("nt get dc",get_dc);
  env_function ("nt get dc org ex",get_dc_org_ex);
  env_function ("nt get stock object", get_stock_object);
  env_function ("nt release dc",release_dc);
  env_function ("nt restore dc",restore_dc);
  env_function ("nt save dc", save_dc);
  env_function ("nt select object",select_object);

  /* Ch. 29 Bitmaps */
  env_function ("win32 bit blt", bit_blt);

  /* Ch. 30 Brushes */
  env_function ("nt create hatch brush", create_hatch_brush);
  env_function ("nt create solid brush", create_solid_brush);
/*
  env_function ("nt get brush org", get_brush_org);
  env_function ("nt set brush org", set_brush_org);
*/

  /* Ch. 31 Pens */
  env_function ("nt create pen", create_pen);

  /* Ch. 32 Regions */

  /* Ch. 33 Lines and Curves */
  env_function ("nt angle arc", angle_arc);
  env_function ("nt arc", arc);
  env_function ("nt arc to",arc_to);
  env_function ("nt get arc direction", get_arc_direction);
  env_function ("nt line to", line_to);
  env_function ("nt move to", move_to);
  env_function ("nt set arc direction", set_arc_direction);

  /* Ch. 34 Filled Shapes */
  env_function ("nt chord",chord);
  env_function ("nt ellipse",ellipse);
  env_function ("nt fill rect", fill_rect);
  env_function ("nt frame rect", frame_rect);
  env_function ("nt invert rect", invert_rect);
  env_function ("nt pie", pie);
  env_function ("nt rectangle", rectangle);
  env_function ("nt round rect", round_rect);

  /* Ch. 35 Fonts and Text */
  env_function ("nt get text color", get_text_color);
  env_function ("nt get text extent point", get_text_extent_point);
  env_function ("nt set text color", set_text_color);
  env_function ("nt text out", text_out);

  /* Ch. 36 Colors */

  /* Ch. 37 Paths */

  /* Ch. 38 Clipping */

  /* Ch. 39 Coordinate Spaces & Transformations */
  env_function("nt client to screen", client_to_screen);
  env_function("nt screen to client", screen_to_client);

  /* Ch. 40 MetaFiles */

  /* Ch. 41 Printing & Print Spooling */

  /* System Information Functions */
  env_function ("nt get sys color", get_sys_color);

  /* Error functions */
  env_function("nt message beep",message_beep);
  
  /* Other */

  env_function("win32 find resource", find_resource);
  env_function("win32 lock resource", lock_resource);
  env_function("win32 load resource", load_resource);
  env_function("win32 get module handle", get_module_handle);
  env_function("win32 load library", load_library);
  env_function("win32 free library", free_library);

  env_function("win32 get splash bitmap", get_splash_bitmap);
  env_function("win32 paint splash bitmap", paint_splash_bitmap);

  current_dir[0] = '\0';
  strcpy(current_filesys_dir, get_init_dir("Get current directory failed"));
  
  env_function("win32 find dialog", find_dialog);
  env_function("win32 get find flags", get_find_flags);

  env_function("nt open dir dialog",open_dir_dialog);
  env_function("nt open file dialog",open_file_dialog);
  env_function("win32 save dialog",save_dialog);
  env_function("nt set interrupt window", set_interrupt_window);

  env_function("nt ml window updates toggle", ml_window_updates_toggle);
  env_function("win32 process notify", process_notify);
  
  env_function("win32 interrupt", interrupt);

  windows_exns_initialised = ref (MLFALSE);
  env_value("nt windows exns initialised", windows_exns_initialised);
  declare_global("nt windows exns initialised", &windows_exns_initialised, 
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  perv_exn_ref_win = ref(exn_default);
  env_value("exception win", perv_exn_ref_win);
  declare_global("pervasive exception win", &perv_exn_ref_win,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
}

void display_simple_message_box(const char *message)
{
  int result = MessageBox (NULL,
                           message, "Warning", MB_ICONWARNING | MB_TASKMODAL);
  if (result == 0)
    win32_error ("MessageBox failed");
}
