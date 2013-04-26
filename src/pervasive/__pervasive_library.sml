(*  ==== PERVASIVE LIBRARY ====
 *
 *  Copyright (C) 1991 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is the file that is implicitly loaded before any of the other files
 *  are compiled.
 *
 *  Revision Log
 *  ------------
 *  $Log: __pervasive_library.sml,v $
 *  Revision 1.228  1999/05/12 17:30:39  daveb
 *  [Bug #190553]
 *  Moved exit statuses to mlworks_exit.sml.
 *
 * Revision 1.227  1999/03/11  17:13:38  daveb
 * [Bug #190523]
 * Changed the underlying type of OS.Process.status.
 *
 * Revision 1.226  1998/07/07  10:17:13  jont
 * [Bug #20122]
 * Move pervasive signatures into __pervasive_library.sml
 *
 * Revision 1.225  1998/05/26  13:56:24  mitchell
 * [Bug #30413]
 * Move Exit structure to pervasives
 *
 * Revision 1.224  1998/03/26  17:12:16  jont
 * [Bug #30090]
 * Remove MLWorks.IO and RawIO
 *
 * Revision 1.223  1998/03/26  14:12:31  jont
 * [Bug #30090]
 * Remove almost all of MLWorks.IO
 *
 * Revision 1.222  1998/03/11  14:24:47  mitchell
 * [Bug #70076]
 * Fix exnName so it only returns name of exception, not location info
 *
 * Revision 1.221  1998/02/18  13:21:23  mitchell
 * [Bug #30349]
 * Warn when lhs of semicolon does not have type unit
 *
 * Revision 1.220  1998/02/10  15:31:47  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.219  1997/11/26  15:45:02  johnh
 * [Bug #30134]
 * Change meaning of third arg of deliver and convert to datatype.
 *
 * Revision 1.218  1997/11/09  19:12:49  jont
 * [Bug #30089]
 * Further work on getting rid of MLWorks.Time
 * Also removing {set_,}file_modified
 *
 * Revision 1.217  1997/10/08  17:51:20  jont
 * [Bug #30204]
 * Add update_exn and update_exn_cons
 *
 * Revision 1.216  1997/10/07  14:52:54  johnh
 * [Bug #30226]
 * Add exitFn for storing the function to call when the exe exits normally.
 *
 * Revision 1.215  1997/09/17  15:19:51  brucem
 * [Bug #30268]
 * Clear delivery hooks before delivering.
 *
 * Revision 1.214  1997/08/04  11:01:01  brucem
 * [Bug #30084]
 * Remove option related stuff from structure General.
 * Add datatype MLWorks.Internal.Types.option.
 * Set top-level datatype option to be MLWorks.Internal.Types.option.
 * Add basic option functions to top level.
 * This is for adding the Option structure to the Basis.
 *
 * Revision 1.213  1997/06/17  13:51:31  andreww
 * [Bug #20014]
 * adding MLWorks.name to return the name of the invoking program.
 *
 * Revision 1.212  1997/06/12  11:59:32  matthew
 * [Bug #30101]
 *
 * Using builitin cos & sin
 *
 * Revision 1.211  1997/06/12  10:12:49  matthew
 * Adding print_error to StandardIO
 *
 * Revision 1.210  1997/05/28  21:09:15  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.209  1997/05/09  13:39:52  jont
 * [Bug #30091]
 * Remove MLWorks.Internal.FileIO and related stuff
 *
 * Revision 1.208  1997/05/01  11:49:09  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.207  1997/03/25  11:58:36  andreww
 * [Bug #1989]
 * removing Internal.Value.exn_name_string.
 *
 * Revision 1.206  1997/03/21  15:46:05  andreww
 * [Bug #1968]
 * Altering runtime calls to fetch the values of stdin, stdout and stderr.
 *
 * Revision 1.205  1997/03/18  11:19:28  andreww
 * [Bug #1431]
 * Adding Basis Io exception to MLWorks.Internal.IO so that it
 * can be handled by General.exnMessage neatly.
 *
 * Revision 1.203  1997/03/03  11:13:15  matthew
 * Adding unsafe floatarray operations to Internal.Value
 *
 * Revision 1.202  1997/02/07  11:59:53  andreww
 * [Bug #1911]
 * #put(#output(TerminalIO)) ought to write to stdOut, not stdErr.
 *
 * Revision 1.201  1997/01/27  11:07:12  andreww
 * [Bug #1891]
 * Adding new primitives to enter and exit critical sections in pre-empting
 * threads.
 *
 * Revision 1.200  1997/01/21  15:27:58  andreww
 * [Bug #1896]
 * altering MLWorks.Threads.result to cope with new threads state
 * THREADS_KILLED_SLEEPING.
 *
 * Revision 1.199  1997/01/07  12:46:48  andreww
 * [Bug #1818]
 * Adding new FloatArray primitives.
 *
 * Revision 1.198  1996/12/18  12:19:23  matthew
 * Adding real equality builtin to MLWorks.Internal.Value.
 *
 * Revision 1.197  1996/11/18  14:10:04  jont
 * [bug 1775]
 * Handle all exceptions caused by the profile select function
 *
 * Revision 1.196  1996/11/01  17:07:36  io
 * [Bug #1614]
 * Removing toplevel String structure.
 *
 * Revision 1.195  1996/10/21  16:48:56  andreww
 * [Bug #1682]
 * removing General structure from MLWorks structure.
 *
 * Revision 1.194  1996/10/21  11:28:20  andreww
 * [Bug #1655]
 * Correcting definition of MLWorks.Threads.Internal.children
 * ,
 *
 * Revision 1.193  1996/10/21  10:31:41  andreww
 * [Bug #1666]
 * Hooking runtime exception Threads into pervasive library.
 *
 * Revision 1.192  1996/10/03  15:46:53  io
 * [Bug #1630]
 * fix substring
 *
 * Revision 1.191  1996/09/18  15:12:05  io
 * [Bug #1490]
 * update toplevel String.maxSize
 *
 * Revision 1.190  1996/09/02  15:38:12  jont
 * [Bug #1574]
 * Ensure Vector.vector visible at top level to override the builtin library version
 *
 * Revision 1.189  1996/08/21  12:33:08  stephenb
 * [Bug #1554]
 * Introduce MLWorks.Internal.IO as a repository for file_desc
 * and the read, write, seek, ... etc. stuff.
 *
 * Revision 1.188  1996/08/09  14:19:33  daveb
 * [Bug #1534]
 * before is now infix.
 *
 * Revision 1.187  1996/07/16  15:41:54  andreww
 * Expanding the contents of the StandardIO buffers.
 *
 * Revision 1.186  1996/07/10  09:34:40  andreww
 * Expanding the top level environment to meet the revised basis specification.
 *
 * Revision 1.185  1996/07/03  09:46:06  andreww
 * adding GuiStandardIO structure to pervasives.
 *
 * Revision 1.184  1996/06/19  13:42:27  nickb
 * Extend datatype MLWorks.Internal.Trace.status.
 *
 * Revision 1.183  1996/06/04  14:21:35  io
 * add exception Size
 *
 * Revision 1.182  1996/05/30  11:50:26  daveb
 * Revising top level for revised basis.
 *
 * Revision 1.181  1996/05/29  12:33:56  matthew
 * Fixing problem with SysErr
 *
 * Revision 1.180  1996/05/28  12:21:57  matthew
 * Improving MLWorks.ml_string function
 *
 * Revision 1.179  1996/05/28  10:21:26  daveb
 * Removed RawIO.outstream parameter in Internal.Value.print.
 *
 * Revision 1.178  1996/05/22  13:20:11  matthew
 * Changing type of real_to_string
 *
 * Revision 1.177  1996/05/21  12:02:30  matthew
 * Changing type of word32 shift operations
 *
 * Revision 1.176  1996/05/17  10:05:09  matthew
 * Moving Bits to Internal
 *
 * Revision 1.175  1996/05/16  13:18:10  stephenb
 * MLWorks.Debugger: moved to MLWorks.Internal.Debugger
 * MLWorks.OS.arguments: moved MLWorks.arguments & removed MLWorks.OS
 *
 * Revision 1.174  1996/05/07  10:25:11  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.173  1996/05/03  12:37:49  nickb
 * Add image delivery hooks.
 *
 * Revision 1.172  1996/04/30  17:40:34  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.171  1996/04/29  13:53:30  matthew
 * Removing Real structure
 *
 * Revision 1.170  1996/04/29  11:06:52  jont
 * Modifications to deliver and save
 *
 * Revision 1.169  1996/04/19  16:11:59  stephenb
 * Put MLWorks.exit back to enable boostrapping from older compilers.
 *
 * Revision 1.168  1996/04/19  10:48:44  matthew
 * Removing some exceptions
 *
 * Revision 1.167  1996/04/17  11:02:21  stephenb
 * Remove exit, terminate, atExit and most of the OS structure since
 * they are no longer needed now that OS.Process has been updated.
 *
 * Revision 1.166  1996/03/20  11:57:15  matthew
 * Changes for value polymorphism
 *
 * Revision 1.165  1996/03/08  11:43:08  daveb
 * Changed MLWorks.Internal.Dynamic types to new identifier convention.
 *
 * Revision 1.164  1996/02/22  13:27:22  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.163  1996/02/16  15:00:34  nickb
 * "fn_save" becomes "deliver".
 *
 *  Revision 1.162  1996/02/09  15:46:02  jont
 *  Add Overflow at top level
 *
 *  Revision 1.161  1996/01/22  13:53:28  matthew
 *  Simplifying treatment of pervasive exceptions
 *
 *  Revision 1.160  1996/01/17  16:06:24  stephenb
 *  OS reorganisation: remove the Unix and NT code as it is going elsewhere.
 *
 *  Revision 1.159  1996/01/16  12:14:05  nickb
 *  Change to GC interface.
 *
 *  Revision 1.158  1996/01/15  16:18:01  matthew
 *  Adding NT directory operations
 *
 *  Revision 1.157  1996/01/15  11:48:33  nickb
 *  Add thread sleep and wake operations.
 *
 *  Revision 1.156  1996/01/12  10:34:02  stephenb
 *  Add FullPervasiveLibrary_.MLWorks.Threads.Internal.reset_signal_status.
 *
 *  Revision 1.155  1996/01/08  14:11:11  nickb
 *  Remove signal reservation.
 *
 *  Revision 1.154  1995/12/04  15:56:42  daveb
 *  pervasive module names now begin with a space.
 *
 *  Revision 1.153  1995/11/21  11:23:03  jont
 *  Add Frame.frame_double for accessing directly spilled reals
 *
 *  Revision 1.152  1995/10/17  12:52:49  jont
 *  Add exec_save for saving executables
 *
 *  Revision 1.151  1995/09/20  11:53:41  matthew
 *  Lifting call to call_c in substring
 *
 *  Revision 1.150  1995/09/13  14:24:25  jont
 *  Add function save to MLWorks for use by exportFn
 *
 *  Revision 1.149  1995/09/12  15:08:50  daveb
 *  Added types for different sizes of words and integers.
 *
 *  Revision 1.147  1995/07/28  14:03:11  jont
 *  Remove div and mod from FullPervasiveLibrary signature
 *
 *  Revision 1.146  1995/07/27  12:14:29  jont
 *  Add makestring to word signature and structure
 *
 *  Revision 1.145  1995/07/24  14:24:58  jont
 *  Add Words signature and structure
 *
 *  Revision 1.144  1995/07/20  16:59:25  jont
 *  Add exception Overflow
 *
 *  Revision 1.143  1995/07/19  15:21:55  nickb
 *  Two constructors called MLWorks.Profile.Profile.
 *
 *  Revision 1.142  1995/07/19  13:52:44  nickb
 *  Whoops; major type screwups in new profiler.
 *
 *  Revision 1.141  1995/07/17  16:27:27  nickb
 *  Change to profiler interface.
 *
 *  Revision 1.140  1995/07/17  12:19:18  jont
 *  Add hex integer printing facilities
 *
 *  Revision 1.139  1995/07/14  10:22:45  jont
 *  Add Char structure
 *
 *  Revision 1.138  1995/06/02  13:58:48  nickb
 *  Change threads restart system.
 *
 *  Revision 1.137  1995/05/26  15:59:40  matthew
 *  Adding ML definition of implode_char
 *  Moving definition of append etc to builtin_library
 *
 *  Revision 1.136  1995/05/23  17:24:18  daveb
 *  Added ML version of substring.
 *
 *  Revision 1.135  1995/05/22  15:53:18  nickb
 *  Add threads interface
 *
 *  Revision 1.134  1995/05/19  09:18:49  matthew
 *  Adding flush to with_standard_output
 *  Adding explode function
 *
 *  Revision 1.133  1995/05/10  17:53:30  daveb
 *  Changed argument of Unix exception from int to string.
 *  Added OS.Unix.{stat,seek,set_block_mode,can_input}.
 *
 *  Revision 1.132  1995/05/02  13:12:17  matthew
 *  Adding CAST and UMAP primitives
 *  Adding new append function
 *  Removing stuff from debugger structure
 *
 *  Revision 1.131  1995/04/19  13:55:36  matthew
 *  Speed improvements to input_line: don't call end_of_stream each time
 *
 *  Revision 1.130  1995/04/13  16:51:43  jont
 *  Change atExit to define a list of functions to be executed
 *
 *  Revision 1.129  1995/04/13  14:07:20  jont
 *  Add terminate, atExit functions
 *
 *  Revision 1.128  1995/03/20  10:44:43  matthew
 *  Adding implode_char function
 *
 *  Revision 1.127  1995/03/01  11:44:25  matthew
 *  Unifying Value.Frame and Frame.pointer
 *
 *  Revision 1.126  1995/01/12  15:23:47  jont
 *  Add Win_nt.get_current_directory
 *  Add Win_nt.get_path_name
 *
 *  Revision 1.125  1994/12/09  14:37:33  jont
 *  Add OS.Win_nt structure
 *
 *  Revision 1.124  1994/11/24  14:32:38  matthew
 *  Added new "unsafe" pervasives
 *
 *  Revision 1.123  1994/09/27  16:04:14  matthew
 *  Added pervasive Option structure
 *
 *  Revision 1.122  1994/08/24  16:33:21  matthew
 *  Added unsafe array operations
 *
 *  Revision 1.121  1994/07/08  10:12:32  nickh
 *  Add event functions for stack overflow and interrupt handlers.
 *
 *  Revision 1.120  1994/06/29  15:16:51  nickh
 *  Add MLWorks messages stream.
 *
 *  Revision 1.119  1994/06/22  15:28:03  nickh
 *  Add Trace.restore_all.
 *
 *  Revision 1.118  1994/06/09  15:37:15  nickh
 *  Updated runtime signal handling.
 *
 *  Revision 1.117  1994/06/06  11:44:30  nosa
 *  Breakpoint settings on function exits.
 *
 *  Revision 1.116  1994/03/30  15:03:48  daveb
 *  Revised MLWorks.IO.set_modified_file to tae a datatype.
 *
 *  Revision 1.115  1994/03/30  13:55:31  daveb
 *  Removed input_string and output_string.
 *
 *  Revision 1.114  1994/03/30  13:23:12  daveb
 *  Added MLWorks.IO.set_file_modified.
 *
 *  Revision 1.113  1994/03/23  12:39:10  nickh
 *  New profiler, with a new interface.
 *
 *  Revision 1.112  1994/02/23  17:04:29  nosa
 *  Step and breakpoints Debugger.
 *
 *  Revision 1.111  1994/02/17  17:54:04  matthew
 *  Changed close_* on std_* streams to raise an Io exception.
 *
 *  Revision 1.110  1994/02/08  14:38:55  matthew
 *  Added realpath function
 *
 *  Revision 1.109  1994/02/08  10:45:18  nickh
 *  Added MLWorks.String.ml_string : (string * int) -> string
 *
 *  Revision 1.108  1994/01/10  14:16:50  matthew
 *  Added call to C for MLWorks.Internal.Runtime.Loader.load_module
 *
 *  Revision 1.107  1993/12/20  13:12:14  matthew
 *   Fixed problems with inexhaustive bindings
 *
 *  Revision 1.106  1993/11/18  11:20:22  nickh
 *  Add to IO and RawIO to provide closed_in and closed_out functions, which
 *  test a stream for closed-ness.
 *
 *  Revision 1.105  1993/11/17  12:30:11  nickh
 *  New time structure, to allow real intervals to be measured, to allow the
 *  user to convert to/from reals, and to optimise the "measure the user/
 *  system/gc/clock time taken by this" path.
 *
 *  Revision 1.104  1993/08/27  19:13:59  daveb
 *  Added MLworks.OS.Unix.{unlink,rmdir,mkdir}.
 *
 *  Revision 1.103  1993/08/26  11:13:00  richard
 *  Removed the X exception.  It's now in the Motif interface code.
 *
 *  Revision 1.102  1993/08/25  14:01:50  richard
 *  Added MLWorks.OS.Unix.kill.
 *
 *  Revision 1.101  1993/08/18  12:52:40  daveb
 *  Added X exception.
 *
 *  Revision 1.100  1993/07/23  11:07:49  richard
 *  Added system calls to read directories and the password file.
 *
 *  Revision 1.99  1993/07/19  13:55:02  nosa
 *  added two debugger functions
 *
 *  Revision 1.98  1993/06/09  16:10:12  matthew
 *  Added text_preprocess hook
 *
 *  Revision 1.97  1993/05/05  17:25:23  jont
 *  Added MLWorks.OS.Unix.password_file to get the association list of user
 *  names to home directories necessary for translating ~
 *
 *  Revision 1.96  1993/04/29  11:33:44  richard
 *  Corrected the call to the profiler.
 *
 *  Revision 1.95  1993/04/23  15:49:58  jont
 *  Added Integer and Real substructures of MLWorks with makestring and
 *  print functions
 *
 *  Revision 1.94  1993/04/21  15:58:24  richard
 *  Removed defunct Editor interface and added sytem calls to enable
 *  its replacement.
 *
 *  Revision 1.93  1993/04/20  13:52:21  richard
 *  Added more Unix system call interfaces.
 *  New Trace structure to go with runtime implementation.
 *  Removed commented out array functions.  (They're in RCS anyway.)
 *
 *  Revision 1.92  1993/04/13  09:53:27  matthew
 *  Moved dynamic stuff from MLWorks.Internal.Typerep to MLWorks.Dynamic
 *  Moved break stuff from MLWorks.Internal.Tracing to MLWorks.Debugger
 *
 *  Revision 1.91  1993/04/08  17:39:38  jont
 *  Minor modifications to editor structure
 *
 *  Revision 1.90  1993/04/02  14:51:00  jont
 *  Extended images structure to include table of contents reading
 *
 *  Revision 1.89  1993/03/26  15:51:39  matthew
 *  Added break function to Tracing substructure
 *
 *  Revision 1.88  1993/03/23  18:38:53  jont
 *  Added vector primitives. Changed editor implementastion slightly.
 *
 *  Revision 1.87  1993/03/18  13:44:54  jont
 *  Rewrote a number of array functions to avoid recalculating numbers like
 *  n-1 and l-n
 *
 *  Revision 1.86  1993/03/11  18:38:01  jont
 *  Added Intermal.Images including save and clean. Added other_operation
 *  to Editor for arbitrary bits of emacs lisp
 *
 *  Revision 1.85  1993/03/11  17:29:12  jont
 *  Added Editor substructure to MLWorks
 *
 *  Revision 1.84  1993/03/05  12:41:53  jont
 *  Added builtin string relationals
 *
 *  Revision 1.83  1993/03/01  12:25:53  matthew
 *  Use builtin array, bytearray and vector types
 *
 *  Revision 1.82  1993/02/26  11:13:42  nosa
 *  Implemented a multi-level profiler
 *
 *  Revision 1.81  1993/02/25  16:08:56  matthew
 *  Used builtin array type.  Removed Array.T from signature
 *
 *  Revision 1.80  1993/02/19  18:26:58  matthew
 *  Reimplemented modifiable streams
 *  Added TypeRep substructure for use with Dynamic objects.
 *
 *  Revision 1.79  1993/01/05  17:06:40  richard
 *  Added extra exceptions to those passed to the runtime system.
 *
 *  Revision 1.78  1992/12/22  12:45:32  jont
 *  Removed references to MLWorks.Vector. Removed ExtendedArray from top level
 *
 *  Revision 1.77  1992/12/22  12:15:36  jont
 *  Removed pervasive vector
 *
 *  Revision 1.76  1992/12/21  12:19:14  daveb
 *  Added support for the 'agreed' Array and Vector structures.
 *  Renamed the old Array to ExtendedArray.
 *
 *  Revision 1.75  1992/12/18  14:04:17  clive
 *  Made the profiler take the generalised streams
 *
 *  Revision 1.74  1992/12/03  18:19:09  jont
 *  Modified FileIO to be in terms of RawIO, in order to avoid type errors
 *  occurring at runtime!
 *
 *  Revision 1.73  1992/12/01  12:13:45  matthew
 *  Fixed small bug with std_err in IO.
 *
 *  Revision 1.72  1992/11/30  18:51:54  matthew
 *  Tidied up IO signature
 *
 *  Revision 1.71  1992/11/30  18:27:43  matthew
 *  Added representation of streams as records.  Old IO is now RawIO.
 *
 *  Revision 1.70  1992/11/12  17:21:19  clive
 *  Added tracing hooks to the runtime system
 *
 *  Revision 1.69  1992/11/10  13:22:27  richard
 *  Added StorageManager exception and changed the type of the
 *  StorageManager interface function.
 *
 *  Revision 1.68  1992/10/29  13:18:10  richard
 *  Removed debugger structure and added time and event structures.
 *
 *  Revision 1.67  1992/10/15  07:27:56  richard
 *  The FullPervasiveLibrary_ structure is now opened so that merely
 *  requiring this file gets you the pervasive environment.
 *
 *  Revision 1.66  1992/10/06  17:20:49  clive
 *  call_debugger now takes the debugger function as well as the exception
 *
 *  Revision 1.65  1992/09/25  16:48:59  matthew
 *  Added string_to_real
 *
 *  Revision 1.64  1992/09/23  16:13:15  daveb
 *  Added clear_eof function to IO.
 *
 *  Revision 1.63  1992/09/04  12:36:58  richard
 *  Corrected the calls to C for some exceptions.
 *  Contrained ARRAY and BITS.
 *
 *  Revision 1.62  1992/08/28  15:18:47  clive
 *  Added a function to get the debug_info from a code string
 *
 *  Revision 1.61  1992/08/27  15:42:56  richard
 *  Added extra floating point exceptions.
 *
 *  Revision 1.60  1992/08/27  10:59:18  richard
 *  Corrected some mistakes.
 *
 *  Revision 1.59  1992/08/26  15:44:58  richard
 *  Rationalisation of the MLWorks structure.
 *
 *  Revision 1.58  1992/08/25  08:10:03  richard
 *  Added ByteArrays and writebf in FileIO.  Bits structure is now
 *  duplicated at top level.
 *
 *  Revision 1.57  1992/08/20  12:24:42  richard
 *  Added extra unsafe value utilities.
 *  Enriched the Array structure using unsafe sub and update operations.
 *
 *  Revision 1.56  1992/08/18  15:44:45  richard
 *  Added Value structure with utilities for dealing with
 *  opaque values and casting.  Removed duplicate functions
 *  elsewhere.
 *  Added output and input functions to deal with more types
 *  than strings.
 *
 *  Revision 1.55  1992/08/17  13:29:35  jont
 *  Added inline ordof
 *
 *  Revision 1.54  1992/08/17  10:58:46  richard
 *  Added MLWorks.System.Runtime.GC.interface.
 *
 *  Revision 1.53  1992/08/15  17:31:47  davidt
 *  Added temporary implementation of MLWorks.IO.input_line
 *
 *  Revision 1.52  1992/08/14  11:16:51  jont
 *  Fixed parameters within ordof
 *
 *  Revision 1.51  1992/08/14  11:05:42  davidt
 *  Moved definition of ord, so that it picks up the integer
 *  comparison operations instead of the string ones.
 *
 *  Revision 1.50  1992/08/13  11:40:57  clive
 *  Added a function to get header information from an ml_object
 *
 *  Revision 1.49  1992/08/11  15:34:29  clive
 *  Work on tracing
 *
 *  Revision 1.48  1992/08/10  15:28:44  davidt
 *  Changed MLworks to MLWorks.
 *
 *  Revision 1.47  1992/08/10  15:27:12  richard
 *  Added load_wordset to interpreter structure.
 *
 *  Revision 1.46  1992/08/10  12:20:12  davidt
 *  Major reorganisation so that we have a MLworks structure, with more
 *  sensibly organised sub-structures.
 *
 *  Revision 1.44  1992/08/05  09:05:39  richard
 *  Added missing binding of runtime exception Prod.
 *
 *  Revision 1.43  1992/07/31  16:03:11  clive
 *  Added debugger.call_function
 *
 *  Revision 1.42  1992/07/29  14:19:39  clive
 *  Cahnges to call_debugger and install_debugger
 *
 *  Revision 1.41  1992/07/28  13:12:03  richard
 *  rather than numeric codes.
 *  Rewrote everything to communicate with C using the runtime environment
 *  rather than numeric codes.
 *  Added a System.Runtime structure.  More to come later.
 *
 *  Revision 1.40  1992/07/22  16:43:34  clive
 *  Added profile,save - hack version of weakarrays
 *
 *  Revision 1.39  1992/07/16  15:40:26  clive
 *  Changed the debugger to return a datatype for its desired result action
 *
 *  Revision 1.38  1992/07/14  09:27:53  clive
 *  get_next_frame now additionally returns the PC offset into the code string
 *
 *  Revision 1.37  1992/07/09  14:48:00  clive
 *  Changed the call_debugger function
 *
 *  Revision 1.36  1992/07/07  16:20:06  clive
 *  Added a manual call of the debugger for the interpreter
 *
 *  Revision 1.35  1992/06/25  14:48:03  jont
 *  Changed MLObject to be the same as ml_value used by the interpreter
 *
 *  Revision 1.34  1992/06/24  09:35:34  clive
 *  Added breakpointing functions
 *
 *  Revision 1.33  1992/06/22  16:25:49  clive
 *  Changes for the debugger
 *
 *  Revision 1.32  1992/06/19  16:43:45  jont
 *  Added ML_REQUIRE builtin for interpreter
 *  Rearranged System to include the unsafe interpreter stuff (was in NJ)
 *
 *  Revision 1.31  1992/06/18  16:22:57  jont
 *  Added new builtin ml_value_from_offset for getting pointers into
 *  middles of code vectors for letrecs
 *
 *  Revision 1.30  1992/06/15  17:05:12  jont
 *  Added extra functions load_var, load_exn, load_struct, load_funct for
 *  interpreter in structure Int inside Unsafe
 *
 *  Revision 1.29  1992/06/11  10:48:06  clive
 *  Added the debugger structure of debugger utilities
 *
 *  Revision 1.28  1992/05/20  10:24:17  clive
 *  Added Bits.arshift - arithmetic right shift
 *
 *  Revision 1.27  1992/05/18  11:54:37  clive
 *  Added timers and code for compiling the make system
 *
 *  Revision 1.26  1992/05/13  12:51:00  clive
 *  Added the Bits structure
 *
 *  Revision 1.25  1992/05/11  09:47:07  jont
 *  Changed pervasive arrayoflist to allow nil arguments
 *
 *  Revision 1.24  1992/04/28  10:12:55  clive
 *  Added NewJersey.Bits.andb so that we can still compile everything with
 *  our compiler
 *
 *  Revision 1.23  1992/04/24  15:45:26  jont
 *  Added exn_name to system structure
 *
 *  Revision 1.22  1992/03/12  16:00:56  richard
 *  Altered file operations and added lookahead function.
 *
 *  Revision 1.21  1992/03/10  12:55:28  clive
 *  Re-did Io to use fprintf etc
 *
 *  Revision 1.20  1992/02/25  14:53:38  clive
 *  Added val_print in the System structure in ML
 *
 *  Revision 1.19  1992/02/24  18:15:06  clive
 *  Took out div definition as it now calls c
 *
 *  Revision 1.18  1992/02/24  16:56:46  clive
 *  end_of_stream defined
 *
 *  Revision 1.17  1992/02/24  13:42:13  clive
 *  Added definition of div for positive arguments
 *
 *  Revision 1.16  1992/02/18  17:58:25  jont
 *  Added New Jersey structure
 *
 *  Revision 1.15  1992/02/12  09:29:47  clive
 *  New pervasive library setup
 *
 *  Revision 1.14  1992/02/03  20:12:33  jont
 *  Added most of the array functions, though with bogus implementations
 *
 *  Revision 1.13  1992/02/03  17:34:52  clive
 *  added the array structure itself
 *
 *  Revision 1.12  1992/01/23  10:12:43  richard
 *  Changed unimplemented pervasives to raise Io instead of Interrupt so
 *  we can tell which one causes a run to fail.
 *
 *  Revision 1.11  1992/01/21  15:59:18  richard
 *  Removed explicit numbering of C routines and replaced by members of the
 *  automatically generated structure CallCCodes_.
 *  Commented out arrayoflist and tabulate until they can be implemented
 *  without depending on themselves.
 *
 *  Revision 1.10  1992/01/21  10:56:50  clive
 *  Spelling mistake in tabulate
 *
 *  Revision 1.9  1992/01/17  11:34:40  clive
 *  array_of_list should have been arrayoflist
 *
 *  Revision 1.8  1992/01/16  17:43:28  clive
 *  Added array code
 *
 *  Revision 1.7  1992/01/13  11:29:13  richard
 *  Added substring as a temporary measure until we bootstrap the compiler.
 *
 *  Revision 1.6  1991/12/20  09:53:51  richard
 *  Implemented the real arithmetic functions.
 *
 *  Revision 1.5  91/12/16  13:12:54  richard
 *  Added error handling to input and output, plus calls to C for various
 *  other functions.
 *
 *  Revision 1.4  91/12/10  13:57:08  richard
 *  Added equal and not_equal.
 *
 *  Revision 1.3  91/12/09  15:46:20  richard
 *  Added a signature constraint so that common sub-functions can be
 *  added freely to the structure.  Wrote file input and output pervasives.
 *
 *  Revision 1.2  91/12/04  16:00:40  jont
 *  Optimised the builtin entirely ml functions
 *
 *  Revision 1.1  91/11/28  17:06:21  richard
 *  Initial revision
 *)

require " __builtin_library";

signature ARRAY =
  sig
    eqtype 'a array
    exception Size
    exception Subscript
    val array: int * '_a -> '_a array
    val arrayoflist: '_a list -> '_a array
    val tabulate: int * (int -> '_a) -> '_a array
    val sub: 'a array * int -> 'a
    val update: 'a array * int * 'a -> unit
    val length: 'a array -> int
  end

signature EXTENDED_ARRAY =
  sig
    (* include "ARRAY" -- omitted to keep SML/NJ happy. *)
    eqtype 'a array
    exception Size
    exception Subscript
    exception Find

    val array		: int * '_a -> '_a array
    val length		: 'a array -> int
    val update		: 'a array * int * 'a -> unit
    val sub		: 'a array * int -> 'a
    val arrayoflist	: '_a list -> '_a array
    val tabulate	: int * (int -> '_a) -> '_a array

    val from_list	: '_a list -> '_a array
    val to_list		: 'a array -> 'a list
    val fill		: 'a array * 'a -> unit
    val map		: ('a -> '_b) -> 'a array -> '_b array
    val map_index	: (int * 'a -> '_b) -> 'a array -> '_b array
    val iterate		: ('a -> unit) -> 'a array -> unit
    val iterate_index	: (int * 'a -> unit) -> 'a array -> unit
    val rev		: '_a array -> '_a array
    val duplicate	: '_a array -> '_a array
    val subarray	: '_a array * int * int -> '_a array
    val append		: '_a array * '_a array -> '_a array
    val reducel		: ('a * 'b -> 'a) -> ('a * 'b array) -> 'a
    val reducer		: ('a * 'b -> 'b) -> ('a array * 'b) -> 'b
    val reducel_index	: (int * 'a * 'b -> 'a) -> ('a * 'b array) -> 'a
    val reducer_index	: (int * 'a * 'b -> 'b) -> ('a array * 'b) -> 'b
    val copy		: 'a array * int * int * 'a array * int -> unit
    val fill_range	: 'a array * int * int * 'a -> unit
    val find		: ('a -> bool) -> 'a array -> int
    val find_default	: (('a -> bool) * int) -> 'a array -> int
    val maxLen          : int
  end;

signature VECTOR =
  sig
    eqtype 'a vector
    exception Size
    exception Subscript
    val vector: 'a list -> 'a vector
    val tabulate: int * (int -> 'a) -> 'a vector
    val sub: 'a vector * int -> 'a
    val length: 'a vector -> int
    val maxLen : int
  end

signature BYTEARRAY =
  sig
    eqtype bytearray

    exception Range of int
    exception Size
    exception Subscript
    exception Substring
    exception Find

    val array		: int * int -> bytearray
    val length		: bytearray -> int
    val update		: bytearray * int * int -> unit
    val sub		: bytearray * int -> int
    val arrayoflist	: int list -> bytearray

    val tabulate	: int * (int -> int) -> bytearray
    val from_list	: int list -> bytearray
    val to_list		: bytearray -> int list
    val from_string	: string -> bytearray
    val to_string	: bytearray -> string
    val fill		: bytearray * int -> unit
    val map		: (int -> int) -> bytearray -> bytearray
    val map_index	: (int * int -> int) -> bytearray -> bytearray
    val iterate		: (int -> unit) -> bytearray -> unit
    val iterate_index	: (int * int -> unit) -> bytearray -> unit
    val rev		: bytearray -> bytearray
    val duplicate	: bytearray -> bytearray
    val subarray	: bytearray * int * int -> bytearray
    val substring	: bytearray * int * int -> string
    val append		: bytearray * bytearray -> bytearray
    val reducel		: ('a * int -> 'a) -> ('a * bytearray) -> 'a
    val reducer		: (int * 'a -> 'a) -> (bytearray * 'a) -> 'a
    val reducel_index	: (int * 'a * int -> 'a) -> ('a * bytearray) -> 'a
    val reducer_index	: (int * int * 'a -> 'a) -> (bytearray * 'a) -> 'a
    val copy		: bytearray * int * int * bytearray * int -> unit
    val fill_range	: bytearray * int * int * int -> unit
    val find		: (int -> bool) -> bytearray -> int
    val find_default	: ((int -> bool) * int) -> bytearray -> int
    val maxLen          : int
  end;

signature FLOATARRAY =
  sig
    eqtype floatarray

    exception Range of int
    exception Size
    exception Subscript
    exception Find

    val array		: int * real -> floatarray
    val length		: floatarray -> int
    val update		: floatarray * int * real -> unit
    val sub		: floatarray * int -> real
    val arrayoflist	: real list -> floatarray

    val tabulate	: int * (int -> real) -> floatarray
    val from_list	: real list -> floatarray
    val to_list		: floatarray -> real list
    val fill		: floatarray * real -> unit
    val map		: (real -> real) -> floatarray -> floatarray
    val map_index	: (int * real -> real) -> floatarray -> floatarray
    val iterate		: (real -> unit) -> floatarray -> unit
    val iterate_index	: (int * real -> unit) -> floatarray -> unit
    val rev		: floatarray -> floatarray
    val duplicate	: floatarray -> floatarray
    val subarray	: floatarray * int * int -> floatarray
    val append		: floatarray * floatarray -> floatarray
    val reducel		: ('a * real -> 'a) -> ('a * floatarray) -> 'a
    val reducer		: (real * 'a -> 'a) -> (floatarray * 'a) -> 'a
    val reducel_index	: (int * 'a * real -> 'a) -> ('a * floatarray) -> 'a
    val reducer_index	: (int * real * 'a -> 'a) -> (floatarray * 'a) -> 'a
    val copy		: floatarray * int * int * floatarray * int -> unit
    val fill_range	: floatarray * int * int * real -> unit
    val find		: (real -> bool) -> floatarray -> int
    val find_default	: ((real -> bool) * int) -> floatarray -> int
    val maxLen          : int
  end;

signature STRING = 
  sig 
    exception Substring
    exception Chr
    exception Ord
    val maxLen : int
    val explode : string -> string list
    val implode : string list -> string
    val chr : int -> string
    val ord : string -> int
    val substring : string * int * int -> string
    val <  : string * string -> bool
    val >  : string * string -> bool
    val <= : string * string -> bool
    val >= : string * string -> bool
    val ordof : string * int -> int

    val ml_string : string * int -> string

    val implode_char : int list -> string

  end;

signature BITS =
  sig
    val andb    : int * int -> int
    val orb     : int * int -> int
    val xorb    : int * int -> int
    val lshift  : int * int -> int
    val rshift  : int * int -> int
    val arshift : int * int -> int
    val notb    : int -> int
  end;

signature GENERAL =
  sig
    eqtype  unit
    type  exn

    exception Bind
    exception Match
    exception Subscript
    exception Size
    exception Overflow
    exception Domain
    exception Div
    exception Chr
    exception Fail of string
    exception Empty

    val exnName : exn -> string
    val exnMessage : exn -> string

    datatype order = LESS | EQUAL | GREATER

    val <> : (''a * ''a) -> bool

    val ! : 'a ref -> 'a

    val := : ('a ref * 'a) -> unit

    val o : (('b -> 'c) * ('a -> 'b)) -> 'a -> 'c

    val before : ('a * unit) -> 'a

    val ignore : 'a -> unit

  end

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

structure FullPervasiveLibrary_  :
  sig
    structure MLWorks : MLWORKS

    datatype option = datatype MLWorks.Internal.Types.option

    structure General: GENERAL

    exception Option

    include GENERAL

    eqtype 'a array
    eqtype 'a vector

    val chr		      : int -> char
    val ord		      : char -> int
    val floor                 : real -> int
    val ceil                  : real -> int
    val trunc                 : real -> int
    val round                 : real -> int
    val real                  : int -> real
    val /                     : real * real -> real
    val @                     : 'a list * 'a list -> 'a list
    val ^                     : string * string -> string
    val map                   : ('a -> 'b) -> 'a list -> 'b list
    val not                   : bool -> bool
    val rev                   : 'a list -> 'a list
    val size                  : string -> int


    val str                   : char -> string
    val concat                : string list -> string
    val implode               : char list -> string
    val explode               : string -> char list
    val substring             : string * int * int -> string

    val null                  : 'a list -> bool
    val hd                    : 'a list -> 'a
    val tl                    : 'a list -> 'a list
    val length                : 'a list -> int

    val app                   : ('a -> unit) -> 'a list -> unit
    val foldr                 : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b
    val foldl                 : ('a * 'b -> 'b) -> 'b -> 'a list -> 'b

    val print                 : string -> unit
    val vector                : 'a list -> 'a vector

    val isSome : 'a option -> bool
    val valOf : 'a option -> 'a
    val getOpt : 'a option * 'a -> 'a

  end

=

  struct

    open BuiltinLibrary_

    val chr = char_chr
    val ord = char_ord

    exception Unimplemented of string
    exception Substring

    fun ignore x = ()

    structure MLWorks : MLWORKS =
      struct

	exception Interrupt

        val arguments : unit -> string list = call_c "system os arguments"
        val name: unit -> string = call_c "system os name"

        structure String : STRING =
          struct
            open BuiltinLibrary_
	
            exception Substring = Substring

            val maxLen = 16777195 (* MAGIC: One less than ByteArray.maxLen *)
            val unsafe_substring : (string * int * int) -> string =
              call_c "string unsafe substring"
            fun substring (s, i, n) =
              if n < 0 then raise Substring
              else if i < 0 then raise Substring
              else if i > size s - n then raise Substring
              else if n > 12 then unsafe_substring (s, i, n)
              else
                let
                  val new_s = alloc_string (n + 1)
                  fun copy 0 = new_s
                  |   copy j =
                    let
                      val j' = j - 1
                    in
                      string_unsafe_update
                         (new_s, j', string_unsafe_sub (s, i+j'));
                      copy j'
                    end
                in
                  string_unsafe_update (new_s, n, 0);
                  copy n
                end;

            val c_implode_char : int list * int -> string =
              call_c "string c implode char"

            (* For more than ~30 characters this is slower than the
               C function.*)
            (* We could do something similar with implode too *)
            fun implode_char cl : string =
              let
                fun copyall ([],start,to) = to
                  | copyall (c::cl,start,to) =
                  (string_unsafe_update (to,start,c);
                   copyall (cl,start+1,to))
                fun get_size (a::rest,sz) = get_size (rest,1 + sz)
                  | get_size ([],sz) =
                  if sz > 30 then c_implode_char (cl,sz)
                  else
                    let
                      val result = alloc_string (sz+1)
                      (* set the null terminator *)
                      val _ = string_unsafe_update (result,sz,0)
                    in
                      copyall (cl,0,result)
                    end
              in
                get_size (cl,0)
              end

	    fun ml_string (s,max_size) =
	      let
                val string_abbrev = "\\..."
                val (s,abbrev) =
                  if max_size < 0 orelse size s <= max_size
                    then (s,false)
                  else if max_size < size string_abbrev
                    then ("",true)
                  else (substring (s,0,max_size - size string_abbrev),true)
		fun to_digit n = chr (n +ord "0")
		fun aux ([],result) = implode (rev result)
		  | aux (char::rest,result) =
		    let val newres =
		      case char of
			"\n" => "\\n"::result
		      | "\t" => "\\t"::result
		      | "\"" => "\\\""::result
		      | "\\" => "\\\\"::result
		      | c =>
			  let val n = ord c
			  in
			    if n < 32 orelse n >= 127 then
			      let
				val n1 = n div 10
			      in
				(to_digit (n mod 10))::
				(to_digit (n1 mod 10))::
				(to_digit (n1 div 10))::
				"\\" :: result
			      end
			    else
			      c::result
			  end
		    in
		      aux (rest, newres)
		    end
	      in
                aux (explode s,[]) ^ (if abbrev then string_abbrev else "")
	      end

            (* Finally define these *)
            val op <  : string * string -> bool = string_less
            val op >  : string * string -> bool = string_greater
            val op <= : string * string -> bool = string_less_equal
            val op >= : string * string -> bool = string_greater_equal

          end (* structure String *)

        structure Deliver =
	  struct
	    (* This datatype is passed into the runtime delivery function and 
	     * is tested as an integer in C.  *)
	    datatype app_style = CONSOLE | WINDOWS
	    type deliverer = string * (unit -> unit) * app_style -> unit
	    type delivery_hook = deliverer -> deliverer
	    local
	      val c_deliver : deliverer = call_c "function deliver"
	      val delivery_hooks : delivery_hook list ref = ref []
	      fun true_deliverer (f,[]) = f
		| true_deliverer (f,h::hs) = true_deliverer (h f, hs)
	    in
	      fun add_delivery_hook (h : delivery_hook) =
		delivery_hooks := (h::(!delivery_hooks))

	      fun with_delivery_hook h f x =
		let
		  val hs = !delivery_hooks
		  val _ = delivery_hooks := (h::hs)
		  fun restore () = delivery_hooks := hs
		  val result = f x handle exn => (restore (); raise exn)
		in
		  (restore (); result)
		end

	      val exitFn = ref (fn () => ())

	      fun deliver args =
		let
                  val old_deliverer = true_deliverer(c_deliver, !delivery_hooks)
		  val deliverer =
		    (fn (s, f, b) =>
			old_deliverer (s, fn () => (ignore(f()); (!exitFn) ()), b) )

                  val hooks = !delivery_hooks
		in
                  delivery_hooks := [];
                  deliverer args
                    handle exn =>
                      (delivery_hooks := hooks; raise exn);
                  delivery_hooks := hooks
		end
	    end (* local *)
	  end (* structure Deliver *)

        structure Internal =
          struct

	    exception Save of string

	    structure Types =
	      struct
		type int8 = int8
		type word8 = word8
		type int16 = int16
		type word16 = word16
		type int32 = int32
		type word32 = word32
                datatype 'a option = SOME of 'a | NONE
		datatype time = TIME of int * int * int
              end (* structure Types *)

	    val save : string * (unit -> 'a) -> unit -> 'a =
	      fn x => call_c "image save" x
	    val execSave = fn x => call_c "exec image save" x
            val real_to_string : real * int -> string = call_c "real to string"

            exception StringToReal
            val string_to_real : string -> real = call_c "real from string"

            val text_preprocess = ref (fn (f : int -> string ) => f)


            (* Provide the SysErr excaption as required by the basis OS structure.
             * The exception is defined here so as to avoid the rebinding problem
             * that occurs if the exception was bound in a user loadable file.
             *
             * Any changes made here should be reflected in the runtime, see
             * rts/src/OS/Unix/unix.c and rts/src/OS/Win32/win32.c
             *)
            structure Error =
              struct
                type syserror = int
                exception SysErr of string * syserror Types.option
                val errorMsg  : syserror -> string = call_c "OS.errorMsg"
                val errorName : syserror -> string = call_c "OS.errorName"
                val syserror  : string -> syserror Types.option
                  = call_c "OS.syserror"
              end (* structure Error *)



            (* IO provides some features that are needed to primarily to
             * support MLWorks.Internal.StandardIO.  I pulled them out of
             * StandardIO and added the file_desc type since the routines
             * are also needed elsewhere (for example win32/_win32os.sml).
             *
             * Note at some point the routines [sc]ould be updated to use
             * the same interface as similarly named routines in POSIX.IO
             * and hence avoid code duplication and/or casts.
             *
             * Any changes made here should be reflected in the runtime, see
             * rts/src/OS/Unix/unix.c and rts/src/OS/Win32/win32.c
             *
             * Added exception Io from basis so that it can be handled
             * easily by exnMessage.
             *)
            structure IO =
              struct
                exception Io of {name : string, function : string, cause : exn}

                datatype file_desc = FILE_DESC of int

                val write: file_desc * string * int * int-> int
                  = call_c "system io write"

                val read: file_desc * int -> string
                  = call_c "system io read"

                val seek: file_desc * int * int -> int
                  = call_c "system io seek"

                val close: file_desc -> unit
                  = call_c "system io close"

                val can_input: file_desc -> int
                  = call_c "system io can input"
              end (* structure IO *)

            structure StandardIO =
              struct
                   (* the following determines a "current I/O context" *)
                   (* which is set by each window as it evaluates a    *)
                   (* function.                                        *)
                   (* #input records all data required to manipulate   *)
                   (* standard in.  #output for standard out, and      *)
                   (* #error for standard error.                       *)


                   (* IMPORTANT: if you change this, then change the   *)
                   (* files gui/_listener.sml, gui/_podium.sml,        *)
                   (* gui/_console.sml, gui/console.sml,               *)
                   (* gui/_comp_manager.sml, interpreter/xinterpreter, *)
                   (* pervasive/gui_standard_io.sml, unix/__primio.sml *)
                   (* win_nt/__primio.sml, motif/_menus.sml and last   *)
                   (* mswindows/_menus.sml         .                   *)

                type IOData = {input:{descriptor: IO.file_desc Types.option,
                                      get: int -> string,
                                      get_pos: (unit -> int) Types.option,
                                      set_pos: (int -> unit) Types.option,
                                      close: unit -> unit,
                                      can_input: (unit -> bool) Types.option},
                  output: {descriptor: IO.file_desc Types.option,
                           put: {buf:string, i:int, sz: int Types.option}
                                   -> int,
                           get_pos: (unit -> int) Types.option,
                           set_pos: (int -> unit) Types.option,
                           can_output: (unit->bool) Types.option,
                           close: unit-> unit},
                  error: {descriptor: IO.file_desc Types.option,
                          put: {buf:string, i:int, sz: int Types.option}
                                -> int,
                          get_pos: (unit -> int) Types.option,
                          set_pos: (int -> unit) Types.option,
                          can_output: (unit->bool) Types.option,
                          close: unit->unit},
                  access: (unit->unit)->unit}

                  (* access is a hook for the gui to provide some code
                   * for MLWorks.Threads.Internal.Preemption.stop()
                   * to execute before it actually stops preempting.
                   * This allows guis to actually claim control of the
                   * listener before shutting down preemption.
                   * See <URI:spring://ML_Notebook/Design/GUI/Mutexes>.
                   *)
                local
                  val stdIn: IO.file_desc ref =
                                 call_c "system io standard input";
                  val stdOut: IO.file_desc ref =
                                 call_c "system io standard output";
                  val stdErr: IO.file_desc ref =
                                 call_c "system io standard error";


                  val terminalIO : IOData =
                    {output={descriptor=Types.SOME (!stdOut),
                                         (*YUK*)
                             put=fn {buf,i,sz=Types.NONE} =>
                                       IO.write(!stdOut,buf,i,size buf-i)
                                  | {buf,i,sz=Types.SOME n} =>
                                       IO.write(!stdOut,buf,i,n),
                             get_pos = Types.SOME(fn () =>
                                                       IO.seek(!stdOut,0,1)),

                               (* seek to 0th byte after current (=1) pos*)
                               (* which returns the position in file     *)
                             set_pos = Types.SOME
                                          (fn i => (ignore(IO.seek (!stdOut,i,0));())),
                             can_output = Types.NONE,
                             close = fn () => IO.close (!stdOut)},
                               (* seek to ith byte after beginning(=0) *)
                     error={descriptor=Types.SOME (!stdErr),
                             put=fn {buf,i,sz=Types.NONE} =>
                                       IO.write(!stdErr,buf,i,size buf-i)
                                  | {buf,i,sz=Types.SOME n} =>
                                       IO.write(!stdErr,buf,i,n),
                             get_pos=
                                   Types.SOME
                                    (fn () => IO.seek(!stdErr,0,1)),
                             set_pos= Types.SOME
                                     (fn i => (ignore(IO.seek(!stdErr,i,0)); ())),
                             can_output = Types.NONE,
                             close= fn () => IO.close (!stdErr)},
                     input={descriptor=Types.SOME (!stdIn),
                             get= fn i => IO.read (!stdIn,i),
                             get_pos= Types.SOME
                                       (fn () => IO.seek(!stdIn,0,1)),
                             set_pos= Types.SOME
                                            (fn i => (ignore(IO.seek(!stdIn,i,0));())),
                             close= fn() => IO.close (!stdIn),
                             can_input=
                                  Types.SOME
                                    (fn()=>IO.can_input (!stdIn)>0)},
                     access = fn f =>f()}

                  val currIO: IOData ref = ref terminalIO

                in
                  fun currentIO () = !currIO
                  fun redirectIO (newIO:IOData) =
                    (currIO:=newIO)
                  fun resetIO() = currIO:=terminalIO
                  fun print s = (ignore(#put(#output(currentIO()))
                                          {buf=s,i=0,sz=Types.NONE}); ())
                  fun printError s = (ignore(#put(#error(currentIO()))
                                               {buf=s,i=0,sz=Types.NONE});())
                end

              end (* structure StandardIO *)

            structure Exit =
              struct
                type key = int
                type status = word32
                val success : status = 0w0
                val failure : status = 0w1

                fun terminate (x:status):'a = call_c "system os exit" x

                val exitActions = ref [] : (key * (unit -> unit)) list ref

                val exiting = ref false : bool ref

                (* exit is a little convoluted because it must satisfy the
                 * following requirement on OS.Process.exit :-
                 *
                 *   Calls to *exit* do not return, but should cause the remainder 
                 *   of the functions registered with *atExit* to be executed.
                 *)

                fun exit exitCode =
                  let 
                    fun exit' [] = terminate exitCode
                      | exit' ((_,action)::actions) = 
                          (exitActions := actions;
                           (action () handle _ => ());
                           exit' actions)
                  in
                    exiting := true;
                    exit' (!exitActions)
                  end

                val key = ref 0
                val firstExitFn = ref true

                fun atExit action =
                  if !exiting
                  then 0
                  else
                    (if !firstExitFn then 
	              (Deliver.exitFn := (fn () => (ignore(exit success); ()));
        	       firstExitFn := false)
           	     else ();
                     key := !key + 1;
        	     exitActions := (!key, action)::(!exitActions);
                     !key)

                fun removeAtExit key =
                  if !exiting then ()
                  else
                    let fun rem [] = []
                          | rem ((p as (key',_))::t) = 
                              if key = key' then t else p :: (rem t)
                     in exitActions := rem(!exitActions)
                    end
              end

            structure Debugger =
              struct
                fun default_break s = StandardIO.print("Break at " ^ s ^ "\n")
                val break_hook = ref default_break
                fun break s = (!break_hook) s
              end (* structure Debugger *)



	    structure Images =
	      struct
		exception Table of string
		val clean : unit -> unit = call_c "clean code vectors"
		val save = save
		val table : string -> string list = call_c "image table"
	      end (* structure Images *)

            structure Bits : BITS =
              struct
                open BuiltinLibrary_
              end (* structure Bits *)

            structure Word =
              struct
                open BuiltinLibrary_
        	
                val orb = word_orb
                val xorb = word_xorb
                val andb = word_andb
                val notb = word_notb
                val << = word_lshift
                val >> = word_rshift
                val ~>> = word_arshift
              end (* structure Word *)

            structure Word32 =
              struct
        	val word32_orb = word32_orb
        	val word32_xorb = word32_xorb
        	val word32_andb = word32_andb
        	val word32_notb = word32_notb
        	val word32_lshift = word32_lshift
        	val word32_rshift = word32_rshift
        	val word32_arshift = word32_arshift
	      end (* structure Word32 *)




            structure FloatArray: FLOATARRAY =
              struct
                type floatarray = BuiltinLibrary_.floatarray
                exception Range = BuiltinLibrary_.Range
                exception Size = BuiltinLibrary_.Size
                exception Subscript = BuiltinLibrary_.Subscript
		val array = BuiltinLibrary_.floatarray
		val length = BuiltinLibrary_.floatarray_length
		val update = BuiltinLibrary_.floatarray_update
		val unsafe_update = BuiltinLibrary_.floatarray_unsafe_update
		val sub = BuiltinLibrary_.floatarray_sub
		val unsafe_sub = BuiltinLibrary_.floatarray_unsafe_sub

		val maxLen = 1048575

		fun tabulate (l, f) =
		  let
		    val a = array (l, 0.0)

		    fun init n =
		      if n = l then a
		      else
			(unsafe_update (a, n, f n);
			 init (n+1))
		  in
		    init 0
		  end

		fun from_list list =
		  let
		    fun list_length (n, []) = n
		      | list_length (n, _::xs) = list_length (n+1, xs)

		    val new = array (list_length (0, list), 0.0)

		    fun fill (_, []) = new
		      | fill (n, x::xs) =
		      (unsafe_update (new, n, x);
		       fill (n+1, xs))
		  in
		    fill (0, list)
		  end

		val arrayoflist = from_list

		fun fill (a, x) =
		  let
		    fun fill' 0 = ()
		      | fill' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (a, n', x);
			 fill' n')
		      end
		  in
		    fill' (length a)
		  end

		fun map f a =
		  let
		    val l = length a
		    val new = array (l, 0.0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun map_index f a =
		  let
		    val l = length a
		    val new = array (l, 0.0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (n, unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun to_list a =
		  let
		    fun to_list' (0, list) = list
		      | to_list' (n, list) =
		      let
			val n' = n-1
		      in
			to_list' (n', unsafe_sub (a, n') :: list)
		      end
		  in
		    to_list' (length a, nil)
		  end

		fun iterate f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else
			(ignore(f (unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun iterate_index f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else
			(ignore(f (n, unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun rev a =
		  let
		    val l = length a
		    val new = array (l, 0.0)

		    fun rev' 0 = new
		      | rev' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (a, l-n));
			 rev' n')
		      end
		  in
		    rev' l
		  end

		fun duplicate a =
		  let
		    val l = length a
		    val new = array (l, 0.0)

		    fun duplicate' 0 = new
		      | duplicate' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (a, n'));
			 duplicate' n')
		      end
		  in
		    duplicate' l
		  end

		fun subarray (a, start, finish) =
		  let
		    val l = length a
		  in
		    if start < 0 orelse start > l orelse finish > l orelse
		      start > finish then
		      raise Subscript
		    else
		      let
			val l' = finish - start
			val new = array (l', 0.0)

			fun copy 0 = new
			  | copy n =
			  let
			    val n' = n-1
			  in
			    (unsafe_update (new, n', unsafe_sub (a, start+n'));
			     copy n')
			  end
		      in
			copy l'
		      end
		  end

		fun append (array1, array2) =
		  let
		    val l1 = length array1
		    val l2 = length array2
		    val new = array (l1+l2, 0.0)

		    fun copy1 0 = new
		      | copy1 n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (array1, n'));
			 copy1 n')
		      end

		    fun copy2 0 = copy1 l1
		      | copy2 n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n'+l1, unsafe_sub (array2, n'));
			 copy2 n')
		      end
		  in
		    copy2 l2
		  end

		fun reducel f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
		      let
			val n' = n-1
		      in
			reducer' (n', f (unsafe_sub (a, n'), i))
		      end
		  in
		    reducer' (l, i)
		  end

		fun reducel_index f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (n, i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer_index f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
		      let
			val n' = n-1
		      in
			reducer' (n', f (n', unsafe_sub (a, n'), i))
		      end
		  in
		    reducer' (l, i)
		  end

		fun copy (from, start, finish, to, start') =
		  let
		    val l1 = length from
		    val l2 = length to
		  in
		    if start < 0 orelse start > l1 orelse finish > l1 orelse
		      start > finish orelse
		      start' < 0 orelse start' + finish - start > l2 then
		      raise Subscript
		    else
		      let
			fun copydown 0 = ()
			  | copydown n =
			  let
			    val n' = n-1
			  in
			    (unsafe_update (to, start'+n',
                                            unsafe_sub (from, start+n'));
			     copydown n')
			  end
			fun copyup i =
			  if i = finish then ()
			  else
			    (unsafe_update (to,i-start+start',
                                            unsafe_sub (from,i));
			     copyup (i + 1))
		      in
			if start < start'
			  then copydown (finish - start)
			else copyup start
		      end
		  end

	        fun fill_range (a, start, finish, x) =
                  let
                    val l = length a
                  in
                    if start < 0 orelse start > l orelse finish > l orelse
                      start > finish then
                      raise Subscript
                    else
                      let
                        fun fill' 0 = ()
                          | fill' n =
                          let
                            val n' = n-1
                          in
                            (unsafe_update (a, start+n', x);
                             fill' n')
                          end
                      in
                        fill' (finish - start)
                      end
                  end

                exception Find

                fun find predicate a =
                  let
                    val l = length a
                    fun find' n =
                      if n = l then
                        raise Find
                      else
                        if predicate (unsafe_sub (a, n)) then n
                        else find' (n+1)
                  in
                    find' 0
                  end

                fun find_default (predicate, default) a =
                  let
                    val l = length a
                    fun find' n =
                      if n = l then
                        default
                      else
                        if predicate (unsafe_sub (a, n)) then n
                        else find' (n+1)
                  in
                    find' 0
                  end

              end (* FloatArray *)



	    structure ByteArray : BYTEARRAY =
	      struct
		open BuiltinLibrary_
		exception Substring = Substring

		type bytearray = bytearray

		val maxLen = 16777196
		val array = BuiltinLibrary_.bytearray
		val length = BuiltinLibrary_.bytearray_length
		val update = BuiltinLibrary_.bytearray_update
		val unsafe_update = BuiltinLibrary_.bytearray_unsafe_update
		val sub = BuiltinLibrary_.bytearray_sub
		val unsafe_sub = BuiltinLibrary_.bytearray_unsafe_sub

		val to_string : bytearray -> string =
                                         call_c "bytearray to string"
		val from_string : string -> bytearray =
                                         call_c "bytearray from string"
		val substring : bytearray * int * int -> string =
                                         call_c "bytearray substring"

		fun tabulate (l, f) =
		  let
		    val a = array (l, 0)

		    fun init n =
		      if n = l then a
		      else
			(unsafe_update (a, n, f n);
			 init (n+1))
		  in
		    init 0
		  end

		fun from_list list =
		  let
		    fun list_length (n, []) = n
		      | list_length (n, _::xs) = list_length (n+1, xs)

		    val new = array (list_length (0, list), 0)

		    fun fill (_, []) = new
		      | fill (n, x::xs) =
		      (unsafe_update (new, n, x);
		       fill (n+1, xs))
		  in
		    fill (0, list)
		  end

		val arrayoflist = from_list

		fun fill (a, x) =
		  let
		    fun fill' 0 = ()
		      | fill' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (a, n', x);
			 fill' n')
		      end
		  in
		    fill' (length a)
		  end

		fun map f a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun map_index f a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (n, unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun to_list a =
		  let
		    fun to_list' (0, list) = list
		      | to_list' (n, list) =
		      let
			val n' = n-1
		      in
			to_list' (n', unsafe_sub (a, n') :: list)
		      end
		  in
		    to_list' (length a, nil)
		  end

		fun iterate f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else	
			(ignore(f (unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun iterate_index f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else
			(ignore(f (n, unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun rev a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun rev' 0 = new
		      | rev' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (a, l-n));
			 rev' n')
		      end
		  in
		    rev' l
		  end

		fun duplicate a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun duplicate' 0 = new
		      | duplicate' n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (a, n'));
			 duplicate' n')
		      end
		  in
		    duplicate' l
		  end

		fun subarray (a, start, finish) =
		  let
		    val l = length a
		  in
		    if start < 0 orelse start > l orelse finish > l orelse
		      start > finish then
		      raise Subscript
		    else
		      let
			val l' = finish - start
			val new = array (l', 0)

			fun copy 0 = new
			  | copy n =
			  let
			    val n' = n-1
			  in
			    (unsafe_update (new, n', unsafe_sub (a, start+n'));
			     copy n')
			  end
		      in
			copy l'
		      end
		  end

		fun append (array1, array2) =
		  let
		    val l1 = length array1
		    val l2 = length array2
		    val new = array (l1+l2, 0)

		    fun copy1 0 = new
		      | copy1 n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n', unsafe_sub (array1, n'));
			 copy1 n')
		      end

		    fun copy2 0 = copy1 l1
		      | copy2 n =
		      let
			val n' = n-1
		      in
			(unsafe_update (new, n'+l1, unsafe_sub (array2, n'));
			 copy2 n')
		      end
		  in
		    copy2 l2
		  end

		fun reducel f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
		      let
			val n' = n-1
		      in
			reducer' (n', f (unsafe_sub (a, n'), i))
		      end
		  in
		    reducer' (l, i)
		  end

		fun reducel_index f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (n, i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer_index f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
		      let
			val n' = n-1
		      in
			reducer' (n', f (n', unsafe_sub (a, n'), i))
		      end
		  in
		    reducer' (l, i)
		  end

		fun copy (from, start, finish, to, start') =
		  let
		    val l1 = length from
		    val l2 = length to
		  in
		    if start < 0 orelse start > l1 orelse finish > l1 orelse
		      start > finish orelse
		      start' < 0 orelse start' + finish - start > l2 then
		      raise Subscript
		    else
		      let
			fun copydown 0 = ()
			  | copydown n =
			  let
			    val n' = n-1
			  in
			    (unsafe_update (to, start'+n',
                                            unsafe_sub (from, start+n'));
			     copydown n')
			  end
			fun copyup i =
			  if i = finish then ()
			  else
			    (unsafe_update (to,i-start+start',
                                            unsafe_sub (from,i));
			     copyup (i + 1))
		      in
			if start < start'
			  then copydown (finish - start)
			else copyup start
		      end
		  end
(*
(* Old version for reference *)
(* This fails when copying a to a *)
	    fun copy (from, start, finish, to, start') =
	      let
		val l1 = length from
		val l2 = length to
	      in
		if start < 0 orelse start > l1 orelse finish > l1 orelse
		  start > finish orelse
		  start' < 0 orelse start' + finish - start > l2 then
		  raise Subscript
		else
		  let
		    fun copy' 0 = ()
		      | copy' n =
			let
			  val n' = n-1
			in
			  (unsafe_update (to, start'+n', unsafe_sub (from, start+n'));
			   copy' n')
			end
		  in
		    copy' (finish - start)
		  end
	      end
*)

	    fun fill_range (a, start, finish, x) =
	      let
		val l = length a
	      in
		if start < 0 orelse start > l orelse finish > l orelse
		  start > finish then
		  raise Subscript
		else
		  let
		    fun fill' 0 = ()
		      | fill' n =
			let
			  val n' = n-1
			in
			  (unsafe_update (a, start+n', x);
			   fill' n')
			end
		  in
		    fill' (finish - start)
		  end
	      end
	
	    exception Find

	    fun find predicate a =
	      let
		val l = length a
		fun find' n =
		  if n = l then
		    raise Find
		  else
		    if predicate (unsafe_sub (a, n)) then n else find' (n+1)
	      in
		find' 0
	      end

	    fun find_default (predicate, default) a =
	      let
		val l = length a
		fun find' n =
		  if n = l then
		    default
		  else
		    if predicate (unsafe_sub (a, n)) then n else find' (n+1)
	      in
		find' 0
	      end

	      end (* structure ByteArray *)

	    structure ExtendedArray : EXTENDED_ARRAY =
	      struct
		open BuiltinLibrary_

		type 'a array = 'a array

                val maxLen = 4194297 (* MAGIC NUMBER *)
		fun tabulate (l, f) =
		  let
		    val a = array (l, 0)

		    fun init n =
		      if n = l then a
		      else
			(unsafe_update (a, n, f n);
			 init (n+1))
		  in
		    init 0
		  end

		fun from_list list =
		  let
		    fun list_length (n, []) = n
		      | list_length (n, _::xs) = list_length (n+1, xs)

		    val new = array (list_length (0, list), 0)

		    fun fill (_, []) = new
		      | fill (n, x::xs) =
			(unsafe_update (new, n, x);
			 fill (n+1, xs))
		  in
		    fill (0, list)
		  end

		val arrayoflist = from_list

		fun fill (a, x) =
		  let
		    fun fill' 0 = ()
		      | fill' n =
		    let
		      val n' = n-1
		    in
		      (unsafe_update (a, n', x);
		       fill' n')
		    end
		  in
		    fill' (length a)
		  end

		fun map f a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun map_index f a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun map' n =
		      if n = l then
			new
		      else
			(unsafe_update (new, n, f (n, unsafe_sub (a, n)));
			 map' (n+1))
		  in
		    map' 0
		  end

		fun to_list a =
		  let
		    fun to_list' (0, list) = list
		      | to_list' (n, list) =
			let
			  val n' = n-1
			in
			  to_list' (n', unsafe_sub (a, n') :: list)
			end
		  in
		    to_list' (length a, nil)
		  end

		fun iterate f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else
			(ignore(f (unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun iterate_index f a =
		  let
		    val l = length a

		    fun iterate' n =
		      if n = l then
			()
		      else
			(ignore(f (n, unsafe_sub (a, n)));
			 iterate' (n+1))
		  in
		    iterate' 0
		  end

		fun rev a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun rev' 0 = new
		      | rev' n =
			let
			  val n' = n-1
			in
			  (unsafe_update (new, n', unsafe_sub (a, l-n));
			   rev' n')
			end
		  in
		    rev' l
		  end

		fun duplicate a =
		  let
		    val l = length a
		    val new = array (l, 0)

		    fun duplicate' 0 = new
		      | duplicate' n =
			let
			  val n' = n-1
			in
			  (unsafe_update (new, n', unsafe_sub (a, n'));
			   duplicate' n')
			end
		  in
		    duplicate' l
		  end

		exception Subarray of int * int
		fun subarray (a, start, finish) =
		  let
		    val l = length a
		  in
		    if start < 0 orelse start > l orelse finish > l orelse
		      start > finish then
		      raise Subscript
		    else
		      let
			val l' = finish - start
			val new = array (l', 0)

			fun copy 0 = new
			  | copy n =
			    let
			      val n' = n-1
			    in
			      (unsafe_update (new, n', unsafe_sub (a, start+n'));
			       copy n')
			    end
		      in
			copy l'
		      end
		  end

		fun append (array1, array2) =
		  let
		    val l1 = length array1
		    val l2 = length array2
		    val new = array (l1+l2, 0)

		    fun copy1 0 = new
		      | copy1 n =
			let
			  val n' = n-1
			in
			  (unsafe_update (new, n', unsafe_sub (array1, n'));
			   copy1 n')
			end

		    fun copy2 0 = copy1 l1
		      | copy2 n =
			let
			  val n' = n-1
			in
			  (unsafe_update (new, n'+l1, unsafe_sub (array2, n'));
			   copy2 n')
			end
		  in
		    copy2 l2
		  end

		fun reducel f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
			let
			  val n' = n-1
			in
			  reducer' (n', f (unsafe_sub (a, n'), i))
			end
		  in
		    reducer' (l, i)
		  end

		fun reducel_index f (i, a) =
		  let
		    val l = length a

		    fun reducel' (i, n) =
		      if n = l then
			i
		      else
			reducel' (f (n, i, unsafe_sub (a, n)), n+1)
		  in
		    reducel' (i, 0)
		  end

		fun reducer_index f (a, i) =
		  let
		    val l = length a

		    fun reducer' (0, i) = i
		      | reducer' (n, i) =
			let
			  val n' = n-1
			in
			  reducer' (n', f (n', unsafe_sub (a, n'), i))
			end
		  in
		    reducer' (l, i)
		  end

		fun copy (from, start, finish, to, start') =
		  let
		    val l1 = length from
		    val l2 = length to
		  in
		    if start < 0 orelse start > l1 orelse finish > l1 orelse
		      start > finish orelse
		      start' < 0 orelse start' + finish - start > l2 then
		      raise Subscript
		    else
		      let
			fun copydown 0 = ()
			  | copydown n =
			    let
			      val n' = n-1
			    in
			      (unsafe_update (to, start'+n', unsafe_sub (from, start+n'));
			       copydown n')
			    end
                        fun copyup i =
                          if i = finish then ()
                          else
                            (unsafe_update (to,i-start+start',unsafe_sub (from,i));
                             copyup (i + 1))
		      in
                        if start < start'
                          then copydown (finish - start)
                        else copyup start
		      end
		  end

		fun fill_range (a, start, finish, x) =
		  let
		    val l = length a
		  in
		    if start < 0 orelse start > l orelse finish > l orelse
		      start > finish then
		      raise Subscript
		    else
		      let
			fun fill' 0 = ()
			  | fill' n =
			    let
			      val n' = n-1
			    in
			      (unsafe_update (a, start+n', x);
			       fill' n')
			    end
		      in
			fill' (finish - start)
		      end
		  end

		exception Find
		fun find predicate a =
		  let
		    val l = length a
		    fun find' n =
		      if n = l then
			raise Find
		      else
			if predicate (unsafe_sub (a, n)) then n else find' (n+1)
		  in
		    find' 0
		  end

		fun find_default (predicate, default) a =
		  let
		    val l = length a
		    fun find' n =
		      if n = l then
			default
		      else
			if predicate (unsafe_sub (a, n)) then n else find' (n+1)
		  in
		    find' 0
		  end

	      end (* structure ExtendedArray *)

	    structure Array : ARRAY = ExtendedArray

	    structure Vector : VECTOR =
	      struct
		open BuiltinLibrary_
		type 'a vector = 'a vector
                val maxLen = 4194299 (* MAGIC NUMBER *)
		fun length' ([],n) = n
		  | length' (a::b,n) = length' (b,unsafe_int_plus (n,1))
		fun length l = length' (l,0)
		fun update ([],n,v) = ()
		  | update (a::rest,n,v) =
		    (record_unsafe_update (v,n,a);
		     update (rest,unsafe_int_plus (n,1),v))
		
		(* This is going to override the definition in the builtin library *)
		fun vector (l : 'a list) : 'a vector =
		  let
		    val len = length l
		    val result = alloc_vector len
		    val _ = update (l,0,result)
		  in
		    result
		  end

		fun tabulate(i, f) =
		  if i < 0 then
		    raise Size
		  else
		    let
		      fun make_list(done, j) =
			if j >= i then done
			else
			  make_list(f j :: done, j+1)
		    in
		      vector (rev (make_list([], 0)))
		    end
		val sub = vector_sub
		val length = vector_length
	      end (* structure Vector *)

            structure Value =
              struct
                open BuiltinLibrary_
                type T = ml_value
                exception Value of string

                (* Many of these operations would be better implemented as *)
                (* built-in code. *)

                val cast = cast
                val ccast = fn x => call_c "value cast" x
                val list_to_tuple : ml_value list -> ml_value = call_c "value list to tuple"
                val tuple_to_list : ml_value -> ml_value list = call_c "value tuple to list"
                val string_to_real : string -> real = call_c "value string to real"
                val real_to_string : real -> string = call_c "value real to string"

                val real_equal : real * real -> bool = real_equal
                val arctan : real -> real = arctan
                val cos : real -> real = cos
                val exp : real -> real = exp
                val sin : real -> real = sin
                val sqrt : real -> real = sqrt

                val unsafe_plus = unsafe_int_plus
                val unsafe_minus = unsafe_int_minus

                val unsafe_array_sub = unsafe_sub
                val unsafe_array_update = unsafe_update

                val unsafe_bytearray_sub = bytearray_unsafe_sub
                val unsafe_bytearray_update = bytearray_unsafe_update

                val unsafe_floatarray_sub = floatarray_unsafe_sub
                val unsafe_floatarray_update = floatarray_unsafe_update

                val unsafe_record_sub = record_unsafe_sub
                val unsafe_record_update = record_unsafe_update

                val unsafe_string_sub = string_unsafe_sub
                val unsafe_string_update = string_unsafe_update

                val alloc_pair = alloc_pair
                val alloc_string = alloc_string
                val alloc_vector = alloc_vector

                (* This datatype is decoded in rts/pervasive/value.c.  You *)
                (* must update that if you change it. *)
                datatype print_options =
                  DEFAULT |
                  OPTIONS of {depth_max	  	: int,
                              string_length_max	: int,
                              indent		: bool,
                              tags		  	: bool}
                val print : print_options * T -> unit = call_c "value print"
                val primary : T -> int = call_c "value primary"
                val header : T -> int * int = call_c "value header"
                val pointer : T * int -> T = call_c "value pointer"
                val update : T * int * T -> unit = call_c "value update value"
                val sub : T * int -> T = call_c "value sub value"
                val update_byte : T * int * int -> unit = call_c "value update byte"
                val sub_byte : T * int -> int = call_c "value sub byte"
                val update_header : T * int * int -> unit = call_c "value update header"
                val code_name : ml_value -> string = call_c "value code name"
                val exn_name : exn -> string = call_c "value exn name"
                val exn_argument : exn -> T = call_c "value exn argument"

		fun update_exn_sub(exn1, exn2) =
		  (* Update the exception constructor unique in exn1 *)
		  (* with that in exn2 *)
		  (* Thus exn1 and exn2 become the same exception *)
		  (* though possibly with different exn_names *)
		  let
		    val constructor1 = unsafe_record_sub(exn1, 0)
		    val constructor2 = unsafe_record_sub(exn2, 0)
		    val unique = unsafe_record_sub(constructor2, 0)
		  in
		    unsafe_record_update(constructor1, 0, unique)
		  end
		fun update_exn(exn1, ref exn2) =
		  update_exn_sub(exn1, exn2)
		fun update_exn_cons(exn1_cons, ref exn2_cons) =
		  update_exn_sub(exn1_cons(cast 0), exn2_cons(cast 0))

                structure Frame =
                  struct
                    datatype frame = FRAME of int

                    val sub : frame * int -> ml_value = call_c "stack frame sub"
                    val update : frame * int * ml_value -> unit = call_c "stack frame update"
                    val current : unit -> frame = call_c "stack frame current"
                    val is_ml_frame : frame -> bool = call_c "stack is ml frame"

                    val frame_call = fn x => call_c "debugger frame call" x
                    val frame_next : frame -> (bool * frame * int) = call_c "debugger frame next"
                    val frame_offset = fn x => call_c "debugger frame offset" x
		    val frame_double = fn x => call_c "debugger frame double" x
                    val frame_allocations : frame -> bool = call_c "debugger frame allocations"
                  end (* structure Frame *)
              end (* structure Value *)

            structure Trace =
              struct
                exception Trace of string
                val intercept = fn x => call_c "trace intercept" x
                val replace = fn x => call_c "trace replace" x
                val restore = fn x => call_c "trace restore" x
		val restore_all : unit -> unit = call_c "trace restore all"
                (* NOTE: This datatype is implicitly understood by the *)
                (* runtime system.  Don't change the constructors without *)
                (* altering rts/pervasive/trace.c *)
                datatype status = INTERCEPT | NONE | REPLACE | UNTRACEABLE
                val status = fn x => call_c "trace status" x
              end (* structure Trace *)

            structure Dynamic =
              struct
                type dynamic = dynamic
                type type_rep = type_rep

                exception Coerce of type_rep * type_rep

                val generalises_ref : (type_rep * type_rep -> bool) ref =
                  ref (fn _ => false)

  		local
                  fun generalises data = (!generalises_ref) data

                  val get_type = Value.cast (fn (a,b) => b)
                  val get_value = Value.cast (fn (a,b) => a)
		in
                  fun coerce (d : dynamic, t:type_rep) : ml_value =
                    if generalises (get_type d,t) then
		      get_value d
                    else
		      raise Coerce(get_type d,t)
		end

              end (* structure Dynamic *)

	    structure Runtime =
	      struct
                exception Unbound of string
                val environment = call_c

                val modules : (string * ml_value * ml_value) list ref = call_c "system module root"

                structure Loader =
                  struct
                    exception Load of string
                    val load_module : string -> (string * ml_value) = call_c "system load link"
                    val load_wordset : int * {a_names : string list,
                                              b: {a_clos: int,
                                                  b_spills: int,
                                                  c_saves: int,
                                                  d_code : string} list,
                                              c_leafs : bool list,
                                              d_intercept : int list,
					      e_stack_parameters : int list} ->
		      (int * ml_value) list = call_c "system load wordset"
                  end (* structure Loader *)

		structure Memory =
		  struct
		    val max_stack_blocks : int ref = call_c "mem max stack blocks"
		    val gc_message_level : int ref = call_c "gc message level"
		    val collect : int -> unit = call_c "gc collect generation"
		    val collect_all : unit -> unit = call_c "gc collect all"
		    val promote_all : unit -> unit = call_c "gc promote all"
		    val collections : unit -> (int * int) = call_c "gc collections"
		  end (* structure Memory *)

                structure Event =
                  struct
                    datatype T = SIGNAL of int
                    exception Signal of string
                    val signal : int * (int -> unit) -> unit = call_c "event signal"

		    val stack_overflow_handler : (unit -> unit) -> unit = call_c "event signal stack overflow"
		    val interrupt_handler : (unit -> unit) -> unit = call_c "event signal interrupt"
                  end (* structure Event *)
              end (* structure Runtime *)

	  end (* structure Internal *)

	structure Threads =
	  struct
            exception Threads of string

	    datatype 'a result =
	      Running		(* still running *)
	    | Waiting		(* waiting *)
	    | Sleeping		(* sleeping *)
	    | Result of 'a	(* completed, with this result *)
	    | Exception of exn	(* exited with this uncaught exn *)
	    | Died		(* died (e.g. bus error) *)
	    | Killed		(* killed *)
	    | Expired		(* no longer exists (from a previous image) *)
	
	    datatype 'a thread =
	      Thread of Internal.Value.T result ref * int
	
	    local
	      val identity = Internal.Value.cast
	    in
              (* r is a number (see rts/src/threads.h) indicating
                 which state the thread is in.  One of these states,
                 THREAD_KILLED_SLEEPING(=8), is used purely to keep
                 the internal thread mechanism secure.  To the user
                 This state should appear to be just THREAD_KILLED(=3).*)

	      fun result (Thread (r,i)) =
                Internal.Value.cast(
                let val y = Internal.Value.cast (!r)
                in if y=8 then 3 else y
                end)
		
	      val c_fork = (fn x => call_c "thread fork" x) : (unit -> 'b) -> 'b thread
		
	      fun fork (f : 'a -> 'b) a = c_fork (fn () => f a)
		
	      val yield = (call_c "thread yield") : unit -> unit

	      val sleep = (fn x => call_c "thread sleep" x) : 'a thread -> unit
	      val wake  = (fn x => call_c "thread wake" x)  : 'a thread -> unit


	      structure Internal =
		struct
		  type thread_id = unit thread
		
		  val id = fn x => call_c "thread current thread" x
		  fun get_id t = (identity t) : thread_id
		  val children = fn x => call_c "thread children" x
		  val parent = fn x => call_c "thread parent" x
		  val all = fn x => call_c "thread all threads" x
		
		  val kill = fn x => call_c "thread kill" x
		  val raise_in = fn x => call_c "thread raise" x
		  val yield_to = fn x => call_c "thread yield to" x
		  val set_handler = fn x => call_c "thread set fatal handler" x
		
		  val reset_fatal_status = fn x => call_c "thread reset fatal status" x

		  val get_num = fn x => call_c "thread number" x
		  fun state t =
		    case (result t) of
		      Running => Running
		    | Waiting => Waiting
		    | Sleeping => Sleeping
		    | Result _ => Result ()
		    | Exception e => Exception e
		    | Died => Died
		    | Killed => Killed
		    | Expired => Expired
			
		  structure Preemption =
		    struct
		      val start : unit -> unit
                        = call_c "thread start preemption"
		      val stop : unit -> unit
                        = fn () =>
                            let val s: unit->unit =
                              call_c "thread stop preemption"
                            in #access(Internal.StandardIO.currentIO()) s
                            end
                     (* see <URI:spring://ML_Notebook/Design/GUI/Mutexes> for
                        an explanation *)

		      val on : unit -> bool
                        = call_c "thread preempting"
		      val get_interval : unit -> int
                        = call_c "thread get preemption interval"
		      val set_interval : int -> unit
                        = call_c "thread set preemption interval"
                      val enter_critical_section : unit -> unit
                        = call_c "thread start critical section"
                      val exit_critical_section : unit -> unit
                        = call_c "thread stop critical section"
                      val in_critical_section: unit -> bool
                        = call_c "thread critical"
		    end (* structure Preemption *)
		end (* structure Internal *)
	    end (* local *)
	  end (* structure Threads *)

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
	
	    datatype options =
	      Options of
	      {scan : int,
	       selector : function_id -> manner}
	
	    datatype 'a result =
	      Result of 'a
	    | Exception of exn

	    exception ProfileError of string

	    local
	      val rts_profile = (fn x => call_c "profile" x) :
		int * (string->int) * (unit->'b) -> ('b * profile)
	    in
	      fun profile (Options {scan, selector}) f a =
		let
		  fun wrapper () = (Result (f a)) handle e => Exception e
		  fun sel x = selector x handle _ => 0
		in
		  rts_profile (scan, sel, wrapper)
		end
	    end

	    local
	      fun manner_object ARRAY = 1
		| manner_object BYTEARRAY = 2
		| manner_object CLOSURE = 4
		| manner_object OTHER = 8
		| manner_object PAIR = 16
		| manner_object RECORD = 32
		| manner_object STRING = 64
		| manner_object TOTAL = 128

	      fun breakdown_manner [] = 0
		| breakdown_manner (x::xs) =
		  Internal.Bits.orb(manner_object x,breakdown_manner xs)
	    in
	
	      fun make_manner {time, space, copies, calls, depth, breakdown} =
		(if calls then 1 else 0) +
		(if time then 2 else 0) +
		(if space then 4 else 0) +
		(if copies then 8 else 0) +
                   Internal.Bits.lshift(depth,16) +
                   Internal.Bits.lshift(breakdown_manner breakdown, 8)
	    end (* local *)
			
          end (* structure Profile *)

	(*
	structure Char : CHAR =
	  struct
	    open BuiltinLibrary_

	    type char = char
	    val chr = char_chr
	    val ord = char_ord
	    val maxCharOrd = 255

	    (* Finally define these *)
	    val op <  : char * char -> bool = op <
	    val op >  : char * char -> bool = op >
	    val op <= : char * char -> bool = op <=
	    val op >= : char * char -> bool = op >=
	  end
	*)

      end (* structure MLWorks *)

    local
      val exns_initialised =            call_c "exception exns_initialised"
      val SizeExn =                     call_c "exception Size"
      val DivExn =			call_c "exception Div"
      val OverflowExn =			call_c "exception Overflow"
      val ProfileExn =			call_c "exception Profile"
      val SaveExn =			call_c "exception Save"
      val LoadExn =			call_c "exception Load"
      val SignalExn =			call_c "exception Signal"
      val StringToRealExn = 		call_c "exception StringToReal"
      val SubstringExn =		call_c "exception Substring"
      val SysErrExn =                   call_c "exception syserr"
      val TraceExn =			call_c "exception Trace"
      val UnboundExn =			call_c "exception Unbound"
      val ValueExn =			call_c "exception Value"
      val ThreadsExn =                  call_c "exception Threads"
    in
      val _ =
        if !exns_initialised then ()
        else
          (exns_initialised := true;
           SizeExn              := Size;
           DivExn		:= Div;
           LoadExn		:= MLWorks.Internal.Runtime.Loader.Load "";
           OverflowExn		:= Overflow;
           ProfileExn		:= MLWorks.Profile.ProfileError "";
           SaveExn		:= MLWorks.Internal.Save "";
           SignalExn		:= MLWorks.Internal.Runtime.Event.Signal "";
           StringToRealExn	:= MLWorks.Internal.StringToReal;
           SubstringExn		:= MLWorks.String.Substring;
           SysErrExn            := MLWorks.Internal.Error.SysErr ("",MLWorks.Internal.Types.NONE);
           TraceExn		:= MLWorks.Internal.Trace.Trace "";
           UnboundExn		:= MLWorks.Internal.Runtime.Unbound "";
           ValueExn		:= MLWorks.Internal.Value.Value "";
           ThreadsExn           := MLWorks.Threads.Threads "")
    end (* local *)

    (* some more top-level maths functions *)

    val ceil : real -> int = ~ o floor o ~
    val trunc: real -> int = fn x => if x>0.0 then floor x else ceil x
    val round: real -> int = fn x=>
      let
	val near = floor x
	val diff = abs(real near - x)
      in
	if diff < 0.5 then
	  near
	else
	  if diff > 0.5 orelse near mod 2 = 1
	    then near + 1
	  else near
      end


    (* some more top-level string functions *)

    val maxSize = MLWorks.String.maxLen

    fun unsafe_alloc_string (n:int) : string =
      let val alloc_s = alloc_string n
      in
	string_unsafe_update (alloc_s, n-1, 0);
	alloc_s
      end
    fun alloc_string (n:int) : string =
      if n > maxSize then
	raise Size
      else
	unsafe_alloc_string n
	
    fun implode (cl : char list) : string =
      let
	val cl : int list = cast cl
	fun copyall ([],start,to) = to
	  | copyall (c::cl,start,to) =
	  (string_unsafe_update (to,start, c);
	   copyall (cl,start+1,to))
	fun get_size (a::rest,sz) = get_size (rest,1 + sz)
	  | get_size ([],sz) =
	  if sz > 30 then call_c "string c implode char" (cl,sz)
	  else
	    let
	      val result = unsafe_alloc_string (sz+1)
	      (* set the null terminator *)
	      val _ = string_unsafe_update (result,sz,0)
	    in
	      copyall (cl,0,result)
	    end
      in
	get_size (cl,0)
      end

    (*NB concat is old-style string implode*)
    fun concat [] = ""
      | concat xs = call_c "string implode" xs

    fun str (c:char) : string =
      let val alloc_s = unsafe_alloc_string (1+1)
      in
	string_unsafe_update(alloc_s, 0, (cast c):int);
	alloc_s
      end

    fun explode (s:string) : char list =
      let fun aux (i, acc) =
	  if i >= 0 then
	    aux (i-1, (cast (string_unsafe_sub(s, i)):char)::acc)
	  else
	    acc
      in
	aux (size s -1, [])
      end


    fun substring (s, i, n) =
      if i < 0 orelse n < 0 orelse (size s - i) < n then raise Subscript
      else if n <= 12 then
	let
	  val alloc_s = unsafe_alloc_string (n+1)
	  fun copy i' =
	    if i' < 0 then alloc_s
	    else
	      (string_unsafe_update (alloc_s, i', string_unsafe_sub (s, i+i'));
	       copy (i'-1))
	in
	  copy (n-1)
	end
	   else (* n > 12 *)
	     call_c "string unsafe substring" (s, i, n)

    datatype option = datatype MLWorks.Internal.Types.option

    exception Option

    fun isSome (SOME _) = true | isSome _ = false

    fun valOf (SOME x) = x | valOf NONE = raise Option

    fun getOpt (NONE, d) = d
      | getOpt ((SOME x), _) = x

    structure General : GENERAL =
      struct

        open BuiltinLibrary_

        type exn = exn
        type unit = unit

        exception Domain
        exception Fail of string
        exception Empty

        datatype order = LESS | EQUAL | GREATER

        fun exnName e =
          let val full_name = MLWorks.Internal.Value.exn_name e
              fun split [] = []
                | split ("[" :: _) = []
                | split (h :: t) = h :: (split t)
           in implode(split(explode full_name)) end;

        fun exnMessage (MLWorks.Internal.Error.SysErr(s, NONE)) =
                "SysErr: " ^ s
          | exnMessage (MLWorks.Internal.Error.SysErr(s, SOME n)) =
                "SysErr: " ^ (MLWorks.Internal.Error.errorMsg n)
          | exnMessage (Fail s) =
                "Fail: " ^ s
          | exnMessage (MLWorks.Internal.IO.Io {name,function,cause}) =
                "Io: " ^ function ^ " failed on file " ^ name ^ " with "
                ^ exnMessage cause
          | exnMessage e = exnName e


        val (op<>) : ''a * ''a -> bool = (op<>)
        val (op :=) : ('a ref * 'a) -> unit = (op :=)
        val ignore : 'a -> unit = fn (_) => ()

        fun (x before _) = x      (* before is given infix status by
                                     the parser. *)
      end (* structure General *)

    open General

    (* some more top-level list functions *)
	
    fun null [] = true
      | null _ = false

    fun hd [] = raise Empty
      | hd (a::_) = a

    fun tl [] = raise Empty
      | tl (_::a) = a

    fun length l =
      let
	fun loop ([], acc) = acc
	  | loop (_::t, acc) = loop (t, 1+acc)
      in
	loop (l, 0)
      end


    fun app f [] = ()
      | app f (h :: t) = (ignore(f h); app f t)

    fun foldl f i list =
      let
	fun red (acc, []) = acc
	  | red (acc, (x::xs)) = red (f (x, acc), xs)
      in
	red (i, list)
      end


    fun foldr f i list =
      let
	fun red (acc, []) = acc
	  | red (acc, x::xs) = red (f (x,acc), xs)
      in
	red (i, rev list)
      end

    val print = MLWorks.Internal.StandardIO.print
    val vector = MLWorks.Internal.Vector.vector

  end (* structure FullPervasiveLibrary_ *)

open FullPervasiveLibrary_;

