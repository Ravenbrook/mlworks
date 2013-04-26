/*  ==== PERVASIVE NT FUNCTIONS ====
 *
 *  Copyright (C) 1994 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This part of the runtime environment contains all the Windows NT specific
 *  stuff.
 *
 *  Revision Log
 *  ------------
 *  $Log: win32.h,v $
 *  Revision 1.1  1996/02/12 11:58:38  stephenb
 *  new unit
 *  This used to be src/rts/src/OS/common/win32.h
 *
 * Revision 1.3  1996/01/22  15:45:30  stephenb
 * change nt_init to win32_init.
 *
 * Revision 1.2  1996/01/18  15:49:05  stephenb
 * Now that the name of the file has changed (nt.h -> win32.h), the
 * ifndef name must change accordingly.
 *
 * Revision 1.1  1994/12/12  14:30:08  jont
 * new file
 *
 *
 */

#ifndef win32_h
#define win32_h


/*  === INTIALISE ===
 *
 *  Intialises the module and adds the nt values to the runtime
 *  environment.
 */

extern void win32_init(void);

#endif
