(* _ml_debugger.sml the functor *)
(*
 * $Log: _ml_debugger.sml,v $
 * Revision 1.186  1999/02/02 15:59:08  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.185  1998/04/22  17:12:57  jont
 * [Bug #70099]
 * Modifications to encapsulation format to put type_env first
 *
 * Revision 1.184  1998/04/16  11:01:54  jont
 * [Bug #70058]
 * Add a function to collect the stamps of all submodules when getting
 * type information
 *
 * Revision 1.183  1998/03/31  13:04:37  jont
 * [Bug #70077]
 * Remove use of Path, and replace with OS.Path
 *
 * Revision 1.182  1998/03/23  14:36:31  jont
 * [Bug #30090]
 * Remove use of MLWorks.IO
 *
 * Revision 1.181  1998/03/02  15:07:22  mitchell
 * [Bug #70074]
 * Add depth limit support for signature printing
 *
 * Revision 1.180  1998/02/19  20:16:47  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.179  1998/02/18  16:55:25  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.178  1998/02/10  16:01:52  jont
 * [Bug #70065]
 * Remove uses of MLWorks.IO.messages and use the Messages structure
 *
 * Revision 1.177  1998/02/05  12:11:08  jont
 * [Bug #30331]
 * Modify to use Encapsulate.input_debug_info
 *
 * Revision 1.176  1997/11/25  10:43:26  jont
 * [Bug #30328]
 * Add environment parameter to decode_type_basis
 * for finding pervasive type names
 *
 * Revision 1.175  1997/11/10  16:58:35  jont
 * [Bug #30320]
 * Swap effects of < and > around
 *
 * Revision 1.174  1997/09/18  14:36:41  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.173  1997/07/21  16:47:26  jont
 * [Bug #30201]
 * Remove Unix-ism "Fatal Unix signal" and replace
 * with "Fatal OS signal"
 *
 * Revision 1.172  1997/05/21  17:02:51  jont
 * [Bug #30090]
 * Replace MLWorks.IO with TextIO where applicable
 *
 * Revision 1.171  1997/05/02  17:06:02  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.170  1997/03/21  15:43:26  matthew
 * Adding catchall handlers around print function
 *
 * Revision 1.169  1997/03/20  14:50:05  stephenb
 * [Bug #1822]
 * make_frame_details: introduce a Stack_Interface.variable_debug_frame
 * call at an appropriate point ensure that details of the correct
 * frame are displayed.
 *
 * Revision 1.168  1997/03/07  16:43:08  matthew
 * Don't exit with do_quit if use_debugger is false
 *
 * Revision 1.167  1996/12/18  14:24:52  stephenb
 * [Bug #1786]
 * do_continue: add a raise Exit in the FUN case so that the debugger loop
 * is exited.
 *
 * Revision 1.166  1996/11/07  17:27:53  stephenb
 * [Bug #1461]
 * Change to stack closure tags.
 *
 * Revision 1.165  1996/11/07  14:33:56  stephenb
 * [Bug #1441]
 * Change from using word to byte offsets for annotation indices.
 * This is necessary because the instructions on an I386 are not
 * word aligned as they are on a SPARC/MIPS.
 *
 * Revision 1.164  1996/11/06  11:23:09  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.163  1996/10/31  14:09:40  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.162  1996/09/27  12:40:40  stephenb
 * As discussed in mlworks.mail.{8075,8081,8086}, display
 * a message when about to and just after scanning the stack
 * when entering the debugger.
 *
 * Revision 1.161  1996/08/06  14:47:21  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml
 *
 * Revision 1.160  1996/08/01  12:49:18  jont
 * [Bug #1503]
 * Ensure no arg acquired if there isn't one saved
 *
 * Revision 1.159  1996/06/27  14:37:08  stephenb
 * Fix #1437 - NT: stack browser frame hiding doesn't work properly
 *
 * Revision 1.158  1996/06/19  10:41:31  stephenb
 * Fix #1423 - duplicate anonymous frames not hidden correctly.
 *
 * Revision 1.157  1996/06/17  15:37:54  stephenb
 * with_start_frame: Fix so that it does not unconditionally turn off
 * stepping, rather it sets it to what it was before with_start_frame
 * was run.
 *
 * Revision 1.156  1996/05/30  13:09:08  daveb
 * The Io exception is no longer at top level.
 *
 * Revision 1.155  1996/05/21  11:12:28  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.154  1996/05/17  09:58:11  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.153  1996/05/01  10:16:56  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.152  1996/04/29  15:04:24  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.151  1996/04/23  11:36:14  daveb
 * Made debug_print local to the debug functions, and removed a call to it
 * that should have used one of the other debug functions.
 *
 * Revision 1.150  1996/04/18  15:17:50  jont
 * initbasis moves to basis
 *
 * Revision 1.149  1996/04/15  12:06:34  stephenb
 * Rename Os -> OS to conform with latest basis revision.
 *
 * Revision 1.148  1996/04/15  10:27:34  stephenb
 * output_frame_details: restore to its original behaviour of outputting
 * a newline after the frame details.
 *
 * Revision 1.147  1996/04/04  13:31:13  stephenb
 * Lift out some of the functions in ml_debugger so that it is
 * easier to follow what is going on.
 *
 * Revision 1.146  1996/04/01  12:54:31  stephenb
 * Replace Path/PATH by Os.Path/OS_PATH
 *
 * Revision 1.145  1996/03/15  12:08:56  stephenb
 * Fix so that if the user keeps stepping right through until the MLWorks
 * prompt is reached (i.e. the user does not explicitly continue or quit),
 * stepping is not left on.
 *
 * Revision 1.144  1996/03/05  14:21:37  stephenb
 * Fix the frame filtering mechanism so that it doesn't drop
 * the top frame if it is a delivered frame.
 *
 * Revision 1.143  1996/02/29  15:11:46  stephenb
 * Modify the tty->gui interface so that the gui debugger knows
 * which frame to apply Trace.next to.
 * Modified the tty frame movement commands so that they deal gracefully
 * with the case where there are no visible ML frames (I didn't
 * consider this case when I originally wrote the code since it cannot
 * occur if the debugger is entered due to a breakpoint).
 * Removed an unused function from inside _ml_debugger.
 *
 * Revision 1.142  1996/02/28  12:18:02  stephenb
 * Re-implement the frame hiding stuff so that hiding/revealing a frame
 * does not lose the user's position in the backtrace.
 *
 * Revision 1.141  1996/02/27  11:27:45  stephenb
 * Simplified the mapping between frame type names and the frame hiding flags.
 * Added some more comments.
 *
 * Revision 1.140  1996/02/26  14:02:18  stephenb
 * Unify control of hiding and revealing frames in the tty&gui debuggers.
 *
 * Revision 1.139  1996/02/23  16:30:32  stephenb
 * Rewrite frame hiding so that it supports the same sort of
 * features as the gui debugger.
 *
 * Revision 1.138  1996/02/22  14:43:39  jont
 * Replacing Map with NewMap
 *
 * Revision 1.137  1996/02/22  14:29:28  stephenb
 * Fix so that frames created as a result of a breakpoint/step/trace
 * are not visible to the user.
 * This doesn't have any of the fancy options that the gui version does.
 * Hopefully this and the gui version will converge in the near future.
 *
 * Revision 1.136  1996/02/21  11:22:32  stephenb
 * Fix so that the 5th frame is displayed if the debugger has
 * been invoked due to stepping or breakpointing but the top
 * frame is displayed otherwise.
 *
 * Revision 1.135  1996/02/20  09:34:49  stephenb
 * Add an extra (impossible) branch to a case to keep the compiler
 * from warning about non-exhaustive patterns.
 *
 * Revision 1.134  1996/02/19  11:20:47  stephenb
 * Updated wrt Trace.step_status -> Trace.stepping name change and wrt
 * the changes in the implementation of step/breakpoint which mean that
 * the function to break/step is not the top frame any more!  Instead it
 * is the second ML frame (empirically determined to be the the 4th frame
 * from top on the stack).
 *
 * Revision 1.133  1996/02/05  12:34:35  stephenb
 * Add "breakpoints" command to tty debugger.
 * Modify "ignore" command so that it more closely resembles the gdb command.
 *
 * Revision 1.132  1996/02/01  16:30:15  stephenb
 * Add the ignore command description to the help info.
 *
 * Revision 1.131  1996/02/01  16:01:54  stephenb
 * Added the "ignore" command which allows the next n hits on a
 * breakpoint to be skipped.
 *
 * Revision 1.130  1996/01/25  15:39:57  matthew
 * Need to raise Exit occasionally to exit the debugger
 *
 * Revision 1.129  1996/01/15  17:03:04  stephenb
 * Fix the continue action so that if the action is not possible, it
 * does not drop out of the debugger back to MLWorks.
 *
 * Revision 1.128  1996/01/08  16:29:55  nickb
 * Change SIGNAL to INTERRUPT (interrupts aren't signals on Windows).
 *
 * Revision 1.127  1996/01/05  16:20:41  matthew
 * Fixing bungle with step mode
 *
 * Revision 1.126  1995/12/18  16:36:44  jont
 * Remove debugging print stuff
 *
 * Revision 1.125  1995/12/11  14:27:16  jont
 * Add counting of break points, and continuing multiple times
 *
 * Revision 1.124  1995/11/17  16:41:26  jont
 * General improvements to debug inference of types in stack backtraces,
 * particularly for local variable debugging
 *
Revision 1.123  1995/10/26  10:23:54  nickb
Fix frames seen by the debugger when tracing.

Revision 1.122  1995/10/20  10:32:19  daveb
Renamed ShellUtils.edit_string to ShellUtils.edit_source
(and ShellUtils.edit_source to ShellUtils.edit_location).

Revision 1.121  1995/10/17  13:58:36  matthew
Renaming trace functions

Revision 1.120  1995/09/21  11:04:38  matthew
Suppressing display of C frames

Revision 1.119  1995/09/12  12:21:47  matthew
Improving messages

Revision 1.118  1995/09/08  12:16:33  jont
Add location imformation to exception names when printed

Revision 1.117  1995/08/31  15:16:47  matthew
Changing behaviour for empty list of frames

Revision 1.116  1995/08/02  13:57:00  daveb
If the use_debugger preference is not set, make the debugger function do a
quit option instead of a normal return.

Revision 1.115  1995/06/20  13:53:24  daveb
Fixed mistake in my last change: the tty debugger wasn't printing the
reason that the debugger was invoked.

Revision 1.114  1995/06/15  14:46:18  daveb
Made the debugger use the message function from the debugger type
info to print the message when use_debugger is false or the stack is empty.

Revision 1.113  1995/06/14  14:25:58  daveb
Made use of debugger depend on preference setting.
Removed redundant parameters from ml_debugger, added a message_fn
parameter, and removed unnecessary currying.

Revision 1.112  1995/06/02  14:10:32  nickb
Add fatal signals.

Revision 1.111  1995/06/01  11:37:01  matthew
Cleaning up tty interface

Revision 1.110  1995/05/10  11:09:54  matthew
Removed old step & breakpoint stuff
Removed script parameter to ml_debugger

Revision 1.109  1995/04/24  12:41:06  matthew
General cosmetic improvements

Revision 1.108  1995/04/20  19:15:32  daveb
filesys and path moved from utils to initbasis.

Revision 1.107  1995/04/20  13:57:41  jont
Change type of decode_type_basis to take a btree

Revision 1.106  1995/04/11  14:38:45  matthew
New stepping and breakpointing stuff

Revision 1.105  1995/03/28  15:25:46  matthew
More stuff

Revision 1.104  1995/03/10  16:38:11  matthew
Making debugger platform independent

Revision 1.103  1995/03/06  12:08:37  daveb
New path functions.

Revision 1.102  1995/03/01  15:38:58  matthew
Various changes
Addition of simple trace functions to tty debugger
Improvements to backtrace stuff
etc. etc.

Revision 1.101  1995/02/01  16:10:42  matthew
Debugger changes

Revision 1.100  1995/01/30  12:47:30  matthew
Renaming debugger_env to runtime_env
Various simplifications etc,

Revision 1.99  1995/01/27  14:14:12  daveb
Replaced hacky file name operations with Path functions.

Revision 1.97  1994/12/06  10:24:40  matthew
Changing uses of cast.

Revision 1.96  1994/10/13  15:42:09  matthew
Make NewMap return pervasive option

Revision 1.95  1994/09/21  15:18:47  matthew
Abstraction of debug information

Revision 1.94  1994/08/01  09:20:09  daveb
Moved preferences out of Options structure.

Revision 1.93  1994/06/23  10:26:30  jont
Update debugger information production

Revision 1.92  1994/06/20  09:37:31  daveb
Replaced context_ref with context.

Revision 1.91  1994/06/09  15:49:20  nickh
\nNew runtime directory structure.

Revision 1.90  1994/06/09  09:44:29  nosa
Breakpoint settings on function exits;
altered filename formation in decapsulation of debugger environments.

Revision 1.89  1994/02/28  09:46:45  nosa
Step and Breakpoints Debugger;
Type basis decapsulation facility for Monomorphic debugger;
Few changes to the debugger command line parser.

Revision 1.88  1994/02/23  17:40:01  matthew
Modifying loop

Revision 1.87  1994/02/02  12:23:36  daveb
CHanged substructure of InterMake.

Revision 1.86  1993/12/22  15:18:20  daveb
The tty debugger was printing the wrong frame.

Revision 1.85  1993/12/17  17:03:33  matthew
Ignore stack extension frames in type inference

Revision 1.84  1993/12/09  19:27:26  jont
Added copyright message

Revision 1.83  1993/12/01  18:12:04  matthew
Made make_frame_string tail recursive.

Revision 1.82  1993/11/23  12:02:28  daveb
Removed with_frame_wrap.  Changed type of with_start_frame so that callers
don't have to provide a frame.  Changed several details of presentation to
make the TTY debugger more friendly.  Removed extraneous frames from list
of frames perused by debugger.  Coding in the number of frames to remove
is a gross hack, but I couldn't get anything else to work.

Revision 1.81  1993/10/12  16:23:15  matthew
Merging bug fixes

Revision 1.80  1993/09/06  15:51:36  nosa
Polymorphic debugger.

Revision 1.79  1993/09/02  17:08:03  matthew
Merging in bug fixes

Revision 1.78.1.3  1993/10/12  14:30:34  matthew
Added STACK_OVERFLOW parameter type
Changed the debugger entry message to be more informative

Revision 1.78.1.2  1993/09/02  13:58:06  matthew
Get the debug_info using the global access function InterMake.current_debug_information

Revision 1.78  1993/08/25  15:02:10  matthew
Return quit function from ShellUtils.edit_string

Revision 1.77  1993/08/24  13:46:29  matthew
 Tidied up edit failure messages.
Back traces now include current frame

Revision 1.76  1993/08/17  18:13:03  daveb
Removed Io structure.

Revision 1.75  1993/08/06  14:24:32  nosa
Inspector invocation in debugger-window on values of local
and closure variables.

Revision 1.74  1993/08/04  15:06:30  nosa
Changes for ShowFrameInfo option in debugger window.

Revision 1.73  1993/08/03  09:22:49  nosa
Improved frame relative naming.

Revision 1.72  1993/07/30  13:32:06  nosa
Debugger Environments for local and closure variable inspection
in the debugger;
enhanced debugger commands.

Revision 1.71  1993/06/17  10:52:06  matthew
Improved frame filtering

Revision 1.70  1993/06/11  13:16:16  matthew
Added function continuation

Revision 1.69  1993/05/28  16:39:24  matthew
Added window_debugger option
Added tty_ok option to WINDOWING

Revision 1.68  1993/05/24  15:27:56  matthew
Fixed problem with previous frame in tty debugger

Revision 1.67  1993/05/18  13:56:26  jont
Removed integer parameter

Revision 1.66  1993/05/12  15:21:00  matthew
 Added message function to Windowing debugger
Added with_start_frame

Revision 1.65  1993/05/10  15:35:42  daveb
Changed argument of ml_debugger from Incremental.options to Options.options.
Removed lots of commented out code.

Revision 1.64  1993/05/07  17:20:44  matthew
Partial implementation of frame selection in tty debugger
Added quit and continue options to windowing debugger.

Revision 1.63  1993/05/06  13:00:32  matthew
Removed printer descriptors.

Revision 1.62  1993/04/30  15:49:09  matthew
Changed edit function interface

Revision 1.61  1993/04/29  15:10:40  matthew
Changed do_my_debug to false

Revision 1.60  1993/04/29  14:31:29  matthew
Rewritten

Revision 1.59  1993/04/26  17:25:23  matthew
Much diddling.

Revision 1.58  1993/04/02  13:56:33  matthew
 Signature changes

Revision 1.57  1993/03/30  11:51:00  matthew
Removed current module parameter from ml_debugger
Fixed "bv" so as not to change the frame stack

Revision 1.56  1993/03/25  18:17:19  matthew
Added call to flush_out on prompting

Revision 1.55  1993/03/11  13:55:02  matthew
Simplified interface to debugger
Signature revisions

Revision 1.54  1993/03/08  16:03:41  matthew
Options & Info changes
Incremental changes
Absyn changes

Revision 1.53  1993/03/03  09:57:01  matthew
empty_rec_type to empty_rectype

Revision 1.52  1993/02/23  16:46:39  matthew
Added break option and changed debugger message.

Revision 1.51  1993/02/09  11:21:21  matthew
Typechecker structure changes

Revision 1.50  1993/02/04  17:59:34  matthew
Changed functor parameter

Revision 1.49  1992/12/18  12:10:20  clive
We also pass the current module forward

Revision 1.48  1992/12/17  11:46:04  clive
Changed debug info to have only module name - needed to pass module table through to window stuff

Revision 1.47  1992/12/15  17:16:09  clive
Keep the backtrace short

Revision 1.46  1992/12/10  15:38:15  clive
Removed a lot of unnecessary handlers

Revision 1.44  1992/12/09  14:53:52  clive
Two bugs fixes and propagation of changes lower down

Revision 1.43  1992/12/07  17:17:28  clive
Fixed a bug when tracing

Revision 1.42  1992/12/01  09:46:09  clive
Debugger now takes a print descriptor

Revision 1.41  1992/11/27  18:34:52  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.40  1992/11/23  15:06:54  clive
Fixed a bug in tracing
Changed the option 'c' to 'q' and added another 'c'

Revision 1.39  1992/11/20  16:48:35  jont
Modified the sharing equations slightly

Revision 1.38  1992/11/19  15:35:58  matthew
Tidied up debugger loop.

Revision 1.37  1992/11/17  14:20:42  matthew
Changed Error structure to Info

Revision 1.36  1992/11/16  16:21:48  clive
Added extra info for the frames whose types have not been deduced yet

Revision 1.35  1992/11/16  14:17:21  clive
Added polymorphic tracing

Revision 1.34  1992/11/12  16:53:39  clive
Added tracing again

Revision 1.33  1992/11/10  12:04:30  clive
Added a handle for substring and changed the help message

Revision 1.32  1992/11/05  18:17:27  richard
Stripped out tracing code.  Many changes concerning
changes to pervasives.  Needs seeing to.

Revision 1.31  1992/10/27  11:15:59  clive
Took out trace and added binding of frame arguments to it

Revision 1.30  1992/10/14  08:54:15  clive
Changes for windowing listener

Revision 1.29  1992/10/12  14:20:18  clive
Tynames now have a slot recording their definition point

Revision 1.28  1992/10/08  10:54:43  clive
Changes for the use of new shell

Revision 1.27  1992/10/05  14:58:02  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.26  1992/09/10  14:42:44  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.25  1992/09/09  16:12:18  clive
Added switches t the value-printer to control depth of printing etc

Revision 1.24  1992/09/03  09:12:40  clive
Added functionality to the value_printer

Revision 1.23  1992/09/01  17:44:13  clive
Small fix to :n fred

Revision 1.22  1992/08/28  16:03:50  clive
Used get_code_object_debug_info in the trace code

Revision 1.21  1992/08/27  17:01:53  clive
Neatened up the output a bit

Revision 1.20  1992/08/26  18:59:19  richard
Rationalisation of the MLWorks structure.

Revision 1.19  1992/08/26  18:50:53  jont
Removed some redundant structures and sharing

Revision 1.18  1992/08/26  17:14:10  clive
Fixed a few bugs and added binding of frame arguments to it

Revision 1.17  1992/08/24  15:46:59  clive
Added details about leafness to the debug information

Revision 1.16  1992/08/21  16:36:02  clive
Added a loop inside the debugger

Revision 1.15  1992/08/19  13:27:06  clive
Added untrace

Revision 1.14  1992/08/19  10:44:45  clive
Changed to reflect changes to pervasive_library

Revision 1.13  1992/08/18  11:49:21  clive
Various improvements

Revision 1.12  1992/08/14  15:11:29  clive
Corrected a few errors

Revision 1.11  1992/08/13  15:54:57  clive
Neatening up, plus changes due to lower level sharing changes

Revision 1.10  1992/08/11  15:05:36  clive
More improvements

Revision 1.8  1992/08/07  15:38:06  clive
Working monomorphic version of trace

Revision 1.5  1992/07/17  08:32:01  clive
More work on the debugger

Revision 1.4  1992/07/16  16:18:25  clive
Made the debugger work better, and changes for the new interface to the runtime system

Revision 1.3  1992/07/13  15:34:05  clive
Support for interpreter

Revision 1.2  1992/06/22  16:27:21  clive
get_next_frame only returns two arguments - the third exnp is no longer required

Revision 1.1  1992/06/22  16:07:39  clive
Initial revision

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
*)

require "$.basis.__int";
require "$.basis.__text_io";
require "$.basis.__string";

require "^.utils.lists";
require "^.utils.crash";
require "^.utils.__messages";
require "^.utils.__terminal";
require "^.basics.module_id";
require "^.basics.location";
require "^.basis.os_path";
require "^.main.encapsulate";
require "^.main.preferences";
require "^.main.project";
require "^.typechecker.types";
require "^.interpreter.incremental";
require "^.interpreter.shell_utils";
require "^.rts.gen.tags";
require "debugger_print";
require "^.main.stack_interface";
require "debugger_utilities";
require "value_printer";
require "newtrace";
require "stack_frame";
require "ml_debugger";

functor Ml_Debugger(
  structure Lists : LISTS
  structure Crash : CRASH
  structure Path : OS_PATH
  structure Encapsulate : ENCAPSULATE
  structure Preferences : PREFERENCES
  structure Project : PROJECT
  structure ModuleId : MODULE_ID
  structure Location : LOCATION
  structure Types : TYPES
  structure Incremental : INCREMENTAL
  structure ShellUtils : SHELL_UTILS
  structure ValuePrinter : VALUE_PRINTER
  structure StackInterface : STACK_INTERFACE
  structure DebuggerUtilities : DEBUGGER_UTILITIES
  structure Tags : TAGS
  structure DebuggerPrint : DEBUGGER_PRINT
  structure Trace : TRACE
  structure StackFrame : STACK_FRAME

  sharing DebuggerPrint.Options = DebuggerUtilities.Options =
          ShellUtils.Options = Types.Options = ValuePrinter.Options =
          Incremental.InterMake.Inter_EnvTypes.Options

  sharing DebuggerUtilities.Debugger_Types = Encapsulate.Debugger_Types
  sharing DebuggerUtilities.Debugger_Types.Options = DebuggerPrint.Options
  sharing Incremental.Datatypes = Types.Datatypes
  sharing DebuggerPrint.RuntimeEnv = DebuggerUtilities.Debugger_Types.RuntimeEnv
  sharing Types.Datatypes.NewMap = Encapsulate.ParserEnv.Map
  sharing Encapsulate.BasisTypes.Datatypes = Types.Datatypes

  sharing type Incremental.Context = ShellUtils.Context
  sharing type DebuggerUtilities.Debugger_Types.information =
    ValuePrinter.DebugInformation = Incremental.InterMake.Compiler.DebugInformation
  sharing type Types.Datatypes.Type = DebuggerUtilities.Debugger_Types.Type =
    ValuePrinter.Type
  sharing type (* GetTypeInformation.TypeBasis = *) ValuePrinter.TypeBasis =
    Incremental.InterMake.Compiler.TypeBasis
  sharing type DebuggerUtilities.Debugger_Types.Type = DebuggerPrint.RuntimeEnv.Type
  sharing type Preferences.preferences = ShellUtils.preferences
  sharing type ModuleId.Location = Location.T
  sharing type Project.ModuleId = ModuleId.ModuleId
  sharing type Project.Project = Incremental.InterMake.Project
    ) : ML_DEBUGGER =

  struct

    structure Incremental = Incremental
    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Debugger_Types = DebuggerUtilities.Debugger_Types
    structure InterMake = Incremental.InterMake
    structure Info = InterMake.Compiler.Info
    structure ValuePrinter = ValuePrinter
    structure Options = DebuggerPrint.Options
    structure RuntimeEnv = DebuggerPrint.RuntimeEnv

    datatype ('a, 'b)union = INL of 'a | INR of 'b

    type preferences = Preferences.preferences

    local
      fun debug_print s = Terminal.output("  # " ^ s ^ "\n")
    in
      val do_debug = false

      (* For multiple line output *)
      fun debugl f =
        if do_debug then
          app debug_print (f ())
        else ()
  
      fun debug f = if do_debug then debug_print (f ()) else ()
      fun ddebug f = debug_print (f ())
    end

    fun assoc (a,[]) = NONE
      | assoc (a,(a',b)::rest) =
        if a = a' then SOME b
        else assoc (a,rest)


    (* This should be replaced by List.take if and when Lists is replaced
       by the basis List *)
    fun firstn (l,n) =
      if n < 0 then []
      else
        let
          fun aux (_,0,acc) = rev acc
            | aux ([],n,_) = l
            | aux (a::b,n,acc) = aux (b,n-1,a::acc)
        in
          aux (l,n,[])
        end


    val cast : 'a -> 'b = MLWorks.Internal.Value.cast

    val empty_map = NewMap.empty' (op < : string * string -> bool)

    (* Some utilities *)


    (* Display a message in the shell or podium if in the GUI.
     * The output is flushed after the message is displayed to 
     * ensure that the output appears even if it is not terminated
     * with a newline.
     *)
    fun outputMessage (message:string):unit =
      (Messages.output message;
       Messages.flush())



(* 
 This works on exploded strings 
    fun substring (str1,str2) =
      let
        fun tl [] = []
          | tl (a::b) = b
        fun substring ([],_,_) = true
          | substring (_,[],_) = false
          | substring (x::xs,y::ys,yys) =
            if x = y
              then substring (xs,ys,yys)
            else substring(str1,yys,tl yys)
      in
        substring (str1,str2,tl str2)
      end
*)

    (* This should use some Location function *)
    fun location_source_file locdata =
      let
        fun aux1(#":"::l,acc) = implode (rev acc)
          | aux1(c::l,acc) = aux1(l,c::acc)
          | aux1([],acc) = implode (rev acc)
      in
        aux1(explode locdata,[])
      end

    fun get_data_from_frame frame =
      let
        fun get_name_and_location code_name =
          let
            fun duff () = debug (fn _ => "Odd codename:"^code_name^":")
            fun aux1( #"[" ::l,acc) = (acc,l)
              | aux1(c::l,acc) = aux1(l,c::acc)
              | aux1([],acc) = (duff();(acc,[]))
            fun aux2([ #"]" ],acc) = (acc,nil)
              | aux2( #"]" ::l,acc) = (duff();(acc,l))
              | aux2(c::l,acc) = aux2(l,c::acc)
              | aux2([],acc) = (duff();(acc,nil))
            val (namechars,rest) = aux1(explode code_name,[])
            val (locchars,fnname) = aux2 (rest,[])
          in
            (implode(rev namechars),(implode(rev locchars),implode fnname))
          end
        val name_string = StackInterface.frame_name frame
      in
        (get_name_and_location name_string,name_string)
      end

    (* DIAGNOSTIC FUNCTIONS *)

    fun get_arg_type(Datatypes.METATYVAR(ref(_,object,_),_,_)) = get_arg_type object
      | get_arg_type(Datatypes.FUNTYPE (arg,_)) = arg
      | get_arg_type x = Datatypes.NULLTYPE

    fun get_res_type(Datatypes.METATYVAR(ref(_,object,_),_,_)) = get_res_type object
      | get_res_type(Datatypes.FUNTYPE (_,res)) = res
      | get_res_type x = Datatypes.NULLTYPE

    exception FailedToGetTypeInfo

    (* Cache away any file information that is recorded *)
    exception CacheFail
    val size_of_data_cache = ref(7)
    val data_cache = ref([] : (string * Debugger_Types.information) list)
    fun cache_lookup file =
      let
        fun cache_lookup(x,[]) =
          (debug (fn _ => file ^ " not found in cache") ;
           raise CacheFail)
          | cache_lookup(x,(elem as (h,t))::rest) =
            if x=h
              then (debug (fn _ => file ^ " found in cache");
                    (t,rest))
            else
              let
                val (a,b) = cache_lookup(x,rest)
              in
                (a,elem::b)
              end
        val (result,rest) = cache_lookup(file,!data_cache)
        val _ = data_cache := (file,result) :: rest
      in
        result
      end

    fun add_to_cache x = data_cache := x :: !data_cache

    fun initialise_cache () = data_cache := nil

    val stamp_map =
      ref empty_map : (string, (string * int * int))NewMap.map ref

    fun update_stamp_map project =
      let
	fun update_stamp_map' id =
	  let
	    val name = ModuleId.string id
	  in
	    case NewMap.tryApply'(!stamp_map, name) of
	      SOME _ => ()
	    | NONE =>
		let
		  val requires =
		    if name = " __pervasive_library" then
		      []
		    else
		      Project.get_requires(project, id)
		      (* This can raise an exception not in its signature *)
		in
		  case Project.get_object_info(project, id) of
		    SOME{stamps, ...} =>
		      (stamp_map :=
		       NewMap.define(!stamp_map, name, (name, stamps, 0));
		       Lists.iterate
		       update_stamp_map'
		       requires)
		    | _ => ()
		end
	      handle _ => ()
	  end
      in
	update_stamp_map'
      end

    fun get_type_information (options,debug_info,((function_name,loc),name_string)) =
      let
        val source_file = location_source_file loc
      in
        case Debugger_Types.lookup_debug_info (debug_info,name_string) of
          SOME funinfo =>
            (funinfo,source_file)
	| _ =>
	    (* This needs to be thought about a little *)
	    (let
	       val file = Path.base source_file
	       val file_debug_info =
		 if Lists.member(file,["","__pervasive_library","__builtin_library"]) then
		   Debugger_Types.empty_information
		 else
		   cache_lookup file
		   handle CacheFail =>
		     (let
			val project = Incremental.get_project()
			val base = Path.base(Path.file source_file)
			val information =
			  case ModuleId.from_string' base of
			    SOME id =>
			      let
				val _ = update_stamp_map project id
				val _ = update_stamp_map
				  project
				  (ModuleId.perv_from_string
				   ("__pervasive_library",
				    Location.FILE"<debugger>"))
				val information =
				  case Project.get_object_info(project, id) of
				    SOME{file, ...} =>
				      let
					val information =
					  Encapsulate.input_debug_info
					  {file_name=file,
					   sub_modules= !stamp_map}
				      in
					information
				      end
				  | _ => Debugger_Types.empty_information
			      in
				information
			      end
			  | _ => Debugger_Types.empty_information
		      in
			add_to_cache (file,information);
			information
		      end
			handle Encapsulate.BadInput msg =>
			  (debug (fn _ =>
				  "Decapsulation failed for function " ^
				  function_name ^ ": " ^ file ^ ":" ^ msg);
			   let
			     val information = Debugger_Types.empty_information
			   in
			     (add_to_cache (file,information); information)
			   end))
	     in
	       case Debugger_Types.lookup_debug_info (file_debug_info, name_string) of
		 SOME funinfo => (funinfo,source_file)
	       | _ => raise FailedToGetTypeInfo
	     end)
      end

    local
      (* The name "part_of_a_frame" is not terribly helpful, but it's
       * still easier to read the debugger_window type now that I've
       * separated out it's components.  This type probably corresponds
       * to the info about a local variable, but I wouldn't bet on it. *)
      type part_of_a_frame =
        (string
         * (ValuePrinter.Type * MLWorks.Internal.Value.ml_value * string)
         ) list

      type frame_details =
        string
        * string
        * (ValuePrinter.Type * MLWorks.Internal.Value.ml_value * string)
        * (unit -> string * part_of_a_frame,
           string * part_of_a_frame)
        union ref option

      type frame = {name : string, loc : string, details: frame_details}
    in
      type debugger_window =
        {parameter_details: string,
         frames: frame list,
         quit_fn: (unit -> unit) option,
         continue_fn: (unit -> unit) option,
         top_ml_user_frame: MLWorks.Internal.Value.Frame.frame option}
        -> unit
    end

    datatype TypeOfDebugger =
      WINDOWING of debugger_window * (string -> unit) * bool
      | TERMINAL

    datatype parameter =
      INTERRUPT |
      FATAL_SIGNAL of int |
      EXCEPTION of exn |
      BREAK of string |
      STACK_OVERFLOW

    datatype Continuation_action =
      NORMAL_RETURN |
      DO_RAISE of exn |
      FUN of (unit -> unit)

    datatype Continuation =
      POSSIBLE of string * Continuation_action |
      NOT_POSSIBLE

    datatype FrameInfo =
      FRAMEINFO of
      Datatypes.Type * Debugger_Types.Backend_Annotation
      * RuntimeEnv.RuntimeEnv * Datatypes.Type ref |
      NOFRAMEINFO

    datatype FrameSpec =
      MLFRAME of
      MLWorks.Internal.Value.Frame.frame *
      ((string * (string * string)) * string) *
      MLWorks.Internal.Value.T option*
      FrameInfo |
      CFRAME of (MLWorks.Internal.Value.Frame.frame * string)

    fun make_continuation_function (POSSIBLE (_,NORMAL_RETURN)) =
        SOME (fn _ => ())
      | make_continuation_function (POSSIBLE (_,DO_RAISE exn)) =
        SOME (fn _ => raise exn)
      | make_continuation_function (POSSIBLE (_,FUN f)) =
        SOME f
      | make_continuation_function NOT_POSSIBLE =
        NONE

    (* need to ensure that this is the latest stuff *)

    fun get_interpreter_information () = InterMake.current_debug_information ()

    (* Incremental.debug_info context *)

    (* Note that offset is a _byte_ count (it used to be a _word_ count) *)

    fun get_frame_details options (frame,offset,is_ml) =
      if is_ml then
        let
          val debug_info as ((name,(loc,_)),name_str) = get_data_from_frame frame
          val (info, arg) =
            let
              val (Debugger_Types.FUNINFO {ty,is_leaf,has_saved_arg,annotations,runtime_env,...},
                   source_file) =
                get_type_information (options,
                                      get_interpreter_information(),
                                      ((name,loc),name_str))
              val arg_type = get_arg_type ty
              val _ = debug (fn _ => "Getting info for " ^ name ^ ", offset: " ^ Int.toString (offset))
              val current_annotation =
                case assoc (offset, annotations) of
                  SOME a => a
                | _ =>
                    let
                      val string =
                        ("No annotation for offset " ^
                         Int.toString offset ^ " for " ^ name)
                    in
                      ignore(Debugger_Types.ERROR string);
                      Debugger_Types.NOP
                    end
              val _ = debug (fn _ => "Annotation: " ^ Debugger_Types.print_backend_annotation options current_annotation)
            in
              (FRAMEINFO(arg_type,current_annotation,runtime_env,
			 ref Datatypes.NULLTYPE),
	       if has_saved_arg then
		 SOME (StackInterface.frame_arg frame)
	       else
		 NONE)
            end
          handle FailedToGetTypeInfo => (NOFRAMEINFO, NONE)
        in
          MLFRAME(frame,debug_info,arg,info)
        end
      else
        let
          val closure_bits = MLWorks.Internal.Bits.lshift(MLWorks.Internal.Value.cast (StackInterface.frame_closure frame),2)
          fun clos_type n =
            if n = Tags.STACK_START then "start"
            else if n = Tags.STACK_EXTENSION then "extension"
            else if n = Tags.STACK_DISTURB_EVENT then "disturb event"
            else if n = Tags.STACK_EXTENSION then "extension"
            else if n = Tags.STACK_RAISE then "raise"
            else if n = Tags.STACK_EVENT then "event"
            else if n = Tags.STACK_C_RAISE then "c raise"
            else if n = Tags.STACK_C_CALL then "c call"
            else if n = Tags.STACK_INTERCEPT then "intercept"
            else if n = Tags.STACK_SPACE_PROFILE then "space profile"
            else "unknown closure "^(Int.toString n)
        in
          CFRAME(frame, clos_type (closure_bits))
        end

    fun type_list_to_rectype ty_list =
      let
        val (numbered_list, _) =
          Lists.number_from_by_one
          (ty_list, 1,
           fn i => Datatypes.Ident.LAB(Datatypes.Ident.Symbol.find_symbol
                                       (Int.toString i)))
      in
        Datatypes.RECTYPE
        (Lists.reducel
         (fn (map, (ty, lab)) => NewMap.define'(map, (lab, ty)))
         (NewMap.empty' Datatypes.Ident.lab_lt, numbered_list))
      end

    fun make_partial_map(poly_type, mono_type, partial_map) =
      let
        val poly_type = DebuggerUtilities.slim_down_a_type poly_type
        val mono_type = DebuggerUtilities.slim_down_a_type mono_type
      in
        make_map(poly_type, mono_type, partial_map)
      end

    and make_map(Datatypes.METATYVAR(r as ref (_, ty, _), _, _),
                 mono_type, partial_map) =
      (case ty of
         Datatypes.NULLTYPE => (r, mono_type) :: partial_map
       | _ => make_map(ty, mono_type, partial_map))
      | make_map(Datatypes.META_OVERLOADED{1=ref ty, ...}, mono_type, partial_map) =
        make_map(ty, mono_type, partial_map)
      | make_map(ty as Datatypes.TYVAR _, mono_type, partial_map) =
        partial_map (* Can't do anything with this I think *)
      | make_map(Datatypes.METARECTYPE(ref {3=ty, ...}), mono_type, partial_map) =
        make_map(ty, mono_type, partial_map)
      | make_map(Datatypes.RECTYPE mapping, mono_type, partial_map) =
        (case mono_type of
           Datatypes.RECTYPE mapping' =>
             Lists.reducel
             (fn (map, ((_, ty1), (_, ty2))) =>
              make_map(ty1, ty2, map))
             (partial_map, Lists.zip(NewMap.to_list_ordered mapping,
                                     NewMap.to_list_ordered mapping'))
         | _ => partial_map (* Can't deal with this any more *))
      | make_map(Datatypes.FUNTYPE(ty, ty'), mono_type, partial_map) =
        (case mono_type of
           Datatypes.FUNTYPE(ty'', ty''') =>
             make_map(ty', ty'', make_map(ty, ty'', partial_map))
         | _ => partial_map (* Can't deal with this any more *))
      | make_map(Datatypes.CONSTYPE(ty_list, tyname), mono_type, partial_map) =
        (case mono_type of
           Datatypes.CONSTYPE(ty_list', tyname') =>
             Lists.reducel
             (fn (map, (ty1, ty2)) =>
              make_map(ty1, ty2, map))
             (partial_map, Lists.zip(ty_list, ty_list'))
         | _ => partial_map (* Can't deal with this any more *))
      | make_map(Datatypes.DEBRUIJN _, mono_type, partial_map) =
        partial_map (* Can't do anything with this I think *)
      | make_map(Datatypes.NULLTYPE, mono_type, partial_map) =
        partial_map (* Can't do anything with this I think *)

    fun apply_map partial_map =
      let
        fun apply_map(ty as Datatypes.METATYVAR(r as ref (_, ty', _), _, _)) =
          (case ty' of
             Datatypes.NULLTYPE =>
               (Lists.assoc(r, partial_map) handle Lists.Assoc => ty)
             | _ => apply_map ty')
          | apply_map(Datatypes.META_OVERLOADED{1=ref ty, ...}) = apply_map ty
          | apply_map(ty as Datatypes.TYVAR _) = ty
          | apply_map(Datatypes.METARECTYPE(ref {3=ty, ...})) = apply_map ty
          | apply_map(Datatypes.RECTYPE mapping) =
            Datatypes.RECTYPE(NewMap.map apply_map_map mapping)
          | apply_map(Datatypes.FUNTYPE(ty, ty')) =
            Datatypes.FUNTYPE(apply_map ty, apply_map ty')
          | apply_map(Datatypes.CONSTYPE(ty_list, tyname)) =
            Datatypes.CONSTYPE(map apply_map ty_list, tyname)
          | apply_map(ty as Datatypes.DEBRUIJN _) = ty
          | apply_map(ty as Datatypes.NULLTYPE) = ty

        and apply_map_map(_, ty) = apply_map ty
      in
        apply_map
      end

    fun print_parameter(INTERRUPT) = "INTERRUPT"
      | print_parameter(FATAL_SIGNAL _) = "FATAL_SIGNAL"
      | print_parameter(EXCEPTION _) = "EXCEPTION"
      | print_parameter(BREAK _) = "BREAK"
      | print_parameter STACK_OVERFLOW = "STACK_OVERFLOW"



    (* The following appears to convert the basic frames list into a 
     * another list of slightly different frames.  In the process some
     * sort of type reconstruction is done.  What isn't clear is why
     * this is done at all since if the gui debugger is invoked, all
     * the frames built by this routine are converted back to a simple
     * frame format (using make_frame_strings) - stephenb
     *)
    fun make_frames (basic_frames,parameter,options) =
      let
        val Options.OPTIONS{print_options, ...} = options
        exception ApplyRecipe
        fun apply_recipe (annotation,ty,name) =
          let
            val result =
              DebuggerUtilities.apply_recipe(annotation,ty)
              handle DebuggerUtilities.ApplyRecipe problem =>
                (debugl (fn _ =>
                         ["Recipe problem " ^ problem ^ " for " ^ name,
                          "Annotation: " ^ Debugger_Types.print_backend_annotation options annotation,
                          "Arg : " ^ Types.debug_print_type options ty]);
                raise ApplyRecipe)
          in
            if do_debug then
              debugl (fn _ => ["Name: " ^ name,
                               "Annotation: " ^ Debugger_Types.print_backend_annotation options annotation,
                               "Arg : " ^ Types.debug_print_type options ty,
                               "Res : " ^Types.debug_print_type options result])
            else ();
              result
          end

        datatype TypeThunk =
          NORECIPE |
          RECIPE of (Debugger_Types.Backend_Annotation * Datatypes.Type)

        fun generate_from_previous_types([], _, ty) = ty (*Can't do any better here *)
          | generate_from_previous_types(poly_type_list, mono_type_list, ty) =
            let
              val new_poly_type =
                Datatypes.FUNTYPE
                (type_list_to_rectype poly_type_list,
                 Datatypes.NULLTYPE) (* Result type will be ignored *)
              val new_mono_type = type_list_to_rectype mono_type_list
              val recipe =
                DebuggerUtilities.generate_recipe options (new_poly_type, ty, "Debugger internal")
            in
              DebuggerUtilities.apply_recipe(recipe, new_mono_type)
              handle DebuggerUtilities.ApplyRecipe problem =>
                (debug(fn _ =>"Problem '" ^ problem ^
                        "' with record type inference mechanism\nty = " ^
                        Types.debug_print_type options ty ^
                        " as " ^ Types.extra_debug_print_type ty ^
                        " and\nnew_poly_type = " ^
                        Types.debug_print_type options new_poly_type ^
                        " as " ^ Types.extra_debug_print_type new_poly_type ^ "\n"
                        );
                raise ApplyRecipe)
            end

        val sys_indicator = "[ "

        fun upto_sys_indicator(s, i) =
          if i+1 >= size s then s
          else
            if substring (* could raise Substring *)(s, i, 2) = sys_indicator then
              substring (* could raise Substring *)(s, 0, i+2)
            else
              upto_sys_indicator(s, i+1)


        (* This appears to only do a subset of what was inside frame_name (and
           now frame_code) in StackInterface.  It should probably be
           changed - stephenb *)

        fun get_code closure =
          MLWorks.Internal.Value.cast
          (MLWorks.Internal.Value.unsafe_record_sub
           (MLWorks.Internal.Value.cast closure, 0))


        val step_through : int = get_code(Trace.step_through (fn x => x))
        val step_through_name =
          upto_sys_indicator
          (MLWorks.Internal.Value.code_name(MLWorks.Internal.Value.cast step_through),
           0)


        fun infer_types (recipe,[], _, _) = ()
          | infer_types (recipe,frame::rest, done_poly_types, done_mono_types) =
            let
(*
              fun debug f = debug_print (f ())
*)
            in
            (case frame of
               CFRAME (frame,_) =>
                 (debug(fn _ => "CFRAME");
                  
                 if StackInterface.is_stack_extension_frame frame then
                   infer_types (recipe,rest, done_poly_types, done_mono_types)
                 else
                   infer_types (NORECIPE,rest, done_poly_types, done_mono_types)
                   )
             | MLFRAME (fr,((name,_),_),_,NOFRAMEINFO) =>
                 let
                   val frame_name = upto_sys_indicator(StackInterface.frame_name fr, 0)
                   val recipe =
                     if frame_name = step_through_name then recipe else NORECIPE
                 (* We can use the recipe from the previous frame *)
                 (* when we find a step_through frame *)
                 in
                   (debug(fn _ => "MLFRAME for " ^ name ^
                          " - no info, => no recipe,\n" ^
                            "parameter type: " ^ print_parameter parameter ^
                            " but inferred type was: " ^
                            (case recipe of
                               RECIPE(r, ty) =>
                                 Types.debug_print_type options (apply_recipe (r,ty,name))
                             | _ => "unavailable due to missing recipe"));
                   infer_types (recipe,rest, done_poly_types, done_mono_types))
                 end
             | MLFRAME (_,((name,_),_),_,FRAMEINFO(arg_type,annotation,_,tyref)) =>
                 let
                   val _ = debug (fn _ => "Doing " ^ name)
                   val itype =
                     if not (DebuggerUtilities.is_type_polymorphic arg_type)
                       then (debug (fn _ => "Not polymorphic"); arg_type)
                     else
                       let
                         val reconstructed_type =
                           case recipe of
                             NORECIPE =>
                               (debug (fn _ => "No recipe, trying previous types");
                                let
                                  val done_poly_types =
                                    type_list_to_rectype done_poly_types
                                  val done_mono_types =
                                    type_list_to_rectype done_mono_types
                                  val map =
                                    make_partial_map(done_poly_types,
                                                     done_mono_types, [])
                                  val seen_tyvars = Types.no_tyvars
                                  val (str1, seen_tyvars) =
                                    Types.print_type_with_seen_tyvars
                                    (options, done_poly_types, seen_tyvars)
                                  val (str2, seen_tyvars) =
                                    Types.print_type_with_seen_tyvars
                                    (options, done_mono_types, seen_tyvars)
                                  val (str3, seen_tyvars) =
                                    Types.print_type_with_seen_tyvars
                                    (options, arg_type, seen_tyvars)
                                in
                                  debug
				    (fn () =>
				       ("Attempting partial tyvar substitution in stack backtrace for\n" ^
                                        str1 ^ " as\n" ^ str2 ^
					" with\n" ^ str3));
                                  apply_map map arg_type
                                end)
                           | RECIPE(r,ty) =>
                               let
                                 val _ = debug (fn _ => "Applying recipe to " ^
                                                Types.debug_print_type options ty ^
                                                " when arg_type = " ^
                                                Types.debug_print_type options arg_type)
                               in
                                 apply_recipe (r,ty,name)
                                 handle ApplyRecipe =>
                                   (debug(fn _ => "generating from previous types");
                                    
                                    generate_from_previous_types(done_poly_types, done_mono_types, arg_type)
                                    handle ApplyRecipe =>
                                      (* This case should try to use the partial instantiation stuff *)
                                      let
                                        val done_poly_types =
                                          type_list_to_rectype done_poly_types
                                        val done_mono_types =
                                          type_list_to_rectype done_mono_types
                                        val map =
                                          make_partial_map(done_poly_types,
                                                           done_mono_types, [])
                                        val seen_tyvars = Types.no_tyvars
                                          
                                        val (str1, seen_tyvars) =
                                          Types.print_type_with_seen_tyvars
                                          (options, done_poly_types, seen_tyvars)
                                          val (str2, seen_tyvars) =
                                            Types.print_type_with_seen_tyvars
                                            (options,done_mono_types, seen_tyvars)
                                          val (str3, seen_tyvars) =
                                            Types.print_type_with_seen_tyvars
                                            (options, arg_type, seen_tyvars)
                                      in
                                        debug(fn _ => "Attempting partial tyvar substitution in stack backtrace for\n" ^
                                              str1 ^ " as\n" ^
                                              str2 ^ " with\n" ^
                                              str3);
                                        apply_map map arg_type
                                      end)
                               end
                       in
                         Types.combine_types (reconstructed_type,arg_type)
                         handle Types.CombineTypes =>
                           (debug (fn _ =>
                                   concat ["Combine types fails for: ",
                                            name, "\n argtype: ",
                                            Types.debug_print_type options arg_type,
                                            "\n reconstructed type: ",
                                            Types.debug_print_type options reconstructed_type]);
                           arg_type)
                       end
                 in
                   tyref := itype;
                   debug (fn _ => " Type = " ^ Types.extra_debug_print_type itype);
                   infer_types (RECIPE (annotation,itype), rest,
                                arg_type :: done_poly_types,
                                itype :: done_mono_types)
                 end)
            end

	val _ = stamp_map := empty_map
	(* Clear out prior to getting frames *)
        val frames = map (get_frame_details options) basic_frames
        val _ = infer_types (NORECIPE,frames, [], [])
      in
        case parameter of
          EXCEPTION _ =>
            ((* Omit the first frame.  This should usually be a top level handler *)
             case rev frames of
               (_::rest) => rest
             | rest => rest)
        (* Otherwise, keep all of the frames -- the top ones will usually be C frames and suppressed *)
        | _ => rev frames
      end

    (* If the frame has a well defined type, use that to print the *)
    (* argument.  Otherwise, scan down the stack collecting recipes until *)
    (* either we run out of stack, or recipes or we find a fully *)
    (* instantiated type *)

    fun fix_runtime_env_types options (arg_type, inferred_type, raise_excp) =
      let
        fun fix_runtime_env_types(RuntimeEnv.LET(varinfo_env_list, env)) =
          let
            val varinfo_env_list =
              map
              (fn (RuntimeEnv.NOVARINFO, env) =>
               (RuntimeEnv.NOVARINFO, fix_runtime_env_types env)
                | (var as RuntimeEnv.VARINFO(str, (ty' as ref ty, rti_ref), offs_ref_opt),
                   env) =>
                  let
                    val recipe =
                      DebuggerUtilities.generate_recipe options
                      (Datatypes.FUNTYPE(arg_type, Datatypes.NULLTYPE), ty,
                       "fix_runtime_env_types")
                    val env = fix_runtime_env_types env
                  in
                    (RuntimeEnv.VARINFO
                     (str, (ref(DebuggerUtilities.apply_recipe(recipe, inferred_type)),
                            rti_ref), offs_ref_opt), env)
                    handle exn as DebuggerUtilities.ApplyRecipe _ =>
                      if raise_excp then raise exn
                      else
                        (* Do stuff with partial_maps *)
                        ((*print("Attempting partial tyvar substitution for\n" ^
                                Types.debug_print_type options arg_type ^ " as\n" ^
                                Types.debug_print_type options inferred_type ^ " with\n" ^
                                Types.debug_print_type options ty ^ "\n");*)
                         let
                           val map = make_partial_map(arg_type, inferred_type, [])
                         in
                           (RuntimeEnv.VARINFO
                            (str, (ref(apply_map map ty), rti_ref), offs_ref_opt), env)
                         end)
                  end)
              varinfo_env_list
          in
            RuntimeEnv.LET(varinfo_env_list, fix_runtime_env_types env)
          end
          | fix_runtime_env_types(RuntimeEnv.FN(string, env, offs, funinfo)) =
            RuntimeEnv.FN(string, fix_runtime_env_types env, offs, funinfo)
          | fix_runtime_env_types(RuntimeEnv.APP(env, env', int_opt)) =
            RuntimeEnv.APP(fix_runtime_env_types env, fix_runtime_env_types env',
                           int_opt)
          | fix_runtime_env_types(RuntimeEnv.RAISE env) =
            RuntimeEnv.RAISE(fix_runtime_env_types env)
          | fix_runtime_env_types(RuntimeEnv.SELECT(int, env)) =
            RuntimeEnv.SELECT(int, fix_runtime_env_types env)
          | fix_runtime_env_types(RuntimeEnv.STRUCT(env_list)) =
            RuntimeEnv.STRUCT(map fix_runtime_env_types env_list)
          | fix_runtime_env_types(RuntimeEnv.LIST(env_list)) =
            RuntimeEnv.LIST(map fix_runtime_env_types env_list)
          | fix_runtime_env_types(RuntimeEnv.SWITCH(env, offs_ref, int, tag_env_list)) =
            RuntimeEnv.SWITCH
            (fix_runtime_env_types env, offs_ref, int,
             map (fn (tag, env) => (tag, fix_runtime_env_types env)) tag_env_list)
          | fix_runtime_env_types(RuntimeEnv.HANDLE(env, offs_ref, int, int', env')) =
            RuntimeEnv.HANDLE(fix_runtime_env_types env, offs_ref, int, int',
                              fix_runtime_env_types env')
          | fix_runtime_env_types(RuntimeEnv.EMPTY) = RuntimeEnv.EMPTY
          | fix_runtime_env_types(RuntimeEnv.BUILTIN) = RuntimeEnv.BUILTIN
      in
        fix_runtime_env_types
      end

    fun find_space(arg as (s, i)) =
      if i >= size s orelse MLWorks.String.ordof arg = ord #" " then
        i
      else
        find_space(s, i+1)

    fun ignore_spaces(arg as (s, i)) =
      if i >= size s orelse MLWorks.String.ordof arg <> ord #" " then
        i
      else
        ignore_spaces(s, i+1)

    fun find_colon(arg as (s, i)) =
      if i >= size s then
        0
      else
        let
          val arg' = (s, i+1)
        in
          if MLWorks.String.ordof arg = ord #":" then
            ignore_spaces arg'
          else
            find_colon arg'
        end

    fun strip_name s =
      (* Strip up to first : and space, and all after first space *)
      let
        val start = find_colon(s, 0)
        val finish = find_space(s, start)
      in
        substring (* could raise Substring *)(s, start, finish-start)
      end



    local
      fun should_ignore_break {hits, max, name} =
        let
          val (new_hits, new_max, ignore) =
            let val new_hits = hits+1
            in if max >= 0 andalso new_hits >= max
               then (0, 1, false)
               else (new_hits, max, true)
            end
        in
          Trace.update_break{hits=new_hits, max=new_max, name=name};
          ignore
        end

    in
      fun should_ignore INTERRUPT        = false
        | should_ignore (FATAL_SIGNAL _) = false
        | should_ignore (EXCEPTION    _) = false
        | should_ignore (BREAK  fn_info) = 
            (case Trace.is_a_break (strip_name fn_info) of
               SOME break_info => should_ignore_break break_info
             | NONE            => false)
        | should_ignore STACK_OVERFLOW   = false
    end



    fun ignore_command breakpoint_name ignore_count =
      case Trace.is_a_break breakpoint_name of
        SOME {hits, max, name} =>
          (Trace.update_break {hits=hits, max=hits+ignore_count, name=name};
           print"ignoring next ";
           print(Int.toString ignore_count);
           print" hits on the breakpoint ";
           print breakpoint_name;
           print"\n")
      | NONE =>
          (print breakpoint_name;
           print" is not a breakpoint\n")

    fun breakpoints_command () =
      let fun display_breakpoint {hits, max, name} = 
             (print name;
              print" ";
              print(Int.toString hits);
              print" ";
              print(Int.toString max);
              print"\n")
          val breakpoints = Trace.breakpoints ()
      in case breakpoints of
           [] =>
             print"No breakpoints set\n\n"
         | _  =>
             (app display_breakpoint breakpoints;
              print"\n")
      end



    local
      (* A mapping from frame type name to the associated flag.
       * A list is sufficient since the number of entries is small.
       *)
      val frame_visibility = 
        [ ("c",         StackFrame.hide_c_frames)
        , ("anon",      StackFrame.hide_anonymous_frames)
        , ("setup",     StackFrame.hide_setup_frames)
        , ("handler",   StackFrame.hide_handler_frames)
        , ("delivered", StackFrame.hide_delivered_frames)
        , ("duplicate", StackFrame.hide_duplicate_frames)
        ]


      fun frame_type_to_ref frame_type =
        SOME (Lists.assoc (frame_type, frame_visibility))
        handle Lists.Assoc => NONE


      fun apply action frame_type =
        case frame_type_to_ref frame_type of
          NONE => (print"No such frame type as ";
                   print frame_type;
                   print"\n")
        | SOME flag => action flag


      fun display_frames_status status =
        let
          fun out (name, hide) = 
            if !hide = status
            then (print name; print" ")
            else ()
        in
          app out frame_visibility;
          print"\n"
        end


      (*
       * User frames are unconditionally displayed.  However, to make
       * the implementation of frame filtering easier, a ref of the same
       * for that is used for all the other frames (see StackFrame) exists.
       * Since user frames are unconditionaly displayed, this value should
       * never be changed.  If the debugger is changed to allow user frames
       * to be hidden, then move this ref to StackFrame with all the other
       * frame controls.
       *)
      val hide_user_frame = ref false

    in

      (* Display the names of all the frame types that are currently hidden *)

      fun display_hidden_frames_command () =
        display_frames_status true



      (* Display the names of all the frame types that are currently visible *)

      fun display_revealed_frames_command () =
        display_frames_status false



      (* Mark as hidden any frames with the given types.
       * If the frame type is not legal, then issue a warning 
       * for that frame type but process any following frame types.
       * If a given frame type is already set, then leave it set.
       * (Could output a warning ?)
       *)
      fun hide_frame_command frame_types =
        app (apply (fn var => var := true)) frame_types



      (* Mark as visible any frames with the given types.
       * If the frame type is not legal, then issue a warning 
       * for that frame type but process any following frame types.
       * If a given frame type is already set, then leave it set.
       * (Could output a warning ?)
       *)
      fun reveal_frame_command frame_types =
        app (apply (fn var => var := false)) frame_types
        

      (* The backtrace and stack frame movement commands need to take
       * account of whether a given frame is visible at a given point.
       * Whether a frame is visible or not depends on the type of frame, 
       * its name, location, ... etc., and in one case the type of the
       * *next* frame (specifically any ML frame that comes after a 
       * frame which has been identified as a delivered ML frame is
       * considered to be a duplicate frame resulting from the step/next/trace
       * implementation).  It is this last case which makes it awkward
       * to do the test in the display and movement commands, especially
       * since it is necessary to move in both directions in the stack.
       *
       * The solution adopted here is to classify the frames once and for
       * all at the start.  The list of frames then becomes a list of 
       * pairs, where the first item is a boolean reference to the particular
       * flag that controls whether that (type of) frame should be
       * displayed.
       *
       * If you make any changes to the following, make sure that you make
       * the corresponding changes to the gui version (filter_frames in 
       * ../gui/_debugger_window.sml).
       *)
      local
        fun classify ([], fs') = rev fs'
          | classify (((f as (CFRAME (_, name)))::fs), fs') = 
               classify (fs, (StackFrame.hide_c_frames, f)::fs')
          | classify (((f as (MLFRAME (_, ((name, (loc, file_name)), _), _, _)))::fs), fs') =
               case name of
                 "<Setup>" =>  
                   classify (fs, (StackFrame.hide_setup_frames, f)::fs')
               | "<anon>" =>   
                   classify (fs, (StackFrame.hide_anonymous_frames, f)::fs')
               | "<handle>" => 
                   classify (fs, (StackFrame.hide_handler_frames, f)::fs')
               | _ =>
                   if file_name = "" andalso size loc > 0 andalso 
		     MLWorks.String.ordof (loc, 0) <> ord #" " then
                     classify (fs, (hide_user_frame, f)::fs')
                   else
                     let 
                       val f' = (StackFrame.hide_delivered_frames, f)
                     in
                       case fs' of
                         [] => classify (fs, [f'])
                       | ((hide, f)::rest) =>
                           if     hide = hide_user_frame
                           orelse hide = StackFrame.hide_anonymous_frames
                           then classify (fs, f'::(StackFrame.hide_duplicate_frames, f)::rest)
                           else classify (fs, f'::fs')
                     end
      in
        fun classify_frames frames = classify (frames, [])
      end

    end



    (* The show_frame_above and show_frame_below were added to help
     * work out what is stack at any point.  I found these very useful when
     * reworking the stepper and adding the next_command.
     * They shouldn't be visible to users of the debugger.
     * -stephenb
     *)
    fun display_frame (hide, (MLFRAME (frame, ((name, (loc,file_name)), nameStr), _, _))) =
      (print"MLFRAME";
       (if !hide then print" (hidden)" else ());
	print"\nname = X";
	print name;
	print"X\nfile_name= X";
	print file_name;
	print"X\nlocation= X";
	print loc;
	print"X\nnameStr= X";
	print nameStr;
	print"X\n")
      | display_frame (hide, (CFRAME (frame, name))) =
	(print"CFRAME";
	 (if !hide then print" (hidden)" else ());
	  print"\nname = ";
	  print name;
	  print"\n")

    fun show_frame_above_command ([], _, _) = print"TOP\n"
      | show_frame_above_command (above as (a::as'), below, n) =
          if n = 0
          then display_frame a
          else show_frame_above_command (as', a::below, n-1)

    fun show_frame_below_command (_, [], _) = print"BOTTOM\n"
      | show_frame_below_command (above, below as (b::bs), n) =
          if n = 0
          then display_frame b
          else show_frame_below_command (b::above, bs, n-1)

    (*
     * This is just here for debugging/development purposes.
     *)
    local
      fun out m = (print"Parameter = ";
                   print m;
                   print"\n")
    in
      fun show_parameter_command INTERRUPT = out "interrupt"
        | show_parameter_command (FATAL_SIGNAL _) = out "fatal signal"
        | show_parameter_command (EXCEPTION _) = out "exception"
        | show_parameter_command (BREAK _) = out "breakpoint"
        | show_parameter_command STACK_OVERFLOW = out "stack overflow"
    end



    local 

      fun make_frame_details (_, CFRAME (f,s),_) _ =
        ("<Cframe> "^s,"", (Datatypes.NULLTYPE,cast 0,""), NONE)
        | make_frame_details (_, MLFRAME (f,((name,(loc,_)),st),_,NOFRAMEINFO),_) _ =
          (concat[name,"<??>"],
           concat["[",loc,"]"],
           (Datatypes.NULLTYPE,cast 0,""),
           NONE)
        | make_frame_details (_, MLFRAME (f,((name,(loc,_)),st),NONE,_),_) _ =
          (concat[name,"<??>"],
           concat["[",loc,"]"],
           (Datatypes.NULLTYPE,cast 0,""),
           NONE)
        | make_frame_details (options as (Options.OPTIONS {print_options, ...}), MLFRAME (f,
                                       ((name,(loc,_)),st),
                                       SOME arg,
                                       FRAMEINFO(arg_type,annotation,runtime_env,
                                                 ref inferredType)),frames) windowing =
          (concat[name," ",
                   if windowing then ""
                   else
                     ValuePrinter.stringify_value false (print_options,
                                                         arg,
                                                         inferredType,
                                                         get_interpreter_information())],
          concat[name,"[",loc,"]", ":",Types.print_type options inferredType],
          if windowing then
            (inferredType, arg,
             ValuePrinter.stringify_value false (print_options,
                                                 arg,
                                                 inferredType,
                                                 get_interpreter_information()))
          else (Datatypes.NULLTYPE, cast 0,""),
            if windowing then
              let
                val new_runtime_env =
                  (fix_runtime_env_types options
                   (arg_type, inferredType, true)
                   runtime_env)
                  handle DebuggerUtilities.ApplyRecipe _ =>
                    (* Try using the entire set of frames to do the same job *)
                    let
                      fun collect_types(poly_list, mono_list, []) =
                        (poly_list, mono_list)
                        | collect_types(poly_list, mono_list, CFRAME _ :: frames) =
                          collect_types(poly_list, mono_list, frames)
                        | collect_types(poly_list, mono_list,
                                        MLFRAME(_, _, _, NOFRAMEINFO) :: frames) =
                          collect_types(poly_list, mono_list, frames)
                        | collect_types(poly_list, mono_list,
                                        MLFRAME(_, _, _,
                                                FRAMEINFO(arg_type, _, _,
                                                          ref inferredType)) ::
                                        frames) =
                          collect_types(arg_type :: poly_list,
                                        inferredType :: mono_list,
                                        frames)
                      val (poly_type_list, mono_type_list) =
                        collect_types([arg_type], [inferredType], frames)
                      val new_poly_type =
                        type_list_to_rectype poly_type_list
                      val new_mono_type = type_list_to_rectype mono_type_list
                    in
                      (fix_runtime_env_types options
                       (new_poly_type, new_mono_type, false)
                       runtime_env)
                      (* This shouldn't raise, but just in case it does ... *)
                      handle DebuggerUtilities.ApplyRecipe _ =>
                        runtime_env
                    end
                val frame = StackInterface.variable_debug_frame f
              in
                (* This should use the full stack if necessary *)
                (* And now it does *)
                SOME (ref (INL
			   (fn () =>
			    DebuggerPrint.print_env
			    ((frame, new_runtime_env, inferredType),
			     (* Mysterious errors can happen during local variable printing *)
			     (* so we have catchall exception here *)
			     (* This is suboptimal, but beats having the debugger renter itself *)
			     fn (ty1,value) =>
			     ValuePrinter.stringify_value true (print_options,
								value,
								ty1,get_interpreter_information())
			     handle _ => "_" (*XXXX HACK *),
			       options,true,
			       map (fn MLFRAME(frame,_,_,FRAMEINFO(_,_,env,ref ty))=>(frame,env,ty)
			     | MLFRAME (frame,_,_,_) => (frame,RuntimeEnv.EMPTY,Datatypes.NULLTYPE)
			     | CFRAME(frame,_) => (frame,RuntimeEnv.EMPTY,Datatypes.NULLTYPE))
			       frames))))
              end
            else NONE)



      fun make_frame_strings (options, frames) =
        let
          fun aux (frame::frames,acc) =
            let
              val details = make_frame_details (options, frame,frames) true
              val stuff =
                case frame of
                  CFRAME (_,loc) => {name = "<Cframe>", loc = loc,details = details}
                | MLFRAME (_,((name,(loc,_)),_),_,_) => {name = name,loc = loc, details = details}
            in
              aux (frames,stuff::acc)
            end
            | aux (nil,acc) = rev acc
        in
          aux (frames,[])
        end



      local
        fun turn_on_exn_details_printing
          (Options.PRINTOPTIONS{maximum_seq_size,
                               maximum_string_size,
                               maximum_ref_depth,
                               maximum_str_depth,
                               maximum_sig_depth,
                               maximum_depth,
                               float_precision,
                               print_fn_details,
                               print_exn_details,
                               show_id_class,
                               show_eq_info}) =
           Options.PRINTOPTIONS{maximum_seq_size = maximum_seq_size,
                                maximum_string_size = maximum_string_size,
                                maximum_ref_depth = maximum_ref_depth,
                                maximum_str_depth = maximum_str_depth,
                                maximum_sig_depth = maximum_sig_depth,
                                maximum_depth = maximum_depth,
                                float_precision = float_precision,
                                print_fn_details = print_fn_details,
                                print_exn_details = true,
                                show_id_class = show_id_class,
                                show_eq_info = show_eq_info}
      in
        fun parameter_details (EXCEPTION exn, print_options) =
              let
                val print_options = turn_on_exn_details_printing print_options
                val exn_name = ValuePrinter.stringify_value false (print_options,
                                                             cast exn,
                                                             Datatypes.CONSTYPE([],Types.exn_tyname),
                                                             get_interpreter_information())
              in
                concat ["Exception ", exn_name, " raised"]
              end
          | parameter_details (INTERRUPT, _) = "Interrupt"
          | parameter_details (FATAL_SIGNAL s, _) =
              "Fatal OS signal " ^ Int.toString s
          | parameter_details (BREAK s, _) = s
          | parameter_details (STACK_OVERFLOW, _) = "Break on stack overflow"
       end



      fun string_to_int str =
        let
          exception Finished of int
          fun factor 0 = 1
            | factor n = 10*factor (n-1)
          fun string_to_int nil (n,_) = n
            | string_to_int (m::ms) (n,power) =
              string_to_int ms
              ((case m of
                  #"1" => 1*(factor power)+n
                | #"2" => 2*(factor power)+n
                | #"3" => 3*(factor power)+n
                | #"4" => 4*(factor power)+n
                | #"5" => 5*(factor power)+n
                | #"6" => 6*(factor power)+n
                | #"7" => 7*(factor power)+n
                | #"8" => 8*(factor power)+n
                | #"9" => 9*(factor power)+n
                | #"0" => n
                | _ => raise Finished(n)),power+1)
        in
          string_to_int (rev(explode str)) (0,0)
          handle Finished(n) => n
        end



      (* As part of the step/next implementation it is necessary to locate
       * the first user frame on the stack.  
       *
       * For example, in the following stack trace taken after a few
       * steps into Btree.fromList ([1,2,3], op<) under Unix, the first
       * user frame is the listfold frame :-
       *
       *   step_always_replacement<??>
       *   <Cframe> start
       *   <Cframe> start intercept
       *   <Cframe> start intercept
       *   listfold argument 0 fn
       *   fromList ([1, 2, 3], fn)
       *   step_always_replacement<??>
       *   <Cframe> start
       *   <Cframe> start intercept
       *   <Cframe> start intercept
       *   fromList ([1, 2, 3], fn)
       *   <Setup> ()
       *)
      local
        (* The delivery mechanism ensures that any functions that are
         * part of a delivered image have a location whose first character
         * is a space.  See rts/src/loader.c for (a little) more info.
         *)
        fun userFrame (MLFRAME (_, ((name, (loc, fileName)), _), _, _)) =
              fileName = "" andalso
              size loc > 0  andalso
              (String.sub(loc, 0)) <> #" "
          | userFrame _ = false
      in
        fun locateFirstUserFrame (BREAK _, frames) = 
          ((case (Lists.findp (fn frame => userFrame frame) frames) of
	      (MLFRAME (frame, _, _, _)) => SOME frame
	    | _                          => NONE) handle Find => NONE)
	  |   locateFirstUserFrame (_, _) = NONE
      end



      local

        fun next ((_,[]), orig, _, k) = k orig
          | next (frames as (above, (frame as (hide, _))::rest), orig, n, k) =
              if !hide then
                next ((frame::above, rest), orig, n, k)
              else
                if n = 0
                then frames
                else next ((frame::above, rest), frames, n-1, k)


        fun prev (([], _), orig, _, k) = k orig
          | prev (frames as ((frame as (hide, _))::rest, below), orig, n, k) =
              let
                val frames' = (rest, frame::below)
              in
                if !hide then
                  prev (frames', orig, n, k)
                else
                  if n = 0
                  then frames'
                  else prev (frames', frames', n-1, k)
              end

      in

        (* Move to nth next visible frame up the stack.
         * if n = 0 and the frame is visible then don't move.
         * If n > number of visible calling frames, then move to the
         * last visible frame.
         *)
        local
          fun hit_bottom frames =
            (print"No calling frame\n";  frames)
        in
          fun next_frame_command (frames, n) =
            next (frames, frames, n, hit_bottom)
        end




        (* Moves to the nth next visible frame down the stack.
         * If n = 0 and the frame is visible then don't move.
         * if n > number of visible called frames, then move to the
         * earliest visible frame.
         *)
        local
          fun hit_top frames = 
            (print"No called frame\n";  frames)
        in
          fun previous_frame_command (frames, n) =
            prev (frames, frames, n, hit_top)
        end



        (* Move to the first visible frame.  This is defined to be (in order):-
         *
         *   1. current frame if visible, 
         *   2. the first visible frame up the stack from the current frame.
         *   3. the first visible frame down the stack from the current frame.
         *
         * Note that in certain circumstances there may not be any visible
         * frames (for example an exception handler invoked from the listener).
         *)
        local
          fun hit_top (above, below) = ((rev below) @ above, [])
          fun hit_bottom frames = prev (frames, frames, 0, hit_top)
        in
          fun move_to_first_visible_frame frames =
            next (frames, frames, 0, hit_bottom)
        end




        fun goto_top_command frames = move_to_first_visible_frame frames



        (* Goto the last visible stack frame.  In the event that there
         * are no visible stack frames below the current one, then
         * display the current stack frame if it is visible.
         * If that is not visible (it isn't clear to me if this situation
         * can occur) then goto the first visible stack frame above the
         * current one -- this might be confusing for users so perhaps
         * an informational message of some sort would be appropriate.
         *)
        local
          fun hit_top frames = frames
          fun next (frames as (_, []), (_, [])) =
                prev (frames, frames, 0, hit_top)
            | next (frames as (_, []), orig as (_, ((hide, _)::rest))) =
                if !hide
                then prev (orig, frames, 0, hit_top)
                else orig
            | next (frames as (above, (frame as (hide, _))::rest), orig) = 
                let 
                  val above' = (frame::above, rest)
                in
                  if !hide
                  then next (above', orig)
                  else next (above', frames)
                end
        in
          fun goto_bottom_command frames = next (frames, frames)
        end

      end




      fun output_frame_details (options, frame) =
        let
          val frame_details = make_frame_details (options, frame, nil) false
        in
          print( #1 frame_details);
          print"\n"
        end



      (* Display all of the visible frames in the frame list.
       * Each frame is displayed on a separate line.
       *)
      fun backtrace_command (options, frames) =
        let
          fun display (hide, frame) =
            if !hide
            then ()
            else output_frame_details (options, frame)
        in
          print"(Current frame)\n";
          app display frames
        end



      (* Make the debugger step over the next ML function call, assuming
       * there is one!
       *)
      fun next_command NONE = 
            print"No ML function to step over\n"
        | next_command (SOME frame) =
            Trace.next frame



      (* Print out the value of local and closure variables of the current
       * frame if it is an ML frame, otherwise do nothing.
       *)
      fun frame_details_command ([], _) = ()
        | frame_details_command ((_, (CFRAME _))::_, _) = ()
        | frame_details_command ((frames as (_, (MLFRAME (frame, _, _, frameinfo)))::_), options) =
            case frameinfo of
              NOFRAMEINFO => ()
            | FRAMEINFO(_, _, runtime_env, ref ty) =>
                let
                  fun munge_frame (_, (MLFRAME (frame,_,_,FRAMEINFO(_,_,env,ref ty)))) =
                       (frame, env, ty)
                    | munge_frame (_, (MLFRAME (frame,_,_,_))) = 
                       (frame, RuntimeEnv.EMPTY, Datatypes.NULLTYPE)
                    | munge_frame (_, (CFRAME (frame,_))) =
                       (frame, RuntimeEnv.EMPTY, Datatypes.NULLTYPE)

                  val Options.OPTIONS {print_options, ...} = options
                  fun display_value (ty,value) =
                    ValuePrinter.stringify_value true
                      (print_options,
                       value,
                       ty,
                       get_interpreter_information())

                  val windowing = false

                  val frame = StackInterface.variable_debug_frame frame
                  val frame_details = (frame ,runtime_env, ty)
                  val frames = map munge_frame frames
                  (* Mysterious errors can happen during local variable printing *)
                  (* so we have catchall exception here *)
                  (* This is suboptimal, but beats having the debugger renter itself *)
                  val (str, _) = DebuggerPrint.print_env (frame_details, 
                                                          fn (ty,x) => display_value (ty,x) handle _ => "_", (*XXX HACK *)
                                                          options, windowing, frames)
                in
                  print str
                end



      fun edit_frame (preferences, (CFRAME _)) =
            print"Cannot edit source for C frame\n"
        | edit_frame (preferences, (MLFRAME (_,((_,(loc,_)),_),_,_))) =
            (ignore(ShellUtils.edit_source (loc, preferences)); ())
            handle ShellUtils.EditFailed s =>
              print("Edit failed: " ^ s ^ "\n")



    in
      fun ml_debugger
        (type_of_debugger, options, preferences)
        (base_frame, parameter, quit_continuation, continue_continuation) =
        if should_ignore parameter then
          ()
        else
          let
            val Options.OPTIONS {print_options, ...} = options
            val Preferences.PREFERENCES {environment_options,...} = preferences

            val Preferences.ENVIRONMENT_OPTIONS
              {use_debugger, window_debugger, ...} =
              environment_options

            fun stack_empty basic_frames =
              case parameter of
                EXCEPTION _ => length basic_frames <= 2
              (* one for the money, two for the show *)
              | _ => false

            val outfun = print
            fun outline s = outfun (s ^ "\n")

            val output_frame_details = fn frame => output_frame_details (options, frame)

            fun output_full_frame_details frame =
              outline (#2 (make_frame_details (options, frame,nil) false))
            fun prompt s = (outfun s; TextIO.flushOut TextIO.stdOut)

            fun do_quit_action () =
              (case quit_continuation of
                 NOT_POSSIBLE => ()
               | POSSIBLE (_,NORMAL_RETURN) => ()
               | POSSIBLE (_,DO_RAISE exn) => raise exn
               | POSSIBLE (_,FUN f) => f())

            (* This is a "private" exception used to exit from the 
             * debugger inner loop *)
            exception Exit


            val edit_frame = fn frame => edit_frame (preferences, frame)


            fun do_input frames =
              let
                fun is_whitespace char =
                  case char of
                    #" " => true
                  | #"\n" => true
                  | _ => false

                fun parse_command s =
                  let
                    fun parse ([],acc) =
                      (case acc of
                         [] => []
                       | _ =>  [implode (rev acc)])
                      | parse (char::rest,acc) =
                        if is_whitespace char
                          then
                            (case acc of
                               nil => parse (rest,nil)
                             | _ => implode(rev acc)::parse(rest,nil))
                        else
                          parse (rest,char::acc)
                  in
                    parse (explode s,[])
                  end

                fun display_simple_help_info () =
                  outline "Enter ? or help for help"

                fun display_help_info () =
		  app
                  outline
                  (["Commands:",
                    " <                - go to the earliest frame in the stack",
                    " >                - go to the latest frame in the stack",
                    " i                - next frame INto the stack or next later frame (callee)",
                    " i <n>            - next n frames INto the stack",
                    " o                - next frame OUT of the stack or next earlier frame (caller)",
                    " o <n>            - next n frames OUT of the stack",
                    " b                - do a backtrace of the stack",
                    " f                - show full frame details",
                    " e                - edit definition",
                    " h {<name>}       - hide the given types of frame or list hidden frame types if none given",
                    " r {<name>}       - reveal the given types of frame or list the reveald frame types if none given",
                    " p                - print values of local and closure variables",
                    " c                - continue interrupted computation",
                    " s                - step through computation",
                    " s <n>            - step through computation to nth function call",
                    " n                - step over the current function to the start of the next one",
                    " trace <name>     - set trace on function entry at <name>",
                    " breakpoint <name> - set breakpoint on function entry at <name>",
                    " untrace <name>   - unset trace on function entry at <name>",
                    " unbreakpoint <name> - unset breakpoint on function entry at <name>",
                    " breakpoints      - display the list of breakpoints",
                    " ignore name n    - ignore the next n hits on the breakpoint on function <name>",
                    " help             - display this help info",
                    " ?                - display this help info"] @
                  (case continue_continuation of
                     POSSIBLE(st,_) => [" c                - " ^ st]
                   | _ => []) @
                     (case quit_continuation of
                        POSSIBLE(st,_) => [" q                - " ^ st]
                      | _ => []))


                val firstUserFrame = locateFirstUserFrame (parameter, frames)
                val classified_frames = ([], classify_frames frames)



                fun loop (frames as (above, below)) =
                  let

                    (* Next two functions raise Exit, so only call from inside loop *)
                    (* Attempt to return from the debugger to whatever called
                     * it.  If this is possible, the action is performed before
                     * returning.
                     *)
                    fun do_continue action =
                      (case continue_continuation of
                         NOT_POSSIBLE => outline "Cannot Continue"
                       | POSSIBLE (_,NORMAL_RETURN) => (ignore(action ()); raise Exit)
                       | POSSIBLE (_,DO_RAISE exn) => raise exn
                       | POSSIBLE (_,FUN f) => (ignore(action ()); f (); raise Exit))


                    fun do_quit () =
                      (case quit_continuation of
                         NOT_POSSIBLE => outline "Cannot Quit"
                       | POSSIBLE (_,NORMAL_RETURN) => raise Exit
                       | POSSIBLE (_,DO_RAISE exn) => raise exn
                       | POSSIBLE (_,FUN f) => (f()))

                    fun apply_to_current_frame action =
                      case below of
                        [] => print"No visible frame\n"
                      | ((_, this)::_) => action this


                    val _ = if Trace.stepping ()
                            then ()
                            else apply_to_current_frame output_frame_details

                    val _ = prompt "Debugger> "

                    val command_and_args =
                      let
                        val _ =
                          if TextIO.endOfStream TextIO.stdIn then
                            (do_quit(); raise Exit)
                          else ()

                        val line = TextIO.inputLine TextIO.stdIn
                      in
                        parse_command line
                      end

                  in
                    case command_and_args of
                      ">"::_ => loop (goto_top_command classified_frames)
                    | "<"::_ => loop (goto_bottom_command frames)
                    | "f"::_ =>
                        (apply_to_current_frame output_full_frame_details;
                         loop frames)
                    | "e"::_ =>
                        (apply_to_current_frame edit_frame;  loop frames)
                    | ["i"] =>
                        loop (previous_frame_command (frames, 1))
                    | "i"::arg::_ =>
                        let
                          val n = string_to_int arg
                        in
                          loop (previous_frame_command (frames, n))
                        end
                    | ["o"] =>
                        loop (next_frame_command (frames, 1))
                    | "o"::arg::_ =>
                        let
                          val n = string_to_int arg
                        in
                          loop (next_frame_command (frames, n))
                        end
                    | ["b"] =>
                        (backtrace_command (options, below);
                         print"(Outermost frame)\n";
                         loop frames)
                    | ("b"::arg::_) =>
                        let
                          val frames' = firstn (below, string_to_int arg)
                        in
                          backtrace_command (options, frames');
                          loop frames
                        end
                    | "c"::_ =>
                        (do_continue (fn () => ());
                         loop frames)
                    | ["h"] => 
                        (display_hidden_frames_command ();
                         loop frames)
                    | "h"::names =>
                        (hide_frame_command names;
                         loop (move_to_first_visible_frame frames))
                    | "q"::_ =>
                        (do_quit ();
                         ignore(raise Exit); (* Why the call to loop frames after this ? *)
                         loop frames)
                    | ["r"] => 
                       (display_revealed_frames_command ();
                        loop frames)
                    | "r"::names => 
                        (reveal_frame_command names;
                         loop (move_to_first_visible_frame frames))
                    | ""::_ => loop frames
                    | "?"::_ =>
                        (display_help_info();  loop frames)
                    | "help"::_ =>
                        (display_help_info();  loop frames)
                    | "trace" :: args =>
			(app Trace.trace args;  loop frames)
                    | ["breakpoints"] =>
                        (breakpoints_command ();  loop frames)
                    | "breakpoint" :: args =>
                        (app Trace.break
                          (map (fn name => {name=name, hits=0, max=1}) args);
                         loop frames)
                    | "ignore" :: fn_name :: n :: _ =>
                        (ignore_command fn_name (string_to_int n);
                         loop frames)
                    | "untrace" :: args => (app Trace.untrace args;
                                            loop frames)
                    | "unbreakpoint" :: args =>
                         (app Trace.unbreak args;  loop frames)
                    | ["s"] =>
                         (do_continue (fn () => Trace.set_stepping true);
                          loop frames)
                    | "s" :: arg :: _ => 
                       (do_continue (fn () =>
                          (Trace.set_stepping true;
                           Trace.set_step_count (string_to_int arg)));
                        loop frames)
                    | ["n"] => 
                        (do_continue (fn () => next_command firstUserFrame);
                         loop frames)
                    | "show_frame_above"::arg::_ => 
                        (show_frame_above_command (above, below, string_to_int arg);
                         loop frames)
                    | "show_frame_below"::arg::_ => 
                        (show_frame_below_command (above, below, string_to_int arg);
                         loop frames)
                    | ["show_parameter"] =>
                        (show_parameter_command parameter;
                         loop frames)
                    | ["t"] => 
                        (do_continue (fn () => Trace.set_trace_all true);
                         loop frames)
                    | "p"::_ =>
                        (frame_details_command (below, options);
                         loop frames)
                    | "show_debug"::_ =>
                        (let
                           val debug_info = get_interpreter_information ()
                         in
                           app (fn s => print(s^"\n")) (Debugger_Types.print_information options (debug_info,true))
                         end;
                         loop frames)
                    | _ => (display_simple_help_info();
                            loop frames)
                  end
              in
                (if Trace.stepping () then
                   ()
                 else
                   outline "Current (innermost) stack frame:");
                loop (move_to_first_visible_frame classified_frames)
                handle Exit => ()
              end

            fun make_entry_info_line () =
              (case quit_continuation of
                 POSSIBLE (s,_) => "q : " ^ s ^ ", "
               | _ => "") ^
                 (case continue_continuation of
                    POSSIBLE (s,_) => "c : " ^ s ^ ", "
                  | _ => "") ^
                    " ? : more help"

            fun tty_debugger basic_frames =
              if not (!use_debugger) then
                (outline (parameter_details (parameter, print_options));
                 do_quit_action ())
              else
                if stack_empty basic_frames then
                  outline (parameter_details (parameter, print_options) ^ " at top level")
                else
                  (outline (parameter_details (parameter, print_options));
                   (if Trace.stepping () then
                      ()
                    else
                      outline ("Entering debugger, commands: " ^ make_entry_info_line ()));
                   do_input (make_frames (basic_frames,parameter,options)))
          in
            let
              val top_frame = MLWorks.Internal.Value.Frame.current ()

              val no_message = Trace.stepping ()  orelse not (!use_debugger)
              val _ = 
                if no_message
                  then ()
                else outputMessage "Entering Debugger, scanning stack ... "

              val basic_frames =
                StackInterface.get_basic_frames (top_frame,base_frame)

              val _ = 
                if no_message
                  then ()
                else outputMessage "done.\n";
            
              (* The identifier debugger_call is never used; 
                 this is deliberate!  See below.  *)
              val debugger_call =
                case type_of_debugger of
                  TERMINAL =>
                    tty_debugger basic_frames
                | WINDOWING (make_window, send_message, tty_ok) =>
                    if tty_ok andalso not (!window_debugger) then
                      tty_debugger basic_frames
                    else if not (!use_debugger) then
                      (send_message (parameter_details (parameter, print_options) ^ "\n");
                       do_quit_action ())
                    else if stack_empty basic_frames then
                      send_message (parameter_details (parameter, print_options) ^ " at top level\n")
                    else
                      let
                        (* This is terribly distracting when stepping *)
                        (* val _ = outline (parameter_details (parameter, print_options)) *)
                        val frames = make_frames (basic_frames,parameter,options)
                        val firstUserFrame = locateFirstUserFrame (parameter, frames)
                        val frame_strings = make_frame_strings (options, frames)
                      in
                        make_window
                          {parameter_details = parameter_details (parameter, print_options),
                           frames = frame_strings,
                           quit_fn =
                             make_continuation_function quit_continuation,
                           continue_fn = 
                             make_continuation_function continue_continuation,
                           top_ml_user_frame = firstUserFrame};
                        ()
                      end
            in
              (* Ensure call to tty_debugger not tail, else frame is invalid *)
              (* The lambda optimizer is unable to guarantee that this will be maintained *)
              ()
            end
          end
    end


    val start_frame_ref = ref (MLWorks.Internal.Value.Frame.current())



    (* The "Trace.set_stepping previousStepStatus" expression is there to
     * ensure that all stepping is restored to its previous status
     * (generally off) before returning to the top level.
     * In previous versions of the debugger, an equivalent was sprinkled
     * around various parts of the debugger to try and ensure that stepping
     * was turned off, however they never dealt with all the possible cases,
     * particularly the case where the user used step/next to step right
     * to the end of a computation and doesn't exit the debugger using 
     * "c"ontinue or "q"uit.
     *)
    fun with_start_frame f =
      let
        val frame = MLWorks.Internal.Value.Frame.current ()
        val old_frame = !start_frame_ref
        val _ = start_frame_ref := frame
        val previousStepStatus = Trace.stepping ()
        val result =
          f frame
          handle exn => (start_frame_ref := old_frame; Trace.set_stepping previousStepStatus; raise exn)
      in
        start_frame_ref := old_frame;
        Trace.set_stepping previousStepStatus;
        result
      end



    fun get_start_frame () = !start_frame_ref

    val debugger_type_ref = ref TERMINAL

    fun with_debugger_type debugger_type f =
      let
        val old_type = !debugger_type_ref
        val _ = debugger_type_ref := debugger_type
        val result = (with_start_frame f) handle exn => (debugger_type_ref := old_type; raise exn)
      in
        debugger_type_ref := old_type;
        result
      end

    fun get_debugger_type () = !debugger_type_ref

  end
