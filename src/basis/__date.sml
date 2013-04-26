(*  ==== INITIAL BASIS : Date structure ====
 *
 *  Copyright (C) 1995 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: __date.sml,v $
 *  Revision 1.15  1999/02/12 16:17:50  mitchell
 *  [Bug #190507]
 *  Use PreStringCvt instead of StringCvt
 *
 * Revision 1.14  1999/02/02  15:57:44  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.13  1998/10/02  13:07:50  jont
 * [Bug #30487]
 * Modify to cope with use of LargeInt.int in Time
 *
 * Revision 1.12  1997/09/25  10:13:20  brucem
 * [Bug #30269]
 * DATE signature has been revised.  Change structure to new specification.
 *
 * Revision 1.11  1997/05/06  15:47:57  daveb
 * [Bug #30112]
 * Changed uncurry_fmt to a value.
 *
 * Revision 1.10  1997/03/03  12:05:39  daveb
 * [Bug #1937]
 * Corrected type of scan.
 *
 * Revision 1.9  1996/10/03  15:31:13  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.8  1996/06/04  17:59:29  io
 * stringcvt -> string_cvt
 *
 * Revision 1.7  1996/05/30  11:33:01  daveb
 * ord is now at top level.
 *
 * Revision 1.6  1996/05/16  13:43:17  jont
 * Include some date clamping to avoid runtime failures
 * Use full representation of year within dates
 *
 * Revision 1.5  1996/05/15  12:46:42  jont
 * pack_words moved to pack_word
 *
 * Revision 1.4  1996/05/10  16:53:21  jont
 * Fix problems in scan
 *
 * Revision 1.3  1996/05/09  17:20:44  jont
 * Bring up to latest revision of basis
 *
 * Revision 1.2  1996/05/02  10:05:48  stephenb
 * Update wrt change in Time implementation.
 * Also partially reimplemented it inline with the lastest basis definition.
 *
 * Revision 1.1  1996/04/18  11:25:36  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  13:15:51  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "../system/__time";
require "date";
require "__string";
require "__pre_string_cvt";
require "__pre_basis";
require "__int";

(* This makes use of routines in the runtime system for
     Date.localOffset
     Date.fromTimeLocal
     Date.fromTimeUniv
     Date.toTime
     Date.toString
   The rts routines will be sensitive to any changes in the 
   datatypes within this structure.
 *)

structure Date : DATE =
  struct


    val env = MLWorks.Internal.Runtime.environment


    datatype weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun
      
    datatype month = Jan | Feb | Mar | Apr | May | Jun
                   | Jul | Aug | Sep | Oct | Nov | Dec


    (* ``date value represents an instant in a particular time zone,''
       it contains the timezone (as a Time.time option, representing
       the time west from GMT (NONE is local-time), and the logical date. *)
    (* The user cannot manipulate dates directly.  All values of type date
       should be valid (internally consistent). *)
    datatype date = DATE of
      {
       year : int, (* e.g. 1997 *)
       month : month,
       day : int, (* day of month, 1st is day 1 *)
       hour : int,
       minute : int,
       second : int,
       wday : weekday,
       yday : int, (* day of the year, 1st Jan. is day 1. *)
       offset : Time.time option, (* Time west of GM, in range 0..24 hrs *)
       isDst : bool option
       }


    (* Exception `Date' is raised if an invalid date is encountered
       or would be produced. *)
    exception Date
    val dateRef : exn ref = env "Date.Date"
    val _ = dateRef := Date


    (* Extractors: *)
    fun year (DATE{year, ...}) = year
    fun month (DATE{month, ...}) = month
    fun day (DATE{day, ...}) = day
    fun hour (DATE{hour, ...}) = hour
    fun minute (DATE{minute, ...}) = minute
    fun second (DATE{second, ...}) = second
    fun weekDay (DATE{wday, ...}) = wday
    fun yearDay (DATE{yday, ...}) = yday
    fun isDst (DATE{isDst, ...}) = isDst 
    fun offset (DATE{offset, ...}) = offset
    

    local (* Local functions for function `date' *)

      (* Functions to convert a date into canonical form.
       * Assumptions:
       *   Gregorian calendar
       *   Leap years every 4 years, excluding centuries; also every 400 years
       *   Ignores leap seconds
       *   Ignores Daylight Saving Time
       *)

      fun leapYear year = 
        (year mod 4 = 0 andalso year mod 100 <> 0) orelse
        year mod 400 = 0

      fun dayOfWeek 0 = Mon
      |   dayOfWeek 1 = Tue
      |   dayOfWeek 2 = Wed
      |   dayOfWeek 3 = Thu
      |   dayOfWeek 4 = Fri
      |   dayOfWeek 5 = Sat
      |   dayOfWeek 6 = Sun
      |   dayOfWeek _ = raise Fail "dayOfWeek"

      (*
         offset must be between 0 and 24 hours.
         This function returns canonical offset and excess time
         to be added to the date.
         If you claim to be in timezone with offset=25 hours then
         the result date will be in timezone with offset=1 hour and
         the rest of the date will be one day ahead.
       *)
      fun makeOffset NONE = (NONE, 0)
        | makeOffset (SOME offset) = 
          let
            val secs = Time.toSeconds offset
            val offsetSecs = secs mod (60 * 60 * 24)
            val excessSecs = secs - offsetSecs
            val offset' = Time.fromSeconds offsetSecs
          in
            (SOME offset', excessSecs)
          end

      (* This implementation of dayToYear is based on the calendar facility
       * distributed with GNU emacs.  The emacs code was written by
       * Edward M. Reingold.
       *)
      fun dayToYear (day, year) =
        if year <= 0 then
          raise Date
        else
          let

            (* First, convert the year into a number of days since the
               imaginary date Sunday, December 31, 1 BC.  That's what the
               emacs code claims, but we seem to have day
               0 = Monday, Jan 1, 1 AD.  Maybe they count their days from 1. *)

            val priorYears = year - 1
            val absYear =
               365 * priorYears +    (* Days in prior years *)
               priorYears div 4 -    (* Julian leap years *)
               priorYears div 100 +  (* Century years *)
               priorYears div 400    (* Gregorian leap years *)

            (* Now adjust this by the number of days in this year. *)
            val absDay = Int.toLarge absYear + day

            (* The day of the week is now easy. *)
            val weekDay = dayOfWeek (Int.fromLarge((absDay-1) mod 7))

            (* Now convert the absolute number of days into the real year
               and day.  See the footnote on page 384 of ``Calendrical
               Calculations, Part II: Three Historical Calendars'' by
               E. M. Reingold,  N. Dershowitz, and S. M. Clamen,
               Software--Practice and Experience, Volume 23, Number 4
               (April, 1993), pages 383-404 for an explanation. *)

            val oneYear = 365
            val fourYears = 4 * oneYear + 1
            val oneHundredYears = 25 * fourYears - 1 
            val fourHundredYears = 4 * oneHundredYears + 1
            val d0 = absDay - 1
            val n400 = d0 div fourHundredYears (* number of 400 years *)
            val d1 = d0 mod fourHundredYears (* part of 400 years *)
            val n100 = d1 div oneHundredYears (* number of 100 years (0..3) *)
            val d2 = d1 mod oneHundredYears (* part of 100 years *)
            val n4 = d2 div fourYears (* number of 4 years (0..24) *)
            val d3 = d2 mod fourYears (* part of 4 years *)
            val n1 = d3 div oneYear (* number of years (0..3) *)
            val day' = d3 mod oneYear + 1 (* part of year (1.. ) *)
            val year' = n400 * 400 + n100 * 100 + n4 * 4 + n1
          in
	    (weekDay, Int.fromLarge day', Int.fromLarge(year' + 1))
          end (* of fun dayToYear *)

      val months =
        [(Jan,31),
         (Feb,28),
         (Mar,31),
         (Apr,30),
         (May,31),
         (Jun,30),
         (Jul,31),
         (Aug,31),
         (Sep,30),
         (Oct,31),
         (Nov,30),
         (Dec,31)]

      val leapMonths =
        [(Jan,31),
         (Feb,29),
         (Mar,31),
         (Apr,30),
         (May,31),
         (Jun,30),
         (Jul,31),
         (Aug,31),
         (Sep,30),
         (Oct,31),
         (Nov,30),
         (Dec,31)]

      fun dayToMonth' (day, []) =
            raise Fail ("dayToMonth excess="^(Int.toString day))
      |   dayToMonth' (day, (month,length) :: l) =
            if day <= length then
              (day, month) (* Both year and month days number from 1 *)
            else
              dayToMonth' (day - length, l)

      (* Given (day in year, year) return (day in month, month) *)
      fun dayToMonth (day, year) = 
            if leapYear year then
              dayToMonth' (day, leapMonths)
            else
              dayToMonth' (day, months)

      fun mkYearDay' (month, day, []) = raise Fail "yearDay'"
      |   mkYearDay' (month, day, (month', length) :: l) =
            if month = month' then
                day (* Both month and year days number from 1 *)
            else
              mkYearDay' (month, day + length, l)

      (* mkYearDay : int * Month * int -> int
         Usage: mkYearDay (year, month, dayOfMonth)
                Returns the day of the year for the given date. *)
      fun mkYearDay (year, month, day) =
            if leapYear year then
              mkYearDay' (month, day, leapMonths)
            else
              mkYearDay' (month, day, months)

    in

      (* Offset is not checked for validity or manipulated in any way.
         Perhaps it should be range checked? *)

      fun date {year, month, day, hour, minute, second, offset} =
        let
          val (offset', excessSecs) = makeOffset offset
          val yday = mkYearDay (year, month, day)
          val second' = Int.toLarge second + excessSecs
          val (second'', adjMinute) = (Int.fromLarge(second' mod 60),
				       Int.toLarge minute + second' div 60)
          val (minute', adjHour) = (Int.fromLarge(adjMinute mod 60),
				    Int.toLarge hour + adjMinute div 60)
          val (hour', adjDay) = (Int.fromLarge(adjHour mod 24), Int.toLarge yday + adjHour div 24)
          val (wday', yday', year') = dayToYear (adjDay, year)
          val (day', month') = dayToMonth (yday', year')
        in
          DATE
            {year = year', month = month', day = day',
             hour = hour' , minute = minute', second = second'',
             wday = wday', yday = yday',
             offset = offset', isDst = NONE}
        end (* of fun date *)

    end (* of local surrounding fun date *)


    val localOffset   : unit      -> Time.time = env "Date.localOffset"

    val fromTimeLocal : Time.time -> date      = env "Date.fromTimeLocal"

    val fromTimeUniv  : Time.time -> date      = env "Date.fromTimeUniv"

    val toTime        : date      -> Time.time = env "Date.toTime"

    val toString      : date      -> string    = env "Date.toString"


    local (* functions for function fromString *)

      fun ignore_space((s, i, size)) =
        if i >= size then
          i
        else
          let
            val ch = String.sub(s, i)
          in
            if PreBasis.isSpace ch then ignore_space(s, i+1, size) else i
          end

      val ignore_space = fn (s, i) => ignore_space(s, i, size s)

      fun check_space(s, i) =
        if i >= size s orelse String.sub(s, i) <> #" " then raise Date else ()
        
      fun three_char_string(s, i) = String.substring(s, i, 3)
      
      (* We must check that a valid day is given, though the result
         of this is not actually used. *)
      fun day_of_string "Mon" = Mon
        | day_of_string "Tue" = Tue
        | day_of_string "Wed" = Wed
        | day_of_string "Thu" = Thu
        | day_of_string "Fri" = Fri
        | day_of_string "Sat" = Sat
        | day_of_string "Sun" = Sun
        | day_of_string _ = raise Date

      fun mon_of_string "Jan" = Jan
        | mon_of_string "Feb" = Feb
        | mon_of_string "Mar" = Mar
        | mon_of_string "Apr" = Apr
        | mon_of_string "May" = May
        | mon_of_string "Jun" = Jun
        | mon_of_string "Jul" = Jul
        | mon_of_string "Aug" = Aug
        | mon_of_string "Sep" = Sep
        | mon_of_string "Oct" = Oct
        | mon_of_string "Nov" = Nov
        | mon_of_string "Dec" = Dec
        | mon_of_string _ = raise Date

      fun digit_to_int #"0" = 0
        | digit_to_int #"1" = 1
        | digit_to_int #"2" = 2
        | digit_to_int #"3" = 3
        | digit_to_int #"4" = 4
        | digit_to_int #"5" = 5
        | digit_to_int #"6" = 6
        | digit_to_int #"7" = 7
        | digit_to_int #"8" = 8
        | digit_to_int #"9" = 9
        | digit_to_int _ = raise Date

      fun read_mon_day(s, i) =
        let
          val ch = String.sub(s, i)
          val ch' = String.sub(s, i+1)
          val d = digit_to_int ch'
        in
          if ch = #" " then d else d + 10*digit_to_int ch
        end

      fun read_two_digits(s, i) =
        if i+1 >= size s then
          raise Date
        else
          10*digit_to_int(String.sub(s, i)) + digit_to_int(String.sub(s, i+1))

      fun check_colon(s, i) =
        if i >= size s orelse String.sub(s, i) <> #":" then raise Date else ()

      fun check_size(s, i) = if i + 24 <= size s then () else raise Date

    in
      
      (* Input to fromString must be of form
          "Mon Sep 22 11:05:51 1997"
         i.e. a `24 character date.'  If input is not of this form or
         cannot be represented as a date then NONE is returned.
         The function will not raise Date. *)

      fun fromString s =
        let
          val i = ignore_space(s, 0)
          val _ = check_size(s, i)
          val wday = three_char_string(s, i)
          val _ = check_space(s, i+3)
          val mon = three_char_string(s, i+4)
          val month = mon_of_string mon
          val _ = check_space(s, i+7)
          val mon_day = read_mon_day(s, i+8)	  
          val _ = check_space(s, i+10)
          val hour = read_two_digits(s, i+11)
          val _ = check_colon(s, i+13)
          val min = read_two_digits(s, i+14)
          val _ = check_colon(s, i+16)
          val sec = read_two_digits(s, i+17)
          val _ = check_space(s, i+19)
          val hi_year = read_two_digits(s, i+20)
          val lo_year = read_two_digits(s, i+22)
          val year = if hi_year <19 then
                       raise Date
                     else
                       hi_year*100+lo_year
        in

          (* Basis specification says:
               ``[Date.fromString] ignores the weekday (if supplied)
               and recomputes it on the basis of other fields.''
             So we call date to make the date.
             This will also make the date canonical and do range
             checks. *)
          SOME
            (date{year = year, month = month, day = mon_day,
                  hour = hour, minute = min, second = sec,
                  offset = NONE})

        end
        handle Date => NONE
      (* end of fun fromString *)

    end (* of local surrounding fun fromString *)


    fun scan getc stream =
      let
        val orig_stream = stream
        val stream = PreStringCvt.skipWS getc stream          
      in
        case PreStringCvt.getNChar 24 getc stream of
          NONE => NONE
        | SOME(charlist, stream) =>
            let val string = implode charlist
            in
              case fromString string of
                SOME date => SOME (date, stream)
              | NONE => NONE
            end handle Date => NONE
      end


    val uncurry_fmt = env "Date.fmt": string * date -> string
    fun fmt string date = uncurry_fmt(string, date)
      

    local (* functions for compare *)

      fun number_order(n : int, n') =
        if n < n' then LESS
        else
          if n > n' then GREATER
          else EQUAL

      fun month_number Jan = 0
        | month_number Feb = 1
        | month_number Mar = 2
        | month_number Apr = 3
        | month_number May = 4
        | month_number Jun = 5
        | month_number Jul = 6
        | month_number Aug = 7
        | month_number Sep = 8
        | month_number Oct = 9
        | month_number Nov = 10
        | month_number Dec = 11

      fun month_order(m, m') = number_order(month_number m, month_number m')

    in

      (* Ignore timezone offset and DST information, and just compare
         dates using the year, month, day, hour, minute and second
         information.
         We compare month and day, but yday could be used instead. *)
      fun compare
        (DATE{year,
              month,
              day,
              hour,
              minute,
              second,
              ...},
         DATE{year=year',
              month=month',
              day=day',
              hour=hour',
              minute=minute',
              second=second',
              ...}) =
        if year < year' then
          LESS
        else
          if year > year' then
            GREATER
          else
            let
              val order = month_order(month, month')
            in
              if order = EQUAL then
                if day < day' then
                  LESS
                else
                  if day > day' then
                    GREATER
                  else
                    if hour < hour' then
                      LESS
                    else
                      if hour > hour' then
                        GREATER
                      else
                        if minute < minute' then
                          LESS
                        else
                          if minute > minute' then
                            GREATER
                          else
                            number_order(second, second')
              else
                order
            end (* of fun compare *)

    end (* of local surrounding fun compare *)


  end (* of structure *)
