/*
$HopeName: HQNc-standard!export:hqassert.h(trunk.21) $

$Log: hqassert.h,v $
Revision 1.22  2002/04/18 15:03:44  jonw
[Bug #25083]
New build regime for profiling: means we finally have to switch
assertions on and off with ASSERT_BUILD rather than !
RELEASE_BUILD. Should have been done an awfully long time ago.

Revision 1.21  2001/07/13  15:33:29  jonw
[Bug #24215]
Add HQASSERT[WLD]PTR - shorthand for asserting pointers against NULL.

Revision 1.20  2001/03/12  12:54:49  deane
[Bug #24061]
Back out of last change.

Revision 1.19  2001/03/12  11:25:25  deane
[Bug #24061]
Include Types.h to solve build probs.

Revision 1.18  2001/01/24  16:34:08  mikew
[Bug #23905]
Add redundant assignment from plover in HQASSERT_FPEXCEP to prevent debug
build warning on PC.

Revision 1.17  2000/10/25  12:26:19  peterg
[Bug #11232]
Get a clean build on Linux

Revision 1.16  1998/07/30  17:23:51  mikew
[Bug #50064]
Add assert macro to prod Intel FPU fp exceptions if any waiting.

Revision 1.15  1998/07/23  16:21:22  luke
[Bug #30340]
mark with extern C

Revision 1.14  1996/09/11  16:32:00  nickr
[Bug #7607]
add HqAssertDepth

Revision 1.13  1996/08/27  13:24:40  miker
[Bug #8507]
Add message to HQASSERT_EXPN

Revision 1.12  1996/08/23  16:30:10  miker
[Bug #8507]
Add HQASSERT_EXPN

Revision 1.11  1995/09/27  14:57:42  paulb
[Bug #6237]
Add compile-time asserts

Revision 1.10  1995/07/06  20:16:55  dstrauss
[Bug #4569]
Add variable hqassert_val (which happens to have a constant value)
to the tests for HQASSERT and HQTRACE to eliminate "unreachable
code" warnings.

Revision 1.9  1994/12/08  20:44:20  dstrauss
[Bug #4569]
Rewrite HQFAIL to not use HQASSERT, then rewrite HQASSERT to
use HQFAIL.  HQFAIL now no longer has a conditional in it.

Revision 1.8  1994/07/25  08:56:06  luke
Bug 4067: change long ints to ints

Revision 1.7  1994/06/19  08:56:00  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-Apr-27-19:03 paulb
	[Task number: 3678]
	Add HQFAIL
 1994-Apr-20-11:17 paulb
	[Task number: 3585]
	Yet another attempt to get the prototypes correct
 1994-Apr-15-23:47 davidg
	[Task number: 3585]
	fix HQASSERT_FILE() and HQASSERT() when RELEASE_BUILD is defined
 1994-Apr-15-18:55 paulb
	[Task number: 3585]
	Use PROTO and PARAMS, not PROTOMIXED
 1994-Apr-14-16:29 paulb
	Created in standard
*/

/* hqassert.h
 * ==========
 *
 * Harlequin standard "assert" and "trace" macros.
 *
 * Paul Butcher, 94/4/12.
 */

#ifndef __HQASSERT_H__ /* { */
#define __HQASSERT_H__

#ifdef __cplusplus /* { */
extern "C" {
#endif /* } */

#define HQASSERT_NOT(fCondition, pszMessage) \
 HQASSERT( !(fCondition), (pszMessage) )

#if ! defined( ASSERT_BUILD ) /* { */

#define HQASSERT(fCondition, pszMessage) EMPTY_STATEMENT()
#define HQFAIL(pszMessage) EMPTY_STATEMENT()
#define HQASSERT_EXPR(fCondition, pszMessage, value)  ( value )
#define HQTRACE(fCondition, printf_style_args) EMPTY_STATEMENT()
#define HQASSERT_DEPTH 0
#define HQASSERT_FPEXCEP() EMPTY_STATEMENT()
#define HQASSERT_PTR(pPtr) EMPTY_STATEMENT()
#define HQASSERT_WPTR(pPtr) EMPTY_STATEMENT()
#define HQASSERT_LPTR(pPtr) EMPTY_STATEMENT()
#define HQASSERT_DPTR(pPtr) EMPTY_STATEMENT()

#else /* } { ASSERT_BUILD */

extern uint32 hqassert_val;

#define HQASSERT_VAL 0x01dead10

/* Platform independent Assert and Trace functions.
 */
extern void HqAssert PROTO(
    (char *pszFilename, int nLine, char *pszMessage));
extern void HqTraceSetFileAndLine PROTO(
    (char *pszFilename, int nLine));
#ifdef STDARGS /* { */
extern void HqTrace PROTO((char *pszMessage, ...));
#else  /* } { */
extern void HqTrace();
#endif /* } */


/* If HQASSERT_LOCAL_FILE is defined, then the HQASSERT_FILE() macro should
 * be "called" to define a static local variable containing the name of the
 * current file. This allows space used for static strings to be minimised
 * for compilers that don't support string pooling.
 */
#ifdef HQASSERT_LOCAL_FILE /* { */

#define HQASSERT_FILENAME hqassert_you_havent_called_HQASSERT_FILE
#define HQASSERT_FILE() static char HQASSERT_FILENAME[] = __FILE__

#else  /* } { !HQASSERT_LOCAL_FILE */

#define HQASSERT_FILENAME __FILE__

#endif /* } !HQASSERT_LOCAL_FILE */


/* HQFAIL, HQASSERT
 * ================
 *
 * HQFAIL calls the HqAssert function 
 *
 * Typically this will interrupt the execution of the program and
 * display a message to the user.
 *
 * HQASSERT evaluates its first argument and calls HQFAIL if it is FALSE.
 * 
 */

#ifdef HQASSERT_NO_MESSAGES /* { */

#define HQFAIL(pszMessage)  \
        (HqAssert(HQASSERT_FILENAME, __LINE__, NULL))

#else /* } { HQASSERT_NO_MESSAGES */

#define HQFAIL(pszMessage)  \
  (HqAssert(HQASSERT_FILENAME, __LINE__, (pszMessage)))

#endif /* } HQASSERT_NO_MESSAGES */


#define HQASSERT(fCondition, pszMessage) MACRO_START \
    if (!((fCondition)&&(hqassert_val==HQASSERT_VAL))) HQFAIL(pszMessage); \
MACRO_END


/* HQASSERT_EXPR
 * =============
 *
 * An assert mechanism that can be used in an expression context
 *
 * The first test gives a run-time warning if fCondition is FALSE.
 * The second line may give a compile time error or warning or nothing depending
 * on the compiler if fCondition is FALSE.
 * 
 */

#define HQASSERT_EXPR(fCondition, pszMessage, value) \
( \
  (void)( ( fCondition ) ? 0 : ( HQFAIL(pszMessage), 0 ) ) \
  , (void)( 0 / ( ( fCondition ) ? 1 : 0 ) ) \
  , ( value ) \
)


/* HQTRACE
 * =======
 *
 * Evaluates its first argument - if it is TRUE (non-zero), calls the
 * HqTrace function. The second argument should be a printf-style
 * parameter list (including brackets), e.g.
 *
 *    HQTRACE(TRUE, ("Something went wrong - code %d", 42));
 *
 * Typically this will output the message to the user, but will not
 * interrupt the execution of the program (i.e. it should be used for
 * informational messages).
 */

#define HQTRACE(fCondition, printf_style_args) MACRO_START \
    if((fCondition)||(hqassert_val!=HQASSERT_VAL)) { \
        HqTraceSetFileAndLine(HQASSERT_FILENAME, __LINE__); \
        HqTrace printf_style_args; \
    } \
MACRO_END


/* HQFAIL_AT_COMPILE_TIME
 * ======================
 *
 * Compile time versions of HQFAIL and HQASSERT. We need these because some
 * compilers get all upset about #error.
 *
 * This is designed to look like a variable declaration of an unknown type.
 * Hopefully this way we can get a sensible error message as well as an
 * error.
 */

#define HQFAIL_AT_COMPILE_TIME() \
    compile_time_assert this_should_give_an_error_message


/* HQASSERT_DEPTH
 * ==============
 *
 * This is the recursion level of HqAssert, and hence is zero if not within
 * an assert.
 */

#define HQASSERT_DEPTH HqAssertDepth()

extern int32 HqAssertDepth( void );


/* HQASSERT_FPEXCEP
 * ================
 *
 * Macro to prod any pending fp exceptions on Win32 Intel platforms.
 */
#define HQASSERT_FPEXCEP()  EMPTY_STATEMENT()

#ifdef WIN32 /* { */
#ifndef ALPHA /* { */

#undef HQASSERT_FPEXCEP
#define HQASSERT_FPEXCEP() \
MACRO_START \
  double  xyzzy = 0.0; \
  double  plover = xyzzy + 1.0; \
  xyzzy = plover; \
MACRO_END

#endif /* } !ALPHA */
#endif /* } WIN32 */


/* HQASSERT_[L|W]PTR
 * =================
 *
 * Asserts the validity of a pointer - both against NULL and an obviously
 * bad address. Won't catch everything, but it's a start.
 * I KNOW I'm casting a pointer to int32, but all I want is the bottom
 * few bits to test for the appropriate word alignment. WPTR is for word
 * alignment, LPTR for longword and DPTR for double...
 */

#define HQASSERT_PTR( pPtr ) MACRO_START \
  HQASSERT(( pPtr ) != NULL , #pPtr " NULL" ) ; \
MACRO_END

#define HQASSERT_WPTR( pPtr ) MACRO_START \
  HQASSERT((( pPtr ) != NULL ) && (((( int32 )( pPtr )) & 0x01  ) == 0 ) , \
              #pPtr " NULL or invalid" ) ; \
MACRO_END

#define HQASSERT_LPTR( pPtr ) MACRO_START \
  HQASSERT((( pPtr ) != NULL ) && (((( int32 )( pPtr )) & 0x03 ) == 0 ) , \
              #pPtr " NULL or invalid" ) ; \
MACRO_END

#define HQASSERT_DPTR( pPtr ) MACRO_START \
  HQASSERT((( pPtr ) != NULL ) && (((( int32 )( pPtr )) & 0x07 ) == 0 ) , \
              #pPtr " NULL or invalid" ) ; \
MACRO_END


#endif /* } ! ASSERT_BUILD */

#ifndef HQASSERT_FILE /* { */
/* We must have something in this declaration since there will */
/* be a semi-colon after the "call" in the source */
#define HQASSERT_FILE() extern void HQASSERT_FILE_dummy PROTO((void))
#endif /* } !HQASSERT_FILE */

#ifdef __cplusplus /* { */
}
#endif /* } */

#endif /* } __HQASSERT_H__ */

