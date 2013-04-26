(*  ==== COMPILER INFORMATION OUTPUT ====
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: _info.sml,v $
 *  Revision 1.30  1999/02/17 13:14:32  mitchell
 *  [Bug #190507]
 *  The default error reported shouldn't update the error count.
 *
 * Revision 1.29  1998/07/29  13:17:54  mitchell
 * [Bug #30450]
 * Fix broken null output routine
 *
 * Revision 1.28  1997/05/22  11:59:23  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.27  1996/10/29  16:05:48  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.26  1996/04/30  14:21:09  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.25  1996/04/01  13:16:53  matthew
 * Adding error_occurred function
 *
 * Revision 1.24  1996/03/27  14:53:45  jont
 * Modify null_options to use a null_out outstream that throws away its output
 *
 * Revision 1.23  1996/03/20  16:19:08  daveb
 * Changed definition of default_error' so that each application creates
 * a new set of options.
 *
 * Revision 1.22  1996/03/20  12:12:50  matthew
 * Changes for value polymorphism
 *
 * Revision 1.21  1996/03/15  12:29:41  daveb
 * Removed default_options, as it could be used inappropriately.
 * Added default_error' to handle cases where the default options can be used
 * reasonably safely.
 * Removed with_error_list because it wasn't used anywhere.
 *
 * Revision 1.20  1996/01/22  16:06:49  matthew
 * Adding null_options
 *
Revision 1.19  1995/09/11  14:51:01  matthew
Changing default output stream to MLWorks.IO.std_err

Revision 1.18  1995/09/08  13:26:04  matthew
Improving behaviour of wrap when exceptions are raised in body.

Revision 1.17  1995/02/27  16:04:33  daveb
Changed printing of fatal errors.  Users don't see what the difference is.

Revision 1.16  1993/12/16  15:12:37  matthew
 Changed push_error so errors are only recorded in the scope of a with_error_list

Revision 1.15  1993/12/15  11:30:18  matthew
Added type constraint to error_list_ref

Revision 1.14  1993/12/10  17:17:58  matthew
Added with_error_list to determine errors occuring in dynamic scope.
This is a bit grotty and is intended as a quicky fix.

Revision 1.13  1993/11/30  18:36:20  matthew
Made error count ignore warnings.

Revision 1.12  1993/11/29  15:50:23  matthew
Added a limit to the number of recoverable errors occuring.
(Modifiable) maximum number of errors is in max_num_errors: int ref

Revision 1.11  1993/10/29  16:52:37  nickh
Removed redundant string_err function.

Revision 1.10  1993/07/28  14:36:07  matthew
Added make_default_options function

Revision 1.9  1993/07/12  12:15:13  jont
Modified wrap to use the same ref for worst case when making a new wrapper,
and to remember the old value on the procedure stack. This allows for simpler
code when a small section is to be wrapped and its dynamic scope is not
within its lexical scope

Revision 1.8  1993/05/27  10:20:14  matthew
Added Location parameter to wrap
Used when raising Stop exception
Changed outstream field to report_fun
Added with_report_fun

Revision 1.7  1993/04/16  15:42:21  matthew
 Hid definition of options type
Added error list field to Stop exception

Revision 1.6  1993/03/03  18:23:49  matthew
removed printing controls

Revision 1.5  1993/02/24  14:59:36  matthew
Set show_eq_info default to false

Revision 1.4  1992/11/30  17:10:51  matthew
Used pervasive streams

Revision 1.3  1992/11/25  20:38:32  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.2  1992/11/19  13:26:22  matthew
Fixed problem with wrap

Revision 1.1  1992/11/17  16:50:21  matthew
Initial revision

 *)

require "../basis/__char_array";
require "../basis/__char_vector";
require "../basis/__text_io";
require "../basis/__text_prim_io";
require "../basis/__io";

require "^.basics.location";
require "info";

functor Info (structure Location : LOCATION) : INFO =
  struct
    structure Location = Location

    datatype severity =
      ADVICE |                          (* e.g. `unnecessary op' *)
      WARNING |                         (* legal, but odd *)
      NONSTANDARD |                     (* non-standard, but understood *)
      RECOVERABLE |                     (* recoverable error *)
      FATAL |                           (* can't continue *)
      FAULT                             (* fault in the compiler *)

    local
      fun sort ADVICE = 0
        | sort WARNING = 1
        | sort NONSTANDARD = 2
        | sort RECOVERABLE = 3
        | sort FATAL = 4
        | sort FAULT = 4
    in
      val (op<) = fn (s1, s2) => sort s1 < sort s2
    end

    fun level_to_string ADVICE = "advice"
      | level_to_string WARNING = "warning"
      | level_to_string NONSTANDARD = "non-SML feature"
      | level_to_string RECOVERABLE = "error"
      | level_to_string FATAL = "error"
      | level_to_string FAULT = "compiler fault"

    datatype error =
      ERROR of severity * Location.T * string

    datatype options =
      OPTIONS of
      {error       : {report_fun    : (error -> unit) option,
                      stop	: severity,
                      report	: severity,
                      worst	: severity ref},
       listing	   : {outstream : TextIO.outstream,
                      level     : int},
       error_list : error list ref,
       error_count : int ref
       }

    fun worst_error (OPTIONS {error = {worst,...},
                              ...}) =
      !worst

    exception Stop of error * error list

    fun make_list (severity,location,message) =
      [Location.to_string location, ": ", level_to_string severity,
       ": ", message]

    fun string_error (ERROR packet) = concat (make_list packet)

    fun report_fun (ERROR packet) =
      (app
       (fn s => TextIO.output(TextIO.stdErr,s))
       (make_list packet);
       TextIO.output(TextIO.stdErr,"\n"))

    fun make_default_options () =
      OPTIONS {error = {report_fun = SOME report_fun,
                        stop = FATAL,
                        report = ADVICE,
                        worst = ref ADVICE},
               listing = {outstream = TextIO.stdOut,
                          level = 2},
               error_list = ref [],
               error_count = ref 0
               }

    val null_writer =
      let
	fun null_fun_vec {buf, i, sz} = 
          CharVector.length(CharVector.extract(buf,i,sz))
	fun null_fun_arr {buf, i, sz} = 
          CharVector.length(CharArray.extract(buf,i,sz))
	val null_fun_option = fn _ => NONE
      in
	TextPrimIO.WR
	{writeVecNB = SOME null_fun_option,
	 writeArrNB = SOME null_fun_option,
	 writeVec = SOME null_fun_vec,
	 writeArr = SOME null_fun_arr,
	 block = NONE,
	 canOutput = SOME(fn _ => true),
	 name = "sink",
	 chunkSize = 1,
	 close = fn _ => (),
	 getPos = NONE,
	 setPos = NONE,
	 endPos = NONE,
	 verifyPos = NONE,
	 ioDesc = NONE}
      end

    val null_out =
      TextIO.mkOutstream(TextIO.StreamIO.mkOutstream(null_writer, IO.NO_BUF))

    val null_options =
      OPTIONS {error = {report_fun = NONE,
                        stop = FATAL,
                        report = ADVICE,
                        worst = ref ADVICE},
               listing = {outstream = null_out,
                          level = 2},
               error_list = ref [],
               error_count = ref 0
               }

      
    val max_num_errors = ref 30;

    fun error (OPTIONS {error = {report_fun=NONE, stop, ...},error_list,...})
              (packet as (severity, location, message)) =
          if severity < stop then () else raise Stop (ERROR packet,[])

      | error (OPTIONS {error = {report_fun=SOME report_fun, stop, report, worst},
                        error_list, error_count,...})
              (packet as (severity, location, message)) =
      let
        val error = ERROR packet
      in
        error_list := error :: (!error_list);
        if severity < report then () else report_fun error;
        if severity < !worst then () else worst := severity;
        if NONSTANDARD < severity then error_count := (!error_count) + 1 else ();
        if (!error_count) >= (!max_num_errors)
          then
            let val error2 = ERROR (FATAL,location,"Too many errors, giving up")
            in
              report_fun error2;
              raise Stop (error2,(error2::(!error_list)))
            end
        else
          if severity < stop then () else raise Stop (error,!error_list)
      end
    
    fun error'
	  (OPTIONS {error = {report_fun=NONE, report, worst, ...}, 
                             error_list,...})
          (packet as (severity, location, message)) =
          raise Stop (ERROR packet,[])
      | error'
	  (OPTIONS {error = {report_fun=SOME report_fun, report, worst, ...}, 
                             error_list,...})
          (packet as (severity, location, message)) =
      let
        val error = ERROR packet
      in
        error_list := error :: (!error_list);
        if severity < report then () else report_fun error;
        if severity < !worst then () else worst := severity;
        raise Stop (error,!error_list)
      end
    
    fun default_error' packet = error' (make_default_options ()) packet

    fun with_report_fun
      (OPTIONS {error = {report_fun, stop, report, worst},
                listing,
                error_list,
                error_count})
      new_report_fun f a =
      f
      (OPTIONS
       {error = {report_fun = SOME new_report_fun,
                 stop   = stop,
                 report = report,
                 worst  = worst},
       listing = listing,
       error_list = error_list,
       error_count = error_count
       })
      a

    fun wrap (OPTIONS {error = {report_fun, stop, report, worst},
		       listing,
                       ...})
             (stop', finish', report',location) f a =
      let
        val error_list = ref []
        val error_count = ref 0
	val old_worst = !worst (* Remember current value *)
	val _ = worst := ADVICE
        fun finish () =
          if  !worst < finish' 
            then
              if !worst < old_worst then worst := old_worst else ()
          else 
            raise Stop (ERROR (!worst,location,"Finish of block"),!error_list)
        val result =
          f (OPTIONS 
             {error = {report_fun = report_fun,
                       stop   = if stop' < stop then stop' else stop,
                       report = if report' < report then report' else report,
                       worst  = worst},
             listing = listing,
             error_list = error_list,
             error_count = error_count
             })
            a
            handle exn => (finish (); raise exn)
      in
        finish ();
        result
      end

    fun listing_fn(OPTIONS {listing = {level,outstream},...}) (level',text_fn) = 
      if level' > level
        then text_fn outstream
      else ()

  end
