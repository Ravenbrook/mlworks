/*  Copyright (C) 1996 Harlequin Ltd.
 *
 * Various values that are common to the date parts of
 * rts/src/OS/{Unix,Win32}/time_date.c
 *
 *  Revision Log
 *  ------------
 *  $Log: date.h,v $
 *  Revision 1.3  1997/09/23 14:25:48  brucem
 *  [Bug #30269]
 *  Date.date datatype has changed, change macros for extracting values.
 *
 * Revision 1.2  1996/05/10  11:01:45  stephenb
 * Add a mapping from C month to ML month.
 * and from C weekday to ML weekday.
 *
 * Revision 1.1  1996/05/09  15:44:04  jont
 * new unit
 *
 */


#ifndef date_h
#define date_h

#include "values.h"

#define mlw_make_date() allocate_record(10)

#define mlw_date_month_min 0
#define mlw_date_month_max 11
static int mlw_date_month_c_to_ml[]= {4, 3, 7, 0, 8, 6, 5, 1, 11, 10, 9, 2};
static int mlw_date_month_ml_to_c[]= {3, 7, 11, 1, 0, 6, 5, 2, 4, 10, 9, 8};

#define mlw_date_wday_min 0
#define mlw_date_wday_max 6
static int mlw_date_wday_c_to_ml[]= {3, 1, 5, 6, 4, 0, 2};
static int mlw_date_wday_ml_to_c[]= {5, 1, 6, 0, 4, 2, 3};


/* Note: mday is `day' in ML, so it comes first in alphabetical order */

#define mlw_date_hour(date)   (FIELD(date, 1))
#define mlw_date_isdst(date)  (FIELD(date, 2))
#define mlw_date_mday(date)   (FIELD(date, 0))
#define mlw_date_min(date)    (FIELD(date, 3))
#define mlw_date_mon(date)    (FIELD(date, 4))
#define mlw_date_offset(date) (FIELD(date, 5))
#define mlw_date_sec(date)    (FIELD(date, 6))
#define mlw_date_wday(date)   (FIELD(date, 7))
#define mlw_date_yday(date)   (FIELD(date, 8))
#define mlw_date_year(date)   (FIELD(date, 9))

#endif
