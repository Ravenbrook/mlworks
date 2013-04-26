/*  ==== PERVASIVE INTERFACE TO X LIBRARIES ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: x.c,v $
 *  Revision 1.42  1998/06/24 16:26:45  johnh
 *  [Bug #30433]
 *  Use new splash screen and fix problem of colour failure in pixmap.
 *
 * Revision 1.41  1998/06/15  09:10:50  johnh
 * [Bug #70135]
 * Fix list selection problem.
 *
 * Revision 1.40  1998/06/11  15:13:21  johnh
 * [Bug #30411]
 * Add timer functions.
 *
 * Revision 1.39  1998/06/08  10:06:39  jont
 * [Bug #30369]
 * Fix compiler warning
 *
 * Revision 1.38  1998/06/01  17:40:43  johnh
 * [Bug #30369]
 * Modify list callback struct to handle multiple selection cases.
 *
 * Revision 1.37  1998/05/26  15:31:22  mitchell
 * [Bug #30411]
 * Support for time-limited runtime
 *
 * Revision 1.36  1998/03/26  15:07:37  jont
 * [Bug #30090]
 * Change use of perv_exn_ref_io to use syserr
 *
 * Revision 1.35  1998/02/23  18:50:04  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.34  1998/01/23  17:24:35  jont
 * [Bug #20076]
 * Add x_hide_podium call for when the license has been reacquired
 *
 * Revision 1.33  1997/11/18  16:41:34  jont
 * [Bug #30325]
 * Add include of unixlocal.h to get lstat
 *
 * Revision 1.32  1997/11/18  14:08:04  johnh
 * [Bug #30322]
 * Add visual functions and set window attr functions.
 *
 * Revision 1.31  1997/11/06  14:06:34  johnh
 * [Bug #30125]
 * Implement open_web_location.
 *
 * Revision 1.30  1997/08/19  15:14:03  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.29  1997/05/09  16:40:03  daveb
 * [Bug #30020]
 * Separated mlworks-specific initialisation from general motif initialisation by
 * providing the mlw_check_resources function.   There is still some work left
 * to achieve a pure separation, primarily in the call to XtOpenDisplay.
 *
 * Revision 1.28.1.1.3.2  1997/11/18  11:53:53  johnh
 * [Bug #30322]
 * Add visual functions and set window attr functions.
 *
 * Revision 1.28  1997/03/14  16:22:23  johnh
 * [Bug #1973]
 * Using XmClipboard functions for cut and paste operations.
 *
 * Revision 1.27  1997/03/12  16:45:54  andreww
 * [Bug #1955]
 * Yield thread when waiting for input event only when
 * running threads preemptively.
 *
 * Revision 1.26  1997/02/27  13:55:16  johnh
 * [Bug #1883]
 * Added XmTextShowPosition to message_widget_output.
 *
 * Revision 1.25  1996/12/18  13:05:36  stephenb
 * [Bug #1847]
 * set_gc_values: remove diagnostic printf.
 *
 * Revision 1.24  1996/11/07  18:31:18  daveb
 * Allowed do_input to runt even if mainLoopContinure not set.  This allows
 * the ilicense dialog to run before the podium.
 *
 * Revision 1.23  1996/11/07  10:02:45  daveb
 * Names of bitmap data have changed.
 *
 * Revision 1.22  1996/11/05  11:21:35  daveb
 * [Bug #1703]
 * Corrected the implementation of string_has_substring, which was calling
 * XmStringByteCompare instead of XmStringHasSubstring.
 *
 * Revision 1.21  1996/11/04  17:20:16  daveb
 * [Bug #1699]
 * Changed gc_copy to reflect the C semantics.
 *
 * Revision 1.20  1996/11/04  11:01:02  daveb
 * [Bug #1694]
 * Removed obsolete items.
 *
 * Revision 1.19  1996/10/17  14:03:47  jont
 * Merging in license server stuff
 *
 * Revision 1.18.1.2  1996/10/14  16:28:11  nickb
 * Add x_reveal_podium() stub.
 *
 * Revision 1.18.1.1  1996/10/07  16:12:59  hope
 * branched from 1.18
 *
 * Revision 1.18  1996/10/01  12:40:26  matthew
 * Adding a release colourmap function
 *
 * Revision 1.17  1996/09/27  13:49:53  johnh
 * [Bug #1617]
 * Added a check to ensure that XSystemError exn is not overwritten.
 *
 * Revision 1.16  1996/09/25  11:32:43  nickb
 * Add grab-list debugging code.
 *
 * Revision 1.15  1996/09/24  14:47:02  io
 * [Bug #1611]
 * raise() changed to record_event()
 *
 * Revision 1.14  1996/09/23  14:29:03  matthew
 * Attempting to add a interrupt button handler thing
 *
 * Revision 1.13  1996/08/23  15:05:54  stephenb
 * [Bug #1542]
 * Fixed allocation problems in the following :-
 * convert_KeyEvent, convert_TextVerifyCallbackStruct (cause of #1542)
 * args_to_pairs, text_postoxy
 * return_gc_values
 *
 * Revision 1.12  1996/08/19  13:11:18  daveb
 * Fixed bug in alloc_color_cells.
 *
 * Revision 1.11  1996/07/11  13:53:42  jont
 * Fix further declare_root problems
 *
 * Revision 1.10  1996/07/10  16:25:44  jont
 * Experimentation with Linux
 *
 * Revision 1.9  1996/07/09  12:03:23  jont
 * Further optimisations over use of roots
 *
 * Revision 1.8  1996/07/03  16:22:59  jont
 * Fix problems with undeclared roots
 *
 * Revision 1.7  1996/06/27  15:46:45  jont
 * Change GLOBAL_MISSING_NIL to GLOBAL_MISSING_UNIT since this is what it really means
 *
 * Revision 1.6  1996/06/19  16:51:09  daveb
 * Added call to XtMapWidget to window_to_front.  This deiconises the window,
 * if necessary.
 *
 * Revision 1.5  1996/06/04  13:51:12  nickb
 * Make ml_selection_handler a global root.
 *
 * Revision 1.4  1996/05/28  13:44:21  matthew
 * Adding check_resources function
 *
 * Revision 1.3  1996/04/18  15:56:18  nickb
 * Callback table stretching is broken.
 *
 * Revision 1.2  1996/03/12  10:52:53  matthew
 * Adding query pointer
 *
 * Revision 1.1  1996/02/27  09:27:41  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/x.c
 *
 * Revision 1.33  1996/02/26  12:48:49  matthew
 * Revisions to Xm library
 *
 * Revision 1.32  1996/02/19  13:59:53  matthew
 * Fiddling with selection mechanism
 *
 * Revision 1.31  1996/02/16  18:02:14  nickb
 * Clear up costly root on export.
 *
 * Revision 1.30  1996/02/16  14:46:50  nickb
 * Change to declare_global().
 *
 * Revision 1.29  1996/02/13  16:30:33  io
 * add DefaultVisual
 *
 * Revision 1.28  1996/02/08  16:08:00  daveb
 * Added list_set_pos.
 *
 * Revision 1.27  1996/01/25  17:16:51  matthew
 * Adding set_selection function for text widgets
 *
 * Revision 1.26  1996/01/16  13:27:47  nickb
 * Remove printf() from message_widget_output. It doesn't belong here.
 *
 * Revision 1.25  1996/01/15  11:35:42  nickb
 * Add facility to check for runnable threads.
 *
 * Revision 1.24  1996/01/12  12:41:24  nickb
 * Improve gui/thread interaction, by not entering XtAppNextEvent if there are
 * no events pending.
 *
 * Revision 1.23  1996/01/11  12:52:11  nickb
 * Add code to start and stop window update timer events.
 *
 * Revision 1.22  1996/01/09  15:37:44  nickb
 * Reinstate x_handle_expose_events.
 *
 * Revision 1.21  1996/01/08  11:35:33  matthew
 * Adding sychronize
 *
 * Revision 1.20  1995/12/07  14:15:48  matthew
 * Adding clipboard functions
 *
 * Revision 1.19  1995/11/30  13:46:03  jont
 * Fixed compilation warning message
 *
 * Revision 1.18  1995/10/25  13:56:51  matthew
 * Changing fontstruct_load to font_load
 *
 * Revision 1.17  1995/10/18  11:10:50  matthew
 * Adding root declaration for value_array in gc_set_values
 *
 * Revision 1.16  1995/10/17  15:58:05  nickb
 * Add scale callback struct conversion.
 *
 * Revision 1.15  1995/09/27  14:55:50  brianm
 * Modified return_gc_values - mis-bracketing error ...
 *
 * Revision 1.14  1995/09/23  19:22:53  brianm
 * Adding copying of GC's and retreval of GCValues ...
 *
 * Revision 1.13  1995/09/22  10:51:07  daveb
 * Added Xm.Text.set_highlight.
 *
 * Revision 1.12  1995/09/19  10:47:18  jont
 * Fix problems with C ordering of evaluation of function parameters
 * interaction with gc and C roots
 *
 * Revision 1.11  1995/07/25  12:55:42  matthew
 * Adding support for font dimensions etc.
 *
 * Revision 1.10  1995/07/18  14:11:41  matthew
 * Adding external listener hooks
 *
 * Revision 1.9  1995/06/26  14:27:08  matthew
 * Fixing problem with ML expose events being called in GC
 *
 * Revision 1.8  1995/06/20  14:16:13  daveb
 * Added set_bottom_pos.
 *
 * Revision 1.7  1995/06/19  13:38:07  matthew
 * Problem with GC CLIP_MASK
 *
 * Revision 1.6  1995/06/08  10:05:26  matthew
 * Adding drawing primitives.
 *
 * Revision 1.5  1995/05/11  12:34:12  matthew
 * Better X error message
 *
 * Revision 1.4  1995/05/10  12:14:22  matthew
 * n
 * Added popup and createmenubar functions
 * Removed setting of event mask in mainLoop
 * /
 *
 * Revision 1.3  1995/04/27  11:47:34  daveb
 * Added the "awaiting_x_event" flag.
 * Defined message_flusher to be XFlush.
 *
 * Revision 1.2  1995/04/24  15:05:31  nickb
 * Hope bug wrecked this file.
 *
 *
 * Revision 1.1  1995/04/24  14:48:30  nickb
 * new unit
 * From SunOS version 1.14
 */

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <signal.h>

#include <X11/Xlib.h>
#include <X11/Intrinsic.h>
#include <X11/Shell.h>
#include <X11/cursorfont.h>
#include <X11/Xatom.h>
#include <Xm/Xm.h>
#include <Xm/ArrowB.h>
#include <Xm/ArrowBG.h>
#include <Xm/AtomMgr.h>
#include <Xm/BulletinB.h>
#include <Xm/CascadeB.h>
#include <Xm/CascadeBG.h>
#include <Xm/Command.h>
#include <Xm/CutPaste.h>
#include <Xm/DialogS.h>
#include <Xm/DrawingA.h>
#include <Xm/DrawnB.h>
#include <Xm/FileSB.h>
#include <Xm/Form.h>
#include <Xm/Frame.h>
#include <Xm/Label.h>
#include <Xm/LabelG.h>
#include <Xm/List.h>
#include <Xm/MainW.h>
#include <Xm/MenuShell.h>
#include <Xm/MessageB.h>
#include <Xm/PanedW.h>
#include <Xm/PushB.h>
#include <Xm/PushBG.h>
#include <Xm/RowColumn.h>
#include <Xm/Scale.h>
#include <Xm/ScrollBar.h>
#include <Xm/ScrolledW.h>
#include <Xm/SelectioB.h>
#include <Xm/Separator.h>
#include <Xm/SeparatoG.h>
#include <Xm/Text.h>
#include <Xm/TextF.h>
#include <Xm/ToggleB.h>
#include <Xm/ToggleBG.h>
#include <signal.h>

#include "ansi.h"
#include "environment.h"
#include "values.h"
#include "main.h"
#include "utils.h"
#include "diagnostic.h"
#include "allocator.h"
#include "interface.h"
#include "gc.h"
#include "exceptions.h"
#include "global.h"
#include "extensions.h"
#include "x.h"
#include "threads.h"
#include "signals.h"
#include "event.h"
#include "syscalls.h"
#include "unixlocal.h"

#include <X11/xpm.h>  /* required by xpm               */


#ifdef DEBUG_X_GRAB

/* On Irix the per-display grab list gets corrupted. The structure &c
 * of that list is defined internally to the X sources. This dirty
 * hack allows us to examine the grab list. Calling grab_check(w)
 * prints the names of the widgets on the list, with an asterisk
 * adjacent to w if that is on the list. */

struct grab {
  struct grab *next;
  Widget   widget;
};

struct pdi {
  struct grab *grab;
};

typedef struct _XtPerDisplayStruct {
  void * destroy_callbacks;
  void * region;
  void * case_cvt;		/* user-registered case converters */
  void (*defaultKeycodeTr)(void);
  void * appContext;
  unsigned long keysyms_serial;      /* for tracking MappingNotify events */
  void *keysyms;                   /* keycode to keysym table */
  int keysyms_per_keycode;           /* number of keysyms for each keycode*/
  int min_keycode, max_keycode;      /* range of keycodes */
  void *modKeysyms;                /* keysym values for modToKeysysm */
  void *modsToKeysyms;   /* modifiers to Keysysms index table*/
  unsigned char isModifier[32];      /* key-is-modifier-p bit table */
  unsigned long lock_meaning;	       /* Lock modifier meaning */
  unsigned int mode_switch;	       /* keyboard group modifiers */
  char being_destroyed;
  char rv;			       /* reverse_video resource */
  int name;		       /* resolved app name */
  int class;		       /* application class */
  struct {
    char *start;
    char *current;
    int bytes;
  } heap;
  void *GClist;	       /* support for XtGetGC */
  void *pixmap_tab;             /* ditto for XtGetGC */
  char * language;		       /* XPG language string */
  unsigned long last_timestamp;	       /* from last event dispatched */
  int multi_click_time;	       /* for XtSetMultiClickTime */
  void * tm_context;     /* for XtGetActionKeysym */
  void * mapping_callbacks;  /* special case for TM */
  struct pdi pdi;		       /* state for modal grabs & kbd focus */
} XtPerDisplayStruct, *XtPerDisplay;

typedef struct _PerDisplayTable {
	Display *dpy;
	XtPerDisplayStruct perDpy;
	struct _PerDisplayTable *next;
      } PerDisplayTable, *PerDisplayTablePtr;

extern PerDisplayTablePtr _XtperDisplayList;

extern XtPerDisplay _XtSortPerDisplayList(Display* display);

#define get_pdi(display) \
    ((_XtperDisplayList->dpy == (display)) \
     ? &_XtperDisplayList->perDpy.pdi \
     : &_XtSortPerDisplayList(display)->pdi)

#define _XtGetGrabList(pdi) (&(pdi)->grabList)

void grab_check(Widget widget)
{
  struct grab *grab = get_pdi(XtDisplay(widget))->grab;
  printf("grab list:");
  for (; grab != NULL; grab = grab->next) {
    Widget w = grab->widget;
    printf(" 0x%08x %s", w, XtName(w));
    if (w == widget)
      printf("*");
  }
  printf("\n");
}

#endif /* DEBUG_X_GRAB */

#define MAX_NR_ARGS		20

/* General Utilities */

static inline mlval box(unsigned long int x)
{
  mlval b = allocate_string(sizeof(x));

  memcpy(CSTRING(b), (char *)&x, sizeof(x));

  return(b);
}

static inline unsigned long int unbox(mlval b)
{
  unsigned long int x;

  memcpy((char *)&x, CSTRING(b), sizeof(x));

  return(x);
}

static mlval perv_exn_ref_x;
static mlval x_exns_initialised;

/* Table utilities */
#define INITIAL_HANDLER_TABLE_SIZE	1024 /* *** IMPROVE THIS MECHANISM */
					     /* One possibility would be to
						re-use callbacks.  They would
						have to be freed manually
						though. Better still would be
						a proper FFI. */

static void clear_table(mlval table, unsigned int size)
{
  unsigned int i;
  MLUPDATE(table, 0, MLINT(0));
  for(i=1; i<size; ++i)
    MLUPDATE(table, i, MLUNIT);
}  

static mlval make_table(unsigned int size)
{
  mlval result = allocate_array(size);
  clear_table(result, size);
  return result;
}

/* Events */

static unsigned int event_table_size = INITIAL_HANDLER_TABLE_SIZE;
static mlval event_table;

static void fix_event_table (const char *name, mlval *root, mlval value)
{
  event_table = value;
  event_table_size = LENGTH(ARRAYHEADER(event_table));
  clear_table(event_table, event_table_size);
}

static void create_event_table(const char *name, mlval *root)
{
  event_table = make_table(event_table_size);
}

static void event_dispatch(Widget widget, XtPointer client_data, XEvent *event, Boolean *continue_to_dispatch)
{
  DIAGNOSTIC(3, "event_dispatch(widget = 0x%X, event_nr = %d)", widget, client_data);
  DIAGNOSTIC(3, "  invoking f 0x%X", MLSUB(event_table, (size_t)client_data+1), 0);

  callml((mlval)event, MLSUB(event_table, (size_t)client_data+1));
}

/* This should share code with callback table add */
/* or we could use the same table */
static mlval add_event_handler (mlval arg)
{

  Widget w = (Widget) FIELD (arg,0);
  mlval mask_list = FIELD (arg,1); /* A list of ints for the mask */
  Boolean nonmaskable = CBOOL (FIELD (arg,2));
  mlval handler = FIELD (arg,3);
  EventMask event_mask = 0L;
  size_t event_nr = CINT(MLSUB(event_table, 0));

  DIAGNOSTIC(3, "widget_event_add(widget = 0x%X, ...)",w,0); 

  while (mask_list != MLNIL)
    {
      event_mask |= 1L << CINT(FIELD (mask_list,0));
      mask_list = FIELD (mask_list,1);
    }

  /* Element 0 of the table gives the number of events stored.  Event
     i is stored in element i+1.  Therefore the old value of element 0 gives
     the id number of the new event.  If the table is full, then
     number of events (i.e. element 0) = size of table - 1. */

  if(event_nr >= event_table_size - 1) {
    unsigned int i;
    unsigned int new_table_size = event_table_size * 2;
    mlval new_table;

    declare_root(&handler, 0);
    DIAGNOSTIC(2, "Resizing event table to %d, event_nr = %d",
	       new_table_size, event_nr);
    new_table = allocate_array(new_table_size);
    retract_root(&handler);

    for(i=0; i<event_table_size; ++i)
      MLUPDATE(new_table, i, MLSUB(event_table, i));
    for(; i<new_table_size; ++i)
      MLUPDATE(new_table, i, MLUNIT);
    event_table = new_table;
    event_table_size = new_table_size;
    event_nr = CINT(MLSUB(event_table, 0));
  }

  MLUPDATE(event_table, event_nr+1, handler);
  MLUPDATE(event_table, 0, MLINT(event_nr+1));

  XtAddEventHandler(w,event_mask,nonmaskable,event_dispatch,(XtPointer)event_nr);

  DIAGNOSTIC(3, "  event_nr = %d", event_nr, 0);

  return (MLUNIT);

}

/* Event conversions */
static mlval convert_AnyEvent(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XEvent *event = (XEvent*)arg;
  mlval result = allocate_record(5);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * display
   * event_type
   * send_event
   * serial
   * window
   */

  if (arg == (mlval)NULL) {
    /* Yes, sometimes the event component of a TextVerifyCallback can be NULL,
       just like the manual says it can't. */
    FIELD(result,  0) = (mlval)(NULL);
    FIELD(result,  1) = MLINT(0);
    FIELD(result,  2) = MLFALSE;
    FIELD(result,  3) = MLINT(0);
    FIELD(result,  4) = MLINT(0);
  } else {
    FIELD(result,  0) = (mlval)(event->xany.display);
    FIELD(result,  1) = MLINT(event->xany.type);
    FIELD(result,  2) = MLBOOL (event->xany.send_event);
    FIELD(result,  3) = MLINT(event->xany.serial);
    FIELD(result,  4) = MLINT(event->xany.window);
  }

  return result;
}

static mlval convert_ExposeEvent(mlval arg)
{
  XExposeEvent *event;
  mlval result = MLUNIT;

  declare_root(&arg, 0);
  result = allocate_record(6);
  retract_root(&arg);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * FIELD(arg,0) stuff common to all events
   * count, height,width,x,y
   */

  event = (XExposeEvent*)FIELD(arg, 1);
  FIELD(result,  0) = FIELD(arg, 0);
  FIELD(result,  1) = MLINT (event->count);
  FIELD(result,  2) = MLINT (event->height);
  FIELD(result,  3) = MLINT (event->width);
  FIELD(result,  4) = MLINT (event->x);
  FIELD(result,  5) = MLINT (event->y);

  return result;
}



static mlval convert_KeyEvent(mlval arg)
{
  XEvent *event= (XEvent*)FIELD(arg, 1);
  mlval result;
  char c= XLookupKeysym(&(event->xkey), (signed int) event->xkey.state);
  mlval key;

  /* XLookupKeysym only seems to handle normal and shifted characters.
     We want control characters as well. We could leave it up to the
     ML, but we can just as easily handle it here. */
  if (c == '\0') {
    c = XLookupKeysym(&(event->xkey), 0);
    if (c && (event->xkey.state & ControlMask))
      c -= '`';
  }

  declare_root(&arg, 0);
  key= allocate_string(2);
  CSTRING(key)[0]= c;
  CSTRING(key)[1]= '\0';

  declare_root(&key, 0);
  result= allocate_record(11);
  retract_root(&key);
  retract_root(&arg);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * FIELD(arg, 0) stuff common to all events
   * key    	   the key used
   * root          root window
   * same_screen
   * state         modifiers to key
   * subwindow     child window
   * time          in milliseconds
   * x     	   x position in window
   * x_root        x position relative to root
   * y     	   y position in window
   * y_root        y position relative to root
   */

  FIELD(result,  0) = FIELD(arg, 0);
  FIELD(result,  1) = key;
  FIELD(result,  2) = MLINT(event->xkey.root);
  FIELD(result,  3) = MLBOOL(event->xkey.same_screen);
  FIELD(result,  4) = MLINT(event->xkey.state);
  FIELD(result,  5) = MLINT(event->xkey.subwindow);
  FIELD(result,  6) = MLINT(event->xkey.time);
  FIELD(result,  7) = MLINT(event->xkey.x);
  FIELD(result,  8) = MLINT(event->xkey.x_root);
  FIELD(result,  9) = MLINT(event->xkey.y);
  FIELD(result, 10) = MLINT(event->xkey.y_root);

  return result;
}



static mlval convert_ButtonEvent(mlval arg)
{
  XEvent *event;
  mlval result = MLUNIT;

  declare_root(&arg, 0);
  result = allocate_record(11);
  retract_root(&arg);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * button    	  the button used
   * FIELD(arg,0) stuff common to all events
   * root         root window
   * same_screen
   * state        modifiers to key
   * subwindow    child window
   * time         in milliseconds
   * x     	  x position in window
   * x_root       x position relative to root
   * y     	  y position in window
   * y_root       y position relative to root
   */

  event = (XEvent*)FIELD(arg, 1);
  FIELD(result,  0) = MLINT(event->xbutton.button);
  FIELD(result,  1) = FIELD(arg, 0);
  FIELD(result,  2) = MLINT(event->xbutton.root);
  FIELD(result,  3) = MLBOOL (event->xbutton.same_screen);
  FIELD(result,  4) = MLINT(event->xbutton.state);
  FIELD(result,  5) = MLINT(event->xbutton.subwindow);
  FIELD(result,  6) = MLINT(event->xbutton.time);
  FIELD(result,  7) = MLINT(event->xbutton.x);
  FIELD(result,  8) = MLINT(event->xbutton.x_root);
  FIELD(result,  9) = MLINT(event->xbutton.y);
  FIELD(result, 10) = MLINT(event->xbutton.y_root);

  return result;
}


static mlval convert_MotionEvent(mlval arg)
{
  XEvent *event;
  mlval result = MLUNIT;

  declare_root(&arg, 0);
  result = allocate_record(11);
  retract_root(&arg);

  /* Lexical ordering for fields -- the result is a record with name fields.
   *
   * FIELD(arg, 0) stuff common to all events
   * is_hint       ??
   * root          root window
   * same_screen
   * state         modifiers to key
   * subwindow     child window
   * time          in milliseconds
   * x     	   x position in window
   * x_root        x position relative to root
   * y     	   y position in window
   * y_root        y position relative to root
   */

  event = (XEvent*)FIELD(arg, 1);
  FIELD(result,  0) = FIELD(arg, 0);
  FIELD(result,  1) = MLINT(event->xmotion.is_hint);
  FIELD(result,  2) = MLINT(event->xmotion.root);
  FIELD(result,  3) = MLBOOL(event->xmotion.same_screen);
  FIELD(result,  4) = MLINT(event->xmotion.state);
  FIELD(result,  5) = MLINT(event->xmotion.subwindow);
  FIELD(result,  6) = MLINT(event->xmotion.time);
  FIELD(result,  7) = MLINT(event->xmotion.x);
  FIELD(result,  8) = MLINT(event->xmotion.x_root);
  FIELD(result,  9) = MLINT(event->xmotion.y);
  FIELD(result, 10) = MLINT(event->xmotion.y_root);

  return result;
}


/* Motif Callbacks */  

static unsigned int callback_table_size = INITIAL_HANDLER_TABLE_SIZE;
static mlval callback_table;
static void fix_callback_table (const char *name, mlval *root, mlval value)
{
  callback_table = value;
  callback_table_size = LENGTH(ARRAYHEADER(callback_table));
  clear_table(callback_table, callback_table_size);
}

static void create_callback_table(const char *name, mlval *root)
{
  callback_table = make_table(callback_table_size);
}

static void callback_dispatch(Widget widget, XtPointer client_data, XtPointer call_data)
{
  DIAGNOSTIC(2, "callback_dispatch(widget = 0x%X, callback_nr = %d)", widget, client_data);
  DIAGNOSTIC(2, "  invoking f 0x%X", MLSUB(callback_table, (size_t)client_data+1), 0);

  awaiting_x_event = 0;
  callml((mlval)call_data, MLSUB(callback_table, (size_t)client_data+1));
}

static mlval widget_callback_add(mlval argument)
{
  size_t callback_nr = CINT(MLSUB(callback_table, 0));

  DIAGNOSTIC(3, "widget_callback_add(widget = 0x%X, name = `%s',",
	     FIELD(argument, 0), CSTRING(FIELD(argument, 1)));
  DIAGNOSTIC(3, "                    f = 0x%X)", FIELD(argument, 2), 0);

  /* Element 0 of the table gives the number of callbacks stored.
     Callback i is stored in element i+1. */

  if(callback_nr >= callback_table_size - 1) {
    unsigned int i;
    unsigned int new_table_size = callback_table_size * 2;
    mlval new_table;

    declare_root(&argument, 0);
    DIAGNOSTIC(2, "Resizing callback table to %d, callback_nr = %d",
	       new_table_size, callback_nr);
    new_table = allocate_array(new_table_size);
    retract_root(&argument);

    for(i=0; i<callback_table_size; ++i)
      MLUPDATE(new_table, i, MLSUB(callback_table, i));
    for(; i<new_table_size; ++i)
      MLUPDATE(new_table, i, MLUNIT);
    callback_table = new_table;
    callback_table_size = new_table_size;
  }

  MLUPDATE(callback_table, callback_nr+1, FIELD(argument, 2));
  MLUPDATE(callback_table, 0, MLINT(callback_nr+1));

  XtAddCallback((Widget)FIELD(argument, 0),
		CSTRING(FIELD(argument, 1)),
		callback_dispatch,
		(XtPointer)callback_nr);

  DIAGNOSTIC(3, "  callback_nr = %d", callback_nr, 0);

  return(MLUNIT);
}



static mlval convert_AnyCallbackStruct(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmAnyCallbackStruct *s = (XmAnyCallbackStruct *)arg;
  mlval result = allocate_record(2);

  FIELD(result, 0) = MLINT(s->reason);
  FIELD(result, 1) = (mlval)(s->event);

  return(result);
}



static mlval convert_DrawingAreaCallbackStruct(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmDrawingAreaCallbackStruct *s = (XmDrawingAreaCallbackStruct *)arg;
  mlval result = allocate_record(3);

  FIELD(result, 0) = MLINT(s->reason);
  FIELD(result, 1) = (mlval)(s->event);
  FIELD(result, 2) = MLINT (s->window);

  return(result);
}



static mlval convert_ToggleButtonCallbackStruct(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmToggleButtonCallbackStruct *s = (XmToggleButtonCallbackStruct *)arg;
  mlval result = allocate_record(3);
  FIELD(result, 0) = MLINT(s->reason);
  FIELD(result, 1) = (mlval)(s->event);
  FIELD(result, 2) = MLINT(s->set);

  return(result);
}



static mlval convert_ScaleCallbackStruct(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmScaleCallbackStruct *s = (XmScaleCallbackStruct *)arg;
  mlval result = allocate_record(3);
  FIELD(result, 0) = MLINT(s->reason);
  FIELD(result, 1) = (mlval)(s->event);
  FIELD(result, 2) = MLINT(s->value);

  return(result);
}



static mlval convert_ListCallbackStruct(mlval arg)
{
  mlval sel_list = MLNIL;
  mlval result;
  int i;
  
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmListCallbackStruct *s = (XmListCallbackStruct *)arg;
  
  declare_root(&sel_list, 0); 

  i=0;
  if (((s->reason) != XmCR_BROWSE_SELECT) && ((s->reason) != XmCR_SINGLE_SELECT))
    for (i = 0; i < s->selected_item_count; i++) {
      mlval temp = (mlval)(s->selected_items[i]);  /* Do NOT inline this */
      sel_list = mlw_cons(temp, sel_list);
    }

  result = allocate_record(9);
  FIELD(result, 0) = MLINT(s->reason);
  FIELD(result, 1) = (mlval)(s->event);
  FIELD(result, 2) = (mlval)(s->item);
  FIELD(result, 3) = MLINT(s->item_length);
  FIELD(result, 4) = MLINT(s->item_position);
  FIELD(result, 5) = sel_list;
  FIELD(result, 6) = MLINT(s->selected_item_count);
  FIELD(result, 7) = MLNIL;
  FIELD(result, 8) = MLINT(s->selection_type);

  retract_root(&sel_list);

  return(result);
}



static mlval convert_TextVerifyCallbackStruct(mlval arg)
{
  /* Note arg doesn't need to be a root since it is a C pointer */
  XmTextVerifyCallbackStruct *s = (XmTextVerifyCallbackStruct *)arg;
  mlval result;
  size_t len= s->text->length;
  mlval str= allocate_string(len + 1);

  strncpy(CSTRING(str), s->text->ptr, len);
  CSTRING(str)[len] = '\0';

  declare_root(&str, 0);
  result= allocate_record(8);
  retract_root(&str);

  FIELD(result, 0)= MLINT(s->reason);
  FIELD(result, 1)= (mlval)(s->event);
  FIELD(result, 2)= (mlval)(&s->doit);
  FIELD(result, 3)= MLINT(s->currInsert);
  FIELD(result, 4)= MLINT(s->newInsert);
  FIELD(result, 5)= MLINT(s->startPos);
  FIELD(result, 6)= MLINT(s->endPos);
  FIELD(result, 7)= str;

  return(result);
}



/* Used for ModifyVerify callback */  
static mlval boolean_set(mlval arg)
{
  char *do_it = (char*)FIELD(arg, 0);
  mlval bool = FIELD(arg, 1);

  *do_it = CBOOL (bool);
  return MLUNIT;
}




/* Widget Classes */
/* In ML, a widget class is a ref to one of
 * these values. The ref is never dereferenced by ML. Why? Since the
 * values can change when the runtime is relinked, the refs need to be
 * updated to match. */

#define NR_WIDGET_CLASSES	(sizeof(widget_classes)/sizeof(WidgetClass *))
static WidgetClass *widget_classes[] =
{
  /* ApplicationShell */	&applicationShellWidgetClass,
  /* ArrowButton */		&xmArrowButtonWidgetClass,
  /* ArrowButtonGadget */	&xmArrowButtonGadgetClass,
  /* BulletinBoard */		&xmBulletinBoardWidgetClass,
  /* CascadeButton */		&xmCascadeButtonWidgetClass,
  /* CascadeButtonGadget */	&xmCascadeButtonGadgetClass,
  /* Command */			&xmCommandWidgetClass,
  /* DialogShell */		&xmDialogShellWidgetClass,
  /* DrawingArea */		&xmDrawingAreaWidgetClass,
  /* DrawnButton */		&xmDrawnButtonWidgetClass,
  /* FileSelectionBox */	&xmFileSelectionBoxWidgetClass,
  /* Form */			&xmFormWidgetClass,
  /* Frame */			&xmFrameWidgetClass,
  /* Label */			&xmLabelWidgetClass,
  /* LabelGadget */		&xmLabelGadgetClass,
  /* List */			&xmListWidgetClass,
  /* MainWindow */		&xmMainWindowWidgetClass,
  /* Manager */			&xmManagerWidgetClass,
  /* MenuShell */		&xmMenuShellWidgetClass,
  /* MessageBox */		&xmMessageBoxWidgetClass,
  /* OverrideShell */		&overrideShellWidgetClass,
  /* PanedWindow */		&xmPanedWindowWidgetClass,
  /* Primitive */		&xmPrimitiveWidgetClass,
  /* PushButton */		&xmPushButtonWidgetClass,
  /* PushButtonGadget */	&xmPushButtonGadgetClass,
  /* RowColumn */		&xmRowColumnWidgetClass,
  /* Scale */			&xmScaleWidgetClass,
  /* ScrollBar */		&xmScrollBarWidgetClass,
  /* ScrolledWindow */		&xmScrolledWindowWidgetClass,
  /* SelectionBox */		&xmSelectionBoxWidgetClass,
  /* Separator */		&xmSeparatorWidgetClass,
  /* SeparatorGadget */		&xmSeparatorGadgetClass,
  /* Shell */			&shellWidgetClass,
  /* Text */			&xmTextWidgetClass,
  /* TextField */		&xmTextFieldWidgetClass,
  /* ToggleButton */		&xmToggleButtonWidgetClass,
  /* ToggleButtonGadget */	&xmToggleButtonGadgetClass,
  /* TopLevelShell */		&topLevelShellWidgetClass,
  /* TransientShell */		&transientShellWidgetClass,
  /* WMShell */ 		&wmShellWidgetClass
};

static mlval widget_class_table;

static void fix_widget_class_table(const char *name, mlval *root, mlval value)
{
  int i;
  widget_class_table = value;

  for(i=0; i<NR_WIDGET_CLASSES; ++i) {
    MLUPDATE(FIELD(widget_class_table, i), 0, (mlval)*widget_classes[i]);
  }
}

#define mlw_x_arg_bool    MLINT(0)
#define mlw_x_arg_boxed   MLINT(1)
#define mlw_x_arg_int     MLINT(2)
#define mlw_x_arg_short   MLINT(3)
#define mlw_x_arg_string  MLINT(4)
#define mlw_x_arg_unboxed MLINT(5)


/* Argument-value pairs */

static void pairs_to_args(Arg args[], Cardinal *nr_args_return, mlval list)
{
  Cardinal nr_args = 0;

  DIAGNOSTIC(2, "pairs_to_args(args = 0x%X, list = 0x%X)", args, list);

  while(!MLISNIL(list)) {
    mlval head = MLHEAD(list);
    mlval argument = FIELD(head, 1);
    mlval value = MLDEREF(FIELD(argument, 1));

    DIAGNOSTIC(2, "  %3d: %s", nr_args, CSTRING(FIELD(head, 0)));

    args[nr_args].name = CSTRING(FIELD(head, 0));

    switch(FIELD(argument, 0)) {
    case mlw_x_arg_bool:
      args[nr_args].value = (XtArgVal)(value != MLFALSE);
      DIAGNOSTIC(2, "       boolean %d", (int)args[nr_args].value, 0);
      break;

    case mlw_x_arg_boxed:
      if(value != MLUNIT)
	args[nr_args].value = (XtArgVal)unbox(value);
      DIAGNOSTIC(2, "       boxed 0x%lX", (unsigned long int)args[nr_args].value, 0);
      break;

    case mlw_x_arg_int:
      args[nr_args].value = (XtArgVal)CINT(value);
      DIAGNOSTIC(2, "       int %ld", (long int)args[nr_args].value, 0);
      break;

    case mlw_x_arg_short:
      args[nr_args].value = (XtArgVal)CINT(value);
      DIAGNOSTIC(2, "       int %ld", (long int)args[nr_args].value, 0);
      break;

    case mlw_x_arg_string:
      args[nr_args].value = (XtArgVal)CSTRING(value);
      DIAGNOSTIC(2, "       string `%s'", (char *)args[nr_args].value, 0);
      break;

    case mlw_x_arg_unboxed:
      args[nr_args].value = (XtArgVal)value;
      DIAGNOSTIC(2, "       unboxed 0x%lX", (unsigned long int)args[nr_args].value, 0);
      break;

      default:
      error("pairs_to_args: Illegal Argument constructor for resource `%s': 0x%X",
	    CSTRING(FIELD(head, 0)), FIELD(argument, 0));
    }

    ++nr_args;
    list= MLTAIL(list);
  }

  *nr_args_return = nr_args;
}



static void args_to_pairs(Arg args[], mlval list)
{
  Cardinal nr_args = 0;
  mlval ref= MLUNIT;

  declare_root(&list, 0);
  declare_root(&ref, 0);

  while(!MLISNIL(list)) {
    mlval head= MLHEAD(list);
    mlval argument= FIELD(head, 1);

    ref= FIELD(argument, 1);

    switch(FIELD(argument, 0)) {
    case mlw_x_arg_bool:
      /* Need to cast the pointer before dereferencing */
      mlw_ref_update(ref, MLBOOL(*(Boolean *)(&(args[nr_args].value))));
      break;

    case mlw_x_arg_boxed:
      {
	mlval string = box((unsigned long int)args[nr_args].value);
	mlw_ref_update(ref, string);
      }
      break;

    case mlw_x_arg_int:
      /* Need to cast the pointer before dereferencing */
      mlw_ref_update(ref, MLINT(*(int *)(&(args[nr_args].value))));
      break;

    case mlw_x_arg_short:
      /* Need to cast the pointer before dereferencing */
      mlw_ref_update(ref, MLINT(*(short *)(&(args[nr_args].value))));
      break;

    case mlw_x_arg_string:
      {
	mlval str= ml_string((char *)args[nr_args].value);
	mlw_ref_update(ref, str);
      }
      break;

    case mlw_x_arg_unboxed:
      mlw_ref_update(ref, (mlval)args[nr_args].value);
      break;

    default:
      error("args_to_pairs: Illegal Argument constructor for resource `%s': 0x%X",
	    CSTRING(FIELD(head, 0)), FIELD(argument, 0));
    }

    ++nr_args;
    list= MLTAIL(list);
  }

  retract_root(&ref);
  retract_root(&list);
}



/* These could and should produce more informative error messages */
/* and then we could do with some restarts! */
static void Xt_error_handler (String s)
{
  printf ("Xt Error: %s\n",s);
  exn_raise_string(perv_exn_ref_x, s);
}

static int X_error_handler (Display* d,XErrorEvent* e)
{
  char buf[256];

  XGetErrorText (d,e->error_code,buf,256);
  printf ("X Error: %s\n",buf);
  exn_raise_string(perv_exn_ref_x, buf);
  return (0);
}

static Widget applicationShell = NULL;

/* Each call to initialize creates a new application shell.  The first
 * application shell is stored globally, so that main_loop can test for
 * its destruction.  We use one application context for all application
 * shells, so that we can create user windows interactively from the Motif
 * environment.
 */

#include "mlworks.xbm"

static XtAppContext applicationContext;

static mlval initialize(mlval argument)
{
  /* These static values record whether we have initialized the X toolkit and
     connection to the display. */
  static int toolkit_initialized = 0;
  static Display *display = NULL;

  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget w;

  pairs_to_args(args, &nr_args, FIELD(argument, 2));

  if(!toolkit_initialized)
  {
    DIAGNOSTIC(2, "initializing toolkit", 0, 0);
    XtToolkitInitialize();
    toolkit_initialized = 1;
  }

  if (display == NULL) {
    Cardinal argc = 3;
    const char *argv[argc + 1];

    applicationContext = XtCreateApplicationContext();

    argv[0] = "mlworks";
    argv[1] = "-xrm";
    argv[2] = mono ? "*customization: -mono" : "*customization: -color";
    argv[argc] = NULL;
    display = XtOpenDisplay(applicationContext, (char *) "",
			    CSTRING(FIELD(argument, 0)),
			    CSTRING(FIELD(argument, 1)),
			    NULL, 0, &argc, (char **) argv);
    if(display == NULL)
      exn_raise_string(perv_exn_ref_x, "check DISPLAY variable and host authorization");

    XtAppSetErrorHandler (applicationContext,Xt_error_handler);
    XSetErrorHandler (X_error_handler);
  }

  DIAGNOSTIC(2, "creating application shell", 0, 0);

  w = XtAppCreateShell(CSTRING(FIELD(argument, 0)),
		       CSTRING(FIELD(argument, 1)),
		       applicationShellWidgetClass,
		       display, args, nr_args);

  if (applicationShell == NULL) {
    applicationShell = w;
  }

  window_update_interval = 1000;	/* handle expose events once per sec */
  signal_window_updates_start();

  return (mlval)w;
}

static mlval mlw_check_resources (mlval unit)
{
  int value;
  char* name = (char *)"mlworksTestResource";
  char* type = (char *)"MlworksTestResource";

  XtResource resources [] =
    {{name,type,XtRInt, sizeof (int),0,XtRImmediate,(XtPointer)0}};
  XtGetApplicationResources (applicationShell,&value,resources,1,NULL,0);

  if (value == 27) {
    /* Other MLWorks-specific initialisation */ 

    Arg args[1];

    /* Set the icon "by hand", because Linux/Motif 2.0 complains that
       it can't convert a filename in the resource file to a pixmap. */
    Display* display = XtDisplay((Widget)applicationShell);
    Screen* screen = XtScreen (applicationShell);

    Pixmap icon_pixmap =
      XCreateBitmapFromData (display, RootWindowOfScreen (screen),
			     mlworks_bits, mlworks_width, mlworks_height);
    XtVaSetValues (applicationShell, XmNiconPixmap, icon_pixmap, NULL);

    /* Set deleteResponse to DO_NOTHING.  We can't let people exit while
       they're in a nested event loop. */
    /* This code is probably redundant now -- daveb, 9/5/97 */
    args[0].name = (char *)"deleteResponse";
    args[0].value = (XtArgVal)XmDO_NOTHING;
    XtSetValues (applicationShell, args, 1);
  }
  else
    exn_raise_string (perv_exn_ref_x, 
		      "Can't find resources: check XUSERFILESEARCHPATH"
                      " or your installation");

  return MLUNIT;

}


static int quit_on_exit_flag = 0;

static mlval quit_on_exit (mlval argument)
{
  quit_on_exit_flag = 1;
  return (MLUNIT);
}


/* The main_loop function extracts the application context from the stored
 * application shell.  It uses a flag to indicate whether it is still a
 * valid source of input.  The main_loop and do_input functions communicate
 * via this flag.  Calls to main_loop when one is already running are ignored.
 */
static int mainLoopContinue = 0;

int awaiting_x_event = 0;

/* Record the time of the last key or button event */
Time current_server_time = 0;

static void set_current_server_time (XEvent *event)
{
  if (event->type == ButtonPress || event->type == ButtonRelease ||
      event->type == KeyPress || event->type == KeyRelease)
    current_server_time = event->xbutton.time;
}

static mlval main_loop(mlval argument)
{
  Display *display;
  Window window;
  XtAppContext app_context;

  if (applicationShell == NULL)
    c_raise(argument);

/* Removed for the moment, else exit from a top level debugger doesn't work */
/*
  if (mainLoopContinue)
    return(MLUNIT);
  else
*/
    mainLoopContinue = 1;

  window = XtWindow((Widget)applicationShell);
  display = XtDisplay((Widget)applicationShell);
  app_context = XtDisplayToApplicationContext (display);

/* 
  This next line buggers up menu bar behaviour in the podium.

  The original reason for this line was to ensure that destroy_notify
  events are sent to the event handler.  This doesn't seem to cause a
  problem now, but if this is necessary, then we should probably add a
  destroy notify event handler.
*/

/*  
  XSelectInput(display, window, StructureNotifyMask); 
*/

  DIAGNOSTIC(2, "shell window is %ld", window, 0);
  while (mainLoopContinue) {
    XEvent event;

    /* not sure if can take thread_preemption_on out of the loop;
     * leaving it in for safety's sake.  Not time critical code anyway.
     */
    while (thread_preemption_on 
	   && !thread_in_critical_section
	   && (thread_preemption_pending
	       || (runnable_threads > 2 
		   &&  !XtAppPending(app_context))))
      thread_yield(MLUNIT);

    awaiting_x_event = 1;
    XtAppNextEvent(app_context, &event);
    set_current_server_time (&event);
    XtDispatchEvent(&event);
    awaiting_x_event = 0;
    if (event.type == DestroyNotify) {
      DIAGNOSTIC(2, "destroy notify: window = %ld", event.xdestroywindow.window, 0);
	if (event.xdestroywindow.window == window) {
          DIAGNOSTIC(2, "breaking out of main loop", 0, 0);
	  mainLoopContinue = 0;
          break;
	}
    }
  }
  signal_window_updates_stop();
  if (quit_on_exit_flag) {
    exit (0);
  }
  applicationShell = NULL;
  return(MLUNIT);
}

static mlval do_input (mlval argument)
{
  XEvent event;
  Window window;
  XtAppContext app_context;

  if (applicationShell == NULL)
    c_raise(argument);

  /* This code prevented us from running the license dialog and splash screen.
  if (mainLoopContinue == 0)
    return(MLFALSE);
  */

  window = XtWindow(applicationShell);
  app_context =
    XtDisplayToApplicationContext (XtDisplay (applicationShell));

    /* not sure if can take thread_preemption_on out of the loop;
     * leaving it in for safety's sake.  Not time critical code anyway.
     */
  while (thread_preemption_on
	 && !thread_in_critical_section
	 && (thread_preemption_pending
	     || (runnable_threads > 2 
		 &&  !XtAppPending(app_context))))
    thread_yield(MLUNIT);

  awaiting_x_event = 1;
  XtAppNextEvent(app_context, &event);
  XtDispatchEvent(&event);
  awaiting_x_event = 0;
  if (event.type == DestroyNotify) 
    {
      DIAGNOSTIC(2, "destroy notify: window = %d", event.xdestroywindow.window, 0);
      if (event.xdestroywindow.window == window)
	{
	  DIAGNOSTIC(2, "breaking out of sub loop", 0, 0);
	  mainLoopContinue = 0;
	  return(MLFALSE);
	}
      else
	return (MLTRUE);
    }
  else
    return(MLTRUE);
}

/* This is going to be an interrupt button id */

static Window interrupt_window = 0;

static mlval set_interrupt_window (mlval arg)
{
  interrupt_window = XtWindow((Widget)arg);
  return (MLUNIT);
}

/* This function grabs any expose events off the queue and dispatches
 * them. If it is called fairly often, this prevents the 'windows do
 * not refresh while ML is busy' unpleasant behaviour. Maybe this will
 * go away when we move to a fully threaded event loop. 
 * 
 * Changes to record_event() should be done in synch with
 * <URI:rts/src/signals.c#signal_interrupt_handler>
 */
extern void x_handle_expose_events(void)
{
  Display *display;
  XEvent event;
  int interrupt = FALSE;

  if (applicationShell == NULL)
    return;

  display = XtDisplay((Widget)applicationShell);

  while(XCheckMaskEvent(display, ExposureMask, &event))
    XtDispatchEvent(&event);

  if (interrupt_window){
    while(XCheckWindowEvent(display,interrupt_window,ButtonPressMask, &event)){
      interrupt = TRUE;
      XtDispatchEvent(&event);
    }
    while(XCheckWindowEvent(display,interrupt_window,ButtonReleaseMask, &event)){
      interrupt = TRUE;
      XtDispatchEvent(&event);
    }
    if (interrupt)
      record_event(EV_INTERRUPT, (word)SIGINT); /* see comment above */
  }
}

/* Called when we send a message to the podium which must get seen */
extern void x_reveal_podium(void)
{
}

/* Called when we reacquire a network license and no longer want the podium on view */
extern void x_hide_podium(void)
{
}

static Widget message_widget;
static XmTextPosition message_widget_position;

static void message_widget_output(const char *message)
{
  XmTextInsert(message_widget,
	       message_widget_position,
	       (char *)message);
  message_widget_position += strlen(message);
  XmTextShowPosition(message_widget, message_widget_position);
}

static void message_widget_flush(void)
{
  XFlush (XtDisplay((Widget)applicationShell));
}

static mlval text_setmessagewidget (mlval arg)
{
  message_widget = (Widget)arg;
  message_widget_position = 0;

  messager_function = message_widget_output;
  message_flusher = message_widget_flush;
  return (MLUNIT);
}

static mlval text_nomessagewidget (mlval unit)
{
  messager_function = NULL;
  return (MLUNIT);
}


static mlval ml_handle_expose_events(mlval argument)
{
  x_handle_expose_events();
  return MLUNIT;
}

/* X library functions */

static mlval sync_graphics_exposures (mlval arg)
{
  Display *display;
  XEvent event;
  int terminated = FALSE;

  if (applicationShell == NULL)
    return (MLUNIT);

  display = XtDisplay((Widget)applicationShell);

  while(!terminated)
  {
    XMaskEvent(display, ExposureMask, &event);
    if (event.type == NoExpose)
      terminated = TRUE;
    if ((event.type == GraphicsExpose) && (event.xgraphicsexpose.count == 0))
      terminated = TRUE;
    XtDispatchEvent(&event);
  }
  return (MLUNIT);
}

static mlval bell (mlval arg)
{
  XBell ((Display *)FIELD(arg, 0),CINT(FIELD(arg,1)));
  return (MLUNIT);
}

static mlval query_pointer (mlval arg)
{
  Display *display = (Display *)FIELD (arg,0);
  Window w = (Window) CINT (FIELD (arg,1));
  Window root, child;
  int root_x,root_y,win_x,win_y;
  unsigned int mask;
  mlval result;

  XQueryPointer (display,w,&root,&child,&root_x,&root_y,&win_x,&win_y,&mask);
  result = allocate_record (6);

  FIELD (result,0) = MLINT (root);
  FIELD (result,1) = MLINT (child);
  FIELD (result,2) = MLINT (root_x);
  FIELD (result,3) = MLINT (root_y);
  FIELD (result,4) = MLINT (win_x);
  FIELD (result,5) = MLINT (win_y);

  return (result);
}

static mlval default_depth(mlval arg)
{
  Display *display = (Display *)FIELD(arg, 0);
  Screen *screen = (Screen *)FIELD(arg, 1);
  int screen_num, depth;

  screen_num = XScreenNumberOfScreen(screen);
  depth = DefaultDepth(display, screen_num);

  return MLINT(depth);
}

static mlval default_visual(mlval arg)
{
  Display *display = (Display *)FIELD(arg, 0);
  Screen *screen = (Screen *)FIELD(arg, 1);
  Visual *default_visual;
  int screen_num;
  mlval r, g, b, ml_visual;

  screen_num = XScreenNumberOfScreen(screen);

  default_visual = DefaultVisual(display, screen_num);

  r = box(default_visual->red_mask);
  declare_root(&r, 0);
  g = box(default_visual->green_mask);
  declare_root(&g, 0);
  b = box(default_visual->blue_mask);
  declare_root(&b, 0);

  ml_visual = allocate_record(5);
  FIELD(ml_visual, 0) = MLINT(default_visual->class);
  FIELD(ml_visual, 1) = r;
  FIELD(ml_visual, 2) = g;
  FIELD(ml_visual, 3) = b;
  FIELD(ml_visual, 4) = MLINT(default_visual->bits_per_rgb);

  retract_root(&r);
  retract_root(&g);
  retract_root(&b);

  return(ml_visual);

}

/* foo */

/* Motif library functions */

/* Widget creation functions */
/* Apart from treatment of argument lists, not too dissimilar to the C functions */    

static mlval widget_create(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget widget;

  DIAGNOSTIC(2, "widget_create(\"%s\", ...)", CSTRING(FIELD(argument, 0)), 0);

  pairs_to_args(args, &nr_args, FIELD(argument, 3));

  widget = XtCreateWidget(CSTRING(FIELD(argument, 0)),
			  (WidgetClass)DEREF(FIELD(argument, 1)),
			  (Widget)FIELD(argument, 2),
			  args, nr_args);

  DIAGNOSTIC(2, "  widget = 0x%X", widget, 0);

  return((mlval)widget);
}

static mlval widget_create_menubar(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget widget;

  DIAGNOSTIC(2, "widget_create_menubar(\"%s\", ...)", CSTRING(FIELD(argument, 0)), 0);

  pairs_to_args(args, &nr_args, FIELD(argument, 2));

  widget = XmCreateMenuBar((Widget)FIELD(argument, 0),
			   CSTRING(FIELD(argument, 1)),
			   args, nr_args);

  DIAGNOSTIC(2, "  widget = 0x%X", widget, 0);

  return((mlval)widget);
}

static mlval widget_create_popupshell(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget widget;

  DIAGNOSTIC(2, "widget_create_popupshell(\"%s\", ...)", CSTRING(FIELD(argument, 0)), 0);

  pairs_to_args(args, &nr_args, FIELD(argument, 3));

  widget = XtCreatePopupShell(CSTRING(FIELD(argument, 0)),
			      (WidgetClass)DEREF(FIELD(argument, 1)),
			      (Widget)FIELD(argument, 2),
			      args, nr_args);

  DIAGNOSTIC(2, "  widget = 0x%X", widget, 0);

  return((mlval)widget);
}

static mlval widget_create_pulldownmenu(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget widget;

  DIAGNOSTIC(2, "widget_create_pulldownmenu(\"%s\", ...)", CSTRING(FIELD(argument, 1)), 0);

  pairs_to_args(args, &nr_args, FIELD(argument, 2));

  widget = XmCreatePulldownMenu((Widget)FIELD(argument, 0),
			        CSTRING(FIELD(argument, 1)),
			        args, nr_args);

  DIAGNOSTIC(2, "  widget = 0x%X", widget, 0);

  return((mlval)widget);
}

static mlval widget_create_scrolledtext(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;
  Widget widget;

  DIAGNOSTIC(2, "widget_create_scrolledtext(\"%s\", ...)", CSTRING(FIELD(argument, 1)), 0);

  pairs_to_args(args, &nr_args, FIELD(argument, 2));

  widget = XmCreateScrolledText((Widget)FIELD(argument, 0),
			        CSTRING(FIELD(argument, 1)),
			        args, nr_args);

  DIAGNOSTIC(2, "  widget = 0x%X", widget, 0);

  return((mlval)widget);
}

/* Widget functions */

static mlval widget_popup (mlval argument)
{
  Widget w = (Widget)FIELD(argument, 0);
  int i = CINT(FIELD(argument, 1));
  XtPopup(w, i);
  return (MLUNIT);
}

static mlval widget_destroy(mlval widget)
{
  XtDestroyWidget((Widget)widget);
  return(MLUNIT);
}

static mlval widget_realize(mlval widget)
{
  XtRealizeWidget((Widget)widget);
  return(MLUNIT);
}

static mlval widget_unrealize(mlval widget)
{
  XtUnrealizeWidget((Widget)widget);
  return(MLUNIT);
}

static mlval widget_is_realized (mlval widget)
{
  return (MLBOOL (XtIsRealized ((Widget)widget)));
}

static mlval widget_manage(mlval widget)
{
  XtManageChild((Widget)widget);
  return(MLUNIT);
}

static mlval widget_unmanage_child (mlval widget)
{
  XtUnmanageChild((Widget)widget);
  return(MLUNIT);
}

static mlval widget_map(mlval widget)
{
  XtMapWidget((Widget)widget);
  return(MLUNIT);
}

static mlval widget_unmap(mlval widget)
{
  XtUnmapWidget((Widget)widget);
  return(MLUNIT);
}

static mlval set_backing(mlval arg)
{
  Widget widget = (Widget)FIELD(arg, 0);
  int store = CINT(FIELD(arg, 1));
  long bitPlanes = (long)unbox(FIELD(arg, 2));
  long pixelValue = (long)unbox(FIELD(arg, 3));
  Display *display;
  Window window;
  unsigned long valuemask;
  XSetWindowAttributes setwinattr;

  if (!XtIsRealized(widget)) 
    return MLUNIT;

  window = XtWindow(widget);
  display = XtDisplay(widget);

  valuemask = CWBackingStore | CWBackingPlanes | CWBackingPixel;
  setwinattr.backing_store = store;
  setwinattr.backing_planes = bitPlanes;
  setwinattr.backing_pixel = pixelValue;

  XChangeWindowAttributes(display, window, valuemask, &setwinattr);

  return MLUNIT;
}

static mlval set_save_under(mlval arg)
{
  Widget widget = (Widget)FIELD(arg, 0);
  Boolean value = CBOOL(FIELD(arg, 1));
  Display *display;
  Window window;
  unsigned long valuemask;
  XSetWindowAttributes setwinattr;

  if (!XtIsRealized(widget)) 
    return MLUNIT;

  window = XtWindow(widget);
  display = XtDisplay(widget);

  valuemask = CWSaveUnder;
  setwinattr.save_under = value;
  XChangeWindowAttributes(display, window, valuemask, &setwinattr);

  return MLUNIT;
}

/* Set and get values */  
static mlval widget_values_set(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args;

  pairs_to_args(args, &nr_args, FIELD(argument, 1));
  XtSetValues((Widget)FIELD(argument, 0), args, nr_args);

  return(MLUNIT);
}

static mlval widget_values_get(mlval argument)
{
  Arg args[MAX_NR_ARGS];
  Cardinal nr_args, i;
  mlval list = FIELD(argument, 1);

  pairs_to_args(args, &nr_args, list);
  for(i=0; i<nr_args; ++i) {
    XtArgVal tmp = (XtArgVal)XtMalloc(sizeof (XtArgVal));
    if (tmp == 0)
      error("widget_values_get: malloc failed", 0, 0);
    else
      args[i].value = tmp;
  }
  XtGetValues((Widget)FIELD(argument, 0), args, nr_args);
  for(i=0; i<nr_args; ++i) {
    XtArgVal *tmp = (XtArgVal*)args[i].value;
    args[i].value = *tmp;
    XtFree ((char*)tmp);
  }
  args_to_pairs(args, list);

  return(MLUNIT);
}  

static mlval widget_display(mlval widget)
{
  return((mlval)XtDisplay((Widget)widget));
}

static mlval widget_screen(mlval widget)
{
  return((mlval)XtScreen((Widget)widget));
}

static mlval widget_window(mlval widget)
{
  return(MLINT(XtWindow((Widget)widget)));
}

static mlval widget_name(mlval widget)
{
  return(ml_string(XtName((Widget)widget)));
}

static mlval widget_parent(mlval widget)
{
  DIAGNOSTIC(2, "parent of 0x%X is 0x%X", widget, XtParent((Widget)widget));
  return((mlval)XtParent((Widget)widget));
}

/* This is Motif rather than Xt */
static mlval process_traversal(mlval argument)
{
  Widget w = (Widget)FIELD(argument, 0);
  int i = CINT(FIELD(argument, 1));
  return (MLBOOL (XmProcessTraversal(w, i)));
}

/* Various specialized functions */
/* Bring a window to the front */

static mlval window_to_front (mlval widget)
{
  XWindowChanges changes;
  changes.stack_mode=Above;
  /* If not mapped, map.  This deiconises the window, if necessary. */
  XtMapWidget((Widget)widget);
  XReconfigureWMWindow(XtDisplay((Widget)widget),
		       XtWindow((Widget)widget),
		       XScreenNumberOfScreen(XtScreen((Widget)widget)),
		       (unsigned int) CWStackMode,
		       &changes);
  return(MLUNIT);
  }

/* This, of course, should be done on the ML side of things */
/* Reuse same watch cursor -- the display should be the same each time
   window interface is run */
static Cursor watch = (Cursor) NULL;

static mlval widget_set_busy (mlval widget)
{
  Widget w = (Widget)widget;
  if (!watch) watch = XCreateFontCursor(XtDisplay(w),XC_watch);
  XDefineCursor(XtDisplay(w),XtWindow(w),watch);
  XmUpdateDisplay(w);
  return (MLUNIT);
}

static mlval widget_unset_busy (mlval widget)
{
  Widget w = (Widget)widget;
  XUndefineCursor(XtDisplay(w),XtWindow(w));
  XmUpdateDisplay(w);
  return(MLUNIT);
}

/* Motif text functions */

static mlval text_setstring(mlval argument)
{
  XmTextSetString((Widget)FIELD(argument, 0),
		  CSTRING(FIELD(argument, 1)));
  return MLUNIT;
}

static mlval text_sethighlight(mlval argument)
{
  XmTextSetHighlight((Widget)FIELD(argument, 0),
		     CINT(FIELD(argument, 1)),
		     CINT(FIELD(argument, 2)),
		     CINT(FIELD(argument, 3)));
  return MLUNIT;
}

static mlval text_insert(mlval argument)
{
  XmTextInsert((Widget)FIELD(argument, 0),
	       CINT(FIELD(argument, 1)),
	       CSTRING(FIELD(argument, 2)));
  return MLUNIT;
}

static mlval text_replace(mlval argument)
{
  XmTextReplace((Widget)FIELD(argument, 0),
		CINT(FIELD(argument, 1)),
		CINT(FIELD(argument, 2)),
		CSTRING(FIELD(argument, 3)));
  return MLUNIT;
}

static mlval text_getstring(mlval widget)
{
  char *tmp = XmTextGetString((Widget)widget);
  mlval str = ml_string(tmp);

  XtFree(tmp);
  return str;
}

static mlval text_get_top_character(mlval widget)
{
  return (MLINT (XmTextGetTopCharacter((Widget)widget)));
}

static mlval text_getlastposition(mlval widget)
{
  return (mlval)MLINT(XmTextGetLastPosition((Widget)widget));
}

static mlval text_getinsertionposition(mlval widget)
{
  return (mlval)MLINT(XmTextGetInsertionPosition((Widget)widget));
}

static mlval text_set_add_mode (mlval arg)
{
  XmTextSetAddMode((Widget)FIELD(arg, 0),
		   CBOOL(FIELD(arg, 1)));
  return MLUNIT;
}

static mlval text_set_editable (mlval arg)
{
  XmTextSetEditable((Widget)FIELD(arg, 0),
		    CBOOL(FIELD(arg, 1)));
  return MLUNIT;
}

static mlval text_setinsertionposition(mlval arg)
{
  XmTextSetInsertionPosition((Widget)FIELD(arg, 0),
			     CINT(FIELD(arg, 1)));
  return MLUNIT;
}

static mlval text_set_max_length (mlval arg)
{
  XmTextSetMaxLength((Widget)FIELD(arg, 0),
		     CINT(FIELD(arg, 1)));
  return MLUNIT;
}

static mlval text_getselection (mlval widget)
{
  char *tmp = XmTextGetSelection((Widget)widget);
  mlval str = ml_string(tmp);

  XtFree(tmp);
  return str;
}

static mlval text_setselection (mlval arg)
{
  Widget widget = (Widget)FIELD(arg,0);
  int from = CINT (FIELD (arg,1));
  int to = CINT (FIELD (arg,2));
  XmTextSetSelection (widget,from,to,current_server_time);
  return (MLUNIT);
}

static mlval text_remove (mlval widget)
{
  XmTextRemove ((Widget) widget);
  return MLUNIT;
}

static mlval text_get_baseline (mlval arg)
{
  return (MLINT (XmTextGetBaseline ((Widget)arg)));
}

static mlval text_get_editable (mlval arg)
{
  return (MLBOOL (XmTextGetEditable ((Widget)arg)));
}

static mlval text_get_max_length (mlval arg)
{
  return (MLINT (XmTextGetMaxLength ((Widget)arg)));
}

static mlval text_get_selection_position (mlval arg)
{
  XmTextPosition left,right;
  mlval result;
  XmTextGetSelectionPosition ((Widget)arg,&left,&right);
  result = allocate_record (2);
  FIELD (result,0) = left;
  FIELD (result,1) = right;
  return (result);
}

static mlval text_clear_selection (mlval arg)
{
  Widget text = (Widget)arg;
  XmTextClearSelection (text,current_server_time);
  return (MLUNIT);
}

static mlval text_copy_selection (mlval arg)
{
  Widget text = (Widget)arg;
  XmTextCopy (text,current_server_time);
  return (MLUNIT);
}

static mlval text_cut_selection (mlval arg)
{
  Widget text = (Widget)arg;
  XmTextCut (text,current_server_time);
  return (MLUNIT);
}

static mlval text_paste_selection (mlval arg)
{
  Widget text = (Widget)arg;
  XmTextPaste (text);
  return (MLUNIT);
}

static mlval text_scroll(mlval argument)
{
  XmTextScroll((Widget)FIELD(argument, 0),
	       CINT(FIELD(argument, 1)));
  return MLUNIT;
}

static mlval text_settopcharacter(mlval argument)
{
  XmTextSetTopCharacter((Widget)FIELD(argument, 0),
			CINT(FIELD(argument, 1)));
  return MLUNIT;
}

static mlval text_showposition(mlval argument)
{
  XmTextShowPosition((Widget)FIELD(argument, 0),
		     CINT(FIELD(argument, 1)));
  return MLUNIT;
}

static mlval text_xytopos (mlval argument)
{
  return (MLINT (XmTextXYToPos((Widget)FIELD(argument, 0),
			       CINT(FIELD(argument, 1)),
			       CINT(FIELD(argument, 2)))));
}



static mlval text_postoxy (mlval arg)
{
  Widget w= (Widget)FIELD(arg, 0);
  int pos= CINT(FIELD(arg, 1));
  mlval result= allocate_record(2);
  Position x;
  Position y;

  if (XmTextPosToXY(w, pos, &x,&y)) {
    FIELD(result, 0)= MLINT (x);
    FIELD(result, 1)= MLINT (y);
  } else {
    FIELD(result, 0)= MLINT (-1);
    FIELD(result, 1)= MLINT (-1);
  }

  return result;
}



/* Cascade buttons */
static mlval cascade_button_highlight (mlval arg)
{
  XmCascadeButtonHighlight ((Widget)FIELD (arg,0),
			    CBOOL (FIELD (arg,1)));
  return (MLUNIT);
}

static mlval cascade_button_gadget_highlight (mlval arg)
{
  XmCascadeButtonGadgetHighlight ((Widget)FIELD (arg,0),
				  CBOOL (FIELD (arg,1)));
  return (MLUNIT);
}


/* Toggle buttons */
static mlval toggle_button_get_state (mlval arg)
{
  return (MLBOOL (XmToggleButtonGetState ((Widget)arg)));
}

static mlval toggle_button_set_state (mlval arg)
{
  XmToggleButtonSetState ((Widget)FIELD (arg,0),
			  CBOOL (FIELD (arg,1)),
			  CBOOL (FIELD (arg,2)));
  return (MLUNIT);
}

static mlval toggle_button_gadget_get_state (mlval arg)
{
  return (MLBOOL (XmToggleButtonGadgetGetState ((Widget)arg)));
}

static mlval toggle_button_gadget_set_state (mlval arg)

{
  XmToggleButtonGadgetSetState ((Widget)FIELD (arg,0),
				CBOOL (FIELD (arg,1)),
				CBOOL (FIELD (arg,2)));
  return (MLUNIT);
}

/* Motif List Widgets */

static mlval list_add_item (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  XmString item = (XmString)FIELD (arg,1);
  int pos = CINT (FIELD (arg,2));
  XmListAddItem (widget,item,pos);
  return (MLUNIT);
}

static mlval list_add_item_unselected (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  XmString item = (XmString)FIELD (arg,1);
  int pos = CINT (FIELD (arg,2));
  XmListAddItemUnselected (widget,item,pos);
  return (MLUNIT);
}

static mlval list_add_items (mlval arg)
{
  size_t length;
  XmString *items;
  mlval list;

  length = 0;
  for(list=FIELD(arg, 1); list!=MLNIL; list=MLTAIL(list))
    ++length;

  items = alloc(length * sizeof(XmString), "list_add_items");

  length = 0;
  for(list=FIELD(arg, 1); list!=MLNIL; list=MLTAIL(list))
    items[length++] = (XmString)MLHEAD(list);

  XmListAddItems((Widget)FIELD(arg, 0),
		 items, (signed int) length,
		 CINT(FIELD(arg, 2)));

  free(items);

  return(MLUNIT);
}

static mlval list_delete_all_items(mlval arg)
{
  XmListDeleteAllItems((Widget)arg);
  return(MLUNIT);
}

static mlval list_delete_item (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  XmString item = (XmString)FIELD (arg,1);
  XmListDeleteItem (widget,item);
  return (MLUNIT);
}

static mlval list_delete_items (mlval arg)
{
  size_t length;
  XmString *items;
  mlval list;

  length = 0;
  for(list=FIELD(arg, 1); list!=MLNIL; list=MLTAIL(list))
    ++length;

  items = alloc(length * sizeof(XmString), "list_delete_items");

  length = 0;
  for(list=FIELD(arg, 1); list!=MLNIL; list=MLTAIL(list))
    items[length++] = (XmString)MLHEAD(list);

  XmListDeleteItems((Widget)FIELD(arg, 0),
		    items, (signed int) length);

  free(items);

  return(MLUNIT);
}

static mlval list_delete_items_pos (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  int count = CINT (FIELD (arg,1));
  int pos = CINT (FIELD (arg,2));
  
  XmListDeleteItemsPos (widget,count,pos);
  return (MLUNIT);
}


static mlval list_delete_pos (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  int pos = CINT (FIELD (arg,1));
  
  XmListDeletePos (widget,pos);
  return (MLUNIT);
}

static mlval list_select_pos(mlval arg)
{
  XmListSelectPos((Widget)FIELD(arg, 0),
		  CINT(FIELD(arg, 1)),
		  CBOOL (FIELD(arg, 2)));
  return(MLUNIT);
}



static mlval list_get_selected_pos (mlval arg)
{
  int *items,count,i;
  if (XmListGetSelectedPos((Widget)arg,&items,&count)) {
    mlval result= allocate_vector((size_t) count);
    for(i=0;i<count;i++)
      FIELD(result, i) = MLINT(items[i]);
    XtFree((char*)items);
    return (result);
  } else {
    return (allocate_vector(0));
  }
}



static mlval list_set_bottom_pos (mlval arg)
{
  Widget w = (Widget)(FIELD (arg, 0));
  int i = CINT (FIELD (arg, 1));

  XmListSetBottomPos (w, i);

  return (MLUNIT);
}

static mlval list_set_pos (mlval arg)
{
  Widget w = (Widget)(FIELD (arg, 0));
  int i = CINT (FIELD (arg, 1));

  XmListSetPos (w, i);

  return (MLUNIT);
}

/* Scales */
static mlval scale_get_value (mlval arg)
{
  Widget w = (Widget)arg;
  int value;
  XmScaleGetValue (w,&value);

  return (MLINT (value));
}

static mlval scale_set_value (mlval arg)
{
  XmScaleSetValue ((Widget)FIELD (arg,0),
		   CINT (FIELD (arg,1)));
  return (MLUNIT);
}

/* Scrollbars */
static mlval scrollbar_get_values (mlval arg)
{
  Widget w = (Widget)arg;
  int value;
  int slider_size;
  int increment;
  int page_increment;
  mlval result;

  XmScrollBarGetValues (w,&value,&slider_size,&increment,&page_increment);
  result = allocate_record (4);
  FIELD (result,0) = MLINT (value);
  FIELD (result,1) = MLINT (slider_size);
  FIELD (result,2) = MLINT (increment);
  FIELD (result,3) = MLINT (page_increment);
  return (result);
}

static mlval scrollbar_set_values (mlval arg)
{
  XmScrollBarSetValues ((Widget)FIELD (arg,0),
			CINT (FIELD (arg,1)),
			CINT (FIELD (arg,2)),
			CINT (FIELD (arg,3)),
			CINT (FIELD (arg,4)),
			CBOOL (FIELD (arg,5)));
  return (MLUNIT);
}

/* Scrolled windows */

static mlval scrolled_window_set_areas (mlval arg)
{
  XmScrolledWindowSetAreas ((Widget)FIELD (arg,0),
			    (Widget)FIELD (arg,1),
			    (Widget)FIELD (arg,2),
			    (Widget)FIELD (arg,3));
  return (MLUNIT);
}
  
/* Fonts and fontstructs */

static mlval font_load(mlval argument)
{
  Font font =
    XLoadFont((Display *)FIELD(argument, 0),
	      CSTRING(FIELD(argument, 1)));
  /* printf ("Load font: Font is %x\n",font); */
  return(MLINT (font));
}

static mlval query_font (mlval argument)
{
  Font font = (Font) CINT (FIELD (argument,1));
  /* printf ("Query font: Font is %x\n",font); */
  return ((mlval) XQueryFont ((Display *)FIELD(argument, 0),
			      font));
}

static mlval fontstruct_free(mlval argument)
{
  XFreeFont((Display *)FIELD(argument, 0),
	    (XFontStruct *)FIELD(argument, 1));
  return(MLUNIT);
}

static mlval text_extents (mlval argument)
{
  XFontStruct* fontstruct = (XFontStruct *) FIELD (argument,0);
  mlval mlstring = FIELD (argument,1);
  int len = (int)LENGTH(GETHEADER(mlstring))-1;
  char* string = CSTRING (mlstring);
  XCharStruct charstruct;
  int direction,font_ascent,font_descent;
  mlval result = MLUNIT;
  XTextExtents (fontstruct,string,len,&direction,&font_ascent,&font_descent,&charstruct);
  /* order of fields is ascent,descent,font_ascent,font_descent,lbearing,rbearing,width */
  result = allocate_record(7);
  /* We must do this after the use of string as it points into the ML heap */
  FIELD (result,0) = MLINT (charstruct.ascent);
  FIELD (result,1) = MLINT (charstruct.descent);
  FIELD (result,2) = MLINT (font_ascent);
  FIELD (result,3) = MLINT (font_descent);
  FIELD (result,4) = MLINT (charstruct.lbearing);
  FIELD (result,5) = MLINT (charstruct.rbearing);
  FIELD (result,6) = MLINT (charstruct.width);
  return (result);
}

/* Fonts */

/* Motif fontlists */
static mlval fontlist_create(mlval argument)
{
  return((mlval)XmFontListCreate((XFontStruct *)FIELD(argument, 0),
				 CSTRING(FIELD(argument, 1))));
}

static mlval fontlist_add(mlval argument)
{
  return((mlval)XmFontListAdd((XmFontList)FIELD(argument, 0),
			      (XFontStruct *)FIELD(argument, 1),
			      CSTRING(FIELD(argument, 2))));
}

static mlval fontlist_copy(mlval argument)
{
  return((mlval)XmFontListCopy((XmFontList)argument));
}

static mlval fontlist_free(mlval argument)
{
  XmFontListFree((XmFontList)argument);
  return(MLUNIT);
}

/* Motif Compound Strings */

static mlval string_baseline(mlval argument)
{
  return (MLINT (XmStringBaseline ((XmFontList)FIELD(argument, 0),
				   (XmString)FIELD(argument, 1))));
}

static mlval string_bytecompare(mlval argument)
{
  return(MLBOOL (XmStringByteCompare((XmString)FIELD(argument, 0),
				     (XmString)FIELD(argument, 1))));
}

static mlval string_has_substring (mlval argument)
{
  return(MLBOOL (XmStringHasSubstring((XmString)FIELD(argument, 0),
				      (XmString)FIELD(argument, 1))));
}

static mlval string_compare(mlval argument)
{
  return (MLBOOL (XmStringCompare((XmString)FIELD(argument, 0),
				  (XmString)FIELD(argument, 1))));
}

static mlval string_concat(mlval argument)
{
  return((mlval)XmStringConcat((XmString)FIELD(argument, 0),
			       (XmString)FIELD(argument, 1)));
}

static mlval string_copy(mlval string)
{
  return((mlval)XmStringCopy((XmString)string));
}

static mlval string_create(mlval argument)
{
  return((mlval)XmStringCreate(CSTRING(FIELD(argument, 0)),
			       CSTRING(FIELD(argument, 1))));
}

static mlval string_create_l_to_r(mlval argument)
{
  return((mlval)XmStringCreateLtoR(CSTRING(FIELD(argument, 0)),
				   CSTRING(FIELD(argument, 1))));
}

static mlval string_create_simple(mlval string)
{
  return((mlval)XmStringCreateSimple(CSTRING(string)));
}

static mlval string_segment_create (mlval argument)
{
  return((mlval)XmStringSegmentCreate(CSTRING(FIELD(argument, 0)),
				      CSTRING(FIELD(argument, 1)),
				      CINT(FIELD(argument, 2)),
				      CBOOL(FIELD(argument, 3))));
}

static mlval string_separator_create(mlval unit)
{
  return((mlval)XmStringSeparatorCreate());
}

static mlval string_direction_create(mlval argument)
{
  return((mlval)XmStringDirectionCreate(CINT(argument)));
}

static mlval string_empty(mlval string)
{
  return(MLBOOL (XmStringEmpty((XmString)string)));
}

static mlval string_extent(mlval argument)
{
  Dimension width, height;
  mlval result;

  XmStringExtent((XmFontList)FIELD(argument, 0),
		 (XmString)FIELD(argument, 1),
		 &width, &height);

  result = allocate_record(2);
  FIELD(result, 0) = MLINT(width);
  FIELD(result, 1) = MLINT(height);

  return(result);
}

static mlval string_free(mlval string)
{
  XmStringFree((XmString)string);
  return(MLUNIT);
}

static mlval string_height(mlval argument)
{
  return(MLINT(XmStringHeight((XmFontList)FIELD(argument, 0),
			      (XmString)FIELD(argument, 1))));
}

static mlval string_length(mlval string)
{
  return(MLINT(XmStringLength((XmString)string)));
}

static mlval string_linecount(mlval string)
{
  return(MLINT(XmStringLineCount((XmString)string)));
}

static mlval string_nconcat(mlval argument)
{
  return((mlval)XmStringNConcat((XmString)FIELD(argument, 0),
				(XmString)FIELD(argument, 1),
				CINT(FIELD(argument, 2))));
}

static mlval string_ncopy(mlval argument)
{
  return((mlval)XmStringNCopy((XmString)FIELD(argument, 0),
			      CINT(FIELD(argument, 1))));
}

static mlval string_width(mlval argument)
{
  return(MLINT(XmStringWidth((XmFontList)FIELD(argument, 0),
			     (XmString)FIELD(argument, 1))));
}

/* This is nicked out of my Motif book - MLA */
static mlval string_convert_text (mlval argument)
{
  XmStringContext context;
  char *text;
  XmStringCharSet charset;
  XmStringDirection dir;
  Boolean separator;
  char *buf = NULL;
  int done = FALSE;
  mlval result;

  XmStringInitContext (&context,(XmString)argument);
  while (!done)
    if (XmStringGetNextSegment (context,&text,&charset,&dir,&separator))
      {
	/* Don't know why it does this, seems wrong */
	if (separator)
	  done = TRUE;
	if (buf)
	  {
	    buf = XtRealloc (buf,strlen(buf) + strlen(text) + 2u);
	    strcat(buf,text);
	  }
	else
	  {buf = (char *) XtMalloc(strlen(text) + 1u);
	   strcpy(buf,text);
	 }
	XtFree(text);
      }
    else
      done = TRUE;
  XmStringFreeContext (context);
  result = ml_string(buf);
  XtFree(buf);
  return result;
  }
  
/* Translations (whatever they are !!!!) */
static mlval translations_parse_table(mlval table)
{
  return((mlval)XtParseTranslationTable(CSTRING(table)));
}

static mlval translations_override(mlval argument)
{
  XtOverrideTranslations((Widget)FIELD(argument, 0),
			 (XtTranslations)FIELD(argument, 1));
  return(MLUNIT);
}

static mlval translations_augment(mlval argument)
{
  XtAugmentTranslations((Widget)FIELD(argument, 0),
			(XtTranslations)FIELD(argument, 1));
  return(MLUNIT);
}

static mlval translations_uninstall(mlval widget)
{
  XtUninstallTranslations((Widget)widget);
  return(MLUNIT);
}

/* Miscellaneous */

static mlval is_motif_wm_running (mlval arg)
{
  return (MLBOOL (XmIsMotifWMRunning ((Widget)arg)));
}

static mlval update_display (mlval arg)
{
  XmUpdateDisplay ((Widget)arg);
  return (MLUNIT);
}

/* Atoms */
static mlval atom_intern (mlval arg)
{
  Display *display = (Display *)FIELD (arg,0);
  String name = CSTRING (FIELD (arg,1));
  Boolean b = CBOOL (FIELD (arg,2));
  return (MLINT (XmInternAtom (display,name,b)));
}

static mlval atom_get_name (mlval arg)
{
  Display *display = (Display *)FIELD (arg,0);
  Atom atom = CINT (FIELD (arg,1));
  String s = XmGetAtomName (display,atom);
  mlval result = allocate_string (strlen (s) + 1);
  strcpy (CSTRING (result),(char *) s);
  return (result);
}

/* Tabgroups */
static mlval tabgroup_add (mlval arg)
{
  XmAddTabGroup ((Widget)arg);
  return (MLUNIT);
}

static mlval tabgroup_remove (mlval arg)
{
  XmRemoveTabGroup ((Widget)arg);
  return (MLUNIT);
}

/* Pixmaps */

/* type Pixmap is an int */

static mlval pixmap_create(mlval argument)
{
  return(MLINT (XCreatePixmap((Display *)FIELD(argument, 0),
			      (Drawable) CINT (FIELD(argument, 1)),
			      (unsigned int) CINT(FIELD(argument, 2)),
			      (unsigned int) CINT(FIELD(argument, 3)),
			      (unsigned int) CINT(FIELD(argument, 4)))));
}

static mlval pixmap_free(mlval argument)
{
  XFreePixmap((Display *)FIELD(argument, 0),
	      (Pixmap)CINT(FIELD(argument, 1)));
  return(MLUNIT);
}

static mlval pixmap_get(mlval argument)
{
  Pixmap pixmap;
  Pixel foreground, background;

  foreground = (Pixel)unbox(FIELD(argument, 2));
  background = (Pixel)unbox(FIELD(argument, 3));

  pixmap = XmGetPixmap((Screen *)FIELD(argument, 0),
		       CSTRING(FIELD(argument, 1)),
		       foreground, background);

  if(pixmap == XmUNSPECIFIED_PIXMAP) {
    mlval exn_arg = format_to_ml_string("Couldn't read pixmap from %.2000s",
					CSTRING(FIELD(argument, 1)));
    exn_raise_syserr(exn_arg, 0);
  }
  return (MLINT (pixmap));
}

static mlval pixmap_destroy(mlval argument)
{
  Screen *screen = (Screen *)FIELD (argument,0);
  Pixmap pixmap = (Pixmap)CINT (FIELD (argument,1));
  if (!XmDestroyPixmap (screen, pixmap))
    exn_raise_string (perv_exn_ref_x,
		      "Invalid screen or pixmap in pixmap destroy");
  return (MLUNIT);
}

/* Screens, or maybe pixels */

static mlval pixel_screen_black(mlval screen)
{
  return(box((unsigned long int)BlackPixelOfScreen((Screen *)screen)));
}

static mlval pixel_screen_white(mlval screen)
{
  return(box((unsigned long int)WhitePixelOfScreen((Screen *)screen)));
}

/* File Selection boxes */
static mlval file_selection_do_search (mlval arg)
{
  XmFileSelectionDoSearch ((Widget)FIELD(arg,0), (XmString)(FIELD(arg,1)));
  return MLUNIT;
}

static mlval file_selection_box_get_child (mlval arg)
{
  return ((mlval)XmFileSelectionBoxGetChild ((Widget)FIELD(arg,0),
					     (unsigned)CINT(FIELD(arg,1))));
}

/* Selection box */
static mlval selection_box_get_child (mlval arg)
{
  return ((mlval)XmSelectionBoxGetChild ((Widget)FIELD(arg,0),
					 (unsigned)CINT(FIELD(arg,1))));
}

/* Message box Functions */
/* This is the only one!! */
static mlval message_box_get_child (mlval arg)
{
  return ((mlval)XmMessageBoxGetChild ((Widget)FIELD(arg,0),
				       (unsigned)CINT(FIELD(arg,1))));
}

/* Utils for graphics */
static int ml_list_length (mlval arg)
{
  int len = 0;
  while (arg != MLNIL)
    {
      len ++;
      arg = FIELD (arg,1);
    }
  return (len);
}

/* Xlib GC functions */

static unsigned long set_gc_values (mlval value_array, XGCValues* values)
{
  unsigned long mask = 0;
  mlval val;

  /* Rather long winded setting of the GC values */
  val = (MLSUB (value_array,0));
  if (val) 
    {
      values->function = CINT (FIELD (val,1));
      mask |= GCFunction;
    }
  val = (MLSUB (value_array,1));
  if (val) 
    {
      values->plane_mask = (Pixel) unbox (FIELD (val,1));
      mask |= GCPlaneMask;
    }
  val = (MLSUB (value_array,2));
  if (val) 
    {
      values->foreground = (Pixel) unbox (FIELD (val,1));
      mask |= GCForeground;
    }
  val = (MLSUB (value_array,3));
  if (val) 
    {
      values->background = (Pixel) unbox (FIELD (val,1));
      mask |= GCBackground;
    }
  val = (MLSUB (value_array,4));
  if (val) 
    {
      values->line_width = CINT (FIELD (val,1));
      mask |= GCLineWidth;
    }
  val = (MLSUB (value_array,5));
  if (val) 
    {
      values->line_style = CINT (FIELD (val,1));
      mask |= GCLineStyle;
    }
  val = (MLSUB (value_array,6));
  if (val) 
    {
      values->cap_style = CINT (FIELD (val,1));
      mask |= GCCapStyle;
    }
  val = (MLSUB (value_array,7));
  if (val) 
    {
      values->join_style = CINT (FIELD (val,1));
      mask |= GCJoinStyle;
    }
  val = (MLSUB (value_array,8));
  if (val) 
    {
      values->fill_style = CINT (FIELD (val,1));
      mask |= GCFillStyle;
    }
  val = (MLSUB (value_array,9));
  if (val) 
    {
      values->fill_rule = CINT (FIELD (val,1));
      mask |= GCFillRule;
    }
  val = (MLSUB (value_array,10));
  if (val) 
    {
      values->tile = CINT (FIELD (val,1));
      mask |= GCTile;
    }
  val = (MLSUB (value_array,11));
  if (val) 
    {
      values->stipple = CINT (FIELD (val,1));
      mask |= GCStipple;
    }
  val = (MLSUB (value_array,12));
  if (val) 
    {
      values->ts_x_origin = CINT (FIELD (val,1));
      mask |= GCTileStipXOrigin;
    }
  val = (MLSUB (value_array,13));
  if (val) 
    {
      values->ts_y_origin = CINT (FIELD (val,1));
      mask |= GCTileStipYOrigin;
    }
  val = (MLSUB (value_array,14));
  if (val) 
    {
      values->font = (Font)CINT (FIELD (val,1));
      mask |= GCFont;
    }
  val = (MLSUB (value_array,15));
  if (val) 
    {
      values->subwindow_mode = CINT (FIELD (val,1));
      mask |= GCSubwindowMode;
    }
  val = (MLSUB (value_array,16));
  if (val) 
    {
      values->graphics_exposures = CINT (FIELD (val,1));
      mask |= GCGraphicsExposures;
    }
  val = (MLSUB (value_array,17));
  if (val) 
    {
      values->clip_x_origin = CINT (FIELD (val,1));
      mask |= GCClipXOrigin;
    }
  val = (MLSUB (value_array,18));
  if (val) 
    {
      values->clip_y_origin = CINT (FIELD (val,1));
      mask |= GCClipYOrigin;
    }
  val = (MLSUB (value_array,19));
  if (val) 
    {
      values->clip_mask = CINT (FIELD (val,1));
      mask |= GCClipMask;
    }
  val = (MLSUB (value_array,20));
  if (val) 
    {
      values->dash_offset = CINT (FIELD (val,1));
      mask |= GCDashOffset;
    }
  val = (MLSUB (value_array,21));
  if (val) 
    {
      values->dashes = CINT (FIELD (val,1));
      mask |= GCDashList;
    }
  val = (MLSUB (value_array,22));
  if (val) 
    {
      values->arc_mode = CINT (FIELD (val,1));
      mask |= GCArcMode;
    }
  return (mask);
}
  

static void return_gc_values(unsigned long int mask, mlval value_array, XGCValues* values)
{
  declare_root (&value_array, 0);

  if ((mask & GCFunction) != 0)
    MLUPDATE(value_array, 0,MLINT(values -> function));

  if ((mask & GCPlaneMask) != 0) {
    mlval poo= box((unsigned long int)values -> plane_mask); /* Don't inline */
    MLUPDATE(value_array, 1, poo);
  }

  if ((mask & GCForeground) != 0) {
    mlval poo= box((unsigned long int)values -> foreground); /* Don't inline */
    MLUPDATE(value_array, 2, poo);
  }

  if ((mask & GCBackground) != 0) {
    mlval poo= box((unsigned long int)values -> background); /* Don't inline */
    MLUPDATE(value_array, 3, poo);
  }

  if ((mask & GCLineWidth) != 0)
    MLUPDATE(value_array, 4,MLINT(values -> line_width));

  if ((mask & GCLineStyle) != 0)
    MLUPDATE(value_array, 5,MLINT(values -> line_style));

  if ((mask & GCCapStyle) != 0)
    MLUPDATE(value_array, 6,MLINT(values -> cap_style));

  if ((mask & GCJoinStyle) != 0)
    MLUPDATE(value_array, 7,MLINT(values -> join_style));

  if ((mask & GCFillStyle) != 0) 
    MLUPDATE(value_array, 8,MLINT(values -> fill_style));

  if ((mask & GCFillRule) != 0)
    MLUPDATE(value_array, 9,MLINT(values -> fill_rule));

  if ((mask & GCTile) != 0)
    MLUPDATE(value_array, 10,MLINT(values -> tile));

  if ((mask & GCStipple) != 0)
    MLUPDATE(value_array, 11,MLINT(values -> stipple));

  if ((mask & GCTileStipXOrigin) != 0)
    MLUPDATE(value_array, 12,MLINT(values -> ts_x_origin));

  if ((mask & GCTileStipYOrigin) != 0)
    MLUPDATE(value_array, 13,MLINT(values -> ts_y_origin));

  if ((mask & GCFont) != 0)
    MLUPDATE(value_array, 14,MLINT(values -> font));

  if ((mask & GCSubwindowMode) != 0)
    MLUPDATE(value_array, 15,MLINT(values -> subwindow_mode));

  if ((mask & GCGraphicsExposures) != 0)
    MLUPDATE(value_array, 16,MLINT(values -> graphics_exposures));

  if ((mask & GCClipXOrigin) != 0)
    MLUPDATE(value_array, 17,MLINT(values -> clip_x_origin));

  if ((mask & GCClipYOrigin) != 0)
    MLUPDATE(value_array, 18,MLINT(values -> clip_y_origin));

  if ((mask & GCClipMask) != 0)
    MLUPDATE(value_array, 19,MLINT(values -> clip_mask));

  if ((mask & GCDashOffset) != 0)
    MLUPDATE(value_array, 20,MLINT(values -> dash_offset));

  if ((mask & GCDashList) != 0)
    MLUPDATE(value_array, 21,MLINT(values -> dashes));

  if ((mask & GCArcMode) != 0)
    MLUPDATE(value_array, 22,MLINT(values -> arc_mode));

  retract_root (&value_array);

}



static mlval gc_create (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  mlval value_array = FIELD (arg,2);
  unsigned long mask;
  XGCValues values;
  
  /* need to update the values structure appropriately */
  mask = set_gc_values (value_array,&values);
  return ((mlval)XCreateGC (display,drawable,mask,&values));
}

static mlval gc_change (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  GC gc = (GC) (FIELD (arg,1));
  mlval value_array = FIELD (arg,2);
  unsigned long mask;
  XGCValues values;
  
  /* need to update the values structure appropriately */
  mask = set_gc_values (value_array,&values);
  XChangeGC (display,gc,mask,&values);
  return (MLUNIT);
}

static mlval gc_copy(mlval arg)
{
  Display* display = (Display *)FIELD (arg,0);
  GC src_gc = (GC)(FIELD(arg,1));
  unsigned long mask = CINT(FIELD(arg,2));
  GC dest_gc = (GC)(FIELD(arg,3));
  
  XCopyGC(display,src_gc,mask,dest_gc);
  return MLUNIT;
}

static mlval gc_free (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  GC gc = (GC) (FIELD (arg,1));
  XFreeGC (display,gc);
  return (MLUNIT);
}

static mlval gc_set_clip_rectangles (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  GC gc = (GC) (FIELD (arg,1));
  int xoffset = CINT (FIELD (arg,2));
  int yoffset = CINT (FIELD (arg,3));
  mlval rectlist = FIELD (arg,4);
  int ordering = CINT (FIELD (arg,5));
  int num = ml_list_length (rectlist);
  XRectangle* rects = (XRectangle *) XtMalloc (num * (sizeof (XRectangle)));
  int i = 0;

  while (rectlist != MLNIL)
    {
      mlval car = FIELD (rectlist,0);
      rects[i].x = (short)CINT(FIELD (car,0));
      rects[i].y = (short)CINT(FIELD (car,1));
      rects[i].width = (unsigned short)CINT(FIELD (car,2));
      rects[i].height = (unsigned short)CINT(FIELD (car,3));
      rectlist = FIELD (rectlist,1);
      i++;
    }
  XSetClipRectangles (display,gc,xoffset,yoffset,rects,num,ordering);
  return (MLUNIT);
}

static mlval gc_get_values (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  GC gc = (GC) FIELD (arg,1);
  unsigned long int valuemask = CINT(FIELD(arg,2));
  mlval value_array = FIELD (arg,3);
  XGCValues values;

  declare_root (&value_array, 0);
  XGetGCValues (display,gc,valuemask,&values);
  return_gc_values(valuemask,value_array,&values);
  retract_root (&value_array);

  return (value_array);
}

/* Drawing functions */

/* Maybe we should do this on the ML side */
/* datatype CoordMode = ORIGIN | PREVIOUS */
static int convert_coord_mode (int mode)
{
  return (mode);
}
/* ML datatype Shape = COMPLEX | NONCONVEX | CONVEX */
static int convert_shape (int shape)
{
  return (shape == 0 ? 0 : shape == 1 ? 2 : 3);
}

static mlval draw_point (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XDrawPoint (display,drawable,gc,
	     CINT (FIELD (arg,3)),
	     CINT (FIELD (arg,4)));
  return (MLUNIT);
}

static mlval draw_points (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval pointlist = FIELD (arg,3);
  int num = ml_list_length (pointlist);
  int mode = convert_coord_mode (CINT (FIELD (arg,4)));
  XPoint* points = (XPoint *) XtMalloc (num * (sizeof (XPoint)));
  int i = 0;

  while (pointlist != MLNIL)
    {
      mlval car = FIELD (pointlist,0);
      points[i].x = (short)CINT(FIELD (car,0));
      points[i].y = (short)CINT(FIELD (car,1));
      pointlist = FIELD (pointlist,1);
      i++;
    }

  XDrawPoints (display,drawable,gc,points,num,mode);
  XtFree ((char *) points);
  return (MLUNIT);
}

static mlval draw_line (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XDrawLine (display,drawable,gc,
	     CINT (FIELD (arg,3)),
	     CINT (FIELD (arg,4)),
	     CINT (FIELD (arg,5)),
	     CINT (FIELD (arg,6)));
  return (MLUNIT);
}

static mlval draw_lines (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval pointlist = FIELD (arg,3);
  int num = ml_list_length (pointlist);
  int mode = convert_coord_mode (CINT (FIELD (arg,4)));
  XPoint* points = (XPoint *) XtMalloc (num * (sizeof (XPoint)));
  int i = 0;

  while (pointlist != MLNIL)
    {
      mlval car = FIELD (pointlist,0);
      points[i].x = (short)CINT(FIELD (car,0));
      points[i].y = (short)CINT(FIELD (car,1));
      pointlist = FIELD (pointlist,1);
      i++;
    }

  XDrawLines (display,drawable,gc,points,num,mode);
  XtFree ((char *) points);
  return (MLUNIT);
}

static mlval draw_segments (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval segmentlist = FIELD (arg,3);
  int num = ml_list_length (segmentlist);
  XSegment* segments = (XSegment *) XtMalloc (num * (sizeof (XSegment)));
  int i = 0;

  while (segmentlist != MLNIL)
    {
      mlval car = FIELD (segmentlist,0);
      segments[i].x1 = (short)CINT(FIELD (car,0));
      segments[i].y1 = (short)CINT(FIELD (car,1));
      segments[i].x1 = (short)CINT(FIELD (car,2));
      segments[i].y2 = (short)CINT(FIELD (car,3));
      segmentlist = FIELD (segmentlist,1);
      i++;
    }

  XDrawSegments (display,drawable,gc,segments,num);
  XtFree ((char *) segments);
  return (MLUNIT);
}

static mlval fill_polygon (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval pointlist = FIELD (arg,3);
  int num = ml_list_length (pointlist);
  int shape = convert_shape (CINT (FIELD (arg,4)));
  int mode = convert_coord_mode (CINT (FIELD (arg,5)));
  XPoint* points = (XPoint *) XtMalloc (num * (sizeof (XPoint)));
  int i = 0;

  while (pointlist != MLNIL)
    {
      mlval car = FIELD (pointlist,0);
      points[i].x = (short)CINT(FIELD (car,0));
      points[i].y = (short)CINT(FIELD (car,1));
      pointlist = FIELD (pointlist,1);
      i++;
    }

  XFillPolygon (display,drawable,gc,points,num,shape,mode);
  XtFree ((char *) points);
  return (MLUNIT);
}

/* Need also: draw_text */
static mlval draw_rectangle (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XDrawRectangle (display,drawable,gc,
		  CINT (FIELD (arg,3)),
		  CINT (FIELD (arg,4)),
		  (unsigned int)CINT (FIELD (arg,5)),
		  (unsigned int)CINT (FIELD (arg,6)));
  return (MLUNIT);
}

static mlval fill_rectangle (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XFillRectangle (display,drawable,gc,
		  CINT (FIELD (arg,3)),
		  CINT (FIELD (arg,4)),
		  (unsigned int)CINT (FIELD (arg,5)),
		  (unsigned int)CINT (FIELD (arg,6)));
  return (MLUNIT);
}

static mlval draw_rectangles (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval rectlist = FIELD (arg,3);
  int num = ml_list_length (rectlist);
  XRectangle* rects = (XRectangle *) XtMalloc (num * (sizeof (XRectangle)));
  int i = 0;

  while (rectlist != MLNIL)
    {
      mlval car = FIELD (rectlist,0);
      rects[i].x = (short)CINT(FIELD (car,0));
      rects[i].y = (short)CINT(FIELD (car,1));
      rects[i].width = (unsigned short)CINT(FIELD (car,2));
      rects[i].height = (unsigned short)CINT(FIELD (car,3));
      rectlist = FIELD (rectlist,1);
      i++;
    }

  XDrawRectangles (display,drawable,gc,rects,num);
  XtFree ((char *) rects);
  return (MLUNIT);
}

static mlval fill_rectangles (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval rectlist = FIELD (arg,3);
  int num = ml_list_length (rectlist);
  XRectangle* rects = (XRectangle *) XtMalloc (num * (sizeof (XRectangle)));
  int i = 0;

  while (rectlist != MLNIL)
    {
      mlval car = FIELD (rectlist,0);
      rects[i].x = (short)CINT(FIELD (car,0));
      rects[i].y = (short)CINT(FIELD (car,1));
      rects[i].width = (unsigned short)CINT(FIELD (car,2));
      rects[i].height = (unsigned short)CINT(FIELD (car,3));
      rectlist = FIELD (rectlist,1);
      i++;
    }

  XFillRectangles (display,drawable,gc,rects,num);
  XtFree ((char *) rects);
  return (MLUNIT);
}

static mlval draw_arc (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XDrawArc (display,drawable,gc,
	    CINT (FIELD (arg,3)),
	    CINT (FIELD (arg,4)),
	    (unsigned int)CINT (FIELD (arg,5)),
	    (unsigned int)CINT (FIELD (arg,6)),
	    CINT (FIELD (arg,7)),
	    CINT (FIELD (arg,8)));
  return (MLUNIT);
}

static mlval fill_arc (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  XFillArc (display,drawable,gc,
	    CINT (FIELD (arg,3)),
	    CINT (FIELD (arg,4)),
	    (unsigned int)CINT (FIELD (arg,5)),
	    (unsigned int)CINT (FIELD (arg,6)),
	    CINT (FIELD (arg,7)),
	    CINT (FIELD (arg,8)));
  return (MLUNIT);
}

static mlval draw_arcs (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval arclist = FIELD (arg,3);
  int num = ml_list_length (arclist);
  XArc* arcs = (XArc *) XtMalloc (num * (sizeof (XArc)));
  int i = 0;

  while (arclist != MLNIL)
    {
      mlval car = FIELD (arclist,0);
      arcs[i].x = (short)CINT(FIELD (car,0));
      arcs[i].y = (short)CINT(FIELD (car,1));
      arcs[i].width = (unsigned short)CINT(FIELD (car,2));
      arcs[i].height = (unsigned short)CINT(FIELD (car,3));
      arcs[i].angle1 = (short)CINT(FIELD (car,4));
      arcs[i].angle2 = (short)CINT(FIELD (car,5));
      arclist = FIELD (arclist,1);
      i++;
    }

  XDrawArcs (display,drawable,gc,arcs,num);
  XtFree ((char *) arcs);
  return (MLUNIT);
}

static mlval fill_arcs (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval arclist = FIELD (arg,3);
  int num = ml_list_length (arclist);
  XArc* arcs = (XArc *) XtMalloc (num * (sizeof (XArc)));
  int i = 0;

  while (arclist != MLNIL)
    {
      mlval car = FIELD (arclist,0);
      arcs[i].x = (short)CINT(FIELD (car,0));
      arcs[i].y = (short)CINT(FIELD (car,1));
      arcs[i].width = (unsigned short)CINT(FIELD (car,2));
      arcs[i].height = (unsigned short)CINT(FIELD (car,3));
      arcs[i].angle1 = (short)CINT(FIELD (car,4));
      arcs[i].angle2 = (short)CINT(FIELD (car,5));
      arclist = FIELD (arclist,1);
      i++;
    }

  XFillArcs (display,drawable,gc,arcs,num);
  XtFree ((char *) arcs);
  return (MLUNIT);
}

static mlval draw_string (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval string = FIELD (arg,5);
  XDrawString (display,drawable,gc,
	       CINT (FIELD (arg,3)),
	       CINT (FIELD (arg,4)),
	       CSTRING (string),
	       (int)LENGTH(GETHEADER(string))-1);
  return (MLUNIT);
}

static mlval clear_area (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  XClearArea (display,drawable,
	      CINT (FIELD (arg,2)),
	      CINT (FIELD (arg,3)),
	      (unsigned int)CINT (FIELD (arg,4)),
	      (unsigned int)CINT (FIELD (arg,5)),
	      CBOOL (FIELD (arg,6)));
  return (MLUNIT);
}

/* Note the weird argument ordering -- due to the lexicographical ordering of fields */
/* in ML records */

static mlval copy_area (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable from_drawable = (Drawable) CINT (FIELD (arg,2));
  Drawable to_drawable = (Drawable) CINT (FIELD (arg,3));
  GC gc = (GC) FIELD (arg,4);
  int src_x,src_y,dest_x,dest_y;
  unsigned int width,height;

  src_x = CINT (FIELD (arg,5));
  src_y = CINT (FIELD (arg,6));
  width = (unsigned int)CINT (FIELD (arg,7));
  height = (unsigned int)CINT (FIELD (arg,8));
  dest_x = CINT (FIELD (arg,9));
  dest_y = CINT (FIELD (arg,1));
  XCopyArea (display,from_drawable,to_drawable, gc,
	     src_x,src_y,width,height,dest_x,dest_y);
  return (MLUNIT);
}

static mlval copy_plane (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable from_drawable = (Drawable) CINT (FIELD (arg,3));
  Drawable to_drawable = (Drawable) CINT (FIELD (arg,4));
  GC gc = (GC) FIELD (arg,5);
  int src_x,src_y,dest_x,dest_y;
  unsigned int width,height;
  unsigned long plane;

  src_x = CINT (FIELD (arg,6));
  src_y = CINT (FIELD (arg,7));
  width = (unsigned int)CINT (FIELD (arg,8));
  height = (unsigned int)CINT (FIELD (arg,9));
  dest_x = CINT (FIELD (arg,10));
  dest_y = CINT (FIELD (arg,1));
  plane = CINT (FIELD (arg,2));
  XCopyPlane (display,from_drawable,to_drawable, gc,
	      src_x,src_y,width,height,dest_x,dest_y,plane);
  return (MLUNIT);
}

static mlval draw_image_string (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Drawable drawable = (Drawable) CINT (FIELD (arg,1));
  GC gc = (GC) FIELD (arg,2);
  mlval string = FIELD (arg,5);
  /* Subtract 1 from total size of string for null byte */
  /* this should be a macro really */
  XDrawImageString (display,drawable,gc,
		    CINT (FIELD (arg,3)),
		    CINT (FIELD (arg,4)),
		    CSTRING (string),
		    (int)LENGTH(GETHEADER(string))-1);
  return (MLUNIT);
}


/* colormaps */

static mlval default_colormap (mlval arg)
{
  Screen* screen = (Screen *) arg;
  return (MLINT (DefaultColormapOfScreen (screen)));
}

static mlval alloc_color (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Colormap cmap = CINT (FIELD (arg,1));
  mlval mlcolor = FIELD (arg,2);
  XColor color;
  color.red = CINT (FIELD (mlcolor,0));
  color.green = CINT (FIELD (mlcolor,1));
  color.blue = CINT (FIELD (mlcolor,2));
  if (XAllocColor (display,cmap,&color)) {
    return (box ((unsigned long int)(color.pixel)));
  } else {
    exn_raise_string(perv_exn_ref_x, "Can't allocate color in colormap");
    return MLUNIT;
  }
}
    
static mlval alloc_named_color (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Colormap cmap = CINT (FIELD (arg,1));
  char* name = CSTRING (FIELD (arg,2));
  XColor color;
  XColor exact;
  if (XAllocNamedColor (display,cmap,name,&color,&exact)) {
    return (box ((unsigned long int)(color.pixel)));
  } else {
    exn_raise_string(perv_exn_ref_x, "Can't allocate color in colormap");
    return MLUNIT;
  }
}

static mlval free_colors (mlval arg)
{
  Display* display = (Display *) FIELD (arg, 0);
  Colormap colormap = CINT (FIELD (arg, 1));
  mlval pixelarray = FIELD (arg,2);
  unsigned long planes = CINT (FIELD (arg,3));
  int npixels = LENGTH (ARRAYHEADER (pixelarray));
  unsigned long * pixels = (unsigned long *) malloc (npixels * sizeof (unsigned long));
  int i;
  for (i=0; i<npixels; i++)
    pixels[i] = unbox (MLSUB (pixelarray,i));
  XFreeColors (display,colormap,pixels,npixels,planes);
  return (MLUNIT);
}

static mlval alloc_color_cells (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Colormap colormap = CINT (FIELD (arg,1));
  int contig = CBOOL (FIELD (arg,2));
  unsigned int nplanes = CINT (FIELD (arg,3));
  unsigned int npixels = CINT (FIELD (arg,4));
  unsigned long* plane_masks_return =
    (unsigned long *)XtMalloc (nplanes * sizeof (unsigned long));
  unsigned long* pixels_return =
    (unsigned long *)XtMalloc (npixels * sizeof (unsigned long));
  if (XAllocColorCells (display,colormap,contig,plane_masks_return,nplanes,
      pixels_return,npixels))
    {
      mlval pixel_array = MLUNIT;
      mlval plane_mask_array = MLUNIT;
      mlval result = MLUNIT;
      size_t i;

      pixel_array = allocate_array (npixels);
      for (i=0;i<npixels;i++)
	MLUPDATE (pixel_array,i, MLUNIT);
      declare_root (&pixel_array, 0);

      plane_mask_array = allocate_array (nplanes);
      for (i=0;i<nplanes;i++)
	MLUPDATE (plane_mask_array, i, MLUNIT);
      declare_root (&plane_mask_array, 0);

      for (i=0;i<nplanes;i++) {
	mlval temp = box(plane_masks_return [i]);  /* Do NOT inline this */
	MLUPDATE (plane_mask_array,i, temp);
      }
      for (i=0;i<npixels;i++) {
	mlval temp = box(pixels_return [i]); /* Do NOT inline this */
	MLUPDATE (pixel_array,i, temp);
      }
      result = allocate_record (2);
      FIELD (result,0) = plane_mask_array;
      FIELD (result,1) = pixel_array;
      XtFree ((char *)plane_masks_return);
      XtFree ((char *)pixels_return);
      retract_root (&pixel_array);
      retract_root (&plane_mask_array);
      return (result);
    } 
  else
    {
      XtFree ((char *)plane_masks_return);
      XtFree ((char *)pixels_return);
      exn_raise_string(perv_exn_ref_x, "Can't allocate color in colormap");
    }
}
  
static mlval store_color (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Colormap cmap = CINT (FIELD (arg,1));
  Pixel pixel = unbox (FIELD (arg,2));
  mlval mlcolor = FIELD (arg,3);
  XColor color;
  color.pixel = pixel;
  color.flags = DoRed | DoGreen | DoBlue;
  color.red = CINT (FIELD (mlcolor,0));
  color.green = CINT (FIELD (mlcolor,1));
  color.blue = CINT (FIELD (mlcolor,2));
  XStoreColor (display,cmap,&color);
  return (MLUNIT);
}

static mlval store_named_color (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  Colormap cmap = CINT (FIELD (arg,1));
  Pixel pixel = unbox (FIELD (arg,2));
  char* name = CSTRING (FIELD (arg,3));
  int flags = DoRed | DoGreen | DoBlue;
  XStoreNamedColor (display,cmap,name,pixel,flags);
  return (MLUNIT);
}

/* X clipboard functions */

/* For the moment we won't give a complete ML interface to these functions */
/* just a simple function for getting and setting strings */

/* The following two functions are used by the options from the Edit menu.
 * These functions use the clipboard for the cut/copy and paste operations,
 * whereas the middle mouse button used to paste a selection uses the 
 * PRIMARY window property to store the selection.  Thus these two methods
 * of cutting and pasting are different.  The use of both methods is 
 * praised by <URI: Volume 6A. Motif Programming Manual. Page 617>.
 */ 
static mlval set_selection (mlval arg)
{
  Widget widget = (Widget)FIELD(arg,0);
  mlval ml_text = FIELD(arg,1);
  char *text = CSTRING(ml_text);
  size_t buff_len = CSTRINGLENGTH(ml_text) + 1;
  char *buff = XtMalloc(buff_len);
  int status;
  XmString clip_label = XmStringCreateLocalized((char*) "Data");
  Window window = XtWindowOfObject(widget);
  Display *dpy = XtDisplayOfObject(widget);
  unsigned long item_id = 0;

  strcpy(buff, text);
  do status = XmClipboardStartCopy(dpy, window, clip_label, CurrentTime,
				  NULL, NULL, &item_id);
  while (status == ClipboardLocked);

  XmStringFree(clip_label);
  do status = XmClipboardCopy(dpy, window, item_id, (char*) "STRING",
			     buff, (long)buff_len, 0, NULL);
  while (status == ClipboardLocked);

  do status = XmClipboardEndCopy(dpy, window, item_id);
  while (status == ClipboardLocked);

  return (MLUNIT);
}

static mlval get_selection (mlval arg)
{
  Widget widget = (Widget)FIELD (arg,0);
  mlval handler = FIELD (arg,1);
  Display *dpy = XtDisplayOfObject(widget);
  Window window = XtWindowOfObject(widget);
  char *buf;
  int status, length, recvd;
  mlval mlbuf;

  do status = XmClipboardInquireLength(dpy, window, (char*) "STRING", 
				       (unsigned long *) &length);
  while (status == ClipboardLocked);
				
  if (length != 0) {
    buf = XtMalloc(length+1);
    do status = XmClipboardRetrieve(dpy, window, (char*) "STRING", buf, 
				    length+1, (unsigned long *) &recvd, NULL);
    while (status == ClipboardLocked);
    if (status != ClipboardSuccess || recvd != length) {
      XtWarning("Failed to receive all clipboard data");
      XtFree(buf);
    }
    else {
      declare_root(&handler, 0);
      mlbuf = ml_string(buf);
      retract_root(&handler);
      XtFree(buf);
      callml(mlbuf, handler);
    }
  }

  return (MLUNIT);
}

static mlval synchronize (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  XSynchronize (display,CBOOL (FIELD (arg,1)));
  return (MLUNIT);
}

static mlval xsync (mlval arg)
{
  Display* display = (Display *) FIELD (arg,0);
  XSync (display,CBOOL (FIELD (arg,1)));
  return (MLUNIT);
}

/* Sort of a test function */
/* Need something like this for general resource types */
/* and something for getting resources for particular widget types */
static mlval get_application_resource (mlval arg)
{
  Font value;
  char* name = (CSTRING (FIELD(arg,0)));
  char* type = (CSTRING (FIELD(arg,1)));
  XtResource resources [] =
    {{name,type,XtRFont, sizeof (Font),0,XtRString,(XtPointer)"6x12"}};
  XtGetApplicationResources (applicationShell,&value,resources,1,NULL,0);
  return (MLINT (value));
}

static mlval open_web_location(mlval arg)
{
  char* html_file = CSTRING(arg);
  char* commandStr; 
  char* browser = getenv("MLWORKS_WEB_BROWSER");
  char* home = getenv("HOME");
  char* filename;
  int result;

  if (browser == NULL) {
    return ml_string("No web browser specified");
  }    
  else if (strcmp(browser, "netscape") == 0) {
    int lock_exists;
    struct stat buf;

    filename = (char*)XtMalloc(strlen(home) + 20);
    if (filename == NULL)
      exn_raise_string(perv_exn_ref_x, "Can't allocate memory for opening web location");

    commandStr = (char*)XtMalloc(strlen(html_file) + 35);
    if (commandStr == NULL)
      exn_raise_string(perv_exn_ref_x, "Can't allocate memory for opening web location");

    sprintf(filename, "%s/.netscape/lock", home);
    lock_exists = lstat(filename, &buf);

    /* If the lock link exists then netscape is already running so use it by specifying 
     * the -remote option otherwise start netscape as normal.
     */
    if (lock_exists != 0)
      sprintf(commandStr, "netscape %s &", html_file);
    else
      sprintf(commandStr, "netscape -remote \"openURL(%s)\" &", html_file);

    result = system(commandStr);

    XtFree(filename);
    XtFree(commandStr);

    if (result == -1) 
      return ml_string("Unable to execute Netscape");
  }
  else if (strcmp(browser, "mosaic") == 0) {
    FILE* pid_file;
    
    filename = (char*)XtMalloc(strlen(home) + 20);
    if (filename == NULL)
      exn_raise_string(perv_exn_ref_x, "Can't allocate memory for opening web location");

    sprintf(filename, "%s/.mosaicpid", home);
    pid_file = fopen(filename, "r");
    if (pid_file == NULL) {
      XtFree(filename);
      return ml_string("Can't open mosaic PID file\n");
    }
    else {
      char pidstr[7];
      int pid;
      int kill_result;
      int char_read = fread(pidstr, sizeof(char), 6, pid_file); 

      pidstr[char_read] = '\0';
      pid = atoi(pidstr); 
      
      commandStr = (char*)XtMalloc(strlen(html_file) + 35);
      if (commandStr == NULL)
	exn_raise_string(perv_exn_ref_x, "Can't allocate memory for opening web location");

      /* kill(pid, 0) is used to test for the validity of a pid.  In this case, the 
       * call is used to test for mosaic already running.
       */
      kill_result = kill(pid, 0);
      if (kill_result == 0)
	kill(pid, SIGHUP);

      sprintf(commandStr, "mosaic %s &", html_file);

      XtFree(filename);
      XtFree(commandStr);

      result = system(commandStr);
      if (result == -1) 
	return ml_string("Unable to execute Mosaic");
    }
  }
  else if (strcmp(browser, "") == 0) {
    return ml_string("No web browser specified");
  }
  else {
    return ml_string("Only Netscape and Mosaic web browsers supported");
  }

  /* empty string indicates success */
  return ml_string("");
}

typedef struct {
  XtIntervalId id;
  Widget parent;
  mlval callback;
  XtAppContext app;
} TimeOutClientData;

static void timer_cb(client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
  TimeOutClientData *time_out = (TimeOutClientData *) client_data;

  XtRemoveTimeOut(time_out->id);

  callml(MLUNIT, time_out->callback);

  XtFree((void *)time_out);
}

static mlval add_timer(mlval arg)
{
  Widget parent = (Widget)FIELD(arg,0);
  unsigned long int delay = CINT(FIELD(arg,1));
  mlval callback = FIELD(arg,2);
  TimeOutClientData *time_out = XtNew (TimeOutClientData);
  XtAppContext app = XtWidgetToApplicationContext(parent);

  time_out->app = app;
  time_out->parent = parent;
  time_out->callback = callback;
  declare_root(&callback, 0);
  time_out->id = XtAppAddTimeOut(app, delay, timer_cb, time_out);

  return MLINT(time_out->id);
}

static mlval remove_timer(mlval arg)
{
  XtIntervalId id = (XtIntervalId) unbox(arg);

  XtRemoveTimeOut(id);
  return MLUNIT;
}

static mlval read_pixmap_file(mlval arg)
{
  Widget w = (Widget)FIELD(arg, 0);
  Display *display = XtDisplay(w);
  char *filename = CSTRING(FIELD(arg, 1));
  Pixmap pixmap;
  int status;
  XpmAttributes attributes;

  attributes.closeness = 50000;
  attributes.valuemask = XpmCloseness;

  status = XpmReadPixmapFile
    (display, DefaultRootWindow(display), filename,
     &pixmap, NULL, &attributes);

  if (XpmSuccess != status){
    (void)fprintf
      (stderr, "XpmReadPixmapFile on file \"%s\" failed\n",
       filename);
    return MLINT(0);
  }

  XpmFreeAttributes(&attributes);

  return MLINT(pixmap);
}

/* X initialization function */

void x_init(void)
{
  size_t i;
  mlval ml_widget_classes;

  create_callback_table(NULL, NULL);
  declare_global("x callback table", &callback_table, GLOBAL_TRANSIENT,
		 global_save_die, fix_callback_table, create_callback_table);

  create_event_table(NULL, NULL);
  declare_global("x event table", &event_table, GLOBAL_TRANSIENT,
		 global_save_die, fix_event_table, create_event_table);

  /* we construct the widget class table by building an array of refs to
   * widget classes and then transferring the refs to the table */

  ml_widget_classes = allocate_array(NR_WIDGET_CLASSES);
  for(i=0; i<NR_WIDGET_CLASSES; ++i)
    MLUPDATE(ml_widget_classes,i,MLUNIT);
  declare_root(&ml_widget_classes, 0);
  for(i=0; i<NR_WIDGET_CLASSES; ++i) {
    mlval ml_widget_class = ref((mlval)*widget_classes[i]);
    MLUPDATE(ml_widget_classes,i,ml_widget_class);
  }
  widget_class_table = allocate_record(NR_WIDGET_CLASSES);
  for(i=0; i<NR_WIDGET_CLASSES; ++i)
    FIELD(widget_class_table,i) = MLSUB(ml_widget_classes,i);
  retract_root(&ml_widget_classes);

  declare_global("x widget class table", &widget_class_table,
		 GLOBAL_DEFAULT, NULL, fix_widget_class_table, NULL);

  env_value("x widget class table", widget_class_table);


  env_function("x open web location", open_web_location);

  env_function("x add timer", add_timer);
  env_function("x remove timer", remove_timer);
  env_function("x read pixmap file", read_pixmap_file);

  env_function("x initialize", initialize);
  env_function("x mlw check resources", mlw_check_resources);
  env_function("x quit on exit", quit_on_exit);
  env_function("x main loop", main_loop);
  env_function("x do input", do_input);
  env_function("x cascade button highlight",cascade_button_highlight);
  env_function("x cascade button gadget highlight",cascade_button_gadget_highlight);
  env_function("x text clear selection", text_clear_selection);
  env_function("x text copy selection", text_copy_selection);
  env_function("x text cut selection", text_cut_selection);
  env_function("x text get baseline", text_get_baseline);
  env_function("x text get editable", text_get_editable);
  env_function("x text getinsertionposition", text_getinsertionposition);
  env_function("x text getlastposition", text_getlastposition);
  env_function("x text get max length", text_get_max_length);
  env_function("x text getselection", text_getselection);
  env_function("x text get selection position", text_get_selection_position);
  env_function("x text getstring", text_getstring);
  env_function("x text get top character", text_get_top_character);
  env_function("x text insert", text_insert);
  env_function("x text paste selection", text_paste_selection);
  env_function("x text remove", text_remove);
  env_function("x text replace", text_replace);
  env_function("x text set add mode", text_set_add_mode);
  env_function("x text set editable", text_set_editable);
  env_function("x text sethighlight", text_sethighlight);
  env_function("x text setinsertionposition", text_setinsertionposition);
  env_function("x text setselection", text_setselection);
  env_function("x text set max length", text_set_max_length);
  env_function("x text setstring", text_setstring);
  env_function("x text scroll", text_scroll);
  env_function("x text set top character", text_settopcharacter);
  env_function("x text show position", text_showposition);
  env_function("x text xy to pos", text_xytopos);
  env_function("x text pos to xy", text_postoxy);
  env_function("x text extents", text_extents);

  env_function("x text set message widget", text_setmessagewidget);
  env_function("x text no message widget", text_nomessagewidget);
  env_function("x toggle button get state", toggle_button_get_state);
  env_function("x toggle button set state", toggle_button_set_state);
  env_function("x toggle button gadget get state", toggle_button_gadget_get_state);
  env_function("x toggle button gadget set state", toggle_button_gadget_set_state);
  env_function("x widget create", widget_create);
  env_function("x widget create menubar", widget_create_menubar);
  env_function("x widget create popupshell", widget_create_popupshell);
  env_function("x widget create pulldownmenu", widget_create_pulldownmenu);
  env_function("x widget create scrolledtext", widget_create_scrolledtext);
  env_function("x widget destroy", widget_destroy);
  env_function("x widget realize", widget_realize);
  env_function("x widget unrealize", widget_unrealize);
  env_function("x widget is realized", widget_is_realized);
  env_function("x widget manage", widget_manage);
  env_function("x widget unmanage child", widget_unmanage_child);
  env_function("x widget map", widget_map);
  env_function("x widget unmap", widget_unmap);
  env_function("x widget popup", widget_popup);
  env_function("x widget set backing", set_backing);
  env_function("x widget set save under", set_save_under);
  env_function("x widget values set", widget_values_set);
  env_function("x widget values get", widget_values_get);
  env_function("x widget callback add", widget_callback_add);
  env_function("x widget display", widget_display);
  env_function("x widget parent", widget_parent);
  env_function("x widget screen", widget_screen);
  env_function("x widget window", widget_window);
  env_function("x widget name", widget_name);
  env_function("x widget set busy", widget_set_busy);
  env_function("x widget unset busy", widget_unset_busy);
  env_function("x widget to front", window_to_front);
  env_function("x widget process traversal", process_traversal);
  env_function("x translations parse table", translations_parse_table);
  env_function("x translations override", translations_override);
  env_function("x translations augment", translations_augment);
  env_function("x translations uninstall", translations_uninstall);
  env_function("x string baseline", string_baseline);
  env_function("x string has substring", string_has_substring);
  env_function("x string create", string_create);
  env_function("x string direction create", string_direction_create);
  env_function("x string separator create", string_separator_create);
  env_function("x string segment create", string_segment_create);
  env_function("x string create l to r", string_create_l_to_r);
  env_function("x string create simple", string_create_simple);
  env_function("x string free", string_free);
  env_function("x string compare", string_compare);
  env_function("x string bytecompare", string_bytecompare);
  env_function("x string copy", string_copy);
  env_function("x string ncopy", string_ncopy);
  env_function("x string concat", string_concat);
  env_function("x string nconcat", string_nconcat);
  env_function("x string empty", string_empty);
  env_function("x string length", string_length);
  env_function("x string linecount", string_linecount);
  env_function("x string extent", string_extent);
  env_function("x string height", string_height);
  env_function("x string width", string_width);
  env_function("x string convert text", string_convert_text);
  env_function("x font load", font_load);
  env_function("x fontstruct free", fontstruct_free);
  env_function("x query font", query_font);
  env_function("x fontlist create", fontlist_create);
  env_function("x fontlist add", fontlist_add);
  env_function("x fontlist copy", fontlist_copy);
  env_function("x fontlist free", fontlist_free);
  env_function("x is motif wm running", is_motif_wm_running);
  env_function("x update display", update_display);
  env_function("x atom intern",atom_intern);
  env_function("x atom get name",atom_get_name);
  env_function("x tabgroup add",tabgroup_add);
  env_function("x tabgroup remove",tabgroup_remove);
  env_function("x pixmap create", pixmap_create);
  env_function("x pixmap free", pixmap_free);
  env_function("x pixmap get", pixmap_get);
  env_function("x pixmap destroy", pixmap_destroy);
  env_function("x pixel screen black", pixel_screen_black);
  env_function("x pixel screen white", pixel_screen_white);
  env_function("x convert AnyEvent", convert_AnyEvent);
  env_function("x convert ExposeEvent", convert_ExposeEvent);
  env_function("x convert KeyEvent", convert_KeyEvent);
  env_function("x convert ButtonEvent", convert_ButtonEvent);
  env_function("x convert MotionEvent", convert_MotionEvent);
  env_function("x convert AnyCallbackStruct", convert_AnyCallbackStruct);
  env_function("x convert DrawingAreaCallbackStruct", convert_DrawingAreaCallbackStruct);
  env_function("x convert ToggleButtonCallbackStruct", convert_ToggleButtonCallbackStruct);
  env_function("x convert ListCallbackStruct", convert_ListCallbackStruct);
  env_function("x convert TextVerifyCallbackStruct", convert_TextVerifyCallbackStruct);
  env_function("x convert ScaleCallbackStruct", convert_ScaleCallbackStruct);
  env_function("x boolean set", boolean_set);
  env_function("x list add item", list_add_item);
  env_function("x list add item unselected", list_add_item_unselected);
  env_function("x list add items", list_add_items);
  env_function("x list delete all items", list_delete_all_items);
  env_function("x list delete item", list_delete_item);
  env_function("x list delete items", list_delete_items);
  env_function("x list delete items pos", list_delete_items_pos);
  env_function("x list delete pos", list_delete_pos);
  env_function("x list select pos", list_select_pos);
  env_function("x list get selected pos",list_get_selected_pos);
  env_function("x list set bottom pos",list_set_bottom_pos);
  env_function("x list set pos",list_set_pos);
  env_function("x scale get value", scale_get_value);
  env_function("x scale set value", scale_set_value);
  env_function("x scrollbar get values", scrollbar_get_values);
  env_function("x scrollbar set values", scrollbar_set_values);
  env_function("x scrolled window set areas", scrolled_window_set_areas);
  env_function("x file selection do search",file_selection_do_search);
  env_function("x file selection box get child",file_selection_box_get_child);
  env_function("x selection box get child",selection_box_get_child);
  env_function("x message box get child",message_box_get_child);
  env_function("x bell", bell);
  env_function("x query pointer", query_pointer);
  env_function("x default depth", default_depth);
  env_function("x default visual", default_visual);
  env_function("x add event handler", add_event_handler);
  env_function("x handle expose events", ml_handle_expose_events);
  env_function("x gc create", gc_create);
  env_function("x gc change", gc_change);
  env_function("x gc copy", gc_copy);
  env_function("x gc free", gc_free);
  env_function("x gc set clip rectangles", gc_set_clip_rectangles);
  env_function("x gc get values", gc_get_values);
  env_function("x draw point", draw_point);
  env_function("x draw points", draw_points);
  env_function("x draw line", draw_line);
  env_function("x draw lines", draw_lines);
  env_function("x draw segments", draw_segments);
  env_function("x fill polygon", fill_polygon);
  env_function("x draw string", draw_string);
  env_function("x draw rectangle", draw_rectangle);
  env_function("x draw rectangles", draw_rectangles);
  env_function("x fill rectangle", fill_rectangle);
  env_function("x fill rectangles", fill_rectangles);
  env_function("x draw arc", draw_arc);
  env_function("x draw arcs", draw_arcs);
  env_function("x fill arc", fill_arc);
  env_function("x fill arcs", fill_arcs);
  env_function("x draw image string", draw_image_string);
  env_function("x clear area", clear_area);
  env_function("x copy area", copy_area);
  env_function("x copy plane", copy_plane);
  env_function("x default colormap", default_colormap);
  env_function("x alloc color", alloc_color);
  env_function("x alloc named color", alloc_named_color);
  env_function("x alloc color cells", alloc_color_cells);
  env_function("x free colors", free_colors);
  env_function("x store color", store_color);
  env_function("x store named color", store_named_color);
  env_function("x set selection", set_selection);
  env_function("x get selection", get_selection);
  env_function("x sync", xsync);
  env_function("x synchronize", synchronize);
  env_function("x sync graphics exposures", sync_graphics_exposures);
  env_function("x get application resource",get_application_resource);
  env_function("x set interrupt window", set_interrupt_window);

  x_exns_initialised = ref (MLFALSE);
  env_value("x exns initialised", x_exns_initialised);
  declare_global("x exns initialised", &x_exns_initialised,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  perv_exn_ref_x = ref(exn_default);
  env_value("exception X", perv_exn_ref_x);
  declare_global("pervasive exception X", &perv_exn_ref_x,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

}


static void message_dlg_callback
  (Widget widget, XtPointer client_data, XtPointer call_data)
{
  int *confirmation = (int *)client_data;
  XmAnyCallbackStruct *cbs = (XmAnyCallbackStruct *) call_data;
  *confirmation = (cbs->reason == XmCR_CANCEL);
}

void display_simple_message_box(const char *message)
{
  if (applicationShell == NULL) {
    fprintf(stderr, message);
  } else {
    static Widget dialog;
    XmString text;
    static int confirmation;

    if (!dialog) {
      Arg args[5];
      int n = 0;
      XmString ok = XmStringCreateLocalized((char *)("OK"));
      XtSetArg(args[n], XmNautoUnmanage, False); n++;
      XtSetArg(args[n], XmNcancelLabelString, ok); n++;
      dialog = XmCreateWarningDialog(applicationShell, (char *)("expiring"), 
                                     args, n);
      XtAddCallback(dialog, XmNcancelCallback, 
                    message_dlg_callback, &confirmation);
      XtUnmanageChild(XmMessageBoxGetChild(dialog, XmDIALOG_OK_BUTTON));  
      XtUnmanageChild(XmMessageBoxGetChild(dialog, XmDIALOG_HELP_BUTTON));  
    }
    confirmation = 0;
    text = XmStringCreateLocalized((char *)message);
    XtVaSetValues(dialog, XmNmessageString, text, 
                  XmNdialogStyle, XmDIALOG_FULL_APPLICATION_MODAL, NULL);   
    XmStringFree (text);
    XtManageChild(dialog);
    XtPopup(XtParent(dialog), XtGrabNone);
  
    while (confirmation == 0) XtAppProcessEvent(applicationContext, XtIMAll);
    XtPopdown(XtParent(dialog));
  }
}







