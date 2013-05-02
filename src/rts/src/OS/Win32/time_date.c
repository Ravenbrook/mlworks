/* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Implements various parts of basis/time.sml and basis/date.sml
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date.c,v $
 * Revision 1.23  1998/08/13 15:57:05  jont
 * [Bug #70152]
 * Ensure Time.start uses GetSystemTime
 *
 * Revision 1.22  1998/08/03  14:45:10  mitchell
 * [Bug #30460]
 * Fix times so they are UTC rather than local where necessary
 *
 * Revision 1.21  1998/02/24  11:22:10  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.20  1997/11/19  21:23:35  jont
 * [Bug #30085]
 * Fix typo
 *
 * Revision 1.19  1997/11/19  20:57:10  jont
 * [Bug #30085]
 * Add Time.start function to give value of Time.now when process started
 *
 * Revision 1.18  1997/11/17  09:01:52  jont
 * [Bug #30089]
 * Add mlw_time_make for converting doubles to basis times
 *
 * Revision 1.17  1997/09/30  11:25:25  daveb
 * [Bug #30269]
 * Added declare root to Bruce's change.
 *
 * Revision 1.16  1997/09/25  09:16:29  brucem
 * [Bug #30269]
 * Implement routines for revised Date structure.
 *
 * Revision 1.15  1997/08/27  15:33:57  jont
 * [Bug #30250]
 * Fix up overloading of the name yday in mlw_date_from_system_time
 *
 * Revision 1.14  1997/08/19  15:14:06  nickb
 * [Bug #30250]
 * Bugs in use of allocate_record and allocate_array: add debug-filling code.
 *
 * Revision 1.13  1997/04/01  08:18:34  jont
 * Fix inaccuracies in Time.+ and Time.-
 *
 * Revision 1.12  1997/03/27  14:08:57  jont
 * Fix loss of precision when converting from time to FILETIME
 *
 * Revision 1.11  1997/03/27  10:14:34  jont
 * Modify calculation of tm_year in mlw_date_to_tm to
 * apply CINT before subtracting mlw_date_year_offset
 * Calculate yday in fromTime as this is required by the basis specification
 *
 * Revision 1.10  1996/06/20  10:58:15  stephenb
 * Rewrite Date.from{Time,UTC} and Date.toTime to use native Win32
 * library routines rather than the Unix ones provided in the Visual
 * C++ compatability library.  It was either this or put some hack in
 * to convert between the time used by Time (native Win32 time) and
 * that expected by the previous Date implementation (Unix style time
 * since 1970).
 *
 * Revision 1.9  1996/06/14  08:37:50  stephenb
 * Add mlw_time_to_timeval as needed by select (which is used to
 * implement OS.IO.poll).
 *
 * Revision 1.8  1996/06/13  14:42:59  stephenb
 * Make mlw_time_to_file_time external so that it can be used by the
 * rts support routine for OS.FileSys.setTime.
 * Also alters the mlw_time_2_to_32 constant so that it actually defines 2^32
 * and so means that the time conversions now work!  Doesn't say much
 * for our test suite that it didn't catch this.
 *
 * Revision 1.7  1996/06/12  12:23:27  stephenb
 * Flesh out all the time stubs.
 *
 * Revision 1.6  1996/05/16  14:02:53  jont
 * Modify representation of ML year to be full value, rather than value since 1900
 *
 * Revision 1.5  1996/05/14  12:52:41  stephenb
 * Flesh out some of the stubs.
 * There are still lots of stubs left though.
 *
 * Revision 1.4  1996/05/13  12:44:38  jont
 * Fix problem whereby mk_time fiddles with tm_isdst
 *
 * Revision 1.3  1996/05/13  12:28:56  stephenb
 * Update wrt removal of trans_month ... etc. from date.h
 *
 * Revision 1.2  1996/05/09  16:04:09  jont
 * Completing implementation of __date.sml
 *
 * Revision 1.1  1996/05/07  12:08:47  stephenb
 * new unit
 *
 */

#include <assert.h>		/* assert */
#include <windows.h>		/* DWORD, SystemTimeToFileTime, ... etc. */
#include <math.h>		/* fmod, floor */
#include <limits.h>		/* LONG_MAX .. etc. */
#include "allocator.h"		/* allocate_real, allocate_record */
#include "date.h"		/* mlw_date_hour etc */
#include "exceptions.h"		/* exn_raise, perv_exn_ref_overflow */
#include "environment.h"	/* env_value ... etc. */
#include "global.h"		/* declare_global */
#include "utils.h" 		/* alloc */
#include "gc.h"			/* declare_root, retract_root */
#include "time_date.h"
#include "time_date_init.h"

static mlval mlw_time_exn_ref_time;
static mlval mlw_date_exn_ref_date;

#define mlw_time_2_to_32 ((double)ULONG_MAX)

/* Win32 time is defined as a 64-bit value which ticks every 100 nanoseconds.
 * Due to lack of 64 bit arithmetic support in Visual C++ and the fact
 * that I don't have the time to write a 64/32 -> (64,32) division/remainder
 * routine either in portable C or assembler, floating point is used to
 * do division in the following.  This massages a 64 bit value into
 * a 41 bit value representing the seconds and a 28 bit value representing
 * the number of 100 nanoseconds.  
 *
 * If and when the 64-bit routines are written, most of the floating point
 * stuff should be removed and replaced by the 64-bit routines.
 *
 * If nobody does get around to writing the required integer division 
 * routines, then it may be worthwhile changing the internal representation
 * from a triple of ints to a double.
 */

#define mlw_time_secs_lo_bits 20

#define mlw_time_secs_lo_val (1 << mlw_time_secs_lo_bits)

static long mlw_time_sec(mlval arg)
{
  double secs= ((double)CINT(FIELD(arg, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(arg, 1));
  return (long)secs;
}

static mlval mlw_time_from_ints(unsigned long secs_hi, unsigned long secs_lo, unsigned long nsecs100)
{
  mlval mltime= allocate_record(3);
  FIELD(mltime, 0)= MLINT(secs_hi);
  FIELD(mltime, 1)= MLINT(secs_lo);
  FIELD(mltime, 2)= MLINT(nsecs100);
  return mltime;
}

mlval mlw_time_from_double(double time)
{
  unsigned long secs_hi= (unsigned long)(time/mlw_time_secs_lo_val);
  unsigned long secs_lo= (unsigned long)fmod(time,mlw_time_secs_lo_val);
  unsigned long nsecs100= (unsigned long)((time-floor(time))*mlw_time_ticks_per_sec);
  return mlw_time_from_ints(secs_hi, secs_lo, nsecs100);
}

mlval mlw_time_from_file_time(FILETIME *ft)
{
  double ticks= ((double)ft->dwHighDateTime)*mlw_time_2_to_32 + (double)(ft->dwLowDateTime);
  double time= ticks/mlw_time_ticks_per_sec;
  return mlw_time_from_double(time);
}

/* 
 * This is external since it is needed to implement OS.FileSys.setTime
 */
void mlw_time_to_file_time(mlval time, FILETIME *ft)
{
  double secs= ((double)CINT(FIELD(time, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(time, 1));
  double nsec100s= (double)CINT(FIELD(time, 2));
  double ticks= secs*(double)mlw_time_ticks_per_sec + nsec100s;
  ft->dwHighDateTime= (DWORD)(ticks/mlw_time_2_to_32);
  ft->dwLowDateTime= (DWORD)(fmod(ticks,mlw_time_2_to_32));
  /* Possible loss of precision here, so we increment by 2 */
  ft->dwLowDateTime+=2;
  if (ft->dwLowDateTime < 2) ft->dwHighDateTime++;
}

/* 
 * This is external since it is needed to implement OS.IO.poll
 */
void mlw_time_to_timeval(mlval time, struct timeval *tv)
{
  double secs= ((double)CINT(FIELD(time, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(time, 1));
  double nsec100s= (double)CINT(FIELD(time, 2));
  tv->tv_sec= (long)secs;
  tv->tv_usec= (long)(nsec100s/10.0);
}

#define mlw_time_low_bits 24
extern mlval mlw_time_make(long sec, long usec)
{
  mlval t= allocate_record(3);
  unsigned long hi= ((unsigned long)sec) >> mlw_time_low_bits;
  unsigned long lo= ((unsigned long)sec) & ((1<<(mlw_time_low_bits+1))-1);
  FIELD(t, 0)= MLINT(hi);
  FIELD(t, 1)= MLINT(lo);
  FIELD(t, 2)= MLINT(usec);
  return t;
}

/*
 * Time.fromReal: real -> time
 * raises: Time
 */
static mlval mlw_time_from_real(mlval arg)
{
  double time= GETREAL(arg);
  if (time < 0.0 || time > ((double)ULONG_MAX)*((double)ULONG_MAX))
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_from_double(time);
}

/*
 * Time.toReal: time -> real
 */
static mlval mlw_time_to_real(mlval arg)
{
  double secs= ((double)CINT(FIELD(arg, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(arg, 1));
  double nsecs100= (double)CINT(FIELD(arg, 2));
  mlval time= allocate_real();
  double real_time= secs + (nsecs100/mlw_time_ticks_per_sec);
  return SETREAL(time, real_time);
}

/*
 * Time.toSeconds: time -> int
 */
static mlval mlw_time_to_secs(mlval arg)
{
  double secs= ((double)CINT(FIELD(arg, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(arg, 1));
  if (secs > (double)ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  return MLINT((int)secs);
}

/*
 * Time.toMilliseconds: time -> int
 */
static mlval mlw_time_to_msecs(mlval arg)
{
  double secs= ((double)CINT(FIELD(arg, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(arg, 1));
  double nsecs100= (double)CINT(FIELD(arg, 2));
  double real_time= secs + (nsecs100/mlw_time_ticks_per_sec);
  double msecs= real_time*1000.0;
  if (real_time > (double)ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  if (msecs > (double)ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  return MLINT((int)msecs);
}

/*
 * Time.toMicroseconds: time -> int
 */
static mlval mlw_time_to_usecs(mlval arg)
{
  double secs= ((double)CINT(FIELD(arg, 0)))*mlw_time_secs_lo_val + (double)CINT(FIELD(arg, 1));
  double nsecs100= (double)CINT(FIELD(arg, 2));
  double real_time= secs + (nsecs100/mlw_time_ticks_per_sec);
  double usecs= real_time*1000000.0;
  if (real_time > (double)ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  if (usecs > (double)ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  return MLINT((int)usecs);
}

/*
 * Time.fromSeconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_secs(mlval arg)
{
  int secs= CINT(arg);
  if (secs < 0)
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_from_double((double)secs);
}

/*
 * Time.fromMilliseconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_msecs(mlval arg)
{
  int msecs= CINT(arg);
  if (msecs < 0)
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_from_double((double)(msecs/1000));
}

/*
 * Time.fromMicroseconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_usecs(mlval arg)
{
  int usecs= CINT(arg);
  if (usecs < 0)
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_from_double((double)(usecs/1000000));
}

/*
 * Time.+: (time * time) -> time
 * Raises: time
 *
 * If and when a 64-bit addition routines is written, the following
 * should be rewritten to use it.
 * And now it has.
 */
static mlval mlw_time_add(mlval arg)
{
  mlval a= FIELD(arg, 0);
  mlval b= FIELD(arg, 1);
  unsigned long lo_a = CINT(FIELD(a, 2));
  unsigned long lo_b = CINT(FIELD(b, 2));
  unsigned long mid_a = CINT(FIELD(a, 1));
  unsigned long mid_b = CINT(FIELD(b, 1));
  unsigned long hi_a = CINT(FIELD(a, 0));
  unsigned long hi_b = CINT(FIELD(b, 0));
  unsigned long mid_c, hi_c;
  unsigned long lo_c = lo_a + lo_b;
  int carry = lo_c >= mlw_time_ticks_per_sec;
  if (carry) {
    lo_c -= mlw_time_ticks_per_sec;
    mid_b += 1;
  }
  mid_c = mid_a + mid_b;
  carry = mid_c >= mlw_time_secs_lo_val;
  if (carry) {
    mid_c -= mlw_time_secs_lo_val;
    hi_b += 1;
  }
  hi_c = hi_b + hi_a;
  if ((hi_b == 0 && carry) || hi_b > hi_c)
    exn_raise(mlw_time_exn_ref_time);
  /* This would mean time going negative or overflowing */
  return mlw_time_from_ints(hi_c, mid_c, lo_c);
}

/*
 * Time.-: (time * time) -> time
 * Raises: Time
 *
 * If and when a 64-bit subtraction routine is written, the following
 * should be rewritten to use it.
 * And now it has.
 */
static mlval mlw_time_sub(mlval arg)
{
  mlval a= FIELD(arg, 0);
  mlval b= FIELD(arg, 1);
  unsigned long lo_a = CINT(FIELD(a, 2));
  unsigned long lo_b = CINT(FIELD(b, 2));
  unsigned long mid_a = CINT(FIELD(a, 1));
  unsigned long mid_b = CINT(FIELD(b, 1));
  unsigned long hi_a = CINT(FIELD(a, 0));
  unsigned long hi_b = CINT(FIELD(b, 0));
  unsigned long lo_c, mid_c, hi_c;
  int carry = lo_a < lo_b;
  if (carry) {
    lo_a += mlw_time_ticks_per_sec;
    mid_b += 1;
  }
  lo_c = lo_a - lo_b;
  carry = mid_a < mid_b;
  if (carry) {
    mid_a += mlw_time_secs_lo_val;
    hi_b += 1;
  }
  mid_c = mid_a - mid_b;
  if ((hi_b == 0 && carry) || hi_b > hi_a)
    exn_raise(mlw_time_exn_ref_time);
  /* This would mean time going negative or overflowing */
  hi_c = hi_a - hi_b;
  return mlw_time_from_ints(hi_c, mid_c, lo_c);
}

/*
 * Time.now: unit -> time
 * Raises: Time
 */
static mlval mlw_time_now(mlval unit)
{
  SYSTEMTIME system_time;
  FILETIME file_time;
  GetSystemTime(&system_time); 
  if (!SystemTimeToFileTime(&system_time, &file_time))
    exn_raise(mlw_time_exn_ref_time);
  
  return mlw_time_from_file_time(&file_time);
}

#define mlw_date_year_offset 1900

static void mlw_date_to_tm(mlval date, struct tm *tm)
{
  int dst;
  tm->tm_sec=  CINT(mlw_date_sec(date));
  tm->tm_min=  CINT(mlw_date_min(date));
  tm->tm_hour= CINT(mlw_date_hour(date));
  tm->tm_mday= CINT(mlw_date_mday(date));
  tm->tm_mon=  mlw_date_month_ml_to_c[CINT(mlw_date_mon(date))];
  tm->tm_year= CINT(mlw_date_year(date))-mlw_date_year_offset;
  tm->tm_wday= mlw_date_wday_ml_to_c[CINT(mlw_date_wday(date))];
  tm->tm_yday= CINT(mlw_date_yday(date));
  tm->tm_isdst= mlw_option_is_none(mlw_date_isdst(date))
    ? 0
    : CBOOL(mlw_option_some(mlw_date_isdst(date)));
  dst = tm->tm_isdst; /* Remember this, because mk_time will screw it */
  tm->tm_isdst=-1;    /* Need to stop mktime fiddling with the hours */
  (void)mktime(tm); /* Bring all the fields into range */
  tm->tm_isdst = dst; /* Put it back again */
}

static int month_lengths[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};

static int is_leap_year(int year)
{
  return (year % 4 != 0) ? 0 :
         (year % 100 == 0) ? ((year % 400 == 0) ? 1 : 0) : 1;
}

static int yday(int mday, int month, int year)
{
  int i = 0;
  int yday = mday-1; /* Day of month starts at 1 */
  while (i < month) {
    yday += month_lengths[i++];
  }
  if (month > 2 && is_leap_year(year)) yday++;
  return yday;
}


/*
 * Convert a C SYSTEMTIME into an ML `Date.date'.
 * Will set isDst to NONE.
 * Will set offset to supplied value.
 */
static mlval mlw_date_from_system_time(SYSTEMTIME *st, mlval offset)
{
  mlval date;

  assert(st->wDayOfWeek >= mlw_date_wday_min &&
         st->wDayOfWeek <= mlw_date_wday_max);

  declare_root(&offset, 0);
  date= mlw_make_date();
  retract_root(&offset);

  mlw_date_sec(date)= MLINT(st->wSecond);
  mlw_date_min(date)= MLINT(st->wMinute);
  mlw_date_hour(date)= MLINT(st->wHour);
  mlw_date_mday(date)= MLINT(st->wDay);

  assert(st->wMonth-1 >= mlw_date_month_min &&
         st->wMonth-1 <= mlw_date_month_max);

  mlw_date_mon(date)= MLINT(mlw_date_month_c_to_ml[st->wMonth-1]);
  mlw_date_year(date)= MLINT(st->wYear);
  mlw_date_wday(date)= MLINT(mlw_date_wday_c_to_ml[st->wDayOfWeek]);
  mlw_date_yday(date)= MLINT(yday(st->wDay, st->wMonth-1, st->wYear)); 
  mlw_date_isdst(date)= mlw_option_make_none();
  mlw_date_offset(date)= offset;

  return date;
}

static void mlw_date_to_system_time(mlval date, SYSTEMTIME *st)
{
  st->wMilliseconds= 0;
  st->wSecond= CINT(mlw_date_sec(date));
  st->wMinute= CINT(mlw_date_min(date));
  st->wHour=   CINT(mlw_date_hour(date));
  st->wDay=    CINT(mlw_date_mday(date));
  st->wMonth=  mlw_date_month_ml_to_c[CINT(mlw_date_mon(date))]+1;
  st->wYear=   CINT(mlw_date_year(date));
  st->wDayOfWeek=
    mlw_date_wday_ml_to_c[CINT(mlw_date_wday(date))];
}


/*
 * Date.localOffset : unit -> Time.time
 * Raises: Date
 */
static mlval mlw_date_local_offset(mlval arg){
  struct tm *gmt;
  time_t t1, t2;
  double offset;

  t1 = time((time_t)0);
  gmt = gmtime (&t1);
  t2 = mktime(gmt);

  offset = (difftime(t2, t1));
  /* Make sure offset is in the range 0..24 hours */
  if(offset < 0.0)
    offset = (60.0 * 60.0 * 24.0) + offset;

  return mlw_time_from_double(offset);
}


/*
 * Date.fromTimeLocal: Time.time -> Date.date
 */
static mlval mlw_date_from_time_local(mlval arg)
{
  FILETIME ft;
  FILETIME utc_file_time; 
  SYSTEMTIME st;

  mlw_time_to_file_time(arg, &utc_file_time); 
  (void)FileTimeToLocalFileTime(&utc_file_time, &ft); 

  (void)FileTimeToSystemTime(&ft, &st);

  return mlw_date_from_system_time(&st, mlw_option_make_none());
}

/*
 * Date.fromTimeUniv: Time.time -> Date.date
 */
static mlval mlw_date_from_time_univ(mlval arg)
{
  FILETIME utc_file_time;
  SYSTEMTIME st;
  mlval offset;

  mlw_time_to_file_time(arg, &utc_file_time); 
  (void)FileTimeToSystemTime(&utc_file_time, &st);

  /* Returned date should have offset = SOME(time.zeroTime) */
  offset = mlw_option_make_some(mlw_time_from_double(0.0));

  return mlw_date_from_system_time(&st, offset);
}

/*
 * Date.toTime: date -> Time.time
 * Raises: Date
 */
static mlval mlw_date_to_time(mlval date)
{
  /* Within the translation date -> system time -> file time we introduce 
     non-zero fractions of a second, and this is what causes the date test 
     to fail sometimes on NT.  If possible we should replace this mechanism. 
  */ 
  SYSTEMTIME st;
  FILETIME ft, utc_ft;
  mlw_date_to_system_time(date, &st);
  if (!SystemTimeToFileTime(&st, &ft))
    exn_raise(mlw_date_exn_ref_date);
  if (mlw_option_is_none(mlw_date_offset(date))) {
    (void)LocalFileTimeToFileTime(&ft, &utc_ft);
    return mlw_time_from_file_time(&utc_ft);
  } else {
    /* Need to deal with possibility of non-trivial offset here eventually,
       but we only generate dates with the trivial case at the moment. */
    return mlw_time_from_file_time(&ft);
  }
}

/*
 * Date.toString: date -> string
 */
static mlval mlw_date_to_string(mlval date)
{
  struct tm tm;
  char date_string[26], *ascdate, ch;
  int i;
  mlw_date_to_tm(date, &tm);
  ascdate = asctime(&tm);
  /* Win32 has a fault whereby it zero pads the month day,
     instead of space padding */
  /* We sort that out here */
  for (i = 0; i < 26; i++) {
    date_string[i] = ascdate[i];
  }
  ch = ascdate[8];
  date_string[8] = (ch == '0') ? ' ' : ch;
  date_string[24] = '\0'; /* Remove '\n' */
  return ml_string(date_string);
}

static mlval mlw_date_fmt(mlval string_date)
{
  struct tm tm;
  size_t size;
  mlval result = MLUNIT;
  char *format = CSTRING(FIELD(string_date, 0));
  mlw_date_to_tm(FIELD(string_date, 1), &tm);
  for(size=256; result==MLUNIT; size*=2)
  {
    char *buffer = alloc(size, "Unable to allocate buffer for time_format()");
    size_t length = strftime(buffer, size-1, format, &tm);

    if(length > 0)
    {
      result = allocate_string(length+1);
      memcpy(CSTRING(result), buffer, length+1);
    }

    free(buffer);
  }
  return result;
}

static FILETIME start_time;

static mlval mlw_time_start(mlval unit)
{
  return mlw_time_from_file_time(&start_time);
}

void mlw_time_date_init(void)
{
  SYSTEMTIME system_time;
  GetSystemTime(&system_time);
  SystemTimeToFileTime(&system_time, &start_time);
  mlw_time_exn_ref_time = ref(exn_default);
  mlw_date_exn_ref_date = ref(exn_default);
  env_value("Time.Time", mlw_time_exn_ref_time);
  env_value("Date.Date", mlw_date_exn_ref_date);
  declare_global("Time.Time", &mlw_time_exn_ref_time,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  declare_global("Date.Date", &mlw_date_exn_ref_date,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  env_function("Time.fromReal", mlw_time_from_real);
  env_function("Time.toReal", mlw_time_to_real);

  env_function("Time.toSeconds", mlw_time_to_secs);
  env_function("Time.toMilliseconds", mlw_time_to_msecs);
  env_function("Time.toMicroseconds", mlw_time_to_usecs);

  env_function("Time.fromSeconds", mlw_time_from_secs);
  env_function("Time.fromMilliseconds", mlw_time_from_msecs);
  env_function("Time.fromMicroseconds", mlw_time_from_usecs);

  env_function("Time.+", mlw_time_add);
  env_function("Time.-", mlw_time_sub);

  env_function("Time.now", mlw_time_now);
  env_function("Time.start", mlw_time_start);

  env_function("Date.localOffset", mlw_date_local_offset);
  env_function("Date.fromTimeLocal", mlw_date_from_time_local);
  env_function("Date.fromTimeUniv",  mlw_date_from_time_univ);
  env_function("Date.toTime",   mlw_date_to_time);
  env_function("Date.toString", mlw_date_to_string);
  env_function("Date.fmt", mlw_date_fmt);

}
