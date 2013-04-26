#ifndef __HQCSTASS_H__
#define __HQCSTASS_H__

/*
$HopeName: HQNc-standard!export:hqcstass.h(trunk.7) $

$Log: hqcstass.h,v $
Revision 1.8  1997/01/21 10:41:54  steveb
[Bug #50004]
More nested includes.

Revision 1.7  1996/12/04  09:37:52  nickr
[Bug #50004]
nested includes

Revision 1.6  1995/09/29  10:41:39  nickr
[Bug #6023]
remove enum types

Revision 1.5  1994/06/19  08:56:01  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-Apr-19-19:12 tina
	[Task number: 3585]
	Use separate definition of HqCustomTrace for VARARGS
 1994-Apr-15-18:56 paulb
	[Task number: 3585]
	Use PROTO and PARAMS, not PROTOMIXED
 1994-Apr-14-16:29 paulb
	Created in standard
*/

/* hqcstass.h
 * ==========
 *
 * "Custom" Assert and Trace functions (called from HqAssert and HqTrace).
 * Each platform should define its own version of these functions.
 *
 * Typically HqCustomAssert should display the message to the user (unless
 * it is NULL) and interrupt the program (or drop into a debugger).
 *
 * HqCustomTrace will usually do nothing.
 *
 * Paul Butcher, 94/4/12.
 */

/* ----------------------- Includes ---------------------------------------- */

#ifndef VARARGS
#include <stdarg.h>
#endif

#include "std.h"			/* int32 */

/* ----------------------- Types ------------------------------------------- */

enum { AssertNotRecursive, AssertRecursive };
typedef int32 AssertFlag;

/* ----------------------- Functions --------------------------------------- */

extern void HqCustomAssert PROTO(
    (char *pszFilename, long int nLine, char *pszMessage, AssertFlag assertflag));
#ifdef VARARGS
extern void HqCustomTrace();
#else
extern void HqCustomTrace PROTO(
    (char *pszFilename, long int nLine, char *pszFormat, va_list vlist));
#endif

#endif  /* __HQCSTASS_H__ */

/* eof hqcstass.h */
