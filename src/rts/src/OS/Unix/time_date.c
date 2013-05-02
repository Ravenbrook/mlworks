/* Copyright 1996 The Harlequin Group Limited.  All rights reserved.
 *
 * Implements various parts of basis/time.sml and basis/date.sml
 *
 * Note that for all Unix varieties you will need to create 
 * rts/src/OS/$ARCH/$OS/time_date_local.h which contains a declaration
 * of the form 
 *
 *   extern int mlw_get_time_now(struct timeval *)
 *
 * which does the equivalent of gettimeofday.  Note the reason that
 * gettimeofday is not used directly is that it seems to have a different
 * prototype on each system, mlw_get_time_now is supposed to hide these
 * differences.
 *
 * Revision Log
 * ------------
 *
 * $Log: time_date.c,v $
 * Revision 1.12  1998/02/23 18:47:53  jont
 * [Bug #70018]
 * Modify declare_root to accept a second parameter
 * indicating whether the root is live for image save
 *
 * Revision 1.11  1997/11/19  20:54:24  jont
 * [Bug #30085]
 * Add Time.start function to give value of Time.now when process started
 *
 * Revision 1.10  1997/09/30  11:23:09  daveb
 * [Bug #30269]
 * Added declare root to Bruce's change.
 *
 * Revision 1.9  1997/09/25  09:11:29  brucem
 * [Bug #30269]
 * Implement routines for revised Date structure.
 *
 * Revision 1.8  1996/10/02  11:32:19  stephenb
 * [Bug #1629]
 * mlw_time_add: corrected so that only overflows if the number
 * of seconds goes out of the range representable by the OS.
 *
 * Revision 1.7  1996/07/29  13:55:13  stephenb
 * [Bug #1506]
 * mlw_time_sub: fixed the code that dealt with the case where
 * a_usecs < b_usecs -- the previous code was hopelessly wrong.
 *
 * Revision 1.6  1996/05/16  14:02:49  jont
 * Allow ML dates to have full year value, ie 19xx rather than xx
 *
 * Revision 1.5  1996/05/14  13:49:21  nickb
 * Remove my_asctime.
 *
 * Revision 1.4  1996/05/10  12:34:57  jont
 * Fix problem whereby mk_time fiddles with tm_isdst
 *
 * Revision 1.3  1996/05/10  11:48:38  stephenb
 * Fix the time conversion routines to take account of
 * * Unix starting years at 1900.
 * * mapping C months and weekdays into ML months and weekdays
 * * daylight savings time.
 *
 * Revision 1.2  1996/05/09  16:03:52  jont
 * Completing implementation of __date.sml
 *
 * Revision 1.1  1996/05/07  10:53:39  stephenb
 * new unit
 *
 */

#include <assert.h>
#include <sys/time.h>		/* struct timeval, mktime, ... */
#include <limits.h>		/* LONG_MAX ... */
#include "alloc.h"		/* free */
#include "allocator.h"		/* allocate_real, allocate_record */
#include "date.h"		/* mlw_date_hour ... */
#include "exceptions.h"		/* exn_raise, perv_exn_ref_overflow */
#include "environment.h"	/* env_value ... */
#include "global.h"		/* declare_global */
#include "gc.h"			/* declare_root, retract_root */
#include "utils.h" 		/* alloc */
#include "values.h"		/* mlw_option_XXX */
#include "time_date.h"
#include "time_date_init.h"	/* mlw__get_time_now */
#include "time_date_local.h"




static mlval mlw_time_exn_ref_time;
static mlval mlw_date_exn_ref_date;



/* The tv_sec field is a full 32-bit value which can't fit into an ML int
 * so it is split across two fields.  The following defines how many of
 * the low bits of the tv_sec field are stored in the first of the two
 * fields. 
 *
 * The current value is historic and is taken directly from 
 * rts/src/OS/{Irix,Linux,Solaris,SunOS}/time.c
 */

#define mlw_time_low_bits 24


extern long mlw_time_sec(mlval arg)
{
  unsigned long hi= CWORD(FIELD(arg, 0));
  unsigned long lo= CWORD(FIELD(arg, 1));
  long secs= (long)((hi<<mlw_time_low_bits)|lo);
  return secs;
}



extern long mlw_time_usec(mlval arg)
{
  long usec= CINT(FIELD(arg, 2));
  return usec;
}



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
  long secs, usecs;

  if (time < 0 || time > LONG_MAX)
    exn_raise(mlw_time_exn_ref_time);

  secs= time;
  usecs= (long)((time - (double)secs)*1000000.0);
  return mlw_time_make(secs, usecs);
}



/*
 * Time.toReal: time -> real
 */
static mlval mlw_time_to_real(mlval arg)
{
  long secs= mlw_time_sec(arg);
  long usecs= mlw_time_usec(arg);
  mlval time= allocate_real();
  (void)SETREAL(time, secs+usecs/1000000.0);
  return time;
}



/*
 * Time.toSeconds: time -> int
 * Raises: Overflow
 */
static mlval mlw_time_to_secs(mlval arg)
{
  long secs= mlw_time_sec(arg);
  if (secs > ML_MAX_INT)
    exn_raise(perv_exn_ref_overflow);
  return MLINT(secs);
}




/*
 * Time.toMilliseconds: time -> int
 * Raises: Overflow
 */
static mlval mlw_time_to_msecs(mlval arg)
{
  long secs= mlw_time_sec(arg);
  long usecs= mlw_time_usec(arg);
  long msecs= usecs/mlw_time_msecs_per_sec;
  if (secs > ML_MAX_INT/mlw_time_msecs_per_sec)
    exn_raise(perv_exn_ref_overflow);
  if (msecs > (ML_MAX_INT - secs*mlw_time_msecs_per_sec))
    exn_raise(perv_exn_ref_overflow);
  return MLINT(secs*1000+msecs);
}



/*
 * Time.toMicroseconds: time -> int
 * Raises: Overflow
 */
static mlval mlw_time_to_usecs(mlval arg)
{
  long secs= mlw_time_sec(arg);
  long usecs= mlw_time_usec(arg);

  if (secs > ML_MAX_INT/mlw_time_usecs_per_sec)
    exn_raise(perv_exn_ref_overflow);

  if (usecs > (ML_MAX_INT - secs*mlw_time_usecs_per_sec))
    exn_raise(perv_exn_ref_overflow);

  return MLINT(secs*mlw_time_usecs_per_sec+usecs);
}



/*
 * Time.fromSeconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_secs(mlval arg)
{
  long secs= CINT(arg);
  if (secs < 0)
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_make(secs, 0);
}



/*
 * Time.fromMilliseconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_msecs(mlval arg)
{
  long msecs= CINT(arg);
  if (msecs < 0) {
    exn_raise(mlw_time_exn_ref_time);
  } else {
    long secs=  msecs/mlw_time_msecs_per_sec;
    long usecs= (msecs%mlw_time_msecs_per_sec)*mlw_time_msecs_per_sec;
    return mlw_time_make(secs, usecs);
  }
}



/*
 * Time.fromMicroseconds: int -> time
 * Raises: Time
 */
static mlval mlw_time_from_usecs(mlval arg)
{
  long usecs= CINT(arg);
  if (usecs < 0) {
    exn_raise(mlw_time_exn_ref_time);
  } else {
    long secs=  usecs/mlw_time_usecs_per_sec;
    long normalised_usecs= usecs%mlw_time_usecs_per_sec;
    return mlw_time_make(secs, normalised_usecs);
  }
}



/*
 * Time.+: (time * time) -> time
 * Raises: Overflow
 */
static mlval mlw_time_add(mlval arg)
{
  long a_sec= mlw_time_sec(FIELD(arg, 0));
  long a_usec= mlw_time_usec(FIELD(arg, 0));
  long b_sec= mlw_time_sec(FIELD(arg, 1));
  long b_usec= mlw_time_usec(FIELD(arg, 1));
  long usecs= a_usec + b_usec;
  long secs= b_sec;


  /* cheaper than but equivalent to:
   *    secs += usecs/mlw_time_usecs_per_sec;
   *    usecs %= mlw_time_usecs_per_sec
   */
  if (usecs > mlw_time_usecs_per_sec) {
    secs += 1;  usecs -= mlw_time_usecs_per_sec;
  }

  if ((LONG_MAX - a_sec) < secs)
    exn_raise(perv_exn_ref_overflow);
  
  return mlw_time_make(a_sec+secs, usecs);
}


/*
 * Time.-: (time * time) -> time
 * Raises: Time
 */
static mlval mlw_time_sub(mlval arg)
{
  long a_secs= mlw_time_sec(FIELD(arg, 0));
  long a_usecs= mlw_time_usec(FIELD(arg, 0));
  long b_secs= mlw_time_sec(FIELD(arg, 1));
  long b_usecs= mlw_time_usec(FIELD(arg, 1));
  long secs= a_secs - b_secs;
  long usecs= a_usecs - b_usecs;

  if (secs < 0)
    exn_raise(mlw_time_exn_ref_time);

  if (usecs < 0) {
    if ((secs -= 1) < 0)
      exn_raise(mlw_time_exn_ref_time);
    usecs= (mlw_time_usecs_per_sec - b_usecs) + a_usecs;
  }
  return mlw_time_make(secs, usecs);
}



/*
 * Time.now: unit -> time
 * Raises: Time
 */
static mlval mlw_time_now(mlval unit)
{
  struct timeval tv;
  if (mlw_get_time_now(&tv) < 0)
    exn_raise(mlw_time_exn_ref_time);
  return mlw_time_make(tv.tv_sec, tv.tv_usec);
}


#define mlw_date_year_offset 1900

/*
 * Convert a C `struct tm' into an ML `Date.date'.
 * Will set isDst to the value in the C structure.
 * Will set offset to supplied value.
 */
static mlval mlw_tm_to_date(struct tm *tm, mlval offset)
{
  mlval isdst,  date;

  assert(tm->tm_wday >= mlw_date_wday_min && tm->tm_wday <= mlw_date_wday_max);

  declare_root(&offset, 0);
  isdst= mlw_option_make_some(tm->tm_isdst > 0 ? MLTRUE : MLFALSE);
  declare_root(&isdst, 0);

  date= mlw_make_date();
  mlw_date_sec(date)= MLINT(tm->tm_sec);
  mlw_date_min(date)= MLINT(tm->tm_min);
  mlw_date_hour(date)= MLINT(tm->tm_hour);
  mlw_date_mday(date)= MLINT(tm->tm_mday);
  assert(tm->tm_mon >= mlw_date_month_min && tm->tm_mon <= mlw_date_month_max);
  mlw_date_mon(date)= MLINT(mlw_date_month_c_to_ml[tm->tm_mon]);
  mlw_date_year(date)= MLINT(tm->tm_year+mlw_date_year_offset);
  mlw_date_wday(date)= MLINT(mlw_date_wday_c_to_ml[tm->tm_wday]);
  mlw_date_yday(date)= MLINT(tm->tm_yday);
  mlw_date_isdst(date)= isdst;
  mlw_date_offset(date) = offset;
  retract_root(&isdst);
  retract_root(&offset);
  return date;
}


/*
 * Date.localOffset : unit -> Time.time
 * Raises: Date
 */
static mlval mlw_date_local_offset(mlval arg){
  struct tm *gmt;
  time_t t1, t2;
  double offset;
  long secs, usecs;

  t1 = time((time_t)0);
  gmt = gmtime (&t1);
  t2 = mktime(gmt);

  offset = (difftime(t2, t1));

  /* Convert the double into an ML Time.time.
     The code is the same as for Time.fromReal */
  if (offset < 0 || offset > LONG_MAX)
    exn_raise(mlw_date_exn_ref_date);

  secs= offset;
  usecs= (long)((offset - (double)secs)*1000000.0);
  return mlw_time_make(secs, usecs);
}

/*
 * Date.fromTimeLocal: Time.time -> Date.date
 */
static mlval mlw_date_from_time_local(mlval arg)
{
  time_t secs= (time_t)mlw_time_sec(arg);
  struct tm *tm= localtime(&secs);
  return mlw_tm_to_date(tm, mlw_option_make_none());
}


/*
 * Date.fromTimeUniv: Time.time -> Date.date
 */
static mlval mlw_date_from_time_univ(mlval arg)
{
  mlval offset;
  time_t secs= (time_t)mlw_time_sec(arg);
  struct tm *tm= gmtime(&secs);

  /* Set up offset */
  offset = mlw_option_make_some(mlw_time_make(0, 0));

  return mlw_tm_to_date(tm, offset);
}




static void mlw_date_to_tm(mlval date, struct tm *tm)
{
  int dst, year;

  tm->tm_sec=  CINT(mlw_date_sec(date));
  tm->tm_min=  CINT(mlw_date_min(date));
  tm->tm_hour= CINT(mlw_date_hour(date));
  tm->tm_mday= CINT(mlw_date_mday(date));
  tm->tm_mon=  mlw_date_month_ml_to_c[CINT(mlw_date_mon(date))];
  year = CINT(mlw_date_year(date))-mlw_date_year_offset;
  if(year<0)
    exn_raise(mlw_date_exn_ref_date);

  tm->tm_year= year;
  tm->tm_wday= 
          mlw_date_wday_ml_to_c[CINT(mlw_date_wday(date))];
  tm->tm_yday= CINT(mlw_date_yday(date));
  tm->tm_isdst= mlw_option_is_none(mlw_date_isdst(date))
    ? 0
    : CBOOL(mlw_option_some(mlw_date_isdst(date)));

  dst = tm->tm_isdst; /* Remember this, because mk_time will screw it */
  tm->tm_isdst=-1;    /* Need to stop mktime fiddling with the hours */
  (void)mktime(tm);   /* Bring all the fields into range */
  tm->tm_isdst = dst; /* Put it back again */
}



/*
 * Date.toTime: date -> Time.time
 * Raises: Date
 */
static mlval mlw_date_to_time(mlval date)
{
  struct tm tm;
  time_t time;

  mlw_date_to_tm(date, &tm);
  time = mktime(&tm);
  if(time==(time_t)-1) /* If the calendar time cannot be represented. */
    exn_raise(mlw_date_exn_ref_date);

  return mlw_time_make(time, 0);
}

/*
 * Date.toString: date -> string
 */
static mlval mlw_date_to_string(mlval date)
{
  char *result;

  struct tm tm;
  mlw_date_to_tm(date, &tm);
  result = (asctime(&tm));
  result[24] = '\0'; /* remove the '\n' from the end. */

  return ml_string(result);
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

static struct timeval start_time;

static mlval mlw_time_start(mlval unit)
{
  return mlw_time_make(start_time.tv_sec, start_time.tv_usec);
}

void mlw_time_date_init(void)
{
  mlw_get_time_now(&start_time);
  mlw_time_exn_ref_time = ref(exn_default);
  mlw_date_exn_ref_date = ref(exn_default);
  env_value("Time.Time", mlw_time_exn_ref_time);
  env_value("Date.Date", mlw_date_exn_ref_date);
  declare_global("Time.Time", &mlw_time_exn_ref_time,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);
  declare_global("Date.Date", &mlw_date_exn_ref_date,
		 GLOBAL_DEFAULT, NULL, NULL, NULL);

  env_function("Time.fromReal", mlw_time_from_real);
  env_function("Time.toReal",   mlw_time_to_real);

  env_function("Time.toSeconds",      mlw_time_to_secs);
  env_function("Time.toMilliseconds", mlw_time_to_msecs);
  env_function("Time.toMicroseconds", mlw_time_to_usecs);

  env_function("Time.fromSeconds",      mlw_time_from_secs);
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
