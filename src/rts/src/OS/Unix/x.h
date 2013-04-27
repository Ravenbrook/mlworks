/*  ==== PERVASIVE INTERFACE TO X LIBRARIES ====
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

#endif
