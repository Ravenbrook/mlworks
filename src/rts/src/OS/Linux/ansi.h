/*  ==== ANSI COMPATABILITY HEADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header defines some things which are part of the ANSI standard but
 *  missing from the C compiler / environment.
 * 
 *  See also syscalls.h, which contains prototypes for system calls
 *  which are not prototyped in include files
 * 
 *  $Id: ansi.h,v 1.3 1995/08/04 13:51:17 nickb Exp $
 */

#ifndef ansi_h
#define ansi_h

/* Linux does very well at having ANSI standard header files.
 * Unfortunately we can't include stdlib.h as its definitions of
 * malloc &c conflict with those in alloc.h.*/

/* stdio.h things */

/* time.h things */

/* stdlib.h things */

#define EXIT_FAILURE	1

#endif
