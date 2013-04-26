(*  ==== COMPILER INFORMATION OUTPUT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Description
 *  -----------
 *
 *  Revision Log
 *  ------------
 *  $Log: info.sml,v $
 *  Revision 1.14  1997/05/22 11:04:51  jont
 *  [Bug #30090]
 *  Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.13  1996/04/30  14:19:55  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.12  1996/04/01  13:17:16  matthew
 * Adding error_occurred function
 *
 * Revision 1.11  1996/03/15  12:27:01  daveb
 * Removed default_options, as it could be used inappropriately.
 * Added default_error' to handle cases where the default options can be used
 * reasonably safely.
 * Removed with_error_list because it wasn't used anywhere.
 *
 * Revision 1.10  1996/01/22  16:06:08  matthew
 * Adding null_options
 *
Revision 1.9  1993/12/10  17:17:16  matthew
Added with_error_list to determine errors occuring in dynamic scope.

Revision 1.8  1993/11/29  15:43:56  matthew
Added a limit to the number of recoverable errors occuring.
(Modifiable) maximum number of errors is in max_num_errors: int ref

Revision 1.7  1993/07/28  14:33:53  matthew
Added make_default_options function

Revision 1.6  1993/05/27  10:28:13  matthew
Added Location.T parameter to wrap
Added string_error and with_report_fun

Revision 1.5  1993/04/16  15:39:52  matthew
Hid definition of options type
Added error list field to Stop exception

Revision 1.4  1993/03/03  18:25:45  matthew
Removed printing controls

Revision 1.3  1992/11/30  16:32:34  matthew
Used pervasive streams

Revision 1.2  1992/11/25  20:10:37  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.1  1992/11/17  16:46:29  matthew
Initial revision

 *)

require "../basis/__text_io";

require "../basics/location";

signature INFO =
  sig

    structure Location	: LOCATION

    datatype severity =
      ADVICE |                          (* e.g. `unnecessary op' *)
      WARNING |                         (* legal, but odd *)
      NONSTANDARD |                     (* non-standard, but understood *)
      RECOVERABLE |                     (* recoverable error *)
      FATAL |                           (* can't continue *)
      FAULT                             (* fault in the compiler *)

    val < : severity * severity -> bool

    type options

    val null_options: options

    val make_default_options : unit -> options

    datatype error =
      ERROR of severity * Location.T * string

    val string_error : error -> string

    exception Stop of (error * error list)

    val error	: options -> severity * Location.T * string -> unit
    val error'	: options -> severity * Location.T * string -> 'a
    val default_error'	: severity * Location.T * string -> 'a

    val wrap	: options -> severity * severity * severity * Location.T ->
		    (options -> 'a -> 'b) -> 'a -> 'b

    val with_report_fun :
	  options -> (error -> unit) -> (options -> 'a -> 'b) -> 'a -> 'b

    val listing_fn	: options -> int * (TextIO.outstream -> unit) -> unit

    val max_num_errors  : int ref

    val worst_error : options -> severity

  end;
