/*
$HopeName: HQNc-standard!export:hqstr.h(trunk.1) $
$Log: hqstr.h,v $
Revision 1.2  1996/02/27 11:36:24  richardk
[Bug #7487]
[7487] change HqStrCopy, Trunc, to allow zero destsize (and do nothing) and
 to assert on enormous destsize

 * Revision 1.1  1996/02/22  19:54:32  richardk
 * new unit
 * [Bug #7487]
 * [7487] new file: product-independent Harlequin C-String Utilities
 *
*/

#ifndef __HQSTR_H__
#define __HQSTR_H__

/*
 *
 *              HARLEQUIN C-STRING UTILITIES
 *              ============================
 *
 */


#include "std.h"  /* strncpy */


/* To Copy Strings
 * ===============
 * Usually: (when you know the size of the destination storage)
 *  - HqStrCopy: use to copy strings (asserts if truncated);
 *  - HqStrCopyTrunc: when you want strings silently truncated to fit;
 *  - HqStrBlat: faster, when you _know_ that the dest storage is the 
 *     same size as the src storage.
 *
 * When you don't know, or don't care to check against, the size of 
 * the destination storage:
 *  - HqStrCopyBlind: faster than HqStrCopy, but slower than HqStrBlat.
 */

/* HqStrCopy
 * ---------
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
char * HqStrCopy(char *dest, const char *src, size_t destsize);

/* HqStrCopyTrunc
 * --------------
 * Just like HqStrCopy, but _without_ the restriction that "src string must 
 * fit in dest storage": if src string is longer than destsize-1, the 
 * excess part of src string will not get copied, and the dest string will 
 * be a truncated copy terminated with a null character at dest+destsize-1.
 */
char * HqStrCopyTrunc(char *dest, const char *src, size_t destsize);

/* HqStrBlat 
 * ---------  
 * Usage: 
 *    - to copy strings which you know have the same underlying storage 
 *       size;
 *    - arguments just like strncpy:
 *         char * HqStrBlat(char *dest, const char *src, size_t destsize);
 *    - return value is dest, just like strncpy;
 * Behaviour: 
 *    - assumes that the src storage is the same size as the dest storage; 
 *       it just does a memcpy.
 * Restrictions:
 *    - unless the src and dest storage are actually the same type, you 
 *       should assert your assumption that they are the same size by using 
 *       the ASSERTCHECK_HqStrBlat macro in some code you run at least 
 *       once.
 */
#define HqStrBlat( _dest_ , _src_ , _destsize_ ) \
  ( (char*)memcpy \
            ( ((void*)(_dest_)) , ((const void*)(_src_)) , (_destsize_) ) )
#define ASSERTCHECK_HqStrBlat( _size1_ , _size2_ ) \
  MACRO_START \
  static int already_asserted = FALSE; \
  static char assert_msg[] = #_size1_ " and " #_size2_ " are no longer of" \
  " equal magnitude; there are calls to HqStrBlat between strings with" \
  " storage of these sizes, and these calls are now broken; you must" \
  " use HqStrCopy instead."; \
  HQASSERT( already_asserted || (_size1_)==(_size2_), assert_msg); \
  already_asserted = TRUE; \
  MACRO_END

/* HqStrCopyBlind
 * --------------
 * Usage: 
 *    - Don't use it if you can avoid it!
 *       It is not a 'robust' function -- you should know how long your 
 *       dest storage is, and use HqStrCopy instead;
 *    - just assumes that the src string is terminated, and will fit in the 
 *       dest storage; it just does a strcpy;
 *    - arguments just like strcpy:
 *         char * HqStrCopyBlind(char *dest, const char *src);
 */
#define HqStrCopyBlind( _dest_ , _src_ ) \
  ( strcpy( (_dest_) , (_src_) ) )



#endif  /* __HQSTR_H__ */
