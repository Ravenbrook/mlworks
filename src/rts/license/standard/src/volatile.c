/*
 * File:	volatile.c
 * Description:
 *	machine-specific support code to implement truly volatile
 *	shared memory accesses in and SMP environment.
 *
 * $Log: volatile.c,v $
 * Revision 1.4  2000/09/13 01:57:44  angus
 * [Bug #11389]
 * Clean up use of P_INTEL to avoid implying Windows, and check parallel build
 * is happening before adding interlock functions.
 * Add Linux interlock functions using kernel 2.2+ atomic functions.
 *
 * Revision 1.3  1997/08/13  09:15:44  davidg
 * implement and use interlockedWrite/Read() functions using functions
 * from <mutex.h> which ensure strong memory ordering semantics
 *
 * [Bug #20743]
 * add support for interlockedWrite/Read() to enforce strong memory
 * ordering on Pentium Pro architecture
 *
 * Revision 1.1  1995/05/26  15:46:35  davidg
 * new unit
 * [Bug #5643]
 * SMP rip - support WRITE_SHM() correctly on SPARC platforms
 *
 */

#include "std.h"
#include "volatile.h"

#ifdef	sparc

/*
 * Provide access to the SPARC swap instruction to support a forced write
 * to memory after finishing all previous writes and before all subsequent
 * reads. Used to implement WRITE_SHM() in the SMP environment.
 */

/*ARGSUSED*/
void sparc_swap(volatile uint32 *p, uint32 v)
{
  __asm("swap	[%i0], %i1");
}

#else	/* !sparc */

#if	(PLATFORM_MACHINE == P_INTEL)

#if     (PLATFORM_OS == P_WINNT_PARALLEL)
#include <windows.h>

void interlockedWrite(volatile uint32 *p, uint32 v)
{
  /*
   * Perform an write to a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses
   */
  InterlockedExchange((PULONG)p, (LONG)v);
}

uint32 interlockedRead(volatile uint32 *p)
{
  /*
   * Perform a read from a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses.
   * Note: this implementation atomically writes back the original value
   * as a side effect.
   */
  return InterlockedExchangeAdd((PULONG)p, 0);
}
#else   /* P_INTEL && !P_WINNT_PARALLEL */
#if     (PLATFORM_OS == P_UNIX_PARALLEL)
/* Assume INTEL and P_UNIX means linux; add ifs to distinguish Unixes if
   necessary. */
#include <asm/atomic.h>

void interlockedWrite(volatile uint32 *p, uint32 v)
{
  /*
   * Perform an write to a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses
   */
  atomic_set((atomic_t *)p, (int)v);
}

uint32 interlockedRead(volatile uint32 *p)
{
  /*
   * Perform a read from a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses.
   */
  return (uint32)atomic_read((atomic_t *)p);
}
#endif  /* P_INTEL && P_UNIX_PARALLEL */
#endif  /* P_INTEL && !P_WINNT_PARALLEL */

#else	/* (PLATFORM_MACHINE != P_INTEL) */

#if	(PLATFORM_MACHINE == P_SGI)

#include <mutex.h>

void interlockedWrite(volatile uint32 *p, uint32 v)
{
  /*
   * Perform an write to a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses
   */
  atomic_set((unsigned long *)p, v);
}

uint32 interlockedRead(volatile uint32 *p)
{
  /*
   * Perform a read from a shared memory location with strong memory
   * ordering semantics with respect to any previous or subsequent
   * memory accesses.
   * Note: this implementation atomically writes back the original value
   * as a side effect.
   */
  return test_then_add((unsigned long *)p, 0);
}

#else	/* (PLATFORM_MACHINE != P_SGI) */

int dummy_volatile_c;

#endif	/* (PLATFORM_MACHINE != P_SGI) */

#endif	/* (PLATFORM_MACHINE != P_INTEL) */

#endif	/* !sparc */

/* EOF volatile.c */

