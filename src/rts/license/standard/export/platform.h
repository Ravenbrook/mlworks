#ifndef __PLATFORM_H__
#define __PLATFORM_H__

#if 0 /* please leave this comment block #ifed out - thanks */
/*  
$Log: platform.h,v $
Revision 1.134  2002/06/20 12:33:39  tina
[Bug #24428]
comment out CLOCKS_PER_SEC for linux to avoid multiple defines

Revision 1.133  2002/01/30  14:42:52  miker
[Bug #24836]
Remove Mac OS X platform code

Revision 1.132  2001/06/11  13:17:09  miker
[Bug #24259]
Add Mac OS X platform codes

Revision 1.131  2001/01/18  13:21:14  peterg
[Bug #11473]
Only define SOLARIS_THREADS if POSIX_THREADS is not already defined

Revision 1.130  2000/11/24  14:08:11  miker
[Bug #23773]
Don't need to define off_t for Mac OS X

Revision 1.129  2000/10/23  09:07:19  peterg
[Bug #11232]
Get a clean build on Linux

Revision 1.128  2000/05/03  11:16:38  jamesr
[Bug #23148]
define SOLARIS_THREADS macro where appropriate

Revision 1.127  2000/02/14  11:43:18  luke
[Bug #22983]
SGI does warn about unused params

Revision 1.126  1998/10/13  16:56:10  jamesr
[Bug #30340]
define HAS_PRINTF_PROTO for CC on SGI4K6

Revision 1.125  1998/10/08  16:59:39  jamesr
[Bug #30340]
define NO_PTHREADS for early SGI platforms

Revision 1.124  1998/09/17  10:32:41  nickr
[Bug #21817]
Define NO_UNICODE for SGI4K5 and SGI5

Revision 1.123  1998/03/11  12:20:54  davidg
[Bug #21435]
move #pragma intrinsic for Alpha WIN32 builds to remove compiler warnings
when compiling with +n

Revision 1.122  1998/01/08  16:59:56  jonw
[Bug #20913]
Work on the memory copying rationale for each platform - in some cases
making the v20 optimisations available to all compounds, in others choosing
sytem or standard routines because they perform better. Also clearing up the
issue of overlap safety.

Revision 1.121  1997/12/04  17:37:08  luke
[Bug #30261]
SGI4K6 also has ualarm.

Revision 1.120  1997/11/18  17:40:49  luke
[Bug #30261]
Solaris _does_ have ualarm; remove the NO_UALARM define

Revision 1.119  1997/06/17  10:04:41  luke
[Bug #20600]
define a platform ID which does not include the multi-processing capability

Revision 1.118  1997/04/09  23:08:25  mamye
[Bug #20127]
Change to HAS_DLOPEN if SGI4K6 class, LDOPEN not supported in
SGI 6.x (libmld.a no longer available in /lib32)

Revision 1.117  1997/01/22  14:47:24  richardk
[Bug #10006]
[10006] warnings reduction: policy on PowerMac is for releasebuilds to turn
 off unused-param warnings (MrC -w 35), and have the UNUSED_PARAM macro
 expand to nothing.
 So: define NO_DUMMYPARAM.

Revision 1.116  1996/11/28  16:00:28  dtb
[Bug #10015]
Fixing warning messages 10015
Only turn on system prototype if the build is not Solaris and
not UltraSparc

Revision 1.115  1996/11/19  20:53:13  mamye
[Bug #8497]
fix ifndeftypo in ultrasparc stuff

Revision 1.114  1996/11/19  17:38:46  mamye
[Bug #8497]
Ultrasparc does not NEED_SYSTEM_PROTOTYPE

Revision 1.113  1996/09/02  10:57:09  cindy
[Bug #8419]
define HAS_PRAGMA_UNUSED for MrC

Revision 1.112  1996/08/05  12:55:20  garethc
[Bug #7930]
Remove __MRC__ #ifdefs.

Revision 1.111  1996/07/17  10:03:12  garethc
[Bug #7930]
If not MrC define off_t.

Revision 1.110  1996/06/28  16:57:09  hugo
[Bug #8014]
Change to bitsgoleft for arm200 architecture; this makes it much
easier to check with a previewer that the right PGBs are generated.

Revision 1.109  1996/06/27  18:29:51  freeland
[Bug #8103]
Adding a block for linux

Revision 1.108  1996/06/17  12:56:53  angus
[Bug #6715]
Remove includes of machine.h

Revision 1.107  1996/06/12  11:43:35  hugo
[Bug #8014]
Support experimental ARM port (called ARM200 from tools version) of JAC.

Revision 1.106  1995/11/10  14:55:10  luke
[Bug #6915]
add CLOCKS_PER_SEC for sparc because it doesn't define it

Revision 1.105  1995/10/20  16:50:01  luke
[Bug #6840]
turn HAS_DLOPEN on for the SGI5

Revision 1.104  1995/10/13  19:06:22  angus
[Bug #6584]
Add pragmas and defines for inline memcpy and memset, and make sure Unix
Alpha knows to check atan2 arguments

Revision 1.103  1995/08/30  14:09:41  nickr
[Bug #6390]
allow comp on SGI needed for system header files

Revision 1.102  1995/07/06  20:16:46  dstrauss
[Bug #4569]
Move MSVC pragma to disable warning 4127 to warnings.h.

Revision 1.101  1995/06/20  15:27:27  nickr
[Bug #6022]
if USE_TRADITIONAL is defined the define VARARGS else define STDARGS

Revision 1.100  1995/02/24  11:19:43  hugo
[Bug #4569]
Add platform dependent NEEDS_SYSTEM_PROTOTYPE for beaver/sparc/sun4
and use it in fileops.c, where system is called.

Revision 1.99  1995/02/10  17:08:48  paulb
[Bug #5003]
Add P_WINNT_PARALLEL

Revision 1.98  1995/02/01  12:22:35  nickr
[Bug #4779]
add PLATFORM_OS and PLATFORM_MACHINE

Revision 1.97  1995/01/10  17:43:43  derekl
[Bug #4767]
Add PowerPC platform.

Revision 1.96  1994/12/13  18:39:00  bart
[Bug #4569]
keep VARARGS from being defined for SGI with ANSI c (ugly).

Revision 1.95  1994/12/13  17:48:43  bart
[Bug #4569]
Add new symbol for SGI to avoid warnings from PRAGMA_UNUSED workaround.

Revision 1.94  1994/11/30  19:04:53  dstrauss
[Bug #4569]
Warnings reduction - use pragma to turn off "conditional expression
is a constant" warning from MSVC compiler.

Revision 1.93  1994/11/30  18:05:52  sarah
[Bug #4569]
Protect against multiple inclusions.

Revision 1.92  1994/11/07  18:24:27  tina
[Bug #4532]
Add define for SELECT_IS_BROKEN for clipper

Revision 1.91  1994/10/26  14:56:32  davidg
[Bug #4495]
support SDE-MIPS 2.0 release for Kanji Harpoon
remove default assumption that UNIX means VARARGS
allow all asserts to include messages by default for Kanji Harpoon

Revision 1.90  1994/09/24  16:20:10  richardk
[4257] repl P_MACINTOSH by new name for Mac68K platform: P_MAC68K

Revision 1.89  1994/09/21  13:18:34  angus
[Bug #4319]
Add HAS_PRINTF_PROTO for RS6000

Revision 1.88  1994/09/05  17:05:14  richardk
[2306] PowerMac: define P_ platform; no pragma_unused, promoted_real is double, not extended; both Mac68K and PowerMac REQUIRE universal headers (else break at compile)

Revision 1.87  1994/08/25  11:39:57  paulb
[Bug #4161]
[Bug #4161]
Define MULTIDBG_TO_FILE under NT

Revision 1.86  1994/08/05  15:37:37  luke
Task 4065: add HAS_PRINTF_PROTO for solaris

Revision 1.85  1994/07/28  12:27:38  nickr
define HAS_PRINTF_PROTO for mc88100

Revision 1.84  1994/07/25  14:39:51  steveb
[Bug 3929] Get rid of STRUCT_ASSIGN.

Revision 1.83  1994/07/25  08:54:36  luke
Bug 4067: add HAS_PRINTF_PROTO define

Revision 1.82  1994/06/19  09:12:20  hope
Propagating changes made by Nick Levine in "toy" HOPE.
[-fka3]

 * Revision 1.80  1994/05/28  01:51:43  davidg
 * add debug control of HQASSERT_NO_MESSAGES to reduce memory consumption
 * on "normal" Kanji Harpoon compilations
 *
 * Revision 1.79  1994/05/18  12:55:56  nick
 * discriminate correctly between MIPS MIPS and DEC MIPS
 *
 * Revision 1.78  1994/05/18  12:44:25  nick
 * discriminate on ultrix_mips flag
 *
 * Revision 1.77  1994/05/17  21:48:29  freeland
 * -inserting current code, with Log keyword and downcased #includes
 *
 1994-May-5-11:16 davidg
	[Task number: 3616]
	correct the byte ordering for idtr30xx - we will be running it in
	big-endian mode for Kanji Harpoon
 1994-Apr-21-02:15 davidg
	[Task number: 3616]
	change definitions for idtr30xx machine type to use STDARGS rather
	than VARARGS by not assuming UNIX is defined
 1994-Apr-16-02:31 davidg
	[Task number: 3616]
	add definitions for idtr30xx architecture for Kanji Harpoon
 1994-Apr-14-19:33 luke
	[Task number: 3153]
	the SGI IRIX 5.x uses HAS_DLOPEN
 1994-Feb-24-16:31 peng
	[Task number: 1656]
	turn off Unaligned_32bit_access for alpha
 1994-Jan-18-15:51 luke
	[Bug number: 1300] add RESETSIGNALS for the snake
 1993-Dec-6-09:34 luke
	[Bug number: 3153] add platform defines for statfs and statvfs
 1993-Nov-29-14:13 luke
	add LACKING_GETWD for Solaris
 1993-Nov-26-18:28 angus
	Fix 3060; Alpha RIP floating exceptions
 1993-Nov-9-18:00 jez
	Fix for MIPS NT build - The define "mips" is used for other
	mips platforms, so ignore it if _MIPS_ is defined
 1993-Nov-9-17:35 jez
	Add in MIPS NT support
 1993-Sep-8-07:47 john
	resetsignals on Solaris, also no_ualarm
 1993-Sep-7-12:49 john
	NO_STAT_NAME_LEN on solaris
 1993-Aug-20-14:21 robs
	Add platform dependency into dongle
 1993-Jun-11-18:25 davide
	still wrong on mc88... - need a separate flag DIRECT_READDIR
 1993-Jun-11-14:27 davide
	sort out BSD_READDIR (-> platform) for tadpole/mc88...
 1993-Jun-8-12:56 john
	fix problem introduced for SGIs on previous change
 1993-Jun-7-20:20 john
	make it work on clipper
 1993-Jun-4-11:27 john
	make it work on clipper
 1993-May-10-15:41 chrism
	add I960 definition
 1993-May-4-18:16 john
	put CLIPPER stuff in
 1993-Apr-8-17:18 paulb
	Switch on Unaligned_32but_access for the PC
 1993-Mar-12-17:09 paulb
	Add USE_PROTOTYPES_MIXED for IBMPC and WIN32
 1993-Mar-3-15:36 paulh
	Remove nested comments (harmless since all #ifdef'd out, but provoked
	a gcc warning)
 1993-Jan-28-16:07 sarah
	Introduce mc88100
1993-Jan-25-10:49 john = back off previous change and see what I get
1993-Jan-22-13:15 john = try to get it to compile on the RS6000 electronic
1993-Jan-22-13:15 john + pig (typedef of off_t to long doesn't bring back the
1993-Jan-22-13:15 john + bacon)
1993-Jan-22-11:36 john = try to get it to compile on the RS6000
1993-Jan-6-17:14 harry = Gitto.
1993-Jan-6-17:05 harry = Aha! SGI actually *needs* mips!!!
1992-Dec-3-13:47 andy = add in alpha defs
1992-Dec-3-13:39 andy = add in alpha defs
1992-Dec-3-13:37 andy = add in alpha defs
1992-Nov-25-22:39 john = only use waitpid if available, else use wait
1992-Nov-4-16:50 derekk = WATCOM compiler bug - can't initialise a FAR
1992-Nov-4-16:50 derekk + pointer except to NULL
1992-Nov-4-15:20 derekk = Change _far to far
1992-Nov-4-14:37 paulb = Delete <windows.h>, insert defn. of FAR
1992-Nov-3-18:53 derekk = Add windows.h for win3.1 products
1992-Oct-16-12:59 john = platform dependent thingy: getwd
1992-Oct-15-10:54 faruk = add ADDRESS_IS_VOID_PTR for the rs6000
1992-Sep-28-13:14 davidg = add PID_TYPE (really should be POSIX-dependant)
1992-Sep-24-13:49 harry = Add SIGNALTYPE for SGI.
1992-Sep-24-09:06 richardj = Add define for dynamic loading on SGI
1992-Sep-23-11:37 hugo = Add off_t for AMD29K
1992-Sep-23-11:34 hugo = Add off_t for AMD29K
1992-Sep-23-10:55 hugo = Add off_t for AMD29K
1992-Sep-11-12:51 paulb = WIN32 ==> ANSI_SUPER
1992-Sep-11-09:08 richardj = Add defines for dynamic code loading
1992-Sep-10-18:29 hugo = Aha!  SGI also defines mips.
1992-Sep-10-18:10 hugo = Claims SGI defines both {high,low}bytefirst, so
1992-Sep-10-18:10 hugo + undef it.
1992-Sep-10-16:47 richardk = ANSI_SUPER, const and signed, checking one of
1992-Sep-10-16:47 richardk + STD/VARARGS, also HIGH/LOWBYTEFIRST
1992-Sep-3-10:22 paulb = Remove NEEDS_FAR_TIMER for WIN32
1992-Sep-2-18:31 paulb = Add WIN32 (identical to IBMPC)
1992-Sep-1-15:25 derekk = add HAS_SIGNED if signed type modifier exists
1992-Aug-28-15:46 harry = Add CANNOT_CAST_LVALUE for SGI.
1992-Aug-28-10:02 derekk = New define for Brain-Dead compilers which cannot
1992-Aug-28-10:02 derekk + cast an lvalue
1992-Aug-20-18:27 luke = add highbytefirst for SGI
1992-Aug-13-12:38 harry = Define RESETSIGNALS for SGI.
1992-Aug-12-19:50 harry = SGI needs our ualarm().
1992-Aug-12-19:46 derekk = Add NEEDS_FAR_TIMER define for IBMPC
1992-Jul-14-16:37 harry = Make it compile for the SGI.
1992-Jul-14-16:16 harry = Make it compile for the SGI.
1992-Jul-14-10:51 harry = Add SGI.
1992-Jun-19-14:01 daniel = NO_STRUCT_ASSIGN #define for EXTENDED_DOS
1992-May-6-17:44 richardk = off_t for mac lseek in osproto.h
1992-May-6-13:11 luke = fix NULL casts for snake
1992-Apr-28-22:40 paulh = Define ADDRESS_IS_VOID_PTR (maybe). Just for snake,
1992-Apr-28-22:40 paulh + for now.
1992-Apr-27-09:47 davidg = fix real floating point prototypes
1992-Apr-23-11:46 paulh = Add a #define for SIGNALTYPE
1992-Apr-10-12:33 davidg = take comp out of ifdef to avoid portability
1992-Apr-10-12:33 davidg + problems
1992-Apr-10-12:21 davidg = define comp to break on machines other than
1992-Apr-10-12:21 davidg + Mactinsosh to avoid portability problems
1992-Apr-6-15:20 paulh = Add more #defines for AMD29k
1992-Apr-2-10:47 paulh = Default chars to signed
1992-Mar-13-12:44 paulh = AMD29K is highbytefirst
1992-Mar-11-13:06 davidg = Correct case of Can_Shift_32
1992-Mar-10-14:46 paulh = Define STDARGS for AMD29K
1992-Mar-10-10:25 paulh = Fix typo
1992-Mar-10-10:22 paulh = Add AMD29K
1992-Mar-7-14:57 andy = proper defines for Macinotosh
1992-Feb-25-15:47 paulh = Define USE_PROTOTYPES if __STDC__ or __GNUC__

--- split from machine.h----
*/
/*
  platform.h - port-specific things for Harlequin products
  This file handles various #defines that vary between systems, but not
  product-specific #defines.

  It works out what must be defined from some things that are 
  predefined by the C-preprocessor of each system.
  
  It is in two sections:
     i)  --- PLATFORMS SECTION ---
         sets of #defines, one per platform (roughly):
             IBMPC
             MACINTOSH
             sparc
             ... etc.
    ii)  --- GENERAL SECTION ---
         further interpretation and checking, which is not specific to a
	 single platform (eg. interpreting ANSI_SUPER, checking that one
	 of STD/VARARGS is defined, etc.)
*/
  
/*
  The file must define

    highbytefirst or lowbytefirst   -- however, all code should only switch on highbytefirst defined or not.
    STDARGS or VARARGS

  It may define
    
    ANSI_SUPER           -- super-set (nearly) of ansi C.  Implies the following:
      USE_PROTOTYPES       -- for PROTO and PARAMS macros.
      ANSI_OSPROTOS        -- include stdlib.h, string.h, math.h
      HAS_CONST            -- default is to #define const to nothing.
      HAS_SIGNED           -- default is to #define signed to nothing.
    
    HAS_PRAGMA_UNUSED
    CANNOT_CAST_LVALUE
    Can_Shift_32
    ZEROMEMORY
    SIGNALTYPE
    RESETSIGNALS
    PID_TYPE             -- typedef name for process id for kill() etc
    NO_UALARM
    align_to_double
    promoted_real        -- the promoted type for passing floats and doubles
    off_t                -- for lseek in osprotos.h (on a Mac without sys/types)
    ADDRESS_IS_VOID_PTR  -- define if the type of "addresses" in the standard library (e.g return
		     value of malloc) is "void *", rather than "char *". Should only matter for non-ANSI systems
    HAS_PRINTF_PROTO     -- stdio.h (or similar file) defines prototypes for printf, vprintf.. etc.
    USE_INLINE_MEMCPY    -- tests have established that the ANSI memcpy function
                            is the fastest for copying non-overlapping blocks
    USE_INLINE_MEMMOVE   -- ditto for memmove and potentially overlapping blocks
    BCOPY_OVERLAP_SAFE   -- only relevant if USE_INLINE_MEMMOVE is not defined.
                            Some implementations are overlap safe, some need
                            a wrapper.

    It may also define any others it likes, but these must only be used in
    code for that particular platform.
*/

#endif  /* 0 */


/* --- PLATFORMS SECTION --- */

/*
     The productCode in the dongle now holds a byte describing the platform(s)
     the product may run on and PLATFORM_ID contains a byte which this is checked against.
     The highest 3 bits identify the operating system and the lowest 5 bits identify the
     machine. If the level number in the dongle is zero the product will run on all platforms.
     NB: A gap of several numbers has been left after Macintosh for the addition of
     new Macintosh platforms since the Mactivator only returns a byte and therefore
     would not be able to read the entire productCode in the event of it being expanded
     into a word.
*/

#define PLATFORM_MACHINE        ( PLATFORM_ID & 0x1f )
#define PLATFORM_OS             ( PLATFORM_ID & 0xe0 )

#define P_MACOS             (0<<5)
#define P_MACOS_PARALLEL    (1<<5)
#define P_UNIX_PARALLEL     (2<<5)
#define P_WINNT_PARALLEL    (3<<5)
#define P_UNIX              (4<<5)
#define P_WINNT             (5<<5)
#define P_WIN31             (6<<5)
#define P_CUSTOM            (7<<5)
 
#define P_MAC68K        1
#define P_POWERMAC      2
#define P_INTEL         7
#define P_ALPHA         8
#define P_DESKSTATION   9
#define P_SPARC         10
#define P_SGI           11
#define P_HPSNAKE       12
#define P_CLIPPER       13
#define P_RS6000        14
#define P_HP9000        15
#define P_T188          16
#define P_MC88100       17
#define P_AM29K         18
#define P_MIPS          19
#define P_PPC           20
#define P_ARM200	21

#if (defined(IBMPC) || defined(WIN32) || defined(I960)) 

#if (!defined(_MIPS_) && !defined(_ALPHA_) && !defined(_PPC_))
#define Unaligned_32bit_access	1
#endif

#define CANNOT_CAST_LVALUE	1
#define lowbytefirst		1
#define bitsgoright		1
#define ANSI_SUPER		1

#ifdef WATCOM
#define	FAR	far
#define FAR_INITIALISE_BUG
#endif /* WATCOM */

#define USE_PROTOTYPES_MIXED
#define HAS_PRINTF_PROTO        1

#ifdef WIN32
#define MULTIDBG_TO_FILE    1
#endif

/* A build on Windows assumes P_WINNT. At run time the application may
 * want to take into account that the platform it is running
 * on could be Win3.1, Win95, or NT.
 */
#define NORMAL_OS              P_WINNT

#ifdef MULTI_PROCESS
#define PARALLEL_OS            P_WINNT_PARALLEL
#endif

#ifdef _ALPHA_
#define MACHINE                 P_ALPHA
#define CHECK_ATAN2_ARGS	1
#define USE_INLINE_MEMCPY
#define USE_INLINE_MEMMOVE
#define INLINE_MEMSET
#else /* _ALPHA_ */
#ifdef _MIPS_
#define MACHINE                  P_MIPS
#else
#ifdef _PPC_
#define MACHINE                  P_PPC
#else
#define MACHINE                  P_INTEL
#endif /* _PPC_ */
#endif /* _MIPS_ */
#endif /* _ALPHA_ */
#endif /* IBMPC */

#if  defined(I960) 

#define Unaligned_32bit_access	1
#define CANNOT_CAST_LVALUE	1
#define lowbytefirst		1
#define bitsgoright		1
#define ANSI_SUPER		1
#define off_t                long          /* offset, for lseek */
#define USE_PROTOTYPES_MIXED
#define HAS_PRINTF_PROTO        1

#endif /* I960 */

#if (defined(idtr3081) || defined(idtr3051)) && !defined(idtr30xx)
#define idtr30xx		1
#endif

#if defined(idtr30xx) 

#define ANSI_SUPER		1
#define USE_PROTOTYPES_MIXED	1

/* #define HAS_PRAGMA_UNUSED	1 */
/* #define CANNOT_CAST_LVALUE	1 */

/* #define Can_Shift_32		1 */
#define ZEROMEMORY		1
/* #define SIGNALTYPE		void */
/* #define RESETSIGNALS		1 */
/* #define PID_TYPE		int */     /* rather than pid_t */
#define NO_UALARM		1
#define align_to_double 	1
/* #define promoted_real	? */
/* #define off_t		long */          /* offset, for lseek */

#define highbytefirst		1
#define bitsgoright		1
/* #define Unaligned_32bit_access	1 */

#endif /* idtr30xx */


#ifdef	MACINTOSH
/* please use tabs every 8 columns for editing this file */
#define ANSI_SUPER		1

#define BCOPY_OVERLAP_SAFE /* Since it maps down onto BlockMove */

#ifdef MAC_SYSHDRS_UNIVERSAL

/* math.h now uses "long double", but used to be defined with extended.  
    In PPCC, extended is a synonym for long double.  In C (68K), long 
   double is a synonym for extended.  In GCC neither are synonyms for 
   either.  :-(
*/
#define MAC_SYSHDRS_LONGDBLPROTOS  1
#ifdef POWERMAC
#define promoted_real      double
/* === "Using new UNIV headers; a PPC build." === */
#else
#define promoted_real      extended
/* === "Using new UNIV headers; a MAC68K build." === */
#endif

#else  /* ! UNIVERSAL */

#define promoted_real      extended
=== "Using old 68K headers is not permitted" ===

#endif

#define Can_Shift_32		1
#define Unaligned_32bit_access	1
#define ZEROMEMORY		1
#define highbytefirst		1
#define bitsgoright		1

#ifdef POWERMAC
#ifdef __MRC__  /* MrC has pragma unused, but PPCC does not */
#ifndef RELEASE_BUILD
#define HAS_PRAGMA_UNUSED       1
#else
/* but in release-builds, unused-param warnings are suppressed with a 
 * compiler option, so do not generate any dummy code. */
#define NO_DUMMYPARAM           1
#endif /* RELEASE_BUILD */
#endif /* __MRC__ */
#endif /* POWERMAC */

#ifdef MAC68K
#ifndef __SC__           /* SC does not have pragma unused, but C does */
#define HAS_PRAGMA_UNUSED       1
#endif  /* SC */
#endif  /* MAC68K */

#ifndef BUILDING_FOR_OS_X
typedef long off_t;  /* offset, for lseek */
#endif

#define NORMAL_OS               P_MACOS
#ifdef MULTI_PROCESS
#define PARALLEL_OS             P_MACOS_PARALLEL
#endif

#ifdef MAC68K
#define MACHINE                 P_MAC68K
#else
#ifdef POWERMAC
#define MACHINE                 P_POWERMAC
#else
=== "This should NOT compile - it is not a valid product ID" ===
#endif
#endif

#define HAS_PRINTF_PROTO        1
#endif	/* MACINTOSH */


#if defined(alpha)
#define UNIX			1
#define MACHINE                 P_ALPHA
#define highbytefirst		1
#define bitsgoright		1
#define align_to_double		1
#define HAS_SHL_LOAD		1	/* Dynamic code loading */
#define SIGNALTYPE		void
#define CHECK_ATAN2_ARGS	1
#endif /* alpha */

#if defined(sun4) || defined(sun3)
#define UNIX			1
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* suns */


#ifdef sun386i
#define UNIX			1
#define lowbytefirst		1
#define bitsgoleft		1
#endif /* sun386i */

#ifdef sparc
#define UNIX			1
#define MACHINE                 P_SPARC
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#define PID_TYPE                int     /* rather than pid_t */
#define HAS_DLOPEN		1	/* Dynamic code loading */

/* 
 * Really should use some Solaris OS header identifier
 * but I can't find one as yet. This will turn the prototype
 * off for Solaris and Ultrasparc builds
 */
#if !defined(Solaris) && !defined(Ultrasparc)
#define NEEDS_SYSTEM_PROTOTYPE	1
#endif

#ifndef CLOCKS_PER_SEC
#define CLOCKS_PER_SEC		1000000
#endif
#endif /* sparc */

#ifdef linux
#define UNIX			1
#define MACHINE                 P_INTEL
#define ANSI_SUPER              1
/* bcopy(), apart from being non-standard, is identical in
 * implementation to memmove() (in glibc, at least).  Therefore, we may
 * as well use the standard function.  memcpy(), on the other hand, is
 * hand-written assembler, so I guess (!) is likely to be faster than
 * the C-coded memmove()/bcopy(). */
#define USE_INLINE_MEMCPY       1
#define USE_INLINE_MEMMOVE      1
#define HAS_PRINTF_PROTO        1
#define lowbytefirst		1
#define bitsgoright             1
#define SIGNALTYPE		void
#define RESETSIGNALS            1
#define PID_TYPE                pid_t
#define HAS_DLOPEN		1	/* Dynamic code loading */
#define NO_UALARM		1
 /*
#ifndef CLOCKS_PER_SEC
#define CLOCKS_PER_SEC		1000000
#endif
 */
#endif /* linux */


#if defined( arm200 )

#define lowbytefirst		1
#define NOThighbytefirst	1
#define bitsgoleft		1
#define NOTbitsgoright		1

#define	ANSI_SUPER		1
#define	Can_Shift_32		1
#define	ZEROMEMORY		1
typedef long			off_t;
#define MACHINE                 P_ALPHA
#define NORMAL_OS               P_UNIX
#define HAS_PRINTF_PROTO        1
#define NO_BCOPY
#define NO_BZERO
#define NO_BCMP
#endif

#if defined( mips ) && !defined( SGI ) && !defined( _MIPS_ ) && !defined( dec )
#ifndef UNIX
#define UNIX			1
#endif
#define highbytefirst		1             /* nick 18May94 */
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* mips */

#if defined( dec ) && defined( ultrix_mips )  /* nick 18May94 */
#ifndef UNIX
#define UNIX			1
#endif
#define lowbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* dec & ultrix_mips */

#ifdef rs6000
#define UNIX			1
#define MACHINE                 P_RS6000
#define ADDRESS_IS_VOID_PTR	1
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#define HAS_PRINTF_PROTO        1
#if 0
#define off_t                long
#endif
#endif /* rs6000 */

#ifdef SGI
#ifndef UNIX
#define UNIX			1
#endif
#define MACHINE                 P_SGI
#define highbytefirst		1
#define bitsgoright		1
#define ADDRESS_IS_VOID_PTR	1
#ifndef SGI4K6
/* IRIX 6 now does have ualarm - and posix threads */
#define NO_UALARM		1
#define NO_PTHREADS             1
#else   /* for IRIX 6, CC _has_ got a printf prototype */
#ifdef __cplusplus
#define HAS_PRINTF_PROTO        1
#endif
#endif
#define RESETSIGNALS		1
#define CANNOT_CAST_LVALUE	1
#if defined( SGI4K6 ) || defined( SGI4K5 ) || defined( SGI5 )
/* IRIX 5.x has shared libraries */
#define HAS_DLOPEN		1
#else
/* IRIX 3.x and 4.x does not */
#define HAS_LDOPEN		1
#endif
#if defined( SGI4K5 ) || defined( SGI5 )
#define NO_UNICODE
#endif
#define SIGNALTYPE		void
#define NO_STAT_NAME_LEN        1
#define STATFS_THREE_ARGS       1
#define STATFS_NO_BAVAIL        1
#endif /* SGI */

#ifdef hp9000
#define	UNIX			1
#define MACHINE                 P_HP9000
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* hp9000 */

#ifdef apollo
#define UNIX			1
#define MACHINE                 ??? /* unknown */
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* apollo */

#ifdef sony
#define UNIX			1
#define MACHINE                 ??? /* unknown */
#define highbytefirst		1
#define bitsgoright		1
#define SIGNALTYPE		void
#endif /* sony */

#ifdef __hppa    /* Snake: HP Precision Architecture */
#define UNIX			1
#define MACHINE                 P_HPSNAKE
#define highbytefirst		1
#define bitsgoright		1
#define align_to_double		1
#define SIGNALTYPE		void
#define ADDRESS_IS_VOID_PTR	1
#define ANSI_OSPROTOS		1
#define LACKING_GETWD		1
#define RESETSIGNALS            1
#define HAS_PRINTF_PROTO        1
/* the snake compiler has problems if NULL is a (void *) */
#define NULL 0

#define HAS_SHL_LOAD		1	/* Dynamic code loading */
#endif /* hppa */

#ifdef T188 /* tadpole system */
#define UNIX			1
#define MACHINE                 P_T188
#define highbytefirst		1
#define bitsgoright		1
#define align_to_double 	1
#define SIGNALTYPE		void
#define NO_STAT_NAME_LEN        1
#define BSD_READDIR             1
#else /* T188 */
#define waitpid_defined         1
#endif /* T188 */

#ifdef mc88100
#define UNIX			1
#define MACHINE                 P_MC88100
#define highbytefirst		1
#define bitsgoright		1
#define align_to_double 	1
#define SIGNALTYPE		void
#define DIRECT_READDIR          1
#define HAS_PRINTF_PROTO        1
#endif /* mc88100 */

#ifdef _AM29K
#define AMD29K
#endif
#ifdef AMD29K
#define UNIX                    1
#define MACHINE                 P_AM29K
#define highbytefirst		1
#define bitsgoright		1
#define align_to_double		1
#pragma Off (Char_default_unsigned)
#define SIGNALTYPE		void
#define off_t long
#endif

#ifdef __clipper__
#define CLIPPER
#endif

#ifdef CLIPPER
#define UNIX			1
#define MACHINE                 P_CLIPPER
#define ANSI_OSPROTOS		1
#define lowbytefirst		1
#define bitsgoleft		1
#define SIGNALTYPE		int
#define align_to_double 	1
#define NO_UALARM		1
#define RESETSIGNALS		1
#define NO_STAT_NAME_LEN        1
#define HAS_PRINTF_PROTO        1
#define SELECT_IS_BROKEN        1
#endif

#ifdef Solaris
#ifndef POSIX_THREADS
#define SOLARIS_THREADS  /* use solaris threads */
#define NO_PTHREADS      /* don't use posix threads */
#endif
#define UNIX          1
#define USE_INLINE_MEMCPY
#define USE_INLINE_MEMMOVE
#define NO_BZERO      1
#define NO_BCMP       1
#define NO_STAT_NAME_LEN 1
#define RESETSIGNALS  1
#define LACKING_GETWD 1
#define HAS_STATVFS   1
#define HAS_PRINTF_PROTO 1
#endif

/* --- END OF PLATFORMS SECTION --- */


/* --- PLATFORM_ID SECTION --- */

#ifdef UNIX
/* All unixes have the same OS ID */
#define NORMAL_OS               P_UNIX
#ifdef MULTI_PROCESS
#define PARALLEL_OS             P_UNIX_PARALLEL
#endif
#endif


#ifdef MULTI_PROCESS
#ifndef PARALLEL_OS
"do not have a parallel Operating System ID"
#endif
#define PLATFORM_ID             (MACHINE | PARALLEL_OS)
#define PLATFORM_ID_WITHOUT_MP  (MACHINE | NORMAL_OS)
#else /* ! MULTI_PROCESS */
#define PLATFORM_ID             (MACHINE | NORMAL_OS)
#endif /* ! MULTI_PROCESS */



/* --- GENERAL SECTION --- */

#ifdef USE_TRADITIONAL
#define VARARGS			1
#else
#define STDARGS                 1
#endif  /* USE_TRADITIONAL */

/* default POSIX definition for process id type for kill() etc... */

#ifndef PID_TYPE
#define PID_TYPE pid_t
#endif /* !PID_TYPE */

#if defined(__STDC__) || defined(__GNUC__)
#ifndef  ANSI_SUPER
#ifndef rs6000
#define  ANSI_SUPER
#endif
#endif
#endif

#ifdef ANSI_SUPER
#ifndef USE_PROTOTYPES
#define USE_PROTOTYPES
#endif
#ifndef ANSI_OSPROTOS
#define ANSI_OSPROTOS
#endif
#endif

#if defined(ANSI_SUPER) || defined(HAS_CONST)
/* leave type-qualifier "const" alone */
#else
#define const
#endif

#if defined(ANSI_SUPER) || defined(HAS_SIGNED)
/* leave signed type-specifiers alone */
#else
#define signed
/* //\\ if this breaks a source file, replace "signed" by "signed int" in that source file. */
#endif

/* comp is typedef-ed on the MACINTOSH 'C' Compiler as a complex type */
/* and so compilations break if comp is used as a variable etc. */
/* The define below will make peaple aware of the problem when building on */
/* other platforms. */
/* If you get the expansion below, simply re-name your identifier to */
/* something other than comp */

#ifndef MACINTOSH
#ifndef SGI     /* cant forbid comp on SGI5, needed for system header files */
#define comp "see platform.h - typedef comp on MACINTOSH would break here"+[]+
#endif
#endif /* !MACINTOSH */

#ifdef Solaris
#define NO_BZERO      1
#define NO_BCMP       1
#define NO_STAT_NAME_LEN 1
#endif

/* HIGH/LOWBYTEFIRST
    i) ensure one of high/lowbytefirst is defined
   ii) undef lowbytefirst - all code should only switch on high defined or not.
*/
#ifdef  highbytefirst
#ifdef  lowbytefirst
"Error in platform.h - BOTH highbytefirst and lowbytefirst defined!!!" :-)
#else
/* highbytefirst - all well */
#endif
#else
#ifdef  lowbytefirst
/* lowbytefirst - all well */
#undef lowbytefirst
/* (all code should only switch on high defined or not) */
#else
"Error in platform.h - neither highbytefirst nor lowbytefirst defined" :-)
#endif
#endif

/* Bitsgoright/bitsgoleft
    i) ensure one of bitsgoright/bitsgoleft is defined
   ii) undef bitsgoleft - all code should only switch on right defined or not.
*/
#ifdef  bitsgoright
#ifdef  bitsgoleft
"Error in platform.h - BOTH bitsgoright and bitsgoleft defined!!!" :-)
#else
/* bitsgoright - all well */
#endif
#else
#ifdef bitsgoleft
/* bitsgoleft - all well */
#undef bitsgoleft
/* (all code should only switch on bits right defined or not) */
#else
"Error in platform.h - neither bitsgoright nor bitsgoleft defined" :-)
#endif
#endif

/* STDARGS/VARARGS
   ensure one of STDARGS/VARARGS is defined
*/
#ifdef  STDARGS
#ifdef  VARARGS
"Error in platform.h - BOTH STDARGS and VARARGS defined!!!" :-)
#else
/* STDARGS - all well */
#endif
#else
#ifdef  VARARGS
/* VARARGS - all well */
#else
"Error in platform.h - neither STDARGS nor VARARGS defined" :-)
#endif
#endif


#ifndef promoted_real
#define promoted_real double
#endif /* !promoted_real_type */
/* Use promoted_real in all ANSI prototype declarations which refer */
/* to a reral value passed from an old-style declaration */



/* --- END OF GENERAL SECTION --- */

#if 0
/* please leave this #ifed out - thanks */
/* end of machine.h */
#endif /* 0 */

#endif /* protection for multiple inclusion */
