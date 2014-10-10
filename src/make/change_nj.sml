(*  ==== MODIFY NEW JERSEY ENVIRONMENT ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This New Jersey ML source simulates the MLWorks pervasive environment
 *  under New Jersey, to the extent that we are able to compile the
 *  compiler.
 *
 *  Revision Log
 *  ------------
 *  $Log: change_nj.sml,v $
 *  Revision 1.113  1996/04/18 09:15:09  stephenb
 *  Remove exit, terminate, atExit and most of the OS structure since
 *  they are no longer needed now that OS.Process has been updated.
 *
 * Revision 1.112  1996/03/28  10:08:24  matthew
 * Adding definition of outstream
 *
 * Revision 1.111  1996/03/08  12:04:29  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.110  1996/02/22  14:54:37  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.109  1996/02/16  15:38:29  nickb
 * name change fn_save => deliver
 *
 *  Revision 1.108  1996/01/23  10:32:07  matthew
 *  Adding nj-env.sml file
 *
 *  Revision 1.107  1996/01/22  08:34:29  stephenb
 *  OS reorganisation: Remove the OS specific stuff since
 *  this is no longer in the pervasive library.
 *
 *  Revision 1.106  1996/01/16  12:15:33  nickb
 *  Change to GC interface.
 *
 *  Revision 1.105  1996/01/15  16:24:18  matthew
 *  Adding NT directory operations
 *
 *  Revision 1.104  1996/01/15  11:49:46  nickb
 *  Add thread sleep and wake operations.
 *
 *  Revision 1.103  1996/01/15  09:28:31  stephenb
 *  Update wrt change in ../pervasive/__pervasive_library.sml
 *
 *  Revision 1.102  1996/01/08  14:28:48  nickb
 *  Signal reservation removed.
 *
 *  Revision 1.101  1995/12/04  15:46:54  daveb
 *  Pervasive module names now begin with a space.
 *
 *  Revision 1.100  1995/11/21  11:23:35  jont
 *  Add Frame.frame_double for accessing directly spilled reals
 *
 *  Revision 1.99  1995/10/17  12:53:35  jont
 *  Add exec_save for saving executables
 *
 *  Revision 1.98  1995/09/18  09:52:54  daveb
 *  COrrected syntax error.
 *
 *  Revision 1.97  1995/09/18  09:12:57  daveb
 *  Made quot and rem be nonfix.
 *
 *  Revision 1.96  1995/09/13  14:26:22  jont
 *  Add fn_save
 *
 *  Revision 1.95  1995/09/13  13:44:00  daveb
 *  Removed bogus path name that I was using to test previous changes.
 *
 *  Revision 1.94  1995/09/13  13:08:39  daveb
 *  Implemented overloaded types for different sizes of words and ints.
 *
 *  Revision 1.93  1995/08/10  15:42:01  jont
 *  Add ml_char for giving textual representation of chars
 *
 *  Revision 1.92  1995/07/28  08:31:40  matthew
 *  Adding makestring function to Word structure
 *
 *  Revision 1.91  1995/07/25  14:01:17  jont
 *  Add Word structure and Overflow exn
 *
 *  Revision 1.90  1995/07/24  10:06:29  jont
 *  Add Overflow to structure exception
 *
 *  Revision 1.89  1995/07/19  15:10:31  nickb
 *  Two constructors called MLWorks.Profile.Profile.
 *
 *  Revision 1.88  1995/07/19  13:53:24  nickb
 *  Whoops; major type screwups in new profiler.
 *
 *  Revision 1.87  1995/07/19  13:40:57  nickb
 *  Change to profiler interface.
 *
 *  Revision 1.86  1995/07/19  09:15:59  jont
 *  Add chars stuff
 *  Also add new integer functions for hex printing
 *
 *  Revision 1.85  1995/06/02  13:59:54  nickb
 *  Change threads restart system.
 *
 *  Revision 1.84  1995/05/23  15:43:53  nickb
 *  Add threads system.
 *
 *  Revision 1.83  1995/05/11  09:35:56  jont
 *  Bring up to date with revised basis stuff in __pervasive_library.sml
 *
 *  Revision 1.82  1995/05/02  13:13:11  matthew
 *  Adding CAST and UMAP primitives
 *  Removing some stuff from Debugger
 *
 *  Revision 1.81  1995/04/18  09:06:55  jont
 *  Add missing values atExit and terminate
 *
 *  Revision 1.80  1995/03/20  10:41:00  matthew
 *  Adding implode_char
 *
 *  Revision 1.79  1995/03/02  13:41:07  matthew
 *  Unifying Value.Frame and Frame.pointer
 *
 *  Revision 1.78  1995/01/16  10:16:10  jont
 *  Bring into line with current state of Win_nt structure (getcd and get_path_name)
 *
 *  Revision 1.77  1994/12/09  14:39:46  jont
 *  Add OS.Win_nt structure
 *
 *  Revision 1.76  1994/11/24  16:13:54  matthew
 *  Adding new unsafe operations in MLWorks.Internal.Value
 *
 *  Revision 1.75  1994/09/27  16:05:01  matthew
 *  Added pervasive Option structure
 *
 *  Revision 1.74  1994/08/25  09:12:36  matthew
 *  Adding unsafe array operations
 *
 *  Revision 1.73  1994/07/08  10:13:32  nickh
 *  Add event functions for stack overflow and interrupt handlers.
 *
 *  Revision 1.72  1994/07/01  14:58:51  jont
 *  Add messages to Io
 *
 *  Revision 1.71  1994/06/24  09:01:44  nickh
 *  Add trace.restore_all
 *
 *  Revision 1.70  1994/06/10  10:03:18  nosa
 *  Breakpoint settings on function exits.
 *
 *  Revision 1.69  1994/06/09  15:40:59  nickh
 *  Updated runtime system handling.
 *
 *  Revision 1.68  1994/04/08  08:04:49  daveb
 *  Updated with set_file_modified and associated type.
 *
 *  Revision 1.67  1994/03/24  16:16:24  daveb
 *  Adding handler around realpath.
 *
 *  Revision 1.66  1994/03/24  10:41:48  daveb
 *  Fixing typo (braino?).
 *
 *  Revision 1.65  1994/03/23  17:35:08  daveb
 *  Added realpath to NJ runtime.
 *
 *  Revision 1.64  1994/03/14  17:37:26  nickh
 *  Add an fsync when closing files.
 *
 *  Revision 1.63  1994/03/01  10:08:05  nosa
 *  option was missing in structure Debugger.
 *
 *  Revision 1.62  1994/02/27  22:01:08  nosa
 *  Step and breakpoints Debugger.
 *
 *  Revision 1.61  1994/02/08  17:27:42  nickh
 *  Hope it works now :-)
 *
 *  Revision 1.60  1994/02/08  14:26:08  matthew
 *  Added definition for realpath.  This is just the identity function.
 *
 *  Revision 1.59  1994/02/08  10:51:34  nickh
 *  Added MLWorks.String.ml_string
 *
 *  Revision 1.58  1994/02/03  09:47:49  matthew
 *  Added definition for getwd
 *
 *  Revision 1.57  1993/11/26  12:31:52  nickh
 *  Hacks for Elapsed.elapsed, elapsed_since, format.
 *
 *  Revision 1.56  1993/11/22  16:26:36  jont
 *  Changed type of modules to include a time stamp field
 *
 *  Revision 1.55  1993/11/18  12:16:15  nickh
 *  Add to IO and RawIO to provide closed_in and closed_out functions for
 *  testing open/closed status. (also fix Time structure bug).
 *
 *  Revision 1.54  1993/11/15  15:18:52  nickh
 *  New pervasive time structure; in particular extension to encode/decode.
 *
 *  Revision 1.53  1993/08/31  09:52:13  daveb
 *  Added OS.Unix.{unlink,rmdir,mkdir}
 *
 *  Revision 1.52  1993/08/26  11:13:21  richard
 *  Removed the X exception.  It's now in the Motif interface code.
 *
 *  Revision 1.51  1993/08/26  10:09:04  richard
 *  Declared a special version of require for the pervasive modules.  This
 *  is necessary because of changes to the module naming scheme.
 *
 *  Revision 1.50  1993/08/26  09:58:26  richard
 *  Added X exception.
 *
 *  Revision 1.49  1993/08/25  14:01:00  richard
 *  Added dummy MLWorks.OS.Unix.kill.
 *
 *  Revision 1.48  1993/07/28  11:35:56  richard
 *  Changes to MLWORKS signature.  See pervasive/mlworks.sml.
 *
 *  Revision 1.47  1993/07/19  13:37:03  nosa
 *  Added two frame functions for debugger
 *
 *  Revision 1.46  1993/06/10  15:58:25  matthew
 *  Added text_preprocess hook
 *
 *  Revision 1.45  1993/05/05  16:05:56  jont
 *  Added MLWorks.OS.Unix.password_file to get the association list of user names
 *  to home directories necessary for translating ~
 *
 *  Revision 1.44  1993/04/23  14:51:13  jont
 *  Added Integer and Real substructures of MLWorks
 *
 *  Revision 1.43  1993/04/22  17:22:21  jont
 *  Added write_byte for FileIO and output_byte to RawIO
 *
 *  Revision 1.42  1993/04/22  13:39:46  richard
 *  Removed defunct Editor interface and added sytem calls to enable
 *  its replacement.
 *
 *  Revision 1.41  1993/04/20  10:12:57  richard
 *  New Unix and Trace stuff.  See MLWorks signature.
 *
 *  Revision 1.40  1993/04/13  09:59:17  matthew
 *  Changed TypeRep to Dynamic and restructured
 *  Moved break stuff out of tracing.
 *
 *  Revision 1.39  1993/04/08  17:29:56  jont
 *  Minor modifications to editor structure
 *
 *  Revision 1.38  1993/04/06  13:00:31  jont
 *  Removed use of pervasive ordof
 *
 *  Revision 1.37  1993/04/02  15:27:40  jont
 *  Extended images structure to include table of contents reading
 *
 *  Revision 1.36  1993/03/26  15:53:27  matthew
 *  Added break function to Tracing substructure
 *
 *  Revision 1.35  1993/03/23  18:32:34  jont
 *  Minor change to interface to edit file
 *
 *  Revision 1.34  1993/03/11  18:37:25  jont
 *  Added Intermal.Images including save and clean. Added other_operation to
 *  Editor for arbitrary bits of emacs lisp
 *
 *  Revision 1.33  1993/03/10  16:30:56  jont
 *  Added editor substructure to MLWorks
 *
 *  Revision 1.32  1993/02/18  16:56:08  matthew
 *  Added TypeRep signature in MLWorks.Internal
 *
 *  Revision 1.31  1993/02/17  11:05:21  daveb
 *  Corrected string argument to Unimplemented for MLWorks.Time.Real.now.
 *
 *  Revision 1.30  1993/01/05  16:54:24  richard
 *  Added some extra exceptions for the runtime system.
 *
 *  Revision 1.29  1992/12/22  10:50:12  clive
 *  ExtendedArray should not be available at the top level
 *
 *  Revision 1.28  1992/12/22  10:25:37  daveb
 *  Made ExtendedArray visible at top level.
 *
 *  Revision 1.27  1992/12/22  10:05:26  clive
 *  Needed to define the type T in the Array structure
 *
 *  Revision 1.26  1992/12/22  10:02:01  matthew
 *  Added 'agreed' Array and Vector structures.
 *
 *  Revision 1.25  1992/12/01  13:05:26  matthew
 *  Fixed problem with IO
 *
 *  Revision 1.24  1992/12/01  12:45:10  matthew
 *  Changed IO structure to mirror __pervasive_library
 *
 *  Revision 1.23  1992/11/12  15:58:16  clive
 *  Added some rts support for tracing
 *
 *  Revision 1.22  1992/11/10  13:14:23  richard
 *  Added StorageManager exception and changed the type of the
 *  StorageManager interface function.
 *
 *  Revision 1.21  1992/11/02  10:06:49  richard
 *  Many changes.  See MLWorks signature.
 *
 *  Revision 1.20  1992/09/25  14:36:13  matthew
 *  Added Internal.string_to_real
 *
 *  Revision 1.19  1992/09/23  16:16:41  daveb
 *  Added clear_eof function to IO (unimplemented).
 *
 *  Revision 1.18  1992/09/01  14:34:40  richard
 *  Changed the OS information stuff to functions.  Added Prod and
 *  Value exceptions.
 *  Implemented save.
 *
 *  Revision 1.17  1992/08/28  15:00:49  clive
 *  Added a function to the pervasive_library to get debug_info from a
 *  function
 *
 *  Revision 1.16  1992/08/28  08:26:28  richard
 *  Changed call to environment so that environment is not
 *  preserved across images.
 *  Added floating-point exceptions.
 *
 *  Revision 1.15  1992/08/26  14:34:26  richard
 *  Rationalisation of the MLWorks structure.
 *
 *  Revision 1.14  1992/08/25  16:27:11  richard
 *  Added ByteArray structure and writebf in FileIO.
 *
 *  Revision 1.13  1992/08/24  14:16:46  davidt
 *  Added a faster implementation of FileIO.writef which
 *  doesn't allocate as many bytearrays.
 *
 *  Revision 1.12  1992/08/20  12:44:05  richard
 *  Changed path of require of mlworks to use pervasive directory.
 *
 *  Revision 1.11  1992/08/20  08:33:04  richard
 *  Enriched the Array structure.
 *
 *  Revision 1.10  1992/08/18  16:40:49  richard
 *  Added real_to_string.
 *
 *  Revision 1.9  1992/08/18  14:44:59  richard
 *  Changes to the MLWorks signature.  See mlworks file for
 *  details.
 *
 *  Revision 1.8  1992/08/17  11:05:12  richard
 *  Added MLWorks.System.Runtime.GC.interface.
 *
 *  Revision 1.7  1992/08/15  17:32:57  davidt
 *  Put in MLWorks.IO.input_line function.
 *
 *  Revision 1.6  1992/08/13  15:30:59  clive
 *  Added two functions to the debugger
 *
 *  Revision 1.4  1992/08/12  14:21:36  davidt
 *  Took out copying of Array and String structures from the
 *  MLWorks structure in an attempt to see if NewJersey was
 *  getting confused and not inlining code for array updates.
 *
 *  Revision 1.3  1992/08/11  05:59:23  richard
 *  Added load_wordset to Int structure.
 *
 *  Revision 1.2  1992/08/10  15:26:16  davidt
 *  Changed MLworks structure to MLWorks
 *
 *  Revision 1.1  1992/08/07  15:03:28  davidt
 *  Initial revision
 *
 *  Revision 1.1  1992/05/18  15:40:36  clive
 *  Initial revision
 *)

(* This require is just for the pervasive modules. *)
fun require s =
    use ("pervasive/"
	 ^ (case Char.fromString s of
		SOME #" " => String.substring (s, 1, size s - 1)
	      | _ => s)
	 ^ ".sml");

require "mlworks";

local
    exception Unimplemented of string
    fun unimplemented (name:string)  =
	(TextIO.print ("unimplemented MLWorks pervasive: " ^ name ^ "\n");
	 raise Unimplemented name;
	 Unsafe.cast 0)

    structure SMLBasisArray = Array
    structure SMLBasisArraySlice = ArraySlice
    structure SMLBasisVector = Vector
    structure SMLBasisString = String
    structure SMLBasisChar = Char
    structure SMLBasisInt = Int
    structure SMLBasisReal = Real
    structure SMLBasisMath = Math
    structure SMLBasisTime = Time
    structure SMLBasisInt32 = Int32
    structure SMLBasisWord = Word
    structure SMLBasisWord32 = Word32
    structure SMLBasisWord8 = Word8
    structure SMLBasisWord8Array = Word8Array
    structure SMLBasisWord8ArraySlice = Word8ArraySlice
    structure SMLBasisRealArray = RealArray
    structure SMLBasisRealArraySlice = RealArraySlice
    structure SMLBasisOption = Option
    structure SMLBasisOS = OS
    structure SMLBasisOSProcess = OS.Process
in
structure MLWorks : MLWORKS =
  struct

    structure String =
      struct
	local
	    structure S = SMLBasisString
	in
	exception Substring = General.Subscript
	exception Chr = General.Chr
	exception Ord
	val maxLen = S.maxSize
	fun explode (s:string) = List.map S.str (S.explode s)
	fun implode (l:string list) = S.concat l
	val str = S.str
	fun chr (i:int) = S.str (Char.chr i)
	val sub = S.sub
	val substring = S.substring
	val op < = S.<
	val op > = S.>
	val op >= = S.>=
	val op <= = S.<=
	fun ordof (s, i) = SMLBasisChar.ord (sub (s, i))
	fun ord (s:string) =
	    case size s of
		1 => Char.ord (sub (s, 0))
	     |  _ => raise Ord
	fun ml_string (s,max_size) =
	    let
		fun to_digit n = Char.chr (n + Char.ord #"0")
		fun aux ([],result:char list,_) =
		    S.implode (rev result)
		  | aux (_,result,0) =
		    S.implode (rev (#"\\" :: #"." :: #"." :: result))
		  | aux (char::rest,result,n) =
		    let val newres =
			    case char of
				#"\n" => #"\\"::char::result
			      | #"\t" => #"\\"::char::result
			      | #"\"" => #"\\"::char::result
			      | #"\\" => #"\\"::char::result
			      | c =>
				let val n = Char.ord c
				in
				    if Int.< (n, 32) orelse Int.>= (n, 127)
				    then
					let
					    val n1 = n div 10
					in
					    (to_digit (n mod 10))::
					    (to_digit (n1 mod 10))::
					    (to_digit (n1 div 10))::
					    (#"\\")::result
					end
				    else
					c::result
				end
		    in
			aux (rest, newres, n-1)
		    end
	    in
		aux (S.explode s,[],
		     if Int.<(max_size, 0) then ~1 else max_size)
	    end
	fun implode_char ints =
	    S.implode (map SMLBasisChar.chr ints)

	end
      end

    exception Interrupt

    structure Option = SMLBasisOption

    structure Char =
      struct
	type char = SMLBasisChar.char
	fun ml_char c = String.ml_string(c, ~1)
	val chr = SMLBasisChar.chr
	val ord = SMLBasisChar.ord
	val maxCharOrd = 255
	exception Chr = Chr

	(* Finally define these *)
	val op <  : char * char -> bool = op <
	val op >  : char * char -> bool = op >
	val op <= : char * char -> bool = op <=
	val op >= : char * char -> bool = op >=
      end

    structure Integer =
      struct
	val makestring : int -> string = SMLBasisInt.toString
	val print : int -> unit = fn i => TextIO.print (makestring i)
	fun hexmakestring _ = unimplemented"hexmakestring"
	fun hexprint _ = unimplemented"hexprint"
      end

    structure Real =
      struct
	val makestring : real -> string = SMLBasisReal.toString
	val print : real -> unit = fn r => TextIO.print (makestring r)
      end

    structure Deliver = struct
	datatype app_style = CONSOLE | WINDOWS
	type deliverer = string * (unit -> unit) * app_style -> unit
	type delivery_hook = deliverer -> deliverer
	fun deliver (x,y,z) = (unimplemented "MLWorks.Deliver.deliver";
			       ())
	fun with_delivery_hook _ =
	    unimplemented "MLWorks.Deliver.with_delivery_hook"
	fun add_delivery_hook x =
	    (TextIO.print ("add_delivery_hook called");
	     ())
	val exitFn = ref (fn () =>
			     (unimplemented "MLWorks.Deliver.exitFn"; ()))
      end

    val arguments = CommandLine.arguments
    val name = CommandLine.name

    structure Threads =
      struct
	datatype 'a thread = Thread of { r : 'a }
        exception Threads of string

	fun fork f =
	    (unimplemented "MLWorks.Threads.fork";
	     fn (a) => Thread {r=f(a)})
	fun yield () = (unimplemented "MLWorks.Threads.yield"; ())

	datatype 'a result =
		 Running		(* still running *)
		 | Waiting		(* waiting *)
		 | Sleeping		(* sleeping *)
		 | Result of 'a		(* completed, with this result *)
		 | Exception of exn	(* exited with this uncaught exn *)
		 | Died			(* died (e.g. bus error) *)
		 | Killed		(* killed *)
		 | Expired		(* no longer exists (from a previous image) *)

	fun result (Thread{r}) = (unimplemented "MLWorks.Threads.result";
				  Result r)
	fun sleep _ =  (unimplemented "MLWorks.Threads.sleep"; ())
	fun wake _ =  (unimplemented "MLWorks.Threads.wake"; ())

	structure Internal = struct
	    type thread_id = unit
	    fun id _ = (unimplemented "MLWorks.Threads.Internal.id"; ())
	    fun get_id _ = (unimplemented "MLWorks.Threads.Internal.get_id";())
	    fun children _ =
		(unimplemented "MLWorks.Threads.Internal.children";[])
	    fun parent _ = (unimplemented "MLWorks.Threads.Internal.parent";())
	    fun all _ = (unimplemented "MLWorks.Threads.Internal.all";[])
	    fun kill _ = (unimplemented "MLWorks.Threads.Internal.kill";())
	    fun raise_in _ =
		(unimplemented "MLWorks.Threads.Internal.raise_in";())
	    fun yield_to _ =
		(unimplemented "MLWorks.Threads.Internal.yield_to";())
	    fun state _ = (unimplemented "MLWorks.Threads.Internal.state";
			   Result ())
	    fun get_num _ = (unimplemented "MLWorks.Threads.Internal.get_num";
			     0)
	    fun set_handler _ =
		(unimplemented "MLWorks.Threads.Internal.set_handler"; ())
	    fun reset_fatal_status _ =
		(unimplemented "MLWorks.Threads.Internal.reset_fatal_status";
		 ())
	    structure Preemption =
	      struct
		fun start _ =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.start";
		     ())
		fun stop _ =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.stop";())
		fun on _ =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.on";
		     false)
		fun get_interval _ =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.get_interval"; 0)
		fun set_interval _ =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.set_interval"; ())
		fun enter_critical_section () =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.enter_critical_section";
		     ())
		fun exit_critical_section () =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.exit_critical_section";
		     ())
		fun in_critical_section () =
		    (unimplemented "MLWorks.Threads.Internal.Preemption.exit_critical_section";
		     false)
	      end
	  end
      end

    exception Save of string
    fun save (filename, function) =
	(SMLofNJ.exportFn (filename,
			   fn _ => (function(); OS.Process.success));
	 function)

    fun deliver _ = unimplemented "MLWorks.deliver"

    fun exec_save _ = unimplemented "MLWorks.exec_save"

    structure OS =
      struct
        fun arguments () =
            case CommandLine.arguments ()
             of [] => []
              | program_name::rest => rest
      end

    structure Debugger =
      struct
        fun default_break s = TextIO.print("Break at " ^ s ^ "\n")
        val break_hook = ref default_break
        fun break s = (!break_hook) s
      end

    structure Internal =
      struct
	local
	    fun w8vectorToString (v:Word8Vector.vector):string =
		let fun b2c i = Char.chr (Word8.toInt (Word8Vector.sub (v, i)))
		in CharVector.tabulate (Word8Vector.length v, b2c)
		end

	    fun stringToW8vector (s:string):Word8Vector.vector =
		let fun c2b i = Word8.fromInt (Char.ord (String.sub (s, i)))
		in Word8Vector.tabulate (SMLBasisString.size s, c2b)
		end
	in

        exception Save of string
	fun save (s, f) = (unimplemented "Internal.save"; f)
	fun execSave (s, f) = (unimplemented "Internal.execSave"; f)
	val text_preprocess = ref (fn (f : int -> string ) => f)
	fun real_to_string (r, i) = SMLBasisReal.toString (r)
        exception StringToReal

        fun string_to_real string =
	    case SMLBasisReal.fromString string of
		NONE => raise StringToReal
	      | SOME r => r

	structure Images =
	  struct
	    fun clean _ = ()
	    val save = save
	    exception Table of string
	    fun table _ = []
	  end

	structure Types =
	  struct
	    (* These are all somewhat bogus. *)
	    type word8 = SMLBasisWord8.word
	    type int8 = int
	    type word16 = int
	    type int16 = int
	    type word32 = SMLBasisWord32.word
	    type int32 = SMLBasisInt32.int
	    datatype option = datatype SMLBasisOption.option
	    datatype time = datatype MLWTime.time
	  end

	structure Error =
	  struct
	    type syserror = Posix.Error.syserror
	    exception SysErr = SMLBasisOS.SysErr
	    val errorMsg = Posix.Error.errorMsg
	    val errorName = Posix.Error.errorName
	    val syserror = Posix.Error.syserror
	  end

        structure IO =
	  struct
            exception Io of {cause: exn, name: string, function: string}
	    datatype file_desc = FILE_DESC of int
	    datatype access_mode = datatype Posix.FileSys.access_mode

	    structure W8 = Word8
	    structure W32 = SMLBasisWord32
	    structure W8A = Word8Array
	    structure W8S = Word8ArraySlice

	    fun stringToW8S (s, start, len) =
		let fun c2b i = W8.fromInt (Char.ord (String.sub (s, start+i)))
		in
		    W8S.full (W8A.tabulate (len, c2b))
		end

	    fun posixFD (FILE_DESC fd) =
		Posix.FileSys.wordToFD (W32.fromInt fd)

            fun write (fd, s, start, len) =
		Posix.IO.writeArr (posixFD fd, stringToW8S (s, start, len))

	    fun read (fd, n:int) =
		(* val _= TextIO.print ("D: read called: " ^ Int.toString n
					 ^ "\n") *)
		w8vectorToString (Posix.IO.readVec (posixFD fd, n))

	    fun seek (fd, offset, whence) =
		let val w = (case whence of
				 0 => Posix.IO.SEEK_SET
			       | 1 => Posix.IO.SEEK_CUR
			       | 2 => Posix.IO.SEEK_END
			       | _ => (unimplemented "seek whence";
				       Posix.IO.SEEK_END))
		in
		    Posix.IO.lseek (posixFD fd, offset, w)
		end

	    fun close fd = Posix.IO.close (posixFD fd)

	    fun can_input fd =
		let val (_, mode) = Posix.IO.getfl (posixFD fd)
		in
		    (case mode of
			 Posix.IO.O_RDONLY => 0
		      |  Posix.IO.O_RDWR => 0
		      |  Posix.IO.O_WRONLY => 1)
		end
	  end

	structure StandardIO =
	  struct
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

	    local
		fun put_ {buf:string,i:int,sz:int Types.option} : int =
		    let val j = case sz of
				    SOME s => i + s
				  | NONE => SMLBasisString.size buf
			val s = SMLBasisString.substring (buf, i, j)
		    in
			TextIO.print (s);
			SMLBasisString.size s
		    end
		fun close_ () =
		    (TextIO.print ("D: change_nj.sml close_ called\n");
		     ())
		val dummyIO:IOData = {
		      output = { descriptor = NONE,
				 put = put_,
				 get_pos = NONE,
				 set_pos = NONE,
				 can_output = NONE,
				 close = close_ },
		      error = { descriptor= NONE,
				put = put_,
				get_pos = NONE,
				set_pos = NONE,
				can_output = NONE,
				close = close_ },
		      input = { descriptor = NONE,
				get = fn _ => (unimplemented "IOData.get";
					       ""),
				get_pos = NONE,
				set_pos = NONE,
				close = close_,
				can_input = NONE },
		      access = fn f =>f() }
	    in
	    fun currentIO () = (dummyIO)
	    fun redirectIO x = (TextIO.print "D: redirectIO called\n"; ())
	    fun resetIO () = (TextIO.print "D: resetIO called\n"; ())
	    fun print _ = unimplemented "print"
	    fun printError _ = unimplemented "printError"
	    end
	  end

	structure Bits : BITS =
	  struct
            local
		structure W = SMLBasisWord32
		fun lift (f) =
		    fn (x:int, y:int) =>
		       W.toIntX (f (W.fromInt x, W.fromInt y))
		fun lifts (f) =
		    fn (x:int, y:int) =>
		       W.toIntX (f (W.fromInt x, Word31.fromInt y))
	    in
	    val andb = lift W.andb
	    val orb = lift W.orb
	    val xorb = lift W.xorb
	    val lshift = lifts W.<<
	    val rshift = lifts W.>>
	    val arshift = lifts W.~>>
	    fun notb (x) = W.toIntX (W.notb (W.fromInt x))
	    end
	  end

        structure Word32 =
          struct
	    local
		(* open NewJersey.Bits *)
		structure W = SMLBasisWord32
		type w32 = W.word
		fun lifts (f) =
		    fn (x:w32, y:word) =>
		       (f (x, Word31.fromLarge (SMLBasisWord.toLarge y))):w32
	    in
	    val word32_lshift  : w32 * word -> w32 = lifts W.<<
	    val word32_rshift  : w32 * word -> w32 = lifts W.>>
	    val word32_arshift : w32 * word -> w32 = lifts W.~>>
	    val word32_orb  : w32 * w32 -> w32 = W.orb
	    val word32_xorb : w32 * w32 -> w32 = W.xorb
	    val word32_andb : w32 * w32 -> w32 = W.andb
	    val word32_notb : w32 -> w32 = W.notb
	    end
          end

	structure Word =
          struct
	    local
		type word = SMLBasisWord.word
		type w = Word31.word
	    in
	    val word_lshift = SMLBasisWord.<<
	    val word_rshift  : word * w -> word = SMLBasisWord.>>
	    val word_arshift : word * w -> word = SMLBasisWord.~>>
	    val word_orb  : word * word -> word = SMLBasisWord.orb
	    val word_xorb : word * word -> word = SMLBasisWord.xorb
	    val word_andb : word * word -> word = SMLBasisWord.andb
	    val word_notb : word -> word = SMLBasisWord.notb
	    end
          end

	structure Array : ARRAY =
	  struct
	    open SMLBasisArray
	    exception Size
	    exception Subscript
	    val arrayoflist = SMLBasisArray.fromList
	  end

	structure ByteArray : BYTEARRAY =
	  struct
            local
		structure W8A = SMLBasisWord8Array
		structure W8S = SMLBasisWord8ArraySlice
		structure W8 = SMLBasisWord8
		structure S = SMLBasisString
		structure C = SMLBasisChar
	    in
	    type bytearray = W8A.array

	    exception Range of int
	    exception Size
	    exception Subscript
	    exception Substring
	    exception Find

	    fun array (len, init) = W8A.array (len, (W8.fromInt init))
	    val length = W8A.length
	    fun update (arr, i, x) = W8A.update (arr, i, (W8.fromInt x))
	    fun sub (arr, i) = W8.toInt (W8A.sub (arr, i))
	    fun arrayoflist ilist = W8A.fromList (map W8.fromInt ilist)
	    fun tabulate (n, f) = W8A.tabulate (n, fn (i) => W8.fromInt (f i))
	    val from_list = arrayoflist
	    fun to_list arr = List.tabulate (length arr, fn i => sub (arr, i))
	    fun from_string s =
		tabulate (S.size s, fn i => C.ord (S.sub (s, i)))
	    fun substring (arr, start, len) =
		let fun f i = C.chr (sub (arr, start + i))
		in CharVector.tabulate (len, f)
		end
	    fun to_string arr = substring (arr, 0, length arr)
	    fun fill (arr, x) =
		let val b = W8.fromInt x
		in W8A.modify (fn _ => b) arr
		end
	    fun map_index f arr =
		tabulate (length arr, fn i => f (i, sub (arr, i)))
	    fun map f arr = map_index (f o #2) arr
	    fun iterate_index f arr =
		W8A.appi (fn (i, w) => f (i, W8.toInt w)) arr
	    fun iterate f arr = iterate_index (f o #2) arr
	    fun rev arr =
		let val len = length arr
		in W8A.tabulate (len, fn i => W8A.sub (arr, (len - 1) - i))
		end
	    fun duplicate arr =
		let val result = W8A.array (length arr, 0w0)
		in
		    W8A.copy { src = arr, dst = result, di = 0 };
		    result
		end
	    fun subarray (arr, start, end_) =
		let val result = W8A.array (end_ - start, 0w0)
		in
		    W8S.copy { src = W8S.slice (arr, start, SOME end_),
			       dst = result,
			       di = 0 };
		    result
		end
	    fun append (arr1, arr2) =
		let val len1 = length arr1
		    val len2 = length arr2
		    val result = W8A.array (len1 + len2, 0w0)
		in
		    W8A.copy {src = arr1, dst = result, di = 0};
		    W8A.copy {src = arr2, dst = result, di = len1};
		    result
		end
	    fun reducel_index f (init, arr) =
		let fun g (i, w, state) = f (i, state, W8.toInt w)
		in W8A.foldli g init arr
		end
	    fun reducer_index f (arr, init) =
		let fun g (i, w, state) = f (i, W8.toInt w, state)
		in W8A.foldri g init arr
		end
	    fun reducel f (init, arr) =
		reducel_index (fn (_, state, x) => f (state, x)) (init, arr)
	    fun reducer f (arr, init) =
		reducer_index (fn (_, x, state) => f (x, state)) (arr, init)
	    fun copy (src, start, end_, dst, start') =
		W8S.copy { src = W8S.slice (src, start, SOME end_),
			   dst = dst,
			   di = start'}
	    fun fill_range (arr, start, end_, x) =
		let val w = W8.fromInt x
		in W8S.modify (fn _ => w) (W8S.slice (arr, start, SOME end_))
		end
	    local
		fun find' f arr = W8A.findi (fn (_, w) => f (W8.toInt w)) arr
	    in
	    fun find f arr =
		case find' f arr of
		    NONE => raise Find
		  | SOME (i, _) => i
	    fun find_default (f, default) arr =
		case find' f arr of
		    NONE => default
		  | SOME (i, _) => i
	    end
	    val maxLen = W8A.maxLen

	    end
	  end

        structure FloatArray : FLOATARRAY =
	  struct
	    local
		structure A = SMLBasisRealArray
		structure S = SMLBasisRealArraySlice
	    in
	    type floatarray = A.array
	    exception Range of int
	    exception Size
	    exception Subscript
	    exception Find
	    val array = A.array
	    val length = A.length
	    val sub = A.sub
	    val update = A.update
	    val tabulate = A.tabulate
	    val arrayoflist = A.fromList
	    val from_list = A.fromList
	    fun to_list arr = List.tabulate (length arr, fn i => sub (arr, i))
	    fun fill (arr, x) = A.modify (fn _ => x) arr
	    fun map_index f arr =
		tabulate (length arr, fn i => f (i, (sub (arr, i))))
	    fun map f arr = map_index (f o #2) arr
	    val iterate = A.app
	    val iterate_index = A.appi
	    fun rev arr =
		let val len = length arr
		in tabulate (len, fn i => sub (arr, (len - 1) - i))
		end
	    fun duplicate arr =
		let val result = array (length arr, 0.0)
		in
		    A.copy { src = arr, dst = result, di = 0 };
		    result
		end
	    fun subarray (arr, start, end_) =
		let val result = array (end_ - start, 0.0)
		in
		    S.copy { src = S.slice (arr, start, SOME end_),
			     dst = result,
			     di = 0 };
		    result
		end
	    fun append (arr1, arr2) =
		let val len1 = length arr1
		    val len2 = length arr2
		    val result = array (len1 + len2, 0.0)
		in
		    A.copy {src = arr1, dst = result, di = 0};
		    A.copy {src = arr2, dst = result, di = len1};
		    result
		end
	    fun reducel_index f (init, arr) =
		let fun g (i, x, state) = f (i, state, x)
		in A.foldli g init arr
		end
	    fun reducer_index f (arr, init) = A.foldri f init arr
	    fun reducel f (init, arr) =
		reducel_index (fn (_, state, x) => f (state, x)) (init, arr)
	    fun reducer f (arr, init) = A.foldr f init arr
	    fun copy (src, start, end_, dst, start') =
		S.copy { src = S.slice (src, start, SOME end_),
			 dst = dst,
			 di = start'}
	    fun fill_range (arr, start, end_, x) =
		S.modify (fn _ => x) (S.slice (arr, start, SOME end_))
	    local
		fun find' f arr = A.findi (fn (_, x) => f x) arr
	    in
	    fun find f arr =
		case find' f arr of
		    NONE => raise Find
		  | SOME (i, _) => i
	    fun find_default (f, default) arr =
		case find' f arr of
		    NONE => default
		  | SOME (i, _) => i
	    end
	    val maxLen = A.maxLen

	    end
	  end

	structure ExtendedArray : EXTENDED_ARRAY =
	  struct
	    local
		structure A = SMLBasisArray
		structure S = SMLBasisArraySlice
	    in
	    type 'a array = 'a A.array
	    exception Range of int
	    exception Size
	    exception Subscript
	    exception Find
	    val array = A.array
	    val length = A.length
	    val sub = A.sub
	    val update = A.update
	    val tabulate = A.tabulate
	    val arrayoflist = A.fromList
	    val from_list = A.fromList
	    fun to_list arr = List.tabulate (length arr, fn i => sub (arr, i))
	    fun fill (arr, x) = A.modify (fn _ => x) arr
	    fun map_index f arr =
		tabulate (length arr, fn i => f (i, (sub (arr, i))))
	    fun map f arr = map_index (f o #2) arr
	    val iterate = A.app
	    val iterate_index = A.appi
	    fun rev arr =
		let val len = length arr
		in tabulate (len, fn i => sub (arr, (len - 1) - i))
		end
	    local
		fun alloc (len, proto) =
		    if len = 0
		    then tabulate (0, fn i => sub (proto, i))
		    else array (len, sub (proto, 0))
	    in
	    fun duplicate arr =
		let val result = alloc (length arr, arr)
		in
		    A.copy { src = arr, dst = result, di = 0 };
		    result
		end
	    fun subarray (arr, start, end_) =
		let val result = alloc (end_ - start, arr)
		in
		    S.copy { src = S.slice (arr, start, SOME end_),
			     dst = result,
			     di = 0 };
		    result
		end
	    fun append (arr1, arr2) =
		let val len1 = length arr1
		    val len2 = length arr2
		    val result = alloc (len1 + len2, arr1)
		in
		    A.copy {src = arr1, dst = result, di = 0};
		    A.copy {src = arr2, dst = result, di = len1};
		    result
		end
	    end
	    fun reducel_index f (init, arr) =
		let fun g (i, x, state) = f (i, state, x)
		in A.foldli g init arr
		end
	    fun reducer_index f (arr, init) = A.foldri f init arr
	    fun reducel f (init, arr) =
		reducel_index (fn (_, state, x) => f (state, x)) (init, arr)
	    fun reducer f (arr, init) = A.foldr f init arr
	    fun copy (src, start, end_, dst, start') =
		S.copy { src = S.slice (src, start, SOME end_),
			 dst = dst,
			 di = start'}
	    fun fill_range (arr, start, end_, x) =
		S.modify (fn _ => x) (S.slice (arr, start, SOME end_))
	    local
		fun find' f arr = A.findi (fn (_, x) => f x) arr
	    in
	    fun find f arr =
		case find' f arr of
		    NONE => raise Find
		  | SOME (i, _) => i
	    fun find_default (f, default) arr =
		case find' f arr of
		    NONE => default
		  | SOME (i, _) => i
	    end
	    val maxLen = A.maxLen

	    end
	  end

	structure Vector : VECTOR =
	  struct
	    local
		structure V = SMLBasisVector
	    in
	    type 'a vector = 'a V.vector
	    exception Size
	    exception Subscript
	    val vector = V.fromList
	    val tabulate = V.tabulate
	    val sub = V.sub
	    val length = V.length
	    val maxLen = V.maxLen
	    end
	  end

        structure Value =
          struct
            type T = unit
            type ml_value = T
            exception Value of string
            val cast = Unsafe.cast
            val ccast = Unsafe.cast
            datatype print_options =
		     DEFAULT |
		     OPTIONS of {depth_max		: int,
				 string_length_max	: int,
				 indent		: bool,
				 tags			: bool}

            fun unsafe_plus _ = unimplemented "unsafe_plus"
            fun unsafe_minus _ = unimplemented "unsafe_minus"

            val unsafe_array_sub = Array.sub
            val unsafe_array_update = Array.update

            val unsafe_bytearray_sub = ByteArray.sub
            val unsafe_bytearray_update = ByteArray.update

	    val unsafe_floatarray_sub = FloatArray.sub
            val unsafe_floatarray_update = FloatArray.update

            fun unsafe_record_sub (x, _) = unimplemented "unsafe_record_sub"
            fun unsafe_record_update _ = unimplemented "unsafe_record_update"

            fun unsafe_string_sub (s, i) = Char.ord (String.sub (s, i))
            fun unsafe_string_update _ = unimplemented "unsafe_string_update"

            fun alloc_pair _ = unimplemented "alloc_pair"
            fun alloc_string _ = unimplemented "Value.alloc_string"
            fun alloc_vector _ = unimplemented "alloc_vector"

            fun list_to_tuple _ = unimplemented "list_to_tuple"
            fun tuple_to_list _ = unimplemented "tuple_to_list"
	    local
		(* encode a 64bit float as a Word8Vector with
		   big endian order. *)
		fun packReal64Big r =
		    let val r64a = Real64Array.array (1, r)
			(* i386 is little endian  *)
			fun load_byte i =
			    Unsafe.Word8Array.sub (r64a, 8 - 1 - i)
		    in Word8Vector.tabulate (8, load_byte)
		    end
		fun unpackReal64Big v =
		    let val r64a = Real64Array.array (1, 0.0)
			fun store_byte (i, b) =
			    Unsafe.Word8Array.update (r64a, 8 - 1 - i, b)
		    in Word8Vector.appi store_byte v;
		       Real64Array.sub (r64a, 0)
		    end
	    in
            fun string_to_real (s:string):real =
		unpackReal64Big (stringToW8vector s)
            fun real_to_string (r:real):string =
		w8vectorToString (packReal64Big r)
	    end
	    fun real_equal (x, y) = SMLBasisReal.== (x, y)
	    fun arctan x = SMLBasisMath.atan x
	    fun cos x = SMLBasisMath.cos x
	    fun exp x = SMLBasisMath.exp x
	    fun sin x = SMLBasisMath.cos x
	    fun sqrt x = SMLBasisMath.sqrt x

            fun print _ = unimplemented "Value.print"
            fun primary _ = unimplemented "Value.primary"
            fun header _ = unimplemented "Value.header"
            fun update_header _ = unimplemented "MLWorks.Internal.Value.update_header"
            fun pointer _ = unimplemented "Value.pointer"
            fun update _ = unimplemented "MLWorks.Internal.Value.update"
            fun sub _ = unimplemented "MLWorks.Internal.Value.sub"
            fun update_byte _ = unimplemented "MLWorks.Internal.Value.update_byte"
            fun sub_byte _ = (unimplemented "MLWorks.Internal.Value.sub_byte"; 0)
            fun update_header _ = unimplemented "MLWorks.Internal.Value.update_header"
            fun exn_name _ = (unimplemented "MLWorks.Internal.Value.exn_name"; "")
            fun code_name _ = (unimplemented "MLWorks.Internal.Value.code_name"; "")
            fun exn_argument _ = unimplemented "MLWorks.Internal.Value.exn_argument"
            fun exn_name_string _ = unimplemented "MLWorks.Internal.Value.exn_name_string"
	    fun update_exn _ = unimplemented "Value.update_exn"
	    fun update_exn_cons _ = unimplemented "Value.update_exn_cons"

            structure Frame =
              struct
                type frame = unit

                fun frame_call f = (unimplemented "MLWorks.Internal.Value.Frame.frame_call"; f ())
                fun frame_next _ = (unimplemented "MLWorks.Internal.Value.Frame.frame_next"; (false, (), 0))
                fun frame_offset _ = unimplemented "MLWorks.Internal.Value.Frame.frame_offset"
                fun frame_double _ = unimplemented "MLWorks.Internal.Value.Frame.frame_double"
                fun frame_allocations _ = (unimplemented "MLWorks.Internal.Value.Frame.frame_allocations"; false)
                fun is_ml_frame _ = (unimplemented "MLWorks.Internal.Value.Frame.is_ml_frame"; false)
                fun sub _ = unimplemented "MLWorks.Internal.Value.Frame.sub"
                fun update _ = unimplemented "MLWorks.Internal.Value.Frame.update"
                fun current _ = unimplemented "MLWorks.Internal.Value.Frame.current"
              end
          end

        structure Trace =
          struct
            exception Trace of string
            fun intercept _ = unimplemented "MLWorks.Internal.Trace.intercept"
            fun replace _ = unimplemented "MLWorks.Internal.Trace.replace"
            fun restore _ = unimplemented "MLWorks.Internal.Trace.restore"
	    fun restore_all _ = unimplemented "MLWorks.Internal.Trace.restore_all"
            datatype status = INTERCEPT | NONE | REPLACE | UNTRACEABLE
            fun status _ = (unimplemented "MLWorks.Internal.Trace.status"; NONE)
          end

        structure Dynamic =
          struct
            type dynamic = int ref * int ref
            type type_rep = int ref
            exception Coerce of type_rep * type_rep

            val generalises_ref : (type_rep * type_rep -> bool) ref =
		ref (fn _ => false)

	    local
		fun generalises data = (!generalises_ref) data

		val get_type = Value.cast (fn (a,b) => b)
		val get_value = Value.cast (fn (a,b) => a)
	    in
            fun coerce (d,t) =
                if generalises (get_type d,t) then
		    get_value d
                else
		    raise Coerce(get_type d,t)
	    end
          end

	structure Exit =
	  struct
	    local
		structure P = SMLBasisOSProcess
		structure W = SMLBasisWord32
	    in
	    type key = int
	    type status = W.word
            val success = W.fromInt P.success
            val failure = W.fromInt P.failure
            val uncaughtIOException = W.fromInt 2
            val badUsage = W.fromInt 3
            val stop = W.fromInt 4
            val save = W.fromInt 5
            val badInput = W.fromInt 6
            fun atExit f = (P.atExit f; 0)
            fun removeAtExit key = unimplemented "removeAtExit"
            fun exit w = (TextIO.print "D: exit called\n"; Unsafe.cast w)
            fun terminate w = P.terminate (W.toIntX w)
	    end
          end

	structure Debugger =
	  struct
	    local
		fun f (s:string) = (unimplemented "break_hook"; ())
	    in
	    val break_hook = ref f
	    fun break s = unimplemented "break"
	    end
	  end

        structure FileIO =
          struct
            datatype offset = BEG | CUR | END

            fun flush stream = BinIO.flushOut stream

            fun openf s = BinIO.openOut

	    (* to close:
	       - flush our buffer,
	       - do an fsync,
	       - close the file.
	       The fsync is required to avoid MLWorks bug 561, q.v.
	       The fsync is very ugly. Nick Haines 14-Mar-94 *)

            fun closef s = BinIO.closeOut

            fun seekf (stream, i, p) =
		(unimplemented "seekf"; ())

            fun writebf (stream, bytearray, start, length) =
		let val aslice = Word8ArraySlice.slice (bytearray, start,
							SOME(length))
		in
		    BinIO.output (stream, Word8ArraySlice.vector (aslice))
		end

	    fun write_byte (stream, byte) = BinIO.output1 (stream, byte)

            fun writef (stream, s:string) =
		let fun write1 (c:char) =
			let val byte = Word8.fromInt(ord c)
			in write_byte (stream, byte)
			end
		    val sz = size s
		    fun loop (i) =
			if i = sz then ()
			else (write1 (String.sub (s, i)); loop (1 + i))
		in
		    loop (0)
		end

          end

        structure Runtime =
	  struct
            exception Unbound of string
            fun environment name =
		Unsafe.cast (nj_environment name) (* Defined in nj_env.sml *)

            val modules = ref ([] : (string * Value.T * Value.T) list)

            structure Loader =
              struct
                exception Load of string
                fun load_module name =
		    (unimplemented "MLWorks.Internal.Runtime.Loader.load_module"; (name, ()))

		fun load_wordset _ =
		    (unimplemented "MLWorks.Internal.Runtime.Loader.load_wordset"; [])
              end

	    structure Memory =
	      struct
		val gc_message_level = ref 0
		val max_stack_blocks = ref 0
                fun collect _ = unimplemented "MLWorks.Internal.Runtime.Memory.collect"
                fun collect_all _ = unimplemented "MLWorks.Internal.Runtime.Memory.collect_all"
                fun promote_all _ = unimplemented "MLWorks.Internal.Runtime.Memory.promote_all"
                fun collections _ =
		    (unimplemented "MLWorks.Internal.Runtime.Memory.collections"; (0,0))
	      end

            structure Event =
              struct
                datatype T = SIGNAL of int
                exception Signal of string
                fun signal _ = unimplemented "MLWorks.Internal.Runtime.Event.signal"
		fun stack_overflow_handler _ = unimplemented "MLWorks.Internal.Runtime.Event.stack_overflow_handler"
		fun interrupt_handler _ = unimplemented "MLWorks.Internal.Runtime.Event.interrput_handler"

              end

          end
	end
      end

    structure Profile =
      struct
	type manner = int
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
		 | TOTAL		(* used when specifying a profiling manner *)

	datatype large_size =
		 Large_Size of
		 {megabytes : int,
		  bytes : int}

	datatype object_count =
		 Object_Count of
		 {number : int,
		  size : large_size,
		  overhead : int}

	type object_breakdown = (object_kind * object_count) list

	datatype function_space_profile =
		 Function_Space_Profile of
		 {allocated : large_size,
		  copied : large_size,
		  copies : large_size list,
		  allocation : object_breakdown list}

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

	datatype options = Options of { scan : int,
					selector : function_id -> manner}

	datatype 'a result =
		 Result of 'a
		 | Exception of exn

	exception ProfileError of string

	fun profile (Options {scan, selector}) f a =
	    (unimplemented "MLWorks.Profile.profile";
	     Unsafe.cast 0)

	fun make_manner {time, space, copies, calls, depth, breakdown} =
	    (unimplemented "MLWorks.Profile.make_manner";
	     Unsafe.cast 0)

      end

  end
end;

local
    structure MLWorksGeneral =
      struct
	open General
	val op <> = op <>
      end
in
structure General = MLWorksGeneral
end
