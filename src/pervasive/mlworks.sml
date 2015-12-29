(*  ==== PERVASIVE MLWORKS LIBRARY ====
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: mlworks.sml,v $
 *  Revision 1.148  1998/05/26 13:56:24  mitchell
 *  [Bug #30413]
 *  Move Exit structure to pervasives
 *
 * Revision 1.147  1998/03/26  16:21:00  jont
 * [Bug #30090]
 * Remove MLWorks.IO
 *
 * Revision 1.146  1998/03/26  14:08:42  jont
 * [Bug #30090]
 * Remove all of MLWorks.IO
 *
 * Revision 1.145  1998/02/10  15:31:30  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.144  1997/11/26  15:45:22  johnh
 * [Bug #30134]
 * Change meaning of third arg of deliver and convert to datatype.
 *
 * Revision 1.143  1997/11/09  19:14:52  jont
 * [Bug #30089]
 * Furhter work on getting rid of MLWorks.Time
 * Also removing {set_,}file_modified
 *
 * Revision 1.142  1997/10/09  13:45:35  jont
 * [Bug #30204]
 * Add comment indicating restrictions on use of update_exn
 *
 * Revision 1.141  1997/10/08  17:23:28  jont
 * [Bug #30204]
 * Add update_exn and update_exn_cons
 *
 * Revision 1.140  1997/10/07  14:45:19  johnh
 * [Bug #30226]
 * Add exitFn for storing the function to call when the exe exits normally.
 *
 * Revision 1.139  1997/08/04  10:37:27  brucem
 * [Bug #30084]
 * Add datatype MLWorks.Internal.Types.option.
 * Change all occurences of General.option to the new option.
 *
 * Revision 1.138  1997/06/17  13:50:58  andreww
 * [Bug #20014]
 * adding MLWorks.name
 *
 * Revision 1.137  1997/06/12  11:59:49  matthew
 * [Bug #30101]
 *
 * Adding sin and cos
 *
 * Revision 1.136  1997/06/12  10:09:57  matthew
 * Adding print_error to StandardIO
 *
 * Revision 1.135  1997/05/28  21:08:46  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.134  1997/05/09  13:39:40  jont
 * [Bug #30091]
 * Remove MLWorks.Internal.FileIO and related stuff
 *
 * Revision 1.133  1997/05/01  11:44:14  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.132  1997/03/25  11:46:48  andreww
 * [Bug #1989]
 * removing Internal.Value.exn_name_string.
 *
 * Revision 1.131  1997/03/18  11:16:10  andreww
 * [Bug #1431]
 * Adding Io exception from basis to Internal Value so that
 * general exnMessage prints it nicely.
 *
 * Revision 1.130  1997/03/07  15:59:34  andreww
 * [Bug #1677]
 * Adding hook for stopping preemption.  This is used to keep
 * the GUI listener operating correctly --- when the user types
 * "stop pre-empting", the listener must claim its access mutex
 * before actually stopping, otherwise it will go to sleep,and
 * a concurrent thread will continue executing.
 *
 * Revision 1.129  1997/03/03  11:13:53  matthew
 * Adding unsafe floatarray operations to Internal.Value
 *
 * Revision 1.128  1997/01/27  11:07:34  andreww
 * [Bug #1891]
 * Adding critical section primitives for threads.
 *
 * Revision 1.127  1997/01/06  15:55:13  andreww
 * [Bug #1818]
 * Adding new FloatArray primitives.
 *
 * Revision 1.126  1996/11/18  10:27:44  matthew
 * Adding real equality builtin to MLWorks.Internal.Value.
 *
 * Revision 1.125  1996/10/21  14:42:28  andreww
 * [Bug #1682]
 * removing MLWorks.General
 *
 * Revision 1.124  1996/10/21  10:34:38  andreww
 * [Bug #1666]
 * Adding Threads exception to MLWorks.Threads
 *
 * Revision 1.123  1996/09/18  14:10:18  io
 * [Bug #1490]
 * update String maxSize
 *
 * Revision 1.122  1996/08/21  09:00:38  stephenb
 * [Bug #1554]
 * Introduce MLWorks.Internal.IO as a repository for file_desc
 * and the read, write, seek, ... etc. stuff.
 *
 * Revision 1.121  1996/07/16  15:48:15  andreww
 * Incorporated gui_standard_io signature.
 *
 * Revision 1.120  1996/07/15  12:42:05  andreww
 * Adding exception Empty.
 *
 * Revision 1.119  1996/06/25  10:52:03  andreww
 * adding General to the top level.
 *
 * Revision 1.118  1996/06/19  13:42:40  nickb
 * Extend datatype MLWorks.Internal.Trace.status.
 *
 * Revision 1.117  1996/05/30  11:50:53  daveb
 * Revising top level for revised basis.
 *
 * Revision 1.116  1996/05/29  12:33:31  matthew
 * Fixing problem with SysErr
 *
 * Revision 1.115  1996/05/28  11:58:32  daveb
 * Removed MLWorks.RawIO.
 *
 * Revision 1.114  1996/05/22  13:20:01  matthew
 * Changing type of real_to_string
 *
 * Revision 1.113  1996/05/20  10:00:06  matthew
 * Changing type of word32 shift operations
 *
 * Revision 1.112  1996/05/17  10:05:18  matthew
 * Moving Bits to Internal
 *
 * Revision 1.111  1996/05/16  13:18:56  stephenb
 * MLWorks.Debugger: moved to MLWorks.Internal.Debugger
 * MLWorks.OS.arguments: moved MLWorks.arguments & removed MLWorks.OS
 *
 * Revision 1.109  1996/05/07  10:22:14  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.108  1996/05/03  12:27:52  nickb
 * Add image delivery hooks.
 *
 * Revision 1.107  1996/04/29  14:49:44  matthew
 * Removing Real structure
 *
 * Revision 1.106  1996/04/29  10:47:47  jont
 * Modifications to deliver and save
 *
 * Revision 1.105  1996/04/19  16:13:05  stephenb
 * Put MLWorks.exit back to enable boostrapping from older compilers.
 *
 * Revision 1.104  1996/04/17  11:02:35  stephenb
 * Remove exit, terminate, atExit and most of the OS structure since
 * they are no longer needed now that OS.Process has been updated.
 *
 * Revision 1.103  1996/03/28  11:34:37  matthew
 * Language revisions
 *
 * Revision 1.102  1996/03/20  12:19:32  matthew
 * Changing the type of some things
 *
 * Revision 1.101  1996/03/08  11:42:18  daveb
 * Changed MLWorks.Internal.Dynamic types to new identifier convention.
 *
 * Revision 1.100  1996/02/22  13:15:06  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.99  1996/02/16  15:00:34  nickb
 * "fn_save" becomes "deliver".
 *
 *  Revision 1.98  1996/01/22  11:01:32  matthew
 *  Simplifying treatment of pervasive exceptions
 *
 *  Revision 1.97  1996/01/17  16:05:58  stephenb
 *  OS reorganisation: remove the Unix and NT code as it is going elsewhere.
 *
 *  Revision 1.96  1996/01/16  12:22:05  nickb
 *  Change to GC interface.
 *
 *  Revision 1.95  1996/01/15  16:18:20  matthew
 *  Adding NT directory operations
 *
 *  Revision 1.94  1996/01/15  11:47:45  nickb
 *  Add thread sleep and wake operations.
 *
 *  Revision 1.93  1996/01/12  10:33:22  stephenb
 *  Add MLWORKS.Threads.Internal.reset_signal_status
 *
 *  Revision 1.92  1996/01/08  14:18:00  nickb
 *  Remove signal reservation.
 *
 *  Revision 1.91  1995/12/04  15:55:59  daveb
 *  pervasive module names now begin with a space.
 *
 *  Revision 1.90  1995/11/21  11:22:13  jont
 *  Add Frame.frame_double for accessing directly spilled reals
 *
 *  Revision 1.89  1995/10/17  12:51:59  jont
 *  Add exec_save for saving executables
 *
 *  Revision 1.88  1995/09/13  14:23:26  jont
 *  Add function save to MLWorks for use by exportFn
 *
 *  Revision 1.87  1995/09/12  15:08:33  daveb
 *  Added types for different sizes of words and integers.
 *
 *  Revision 1.85  1995/07/26  14:15:01  jont
 *  Add makestring to word signature and structure
 *
 *  Revision 1.84  1995/07/24  14:20:42  jont
 *  Add Words signature and structure
 *
 *  Revision 1.83  1995/07/20  17:01:30  jont
 *  Add Overflow to structure Exception
 *
 *  Revision 1.82  1995/07/19  15:09:52  nickb
 *  Two constructors called MLWorks.Profile.Profile.
 *
 *  Revision 1.81  1995/07/19  13:51:55  nickb
 *  Whoops; major type screwups in new profiler.
 *
 *  Revision 1.80  1995/07/17  16:33:47  nickb
 *  Change to profiler interface.
 *
 *  Revision 1.79  1995/07/17  11:13:21  jont
 *  Add hex integer printing facilities
 *
 *  Revision 1.78  1995/06/02  14:02:36  nickb
 *  Change threads restart system.
 *
 *  Revision 1.77  1995/05/22  15:45:37  nickb
 *  Add threads interface
 *
 *  Revision 1.76  1995/05/10  17:51:49  daveb
 *  Changed argument of Unix exception from int to string.
 *  Added OS.Unix.{stat,seek,set_block_mode,can_input}.
 *
 *  Revision 1.75  1995/05/02  13:12:39  matthew
 *  Adding CAST and UMAP primitives
 *
 *  Revision 1.74  1995/04/13  14:03:24  jont
 *  Add terminate, atExit functions
 *
 *  Revision 1.73  1995/03/01  11:24:16  matthew
 *  Unifying Value.Frame and Frame.pointer
 *
 *  Revision 1.72  1995/01/12  15:23:07  jont
 *  Add Win_nt.get_current_directory
 *
 *  Revision 1.71  1994/12/09  14:38:44  jont
 *  Add OS.Win_nt structure
 *
 *  Revision 1.70  1994/11/24  16:19:45  matthew
 *  Adding new "unsafe" pervasives
 *
 *  Revision 1.69  1994/09/28  14:45:11  matthew
 *  Added pervasive Option structure
 *
 *  Revision 1.68  1994/08/24  16:31:57  matthew
 *  Adding unsafe array operations
 *
 *  Revision 1.67  1994/07/22  15:37:35  jont
 *  Modify for new code_module
 *
 *  Revision 1.66  1994/07/22  15:26:24  jont
 *  Modify for new code_module
 *
 *  Revision 1.65  1994/07/08  10:08:54  nickh
 *  Add event functions for stack overflow and interrupt handlers.
 *
 *  Revision 1.64  1994/06/29  14:58:56  nickh
 *  Add MLWorks messages stream.
 *
 *  Revision 1.63  1994/06/22  15:27:30  nickh
 *  Add Trace.restore_all.
 *
 *  Revision 1.62  1994/06/09  15:37:46  nickh
 *  Updated runtime signal handling.
 *
 *  Revision 1.61  1994/06/06  11:46:19  nosa
 *  Breakpoint settings on function exits.
 *
 *  Revision 1.60  1994/03/30  14:46:24  daveb
 *  Revised MLWorks.IO.set_modified_file to take a datatype.
 *
 *  Revision 1.59  1994/03/30  13:55:51  daveb
 *  Removed input_string and output_string.
 *
 *  Revision 1.58  1994/03/30  13:22:12  daveb
 *  Added MLWorks.IO.set_file_modified.
 *
 *  Revision 1.57  1994/02/23  17:04:26  nosa
 *  Step and breakpoints Debugger.
 *
 *  Revision 1.56  1994/02/08  14:37:21  matthew
 *  Added realpath function
 *
 *  Revision 1.55  1993/11/25  13:00:45  jont
 *  Reinstated missing version 1.53
 *
 *  Revision 1.54  1993/11/22  14:28:13  jont
 *  Changed type of modules to include a time stamp field
 *
 *  Revision 1.53  1993/11/18  12:05:51  nickh
 *  Add to IO and RawIO to provide closed_in and closed_out functions, which
 *  test a stream for closed-ness.
 *
 *  Revision 1.52  1993/11/15  16:44:26  nickh
 *  New, more versatile time structure.
 *
 *  Revision 1.51  1993/08/27  19:34:57  daveb
 *  Added MLworks.OS.Unix.{unlink,rmdir,mkdir}.
 *
 *  Revision 1.50  1993/08/26  11:13:00  richard
 *  Removed the X exception.  It's now in the Motif interface code.
 *
 *  Revision 1.49  1993/08/25  14:01:37  richard
 *  Changed MLWorks.OS.Unix.vfork_* to return the pid of the forked
 *  process.  Added MLWorks.OS.Unix.kill.
 *
 *  Revision 1.48  1993/08/18  12:53:36  daveb
 *  Added X exception.
 *
 *  Revision 1.47  1993/08/10  11:28:49  daveb
 *  Removed "../pervasive" from require statements, for the new make systems.
 *
 *  Revision 1.46  1993/07/23  11:08:17  richard
 *  Added system calls to read directories and the password file.
 *
 *  Revision 1.45  1993/07/19  13:53:26  nosa
 *  Added two frame functions for debugger
 *
 *  Revision 1.44  1993/06/09  16:06:35  matthew
 *  Added text_preprocess hook
 *
 *  Revision 1.43  1993/05/05  17:09:17  jont
 *  Added MLWorks.OS.Unix.password_file to get the association list of user names
 *  to home directories necessary for translating ~
 *
 *  Revision 1.42  1993/04/23  14:56:28  jont
 *  Added Integer and Real substructures of MLWorks with makestring and print functions
 *
 *  Revision 1.41  1993/04/21  15:58:26  richard
 *  Removed defunct Editor interface and added sytem calls to enable
 *  its replacement.
 *
 *  Revision 1.40  1993/04/20  13:52:57  richard
 *  Added more Unix system call interfaces.
 *  New Trace structure to go with runtime implementation.
 *
 *  Revision 1.39  1993/04/13  09:50:58  matthew
 *  Moved dynamic stuff from MLWorks.Internal.Typerep to MLWorks.Dynamic
 *  Moved break stuff from MLWorks.Internal.Tracing to MLWorks.Debugger
 *
 *  Revision 1.38  1993/04/08  17:29:01  jont
 *  Expose vi_file and emacs_file
 *
 *  Revision 1.37  1993/04/02  14:47:39  jont
 *  Extended images structure to include table of contents reading
 *
 *  Revision 1.36  1993/03/26  15:52:31  matthew
 *  Added break function to Tracing substructure
 *
 *  Revision 1.35  1993/03/23  18:29:31  jont
 *  Added vector primitives
 *
 *  Revision 1.34  1993/03/18  16:34:45  jont
 *  Changed the specification of load_codeset to reflect changes in machtypes
 *
 *  Revision 1.33  1993/03/11  18:36:55  jont
 *  Added Intermal.  Images including save and clean.
 *  Added other_operation to Editor for arbitrary bits of emacs lisp
 *
 *  Revision 1.32  1993/03/10  16:40:47  jont
 *  Added Editor substructure to MLWorks
 *
 *  Revision 1.31  1993/02/26  11:13:05  nosa
 *  Implemented a multi-level profiler
 *
 *  Revision 1.30  1993/02/25  18:17:57  matthew
 *  Changed ByteArray.T to ByteArray.bytearray
 *
 *  Revision 1.29  1993/02/18  16:33:36  matthew
 *  Added TypeRep substructure
 *
 *  Revision 1.28  1993/02/09  14:58:38  jont
 *  Changes for code vector reform.
 *
 *  Revision 1.27  1993/01/14  14:45:50  daveb
 *  Added objectfile version argument to load_wordset, to catch an interpreter
 *  trying to load inconsistent code.
 *
 *  Revision 1.26  1993/01/05  16:52:41  richard
 *  Added extra exceptions to those passed to the runtime system.
 *
 *  Revision 1.25  1992/12/22  11:43:12  jont
 *  Removed pervasive vector
 *
 *  Revision 1.24  1992/12/21  11:29:53  daveb
 *  Added support for the 'agreed' Array and Vector structures.
 *  Renamed the old Array to ExtendedArray.
 *
 *  Revision 1.23  1992/11/30  18:51:17  matthew
 *  Tidied up IO signature
 *
 *  Revision 1.22  1992/11/30  17:56:05  matthew
 *  Added representation of streams as records.  Old IO is now RawIO.
 *
 *  Revision 1.21  1992/11/12  17:22:21  clive
 *  Added tracing hooks to the runtime system
 *
 *  Revision 1.20  1992/11/10  13:13:37  richard
 *  Added StorageManager exception and changed the type of the
 *  StorageManager interface function.
 *
 *  Revision 1.19  1992/10/29  17:07:45  richard
 *  Removed debugger structure and added time and event structures.
 *
 *  Revision 1.18  1992/10/06  17:20:26  clive
 *  Type of call_debugger has changed to take debugger function as well
 *  as exception
 *
 *  Revision 1.17  1992/09/25  14:20:56  matthew
 *  Added Internal.string_to_real
 *
 *  Revision 1.16  1992/09/23  16:12:32  daveb
 *  Added clear_eof function to IO.
 *
 *  Revision 1.15  1992/09/01  13:44:40  richard
 *  Changed the types of the OS information stuff.  Added real_to_string,
 *  arguments, Prod and Value.
 *
 *  Revision 1.14  1992/08/28  10:32:51  clive
 *  Added get_code_object_debug_info
 *
 *  Revision 1.13  1992/08/28  08:21:53  richard
 *  Changed call to environment so that it isn't preserved across
 *  images.
 *  Added floating point exceptions.
 *
 *  Revision 1.12  1992/08/26  14:14:16  richard
 *  Rationalisation of the MLWorks structure.
 *
 *  Revision 1.11  1992/08/25  08:37:30  richard
 *  Copied BITS signature to a separate file.
 *  Added ByteArray structure.
 *
 *  Revision 1.10  1992/08/20  12:54:36  richard
 *  Corrected paths to string and array in requires.
 *
 *  Revision 1.9  1992/08/20  12:24:43  richard
 *  Added extra unsafe value utilities.
 *
 *  Revision 1.8  1992/08/18  16:38:55  richard
 *  Corrected type of input_string.
 *
 *  Revision 1.7  1992/08/18  15:36:27  richard
 *  Added more input and output functions for different types.
 *  Added Value structure for opaque value stuff and removed
 *  duplicates elsewhere.
 *
 *  Revision 1.6  1992/08/17  10:58:26  richard
 *  Added MLWorks.System.Runtime.GC.interface.
 *
 *  Revision 1.5  1992/08/15  17:30:02  davidt
 *  Put in IO.input_line function.
 *
 *  Revision 1.4  1992/08/13  11:40:16  clive
 *  Added a function to get header information from an ml_object
 *
 *  Revision 1.3  1992/08/11  15:33:23  clive
 *  Work on tracing
 *
 *  Revision 1.2  1992/08/10  15:26:35  richard
 *  Added load_wordset to interpreter structure.
 *
 *  Revision 1.1  1992/08/10  12:18:46  davidt
 *  Initial revision
 *
 *)

require " array";
require " vector";
require " bytearray";
require " floatarray";
require " string";
require " bits";
require " general";

signature MLWORKS =
  sig

    structure String : STRING

    exception Interrupt

    structure Deliver :
    sig
      datatype app_style = CONSOLE | WINDOWS
      type deliverer = string * (unit -> unit) * app_style -> unit
      type delivery_hook = deliverer -> deliverer
      val deliver : deliverer
      val with_delivery_hook : delivery_hook -> ('a -> 'b) -> 'a -> 'b
      val add_delivery_hook : delivery_hook -> unit
      val exitFn : (unit -> unit) ref
    end
	
    val arguments : unit -> string list
    val name: unit -> string

    structure Threads :
      sig
	type 'a thread
        exception Threads of string
	
	val fork : ('a -> 'b) -> 'a -> 'b thread
	val yield : unit -> unit
	
	datatype 'a result =
	  Running		(* still running *)
	| Waiting		(* waiting *)
	| Sleeping		(* sleeping *)
	| Result of 'a		(* completed, with this result *)
	| Exception of exn	(* exited with this uncaught exn *)
	| Died			(* died (e.g. bus error) *)
	| Killed		(* killed *)
	| Expired		(* no longer exists (from a previous image) *)
	
	val result : 'a thread -> 'a result

	val sleep : 'a thread -> unit
	val wake : 'a thread -> unit

	structure Internal :
	  sig
	    eqtype thread_id
	
	    val id : unit -> thread_id		(* this thread *)
	    val get_id : 'a thread -> thread_id	(* that thread *)
	
	    val children : thread_id -> thread_id list
	    val parent : thread_id -> thread_id
	
	    val all : unit -> thread_id list	 (* all threads *)
	
	    val kill : thread_id -> unit	 (* kill a thread *)
	    val raise_in : thread_id * exn -> unit (* raise E in the thread *)
	    val yield_to : thread_id -> unit	 (* fiddle with scheduling *)
	
	    val state : thread_id -> unit result (* the state of that thread *)
	    val get_num : thread_id -> int	 (* the 'thread number' *)
	
	    val set_handler  : (int -> unit) -> unit
	    	(* fatal signal handler fn for this thread *)
	
	    val reset_fatal_status : unit -> unit
	      (* Mark the thread as being outside of a fatal handler *)

	    structure Preemption :
	      sig
		val start : unit -> unit
		val stop : unit -> unit
		val on : unit -> bool
		val get_interval : unit -> int	(* milliseconds *)
		val set_interval : int -> unit
                val enter_critical_section: unit -> unit
                val exit_critical_section: unit -> unit
                val in_critical_section: unit -> bool
	      end
	  end
      end

    structure Internal :
      sig

	exception Save of string
	val save : string * (unit -> 'a) -> unit -> 'a
	val execSave : string * (unit -> 'a) -> unit -> 'a
        val real_to_string	: real * int -> string
        exception StringToReal
        val string_to_real : string -> real

        val text_preprocess : ((int -> string) -> int -> string) ref

	structure Types :
	  sig
	    type int8
	    type word8
	    type int16
	    type word16
	    type int32
	    type word32
            datatype 'a option = SOME of 'a | NONE
	    datatype time = TIME of int * int * int (* basis time *)
	  end

        structure Error :
          sig
            type syserror
            exception SysErr of string * syserror Types.option
            val errorMsg: syserror -> string
            val errorName: syserror -> string
            val syserror: string -> syserror Types.option
          end


        structure IO :
          sig
            exception Io of {cause: exn, name: string, function: string}

            datatype file_desc = FILE_DESC of int
            val write     : file_desc * string * int * int -> int
            val read      : file_desc * int -> string
            val seek      : file_desc * int * int -> int
            val close     : file_desc -> unit
            val can_input : file_desc -> int
          end


        structure StandardIO :
          sig
            type IOData = {input: {descriptor: IO.file_desc Types.option,
                                   get: int -> string,
                                   get_pos: (unit -> int) Types.option,
                                   set_pos: (int -> unit) Types.option,
                                   can_input: (unit-> bool) Types.option,
                                   close: unit->unit},
              output: {descriptor: IO.file_desc Types.option,
                       put: {buf:string,i:int,sz:int Types.option} -> int,
                       get_pos: (unit -> int) Types.option,
                       set_pos: (int -> unit) Types.option,
                       can_output: (unit-> bool) Types.option,
                       close: unit->unit},
              error: {descriptor: IO.file_desc Types.option,
                      put: {buf:string,i:int,sz:int Types.option} -> int,
                      get_pos: (unit -> int) Types.option,
                      set_pos: (int -> unit) Types.option,
                      can_output: (unit->bool) Types.option,
                      close: unit-> unit},
              access: (unit->unit)->unit}

            val currentIO: unit -> IOData
            val redirectIO: IOData -> unit
            val resetIO: unit -> unit
            val print : string -> unit
            val printError : string -> unit
          end


	structure Images :
	  sig
	    exception Table of string
	    val clean : unit -> unit
	    val save : string * (unit -> 'a) -> unit -> 'a
	    val table : string -> string list
	  end

        structure Bits : BITS

	structure Word32 :
	  sig
            val word32_orb: Types.word32 * Types.word32 -> Types.word32
            val word32_xorb: Types.word32 * Types.word32 -> Types.word32
            val word32_andb: Types.word32 * Types.word32 -> Types.word32
            val word32_notb: Types.word32 -> Types.word32
            val word32_lshift: Types.word32 * word -> Types.word32
            val word32_rshift: Types.word32 * word -> Types.word32
            val word32_arshift: Types.word32 * word -> Types.word32
	  end;

	structure Word :
	  sig
            val word_orb: word * word -> word
            val word_xorb: word * word -> word
            val word_andb: word * word -> word
            val word_notb: word -> word
            val word_lshift: word * word -> word
            val word_rshift: word * word -> word
            val word_arshift: word * word -> word
	  end;

	structure Array : ARRAY
	structure ByteArray : BYTEARRAY
        structure FloatArray: FLOATARRAY
	structure ExtendedArray : EXTENDED_ARRAY
	structure Vector : VECTOR

        structure Value :
          sig
            type ml_value
            type T = ml_value

            exception Value of string

            val cast		: 'a -> 'b
            val ccast		: 'a -> 'b
            val list_to_tuple	: T list -> T
            val tuple_to_list	: T -> T list
            val string_to_real	: string -> real
            val real_to_string	: real -> string

            (* real equality -- needed now real isn't an equality type *)
            val real_equal : real * real -> bool
            val arctan : real -> real
            val cos : real -> real
            val exp : real -> real
            val sin : real -> real
            val sqrt : real -> real

            (* Unchecked arithmetic *)
            val unsafe_plus : int * int -> int
            val unsafe_minus : int * int -> int

            (* Unchecked structure accessing *)
            val unsafe_array_sub : '_a Array.array * int -> '_a
            val unsafe_array_update : '_a Array.array * int * '_a -> unit

            val unsafe_bytearray_sub : ByteArray.bytearray * int -> int
            val unsafe_bytearray_update : ByteArray.bytearray * int * int -> unit

            val unsafe_floatarray_sub : FloatArray.floatarray * int -> real
            val unsafe_floatarray_update : FloatArray.floatarray * int * real -> unit

            val unsafe_record_sub : 'a  * int -> 'b
            (* This is the really nasty one, only use to update a newer object with an older *)
            val unsafe_record_update : 'a  * int * 'b -> unit

            (* Unchecked ordof *)
            val unsafe_string_sub	: string * int -> int

            (* Allows destructive update of strings -- use with care *)
            val unsafe_string_update	: string * int * int -> unit

            (* Allocate an object of the specified type. *)
            (* alloc_pair and alloc_vector initialize slots to 0 *)
            (* alloc_string returns uninitialized string of given size *)
            (* nb. size (alloc_string n) = n-1 as the terminating 0 is counted *)

            val alloc_pair		: unit -> ml_value
            val alloc_vector		: int -> ml_value
            val alloc_string		: int -> string

            datatype print_options =
              DEFAULT |
              OPTIONS of {depth_max	  	: int,
                          string_length_max	: int,
                          indent		: bool,
                          tags		  	: bool}
            val print		: print_options * ml_value -> unit

            val pointer		: T * int -> T
            val primary		: T -> int
            val header		: T -> int * int
            val update_header	: T * int * int -> unit
            val sub		: T * int -> T
            val update		: T * int * T -> unit
            val sub_byte	: T * int -> int
            val update_byte	: T * int * int -> unit

            val exn_name	: exn -> string
            val exn_argument	: exn -> T

            val code_name	: T -> string

	    (* exceptions *)
	    val update_exn : exn * exn ref -> unit
	    val update_exn_cons : ('a -> exn) * ('a -> exn) ref -> unit
	    (* Note well *)
	    (* Since these functions update a pair, which is something *)
	    (* the gc is not expecting to happen, you should take care *)
	    (* that the value being placed into the pair is older *)
	    (* than the pair itself. Also, you should not use the updated *)
	    (* exception within a handler inside the structure in which *)
	    (* it (the exception which has been updated) was originally *)
	    (* defined. This is because the compiler will already have *)
	    (* the original unique available to it, and will use that *)
	    (* when generating the handle, rather then that update value *)
	    (* I would also advise against creating a handler in the same *)
	    (* structure as the one containing the called to update_exn, *)
	    (* for similar reasons *)

            (* This stuff should be implementable in a platform independent way *)
            (* The meaning of frame offsets could be platform dependent though *)
            structure Frame :
              sig
                eqtype frame
                val sub		: frame * int -> T
                val update	: frame * int * T -> unit

                (* Gives the frame of the calling function *)
                val current	: unit -> frame
                val is_ml_frame : frame -> bool

                (* This stuff is required by the debugger but really ought to be *)
                (* chucked out. *)

                val frame_call      : (frame -> 'a) -> 'a
                val frame_next      : frame -> bool * frame * int
                val frame_offset    : frame * int -> T
		val frame_double    : frame * int -> T
                val frame_allocations : frame -> bool
              end
          end

        structure Trace :
          sig
            exception Trace of string
            val intercept	: ('a -> 'b) * (Value.Frame.frame -> unit) -> unit
            val replace		: ('a -> 'b) * (Value.Frame.frame -> unit) -> unit
            val restore		: ('a -> 'b) -> unit
	    val restore_all	: unit -> unit
            datatype status = INTERCEPT | NONE | REPLACE | UNTRACEABLE
            val status		: ('a -> 'b) -> status
          end

        structure Runtime :
          sig
            exception Unbound of string
            val environment	: string -> 'a

            val modules		: (string * Value.T * Value.T) list ref

            structure Loader :
              sig
                exception Load of string
                val load_module		: string -> (string * Value.T)
                val load_wordset :
		  int *
		  {a_names:string list,
		   b:{a_clos:int, b_spills:int, c_saves:int, d_code:string} list,
		   c_leafs:bool list, d_intercept:int list,
		   e_stack_parameters: int list} ->
                  (int * Value.T) list
              end;

            structure Memory :
              sig
                val gc_message_level	: int ref
		val max_stack_blocks    : int ref
		val collect             : int -> unit
		val collect_all         : unit -> unit
		val collections         : unit -> int * int
		val promote_all       : unit -> unit
              end;

            structure Event :
              sig
                datatype T = SIGNAL of int
                exception Signal of string
                val signal : int * (int -> unit) -> unit
		val stack_overflow_handler : (unit -> unit) -> unit
		val interrupt_handler : (unit -> unit) -> unit
              end;
          end

        structure Dynamic :
          sig
	    (* Dynamics are rather special.  They can only be used in the
	       interpreter, and require special compiler support.  The
	       generalises_ref is set in _scheme and used in the coerce
	       function.  The coerce function is called by code that is
	       constructed by code in _typerep_utils. *)

            type dynamic
            type type_rep

            exception Coerce of type_rep * type_rep

            val generalises_ref : ((type_rep * type_rep) -> bool) ref

            (* return a coerced value or raise Coerce Coerce (t,t') if
	       generalisation fails *)
            val coerce : (dynamic * type_rep) -> Value.ml_value
          end

        structure Exit :
        sig
          eqtype key
          type status = Types.word32
          val success : status
          val failure : status
          val uncaughtIOException : status
          val badUsage : status
          val stop : status
          val save : status
          val badInput : status
          val atExit : (unit -> unit) -> key
          val removeAtExit : key -> unit
          val exit : status -> 'a
          val terminate : status -> 'a
        end

        structure Debugger :
          sig
            val break_hook : (string -> unit) ref
            val break      : string -> unit
          end

      end (* of structure Internal *)
    structure Profile :
      sig
	type manner
	type function_id = string
	type cost_centre_profile = unit
	
	datatype object_kind =
	  RECORD
	| PAIR
	| CLOSURE
	| STRING
	| ARRAY
	| BYTEARRAY
	| OTHER		(* includes weak arrays, code objects *)
	| TOTAL		(* only used when specifying a profiling manner *)

	datatype large_size =
	  Large_Size of
	  {megabytes : int,
	   bytes : int}	
	
	datatype object_count =
	  Object_Count of
	  {number : int,
	   size : large_size,
	   overhead : int}
	
	datatype function_space_profile =
	  Function_Space_Profile of
	  {allocated : large_size,	
	   copied : large_size,		
	   copies : large_size list,
	   allocation : (object_kind * object_count) list list}
	
	datatype function_caller =
	  Function_Caller of
	  {id: function_id,
	   found: int,
	   top: int,
	   scans: int,
	   callers: function_caller list}
	
	datatype function_time_profile =
	  Function_Time_Profile of
	  {found: int,
	   top: int,
	   scans: int,
	   depth: int,
	   self: int,
	   callers: function_caller list}
	
	datatype function_profile =
	  Function_Profile of
	  {id: function_id,
	   call_count: int,
	   time: function_time_profile,
	   space: function_space_profile}
	
	datatype general_header =
	  General of
	  {data_allocated: int,
	   period: Internal.Types.time,
	   suspended: Internal.Types.time}
	
	datatype call_header =
	  Call of {functions : int}
	
	datatype time_header =
	  Time of
	  {data_allocated: int,
	   functions: int,
	   scans: int,
	   gc_ticks: int,
	   profile_ticks: int,
	   frames: real,
	   ml_frames: real,
	   max_ml_stack_depth: int}
	
	datatype space_header =
	  Space of
	  {data_allocated: int,
	   functions: int,
	   collections: int,
	   total_profiled : function_space_profile}

	type cost_header = unit
	
	datatype profile =
	  Profile of
	  {general: general_header,
	   call: call_header,
	   time: time_header,
	   space: space_header,
	   cost: cost_header,
	   functions: function_profile list,
	   centres: cost_centre_profile list}

	  datatype options =
	    Options of
	    {scan : int,
	     selector : function_id -> manner}

	  datatype 'a result =
	    Result of 'a
	  | Exception of exn

        exception ProfileError of string

	val profile : options -> ('a -> 'b) -> 'a -> ('b result * profile)

	  val make_manner :
	    {time : bool,
	     space : bool,
	     calls : bool,
	     copies : bool,
	     depth : int,
	     breakdown : object_kind list} -> manner
      end

  end (* of structure MLWorks *) ;
