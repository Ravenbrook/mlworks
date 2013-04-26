/* warnings.h
 * ==========
 * Macros and such used primarily to eliminate compiler warnings.
 * The intent is that this file should contain macros which are or
 * can be used for various compilers to work around various warnings
 * which the compilers generate.
 *
 *
 *
 * 
 *    $Log: warnings.h,v $
 *    Revision 1.11  2000/02/14 11:43:17  luke
 *    [Bug #22983]
 *    UNUSED_PARAM doesn't shut the SGI compiler up - use a simpler form
 *
 * Revision 1.10  1996/07/01  13:25:27  andrew
 * [Bug #8264]
 * Mac 68K compiler SC is not brain-dead, but does complain a lot
 *
 * Revision 1.9  1996/01/18  21:28:26  dstrauss
 * [Bug #4569]
 * Turn off some more MSVC warnings - C4115 (named type definition
 * in parentheses) and C4514 (unreferenced inline funciton has been
 * removed).
 *
 * Revision 1.8  1995/10/20  20:31:29  dstrauss
 * [Bug #4569]
 * Turn off more warnings for MSVC 2.0.
 * Specifically: warning C4209: nonstandard extension used : benign
 * typedef redefinition.
 *
 * Revision 1.7  1995/07/10  15:46:05  freeland
 * [Bug #6056]
 * fixing typo
 *
 * Revision 1.6  1995/07/10  15:23:10  freeland
 * [Bug #6056]
 * adding an alternate UNUSED_PARAMS, which the MPW "C" compiler will
 * know how to optimize away.
 *
 * Revision 1.5  1995/07/06  20:16:50  dstrauss
 * [Bug #4569]
 * Add pragma's to turn off warnings in MSVC:  4127 (conditional
 * expression is a constant), 4201 (nonstandard extension used: nameless
 * struct/union), and 4214 (nonstandard extension used : bit field types
 * other than int).  4201 and 4214 are new; 4127 is being moved here
 * from platform.h.
 *
 * Revision 1.4  1995/01/23  21:32:25  pbarada
 * [Bug #4569]
 * Fix definition of UNUSED_PARAM for SGI compiler
 *
 * Revision 1.3  1994/12/13  17:48:46  bart
 * [Bug #4569]
 * Add new symbol for SGI to avoid warnings from PRAGMA_UNUSED workaround.
 *
 * Revision 1.2  1994/12/07  23:00:26  dstrauss
 * [Bug #4569]
 * Change UNUSED to UNUSED_PARAM to avoid conflict.
 *
 * Revision 1.1  1994/12/07  22:24:35  dstrauss
 * new file
 *
 * DStrauss  07-Dec-94
 *     Created with UNUSED().
 *
 */

#ifndef __WARNINGS_H__
#define __WARNINGS_H__

#ifdef _MSC_VER
/*
 * For MSVC compiler, we don't care about the "conditional expression is
 * a constant" warning message.  Turn it off with a pragma.
 */
#pragma warning (disable : 4127)

/*
 * Turn off warnings which occur in MS Windows
 * include files (winnt.h and winbase.h, for example):
 *
 * warning C4201: nonstandard extension used : nameless struct/union
 * warning C4214: nonstandard extension used : bit field types other than int
 * warning C4209: nonstandard extension used : benign typedef redefinition
 * warning C4115: named type definition in parentheses
 * warning C4514: unreferenced inline function has been removed
 */

#pragma warning (disable : 4201)
#pragma warning (disable : 4214)
#pragma warning (disable : 4209)
#pragma warning (disable : 4115)
#pragma warning (disable : 4514)

#endif




/*****************************************************
 * UNUSED(type, param) - unused formal parameter.
 * Creates a dummy usage of an unused parameter for those compilers
 * which do not understand the "unused" pragma.  "type" is the parameter
 * type.  
 *
 *****************************************************/

#if defined(lint) || defined(NO_DUMMYPARAM)

# define UNUSED_PARAM(type, param) /* VOID */

#else  /* !defined(lint) && [!NO_DUMMYPARAM] */

#if defined(MAC68K) && !defined(__GNUC__) && !defined(__SC__)
       /* define UNUSED_PARAM for MPW "C" compiler, whose optimizer is dumb */
#define UNUSED_PARAM(type, param) \
  { param; }
  
#else

#ifdef SGI
       /* The SGI compiler can use the definition used below. */
#define UNUSED_PARAM(type, param) \
  (void)param;

#else
       /* definition of UNUSED_PARAM for all other compilers */
#define UNUSED_PARAM(type, param) \
  { \
     type dummy_param; \
     type dummy_param2; \
     dummy_param = param; \
     dummy_param2 = dummy_param; \
     dummy_param = dummy_param2; \
  }

#endif /* SGI */
#endif /* which compiler? */
#endif /* defined(HAS_PRAGMA_UNUSED) || defined(lint) */



#endif  /* __WARNINGS_H__ */

