/*
$HopeName: HQNc-standard!src:hqstr.c(trunk.5) $
$Log: hqstr.c,v $
Revision 1.6  2001/05/02 11:45:43  deane
[Bug #160005]
Add prototype for HqStr__Test to get a clean Mac build

 * Revision 1.5  2000/10/23  09:04:11  peterg
 * [Bug #11232]
 * Get a clean build on Linux
 *
 * Revision 1.4  1996/02/28  14:05:31  richardk
 * [Bug #7487]
 * [7487] QuickHack: sparc/SunOS/gcc hasn't got satisfactory stuff in platform.h,
 *  so #if-out HqStr__Test for (sparc && gnuc)
 *
 * Revision 1.3  1996/02/27  16:59:36  richardk
 * [Bug #7487]
 * [7487] remove unused pbzNull; see [7589] for fix for memset on sparc
 *
 * Revision 1.2  1996/02/27  11:35:51  richardk
 * [Bug #7487]
 * [7487] change HqStrCopy, Trunc, to allow zero destsize (and do nothing) and
 *  to assert on enormous destsize; add test routine HqStr__Test
 *
 * Revision 1.1  1996/02/22  19:55:04  richardk
 * new unit
 * [Bug #7487]
 * [7487] new file: implement HqStrCopy and HqStrCopyTrunc
 *
*/

#include <limits.h>
#include "hqstr.h"

/* HqStrCopy
 * =========
 * Usage: 
 *    - like 'strncpy', but: 
 *         + guarantees termination of dest string; 
 *         + asserts on truncation or overlap.
 *    - arguments just like strncpy:
 *         char * HqStrCopy(char *dest, const char *src, size_t destsize);
 *    - return value is dest, just like strncpy;
 *    - remember that destsize is a SIZE, ie. the number of bytes of 
 *       storage space available at dest for the string characters and the 
 *       terminating null character.  A string of LENGTH (n) requires 
 *       storage SIZE of at least (n+1).  If destsize is zero, no bytes are 
 *       read or written; dest is returned.  Note that destsize is a 
 *       size_t, and is therefore unsigned (in ANSI-C).
 * Behaviour: 
 *    - never reads beyond src+strlen(src);
 *    - never reads beyond src+destsize-1;
 *    - always writes exactly destsize bytes to dest, including termination;
 *    - always terminates the dest string;
 *    - src string is allowed to be shorter than destsize-1: if so, extra 
 *       null characters are used to complete the dest string, until exactly 
 *       destsize bytes have been written.
 * Restrictions:
 *    - destsize must be < INT_MAX [HQASSERTed]; 
 *       (this should catch attempts to pass a negative destsize: remember 
 *       that destsize is a size_t, which is unsigned)
 *    - src string must fit in dest storage
 *       ie. destsize must be >= strlen(src)+1 [HQASSERTed]; 
 *       (if violated: the excess part of src will not get copied, and the 
 *       dest string will be a correctly terminated but truncated copy)
 *    - dest storage and src string must not overlap
 *       ie. there must be no overlap between *dest,...,*(dest+destsize-1) 
 *       and *src,...,*(src+min(destsize-1,strlen(src))) [HQASSERTed].
 *       (if violated, behaviour of strncpy undefined !)
 * Notes: 
 *    - the "null character" is by definition encoded as zero.  H&S 3/e p8.
 */
char * HqStrCopy(char *dest, const char *src, size_t destsize)
{
  char * rtn;
  if (destsize <= 0)
    return dest;
  HQASSERT( destsize < INT_MAX, "HqStrCopy: enormous destsize! (or"
            " was it negative?); acres of memory will be trampled...");
  HQASSERT( dest && src, "HqStrCopy: null pointer");
  /* NB: in the next assert, strlen(src) should be done last, only if/once 
   * other tests fail -ask richardk.  Also, the comparison of dest and src 
   * pointers is "unspecified" by ANSI-C (can return true or false) unless 
   * dest and src are in the same malloc'd array.  However, it will almost 
   * certainly correctly check for overlap on all common memory 
   * architectures.
   */
  HQASSERT( ( dest+destsize-1 < src )
         || ( src+destsize-1 < dest )
         || ( src+strlen(src) < dest )
          , "HqStrCopy: dest and src must not overlap"
          );
  rtn = strncpy(dest, src, destsize);
  HQASSERT( dest[destsize - 1] == 0, "HqStrCopy: string was truncated" );
  dest[destsize - 1] = 0;
  return rtn;
}


/* HqStrCopyTrunc 
 * ==============
 * Just like HqStrCopy, but _without_ the restriction that "src string must 
 * fit in dest storage": if src string is longer than destsize-1, the 
 * excess part of src string will not get copied, and the dest string will 
 * be a truncated copy terminated with a null character at dest+destsize-1.
 */
char * HqStrCopyTrunc(char *dest, const char *src, size_t destsize)
{
  char * rtn;
  if (destsize <= 0)
    return dest;
  HQASSERT( destsize < INT_MAX, "HqStrCopyTrunc: enormous destsize! (or"
            " was it negative?); acres of memory will be trampled...");
  HQASSERT( dest && src, "HqStrCopyTrunc: null pointer");
  /* NB: in the next assert, strlen(src) should be done last, only if/once 
   * other tests fail -ask richardk.  Also, the comparison of dest and src 
   * pointers is "unspecified" by ANSI-C (can return true or false) unless 
   * dest and src are in the same malloc'd array.  However, it will almost 
   * certainly correctly check for overlap on all common memory 
   * architectures.
   */
  HQASSERT( ( dest+destsize-1 < src )
         || ( src+destsize-1 < dest )
         || ( src+strlen(src) < dest )
          , "HqStrCopyTrunc: dest and src must not overlap"
          );
  rtn = strncpy(dest, src, destsize);
  /* --- no assert here: truncation is allowed --- */
  dest[destsize - 1] = 0;
  return rtn;
}


/* -------------------------------------------------------------- */


/* Test routine
 * ============
 * The following test may be run to exercise and verify some of the 
 * behaviour of the HqStr facilities when porting them to a new platform.  
 * There is no declaration for this function in hqstr.h, because this 
 * function is not intended to be used in released code.  To run the test, 
 * declare the function 'manually' with:
 *      extern void HqStr__Test(void);
 * and call it once.  See comments below for what the tests are supposed to 
 * check.
 */

#if ! ( defined(sparc) && defined(__GNUC__) )
void HqStr__Test(void);
void HqStr__Test(void)
{

#define BUF_SIZE 50
    char abBuf[BUF_SIZE];
    
    /* The following strings end at the embedded null character.  The four 
     * plus-signs that follow the null character should never be read or 
     * copied by HqStrCopy or HqStrCopyTrunc.
     */

#define LARGE_SIZE     40
#define LARGE_MAXLEN   LARGE_SIZE-1
    char *pbzLarge =   "nine-long character sequences 123456789\0++++";
    
#define MEDIUM_SIZE    24
#define MEDIUM_MAXLEN  MEDIUM_SIZE-1
    
#define SMALL_SIZE     5
#define SMALL_MAXLEN   SMALL_SIZE-1
    char *pbzSmall =   "tiny\0++++";

#define EMPTY_SIZE     1
#define EMPTY_MAXLEN   EMPTY_SIZE-1
    char *pbzEmpty =   "\0++++";

    static int HqStr__TestDoDangerous = FALSE;
    
    char *src, *dest;
    int i;
    
#if 1
    /* Copy and Trunc */
    /* ============== */
    
    /* Copy a Large string to a destination just big enough
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzLarge;
    dest = HqStrCopy(dest, src, LARGE_SIZE);
    HQTRACE( TRUE, ("Copy a Large string to a destination just big enough\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy a Small string to a Large destination, pad with zeroes
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzSmall;
    dest = HqStrCopy(dest, src, LARGE_SIZE);
    /* this will not have read beyond strlen(src) -- no easy way to check for this though! */
    HQTRACE( TRUE, ("Copy a Small string to a Large destination, pad with zeroes\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy an Empty string to a One-byte destination just big enough
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzEmpty;
    dest = HqStrCopy(dest, src, EMPTY_SIZE);
    HQTRACE( TRUE, ("Copy an Empty string to a One-byte destination just big enough\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy string to a zero-sized destination (should do nothing)
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzEmpty;
    dest = HqStrCopy(dest, src, 0);
    HQTRACE( TRUE, ("Copy string to a zero-sized destination (should do nothing)\n" 
                    "no-got! followby(%s) from(%s).", dest+0, src) );
    
    if (HqStr__TestDoDangerous) {
      /* BEWARE: If you 'ignore' the assert on 
       *         this test, memory will be nuked.
       */    
      /* Copy string to a NEGATIVE-SIZED destination
       */
      memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
      dest = abBuf; src = pbzSmall;
      dest = HqStrCopy(dest, src, -1);
      HQTRACE( TRUE, ("Copy string to a NEGATIVE-SIZED destination\n" 
                      "no-got! followby(%s) from(%s).", dest+0, src) );
    }
    
    /* Copy a Large string to a destination that's TOO SMALL
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzLarge;
    dest = HqStrCopy(dest, src, MEDIUM_SIZE);
    /* Asserts! (but still terminates safely, and doesn't write more than destsize bytes) */
    HQTRACE( TRUE, ("Copy a Large string to a destination that's TOO SMALL\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* CopyTrunc a Large string to a smaller destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzLarge;
    dest = HqStrCopyTrunc(dest, src, MEDIUM_SIZE);
    HQTRACE( TRUE, ("CopyTrunc a Large string to a smaller destination\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    
    /* Copy Overlapping? */
    /* ================= */
    
    /* Copy to an immediately following, but not overlapping, destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf, 'S', SMALL_SIZE-1); abBuf[SMALL_SIZE-1] = 0;
    dest = abBuf+SMALL_SIZE; src = abBuf;
    dest = HqStrCopy(dest, src, SMALL_SIZE);
    HQTRACE( TRUE, ("Copy to an immediately following, but not overlapping, destination\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy to an immediately preceding, but not overlapping, destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf+SMALL_SIZE, 'S', SMALL_SIZE-1); abBuf[SMALL_SIZE+SMALL_SIZE-1] = 0;
    dest = abBuf; src = abBuf+SMALL_SIZE;
    dest = HqStrCopy(dest, src, SMALL_SIZE);
    HQTRACE( TRUE, ("Copy to an immediately preceding, but not overlapping, destination\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy from short string to an immediately following, but not overlapping, longer destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf, 'S', SMALL_SIZE-1); abBuf[SMALL_SIZE-1] = 0;
    dest = abBuf+SMALL_SIZE; src = abBuf;
    dest = HqStrCopy(dest, src, MEDIUM_SIZE);
    HQTRACE( TRUE, ("Copy from short string to an immediately following, but not overlapping, longer destination\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy to an OVERLAPPING following destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf, 'S', SMALL_SIZE-1); abBuf[SMALL_SIZE-1] = 0;
    dest = abBuf+SMALL_SIZE-1; src = abBuf;
    dest = HqStrCopy(dest, src, SMALL_SIZE);
    /* Assert! overlapping! */
    HQTRACE( TRUE, ("Copy to an OVERLAPPING following destination\n" 
                    "got(%s) followby(%s) from-now-corrupt(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Copy to an OVERLAPPING preceding destination
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf+SMALL_SIZE, 'S', SMALL_SIZE-1); abBuf[SMALL_SIZE+SMALL_SIZE-1] = 0;
    dest = abBuf+1; src = abBuf+SMALL_SIZE;
    dest = HqStrCopy(dest, src, SMALL_SIZE);
    /* Assert! overlapping! */
    HQTRACE( TRUE, ("Copy to an OVERLAPPING preceding destination\n" 
                    "got(%s) followby(%s) from-now-corrupt(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* TruncCopy small initial portion to a destination that overlaps src string but not the portion being copied
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    memset(abBuf, 'M', MEDIUM_SIZE-1); abBuf[MEDIUM_SIZE-1] = 0;
    dest = abBuf+SMALL_SIZE; src = abBuf;
    dest = HqStrCopyTrunc(dest, src, SMALL_SIZE);
    /* Truncate as requested.  Src gets corrupted, but not our problem. */
    HQTRACE( TRUE, ("TruncCopy small initial portion to a destination that overlaps src string but not the portion being copied\n" 
                    "got(%s) followby(%s) from-now-corrupt(%s).", dest, dest+strlen(dest)+1, src) );
#endif
    
    
#if 1
    /* the check macro */
    /* =============== */
    /* ASSERTCHECK_HqStrBlat confirms that the storage sizes for two 
     * strings match, confirming that HqStrBlat between these strings will 
     * be safe.  If the sizes don't match, it should assert, but only once.
     */
    
    for (i=1; i<=2; i++) {
      ASSERTCHECK_HqStrBlat( BUF_SIZE , MEDIUM_SIZE );
      /* fails! */
      ASSERTCHECK_HqStrBlat( MEDIUM_SIZE , MEDIUM_SIZE+1 );
      /* fails! */
      ASSERTCHECK_HqStrBlat( MEDIUM_SIZE , MEDIUM_SIZE );
      /* okay */
      /* Only assert once -- second pass should be silent */
    }
#endif
    

#if 1
    /* Blat and Blind */
    /* ============== */
    
    /* Blat from a small string to small storage
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzSmall;
    dest = HqStrBlat(dest, src, SMALL_SIZE);
    HQTRACE( TRUE, ("Blat from a small string to small storage\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Blat, ILLEGALLY, from a small string to medium storage
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzSmall;
    dest = HqStrBlat(dest, src, MEDIUM_SIZE);
    /* unsafe! reads beyond strlen(src) */
    HQTRACE( TRUE, ("Blat, ILLEGALLY, from a small string to medium storage\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
    
    /* Blat, ILLEGALLY, from a large string to medium storage
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzLarge;
    dest = HqStrBlat(dest, src, MEDIUM_SIZE);
    /* unsafe! doesn't terminate copy */
    HQTRACE( TRUE, ("Blat, ILLEGALLY, from a large string to medium storage\n" 
                    "got(%s) from(%s).", dest, src) );
    
    /* CopyBlind from what happens to be a large string into what happens to be sufficient storage
     */
    memset(abBuf, '^', BUF_SIZE-1); abBuf[BUF_SIZE-1] = 0;
    dest = abBuf; src = pbzLarge;
    dest = HqStrCopyBlind(dest, src);
    /* Works, because we 'know' that strlen(pbzLarge)+1 will fit in abBuf's storage */
    HQTRACE( TRUE, ("CopyBlind from what happens to be a large string into what happens to be sufficient storage\n" 
                    "got(%s) followby(%s) from(%s).", dest, dest+strlen(dest)+1, src) );
#endif

#if 0

/* HqStr__Test should produce the following asserts and traces.
 * (Explicit file-and-line has been changed to "<in hqstr.c>")
 */

/*

<in hqstr.c>: Copy a Large string to a destination just big enough
got(nine-long character sequences 123456789) followby(^^^^^^^^^) from(nine-long character sequences 123456789).
<in hqstr.c>: Copy a Small string to a Large destination, pad with zeroes
got(tiny) followby() from(tiny).
<in hqstr.c>: Copy an Empty string to a One-byte destination just big enough
got() followby(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^) from().
<in hqstr.c>: Copy string to a zero-sized destination (should do nothing)
no-got! followby(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^) from().
Assert failed <in hqstr.c>: HqStrCopy: string was truncated
<in hqstr.c>: Copy a Large string to a destination that's TOO SMALL
got(nine-long character seq) followby(^^^^^^^^^^^^^^^^^^^^^^^^^) from(nine-long character sequences 123456789).
<in hqstr.c>: CopyTrunc a Large string to a smaller destination
got(nine-long character seq) followby(^^^^^^^^^^^^^^^^^^^^^^^^^) from(nine-long character sequences 123456789).
<in hqstr.c>: Copy to an immediately following, but not overlapping, destination
got(SSSS) followby(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^) from(SSSS).
<in hqstr.c>: Copy to an immediately preceding, but not overlapping, destination
got(SSSS) followby(SSSS) from(SSSS).
<in hqstr.c>: Copy from short string to an immediately following, but not overlapping, longer destination
got(SSSS) followby() from(SSSS).
Assert failed <in hqstr.c>: HqStrCopy: dest and src must not overlap
Assert failed <in hqstr.c>: HqStrCopy: string was truncated
<in hqstr.c>: Copy to an OVERLAPPING following destination
got(SSSS) followby(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^) from-now-corrupt(SSSSSSSS).
Assert failed <in hqstr.c>: HqStrCopy: dest and src must not overlap
<in hqstr.c>: Copy to an OVERLAPPING preceding destination
got(SSSS) followby(SSS) from-now-corrupt().
<in hqstr.c>: TruncCopy small initial portion to a destination that overlaps src string but not the portion being copied
got(MMMM) followby(MMMMMMMMMMMMM) from-now-corrupt(MMMMMMMMM).
Assert failed <in hqstr.c>: BUF_SIZE and MEDIUM_SIZE are no longer of equal magnitude; there are calls to HqStrBlat between strings with storage of these sizes, and these calls are now broken; you must use HqStrCopy instead.
Assert failed <in hqstr.c>: MEDIUM_SIZE and MEDIUM_SIZE+1 are no longer of equal magnitude; there are calls to HqStrBlat between strings with storage of these sizes, and these calls are now broken; you must use HqStrCopy instead.
<in hqstr.c>: Blat from a small string to small storage
got(tiny) followby(^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^) from(tiny).
<in hqstr.c>: Blat, ILLEGALLY, from a small string to medium storage
got(tiny) followby(++++) from(tiny).
<in hqstr.c>: Blat, ILLEGALLY, from a large string to medium storage
got(nine-long character sequ^^^^^^^^^^^^^^^^^^^^^^^^^) from(nine-long character sequences 123456789).
<in hqstr.c>: CopyBlind from what happens to be a large string into what happens to be sufficient storage
got(nine-long character sequences 123456789) followby(^^^^^^^^^) from(nine-long character sequences 123456789).

*/

#endif

}
#endif


/* eof */
