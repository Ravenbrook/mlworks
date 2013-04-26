#ifndef __HQOSARCH_H__
#define __HQOSARCH_H__

/*
 * $HopeName: HQNc-standard!export:hqosarch.h(trunk.5) $
 *
 * Define a classification scheme for platforms.
 *
 * Platforms are made up of identifiers for operating system and architecture,
 * separated by COMPONENT_SEPARATOR, for instance "win_nt-pentium". Programs that run
 * on "win_32" will also run on "win_nt", so
 *
 *    platform_includes("win_32-pentium", "win_nt-pentium")
 *
 * returns a true value. If the first parameter is not one that the function
 * knows about, it will have successive  version parts stripped off in an attempt
 * to find one that is known. For instance, in the call
 *
 *    platform_includes("win_32-pentium", "win_nt_foo_bar_baz-pentium")
 *
 * the OS "win_nt_foo_bar_baz" is not known, so the function will try "win_nt_foo_bar",
 * "win_nt_foo", and finally "win_nt", which it knows. The assumption is that all these
 * operating systems are merely specialised versions of each other. If not, they should
 * be assigned different identifying strings. Architecture identifiers work the same way.
 *
 *   platform_overlaps("win_nt-all", "win-pentium")
 *
 * returns true, because the platforms overlap at operating system "win" and
 * architecture "pentium". Programs written for "win-pentium" will run on both.
 */

#define OSARCH_NAMESIZE 16
#define PLAT_NAMESIZE (2*OSARCH_NAMESIZE)

#define VERSION_SEPARATOR '_'
#define COMPONENT_SEPARATOR '-'

typedef int (PLATFORM_TEST_FN)(char *,   char *);

extern int platform_includes(char *general,   char *specific);
extern int platform_included(char *specific,  char *general);
extern int platform_overlaps(char *platform1, char *platform2);
extern int platform_identical(char *platform1, char *platform2);
extern int platform_different(char *platform1, char *platform2);

/*
 * Give the most specific code available for the current platform.
 * The result is guaranteed to fit into char[PLAT_NAMESIZE].
 */
extern void host_platform(char *result);

/*
 * $Log: hqosarch.h,v $
 * Revision 1.6  2000/12/12 11:40:32  peterg
 * [Bug #11232]
 * Up array size to cope with linux version
 *
 * Revision 1.5  1999/12/15  14:07:09  peter
 * [Bug #22725]
 * Make NAMESIZE visible externally.
 *
 * Revision 1.4  1999/12/14  10:47:26  peter
 * [Bug #22725]
 * Add platform_identical and platform_different.
 *
 * Revision 1.3  1999/11/26  16:55:57  peter
 * [Bug #22725]
 * Add a typedef for the functions.
 *
 * Revision 1.2  1999/11/18  12:46:55  peter
 * [Bug #22725]
 * Add platform_included as the converse of platform_includes,
 * so that there is a complete set of functions available for
 * passing as parameters to other functions.
 *
 * Revision 1.1  1999/10/29  16:24:13  peter
 * new unit
 * [Bug #22725]
 * new unit
 *
 */
#endif
