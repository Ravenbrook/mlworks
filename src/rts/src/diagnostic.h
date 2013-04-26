/*  === DIAGNOSTIC OUTPUT ===
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This header provides a macro which can be used in a program to
 *  provide diagnostic output to stderr with different levels of
 *  priority.  Output at level 0 is always displayed, but other levels
 *  are only output if the external unsigned int diagnostic_level is
 *  not less than that level.  In the MLWorks runtime system the
 *  diagnostic_level is set by the `-d' option on the command line.
 *
 *  NOTE:  The macro DIAGNOSTICS must be defined elsewhere (preferably as an
 *  argument to the compiler) in order to make the DIAGNOSTIC macro do
 *  anything.
 *
 *  $Id: diagnostic.h,v 1.4 1996/11/18 13:30:36 stephenb Exp $
 */


#ifndef diagnostic_h
#define diagnostic_h

extern unsigned int diagnostic_level;

#ifdef DIAGNOSTICS
#include "utils.h"
#define DIAGNOSTIC(level, format, p1, p2) \
do {					  \
  if ((level) <= diagnostic_level)	  \
    message_stderr(format, p1, p2);	  \
} while (0)

#else

#define DIAGNOSTIC(level, format, p1, p2)  \
do {                                       \
  /* do nothing */                         \
} while (0)

#endif

#endif
