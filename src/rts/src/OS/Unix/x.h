/*  ==== PERVASIVE INTERFACE TO X LIBRARIES ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 * Lifted from SunOS version 1.2
 *
 *  Revision Log
 *  ------------
 *  $Log: x.h,v $
 *  Revision 1.3  1998/01/23 17:23:55  jont
 *  [Bug #20076]
 *  Add x_hide_podium call for when the license has been reacquired
 *
 * Revision 1.2  1996/10/17  14:03:57  jont
 * Merging in license server stuff
 *
 * Revision 1.1.2.2  1996/10/14  16:28:09  nickb
 * Add x_reveal_podium() stub.
 *
 * Revision 1.1.2.1  1996/10/07  16:13:08  hope
 * branched from 1.1
 *
 * Revision 1.1  1996/02/12  11:58:46  stephenb
 * new unit
 * This used to be src/rts/src/OS/common/x.h
 *
 * Revision 1.3  1995/04/27  11:47:54  daveb
 * Added the "awaiting_x_event" flag.
 *
 * Revision 1.2  1995/04/24  15:06:59  nickb
 * Check for hope bug.
 *
 *
 * Revision 1.1  1995/04/24  14:50:19  nickb
 * new unit
 * From SunOS version 1.2.
 *
 */

#ifndef x_h
#define x_h

/* This function handles any expose events currently on the X event
 * queue. It should be called with reasonable frequency */
extern void x_handle_expose_events(void);

/* This flag is set before blocking on an X event, and unset when a callback
   occurs.  It can be used to handle signals appropriately. */
extern int awaiting_x_event;

/* Called when starting up the runtime */
extern void x_init(void);

/* Called when we send a message to the podium which must get seen */
extern void x_reveal_podium(void);

/* Called when we reacquire a network license and no longer want the podium on view */
extern void x_hide_podium(void);

#endif
