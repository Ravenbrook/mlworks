/*  ==== ANSI COMPATABILITY HEADER ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This header defines some things which are part of the ANSI standard but
 *  missing from the compiler/environment.
 *
 *  $Id: ansi.h,v 1.1 1994/10/18 16:09:59 nickb Exp $
 */

#ifndef ansi_h
#define ansi_h

#include <stdarg.h>
#include <stdio.h>
#include <sys/types.h>
#include <time.h>

#ifdef __GNUC__
#define EXIT_SUCCESS	0
#define EXIT_FAILURE	1
#define FILENAME_MAX	1024	/* from the manual */
#define SEEK_SET	0
#define SEEK_CUR	1
#define SEEK_END	2
#endif /* __GNUC__ */

#endif
