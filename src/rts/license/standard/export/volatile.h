#ifndef __VOLATILE_H__
#define __VOLATILE_H__

/*
$Log: volatile.h,v $
Revision 1.11  2000/09/13 01:57:41  angus
[Bug #11389]
Clean up use of P_INTEL to avoid implying Windows, and check parallel build
is happening before adding interlock functions.

 * Revision 1.10  1997/08/13  09:15:45  davidg
 * implement and use interlockedWrite/Read() functions using functions
 * from <mutex.h> which ensure strong memory ordering semantics
 *
 * [Bug #20743]
 * ensure ports to new platforms do not take place without considering
 * strong memory ordering semantics by using HQFAIL() at run time if
 * no explicit port has been done or HQFAIL_AT_COMPILE_TIME() if a
 * partial port is done
 *
 * [Bug #20743]
 * add support for interlockedWrite/Read() to enforce strong memory
 * ordering on Pentium Pro architecture
 *
 * Revision 1.7  1995/06/19  09:57:02  paulb
 * [Bug #5621]
 * Get memory barriers sorted out
 *
 * Revision 1.6  1995/05/26  16:53:47  davidg
 * [Bug #5643]
 * SMP rip - support WRITE_SHM() correctly on SPARC platforms
 *
 * Revision 1.5  1994/12/06  19:26:35  bart
 * [Bug #4569]
 * change FLUSH_CACHE_STATEMENT to use EMPTY_STATEMENT instead.
 *
 * Revision 1.4  1994/12/01  21:26:46  bart
 * [Bug #4569]
 * Redefine FLUSH_CACHE as used in WRITE_SHM to reduce null effect
 * warnings.
 *
 * Revision 1.3  1994/11/30  18:07:51  sarah
 * [Bug #4569]
 * Protect against multiple inclusions.
 *
 * Revision 1.2  1994/10/21  14:37:24  paulb
 * [Bug #4267]
 * Oops - broke everything *apart* from the Alpha :-(
 *
 * Revision 1.1  1994/10/21  11:39:04  paulb
 * new file
 *
*/

/* volatile.h
 * ==========
 *
 * Macros to help with reading and writing volatile variables.
 * Some machines (e.g. the DEC Alpha) need help with maintaining
 * cache coherency.
 *
 * NOTE: we have been hit by a number of problems in the past
 * where the implicit assumptions we have made about the semantics
 * of access to shared memory in the "LOCK"ing code used by the
 * ScriptWorks Core RIP in an SMP implementation have been invalid.
 *
 * The macros in this file provide mechanisms for ensuring strong
 * memory ordering semantics (which cover the implicit assumptions
 * mentioned above) for key shared memory accesses.
 *
 * When porting an SMP product to a new platform, it is necessary
 * to ensure that this file includes appropriate definitions.
 * However, default, asserted implementations are provided to allow
 * compilation on all platforms if required.
 */

#ifdef MULTI_PROCESS

/*-----------------------------------------------------------------------------*/

#ifdef _ALPHA_

#define ALPHA_MEMORY_BARRIER() __MB()

#define SMP_WRITE_SHM(lvalue, x) MACRO_START \
    HQASSERT(sizeof(lvalue) == sizeof(uint32), "SMP_WRITE_SHM: bad size"); \
    (lvalue) = (x); \
MACRO_END

#define SMP_READ_SHM(rvalue) (rvalue)

#endif  /* _ALPHA_ */

/*-----------------------------------------------------------------------------*/

#ifdef sparc

extern void sparc_swap(volatile uint32 *p, uint32 v);

#define ALPHA_MEMORY_BARRIER()   EMPTY_STATEMENT()

#define SMP_WRITE_SHM(lvalue, x) MACRO_START \
    HQASSERT(sizeof(lvalue) == sizeof(uint32), "SMP_WRITE_SHM: bad size"); \
	sparc_swap((volatile uint32 *)&(lvalue), (uint32)(x)); \
MACRO_END

#define SMP_READ_SHM(rvalue) (rvalue)

#endif  /* sparc */

/*-----------------------------------------------------------------------------*/

#if	(PLATFORM_MACHINE == P_INTEL)
#if	(PLATFORM_OS == P_WINNT_PARALLEL) || (PLATFORM_OS == P_UNIX_PARALLEL)
/* All INTEL platforms support SMP through the same interface. */
extern void interlockedWrite(volatile uint32 *p, uint32 v);
extern uint32 interlockedRead(volatile uint32 *p);

#define ALPHA_MEMORY_BARRIER()   EMPTY_STATEMENT()

#define SMP_WRITE_SHM(lvalue, x) interlockedWrite(&(lvalue), (x))
#define SMP_READ_SHM(rvalue)     interlockedRead(&(rvalue))
#endif  /* P_WINNT_PARALLEL || P_UNIX_PARALLEL */
#endif	/* (PLATFORM_MACHINE == P_INTEL) */

/*-----------------------------------------------------------------------------*/

#if	(PLATFORM_MACHINE == P_SGI)

extern void interlockedWrite(volatile uint32 *p, uint32 v);
extern uint32 interlockedRead(volatile uint32 *p);

#define ALPHA_MEMORY_BARRIER()   EMPTY_STATEMENT()

#define SMP_WRITE_SHM(lvalue, x) interlockedWrite(&(lvalue), (x))
#define SMP_READ_SHM(rvalue)     interlockedRead(&(rvalue))

#endif	/* (PLATFORM_MACHINE == P_SGI) */

/*-----------------------------------------------------------------------------*/

/*
 * Provide default, untested versions for other platforms
 *
 * NOTE: If you are just porting to a new platform you should *not* need to
 * change anything below this line.
 */

#if !defined(ALPHA_MEMORY_BARRIER) || !defined(SMP_WRITE_SHM) || !defined(SMP_READ_SHM)

/* Check that we have not done an incomplete port... */

#if defined(ALPHA_MEMORY_BARRIER) || defined(SMP_WRITE_SHM) || defined(SMP_READ_SHM)
HQFAIL_AT_COMPILE_TIME();
#endif

#define ALPHA_MEMORY_BARRIER() EMPTY_STATEMENT()

#define SMP_WRITE_SHM(lvalue, x) MACRO_START \
    HQFAIL("SMP_WRITE_SHM: not a supported platform for SMP products"); \
    HQASSERT(sizeof(lvalue) == sizeof(uint32), "SMP_WRITE_SHM: bad size"); \
    (lvalue) = (x); \
MACRO_END

#define SMP_READ_SHM(rvalue) (rvalue)

#endif

/*-----------------------------------------------------------------------------*/

#else  /* !MULTI_PROCESS */

#define ALPHA_MEMORY_BARRIER() EMPTY_STATEMENT()

#define SMP_WRITE_SHM(lvalue, x) MACRO_START \
    HQASSERT(sizeof(lvalue) == sizeof(uint32), "SMP_WRITE_SHM: bad size"); \
    (lvalue) = (x); \
MACRO_END

#define SMP_READ_SHM(rvalue) (rvalue)

#endif /* !MULTI_PROCESS */

#endif /* protection for multiple inclusion */

