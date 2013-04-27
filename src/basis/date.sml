(*  ==== INITIAL BASIS : DATE ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  $Log: date.sml,v $
 *  Revision 1.6  1997/09/25 11:04:32  brucem
 *  [Bug #30269]
 *  Signature has been revised.
 *
 * Revision 1.5  1997/03/03  12:08:21  daveb
 * [Bug #1937]
 * Corrected type of scan.
 *
 * Revision 1.4  1996/10/03  15:20:15  io
 * [Bug #1614]
 * remove redundant requires
 *
 * Revision 1.3  1996/05/08  15:55:15  jont
 * Bring up to latest revision of basis
 *
 * Revision 1.2  1996/05/01  15:16:19  stephenb
 * Update wrt change in Time implementation.
 * Also bring up to date wrt latest basis revision.
 *
 * Revision 1.1  1996/04/18  11:41:04  jont
 * new unit
 *
 *  Revision 1.1  1995/04/13  13:49:53  jont
 *  new unit
 *  No reason given
 *
 *
 *)

require "../system/__time";
require "__string_cvt";


signature DATE =
  sig
    datatype weekday = Mon | Tue | Wed | Thu | Fri | Sat | Sun

    datatype month = Jan | Feb | Mar | Apr | May | Jun
                   | Jul | Aug | Sep | Oct | Nov | Dec

    type date
      (* Dates always work over at least the period 1900..2200 as
         specified by the Basis library.
         They are also reliable over a much greater period (limited only
         by integer arithmetic) but the exact range is machine
         dependent and differs according to what operations are performed.
         Some operations (involving Time.time) only work over a
         shorter period (again machine dependent, the lower limit
         of times is always time.zeroTime).
         You will never receive an inaccurate date due to rounding
         errors or overflow.  Attempts to create a date outside the
         valid range will always raise exception Date.  So if you assume
         an unlimited range of dates, you can be sure of either getting
         the correct answer, or an exception. *)

    exception Date

    val year : date -> int         (* returns the year, e.g. 1997 *)
    val month : date -> month      (* returns the month *)
    val day : date -> int          (* returns day of the month, >=1 *)
    val hour : date -> int         (* returns hour of the day *)
    val minute : date -> int       (* returns minute of the hour *)
    val second : date -> int       (* returns second of the minute *)
    val weekDay : date ->  weekday (* returns day of the week *)
    val yearDay : date -> int      (* returns day of the year, >=1 *)

    val offset : date -> Time.time option 
        (* return time west of UTC.  NONE is localtime, SOME(Time.zeroTime)
           is UTC.
           Europe will be reported as SOME(23 hours), one hour _ahead_
           of GMT. *)
    val isDst : date -> bool option
        (* returns SOME(true) if daylight savings time is in effect; returns
           SOME(false) if not, and returns NONE if we don't know. *)

    val date :
      { year   : int,
        month  : month,
        day    : int,
        hour   : int,
        minute : int,
        second : int,
        offset : Time.time option } ->
      date
        (* Creates a canonical date from the given values.  If the 
           resulting date is outside the range supported by the 
           implementation, the Date exception is raised. *)

    val localOffset : unit -> Time.time
        (* Returns the offset from UTC for the local timezone. *) 

    val fromTimeLocal : Time.time -> date
        (* Returns the date in the local timezone for the given (UTC) time.
           This is like the ANSI C function localtime.
           offset of the date will be NONE. *)

    val fromTimeUniv : Time.time -> date
        (* Returns the date in the UTC timezone for the given (UTC) time.
           This is like the ANSI C function gmtime.
           offset of the date will be SOME(Time.zeroTime). *)

    val toTime : date -> Time.time
        (* Returns the time value corresponding to the date in the host
           system.  This raises Date exception if the date cannot be 
           represented as a time value. *)

    (* Dates as text must be in 24 character format,
       e.g. "Thu Sep 25 10:08:30 1997".*)
    val toString   : date -> string
    val fmt        : string -> date -> string
    val fromString : string -> date option
    val scan       : (char, 'a) StringCvt.reader -> (date, 'a) StringCvt.reader

    val compare : (date * date) -> order
        (* Returns the relative order of two dates ignoring DST and 
           timezone information. *)

  end
