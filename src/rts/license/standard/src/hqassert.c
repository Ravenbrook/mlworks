/*
$Log: hqassert.c,v $
Revision 1.29  2002/04/18 15:03:50  jonw
[Bug #25083]
New build regime for profiling: enable assertions and traces only when
ASSERT_BUILD is defined, rather than the old cop-out ! RELEASE_BUILD.

Revision 1.28  1996/11/27  18:33:04  angus
[Bug #20027]
Make hq_assert_history non-static, so msvc can see it.

Revision 1.27  1996/09/11  16:33:26  nickr
[Bug #7607]
add HqAssertDepth

Revision 1.26  1996/06/27  18:29:47  freeland
[Bug #8103]
Adding a level of braces to the initializer for the history list, because
it's correct and gcc (on linux) otherwise complains.

Revision 1.25  1996/03/04  19:41:03  andy
[Bug #7623]
Fix off-by-one mistakes

Revision 1.24  1996/03/01  19:43:36  andy
[Bug #7623]
Add in optional history to asserts, so you can ignore spurious ones.

Revision 1.23  1995/07/06  20:17:01  dstrauss
[Bug #4569]
Add variable hqassert_val (which happens to have a constant
value) for use by HQASSERT and HQTRACE to eliminate "unreachable
code" warnings.

Revision 1.22  1995/02/06  18:40:37  freeland
[Bug #4955]
HqCustomAssert is now responsible for calling MONITORF (or whatever),
which used to be done in HqAssert.  This because otherwise it's possible
to have neither function do it, which is very obnoxious.

Revision 1.21  1994/11/22  12:36:57  davidh
[Bug #4288]
Make it use HQASSERT_USEPRINTF as a synonym for USEPRINTF, as that
seems a bit non specific for me to use to compile everything.

Revision 1.20  1994/11/02  21:36:05  freeland
[Bug #3746]
prototype needed for printf(), so stdio.h needs including.

Revision 1.19  1994/09/21  12:19:38  julianb
[Bug #4246]
changing coreguimonitorf() first arg to char*

Revision 1.18  1994/07/27  14:29:38  luke
wow, gcc looks in the printf format string to check the types
of its arguments

Revision 1.17  1994/07/25  08:57:16  luke
Bug 4067: change long ints to ints

Revision 1.16  1994/07/19  18:26:39  angus
Move prototypes of printf and vprintf from hqassert.c to osprotos.h,
which is a more sensible place for them.

Revision 1.15  1994/07/19  11:03:16  angus
Add prototypes for printf and vprintf for building Jac.

Revision 1.14  1994/06/19  08:56:17  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-May-17-13:34 paulb
	[Task number: 3585]
	Call va_end correctly
 1994-May-16-19:16 luke
	[Task number: 3585]
	problems compiling on snake - the proto definition of vprintf didn't
	agree with the system one. Only provide the proto definition for
	VMONITORF when it is mapped to vcoreguimonitorf and vmonitorf. We'll
	still get pointer mismatch warnings for unit8 * and char *.
 1994-May-13-17:40 tina
	[Task number: 3585]
	Use printf/vprintf for products that don't have monitorfs (ie.swp)
 1994-Apr-28-11:31 davidg
	[Task number: 3585]
	lint removal: move prototype for VMONITORF so it is not included when
	not used and is outside a function definition when it is.
 1994-Apr-27-17:34 paulb
	[Task number: 3585]
	Add a newline after an assert message
 1994-Apr-21-11:01 john
	[Task number: 3585]
	Get it to compile on SGI4K -- needs cast for monitorf first arg -- which
	is getting to be a right pain. Given that monitorf first args are most
	often going to be C string constants, it might have been nice to get a
	type that doesn't need casting. Or is this meant to make you stop and
	think about something? If so, unfortunately I can't think what!
 1994-Apr-20-19:03 paulb
	[Task number: 3585]
	Add the prototype for VMONITORF back in, but with PROTO this time
 1994-Apr-20-11:16 paulb
	[Task number: 3585]
	Remove the explicit "extern" of MONITORF
 1994-Apr-15-18:55 paulb
	[Task number: 3585]
	Use PROTO and PARAMS, not PROTOMIXED
 1994-Apr-15-18:11 davidg
	[Task number: 3585]
	fix to allow use with HQASSERT_LOCAL_FILE defined on compile line or
	in std.h and to support HQASSERT_NO_MONITOR on platfomrs which do not
	have fileio.h.
 1994-Apr-15-11:53 paulb
	[Task number: 3585]
	Include guifns.h
 1994-Apr-14-16:30 paulb
	Created in standard
*/

/* hqassert.c
 * ==========
 *
 * Harlequin standard "assert" and "trace" support routines.
 *
 * Paul Butcher, 94/4/12.
 */

/* ----------------------- Includes ---------------------------------------- */

#include "std.h"        /* std.h automatically includes hqassert.h */
#ifdef HQASSERT_LOCAL_FILE
HQASSERT_FILE();
#endif

#include <stdio.h>
#ifdef STDARGS
#include <stdarg.h>
#else
#include <varargs.h>
#endif

#include "hqcstass.h"


#if defined( ASSERT_BUILD )

/* ----------------------- Types ------------------------------------------- */

#define HQ_MAX_ASSERTS 256
typedef struct assert_history {
  char *pszFilename;
  int nLine;
  char *pszMessage;
} HQ_ASSERT_HISTORY ;


/* ----------------------- Data -------------------------------------------- */

uint32                          hqassert_val = HQASSERT_VAL;
static int32                    hq_assert_depth = 0;

static char *                   pszFilenameSaved = NULL;
static int                      nLineSaved = -1;
static int                      fFileAndLineSaved = FALSE;

int                             hq_assert_history = TRUE;
static int                      hq_assert_history_count = 0 ;
static HQ_ASSERT_HISTORY        hq_assert_history_table[ HQ_MAX_ASSERTS ] =
                                 { { NULL, 0, NULL } };


/* ----------------------- Functions --------------------------------------- */

static int HqRememberAssert PARAMS((char *pszFilename, int nLine, char *pszMessage),
    (pszFilename, nLine, pszMessage) char *pszFilename; int nLine; char *pszMessage;)
{
  int i ;
  int moveupto ;
  int found_assert ;
  
  moveupto = hq_assert_history_count ;
  if ( moveupto == HQ_MAX_ASSERTS )
    --moveupto ;
  
  /* Check if assert has been shown already, and ignore if so... */
  found_assert = FALSE ;
  for ( i = 0 ; i < hq_assert_history_count ; ++i )
    if ( hq_assert_history_table[ i ].pszFilename == pszFilename &&
	 hq_assert_history_table[ i ].nLine       == nLine &&
	 hq_assert_history_table[ i ].pszMessage  == pszMessage ) {
      /* Ignore this assert. */
      found_assert = TRUE ;
      /* We want to move this one to the head of the q. */
      moveupto = i ;
      /* Decrement count as we essentially add it in at the head. */
      --hq_assert_history_count ;
      break ;
    }
    
  /* Move everything up one so we can insert the new assert at the head of the q. */
  for ( i = moveupto ; i > 0 ; --i ) {
    hq_assert_history_table[ i ].pszFilename = hq_assert_history_table[ i - 1 ].pszFilename ;
    hq_assert_history_table[ i ].nLine       = hq_assert_history_table[ i - 1 ].nLine ;
    hq_assert_history_table[ i ].pszMessage  = hq_assert_history_table[ i - 1 ].pszMessage ;
  }
  
  /* Insert the new assert at the head of the q. */
  hq_assert_history_table[ 0 ].pszFilename = pszFilename ;
  hq_assert_history_table[ 0 ].nLine       = nLine ;
  hq_assert_history_table[ 0 ].pszMessage  = pszMessage ;
  
  ++hq_assert_history_count ;
  if ( hq_assert_history_count > HQ_MAX_ASSERTS )
    hq_assert_history_count = HQ_MAX_ASSERTS ;
  
  /* If we found it already, then don't bother reporting it again. */
  return ( found_assert ) ;
}

void HqAssert PARAMS((char *pszFilename, int nLine, char *pszMessage),
    (pszFilename, nLine, pszMessage) char *pszFilename; int nLine; char *pszMessage;)
{
  if ( hq_assert_history && HqRememberAssert( pszFilename, nLine, pszMessage ))
   return ;

  hq_assert_depth++;
  if ( hq_assert_depth > 1 )
   HqCustomAssert
    ( __FILE__, __LINE__, "*** ASSERT within ASSERT! ***", AssertRecursive );

  HqCustomAssert( pszFilename, nLine, pszMessage, AssertNotRecursive );

  hq_assert_depth--;
}

int32 HqAssertDepth( void )
{
  return hq_assert_depth;
}

void HqTraceSetFileAndLine PARAMS((char *pszFilename, int nLine),
    (pszFilename, nLine) char *pszFilename; int nLine;)
{
    HQASSERT(!fFileAndLineSaved,
        "Error - HqTrace not called after HqTraceSetFileAndLine");

    pszFilenameSaved = pszFilename;
    nLineSaved = nLine;
    fFileAndLineSaved = TRUE;
}

#ifdef STDARGS
void HqTrace PARAMS(( char *pszFormat, ... ), (pszFormat) char *pszFormat ; )
#else
void HqTrace (pszFormat, va_alist)
char *pszFormat;
va_dcl
#endif
{
    va_list vlist;

    HQASSERT(fFileAndLineSaved,
        "Error - HqTraceSetFileAndLine not called before HqTrace");

    fFileAndLineSaved = FALSE;

#ifdef STDARGS
    va_start(vlist, pszFormat);
#else
    va_start(vlist);
#endif

    HqCustomTrace(pszFilenameSaved, nLineSaved, pszFormat, vlist);

    va_end(vlist);

}

#else   /* ! defined( ASSERT_BUILD ) */

int32   hqassert_dummy;

#endif  /* ! defined( ASSERT_BUILD ) */

