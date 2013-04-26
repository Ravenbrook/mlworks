/*
$Log: osprotos.h,v $
Revision 1.51  2002/01/09 10:01:26  miker
[Bug #24702]
Omit lseek prototype for Mac OS X too

Revision 1.50  2001/01/18  13:21:14  peterg
[Bug #11473]
Fix again, this time for Solaris

Revision 1.49  2000/12/07  12:05:32  peterg
[Bug #11232]
Add caddr_t definition for linux

Revision 1.48  2000/11/24  14:08:09  miker
[Bug #23773]
Port for Mac OS X

Revision 1.47  2000/10/27  10:52:53  peterg
[Bug #11232]
Get a clean build on Linux

Revision 1.46  2000/10/23  09:06:21  peterg
[Bug #11232]
Get a clean build on Linux

Revision 1.45  1998/10/27  13:26:57  tina
[Bug #30412]
Include strings.h and bstring.h for SGI4K6

Revision 1.44  1998/09/17  10:06:38  luke
[Bug #30340]
windows has lseek and strtol defined in its
header files

Revision 1.43  1998/03/11  12:20:57  davidg
[Bug #21435]
move #pragma intrinsic for Alpha WIN32 builds to remove compiler warnings
when compiling with +n

Revision 1.42  1997/04/24  22:33:09  mamye
[Bug #20127]
if def off_t lseek define, it is already defined in _unistd.h
done only for SGI4K6

Revision 1.41  1996/08/05  12:55:17  garethc
[Bug #7930]
Remove __MRC__ #ifdefs.

Revision 1.40  1996/07/17  10:09:07  garethc
[Bug #7930]
if MrC include fcntl.h for off_t

Revision 1.39  1996/06/27  18:29:44  freeland
[Bug #8103]
Adding USE_SYSTEM_BCOPY_PROTO, because otherwise gcc complains that ours are
different than the system's (which are, IMHO, more accurate) on Linux

Revision 1.38  1996/03/08  14:43:46  richardk
[Bug #7589]
[7589] for platforms without ANSI_OSPROTOS, declare memset et al from ANSI string.h
 (ostensibly to fix sparc compile hiccups on hqstr.c, but sparc's platform.h
 entries lie and claim it has ANSI_OSPROTOS)

Revision 1.37  1996/01/22  14:53:50  andy
[Bug #7410]
Add prototypes for some new math functions
floor, ceil, fmod, ldexp, modf.

Revision 1.36  1994/10/20  18:39:00  sarah
[Bug #4430]
Tadpole does not define CLOCKS_PER_SECOND!

Revision 1.35  1994/07/25  08:53:22  luke
Bug 4067: change USEPRINTF flag to HAS_PRINTF_PROTO

Revision 1.34  1994/07/19  18:25:45  angus
Move prototypes of printf and vprintf from hqassert.c to osprotos.h,
which is a more sensible place for them.

Revision 1.33  1994/06/22  08:25:02  davidg
define bcopy(), bcmp and bzero() in terms of mem*() functions
for Algorithmics idtr30xx library support on Kanji Harpoon

Revision 1.32  1994/06/19  08:55:59  freeland
-inserting current code, with Log keyword and downcased #includes

 1994-Apr-21-02:20 davidg
	[Task number: 3616]
	change definitions for idtr30xx machine type to not assume UNIX is
	defined
 1993-Dec-16-11:36 davidg
	[Bug number: 3215] add declaration for strtol()
 1993-Apr-21-18:01 davide
	comment syntax
 1993-Apr-21-18:00 davide
	requires size_t in strn... functions
 1993-Feb-11-10:18 john
	off_t lseek doesn't work on RS6000 (probably because it's a pile of
	junk and can't even read it's own /usr/include files without
	complaining)
 1993-Jan-28-16:07 sarah
	Get rid of readdir definition except when really on a tadpole
1992-Oct-26-11:19 derekk = Include strings.h if not ANSI
1992-Sep-29-16:53 paulb = Whoops once more - no "#"
1992-Sep-29-16:48 paulb = Whoops - put <time.h> in the wrong place
1992-Sep-29-14:39 paulb = Add <time.h>
1992-Sep-10-17:09 richardk = oops, recover change history
1992-Sep-10-16:59 richardk = hppa spits at #error, ifd or not
1992-Sep-10-16:49 richardk = included from std.h ONLY, ANSI_OSPROTOS (now for
1992-Sep-10-16:49 richardk + mac too), plus lseek, bzero/copy.
1992-Sep-3-21:59 harry = Why the FUCK didn't this include proto.h???
1992-Sep-3-16:38 paulb = Add process.h for WIN32
1992-Sep-3-16:13 paulb = Add direct.h under WIN32
1992-Sep-2-18:47 paulb = Add WIN32
1992-May-13-15:47 john = hack out the warnings about readdir on T188 (fix to
1992-May-13-15:47 john + previous attempt)
1992-May-13-15:37 john = hack out the warnings about readdir on T188
1992-May-6-17:45 richardk = sys/types.h: MAC now uses StdDef.h
1992-May-6-14:35 richardk = sys/types.h not platfm indep! Now ifdef'd for
1992-May-6-14:35 richardk + U**X only
1992-Apr-30-17:19 paulh = Include string.h, math.h for ANSI systems
1992-Apr-29-11:42 john = remove redeclaration of malloc
1992-Apr-28-23:02 paulh = Include stdlib.h on snakes, too.
1992-Apr-28-22:56 paulh = Fix typo
1992-Apr-28-22:53 paulh = Add lseek, realloc. Stop using OSAddr, just
1992-Apr-28-22:53 paulh + duplicate prototypes.
1992-Apr-28-22:42 paulh = Use ADDR_IS_VOID_PTR to define a type OSAddr. Use
1992-Apr-28-22:42 paulh + the type for malloc
1992-Apr-28-22:08 paulh = Change strlen to return size_t, include sys/types.h
1992-Apr-28-22:08 paulh + for size_t
1992-Apr-28-21:49 paulh = bcmp doesn't return void!
1992-Apr-28-21:45 paulh = Created

*/
/* Define prototypes for "standard" functions */
#ifndef STD_H
"osprotos.h is internal to the standard component and should only be included by std.h" :-)
#else  /* STD_H - ie. std.h has (correctly) already been included */

#ifndef HAS_PRINTF_PROTO
/* On some machines, no system header files contain prototypes for printf and
   vprintf. These are here in the hope that sometime someone will sort out a
   consistent set of prototypes for all machines on which we develop code. If
   there are problems with these prototypes, add a define to platform.h to say
   where they are needed (sparc-sunos4, for one) */
extern int printf PROTO((const char*, ...));
extern int vprintf PROTO((const char *, char * ));
#endif

#ifdef ANSI_OSPROTOS


#include <stdlib.h>
#include <string.h>
#include <math.h>

#if defined(WIN32)
#if defined(_ALPHA_)
#pragma intrinsic(memcpy)
#pragma intrinsic(memmove)
#pragma intrinsic(memset)
#endif /* defined(_ALPHA_) */
#include <io.h>
#include <direct.h>
#include <process.h>
#endif

#if defined(UNIX) || defined(IBMPC) || defined(WIN32) || defined(idtr30xx) || defined(MACOSX)
#include <sys/types.h>
#else
/* for lseek you will need to define off_t in platform.h */
#endif


#else  /* ! ANSI_OSPROTOS */


#include <strings.h>

#if defined(UNIX) || defined(IBMPC) || defined(WIN32) || defined(idtr30xx)
#include <sys/types.h>
#else
/* you will need to define off_t and size_t (in platform.h) */
#endif

#ifdef ADDRESS_IS_VOID_PTR
extern void *	malloc PROTO((size_t));
extern void *	realloc PROTO((void *, size_t));
#else
extern char *	malloc PROTO((size_t));
extern char *	realloc PROTO((char *, size_t));
#endif

extern void	exit PROTO((int));

extern char *	strcat PROTO((char *s1, const char *s2));
extern int	strcmp PROTO(( char *s1, const char *s2));
extern char *	strcpy PROTO((char *s1, const char *s2));
extern size_t	strlen PROTO((const char *s));
extern char *	strncat PROTO((char *s1, const char *s2, size_t n));
extern int	strncmp PROTO(( char *s1, const char *s2, size_t n));
extern char *	strncpy PROTO((char *s1, const char *s2, size_t n));
extern void *   memchr PROTO((const void *ptr, int val, size_t len));
extern int      memcmp PROTO((const void *ptr1, const void *ptr2, size_t len));
extern void *   memcpy PROTO((void *dest, const void *src, size_t len));
extern void *   memmove PROTO((void *dest, const void *src, size_t len));
extern void *   memset PROTO((void *ptr, int val, size_t len));
extern int	abs PROTO((int));
extern double	fabs PROTO((double));
extern double	sqrt PROTO((double));
extern double	sin PROTO((double));
extern double	cos PROTO((double));
extern double	tan PROTO((double));
extern double	atan PROTO((double));
extern double	atan2 PROTO((double, double));
extern double	pow PROTO((double, double));
extern double	log PROTO((double));
extern double	log10 PROTO((double));

extern double	floor PROTO((double _x)); 
extern double	ceil PROTO((double _x));
extern double	fmod PROTO((double _x,double _y));
extern double	ldexp PROTO((double _x,int _n));
extern double	modf PROTO((double _x, double *_ip));


#endif  /* ! ANSI_OSPROTOS */


/* Many, some or fewer platforms will need the following, unless they're */
/* RS6000s: */
/* These may break duplicate standard declarations on some platforms,
 * including Win32, Linux, Solaris... */
#if ! ( defined(rs6000) || defined(SGI4K6) || defined(WIN32) || defined(linux) || defined(Solaris) || defined(MACOSX) )
extern off_t lseek PROTO((int filedes, off_t offset, int whence));
#endif

#if defined(SGI4K6)
/* Irix 6.3 has these prototypes in bstring.h
 * From Irix 6.4 onwards they are included in strings.h
 * Include them both here, because strings.h is included by
 * the X header files, and this causes a clash for Irix 6.4 onwards
 */
#include <strings.h>
#include <bstring.h>
#else /* ! SGI4K6*/
#ifdef linux

/* Need to make sure we get these prototypes correct, since gcc is very
 * picky, and we don't get them by just including string.h, since they
 * are not ANSI/POSIX. */
#ifdef __cplusplus
extern "C" {
#endif
extern void	bcopy __P ((__const __ptr_t __src, __ptr_t __dest, size_t __n));
extern int	bcmp __P ((__const __ptr_t __s1, __const __ptr_t __s2, size_t __n));
extern void	bzero __P ((__ptr_t __s, size_t __n));
#ifdef __cplusplus
}
#endif

#else
#if defined (MACOSX)

/* Defined in string.h, inside #ifndef _ANSI_SOURCE.
 * Duplicated here
 */
int	 bcmp __P((const void *, const void *, size_t));
void	 bcopy __P((const void *, void *, size_t));
void	 bzero __P((void *, size_t));

#else
extern int	bcmp PROTO((char *b1, char *b2, int length));
extern void	bcopy PROTO((char *b1, char *b2, int length));
extern void	bzero PROTO((char *b, int length));
#endif /* ! MACOSX */
#endif /* ! linux */
#endif /* ! SGI4K6*/

#ifdef idtr30xx
#include <string.h>
#define bcopy(b1, b2, len) (void)memmove(b2, b1, (size_t)(len))
#define bzero(b, len)      (void)memset(b, 0, (size_t)(len))
#define bcmp(b1, b2, len)  memcmp(b1, b2, (size_t)(len))
#endif /* idtr30xx */

#if ! (defined(WIN32) || defined(linux))
/* Windows needs a __declspec(dllimport) in this declaration */
extern long	strtol PROTO((const char *str, char **ptr, int base));
#endif


#ifdef T188
#ifndef mc88100
extern struct direct *readdir();
#endif
#endif

#ifndef CLOCKS_PER_SEC
#include <time.h>

#ifdef T188
#ifndef mc88100
#define CLOCKS_PER_SEC CLK_TCK
#endif
#endif

#endif /* ndef CLOCKS_PER_SEC */


/*
 * Linux has some definitions protected by BSD_SOURCE and SVID_SOURCE.
 * To avoid having to define one of these in the source files concerned,
 * just repeat the troublesome definitions here:
 */
#ifdef linux

#ifndef __USE_BSD
typedef __caddr_t caddr_t;
#define S_ISUID  __S_ISUID
#define S_ISGID  __S_ISGID
#define S_ISVTX  __S_ISVTX
#define S_IREAD  __S_IREAD
#define S_IWRITE __S_IWRITE
#define S_IEXEC  __S_IEXEC
#endif

#endif /* linux */

#endif  /* STD_H */
