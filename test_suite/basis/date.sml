(* Test suite for Date functions.

Result: OK
 * $Log: date.sml,v $
 * Revision 1.15  1998/10/09 14:29:14  jont
 * [Bug #30489]
 * Add test for empty string to Date.fmt
 *
 *  Revision 1.14  1998/05/08  16:32:08  jont
 *  [Bug #70110]
 *  Modify so it works on most unix machines
 *
 *  Revision 1.13  1997/11/21  10:43:52  daveb
 *  [Bug #30323]
 *
 *  Revision 1.12  1997/09/25  10:39:54  brucem
 *  [Bug #30269]
 *  DATE signature has been revised.  Test features of new specification.
 *
 *  Revision 1.11  1997/09/11  15:25:33  jont
 *  [Bug #20102]
 *  Fix problems caused by incompatibility of support for strftime
 *  formats between unix and Win32
 *
 *  Revision 1.10  1997/05/07  13:29:24  daveb
 *  [Bug #30112]
 *  Added use of Date.fmt.  Replaced MLWorks.IO.output with print.
 *  Added more information for failing tests.
 *
 *  Revision 1.9  1997/03/27  09:48:02  jont
 *  Modify date comparison not to use polymorphic equality
 *  as some fields aren't guaranteed
 *
 *  Revision 1.8  1997/03/03  12:31:33  daveb
 *  [Bug #1937]
 *  Corrected the type of Date.scan.
 *
 *  Revision 1.7  1996/12/20  12:15:29  jont
 *  [Bug #0]
 *  Changed because test suite has moved
 *
 *  Revision 1.6  1996/10/14  08:56:53  stephenb
 *  The previous change breaks on machines which aren't running under
 *  GMT (e.g. babylon) since Date.fromUTC o Date.toTime is not the identity
 *  in such timezones.  Consequently changed it back to fromTime o toTime.
 *  This means that the test now fails under SunOS (sorrol) again.
 *
 *  Revision 1.5  1996/10/07  11:10:31  stephenb
 *  Change to use fromUTC to avoid a bug in SunOS when using fromTime
 *  on the equivalent of Time.zeroTime.
 *
 *  Revision 1.4  1996/10/02  11:28:55  stephenb
 *  Add Date.toTime tests.
 *
 *  Revision 1.3  1996/05/22  10:19:02  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.2  1996/05/16  13:51:37  jont
 *  chars has moved to char
 *
 *  Revision 1.1  1996/05/10  17:01:06  jont
 *  new unit
 *
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *)


local
  (* We need two version of the date string here *)
  (* One is the result produced by Date.toString *)
  (* The other is the result produced by Date.fmt *)
  (* Under xpg4 Date.fmt has an option (%e) to allow it to produce *)
  (* leading spaces instead of leading zeroes *)
  (* Unfortunately Win32 doesn't support this, and we are forced *)
  (* to use %d instead *)
  val date_string_a = "Thu May  9 16:30:10 1996"
  val date_string_b = "Thu May 09 16:30:10 1996"
  val fmt_string = "%a %b %d %H:%M:%S %Y"

  fun getc(s, i) =
    if i >= size s then
      NONE
    else
      SOME(Char.chr(MLWorks.String.ordof(s, i)), (s, i+1))

  fun compare_dates
	(msg_string,
	 date, date') =
    if Date.compare(date, date') = EQUAL then
      (print (msg_string ^ " succeeded.\n"); true)
    else
      let
        val year = Date.year date and year' = Date.year date'
        val month = Date.month date and month' = Date.month date'
        val day = Date.day date and day' = Date.day date'
        val hour = Date.hour date and hour' = Date.hour date'
        val minute = Date.minute date and minute' = Date.minute date'
        val second = Date.second date and second' = Date.second date'
        val wday = Date.weekDay date and wday' = Date.weekDay date'
        val yday = Date.yearDay date and yday' = Date.yearDay date'
      in
        (print (msg_string ^ " Error different dates:\n");
         print ("  Dates are "^(Date.toString date)^
                " and "^(Date.toString date')^"\n");
         (if year<>year' then print"  years fail\n" else ());
         (if month<>month' then print"  months fail\n" else ());
         (if day<>day' then print"   days fail\n" else ());
         (if hour<>hour' then print"  hours fail\n" else ());
         (if minute<>minute' then print"  minutes fail\n" else ());
         (if second<>second' then print"  seconds fail\n" else ());
         (if wday<>wday' then print"  weekDays fail\n" else ());
         (if yday<>yday' then print"  yearDays fail\n" else ());
         false)
      end
in

  local
    val date =
      case Date.fromString date_string_a of
        NONE => (print ("Date.fromString \""^date_string_a^"\" failed\n");
	         raise Match)
      | SOME date => date

    val date' =
      let
        val date_string' = MLWorks.String.substring(Date.toString date, 0, 24)
      in
        if date_string' = date_string_a then
          let
	    val date' = Date.scan getc (date_string_a, 0)
          in
	    case date' of
	      SOME(date', _) =>
	        (if compare_dates("date", date, date') then
		   let 
		     val date_fmt = Date.fmt fmt_string date 
                   in
		     if date_fmt = date_string_b then
		       print "Date fmt succeeded\n"
                     else
                       print("Date fmt returned '" ^ date_fmt ^
                             "', instead of '" ^ date_string_b ^ "'\n")
                   end
                 else
                   print "Date scan gave wrong answer\n";
                 date')
              | NONE =>
	        (print "Date scan failed entirely\n";
	         date)
	  end
        else
	  (print ("Date print failed with '" ^ date_string' ^ "'\n");
	   date)
      end
    in
    end

  local
    (* These are local as they will vary between Unix and Win32 *)
    val dateStart = Date.date {year= 1970, month= Date.Jan, day= 2,
                               hour= 0, minute= 0, second= 0,
                               offset = NONE}
    val dateEnd = Date.date {year= 2030, month= Date.Dec, day= 31,
                             hour= 23, minute= 59, second= 59,
                             offset = NONE}
    val dateStart' = Date.fromTimeLocal (Date.toTime dateStart)
    val dateEnd' = Date.fromTimeLocal (Date.toTime dateEnd)
  in
    val _ = compare_dates("dateStart", dateStart, dateStart')
    val _ = compare_dates("dateEnd", dateEnd, dateEnd')
  end

  local
    (* As early a date as we expect to deal with: *)
    val date1 =
      Date.date{year=1900, month=Date.Jan, day=1,
                hour=00, minute=00, second=00, offset=NONE}
    (* This should be the same as date1 *)
    val date2 =
      Date.date{year=1899, month=Date.Dec, day=31,
                hour=23, minute=59, second=60, offset=NONE}
  in
    val _ = print ((Date.toString date1)^"\n");
    val _ = print ((Date.toString date2)^"\n");
    val _ = compare_dates("Carrying over start of 1900", date1, date2)
  end

  local
    fun isLeap year = 
      let
        val date = Date.date{year = year, month = Date.Feb, day = 29,
                             hour = 12, minute = 0, second = 0, offset = NONE}
        val month = Date.month date
      in
        month = Date.Feb
      end
    fun test year = if isLeap year then
                      print ((Int.toString year)^" is a leap year\n")
                    else
                      print ((Int.toString year)^" is not a leap year\n")
  in
    val _ = (test 1900; test 1984; test 1983; test 2000; test 1600)
  end

  (* check day of the week *)
  val _ =
    let
      val date = Date.date{year=1997, month=Date.Sep, day = 23,
                           hour=12, minute=0, second=0, offset=NONE}
      val day = Date.weekDay date
    in
      if day = Date.Tue then
         print "Day of the week succeeded.\n"
      else
         print ("Day of the week failed.\n  "^(Date.toString date)^"\n")
    end

  (* Test that incorrect times are not created.
     An exception should be raised by Date.toTime when it encounters
     a date which cannot be represented as a time.
     If a correct time is created then change the date in the test
     to something earlier.
     Any date before Date.fromTimeUniv(Time.zeroTime) (on all platforms)
     should work. *)
  val _ =
    let
      val date = Date.date{year=1500, month=Date.Sep, day = 23,
                           hour=12, minute=0, second=0,
                           offset=SOME (Time.zeroTime)}
      val time = Date.toTime date
            handle Date.Date =>
               (print "Date.toTime raised exception Date ok.\n";
                raise Fail "ok")
      val date' = Date.fromTimeUniv time
    in
      if Date.compare(date, date') = EQUAL then
        print "Date.toTime failed, incorrect time created\n"
      else
        print ("Date.toTime test failed, please change test file.\n")
    end
    handle Fail "ok" => ()
         | _ => print "Date.ToTime raised wrong exception.\n"

  (* Test that timezone stuff works.  This is best executed outside GMT
     (e.g. in the summer).  As we use the time `now', any errors from
     this may be caused by a problem due to changes that have happened
     now (e.g. changing to BST). *)
  val _ =
    let
      val now = Time.now ()

      val dateLocal = Date.fromTimeLocal now
      val dateUniv = Date.fromTimeUniv now
      val offsetLocal = Date.offset dateLocal
      val offsetUniv = Date.offset dateUniv
      val timeLocal = Date.toTime dateLocal
      val timeUniv = Date.toTime dateUniv

      val reportedOffset = Date.localOffset ()
      (* Get the difference between the dates as a time from 0..24 hours. *)
      val measuredOffset =
        Time.-(timeUniv, timeLocal)
        handle Time.Time =>
          Time.-(Time.+(timeUniv, Time.fromSeconds(24*60*60)), timeLocal)
    in
      (case offsetLocal of
         NONE => print "Offset of timeLocal is correct (NONE).\n"
       | SOME _ => print "Offset of timeLocal is incorrect (SOME _).\n");
      (case offsetUniv of 
         NONE => print "offsetUniv is incorrect (NONE).\n"
       | SOME t => if t=Time.zeroTime then
                     print "Offset of timeUniv is correct (SOME 0).\n"
                   else
                     print ("Offset of timeUniv is incorrect (SOME " ^
                            (Time.toString t) ^ ").\n") );
      (if reportedOffset = measuredOffset then
         print "localOffset matches my calculation ok.\n"
       else
         print ("Local offset doesn't match, measured = " ^ 
                (Time.toString measuredOffset) ^
                ", reported = " ^ (Time.toString reportedOffset) ^ ".\n") )
    end
    


end

val x = Date.fmt "" (Date.fromTimeLocal(Time.now())) = "";
