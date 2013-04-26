(* _mach_cg.sml the functor *)
(*
$Log: _mach_cg.sml,v $
Revision 1.248  1998/02/20 09:31:47  mitchell
[Bug #30349]
Fix to avoid non-unit sequence warnings

 * Revision 1.247  1998/01/30  09:48:22  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.246  1997/11/13  11:21:00  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.245  1997/09/18  16:28:48  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.244.2.2  1997/11/20  17:09:12  daveb
 * [Bug #30326]
 *
 * Revision 1.244.2.1  1997/09/11  21:08:53  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.244  1997/08/07  14:54:35  jont
 * [Bug #30243]
 * Remove tests for out of range shifts as we no longer generate them
 *
 * Revision 1.243  1997/08/06  12:16:36  jont
 * [Bug #50027]
 * Sort out bugs in NOT and NOT32 of constant (not that these should happen)
 *
 * Revision 1.242  1997/08/04  16:26:46  jont
 * [Bug #30215]
 * Remove BIC in favour of INTTAG
 *
 * Revision 1.241  1997/05/30  11:52:29  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.240  1997/05/19  12:36:03  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.239  1997/03/26  14:06:50  matthew
 * Reorder registers in integer multiply
 *
 * Revision 1.238  1997/01/31  16:55:51  matthew
 * Adding static flag to scheduler
 *
 * Revision 1.237  1997/01/23  14:14:33  jont
 * Modifying to protect allocate from lr, and redo switch to allow lr
 * except in leaf case
 *
 * Revision 1.236  1997/01/17  17:23:23  matthew
 * Adding multiply instructions
 *
 * Revision 1.235  1997/01/16  16:41:55  matthew
 * Changed tag option to tag list in tagged instructions
 *
 * Revision 1.234  1996/11/06  14:38:45  jont
 * [Bug #1730]
 * Sort out problem in FP_SPILL_SLOT calculation.
 *
 * Revision 1.233  1996/11/06  11:10:19  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.232  1996/10/09  14:14:06  io
 * moving String from toplevel
 *
 * Revision 1.231  1996/08/01  12:22:44  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.230  1996/05/30  12:38:46  daveb
 * The Ord exception is no longer at top level.
 *
 * Revision 1.229  1996/05/17  09:43:47  matthew
 * Moved Bits to MLWorks.Internal
 *
 * Revision 1.228  1996/05/14  10:44:37  matthew
 * Adding NOT32 MIR instruction
 *
 * Revision 1.227  1996/05/10  09:55:02  matthew
 * Fixing problem with unsigned comparison
 *
 * Revision 1.226  1996/05/07  11:13:49  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.225  1996/04/30  17:05:20  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.224  1996/04/29  15:31:34  matthew
 * removing MLWorks.Integer
 *
 * Revision 1.223  1996/02/02  12:58:58  jont
 * Add implemetatins of ADDW and SUBW
 * These are like ADDS and SUBS, except that
 * they cannot use TADD etc because they are untagged
 * and also when they detect overflow they must clean
 * all registers involved in the operation
 *
Revision 1.222  1995/12/22  13:10:25  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.221  1995/11/20  17:06:35  jont
Modification for improved runtime env spill offsets
to indicate the kind of data spilled

Revision 1.220  1995/09/22  15:53:01  jont
Fix bug in compiler crash when number of fp spill slots exceeded

Revision 1.219  1995/08/10  14:50:28  jont
Fix constant unsigned comparison case of MirTypes.TEST

Revision 1.218  1995/07/28  10:13:27  matthew
Putting sources registers for various instructions in correct order

Revision 1.217  1995/07/28  03:01:51  io
mirtypes.test confuses imm32 case

Revision 1.216  1995/07/25  13:47:19  jont
Add WORD to value_cg

Revision 1.215  1995/07/19  12:04:01  jont
Add CHAR to value_cg

Revision 1.214  1995/07/11  16:19:37  jont
Sort out shifts as per revised basis with range testing etc.

Revision 1.213  1995/05/26  14:07:20  matthew
Commenting out diagnostic stuff

Revision 1.212  1995/05/24  09:44:43  matthew
Adding needs_unaligned_zero

Revision 1.211  1995/05/02  11:33:19  matthew
Removing debug_polyvariables option

Revision 1.210  1995/02/15  12:35:13  matthew
Debugger_Types changes
Abstraction of debug information
Annotate CALL instruction

Revision 1.209  1995/01/30  14:54:52  matthew
Rationalizing debugger

Revision 1.208  1994/11/28  16:52:25  matthew
Change "real too big" message to "real unrepresentable"

Revision 1.207  1994/11/28  15:14:49  matthew
Fix problem with floor.

Revision 1.206  1994/11/23  13:24:33  matthew
Add ALLOC_VECTOR

Revision 1.205  1994/11/16  12:16:44  jont
Add support for immediate store operation

Revision 1.204  1994/10/13  11:23:04  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.203  1994/10/05  12:02:37  jont
Changes for new NEW_HANDLER instruction

Revision 1.202  1994/09/23  11:43:20  matthew
Abstraction of debug information

Revision 1.201  1994/09/12  15:51:21  jont
Handle constant operands to tests

Revision 1.200  1994/09/02  15:27:11  jont
Remove checks for lr used in ALLOC

Revision 1.199  1994/08/26  14:05:39  matthew
Change to interface to stack extension

Revision 1.198  1994/08/24  16:17:04  jont
Remove dependence on mir optimiser for fp registers used

Revision 1.197  1994/07/25  11:07:05  matthew
Added register lists to BRANCH_AND_LINK, TAIL_CALL and ENTER instructions.

Revision 1.196  1994/07/22  16:04:48  nickh
Add new allocation routine.

Revision 1.195  1994/07/22  15:03:04  jont
Modify for new code_module

Revision 1.194  1994/07/13  12:05:57  jont
Fix to avoid lr unspilling alloc

Revision 1.193  1994/06/24  14:17:36  jont
Updates to use lr as unspill register

Revision 1.192  1994/06/22  14:50:27  jont
Update debugger information production

Revision 1.191  1994/06/22  13:48:32  jont
Added leaf case switches

Revision 1.190  1994/06/13  09:51:41  nickh
New runtime directory structure.

Revision 1.189  1994/06/10  09:49:51  jont
Restore floating point callee saves before tailing

Revision 1.188  1994/05/27  15:11:34  jont
Modify fp_save_start to be calculated from fp_save_offset, fp_save_size
and float_value_size, ensuring double alignment if necessary

Revision 1.187  1994/05/25  10:23:21  jont
Fix shift of constant by constant problems

Revision 1.186  1994/05/23  17:23:50  jont
Fix floating point spill alignment problem

Revision 1.185  1994/05/12  13:40:24  richard
Add loop entry to MirTypes.PROC_PARAMS.

Revision 1.184  1994/04/07  09:52:05  jont
Fixed stack initialisation to cope with starting on a non-aligned boundary

Revision 1.183  1994/03/24  14:00:25  jont
Work on avoiding initialisation of stack slots

Revision 1.182  1994/03/23  16:15:12  matthew
Changed the other restore instruction.

Revision 1.181  1994/03/23  15:29:11  nickh
Fix restore instruction to match that commonly generated.

Revision 1.180  1994/03/18  18:43:33  jont
Fix bug introduced in fp register saving by stack rationalisation

Revision 1.179  1994/03/18  12:34:42  jont
Fix bug in float spill area alignment
Rationalise stack layout information

Revision 1.178  1994/03/11  12:09:36  jont
Fix code generation of LEO for mutually recursive function case

Revision 1.177  1994/03/09  17:16:42  jont
Added code generation of load_offset.
Added handling of case where load_offset can't be one instruction
similar to case where adr expands to more than one

Revision 1.176  1994/03/08  18:20:01  jont
Remove module type to separate file

Revision 1.175  1994/03/04  12:42:20  jont
Moved machspec into main

Revision 1.174  1994/02/28  09:40:45  nosa
Debugger_info for some more debugger options.

Revision 1.173  1994/02/25  13:54:18  daveb
Preventing generation of unnecessary debug information.

Revision 1.172  1994/01/18  11:45:50  daveb
Dummy entry to keep in synch with Hope, after I accidentally checked in
an unchanged version to Hope.

Revision 1.171  1994/01/18  11:45:50  daveb
Added comment to FLOOR case.

Revision 1.171  1994/01/18  11:20:54  daveb
Added comment to FLOOR case.

Revision 1.170  1993/12/17  10:38:42  io
moved mach_cg to main/

Revision 1.169  1993/12/10  13:57:30  jont
Put in Simon's suggestions to use a common large number splitting
mechanism throughout, and spot the previously non-optimal case

Revision 1.168  1993/11/22  12:47:10  daveb
Replaced TADDCC instruction with TADDCCTV, and removed explicit exception
handling from built-in arithmetic operators.

Revision 1.167  1993/11/05  16:17:39  jont
Added proper compilation of INTERRUPT instruction

Revision 1.166  1993/11/04  16:46:11  jont
Added (currently trivial) code generation of INTERRUPT instruction

Revision 1.165  1993/10/05  17:07:34  jont
Merged in bug fixes

Revision 1.164  1993/09/06  09:51:10  nosa
Record compiler option debug_polyvariables in Debugger_Types.INFO
for recompilation purposes.

Revision 1.163.1.2  1993/10/05  13:24:30  jont
Put a handler around the part of value_cg dealing with reals to turn
conversion errors into compilation errors

Revision 1.163.1.1  1993/08/26  13:19:57  jont
Fork for bug fixing

Revision 1.163  1993/08/26  13:19:57  jont
Modified leaf test to look at the actual registers used by a function
rather than believing the output from the mir optimiser

Revision 1.162  1993/08/13  14:01:15  simon
Fixed extended-float save and restore.

Revision 1.161  1993/08/06  14:31:34  richard
Made NEW_HANDLER instruction force non-leaf.

Revision 1.160  1993/07/29  15:37:17  nosa
Debugger Environments and extra stack spills for local and closure
variable inspection in the debugger;
structure Option.

Revision 1.159  1993/07/23  16:12:49  jont
Fixed code generation of large integers to avoid stamping on other operands
by using G4 only when safe and using the result register otherwise.

Revision 1.158  1993/07/08  18:08:13  jont
Modified the TBINARY operations to shorten the normal (non-exceptional) path

Revision 1.157  1993/05/18  16:22:48  jont
Removed integer parameter

Revision 1.156  1993/05/05  12:03:31  jont
Improved coding of MirTypes.ENTRY so that simple stack requiring procedures
have a one instruction shorter entry sequence

Revision 1.155  1993/04/27  10:58:48  richard
Changed PROFILE instruction to INTERCEPT.

Revision 1.154  1993/04/19  09:59:24  jont
Added leaf raise code

Revision 1.153  1993/04/16  16:03:30  jont
Added some important comments about adr

Revision 1.152  1993/04/15  12:05:08  jont
OLD_HANDLER now generates handler chain pop

Revision 1.151  1993/03/23  16:04:31  jont
Changed bytearray implementation to use ref tags. Tidied up some
explicit integers into references to TAGS

Revision 1.150  1993/03/17  18:22:07  jont
Produced leaf and code vector intercept offset for each procedure
and added this into WORDSET

Revision 1.149  1993/03/12  11:49:59  matthew
Signature revisions

Revision 1.148  1993/03/05  12:57:26  matthew
Options & Info changes

Revision 1.147  1993/03/01  15:27:33  matthew
Changed value datatype
Added MLVALUEs

Revision 1.146  1993/02/10  13:58:35  jont
Changes for code vector reform.

Revision 1.145  1993/01/28  14:49:43  jont
Improved code generation of switches. Improved code generation of
sequences near calls and tails to allow better scheduling

Revision 1.144  1993/01/05  16:14:20  jont
Modified to return final machine code in an easily printed form

Revision 1.143  1992/12/24  11:53:01  clive
Fixed small bugs in arithmetic of two immediates

Revision 1.142  1992/12/17  16:39:38  matthew
Changed int and real scons to carry a location around

Revision 1.141  1992/12/15  10:48:04  clive
Raised Info.errors for overflow of constants during code generation

Revision 1.140  1992/12/08  11:01:57  clive
Changed the type of nop used for tracing to stop it being moved by the scheduler

Revision 1.139  1992/12/03  11:58:29  clive
Changed the sense of the branch in the stack-overflow checking code

Revision 1.138  1992/12/01  14:52:10  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.137  1992/11/20  16:28:54  daveb
Replaced a call to Print.print with one to Diagnostic.output.

Revision 1.136  1992/11/17  14:31:58  matthew
Changed Error structure to Info

Revision 1.135  1992/11/13  16:26:52  clive
Added the generation of 3 NOP instructions for the purposes of tracing
(if the correct flag is set to true )

Revision 1.134  1992/11/03  11:53:23  jont
Reworked in terms of mononewmap

Revision 1.133  1992/10/30  11:52:00  jont
Changed maps used on tags to that provided by mirtypes for efficiency

Revision 1.132  1992/10/09  10:53:07  clive
Fixed bug in the size put in the header of a double

Revision 1.131  1992/10/07  12:55:02  clive
check_range did an abs which failed on most negative integer

Revision 1.130  1992/10/05  10:12:36  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.129  1992/09/29  14:24:41  clive
Got floor working

Revision 1.128  1992/09/22  11:11:28  clive
When ordof used, the exception in Ord needed to be caught instead of substring

Revision 1.127  1992/09/16  09:42:47  clive
Removed some handles of hashtable lookup exceptions

Revision 1.126  1992/09/15  11:36:07  clive
Added argument value checking to floor

Revision 1.125  1992/09/11  14:28:30  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.124  1992/09/09  17:01:55  jont
Made all moves use OR instead of ADD

Revision 1.123  1992/09/02  14:34:00  jont
Changed mir register to mach register translation to array lookup

Revision 1.122  1992/08/26  16:34:31  jont
Removed some redundant structures and sharing

Revision 1.121  1992/08/26  11:39:55  clive
Samm bug fix - debug info was incremented but not stored back

Revision 1.120  1992/08/25  16:19:18  richard
Implemented ALLOC_BYTEARRAY, and the NULLARY operation CLEAN.

Revision 1.119  1992/08/25  13:29:29  clive
Added details about leafness to the debug information

Revision 1.118  1992/08/14  13:46:12  davidt
Changed ord(substring ...) to ordof.

Revision 1.117  1992/08/07  18:18:38  davidt
String structure is now pervasive.

Revision 1.116  1992/08/04  16:42:39  jont
Removed references to save

Revision 1.115  1992/07/29  15:58:44  jont
Added floating point save and restore code

Revision 1.114  1992/07/23  15:35:32  jont
Removed some messages

Revision 1.113  1992/07/16  08:49:59  clive
Corrected an uncaught MLWorks.String.Substring

Revision 1.112  1992/07/14  16:16:26  richard
Removed obsolete memory profiling code.

Revision 1.111  1992/07/07  13:55:18  clive
Added call point information recording

Revision 1.110  1992/07/03  14:50:53  jont
Modified stack clearing code to use double wort stores where possible

Revision 1.109  1992/07/02  10:50:00  jont
Allowed translation of tagged binary operations where both arguments
are constant

Revision 1.108  1992/07/01  17:03:44  jont
Fixed leaf case profiling so it refers to the correct closure register

Revision 1.107  1992/06/30  13:45:31  jont
Made TAIL_CALL allowable in leaf procedures

Revision 1.106  1992/06/29  14:37:22  jont
Changed to build sexpressions in order to avoid quadratic behaviour
of appends

Revision 1.105  1992/06/29  13:02:04  clive
Added type annotation information at application points

Revision 1.104  1992/06/25  16:58:11  jont
Corrected code to generate unary not. Split out of code for move

Revision 1.103  1992/06/25  16:01:12  richard
Reimplemented the allocation code to deal with large
constant-sized objects.  Also corrected some problems with
variable-sized objects.  The code should now be smaller and
faster.

Revision 1.102  1992/06/22  13:26:34  richard
Implemented tagged floating point instructions.  At the moment
they do not catch infinity.

Revision 1.101  1992/06/19  11:33:32  richard
Added parameter to RAISE once again, and changed leaf-case raise
to fetch from that parameter.

Revision 1.100  1992/06/18  15:19:32  jont
Added stuff to pass through interpretive externals,
and split raise code into leaf and non-leaf cases

Revision 1.99  1992/06/17  17:35:41  jont
Allowed leaf case raise. Doesn't work yet because of mirtables

Revision 1.98  1992/06/17  15:45:18  richard
Enabled leaf case allocation.

Revision 1.97  1992/06/16  19:50:40  jont
Changed stack overflow check to be unsigned.
Added (temporary) handling for externals defined by interpreter

Revision 1.96  1992/06/12  17:26:20  jont
Improved profiling so as not to affect leafness
Removed various redundant loads (should be expression analyser)

Revision 1.95  1992/05/26  14:54:00  richard
Changed gc_trans to deal with new types returned by MirTables.

Revision 1.94  1992/05/21  18:13:52  jont
Fixed problem in enter coding to ensure stack slots cleared.

Revision 1.93  1992/05/11  15:10:57  clive
Added memory profiling

Revision 1.92  1992/05/11  13:31:13  jont
Fixed up discrepancy between split_int and gp_check_range

Revision 1.91  1992/05/08  20:17:34  jont
Added bool ref do_timings to control printing of timings for various stages

Revision 1.90  1992/05/06  10:51:41  richard
Changed BalancedTree to generic Map

Revision 1.89  1992/05/05  12:56:24  clive
With the addition of the extra slots in the code and the addition of diagnostic information,
the tag offset calculations needed to be changed

Revision 1.88  1992/04/29  15:27:40  jont
Redid the reorderer for the lineariser efficiently

Revision 1.87  1992/04/24  15:15:39  clive
Fixed bug in array allocation: if a gc occurred inside the allocation, 2 words too few were allocated
Also added function name printing to the sparc code output

Revision 1.86  1992/04/14  11:40:10  clive
First version of the profiler

Revision 1.85  1992/04/03  13:07:05  jont
Removed some pervasive references to hd, length etc. Added a type
specifier to an overloaded use of +. Added error detection for
incorrect stack allocations

Revision 1.84  1992/03/31  17:51:51  jont
Forced relinearisation to fix up out of range ADRs to recalculate
the tag table

Revision 1.83  1992/03/10  11:23:44  jont
Fixed up problem with out of range ADR instructions by recursing the
lineariser

Revision 1.82  1992/03/05  11:28:53  clive
If there is a word added for double alignment, then this needs to be zeroed out
before it confuses the garbage collector

Revision 1.81  1992/02/25  18:10:27  jont
Added checking on the use use spill slots. Also avoided using
spill slot 0 as the address of the gc stack area.

Revision 1.80  1992/02/11  10:51:10  clive
New pervasive library code

Revision 1.79  1992/02/07  11:09:50  richard
Changed register lookup to use Map instead of Table.  See changes in
MirRegisters.  See mirregisters.sml revision 1.13.

Revision 1.78  1992/02/06  14:28:04  clive
Tail call to a tag had a baa followed by a restore instead of ba followed by restore

Revision 1.77  1992/02/06  10:20:03  richard
Removed obsolete PRESERVE_ALL_REGS and PREVIOUS_ENVIRONMENT
MIR instructions.

Revision 1.76  1992/02/03  16:57:17  clive
Tried to speed the file up (factor of 2-3) - removed invariant code
from function calls

Revision 1.75  1992/01/31  14:29:27  clive
Removed some redundant code

Revision 1.74  1992/01/24  09:47:39  clive
Fixed computed gotos

Revision 1.73  1992/01/23  17:20:50  clive
Removed the dummy instruction that is pushed onto blocks of the wrong size
to double-word align them - this is done elsewhere, and the blocks were
being thrown away anyway

Revision 1.72  1992/01/21  15:40:09  clive
Allocation wasn't working correctly

Revision 1.71  1992/01/17  16:53:38  clive
Added alignment check for alloc of an array

Revision 1.70  1992/01/16  16:24:17  clive
Added things needed to support arrays - rearranged link fields in references,
changed so that ALLOC(REF) can take a register value argument

Revision 1.69  1992/01/15  15:59:52  clive
TAIL_CALL of register had an offset of 4 instead of an offset of 3 (typo)

Revision 1.68  1992/01/15  15:16:56  richard
Added a missing factor of four when jumping to the raise code.

Revision 1.67  1992/01/15  12:03:48  clive
Code bodies tagged incorrectly with non_gc_spill_size instead of non_gc_stack_size

Revision 1.66  1992/01/14  15:34:56  clive
Added a non_gc number in front of each code object in a closure,
Got mutually recursive functions working as there were problems with
alignment in the existing implementation

Revision 1.65  1992/01/13  10:35:44  clive
A working version of the stack checking code, calling code on the implicit vector

Revision 1.64  1992/01/10  17:39:54  clive
More code for the stack limit checking added

Revision 1.63  1992/01/09  15:15:57  clive
Added check for header actually fitting immediate in do_header, and work on stack_limit
checking code

Revision 1.62  1992/01/08  18:23:55  jont
Added require for implicit

Revision 1.61  1992/01/08  16:30:06  clive
Started work on runtime stack limit checking, now gets offsets in implicit vector
from the structure defined in rts, adr took no notice of the tag argument

Revision 1.60  1992/01/07  16:48:30  clive
Started adding stack limit code on procedure entry

Revision 1.59  1992/01/06  17:22:27  jont
Changed all prints to Print.print

Revision 1.58  1992/01/03  12:49:08  richard
Added code to call ml_preserve for the PRESERVE opcode.

Revision 1.57  1992/01/02  13:32:58  richard
Removed the SAVE instruction generated by the PRESERVE instruction.
This will need to be replaced with something useful at some point.

Revision 1.56  1991/12/19  16:56:30  richard
Changed offsets in CALL instructions to point
to the right place.

Revision 1.55  91/12/09  15:23:04  richard
Added a missing NOP after the in-line CALL_C code.

Revision 1.54  91/12/06  17:47:29  jont
Removed some superfluous debugging output

Revision 1.53  91/12/05  18:38:53  jont
Fixed code to do stack initialisation, and added more optimal versions
where the size is small.

Revision 1.52  91/12/04  19:15:41  jont
Improved coding for tail calls by putting restore in delay slot

Revision 1.51  91/12/03  15:25:06  jont
Improved lineariser slightly

Revision 1.50  91/12/02  20:26:17  jont
Added implementation of tail call

Revision 1.49  91/11/29  18:26:17  jont
Fixed minor bug in continuation block spotting

Revision 1.48  91/11/28  18:37:45  jont
Added stack initialisation of gc areas.

Revision 1.47  91/11/28  15:01:30  jont
Fixed problem of procedures without exits (eg fun f x = raise Match)

Revision 1.46  91/11/27  19:42:01  jont
Improved lineariser by spotting blocks terminating with branches with
delay slots

Revision 1.45  91/11/26  15:22:37  jont
*** empty log message ***

Revision 1.44  91/11/25  19:09:05  jont
Minor changes. Experimenting with save/restore optimisation

Revision 1.43  91/11/21  15:15:24  jont
Added reference to save for optimising save/restore use (perhaps)

Revision 1.42  91/11/20  17:13:34  jont
Moved some functions out into MachTypes

Revision 1.41  91/11/20  14:18:32  jont
Changed coding of conversion operations
Added (unimplemented) exception generating fp opcodes

Revision 1.40  91/11/18  16:24:42  jont
Implemented FTEST. Added it to the lineariser

Revision 1.39  91/11/14  15:27:08  jont
Added more real stuff, plus translation of new CALL_C

Revision 1.38  91/11/14  10:54:50  richard
Removed references to fp_double registers.

Revision 1.37  91/11/13  18:48:24  jont
Added more floating point, unary, binary, more stores. Also added
support for symbolic values

Revision 1.36  91/11/12  16:25:34  jont
Added real loads, stores and conversion operations

Revision 1.35  91/11/11  17:04:51  jont
Added encoding and output of reals

Revision 1.34  91/11/08  18:21:16  jont
Added code for STACK_OPs. Added show_mach for controlling opcode listing

Revision 1.33  91/11/08  16:41:45  richard
Added extra argument to STACKOP, as yet unimplemented.

Revision 1.32  91/11/08  14:58:09  jont
Corrected pointers produced by ALLOCATE_STACK to be correctly tagged

Revision 1.31  91/10/31  13:28:21  jont
Added ALLOC_REAL

Revision 1.30  91/10/30  17:47:54  jont
Added ALLOCATE_STACK coding, plus use of various stack sizes provided
by previous stage.

Revision 1.29  91/10/29  17:36:16  davidt
Fixed printing of sparc assembly code.

Revision 1.28  91/10/29  16:41:39  davidt
Does proper check to see whether a preserve is required. Changed
various prints to Print.prints.

Revision 1.27  91/10/29  14:20:40  jont
Added improved linearisation top block choice.

Revision 1.26  91/10/28  16:10:01  richard
Changed the structure of the allocation instructions yet again. This
change is to allow offsets to be inserted for stack allocation. It's
also a bit more orthogonal.

Revision 1.25  91/10/28  15:47:47  jont
Fixed bug in instruction swapping where store interactions might occur
Added large constant handling everywhere
Started on better algorithm for choosing best next block for lineariser

Revision 1.24  91/10/28  11:24:52  davidt
Changed code generated for ALLOCATE to use the implicit vector to
call the garbage collector instead of having the garbage collector
mentioned in the function closure.

Revision 1.23  91/10/25  17:01:51  davidt
General tidy up and re-implementation of allocation code to use
the garbage collector entry point contained in the the implicit
vector. The global register is now used as a temporary so we
don't need a special temporary register (or call_c code either).

Revision 1.22  91/10/24  16:56:42  jont
Started adding code to deal with constants too large for the
instructions which require them.

Revision 1.21  91/10/24  14:21:17  jont
Updated to use the results of the instruction scheduler

Revision 1.20  91/10/24  10:48:49  jont
Added BTA and BNT for tagged value testing

Revision 1.19  91/10/23  15:52:18  jont
Added range checking on immediate values

Revision 1.18  91/10/22  18:15:06  jont
Added fall through branch elimination, along with block reordering
to make this more likely

Revision 1.17  91/10/22  15:25:38  jont
Added code to attempt fall through elimination.
Fixed faulty encoding of RESTORE

Revision 1.16  91/10/21  15:51:53  jont
Handled cgt. Modified call to strip out tag bits

Revision 1.15  91/10/18  18:24:37  jont
Got strings and procs incorrect order (strings first)

Revision 1.14  91/10/18  16:23:30  jont
Coded ALLOC_STRING.

Revision 1.13  91/10/17  17:57:34  jont
Revised code generation for linearisation to allow for mutually
recusrive functions. New ALLOC in place, ready for real calls to c

Revision 1.12  91/10/16  14:13:33  jont
Updated to reflect new simplified module structure
Added parameter to heap allocation to indicate position in closure
of call_c function

Revision 1.11  91/10/15  17:20:04  jont
Added code encapsulation code

Revision 1.10  91/10/14  15:03:10  jont
Got leaf procedures working. Optimised out MOV to self.
Did tagged operations and exception raising.

Revision 1.9  91/10/11  17:37:55  jont
Did load/store with register indexing, and reverse subtracts.
Also added stuff to spot procedures not requiring frames.

Revision 1.8  91/10/11  10:59:31  richard
Slight alterations to cope with new MirTypes.

Revision 1.7  91/10/10  16:48:34  jont
Added support for adr, and added delay slots to CALLs and JMPLs

Revision 1.6  91/10/10  15:15:38  jont
Added BLR and BSR. Altered to use new improved MirTypes

Revision 1.5  91/10/09  18:30:23  jont
More code generation, plus comments and linearisation

Revision 1.4  91/10/08  19:05:25  jont
More work on proc_cg
Pased results out into module structure

Revision 1.3  91/10/07  16:35:29  jont
Started on proc_cg

Revision 1.2  91/10/07  12:16:04  richard
Changed dependencies on MachRegisters to MachSpec.

Revision 1.1  91/10/04  16:19:17  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "$.basis.__int";
require "$.basis.__string";

require "../utils/print";
require "../utils/mlworks_timer";
require "../utils/lists";
require "../utils/crash";
require "../utils/diagnostic";
require "../utils/sexpr";
require "../basics/ident";
require "../main/reals";
require "../main/code_module";
require "../mir/mirtables";
require "../mir/mirregisters";
require "../rts/gen/implicit";
require "../rts/gen/tags";
require "../main/info";
require "../main/options";
require "../main/machspec";
require "sparc_schedule";
require "../main/mach_cg";

functor Mach_Cg(
  structure Tags : TAGS
  structure Print : PRINT
  structure Timer : INTERNAL_TIMER
  structure Lists : LISTS
  structure Crash : CRASH
  structure Info : INFO
  structure Options : OPTIONS
  structure Sexpr : SEXPR
  structure Reals : REALS
  structure Ident : IDENT
  structure MirTables : MIRTABLES
  structure MirRegisters : MIRREGISTERS
  structure MachSpec : MACHSPEC
  structure Code_Module : CODE_MODULE
  structure Sparc_Schedule : SPARC_SCHEDULE
  structure Implicit_Vector : IMPLICIT_VECTOR
  structure Diagnostic : DIAGNOSTIC

  sharing Info.Location = Ident.Location
  sharing MirTables.MirTypes.Set = MachSpec.Set
  sharing MirTables.MirTypes = MirRegisters.MirTypes = Sparc_Schedule.Sparc_Assembly.MirTypes

  sharing type Ident.SCon = MirTables.MirTypes.SCon

  sharing type Sparc_Schedule.Sparc_Assembly.Sparc_Opcodes.MachTypes.Sparc_Reg
    = MachSpec.register
     ) : MACH_CG =
struct
  structure Sparc_Assembly = Sparc_Schedule.Sparc_Assembly
  structure Sparc_Opcodes = Sparc_Assembly.Sparc_Opcodes
  structure MirTypes = MirTables.MirTypes
  structure MachTypes = Sparc_Opcodes.MachTypes
  structure MachSpec = MachSpec
  structure Diagnostic = Diagnostic
  structure Debugger_Types = MirTypes.Debugger_Types
  structure Map = MirTypes.Map
  structure Ident = Ident
  structure Set = MirTypes.Set
  structure Info = Info
  structure RuntimeEnv = Debugger_Types.RuntimeEnv
  structure Options = Options

  structure Bits = MLWorks.Internal.Bits

  type Module = Code_Module.Module
  type Opcode = Sparc_Assembly.opcode

  val do_timings = ref false

  val trace_dummy_instructions =
    [(Sparc_Assembly.other_nop_code,NONE,"Dummy instructions for tracing"),
     (Sparc_Assembly.other_nop_code,NONE,"Dummy instructions for tracing"),
     (Sparc_Assembly.other_nop_code,NONE,"Dummy instructions for tracing")]

  val do_diagnostic = false
  fun diagnostic_output level =
    if do_diagnostic then Diagnostic.output level else fn f => ()

  val print_code_size = ref false

  val arith_imm_limit = 4096 (* 2 ** 12 *)
  val branch_disp_limit = 512 * 4096 (* 2 ** 21 *)
  val call_disp_limit = 16 * 256 * 256 * 256 (* 2 ** 28 *)

  (* Note that this has been reduced in order to stay positive within *)
  (* our system, which allows30 bit signed integers *)

  fun contract_sexpr(Sexpr.NIL, [], acc) =
    Lists.reducel (fn (x, y) => y @ x) ([], acc)
    | contract_sexpr(Sexpr.NIL, x :: xs, acc) = contract_sexpr(x, xs, acc)
    | contract_sexpr(Sexpr.ATOM x, to_do, acc) =
      contract_sexpr(Sexpr.NIL, to_do, x :: acc)
    | contract_sexpr(Sexpr.CONS(x, y), to_do, acc) =
      contract_sexpr(x, y :: to_do, acc)

  val contract_sexpr =
    fn x => contract_sexpr(x, [], [])

  (* This is intended to find the offset of the intercept instructions from *)
  (* the beginning of the code *)
  fun find_nop_offsets(_, []) = ~1
    | find_nop_offsets(offset, (opcode, _) :: rest) =
      if opcode = Sparc_Assembly.other_nop_code then
	offset
      else
	find_nop_offsets(offset+1, rest)

  val find_nop_offsets = fn (tag, code) => find_nop_offsets(0, code)

  fun check_range(i:int, signed, pos_limit) =
    if signed then
	(i >= 0 andalso i < pos_limit) orelse
	(i < 0 andalso i >= ~pos_limit)
    else i >= 0 andalso i < pos_limit

  fun fault_range(i, signed, pos_limit) =
    if check_range(i, signed, pos_limit) then i
    else
      (diagnostic_output 3
       (fn _ => ["fault_range called with value ",
		 Int.toString i,
		 " in positive range ",
		 Int.toString pos_limit]);
       Crash.impossible"Immediate constant out of range" )

  fun make_imm_fault(i, signed, max_pos) =
    let
      val _ = fault_range(i, signed, max_pos)
      val res = Sparc_Assembly.IMM i
    in
      res
    end

  fun mantissa_is_zero mantissa =
    let
      val exp_mant = explode mantissa
      fun exp_mant_is_zero [] = true
      | exp_mant_is_zero(#"0" :: xs) = exp_mant_is_zero xs
      | exp_mant_is_zero _ = false
    in
      exp_mant_is_zero exp_mant
    end

  fun binary_list_to_string(done, [], _, 128) = concat(rev done)
  | binary_list_to_string(_, [], _, l) =
    Crash.impossible("Binary_list_to_string length not 8, remainder length " ^
		     Int.toString l)
  | binary_list_to_string(done, x :: xs, digit, power) =
    let
      val x = MLWorks.String.ord x - ord #"0"
    in
      if power = 1 then
	binary_list_to_string(String.str(chr(digit + x)) :: done, xs, 0, 128)
      else
	binary_list_to_string(done, xs, digit + x * power, power div 2)
    end

  fun to_binary(digits, value) =
    let
      fun to_sub(0, _, done) = done
      | to_sub(digs_to_go, value, done) =
	let
	  val digit = String.str(chr(value mod 2 + ord #"0"))
	in
	  to_sub(digs_to_go - 1, value div 2, digit :: done)
	end
    in
      to_sub(digits, value, [])
    end

  fun n_zeroes(done, 0) = done
  | n_zeroes(done, n) = n_zeroes("0" :: done, n-1)

  fun adjust (error_info,x,location) (mantissa, exponent, max_exponent, bits) =
    if mantissa_is_zero mantissa then
      (mantissa, 0)
    else
      if exponent > 0 andalso exponent < max_exponent then
	(mantissa, exponent)
      else
	(* Need to handle subnormal numbers *)
	if exponent >= max_exponent then
	  Info.error'
          error_info
          (Info.FATAL,location,
           "Real number unrepresentable: " ^ x)
	else
	  if exponent < ~bits then (concat(n_zeroes([], bits)), 0)
	  else
	    (concat(n_zeroes([], abs exponent)) ^ mantissa, 0)

  fun to_single_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 127
      val (mantissa, real_exponent) = adjust args (mantissa, real_exponent, 255, 23)
      val binary_list =
	(if sign then "1" else "0") ::
	   to_binary(8, real_exponent) @
	   (map str (explode (MLWorks.String.substring (mantissa, 1, 23))))
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun to_double_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 1023
      val (mantissa, real_exponent) = adjust args (mantissa, real_exponent, 2047, 52)
      val binary_list =
	(if sign then "1" else "0") ::
	   to_binary(11, real_exponent) @
	   (map String.str
                (explode(MLWorks.String.substring (mantissa, 1, 52))))
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun to_extended_string args (sign, mantissa, exponent) =
    let
      val real_exponent = exponent + 16383
      val (mantissa, real_exponent) =
	adjust args (mantissa, real_exponent, 32767, 63)
      val binary_list =
	(if sign then "1" else "0") ::
	   to_binary(15, real_exponent) @
	   n_zeroes([], 16) @
	   (map String.str 
                (explode(MLWorks.String.substring (mantissa, 0, 64)))) @
	   n_zeroes([], 32)	
    in
      binary_list_to_string([], binary_list, 0, 128)
    end

  fun value_cg(i, MirTypes.SCON (Ident.STRING x),_) = Code_Module.STRING(i, x)
    | value_cg(i, MirTypes.SCON (Ident.REAL(x,location)),error_info) =
      (let
	 val the_real = Reals.evaluate_real x
	 val (sign, mantissa, exponent) = Reals.find_real_components the_real
	 val encoding_function = case MachTypes.fp_used of
	   MachTypes.single => to_single_string (error_info,x,location)
	 | MachTypes.double => to_double_string (error_info,x,location)
	 | MachTypes.extended => to_extended_string (error_info,x,location)
       in
	 Code_Module.REAL(i, encoding_function(sign, mantissa, exponent))
       end handle MLWorks.Internal.StringToReal =>
	 Info.error'
	 error_info
	 (Info.FATAL, location, "Real number unrepresentable: " ^ x)
      )
    | value_cg(_, MirTypes.SCON (Ident.INT _),_) = Crash.impossible"VALUE(INT)"
    | value_cg(_, MirTypes.SCON (Ident.CHAR _),_) = Crash.impossible"VALUE(CHAR)"
    | value_cg(_, MirTypes.SCON (Ident.WORD _),_) = Crash.impossible"VALUE(WORD)"
    | value_cg (i,MirTypes.MLVALUE value,_) =
      Code_Module.MLVALUE (i,value)

  val absent = NONE

  (* A function to return the terminating branch of a block if one exists *)
  fun last_opcode [] = (Sparc_Assembly.nop, false)
    | last_opcode [elem as (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
                            _, _)] =
      (elem, true)
    (* Computed GOTOS must be treated specially *)
    | last_opcode([(Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
                            _, _),
                   elem as (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
                            _, _)]) =
     (elem, true)
    | last_opcode([elem as (Sparc_Assembly.BRANCH(Sparc_Assembly.BA, _), _, _),
                   _]) =
      (elem, true)
  | last_opcode([elem as (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _),
			  _, _),
		 _]) =
     (elem, true)
  | last_opcode(_ :: xs) = last_opcode xs

  fun make_proc_info(res as (main_tree, tag_tree), []) = res
    | make_proc_info((main_tree, tag_tree),
		     ((block_tag, opcode_list)) :: rest) =
      let
	val last_tag_exists as (tag, ok) = case last_opcode opcode_list of
	  ((_, SOME tag, _), true) => (tag, true)
	| _ => (block_tag, false)
      in
	make_proc_info
	((Map.define (main_tree, block_tag, last_tag_exists),
	  if ok then
	    Map.define (tag_tree, tag, 0)
	  else tag_tree), rest)
      end

  fun rev_app([], acc) = acc
    | rev_app(x :: xs, acc) = rev_app(xs, x :: acc)

  fun remove_trailing_branch(block_tag, opcode_list) =
    let
      val rev_opc = rev opcode_list
      val new_opc =
	case rev_opc of
	  (Sparc_Assembly.BRANCH_ANNUL _, _, _) :: rest => rest
	| (operation, opt, comment) :: (Sparc_Assembly.BRANCH _, _, _) :: rest =>
	    (operation, opt, comment ^ " preceding BA removed") :: rest
	| _ :: (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, _), _, _) :: rest => rest
	| _ =>
	    Crash.impossible"Remove trailing branch fails"
    in
      (block_tag, rev new_opc)
    end

  (* CT this now works on the continuer and non-continuer lists in turn *)
  fun find_dest_block(tag, [], [], x,y) = ((tag, []), false, x,y)
    | find_dest_block(dest_tag,
		      (block as (block_tag, opcode_list)) ::
		      rest,
		      other,
		      x , [] ) =
      if dest_tag = block_tag then
	(block, true, x @ rest, other)
      else find_dest_block(dest_tag, rest, other, block :: x,[])

    | find_dest_block(dest_tag,
		      [],
		      (block as (block_tag, opcode_list)) ::
		      rest,
		      x , y ) =
      if dest_tag = block_tag then
	(block, true, x , y @ rest)
      else find_dest_block(dest_tag, [], rest, x, block :: y)

    | find_dest_block _ =
      Crash.impossible "This should never happen in _mach_cg "

  (* Algorithm *)
  (* Start with the first block (entry block) *)
  (* Find the block it tails into, and append that *)
  (* Repeat until we end up with a block which either doesn't tail *)
  (* into an unused block (eg a loop), or doesn't tail at all (eg ret) *)
  (* Now find all blocks which tail into something *)
  (* and pick one from these which nothing tails into from these *)
  (* This is called a chain head *)
  (* Repeat as if we'd just started *)
  (* If no such block, pick one from the cycle and repeat as before *)
  (* If no blocks which tail at all, bung them on the end and finish *)
  (* A consequence of this algorithm is *)
  (* When searching for a new head of a chain, *)
  (* we need only check that a block which continues *)
  (* was never the target of another block (ie check at proc start) *)
  (* Because if it once was, and has now ceased to be *)
  (* Then it would have been processed already (reductio ad absurdum) *)
  fun reorder_blocks(proc as (proc_tag, block_list)) =
    (* Reorder the blocks for a proc so as to allow fall throughs *)
    (* Note that this will result in blocks with dangling ends *)
    (* So they must not be reordered again by any other means *)
    let
      val (proc_info, tag_tree) =
	make_proc_info((Map.empty , Map.empty), block_list)

      val proc_info_map = Map.tryApply proc_info
      val tag_tree_map = Map.tryApply tag_tree
      (* We don't have to repeatedly re-calculate the continuers lists *)
      fun do_fall_throughs_with_continuers_calculated(done, (block as (block_tag, opcode_list)),
                                                      continuers,non_continuers) =
        let
	  val (dest_tag, found_block) =
	    Map.apply_default'(proc_info, (block_tag, false), block_tag)

	  fun do_next() =
	    case continuers of
              (* CT this was rev(rev rest @ (block :: done)), but
               rev(rev rest @ (block::done)) = rev(block::done) @ rest
               = rev( [block] @ done) @ rest = rev done @ rev[block] @ rest
               = rev done @ (block :: rest)
               AND now rest = continuers @ non-continuers *)
	      [] =>
		rev_app(done, (block :: non_continuers))
	    | _ =>
		let
		  val (next_block, continuers') =
		    (let
		       val (tag, _) = Lists.findp
			 (fn (x, _) =>
			  case tag_tree_map x of
			    NONE => true
			  | _ => false)
			 continuers
		       val (others,value) =
			 Lists.assoc_returning_others(tag,continuers)
		     in
		       ((tag, value),others)
		     end) handle Lists.Find =>
		       (Lists.hd continuers, Lists.tl continuers)
		in
		  do_fall_throughs_with_continuers_calculated(block :: done,
							      next_block,
                                                              continuers',
							      non_continuers)
		end
	in
	  if found_block then
	    let
	      val (dest_block, found_dest, non_continuers',continuers') =
		find_dest_block(dest_tag, non_continuers, continuers, [] , [])
	    in
	      if found_dest then
		do_fall_throughs_with_continuers_calculated
		(remove_trailing_branch block :: done,
		 dest_block, continuers', non_continuers')
	      else
		 do_next()
	    end
	  else
	     do_next()
	end

      fun do_fall_throughs(done, block, []) = rev(block :: done)
      | do_fall_throughs(done, block,rest) =
	let
	  fun continues(tag, _) =
	    case proc_info_map tag of
	      SOME (_, t) => t
	    | _ => false

	  val (continuers,non_continuers) =
	    Lists.partition continues rest
        in
          do_fall_throughs_with_continuers_calculated(done,block,continuers,non_continuers)
        end

      val (hd_block_list, tl_block_list) = case block_list of
	x :: y => (x, y)
      | _ => Crash.impossible"Empty block list"
    in
      (proc_tag, do_fall_throughs([], hd_block_list, tl_block_list))
    end

  fun tag_offsets([], offset, tag_env) = (offset, tag_env)
    | tag_offsets((tag, ho_list) :: rest, disp, tag_env) =
      tag_offsets(rest, disp + 4 * (length ho_list),
		  Map.define (tag_env, tag, disp))


  fun tag_offsets_for_list(_, [], env) = env
    | tag_offsets_for_list(offset, (_, proc) :: rest, env) =
      let
	val (next_offset, env) = tag_offsets(proc, offset, env)
	val next_offset' =
	  next_offset + 4 (* Back-pointer *) + 4 (* Procedure number within set *)
	val next_offset'' =
	  if next_offset' mod 8 = 4
	    then next_offset'+4
	  else next_offset'
      in
	tag_offsets_for_list(next_offset'', rest, env)
      end

  exception bad_offset of
  MirTypes.tag * (Sparc_Assembly.opcode * MirTypes.tag option * string) list

  fun do_little_block(block as (tag, opcode_list)) =
    case opcode_list of
      [ins,
       (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, i), SOME tag', comm),
       _] =>
      (tag,
       [(Sparc_Assembly.BRANCH(Sparc_Assembly.BA, i), SOME tag', comm),
	 ins])
     | _ => block

  fun reschedule_little_blocks(proc_tag, block_list) =
    (proc_tag, map do_little_block block_list)

  fun linearise_list proc_list =
    let
      val new_proc_list =
	Timer.xtime
	("reordering blocks", !do_timings,
	 fn () => map reorder_blocks proc_list)

      (* We'd now like to reschedule any small blocks that branch backwards *)

      val new_proc_list = map reschedule_little_blocks new_proc_list

      fun do_linearise proc_list =
	let

	  val tag_env = tag_offsets_for_list(0, proc_list, Map.empty)

	  val _ = diagnostic_output 3 (fn _ => ["Tag_env ="])
	  val _ =
	    diagnostic_output 3
	    (fn _ => (ignore(map
	     (fn (x, y) => Print.print("Tag " ^ MirTypes.print_tag x ^ ", value " ^ Int.toString y ^ "\n"))
		      (Map.to_list tag_env)) ;
		      [] ))

	  fun lookup_env tag = Map.tryApply'(tag_env,tag)

	  fun rev_map f arg =
	    let
	      fun map_sub([], acc) = acc
		| map_sub(x :: xs, acc) = map_sub(xs, f x :: acc)
	    in
	      map_sub arg
	    end

	  fun rev_app([], y) = y
	    | rev_app(x :: xs, y) = rev_app(xs, x :: y)

	  fun copy_n(n, from, acc, new_tail) =
	    if n < 0 then
	      Crash.impossible"copy_n negative arg"
	    else
	      if n = 0 then
		rev_app(acc, new_tail)
	      else
		case from of
		  (x :: xs) =>
		    copy_n(n-1, xs, x :: acc, new_tail)
		| _ => Crash.impossible"copy_n short list"

	  fun drop(n, the_list) =
	    if n < 0 then
	      Crash.impossible"drop negative arg"
	    else
	      if n = 0 then the_list
	      else
		case the_list of
		  [] => Crash.impossible"drop bad list"
		| _ :: rest => drop(n-1, rest)

	  fun linearise_proc(_, offset, [], done) = (offset, rev done)
	    | linearise_proc(proc_offset, start, blocks as (block :: block_list), done) =
	      let
		(* Insert algorithm for optimal linearisation of blocks here *)
		(* Present algorithm just uses the current order *)
		(* Also assumes NOPs inserted after all control transfers *)
		fun do_block(block_start, (block_tag, opcode_list), done) =
		  let
		    fun do_opcode((Sparc_Assembly.BRANCH(branch, i),
				   SOME tag, comment), offset) =
		      (case lookup_env tag of
			 SOME res =>
			   let
			     val disp =
			       fault_range(( res - offset) div 4,
					   true, branch_disp_limit)
			   in
			     (Sparc_Assembly.BRANCH(branch, disp), comment)
			   end
		       | NONE =>
			   Crash.impossible"Assoc do_opcode branch")

		      | do_opcode((Sparc_Assembly.BRANCH_ANNUL(branch, i),
			       SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp =
				 fault_range((res - offset) div 4,
					     true, branch_disp_limit)
			     in
                           (Sparc_Assembly.BRANCH_ANNUL(branch, disp), comment)
			     end
			 | NONE =>
			     (Crash.impossible"Assoc do_opcode branch_annul"))
		      | do_opcode((Sparc_Assembly.FBRANCH(branch, i),
			       SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp =
                             fault_range((res - offset) div 4,
                                         true, branch_disp_limit)
			     in
			       (Sparc_Assembly.FBRANCH(branch, disp), comment)
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode fbranch")
		      | do_opcode((Sparc_Assembly.FBRANCH_ANNUL(branch, i),
			       SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp =
				 fault_range((res - offset) div 4,
					     true, branch_disp_limit)
			     in
			       (Sparc_Assembly.FBRANCH_ANNUL(branch, disp), comment)
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode fbranch_annul")
		      | do_opcode((Sparc_Assembly.Call(Sparc_Assembly.CALL, i,debug_info),
				   SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp =
				 fault_range(( res + i - offset) div 4,
					     true, call_disp_limit)
			     in
			       (Sparc_Assembly.Call(Sparc_Assembly.CALL, disp,debug_info), comment)
			     end
			 | NONE => Crash.impossible "Assoc do_opcode Call")
		      | do_opcode((Sparc_Assembly.LOAD_OFFSET(Sparc_Assembly.LEO, rd, i),
				   SOME tag, comment), offset) =
			(* This will probably suffer the same problems as adr did *)
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp = (res + i) - proc_offset
			     (* Must work relative to start of current proc in set *)
			     in
			       if check_range(disp, true, arith_imm_limit) then
				 (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				  (Sparc_Assembly.OR, rd, MachTypes.G0, Sparc_Assembly.IMM disp),
				  comment)
			       else
				 let
				   val _ =
				     diagnostic_output 3
				     (fn _ => ["Found bad LEO, substituting\n"])
				   val head_size = (offset - block_start) div 4
				   val tail = drop(1 + head_size, opcode_list)
				   (* get the opcodes after this one *)
				   val new_comment = comment ^ " (expanded adr)"
				   val new_tail =
				     (Sparc_Assembly.SPECIAL_LOAD_OFFSET
				      (Sparc_Assembly.LOAD_OFFSET_HIGH, rd, MachTypes.G0, i),
				      SOME tag, new_comment) ::
				     (Sparc_Assembly.SPECIAL_LOAD_OFFSET
				      (Sparc_Assembly.LOAD_OFFSET_AND_MASK, rd, rd, i),
				      SOME tag, new_comment) :: tail
				 in
				   raise bad_offset
				     (block_tag,
				      copy_n(head_size, opcode_list, [], new_tail))
				 end
			     end
			 | NONE => Crash.impossible "Assoc do_opcode LEO")
		      | do_opcode((Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				   (Sparc_Assembly.ADD, rd,
				    rs1, Sparc_Assembly.IMM i),
				   SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp = res + i - offset
			     in
			       if check_range(disp, true, arith_imm_limit) then
				 (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				  (Sparc_Assembly.ADD, rd,
				   rs1, Sparc_Assembly.IMM disp),
				  comment)
			       else
				 let
				   val _ =
				     diagnostic_output 3
				     (fn _ => ["Found bad LEA, substituting\n"])
				   val head_size = (offset - block_start) div 4
				   val tail = drop(1 + head_size, opcode_list)
				   (* get the opcodes after this one *)
				   val _ =
				     if rs1 = rd then
				       Crash.impossible"ADR has dest in lr"
				     else ()
				   val new_comment = comment ^ " (expanded adr)"
				   val new_tail =
				     (Sparc_Assembly.SetHI
				      (Sparc_Assembly.SETHI, rd, i),
				      SOME tag, new_comment) ::
				     (Sparc_Assembly.SPECIAL_ARITHMETIC
				      (Sparc_Assembly.ADD_AND_MASK, rd,
				       rd, Sparc_Assembly.IMM(i + 4)),
				      SOME tag, new_comment) ::
				     (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				      (Sparc_Assembly.ADD, rd,
				       rs1, Sparc_Assembly.REG rd),
				      NONE, new_comment) :: tail
				 in
				   raise bad_offset
				     (block_tag,
				      copy_n(head_size, opcode_list, [], new_tail))
				 end
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode arith")

		      | do_opcode((Sparc_Assembly.SPECIAL_ARITHMETIC
				   (_, rd, rs1, Sparc_Assembly.IMM i),
				   SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp =
				 make_imm_fault
				 ((res + i - offset) mod 1024,
				  true, arith_imm_limit)
			     in
			       (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				(Sparc_Assembly.ADD, rd, rs1, disp),
				comment)
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode arith")
		      | do_opcode((Sparc_Assembly.SPECIAL_LOAD_OFFSET(load, rd, rn, i),
				   SOME tag, comment), _) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp = res + i - proc_offset
			     (* Must work relative to start of current proc in set *)
			     in
			       case load of
				 Sparc_Assembly.LOAD_OFFSET_HIGH =>
				   (Sparc_Assembly.SetHI
				    (Sparc_Assembly.SETHI, rd,
				     (disp div 1024) mod (1024 * 1024 * 4)),
				    comment)
			       | Sparc_Assembly.LOAD_OFFSET_AND_MASK =>
				   (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				    (Sparc_Assembly.ADD, rd,
                                     rn,
				     make_imm_fault(disp mod 1024, true, arith_imm_limit)),
				    comment)
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode SPECIAL_LOAD_OFFSET")

		      | do_opcode((Sparc_Assembly.SetHI(_, rd, i),
				   SOME tag, comment), offset) =
			(case lookup_env tag of
			   SOME res =>
			     let
			       val disp = res + i - offset
			       val disp = (disp div 1024) mod (1024 * 1024 * 4)
			     (* Ensure positive *)
			     in
			       (Sparc_Assembly.SetHI(Sparc_Assembly.SETHI, rd, disp),
				comment)
			     end
			 | NONE =>
			     Crash.impossible"Assoc do_opcode arith")

		      | do_opcode((opcode, NONE, comment), offset) =
			(opcode, comment)
		      | do_opcode _ = Crash.impossible"Bad tagged instruction"

		    val (opcodes_and_offsets, next) =
		      Lists.number_from(opcode_list, block_start, 4, fn x => x)

		  in
		    (rev_map do_opcode (opcodes_and_offsets, done), next)
		  end
		val (so_far, next) = do_block(start, block, done)
	      in
		linearise_proc(proc_offset, next, block_list, so_far)
	      end

	  fun do_linearise_sub(_, []) = []
	    | do_linearise_sub(offset, ((tag, proc)(*,padded_name*)) :: rest) =
	      let
		val (offset', done') =
		  linearise_proc(offset, offset, proc, [])
		val offset'' =
		  offset' + 4 (* Back-pointer *) + 4 (* Procedure number within set *)
		val offset''' =
		  if offset'' mod 8 = 4
		    then offset'' + 4
		  else offset''
	      in
		(tag, done') :: do_linearise_sub(offset''', rest)
	      end

	  fun subst_bad_offset_block(proc_list, block as (tag, opcode_list)) =
	    let
	      fun remap(proc_tag, block_list) =
		(proc_tag,
		 map
		 (fn (block' as (block_tag, _)) =>
		  if block_tag = tag then block else block')
		 block_list)
	    in
	      map remap proc_list
	    end

	in
	  do_linearise_sub(0, proc_list)
	  handle bad_offset bad_offset_block =>
	    do_linearise (subst_bad_offset_block(proc_list, bad_offset_block))
	end
    in
      do_linearise new_proc_list
    end

  fun is_reg(MirTypes.GP_GC_REG reg) = true
    | is_reg(MirTypes.GP_NON_GC_REG reg) = true
    | is_reg _ = false

  fun move_reg(rd, rs) =
    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
     (Sparc_Assembly.OR, rd, rs, Sparc_Assembly.REG MachTypes.G0), absent, "")

  fun move_imm(rd, imm) =
    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
     (Sparc_Assembly.OR, rd, MachTypes.G0, Sparc_Assembly.IMM imm),
     absent, "")

  fun gp_from_reg(MirTypes.GC_REG reg) = MirTypes.GP_GC_REG reg
    | gp_from_reg(MirTypes.NON_GC_REG reg) = MirTypes.GP_NON_GC_REG reg

  datatype proc_stack =
    PROC_STACK of
    {non_gc_spill_size     : int, (* In words *)
     fp_spill_size         : int, (* In singles, doubles or extendeds as appropriate *)
     fp_save_size          : int, (* As for non_fp_spill_size *)
     gc_spill_size         : int, (* In words *)
     gc_stack_alloc_size   : int, (* In words *)
     register_save_size    : int, (* In bytes *)
     non_gc_spill_offset   : int, (* In bytes *)
     fp_spill_offset       : int, (* In bytes *)
     fp_save_offset        : int, (* In bytes*)
     gc_spill_offset       : int, (* In bytes *)
     gc_stack_alloc_offset : int, (* In bytes *)
     register_save_offset  : int, (* In bytes *)
     allow_fp_spare_slot   : bool, (* Do we need a slot for float to int conversion? *)
     float_value_size      : int  (* Number of bytes per float value *)
     }

  fun mach_cg
    error_info
    (Options.OPTIONS {compiler_options =
                      Options.COMPILEROPTIONS {generate_debug_info,
                                               debug_variables,
                                               generate_moduler,
                                               opt_leaf_fns, ...},
                      ...},
     MirTypes.CODE(MirTypes.REFS(loc_refs,
                                 {requires = ext_refs,
                                  vars = vars,
                                  exns = exns,
                                  strs = strs,
                                  funs = funs}),
                    value_list,
                    proc_list_list),
    (gc_map,
     non_gc_map,
     fp_map),
    debugging_map) =
    let
      val {gc, non_gc, fp} = MirRegisters.pack_next
      val gc_array = MLWorks.Internal.Array.array(gc, MachSpec.global)
      val _ =
	MirTypes.GC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(gc_array, MirTypes.GC.unpack mir_reg, reg))
	gc_map
      val non_gc_array = MLWorks.Internal.Array.array(non_gc, MachSpec.global)
      val _ =
	MirTypes.NonGC.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(non_gc_array, MirTypes.NonGC.unpack mir_reg, reg))
	non_gc_map
      val fp_array = MLWorks.Internal.Array.array(fp, MachSpec.global)
      val _ =
	MirTypes.FP.Map.iterate
	(fn (mir_reg, reg) =>
	 MLWorks.Internal.Array.update(fp_array, MirTypes.FP.unpack mir_reg, reg))
	fp_map

      val debug_map = ref debugging_map

      val value_elements =
	(map
	(fn(MirTypes.VALUE(tag, x)) =>
	 value_cg(Lists.assoc(tag, loc_refs), x,error_info))
	value_list) handle Lists.Assoc => Crash.impossible"Assoc value_elements"

      fun symb_value(PROC_STACK
		     {non_gc_spill_size,
		      fp_spill_size,
		      fp_save_size,
		      gc_spill_size,
		      gc_stack_alloc_size,
		      register_save_size,
		      non_gc_spill_offset,
		      fp_spill_offset,
		      fp_save_offset,
		      gc_spill_offset,
		      gc_stack_alloc_offset,
		      register_save_offset,
		      allow_fp_spare_slot,
		      float_value_size
		      }) =
	let
	  fun symbolic_value MirTypes.GC_SPILL_SIZE = gc_spill_size * 4
	    | symbolic_value MirTypes.NON_GC_SPILL_SIZE =
	      non_gc_spill_size * 4
	    | symbolic_value(MirTypes.GC_SPILL_SLOT i) =
	      let
		fun resolve_value i =
		  if i >= gc_spill_size then
		    Crash.impossible
		    ("Spill slot " ^ Int.toString i ^
		     " requested, but only " ^ Int.toString gc_spill_size ^
		     " allocated\n")
		  else
		    ~(gc_spill_offset + 4 * (1 + i))
	      in
                (* If its a symbolic offset, update to the real offset *)
		case i of
		  MirTypes.DEBUG (spill as ref (RuntimeEnv.OFFSET1(i)), name) =>
		    let
                      val print = fn s => print(s ^ "\n")
                      val _ =
                        if i = 0 then print ("Zero spill for " ^ name)
                        (* else if i = 1 then print ("One spill for " ^ name) *) (* This seems to get used for call_code *)
                        else ()
                      val value = resolve_value i
                    in
                      spill := RuntimeEnv.OFFSET2(RuntimeEnv.GC, value);
                      value
                    end
		| MirTypes.DEBUG (ref(RuntimeEnv.OFFSET2(_, i)),name) => i
                | MirTypes.SIMPLE i => resolve_value i
	      end
	    | symbolic_value(MirTypes.NON_GC_SPILL_SLOT i) =
	      let
		fun resolve_value i =
		  let
		    val offset = if allow_fp_spare_slot then 1 else 0
		  in
		    if i >= non_gc_spill_size then
		      Crash.impossible
		      ("non gc spill slot " ^ Int.toString i ^
		       " requested, but only " ^
		       Int.toString non_gc_spill_size ^
		       " allocated\n")
		    else
		      ~(non_gc_spill_offset + 4 * (1 + offset + i))
		  end
	      in
		case i of
                  (* If its a symbolic offset, update to the real offset *)
		  MirTypes.DEBUG (spill as ref(RuntimeEnv.OFFSET1(i)),name) =>
                    let
                      val value = resolve_value i
                    in
                      spill := RuntimeEnv.OFFSET2(RuntimeEnv.NONGC, value);
                      value
                    end
                | MirTypes.DEBUG (ref(RuntimeEnv.OFFSET2(_, i)),name) => i
                | MirTypes.SIMPLE i => resolve_value i
	      end
	    | symbolic_value(MirTypes.FP_SPILL_SLOT i) =
	      let
		fun resolve_value i =
		  if i >= fp_spill_size then
		    Crash.impossible
		    ("fp spill slot " ^ Int.toString i ^
		     " requested, but only " ^
		     Int.toString fp_spill_size ^
		     " allocated\n")
		  else
		    ~(fp_spill_offset + float_value_size * (1 + i))
	      in
		case i of
                (* If its a symbolic offset, update to the real offset *)
		  MirTypes.DEBUG(spill as ref(RuntimeEnv.OFFSET1(i)),name) =>
                    let
                      val value = resolve_value i
                    in
                      spill := RuntimeEnv.OFFSET2(RuntimeEnv.FP, value);
                      value
                    end
                | MirTypes.DEBUG(ref(RuntimeEnv.OFFSET2(_, i)),name) => i
                | MirTypes.SIMPLE i => resolve_value i
	      end
	in
	  symbolic_value
	end

      (* utility functions for enter *)
      fun do_store(_, _, 0, done) = done
	| do_store(reg, offset, 1, done) =
	  (Sparc_Assembly.LOAD_AND_STORE
	   (Sparc_Assembly.ST, MachTypes.G0,
	    reg,
	    Sparc_Assembly.IMM offset), absent,
	   "Initialise a stack slot") :: done
	| do_store(reg, offset, n, done) =
	  if n < 0 then Crash.impossible"Do_store"
	  else
	    if offset mod 8 = 4 then
	      do_store(reg, offset+4, n-1,
		     (Sparc_Assembly.LOAD_AND_STORE
		      (Sparc_Assembly.ST, MachTypes.G0,
		       reg,
		       Sparc_Assembly.IMM offset), absent,
		      "Initialise one misaligned stack slot") :: done)
	    else
	      do_store(reg, offset+8, n-2,
		       (Sparc_Assembly.LOAD_AND_STORE
			(Sparc_Assembly.STD, MachTypes.G0,
			 reg,
			 Sparc_Assembly.IMM offset), absent,
			"Initialise two stack slots") :: done)
      (* revised version of n_stores running off sp *)
      fun n_stores(from, no_of_stores, end_tag) =
	let
	  val end_limit = from + (no_of_stores-1)*4
	  val end_instrs =
	    [(Sparc_Assembly.BRANCH_ANNUL
	      (Sparc_Assembly.BA, 0),
	      SOME end_tag,
	      "Finish cleaning stack"),
	     Sparc_Assembly.nop]
	in
	  if check_range(end_limit, true,
			 arith_imm_limit) then
	    do_store(MachTypes.sp, from, no_of_stores, end_instrs)
	  else
	    Crash.impossible
	    ("n_stores end_limit = " ^
	     Int.toString end_limit)
	end

(* new inline allocation routine uses tagged addition to cause a trap
 * if we need to do a GC *)

      fun inline_allocate (reg, tag, bytes, leaf, rest) =
        (* trapped add to test for allocation overflow *)
	((Sparc_Assembly.TAGGED_ARITHMETIC
	  (Sparc_Assembly.TADDCCTV, MachTypes.gc1, MachTypes.gc1, bytes),
	  absent, "Attempt to allocate some heap") ::
         (* tag the 'answer' *)
	 (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
	  ((if leaf then
	      Sparc_Assembly.OR
	    else
	      Sparc_Assembly.ADD),
	      reg, MachTypes.gc2, Sparc_Assembly.IMM tag),
	      absent, "Tag allocated pointer") ::
         (* increment the allocation pointer *)
	 (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
	  (Sparc_Assembly.ADD, MachTypes.gc2, MachTypes.gc2, bytes),
	  absent, "Advance allocation point") ::
	 rest)

      fun do_blocks(_, [], _, _, _, (*_, _, _, _,*) _) = []
      | do_blocks(needs_preserve, MirTypes.BLOCK(tag,opcodes) :: rest,
		  stack_layout as PROC_STACK
		  {non_gc_spill_size,
		   fp_spill_size,
		   fp_save_size,
		   gc_spill_size,
		   gc_stack_alloc_size,
		   register_save_size,
		   non_gc_spill_offset,
		   fp_spill_offset,
		   fp_save_offset,
		   gc_spill_offset,
		   gc_stack_alloc_offset,
		   register_save_offset,
		   allow_fp_spare_slot,
		   float_value_size
		   },
		  spills_need_init,
		  stack_need_init,
		  fps_to_preserve
		  ) =
	let
	  val frame_size = register_save_offset + register_save_size
	  val non_save_frame_size = register_save_offset

	  val symbolic_value = symb_value stack_layout

	  fun gp_check_range(MirTypes.GP_IMM_INT i, signed, pos_limit) =
	    check_range(i, signed, pos_limit div 4)
	    | gp_check_range(MirTypes.GP_IMM_ANY i, signed, pos_limit) =
	      check_range(i, signed, pos_limit)
	    | gp_check_range(MirTypes.GP_IMM_SYMB symb, signed, pos_limit) =
	      check_range(symbolic_value symb, signed, pos_limit)
	    | gp_check_range _ =
	      Crash.impossible"gp_check_range of non-immediate"

	  fun split_int(MirTypes.GP_IMM_INT i) =
	    (((i div (4096 div 4)) mod (256 * 256 * 16))*4,
	     (i mod (4096 div 4))*4)
	    | split_int(MirTypes.GP_IMM_ANY i) =
	      (((i div 4096) mod (256 * 256 * 16))*4, i mod 4096)
	    | split_int(MirTypes.GP_IMM_SYMB symb) =
	      let
		val i = symbolic_value symb
	      in
		(((i div 4096) mod (256 * 256 * 16))*4, i mod 4096)
	      end
	    | split_int _ = Crash.impossible"split_int of non-immediate"

	  fun load_large_number_into_register (reg, gp_operand) =
	    case split_int gp_operand of
	      (0, 0) =>
                [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                  (Sparc_Assembly.OR, reg,
                   MachTypes.G0, Sparc_Assembly.REG MachTypes.G0),
                  absent, "")]
	    | (0, lo) =>
                [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                  (Sparc_Assembly.OR, reg,
                   MachTypes.G0, Sparc_Assembly.IMM lo),
                  absent, "")]
	    | (hi, 0) =>
                [(Sparc_Assembly.SetHI
                  (Sparc_Assembly.SETHI, reg, hi),
                  absent, "Get high part")]
	    | (hi, lo) =>
                [(Sparc_Assembly.SetHI
                  (Sparc_Assembly.SETHI, reg, hi),
                  absent, "Get high part"),
                 (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                  (Sparc_Assembly.ADD, reg,
                   reg, Sparc_Assembly.IMM lo),
                  absent, "Add in low part")]

	  fun make_imm_format3(MirTypes.GP_IMM_INT i) =
	    make_imm_fault(4 * i, true, arith_imm_limit)
	    | make_imm_format3(MirTypes.GP_IMM_ANY i) =
	      make_imm_fault(i, true, arith_imm_limit)
	    | make_imm_format3(MirTypes.GP_IMM_SYMB symb) =
	      make_imm_fault(symbolic_value symb, true, arith_imm_limit)
	    | make_imm_format3 _ = Crash.impossible"make_imm of non-immediate"

	  fun make_imm_for_store(MirTypes.GP_IMM_ANY i) =
	    make_imm_fault(i, true, arith_imm_limit)
	    | make_imm_for_store(MirTypes.GP_IMM_SYMB symb) =
	      make_imm_fault(symbolic_value symb, true, arith_imm_limit)
	    | make_imm_for_store _ =
	      Crash.impossible"make_imm_for_store(bad value)"

	  fun do_save_instrs(_, []) = []
	    | do_save_instrs(offset, fp :: rest) =
	      case MachTypes.fp_used of
		MachTypes.single =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.STF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "save float") :: do_save_instrs(offset+4, rest)
	      | MachTypes.double =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.STDF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "save float") :: do_save_instrs(offset+8, rest)
	      | MachTypes.extended =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.STDF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "save float") ::
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.STDF,
		    MachTypes.next_reg(MachTypes.next_reg fp),
		    MachTypes.fp, Sparc_Assembly.IMM (offset+8)), NONE,
		   "save float") ::
		  do_save_instrs(offset+16, rest)

	  fun do_restore_instrs(_, []) = []
	    | do_restore_instrs(offset, fp :: rest) =
	      case MachTypes.fp_used of
		MachTypes.single =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.LDF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "restore float") ::
		  do_restore_instrs(offset+4, rest)
	      | MachTypes.double =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.LDDF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "restore float") ::
		  do_restore_instrs(offset+8, rest)
	      | MachTypes.extended =>
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.LDDF, fp, MachTypes.fp,
		    Sparc_Assembly.IMM offset), NONE,
		   "restore float") ::
		  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
		   (Sparc_Assembly.LDDF,
		    MachTypes.next_reg(MachTypes.next_reg fp),
		    MachTypes.fp, Sparc_Assembly.IMM (offset+8)), NONE,
		   "restore float") ::
		  do_restore_instrs(offset+16, rest)

	  val fp_save_start = fp_save_offset + fp_save_size * float_value_size
	  val save_fps = do_save_instrs(~fp_save_start, fps_to_preserve)

	  val restore_fps = do_restore_instrs(~fp_save_start, fps_to_preserve)

	  fun is_comment(MirTypes.COMMENT _) = true
	    | is_comment _ = false

	  fun do_everything
	    (_, tag, [], done, [], final_result) =
	    (tag, contract_sexpr done) :: final_result
	  | do_everything
	    (needs_preserve, tag, [], done,
	     MirTypes.BLOCK(tag',opcodes) :: blocks,
	     final_result) =
	    do_everything
	    (needs_preserve, tag', Lists.filter_outp is_comment opcodes, Sexpr.NIL, blocks,
	     (tag, contract_sexpr done) :: final_result)
	  | do_everything
	    (needs_preserve, tag, opcode :: opcode_list, done,
	     block_list, final_result) =
	    let
	      fun lookup_reg(reg, table) =
		let
		  val reg = MLWorks.Internal.Array.sub(table, reg)
		in
		  if needs_preserve then reg
		  else MachTypes.after_restore reg
		end

	      fun lookup_reg_operand(MirTypes.GC_REG reg) =
	        lookup_reg(MirTypes.GC.unpack reg, gc_array)
	      | lookup_reg_operand(MirTypes.NON_GC_REG reg) =
		lookup_reg(MirTypes.NonGC.unpack reg, non_gc_array)
		
	      fun lookup_gp_operand(MirTypes.GP_GC_REG reg) =
	        lookup_reg(MirTypes.GC.unpack reg, gc_array)
	      | lookup_gp_operand(MirTypes.GP_NON_GC_REG reg) =
		lookup_reg(MirTypes.NonGC.unpack reg, non_gc_array)
	      | lookup_gp_operand _ =
		Crash.impossible"lookup_gp_operand(constant)"

	      fun lookup_fp_operand(MirTypes.FP_REG reg) =
		MLWorks.Internal.Array.sub(fp_array, MirTypes.FP.unpack reg)
		
	      val (result_list, opcode_list, new_blocks, new_final_result) =
		case opcode of
		  MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
				   gp_operand, gp_operand') =>
		  let
                    val tag = case taglist of [] => NONE | a::_ => SOME a
		    val rd = lookup_reg_operand reg_operand

		    fun preserve_order MirTypes.SUBS = true
		      | preserve_order MirTypes.DIVS = true
		      | preserve_order MirTypes.MODS = true
		      | preserve_order MirTypes.SUB32S = true
		      | preserve_order MirTypes.DIV32S = true
		      | preserve_order MirTypes.MOD32S = true
		      | preserve_order _ = false

		    val (gp_operand, gp_operand', redo) =
		      if is_reg gp_operand then
			(gp_operand, gp_operand', false)
		      else
                        if is_reg gp_operand'
                          then
                            if preserve_order tagged_binary_op
                              then
                                (gp_operand, gp_operand', true)
                            else
                              (gp_operand', gp_operand, false)
                        else
                          (* Both are immediate so no problem *)
                          (gp_operand, gp_operand', false)
		  in
		    if redo then
		      ([],
		       MirTypes.UNARY(MirTypes.MOVE,
				      MirTypes.GC_REG MirRegisters.global,
				      gp_operand) ::
		       MirTypes.TBINARY(tagged_binary_op, taglist, reg_operand,
					MirTypes.GP_GC_REG MirRegisters.global,
					gp_operand') ::
		       opcode_list, block_list, final_result)
		    else
		      if is_reg gp_operand then
			let
			  val rs1 = lookup_gp_operand gp_operand
			in
			  if is_reg gp_operand' orelse
			    gp_check_range(gp_operand', true,
					   arith_imm_limit) then
			    (* Actually making some code here *)
			    let
			      val reg_or_imm =
				if is_reg gp_operand' then
				  Sparc_Assembly.REG(lookup_gp_operand
						     gp_operand')
				else make_imm_format3 gp_operand'
			      val (use_traps,long_op) =
                                case tagged_binary_op of
                                  MirTypes.ADDS => (true,false)
                                | MirTypes.SUBS => (true,false)
                                | MirTypes.MULS => (false,false)
                                | MirTypes.DIVS => (false,false)
                                | MirTypes.MODS => (false,false)
                                | MirTypes.ADD32S => (false,true)
                                | MirTypes.SUB32S => (false,true)
                                | MirTypes.MUL32S => (false,true)
                                | MirTypes.DIV32S => (false,true)
                                | MirTypes.MOD32S => (false,true)
                                | MirTypes.DIVU => (false,false)
                                | MirTypes.MODU => (false,false)
                                | MirTypes.DIV32U => (false,true)
                                | MirTypes.MOD32U => (false,true)
			    in
			      if use_traps then
				let
				  val opcode = case tagged_binary_op of
				    MirTypes.ADDS =>
				      Sparc_Assembly.TADDCCTV
				  | MirTypes.SUBS =>
				      Sparc_Assembly.TSUBCCTV
				  | _ => Crash.impossible"do_opcodes(TBINARY)"
				in
				  ([(Sparc_Assembly.TAGGED_ARITHMETIC
				     (opcode, rd, rs1, reg_or_imm), absent, "")],
				   opcode_list,
				   block_list,
				   final_result)
				end
			      else
				(* Non-trapping version for 32 bit values *)
				(* All args are cleaned in case of overflow *)
				let
				  val (opcode, untag_arg) =
                                    case tagged_binary_op of
                                      MirTypes.ADD32S => (Sparc_Assembly.ADDCC,false)
                                    | MirTypes.SUB32S => (Sparc_Assembly.SUBCC,false)
                                    | MirTypes.MULS => (Sparc_Assembly.SMUL,true)
                                    | MirTypes.MUL32S => (Sparc_Assembly.SMUL,false)
                                    | _ => Crash.impossible"do_opcodes(TBINARY)"
				  val cont_tag = MirTypes.new_tag()
				  val clean_code =
                                    if not long_op
                                      then []
                                    else
                                    let
                                      val regs_to_clean = [rd, rs1]
                                      val regs_to_clean = case reg_or_imm of
                                        Sparc_Assembly.REG reg => reg :: regs_to_clean
                                      | _ => regs_to_clean
                                      val regs_to_clean = Lists.rev_remove_dups regs_to_clean
                                      val regs_to_clean =
                                        Lists.filterp
                                        (fn reg => reg <> MachTypes.G0 andalso
                                         reg <> MachTypes.global)
                                        regs_to_clean
                                        (* No point in cleaning global as it's non-gc *)
                                        (* g0 is already clean *)
                                    in
                                      map
                                      (fn reg =>
                                       (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                        (Sparc_Assembly.OR, reg,
                                         MachTypes.G0, Sparc_Assembly.REG MachTypes.G0),
                                        absent, "Clean"))
                                      regs_to_clean
                                    end

                                  val error_block =
                                    clean_code @
                                    [(Sparc_Assembly.BRANCH_ANNUL
                                      (Sparc_Assembly.BA, 0),
                                      tag, ""),
                                     Sparc_Assembly.nop]

                                  fun make_overflow_error () =
                                    ((Sparc_Assembly.BRANCH_ANNUL
                                      (Sparc_Assembly.BVC, 0),
                                      SOME cont_tag,
                                      "Branch if not overflow") ::
                                     Sparc_Assembly.nop ::
                                     error_block,
                                     [])

                                  fun make_multiply_error () =
                                    let
                                      val error_tag = MirTypes.new_tag()
                                      val main_code =
                                        (* result reg can't be global *)
                                        [(Sparc_Assembly.READ_STATE (Sparc_Assembly.RDY,
                                                                     MachTypes.global),
                                          NONE,"get high word of result"),
                                         (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                          (Sparc_Assembly.ADD,
                                           MachTypes.global,
                                           MachTypes.global,
                                           Sparc_Assembly.IMM 1),
                                          NONE,""),
                                         (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                          (Sparc_Assembly.SUBCC,
                                           MachTypes.G0,
                                           MachTypes.global,
                                           Sparc_Assembly.IMM 1),
                                          NONE,""),
                                         (Sparc_Assembly.BRANCH (Sparc_Assembly.BGU,0),
                                          SOME error_tag,""),
                                         (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                          (Sparc_Assembly.SUB,
                                           MachTypes.global,
                                           MachTypes.global,
                                           Sparc_Assembly.IMM 1),
                                          NONE,"adjust back"),
                                         (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                          (Sparc_Assembly.XORCC,
                                           MachTypes.G0,
                                           rd,
                                           Sparc_Assembly.REG MachTypes.global),
                                          NONE, ""),
                                         (Sparc_Assembly.BRANCH_ANNUL (Sparc_Assembly.BL,0),
                                          SOME error_tag,""),
                                         Sparc_Assembly.nop,
                                         (Sparc_Assembly.BRANCH_ANNUL (Sparc_Assembly.BA,0),
                                          SOME cont_tag,""),
                                         Sparc_Assembly.nop]
                                    in
                                      (main_code,
                                       [(error_tag,error_block)])
                                    end

                                  val (error_check, error_blocks) =
                                    case tagged_binary_op of
                                      MirTypes.ADD32S => make_overflow_error ()
                                    | MirTypes.SUB32S => make_overflow_error ()
                                    | MirTypes.MULS => make_multiply_error ()
                                    | MirTypes.MUL32S => make_multiply_error ()
                                    | _ => Crash.impossible"do_opcodes(TBINARY)"

				  val binary_operation =
                                    (if not untag_arg
                                      then
                                        [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                          (opcode, rd, rs1, reg_or_imm), absent, "")]
                                     else (* untag rs1 into result register *)
                                       let
                                         (* reg_or_imm shouldn't be the result reg if rs1 isn't *)
                                         val (rs1,reg_or_imm) =
                                           if rs1 = rd then (rs1,reg_or_imm)
                                           else
                                             case reg_or_imm of
                                               Sparc_Assembly.REG rs2 =>
                                                 if rd = rs2 then (rs2,Sparc_Assembly.REG rs1)
                                                 else (rs1,reg_or_imm)
                                             | _ => (rs1,reg_or_imm)
                                         val both_result_reg =
                                           rs1 = rd andalso
                                           (case reg_or_imm of
                                              Sparc_Assembly.REG rs2 => rs2 = rs1
                                            | _ => false)
                                         val shift_amount = if both_result_reg then 1 else 2
                                       in
                                         [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                           (Sparc_Assembly.SRA, rd, rs1, Sparc_Assembly.IMM shift_amount), absent, "untag argument"),
                                          (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                           (opcode, rd, rd, reg_or_imm), absent, "")]
                                       end) @
                                       error_check
				in
				  (binary_operation,
				   [],
				   MirTypes.BLOCK(cont_tag, opcode_list) :: block_list,
				   error_blocks @ final_result)
				end
			    end
			  else (* not (is_reg gp_operand') andalso
				  not (gp_check_range
				        (gp_operand', true, arith_imm_limit)) *)
			    ([],
			     (* Ok to use the global register here *)
			     (* Because it won't be the result *)
			     MirTypes.UNARY(MirTypes.MOVE,
					    MirTypes.GC_REG
					    MirRegisters.global,
					    gp_operand') ::
			     MirTypes.TBINARY(tagged_binary_op, taglist,
					      reg_operand,
					      gp_operand,
					      MirTypes.GP_GC_REG
					      MirRegisters.global) ::
			     opcode_list, block_list, final_result)
			end
		      else (* not (is_reg gp_operand) *)
			(* Oh dear, both operands gp *)
			(diagnostic_output 3
			  (fn _ => ["Mach_Cg(TBINARY) first arg not reg\n"]);
			 ([],
			  MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					 gp_operand) ::
			  MirTypes.TBINARY(tagged_binary_op, taglist,
					   reg_operand,
					   gp_from_reg reg_operand,
					   gp_operand') ::
			  opcode_list, block_list, final_result))
		  end
		| MirTypes.BINARY(binary_op, reg_operand, gp_operand,
				  gp_operand') =>
		  let
		    (* Shifts are difficult, we'll do them separately *)
		    fun is_shift MirTypes.ADDU = false
		      | is_shift MirTypes.SUBU = false
		      | is_shift MirTypes.MULU = false
		      | is_shift MirTypes.MUL32U = false
		      | is_shift MirTypes.AND = false
		      | is_shift MirTypes.OR = false
		      | is_shift MirTypes.EOR = false
		      | is_shift MirTypes.LSR = true
		      | is_shift MirTypes.ASL = true
		      | is_shift MirTypes.ASR = true

		    val rd = lookup_reg_operand reg_operand
		    val (opcode,untag_arg) =
		      case binary_op of
			MirTypes.ADDU => (Sparc_Assembly.ADD,false)
		      | MirTypes.SUBU => (Sparc_Assembly.SUB,false)
		      | MirTypes.MULU => (Sparc_Assembly.UMUL,true)
		      | MirTypes.MUL32U => (Sparc_Assembly.UMUL,false)
		      | MirTypes.AND => (Sparc_Assembly.AND,false)
		      | MirTypes.OR => (Sparc_Assembly.OR,false)
		      | MirTypes.EOR => (Sparc_Assembly.XOR,false)
		      | MirTypes.LSR => (Sparc_Assembly.SRL,false)
		      | MirTypes.ASL => (Sparc_Assembly.SLL,false)
		      | MirTypes.ASR => (Sparc_Assembly.SRA,false)

		    fun needs_reverse Sparc_Assembly.SUB = true
		      | needs_reverse Sparc_Assembly.SUBCC = true
		      | needs_reverse Sparc_Assembly.SUBX = true
		      | needs_reverse Sparc_Assembly.SUBXCC = true
		      | needs_reverse Sparc_Assembly.SRL = true
		      | needs_reverse Sparc_Assembly.SLL = true
		      | needs_reverse Sparc_Assembly.SRA = true
		      | needs_reverse _ = false

		    val (gp_operand, gp_operand', redo) =
		      if is_reg gp_operand then
			(gp_operand, gp_operand', false)
		      else
                        if is_reg gp_operand' then
			  if needs_reverse opcode then
			    (gp_operand, gp_operand', true)
			  else
			    (gp_operand', gp_operand, false)
                        else
                          (* Both immediate so no problem *)
                          (gp_operand, gp_operand', false)
		    val is_a_shift = is_shift binary_op
		  in
		    if redo andalso not is_a_shift then
		      let
			val inter_reg =
			  case gp_operand' of
			    MirTypes.GP_GC_REG r =>
			      (if r = MirRegisters.global then
				 (* The nasty case *)
				 (case reg_operand of
				    MirTypes.GC_REG r' =>
				      if r = r' then
					Crash.impossible
					"source and dest global with large int"
				      else
					r'
				  | MirTypes.NON_GC_REG _ =>
				      Crash.impossible"BINARY doesn't deliver GC")
			       else
				 MirRegisters.global)
			  | _ => Crash.impossible "BINARY has non-gc register"
		      in
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					MirTypes.GC_REG inter_reg,
					gp_operand) ::
			 MirTypes.BINARY(binary_op, reg_operand,
					 MirTypes.GP_GC_REG inter_reg,
					 gp_operand') ::
			 opcode_list, block_list, final_result)
		      end
		    else
		      if is_a_shift then
			(* Deal with possible out of range shifts *)
			(* and also bad code from LSR/ASR *)
			let
			  val const_shift = case gp_operand' of
			    MirTypes.GP_GC_REG _ => false
			  | MirTypes.GP_NON_GC_REG _ => false
			  | _ => true
			in
			  if const_shift then
			    let
			      val shift_size = make_imm_format3 gp_operand'

			      fun get_shift(Sparc_Assembly.IMM i) = i
				| get_shift _ =
				  Crash.impossible"mach_cg:non_constant in shift by constant"
			      val shift_val = get_shift shift_size
			    in
			      case binary_op of
				MirTypes.LSR =>
				  (* Deal with possible immediate value here *)
				  if is_reg gp_operand then
				    let
				      val rs1 = lookup_gp_operand gp_operand
				    in
				      ([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					 (opcode, rd, rs1, shift_size),
					 absent, "")],
				       opcode_list, block_list, final_result)
				    end
				  else
				    (* A rare case, just replace by move *)
				    (* and shift the result *)
				    ([],
				     MirTypes.UNARY(MirTypes.MOVE,
						    MirTypes.GC_REG MirRegisters.global,
						    gp_operand) ::
				     MirTypes.BINARY(binary_op,
						     reg_operand,
						     MirTypes.GP_GC_REG MirRegisters.global,
						     gp_operand') ::
				     opcode_list,
				     block_list, final_result)
			      | MirTypes.ASR =>
				  if is_reg gp_operand then
				    let
				      val rs1 = lookup_gp_operand gp_operand
				    in
				      ([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					 (opcode, rd, rs1, shift_size),
					 absent, "")],
				       opcode_list, block_list, final_result)
				    end
				  else
				    (* A rare case, just replace by move *)
				    (* and shift the result *)
				    ([],
				     MirTypes.UNARY(MirTypes.MOVE,
						    MirTypes.GC_REG MirRegisters.global,
						    gp_operand) ::
				     MirTypes.BINARY(binary_op,
						     reg_operand,
						     MirTypes.GP_GC_REG MirRegisters.global,
						     gp_operand') ::
				     opcode_list,
				     block_list, final_result)
			      | MirTypes.ASL =>
				    (* Deal with possible immediate value here *)
				    if is_reg gp_operand then
				      let
					val rs1 = lookup_gp_operand gp_operand
				      in
					([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					   (opcode, rd, rs1, shift_size),
					   absent, "")],
					 opcode_list, block_list, final_result)
				      end
				    else
				      (* A rare case, just replace by move *)
				      (* and shift the result *)
				      ([],
				       MirTypes.UNARY(MirTypes.MOVE,
						      MirTypes.GC_REG MirRegisters.global,
						      gp_operand) ::
				       MirTypes.BINARY(binary_op,
						       reg_operand,
						       MirTypes.GP_GC_REG MirRegisters.global,
						       gp_operand') ::
				       opcode_list,
				       block_list, final_result)
			      | _ => Crash.impossible"mach_cg: non-shift in shift case"
			    end
			  else
			    (* Need a range test to sort out shifts by large amounts *)
			    (* This includes the case of a constant shifted by a variable amount *)
			    let
			      val rs1 = lookup_gp_operand gp_operand'
			      val cont_tag = MirTypes.new_tag()
			      fun make_range_test limit =
				let
				  val bad_tag = MirTypes.new_tag()
				in
				  (bad_tag,
				   [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				     (Sparc_Assembly.SUBCC,
				      MachTypes.G0, rs1, Sparc_Assembly.IMM limit),
				     absent, "shift range test"),
				    (Sparc_Assembly.BRANCH_ANNUL
				     (Sparc_Assembly.BCC, 0),
				     SOME bad_tag, "branch if shift arg too big"),
				    Sparc_Assembly.nop])
				end

			      val continue =
				[(Sparc_Assembly.BRANCH_ANNUL
				  (Sparc_Assembly.BA, 0),
				  SOME cont_tag, ""),
				 Sparc_Assembly.nop]

			      fun constant_out_of_range_shift gp_op =
				case binary_op of
				  MirTypes.ASL => [move_imm(rd, 0)]
				| MirTypes.ASR =>
				    if gp_check_range(gp_op, false, arith_imm_limit) then
				      [move_imm(rd, 0)]
				    else
				      (case gp_operand of
					 MirTypes.GP_IMM_INT i =>
					   [move_imm(rd, if i < 0 then ~4 else 0)]
				       | MirTypes.GP_IMM_ANY i =>
					   [move_imm(rd, 0)]
				       | _ => Crash.impossible"Mach_cg:shift:bad constant")
				| MirTypes.LSR => [move_imm(rd, 0)]
				| _ => Crash.impossible"mach_cg: non-shift in shift case"
			      val shift_limit = case binary_op of
				MirTypes.ASL => 32
			      | MirTypes.ASR => 31
			      | MirTypes.LSR => 32
			      | _ => Crash.impossible"mach_cg: non-shift in shift case"

			      fun variable_out_of_range_shift gp_op =
				case binary_op of
				  MirTypes.ASL => [move_imm(rd, 0)]
				| MirTypes.ASR =>
				    (* Shift by 31 *)
				    [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				      (opcode, rd,lookup_gp_operand gp_op, Sparc_Assembly.IMM 31),
				      absent, "")]
				| MirTypes.LSR => [move_imm(rd, 0)]
				| _ => Crash.impossible"mach_cg: non-shift in shift case"

			      val (bad_tag, range_test) =
				make_range_test shift_limit
			      val shift_op =
				if is_reg gp_operand then
				  (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				   (opcode, rd,
				    lookup_gp_operand gp_operand,
                                    Sparc_Assembly.REG rs1),
				   absent, "") :: continue
				else
				  load_large_number_into_register(rd, gp_operand) @
				  ((Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				    (opcode, rd, rd, Sparc_Assembly.REG rs1),
				    absent, "") :: continue)
			    in
			      (range_test @ shift_op @ continue, [],
			       MirTypes.BLOCK(cont_tag, opcode_list) ::
			       block_list,
			       (bad_tag,
				(if is_reg gp_operand then
				   variable_out_of_range_shift gp_operand
				 else
				   constant_out_of_range_shift gp_operand) @
				   continue) :: final_result)
			    end
			end
		      else
			if is_reg gp_operand then
			  let
			    val rs1 = lookup_gp_operand gp_operand
			  in
			    if is_reg gp_operand' orelse
			      gp_check_range(gp_operand', true,
					     arith_imm_limit) then
			      let
				val reg_or_imm =
				  if is_reg gp_operand' then
				    Sparc_Assembly.REG(lookup_gp_operand
						       gp_operand')
				  else make_imm_format3 gp_operand'
			      in
                                if not untag_arg
                                  then
                                    ([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                       (opcode, rd, rs1, reg_or_imm), absent, "")],
                                     opcode_list, block_list, final_result)
                                else
                                  let
                                    val both_rd =
                                      rs1 = rd andalso
                                      (case reg_or_imm of
                                         Sparc_Assembly.REG rs2 => rs2 = rs1
                                       | _ => false)
                                    val shift_amount =
                                      if both_rd then 1 else 2
                                  in
                                    ([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                       (Sparc_Assembly.SRA, rd, rs1, Sparc_Assembly.IMM shift_amount),
                                       absent, ""),
                                      (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                       (opcode, rd, rd, reg_or_imm), absent, "")],
                                     opcode_list, block_list, final_result)
                                  end
			      end
			    else
			      let
				val inter_reg =
				  case gp_operand of
				    MirTypes.GP_GC_REG r =>
				      (if r = MirRegisters.global then
					 (* The nasty case *)
					 (case reg_operand of
					    MirTypes.GC_REG r' =>
					      if r = r' then
						Crash.impossible
						"source and dest global with large int"
					      else
						r'
					  | MirTypes.NON_GC_REG _ =>
					      Crash.impossible"BINARY doesn't deliver GC")
				       else
					 MirRegisters.global)
				  | _ => Crash.impossible "BINARY has non-gc register"
			      in
				([],
				 MirTypes.UNARY(MirTypes.MOVE,
						MirTypes.GC_REG inter_reg,
						gp_operand') ::
				 MirTypes.BINARY(binary_op, reg_operand,
						 gp_operand,
						 MirTypes.GP_GC_REG inter_reg) ::
				 opcode_list, block_list, final_result)
			      end
			  end
			else
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand) ::
			   MirTypes.BINARY(binary_op, reg_operand,
					   MirTypes.GP_GC_REG MirRegisters.global,
					   gp_operand') ::
			   opcode_list, block_list, final_result)
		  end
		| MirTypes.UNARY(MirTypes.MOVE, reg_operand, gp_operand) =>
		  let
		    val rd = lookup_reg_operand reg_operand
		    val opcode = Sparc_Assembly.OR
		    val imm = Sparc_Assembly.REG MachTypes.G0
		    val code_list =
		      if is_reg gp_operand then
			let
			  val rs1 = lookup_gp_operand gp_operand
			in
			  if rd = rs1 then [] (* Null move rn -> rn *)
			  else
			    [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			      (opcode, rd, rs1, imm), absent, "")]
			end
		      else
			if gp_check_range(gp_operand, true,
					  arith_imm_limit) then
			  let
			    val imm = case make_imm_format3 gp_operand of
			      Sparc_Assembly.IMM 0 => imm (* MOVE 0 case *)
			    | non_zero_imm => non_zero_imm
			  in
			    [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			      (opcode, rd, MachTypes.G0, imm), absent, "")]
			  end
			else
			  load_large_number_into_register(rd, gp_operand)
		  in
		    (code_list, opcode_list, block_list, final_result)
		  end
		| MirTypes.UNARY(MirTypes.NOT, reg_operand, gp_operand) =>
		  let
		    val rd = lookup_reg_operand reg_operand
		    val opcode = Sparc_Assembly.XORN
		    val simple_imm = Sparc_Assembly.IMM 3
		  in
		    if is_reg gp_operand then
		      let
			val rs1 = lookup_gp_operand gp_operand
		      in
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (opcode, rd, rs1, simple_imm), absent, "")],
			 opcode_list, block_list, final_result)
		      end
		    else
		      ([], MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					  gp_operand) ::
		       MirTypes.UNARY(MirTypes.NOT, reg_operand,
					  gp_from_reg reg_operand) ::
		       opcode_list,
		       block_list, final_result)
		  end
                (* Don't mask out bottom two bits *)
		| MirTypes.UNARY(MirTypes.NOT32, reg_operand, gp_operand) =>
		  let
		    val rd = lookup_reg_operand reg_operand
		    val opcode = Sparc_Assembly.XORN
		    val simple_imm = Sparc_Assembly.IMM 0
		  in
		    if is_reg gp_operand then
		      let
			val rs1 = lookup_gp_operand gp_operand
		      in
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (opcode, rd, rs1, simple_imm), absent, "")],
			 opcode_list, block_list, final_result)
		      end
		    else
		      ([], MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					  gp_operand) ::
		       MirTypes.UNARY(MirTypes.NOT32, reg_operand,
					  gp_from_reg reg_operand) ::
		       opcode_list,
		       block_list, final_result)
		  end
		| MirTypes.UNARY(MirTypes.INTTAG, reg_operand, gp_operand) =>
		  let
		    val rd = lookup_reg_operand reg_operand
		    val opcode = Sparc_Assembly.ANDN
		    val simple_imm = Sparc_Assembly.IMM 3
		  in
		    if is_reg gp_operand then
		      let
			val rs1 = lookup_gp_operand gp_operand
		      in
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (opcode, rd, rs1, simple_imm), absent, "")],
			 opcode_list, block_list, final_result)
		      end
		    else
		      ([], MirTypes.UNARY(MirTypes.MOVE, reg_operand,
					  gp_operand) ::
		       MirTypes.UNARY(MirTypes.INTTAG, reg_operand,
				      gp_from_reg reg_operand) ::
		       opcode_list,
		       block_list, final_result)
		  end
		| MirTypes.NULLARY(MirTypes.CLEAN, reg_operand) =>
                    ([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                       (Sparc_Assembly.OR, lookup_reg_operand reg_operand,
                        MachTypes.G0, Sparc_Assembly.REG MachTypes.G0),
                       absent, "Clean")],
                    opcode_list, block_list, final_result)
		| MirTypes.BINARYFP(binary_fp_op, fp_operand, fp_operand',
				    fp_operand'') =>
		  let
		    val rd = lookup_fp_operand fp_operand
		    val rs1 = lookup_fp_operand fp_operand'
		    val rs2 = lookup_fp_operand fp_operand''
		    val operation = case (MachTypes.fp_used, binary_fp_op) of
		      (MachTypes.single, MirTypes.FADD) => Sparc_Assembly.FADDS
		    | (MachTypes.single, MirTypes.FSUB) => Sparc_Assembly.FSUBS
		    | (MachTypes.single, MirTypes.FMUL) => Sparc_Assembly.FMULS
		    | (MachTypes.single, MirTypes.FDIV) => Sparc_Assembly.FDIVS
		    | (MachTypes.double, MirTypes.FADD) => Sparc_Assembly.FADDD
		    | (MachTypes.double, MirTypes.FSUB) => Sparc_Assembly.FSUBD
		    | (MachTypes.double, MirTypes.FMUL) => Sparc_Assembly.FMULD
		    | (MachTypes.double, MirTypes.FDIV) => Sparc_Assembly.FDIVD
		    | (MachTypes.extended, MirTypes.FADD) =>
			Sparc_Assembly.FADDX
		    | (MachTypes.extended, MirTypes.FSUB) =>
			Sparc_Assembly.FSUBX
		    | (MachTypes.extended, MirTypes.FMUL) =>
			Sparc_Assembly.FMULX
		    | (MachTypes.extended, MirTypes.FDIV) =>
			Sparc_Assembly.FDIVX
		  in
		    ([(Sparc_Assembly.FBINARY(operation, rd, rs1, rs2), absent,
		       "")], opcode_list, block_list, final_result)
		  end
	        | MirTypes.UNARYFP(unary_fp_op, fp_operand, fp_operand') =>
		    let
		      val rd = lookup_fp_operand fp_operand
		      val rs2 = lookup_fp_operand fp_operand'
		      val (operation, extra_moves) =
			case (MachTypes.fp_used, unary_fp_op) of
			  (MachTypes.single, MirTypes.FSQRT) =>
			    (Sparc_Assembly.FSQRTS, 0)
			| (MachTypes.single, MirTypes.FMOVE) =>
			    (Sparc_Assembly.FMOV, 0)
			| (MachTypes.single, MirTypes.FABS) =>
			    (Sparc_Assembly.FABS, 0)
			| (MachTypes.single, MirTypes.FNEG) =>
			    (Sparc_Assembly.FNEG, 0)
			| (MachTypes.double, MirTypes.FSQRT) =>
			    (Sparc_Assembly.FSQRTD, 0)
			| (MachTypes.double, MirTypes.FMOVE) =>
			    (Sparc_Assembly.FMOV, 1)
			| (MachTypes.double, MirTypes.FABS) =>
			    (Sparc_Assembly.FABS, 1)
			| (MachTypes.double, MirTypes.FNEG) =>
			    (Sparc_Assembly.FNEG, 1)
			| (MachTypes.extended, MirTypes.FSQRT) =>
			    (Sparc_Assembly.FSQRTX, 0)
			| (MachTypes.extended, MirTypes.FMOVE) =>
			    (Sparc_Assembly.FMOV, 3)
			| (MachTypes.extended, MirTypes.FABS) =>
			    (Sparc_Assembly.FABS, 3)
			| (MachTypes.extended, MirTypes.FNEG) =>
			    (Sparc_Assembly.FNEG, 3)
			| _ =>
			    Crash.impossible"Bad unary fp generated"
		      fun add_moves(_, _, 0) = []
		      | add_moves(rd, rs2, moves) =
			let
			  val rd = MachTypes.next_reg rd
			  val rs2 = MachTypes.next_reg rs2
			in
			  (Sparc_Assembly.FUNARY(Sparc_Assembly.FMOV, rd, rs2),
			   absent, "") :: add_moves(rd, rs2, moves - 1)
			end
		      val extra_code = add_moves(rd, rs2, extra_moves)
		    in
		      ((Sparc_Assembly.FUNARY(operation, rd, rs2), absent,
			"") :: extra_code, opcode_list, block_list,
		       final_result)
		    end
		| MirTypes.TBINARYFP(tagged_binary_fp_op, taglist, fp_operand,
				     fp_operand', fp_operand'') =>
		  let
                    val tag = case taglist of [] => NONE | a::_ => SOME a
		    val rd = lookup_fp_operand fp_operand
		    val rs1 = lookup_fp_operand fp_operand'
		    val rs2 = lookup_fp_operand fp_operand''
		    val operation =
                      case (MachTypes.fp_used, tagged_binary_fp_op)
                      of (MachTypes.single, MirTypes.FADDV) =>
			Sparc_Assembly.FADDS
                      |  (MachTypes.single, MirTypes.FSUBV) =>
			Sparc_Assembly.FSUBS
                      |  (MachTypes.single, MirTypes.FMULV) =>
			Sparc_Assembly.FMULS
                      |  (MachTypes.single, MirTypes.FDIVV) =>
			Sparc_Assembly.FDIVS
                      |  (MachTypes.double, MirTypes.FADDV) =>
			Sparc_Assembly.FADDD
                      |  (MachTypes.double, MirTypes.FSUBV) =>
			Sparc_Assembly.FSUBD
                      |  (MachTypes.double, MirTypes.FMULV) =>
			Sparc_Assembly.FMULD
                      |  (MachTypes.double, MirTypes.FDIVV) =>
			Sparc_Assembly.FDIVD
                      |  (MachTypes.extended, MirTypes.FADDV) =>
			Sparc_Assembly.FADDX
                      |  (MachTypes.extended, MirTypes.FSUBV) =>
			Sparc_Assembly.FSUBX
                      |  (MachTypes.extended, MirTypes.FMULV) =>
			Sparc_Assembly.FMULX
                      |  (MachTypes.extended, MirTypes.FDIVV) =>
			Sparc_Assembly.FDIVX
		  in
		    ([(Sparc_Assembly.FBINARY(operation, rd, rs1, rs2),
		       absent, "")],
		     opcode_list, block_list, final_result)
		  end
		| MirTypes.TUNARYFP(tagged_unary_fp_op, tag, fp_operand,
				    fp_operand') =>
		    (* same as untagged case - overflows caught by hardware/OS
		       and handled in runtime system. *)
		    let
		      val rd = lookup_fp_operand fp_operand
		      val rs2 = lookup_fp_operand fp_operand'
		      val (operation, extra_moves) =
			case (MachTypes.fp_used, tagged_unary_fp_op) of
			  (MachTypes.single, MirTypes.FSQRTV) =>
			    (Sparc_Assembly.FSQRTS, 0)
			| (MachTypes.single, MirTypes.FABSV) =>
			    (Sparc_Assembly.FABS, 0)
			| (MachTypes.single, MirTypes.FNEGV) =>
			    (Sparc_Assembly.FNEG, 0)
			| (MachTypes.double, MirTypes.FSQRTV) =>
			    (Sparc_Assembly.FSQRTD, 0)
			| (MachTypes.double, MirTypes.FABSV) =>
			    (Sparc_Assembly.FABS, 1)
			| (MachTypes.double, MirTypes.FNEGV) =>
			    (Sparc_Assembly.FNEG, 1)
			| (MachTypes.extended, MirTypes.FSQRTV) =>
			    (Sparc_Assembly.FSQRTX, 0)
			| (MachTypes.extended, MirTypes.FABSV) =>
			    (Sparc_Assembly.FABS, 3)
			| (MachTypes.extended, MirTypes.FNEGV) =>
			    (Sparc_Assembly.FNEG, 3)
			| _ =>
			    Crash.impossible"Bad unary fp generated"
		      fun add_moves(_, _, 0) = []
		      | add_moves(rd, rs2, moves) =
			let
			  val rd = MachTypes.next_reg rd
			  val rs2 = MachTypes.next_reg rs2
			in
			  (Sparc_Assembly.FUNARY(Sparc_Assembly.FMOV, rd, rs2),
			   absent, "") :: add_moves(rd, rs2, moves - 1)
			end
		      val extra_code = add_moves(rd, rs2, extra_moves)
		    in
		      ((Sparc_Assembly.FUNARY(operation, rd, rs2), absent,
			"") :: extra_code, opcode_list, block_list,
		       final_result)
		    end
		| MirTypes.STACKOP(stack_op, reg_operand,
				   SOME offset) =>
		  let
		    val opcode = case stack_op of
		      MirTypes.PUSH => MirTypes.STREF
		    | MirTypes.POP => MirTypes.LDREF
		  val _ =
		    if offset > gc_stack_alloc_size then
		      Crash.impossible("Stack access at offset " ^
				       Int.toString offset ^
				       " requested, in total area of only " ^
				       Int.toString gc_stack_alloc_size ^
				       "\n")
		    else()
		  in
		    ([],
		     MirTypes.STOREOP(opcode, reg_operand,
				      MirTypes.GC_REG MirRegisters.fp,
				      MirTypes.GP_IMM_ANY
				      (~(gc_stack_alloc_offset + 4 * (offset + 1)))) ::
		     opcode_list, block_list, final_result)
		  end
		| MirTypes.STACKOP _ =>
		    Crash.impossible"Offset missing on STACK_OP"
		| opcode as MirTypes.IMMSTOREOP _ =>
		    Crash.impossible"IMMSTOREOP not supported on sparc"
		| opcode as MirTypes.STOREOP(store_op, reg_operand, reg_operand',
					     gp_operand) =>
		  let
		    val (shuffle, new_opcode_list) =
		      if is_reg gp_operand orelse
			gp_check_range(gp_operand, true, arith_imm_limit) then
			(
			 case opcode_list of
			   (store_op as MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG g,
							 c_reg as MirTypes.GC_REG c,
							 MirTypes.GP_IMM_ANY ~1)) ::
			   (tail as (MirTypes.BRANCH_AND_LINK _ :: _)) =>
			     if g = MirRegisters.global andalso c = MirRegisters.caller_closure
			       andalso reg_operand' <> c_reg andalso reg_operand <> c_reg then
				 (true, store_op :: opcode :: tail)
			     else
			       (false, [])
			 | (store_op as MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG g,
							 c_reg as MirTypes.GC_REG c,
							 MirTypes.GP_IMM_ANY ~1)) ::
			   (tail as (MirTypes.TAIL_CALL _ :: _)) =>
			     if (not needs_preserve) andalso
			       g = MirRegisters.global andalso c = MirRegisters.callee_closure
			       andalso reg_operand' <> c_reg andalso reg_operand <> c_reg then
			       (true, store_op :: opcode :: tail)
			     else
			       (false, [])
		         | (move_op as MirTypes.UNARY(MirTypes.MOVE, c_reg as MirTypes.GC_REG c,
						      MirTypes.GP_GC_REG r)) ::
			   (store_op as MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG g,
							 MirTypes.GC_REG c',
							 MirTypes.GP_IMM_ANY ~1)) ::
			   (tail as (MirTypes.BRANCH_AND_LINK _ :: _)) =>
			     let
			       val r_reg = MirTypes.GC_REG r
			     in
			       if g = MirRegisters.global andalso c = MirRegisters.caller_closure
				 andalso c' = c
				 andalso reg_operand' <> c_reg
				 andalso reg_operand' <> r_reg
				 andalso reg_operand <> c_reg
				 andalso reg_operand <> r_reg then
				 (true, move_op :: store_op :: opcode :: tail)
			       else
				 (false, [])
			     end
		         | (move_op as MirTypes.UNARY(MirTypes.MOVE, c_reg as MirTypes.GC_REG c,
						      MirTypes.GP_GC_REG r)) ::
			   (store_op as MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG g,
							 MirTypes.GC_REG c',
							 MirTypes.GP_IMM_ANY ~1)) ::
			   (tail as (MirTypes.TAIL_CALL _ :: _)) =>
			     let
			       val r_reg = MirTypes.GC_REG r
			     in
			       if (not needs_preserve) andalso
				 g = MirRegisters.global andalso c = MirRegisters.callee_closure
				 andalso c' = c
				 andalso reg_operand' <> c_reg
				 andalso reg_operand' <> r_reg
				 andalso reg_operand <> c_reg
				 andalso reg_operand <> r_reg then
				 (true, move_op :: store_op :: opcode :: tail)
			       else
				 (false, [])
			     end
			 | _ => (false, [])
			     )
		      else
			(false, [])
		    (* Don't bother if the store will use global, cos it won't work *)
		  in
		    if shuffle then
		      ([], new_opcode_list, block_list, final_result)
		    else
		      let
			val rd = lookup_reg_operand reg_operand
			val rs1 = lookup_reg_operand reg_operand'
			val store = case store_op of
			  MirTypes.LD => Sparc_Assembly.LD
			| MirTypes.ST => Sparc_Assembly.ST
			| MirTypes.LDB => Sparc_Assembly.LDUB
			| MirTypes.STB => Sparc_Assembly.STB
			| MirTypes.LDREF => Sparc_Assembly.LD
			| MirTypes.STREF => Sparc_Assembly.ST
		      in
			if is_reg gp_operand orelse
			  gp_check_range(gp_operand, true, arith_imm_limit) then
			  let
			    val reg_or_imm =
			      if is_reg gp_operand then
				Sparc_Assembly.REG(lookup_gp_operand gp_operand)
			      else make_imm_for_store gp_operand
			  in
			    ([(Sparc_Assembly.LOAD_AND_STORE(store, rd, rs1,
							     reg_or_imm), absent, "")],
			     opcode_list, block_list, final_result)
			  end
			else
			  ([],
			   MirTypes.UNARY(MirTypes.MOVE,
					  MirTypes.GC_REG MirRegisters.global,
					  gp_operand) ::
			   MirTypes.STOREOP(store_op, reg_operand,
					    reg_operand',
					    MirTypes.GP_GC_REG
					    MirRegisters.global) ::
			   opcode_list, block_list, final_result)
		      end
		  end
		| MirTypes.STOREFPOP(store_fp_op, fp_operand, reg_operand,
				     gp_operand) =>
		  let
		    val frd = lookup_fp_operand fp_operand
		    val rs1 = lookup_reg_operand reg_operand
		    val (store, repeat) =
		      case (MachTypes.fp_used, store_fp_op) of
			(MachTypes.single, MirTypes.FLD) =>
			  (Sparc_Assembly.LDF, false)
		      | (MachTypes.single, MirTypes.FST) =>
			  (Sparc_Assembly.STF, false)
		      | (MachTypes.single, MirTypes.FLDREF) =>
			  (Sparc_Assembly.LDF, false)
		      | (MachTypes.single, MirTypes.FSTREF) =>
			  (Sparc_Assembly.STF, false)
		      | (MachTypes.double, MirTypes.FLD) =>
			  (Sparc_Assembly.LDDF, false)
		      | (MachTypes.double, MirTypes.FST) =>
			  (Sparc_Assembly.STDF, false)
		      | (MachTypes.double, MirTypes.FLDREF) =>
			  (Sparc_Assembly.LDDF, false)
		      | (MachTypes.double, MirTypes.FSTREF) =>
			  (Sparc_Assembly.STDF, false)
		      | (MachTypes.extended, MirTypes.FLD) =>
			  (Sparc_Assembly.LDDF, true)
		      | (MachTypes.extended, MirTypes.FST) =>
			  (Sparc_Assembly.STDF, true)
		      | (MachTypes.extended, MirTypes.FLDREF) =>
			  (Sparc_Assembly.LDDF, true)
		      | (MachTypes.extended, MirTypes.FSTREF) =>
			  (Sparc_Assembly.STDF, true)
		    val gp_op = case reg_operand of
		      MirTypes.GC_REG reg => MirTypes.GP_GC_REG reg
		    | MirTypes.NON_GC_REG reg => MirTypes.GP_NON_GC_REG reg
		    fun gp_op_is_large(arg as MirTypes.GP_IMM_ANY i) =
		      gp_check_range(arg, true, arith_imm_limit) andalso
		      gp_check_range(MirTypes.GP_IMM_INT(i+8), true,
				     arith_imm_limit)
		    | gp_op_is_large(MirTypes.GP_IMM_INT i) =
		      gp_op_is_large(MirTypes.GP_IMM_ANY(i*4))
		    | gp_op_is_large(arg as MirTypes.GP_IMM_SYMB symb) =
		      gp_op_is_large(MirTypes.GP_IMM_ANY(symbolic_value symb))
		    | gp_op_is_large(MirTypes.GP_GC_REG _) = true
		    | gp_op_is_large(MirTypes.GP_NON_GC_REG _) = true
		  in
		    if repeat then
		      if gp_op_is_large gp_operand then
			([],
			 MirTypes.BINARY(MirTypes.ADDU,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_op,
					 gp_operand) ::
			 MirTypes.STOREFPOP(store_fp_op, fp_operand,
					    MirTypes.GC_REG
					    MirRegisters.global,
					    MirTypes.GP_IMM_ANY 0) ::
			 opcode_list, block_list, final_result)
		      else
			let
			  val (imm, arg) =
			    case make_imm_for_store gp_operand of
			      imm as Sparc_Assembly.IMM arg => (imm, arg)
			    | _ => Crash.impossible
				"make_imm_for_store fails to return IMM"
			  val imm' = Sparc_Assembly.IMM(arg+8)
			in
			  ([(Sparc_Assembly.LOAD_AND_STORE_FLOAT
			     (store, frd, rs1, imm),
			     absent, ""),
			    (Sparc_Assembly.LOAD_AND_STORE_FLOAT
			     (store,
			      MachTypes.next_reg(MachTypes.next_reg frd),
			      MachTypes.next_reg(MachTypes.next_reg rs1),
			      imm'),
			     absent, "")],
			  opcode_list, block_list, final_result)
			end
		    else
		      if is_reg gp_operand orelse
			gp_check_range(gp_operand, true, arith_imm_limit) then
			let
			  val reg_or_imm =
			    if is_reg gp_operand then
			      Sparc_Assembly.REG(lookup_gp_operand gp_operand)
			    else make_imm_for_store gp_operand
			in
			  ([(Sparc_Assembly.LOAD_AND_STORE_FLOAT(store, frd,
								 rs1,
								 reg_or_imm),
			     absent, "")],
			   opcode_list, block_list, final_result)
			end
		      else
			([],
			 MirTypes.BINARY(MirTypes.ADDU,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_op,
					 gp_operand) ::
			 MirTypes.STOREFPOP(store_fp_op, fp_operand,
					    MirTypes.GC_REG
					    MirRegisters.global,
					    MirTypes.GP_IMM_ANY 0) ::
			 opcode_list, block_list, final_result)
		  end
		| MirTypes.REAL(int_to_float, fp_operand, gp_operand) =>
		    let
		      val operation = case MachTypes.fp_used of
			MachTypes.single => Sparc_Assembly.FITOS
		      | MachTypes.double => Sparc_Assembly.FITOD
		      | MachTypes.extended => Sparc_Assembly.FITOX
		      val rd = lookup_fp_operand fp_operand
		      val rs2 =
			if is_reg gp_operand then
			  lookup_gp_operand gp_operand
			else
			  MachTypes.global
		    in
		      if is_reg gp_operand then
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (Sparc_Assembly.SRA, MachTypes.global,
			    rs2, Sparc_Assembly.IMM 2), absent,
			   "Untag operand"),
			  (Sparc_Assembly.LOAD_AND_STORE(Sparc_Assembly.ST,
							 MachTypes.global,
							 MachTypes.fp,
							 Sparc_Assembly.IMM
							 ~4), absent,
			   "Store the value to be converted in spare slot"),
			  (Sparc_Assembly.LOAD_AND_STORE_FLOAT
			   (Sparc_Assembly.LDF, rd, MachTypes.fp,
			    Sparc_Assembly.IMM ~4), absent,
			   "And reload to fp register"),
			  (Sparc_Assembly.CONV_OP(operation, rd, rd),
			   absent, "")],
			 opcode_list, block_list, final_result)
		      else
			([],
			 MirTypes.UNARY(MirTypes.MOVE,
					MirTypes.GC_REG MirRegisters.global,
					gp_operand) ::
			 MirTypes.REAL(int_to_float, fp_operand,
				       MirTypes.GP_GC_REG
				       MirRegisters.global) ::
			 opcode_list, block_list, final_result)
		    end
		| MirTypes.FLOOR(float_to_int, tag, reg_operand, fp_operand) =>
		    let

		      val (operation,operation',test,subtract) =
                        case MachTypes.fp_used of
                          MachTypes.single => (Sparc_Assembly.FSTOI,Sparc_Assembly.FITOS,Sparc_Assembly.FCMPS,Sparc_Assembly.FSUBS)
                        | MachTypes.double => (Sparc_Assembly.FDTOI,Sparc_Assembly.FITOD,Sparc_Assembly.FCMPD,Sparc_Assembly.FSUBD)
                        | MachTypes.extended => (Sparc_Assembly.FXTOI,Sparc_Assembly.FITOX,Sparc_Assembly.FCMPX,Sparc_Assembly.FSUBX)
		      val rs2 = lookup_fp_operand fp_operand
		      val rd = lookup_reg_operand reg_operand
                      (* Branch here to finish *)
                      val finish_tag = MirTypes.new_tag()
                      val code_list =
                       [(* Test for a possible overflow if the number is too
                         big in magnitude.  Can't rely on hardware trap,
                         because our ints are only 30 bits. *)
                        (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                         (Sparc_Assembly.OR,MachTypes.global,
                          MachTypes.G0,Sparc_Assembly.IMM 1),absent,""),
                        (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                         (Sparc_Assembly.SLL,MachTypes.global,
                          MachTypes.global, Sparc_Assembly.IMM 29),absent,""),
                        (Sparc_Assembly.LOAD_AND_STORE
                         (Sparc_Assembly.ST,
                          MachTypes.global,
                          MachTypes.fp,
                          Sparc_Assembly.IMM ~4), absent,""),
                        (Sparc_Assembly.LOAD_AND_STORE_FLOAT
                         (Sparc_Assembly.LDF, MachTypes.fp_global,
                          MachTypes.fp,
                          Sparc_Assembly.IMM ~4), absent,
                         "Save converted value"),
                        (* Make 2**29 in fp_global *)
                        (Sparc_Assembly.CONV_OP(operation', MachTypes.fp_global,
						MachTypes.fp_global),
                         absent, ""),
                        (Sparc_Assembly.FUNARY(test, rs2, MachTypes.fp_global), absent, ""),
                        (* If rs2 >= 2**29 then error *)
                        (Sparc_Assembly.FBRANCH(Sparc_Assembly.FBGE, 0), SOME tag, ""),
                        Sparc_Assembly.nop,

                        (Sparc_Assembly.FUNARY(Sparc_Assembly.FNEG,
                                               MachTypes.fp_global, MachTypes.fp_global), absent, ""),
                        (Sparc_Assembly.FUNARY(test, rs2, MachTypes.fp_global), absent, ""),

                        (* If rs2 < -2**29 then error *)
                        (Sparc_Assembly.FBRANCH(Sparc_Assembly.FBL, 0), SOME tag, ""),
                        Sparc_Assembly.nop,

                        (* Do the conversion operation, result to fp_global *)
                        (Sparc_Assembly.CONV_OP(operation, MachTypes.fp_global, rs2),
			  absent, ""),

                        (* And store into the integer register *)
                        (Sparc_Assembly.LOAD_AND_STORE_FLOAT
                         (Sparc_Assembly.STF, MachTypes.fp_global, MachTypes.fp, Sparc_Assembly.IMM ~4),
                         absent,"Save converted value"),
                        (Sparc_Assembly.LOAD_AND_STORE
                         (Sparc_Assembly.LD,rd, MachTypes.fp,Sparc_Assembly.IMM ~4),
                         absent, "And reload into destination"),
			(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			 (Sparc_Assembly.SLL, rd, rd, Sparc_Assembly.IMM 2),
			 absent, "Tag the result"),

                        (* Now test for a negative quantity that needs decrementing *)
                        (* Put zero in fp_global *)
                        (Sparc_Assembly.FBINARY(subtract, MachTypes.fp_global, rs2, rs2),
                         absent, ""),
                        (Sparc_Assembly.FUNARY(test, rs2, MachTypes.fp_global), absent, ""),
                        (* Branch to finish if rs2 >= 0 *)
                        (Sparc_Assembly.FBRANCH(Sparc_Assembly.FBGE, 0), SOME finish_tag, ""),
                        Sparc_Assembly.nop,
                        (* If real (round rs2) = rs2 then no adjustment necessary *)
                        (* Get the rounded result back.  This is still in the stack slot *)
                        (Sparc_Assembly.LOAD_AND_STORE_FLOAT
                         (Sparc_Assembly.LDF, MachTypes.fp_global,MachTypes.fp,Sparc_Assembly.IMM ~4),
                         absent, "Load back converted value"),
                        (* Convert it to a float again *)
                        (Sparc_Assembly.CONV_OP
                         (operation', MachTypes.fp_global,MachTypes.fp_global),
                         absent, ""),
                        (* And compare with rs2 *)
                        (Sparc_Assembly.FUNARY(test, rs2, MachTypes.fp_global), absent, ""),
                        (* If equal then we are done *)
                        (Sparc_Assembly.FBRANCH(Sparc_Assembly.FBE, 0), SOME finish_tag, ""),
                        Sparc_Assembly.nop,
                        (* Else subtract one from result *)
                        (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			 (Sparc_Assembly.SUB, rd, rd, Sparc_Assembly.IMM 4),
			 absent, "Adjust the result"),
                        (* And branch to finish *)
                        (Sparc_Assembly.BRANCH_ANNUL (Sparc_Assembly.BA, 0),
                         SOME finish_tag,
                         "Done now"),
                        Sparc_Assembly.nop]
		    in
		      (code_list,[], MirTypes.BLOCK (finish_tag,opcode_list)::block_list, final_result)
		    end
		| MirTypes.BRANCH(branch, bl_dest) =>
		    ((case bl_dest of
		      MirTypes.REG reg =>
			[(Sparc_Assembly.JUMP_AND_LINK
			  (Sparc_Assembly.JMPL, MachTypes.G0,
			   lookup_reg_operand reg, Sparc_Assembly.IMM 0,
                           Debugger_Types.null_backend_annotation),
			  absent, "Branch indirect"),
			 Sparc_Assembly.nop]
		    | MirTypes.TAG tag =>
			[(Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, 0),
			  SOME tag, "Branch relative"),
			 Sparc_Assembly.nop]),
			opcode_list, block_list, final_result)

		| MirTypes.TEST(mn, tag, gp_operand, gp_operand') => let
		    val mn' = case mn of
		      MirTypes.BNT => Sparc_Assembly.BE
		    | MirTypes.BTA => Sparc_Assembly.BNE
		    | MirTypes.BEQ => Sparc_Assembly.BE
		    | MirTypes.BNE => Sparc_Assembly.BNE
		    | MirTypes.BHI => Sparc_Assembly.BGU
		    | MirTypes.BLS => Sparc_Assembly.BLEU
		    | MirTypes.BHS => Sparc_Assembly.BCC
		    | MirTypes.BLO => Sparc_Assembly.BCS
		    | MirTypes.BGT => Sparc_Assembly.BG
		    | MirTypes.BLE => Sparc_Assembly.BLE
		    | MirTypes.BGE => Sparc_Assembly.BGE
		    | MirTypes.BLT => Sparc_Assembly.BL

		    val redo = not (is_reg gp_operand) andalso (is_reg gp_operand')
		    val ok =   is_reg gp_operand andalso (not (is_reg gp_operand'))
		    val both = is_reg gp_operand andalso is_reg gp_operand'

		    val test = case mn of
		      MirTypes.BTA => Sparc_Assembly.ANDCC
		    | MirTypes.BNT => Sparc_Assembly.ANDCC
		    | _            => Sparc_Assembly.SUBCC
		  in
		    if redo (* lhs is imm *) then
		      if gp_check_range(gp_operand, true, arith_imm_limit) then let (* lhs imm16 *)
		      in
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (test, MachTypes.G0, lookup_gp_operand gp_operand',
                            make_imm_format3 gp_operand), absent, "test..."),
			  (Sparc_Assembly.BRANCH_ANNUL (Sparc_Assembly.reverse_branch mn', 0),
			   SOME tag, ""),
			  Sparc_Assembly.nop],
			opcode_list, block_list, final_result)
		      end
		      else
			([],
			 MirTypes.UNARY (MirTypes.MOVE,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_operand)
			 :: MirTypes.TEST (mn, tag, MirTypes.GP_GC_REG MirRegisters.global, gp_operand')
			 :: opcode_list, block_list, final_result)
		    else if ok (* rhs is imm *) then
		      if gp_check_range (gp_operand', true, arith_imm_limit) (* rhs is imm16 *) then
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (test, MachTypes.G0, lookup_gp_operand gp_operand, make_imm_format3 gp_operand'), absent, "test..."),
			  (Sparc_Assembly.BRANCH_ANNUL (mn', 0), SOME tag, ""),
			  Sparc_Assembly.nop],
			opcode_list, block_list, final_result)
		      else (* rhs is imm32 *)
			([],
			 MirTypes.UNARY (MirTypes.MOVE,
					 MirTypes.GC_REG MirRegisters.global,
					 gp_operand')
			 :: MirTypes.TEST (mn, tag, gp_operand, MirTypes.GP_GC_REG MirRegisters.global)
			 :: opcode_list, block_list, final_result)
		      else if both (* both registers *) then
			([(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (test, MachTypes.G0,lookup_gp_operand gp_operand,
                            Sparc_Assembly.REG (lookup_gp_operand gp_operand')), absent, "test..."),
			  (Sparc_Assembly.BRANCH_ANNUL (mn', 0), SOME tag, ""),
			  Sparc_Assembly.nop],
			opcode_list, block_list, final_result)
			else (* both constants ahhh *) let
                          fun gp_value(MirTypes.GP_IMM_INT i) = (i, 0)
                            | gp_value(MirTypes.GP_IMM_ANY i) = (i div 4, i mod 4)
                            | gp_value(MirTypes.GP_IMM_SYMB symb) = (symbolic_value symb, 0)
                            | gp_value _ = Crash.impossible "gp_value:non-constant operand"
			  val (gp_op as (hilhs, lolhs)) = gp_value gp_operand
			  val (gp_op' as (hirhs, lorhs)) = gp_value gp_operand'
                          infix less greater lesseq greatereq
                          fun n less m =
                            if n >= 0
                              then if m >=0 then n < m else true
                              else if m >= 0 then false else n > m
                          fun n lesseq m = n = m orelse n less m
                          fun n greater m = not (n lesseq m)
                          fun n greatereq m = not (n less m)
			  val pre = case mn of (* precalculating result *)
			    MirTypes.BGT => (hilhs > hirhs) orelse (hilhs = hirhs andalso lolhs > lorhs)
			  | MirTypes.BLE => (hilhs < hirhs) orelse (hilhs = hirhs andalso lolhs <= lorhs)
			  | MirTypes.BGE => (hilhs > hirhs) orelse (hilhs = hirhs andalso lolhs >= lorhs)
			  | MirTypes.BLT => (hilhs < hirhs) orelse (hilhs = hirhs andalso lolhs < lorhs)
			  | MirTypes.BNT => Bits.andb (lolhs, lorhs) = 0
			  | MirTypes.BTA => Bits.andb (lolhs, lorhs) <> 0
			  | MirTypes.BEQ => gp_op = gp_op' (* tricky *)
			  | MirTypes.BNE => gp_op <> gp_op'
                          (* unsigned operations *)
			  | MirTypes.BHI => (hilhs greater hirhs) orelse (hilhs = hirhs andalso lolhs greater lorhs)
			  | MirTypes.BLS => (hilhs less hirhs) orelse (hilhs = hirhs andalso lolhs lesseq lorhs)
			  | MirTypes.BHS => (hilhs greater hirhs) orelse (hilhs = hirhs andalso lolhs greatereq lorhs)
			  | MirTypes.BLO => (hilhs less hirhs) orelse (hilhs = hirhs andalso lolhs less lorhs)
			in
			  if pre (* jump directly to tag and drop other stuff *) then
			    ([],
			     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG tag)],
			     block_list, final_result)
			  else
			    ([], opcode_list, block_list, final_result)
			end
		  end
		
	      | MirTypes.FTEST(fcond_branch, tag, fp_operand,
			       fp_operand') =>
		  let
		    val branch = case fcond_branch of
		      MirTypes.FBEQ => Sparc_Assembly.FBE
		    | MirTypes.FBNE => Sparc_Assembly.FBNE
		    | MirTypes.FBLE => Sparc_Assembly.FBLE
		    | MirTypes.FBLT => Sparc_Assembly.FBL
		    val rs1 = lookup_fp_operand fp_operand
		    val rs2 = lookup_fp_operand fp_operand'
		    val test_instr = case MachTypes.fp_used of
		      MachTypes.single => Sparc_Assembly.FCMPS
		    | MachTypes.double => Sparc_Assembly.FCMPD
		    | MachTypes.extended => Sparc_Assembly.FCMPX
		  in
		    ([(Sparc_Assembly.FUNARY(test_instr, rs1, rs2),
		       absent, "Do the test"),
		      (Sparc_Assembly.FBRANCH_ANNUL(branch, 0),
		       SOME tag, "Do the branch"),
		      Sparc_Assembly.nop],
		    opcode_list, block_list, final_result)
		  end
		| MirTypes.BRANCH_AND_LINK(_, MirTypes.REG reg_operand,debug_information,_) =>
		    ([(Sparc_Assembly.JUMP_AND_LINK
		      (Sparc_Assembly.JMPL, MachTypes.lr,
		       lookup_reg_operand reg_operand, Sparc_Assembly.IMM Tags.CODE_OFFSET,
                       debug_information),
		      absent, "Call to tagged value"),
		     Sparc_Assembly.nop],
		    opcode_list, block_list, final_result)
		| MirTypes.BRANCH_AND_LINK(_, MirTypes.TAG tag,debug_info,_) =>
		    ([(Sparc_Assembly.Call (Sparc_Assembly.CALL, 0,debug_info),
                       SOME tag, "Call"),
                      Sparc_Assembly.nop],
		    opcode_list, block_list, final_result)
		| MirTypes.TAIL_CALL(_, bl_dest,_) =>
		    let
		      val restore =
			if needs_preserve then
			  (Sparc_Assembly.SAVE_AND_RESTORE
			   (Sparc_Assembly.RESTORE, MachTypes.G0,
			    MachTypes.G0, Sparc_Assembly.IMM 0),
			   absent,
			   "Restore in delay slot")
			else
			  Sparc_Assembly.nop
		      (* Restore floating point callee saves first *)
		      val fp_restore =
			if needs_preserve then restore_fps else []
		    in
		      (fp_restore @
		       [(case bl_dest of
			   MirTypes.REG reg =>
			     (Sparc_Assembly.JUMP_AND_LINK
			      (Sparc_Assembly.JMPL, MachTypes.G0,
			       lookup_reg_operand reg, Sparc_Assembly.IMM Tags.CODE_OFFSET,
                               Debugger_Types.null_backend_annotation),
			      absent, "Branch indirect")
			 | MirTypes.TAG tag =>
			     (Sparc_Assembly.BRANCH(Sparc_Assembly.BA, 0),
			      SOME tag, "Branch relative (tail call)")
			     ), restore],
		      opcode_list, block_list, final_result)
		    end
		| MirTypes.SWITCH(computed_goto, reg_operand, tag_list) =>
		    let
		      val reg = lookup_reg_operand reg_operand
		      val _ =
			if reg = MachTypes.lr andalso not needs_preserve then
			  Crash.impossible "SWITCH from lr in leaf case"
			else
			  ()
		    in
		      if length tag_list <= 2 then
			let
			  val (numbered_tag_list, _) =
			    Lists.number_from(tag_list, 0, 4, fn x=> x)
			  fun do_tests(done, []) = rev done
			    | do_tests(done, (tag, imm) :: (rest as _ :: _)) =
			    do_tests((Sparc_Assembly.BRANCH
				      (Sparc_Assembly.BE, 0),
				      SOME tag, "Do the branch") ::
				     (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				      (Sparc_Assembly.SUBCC, MachTypes.G0,
				       reg, Sparc_Assembly.IMM imm),
				      absent, "Do the test") :: done, rest)
			    | do_tests(done, (tag, imm) :: rest) =
			    do_tests((Sparc_Assembly.BRANCH_ANNUL
				      (Sparc_Assembly.BA, 0),
				      SOME tag, "Do the branch") ::
				     (Sparc_Assembly.nop_code, absent,
				      "No test required in final case") ::
				     done, rest)
			in
			  (do_tests([], numbered_tag_list),
			   opcode_list, block_list, final_result)
			end
		      else
			let
			  val switch_to_global = reg = MachTypes.lr
			  val final_instr =
			    if switch_to_global then
			      move_reg(MachTypes.lr, MachTypes.global)
			    else
			      Sparc_Assembly.nop
			  val reg =
			    if switch_to_global then MachTypes.global else reg
			  val instrs =
			    (Sparc_Assembly.Call (Sparc_Assembly.CALL, 2, Debugger_Types.null_backend_annotation),
			     absent, "Call self") ::
			    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			     (Sparc_Assembly.ADD, MachTypes.lr,
			      MachTypes.lr, Sparc_Assembly.IMM(4*4)),
			     absent,
			     "Offset to start of table") ::
			    (Sparc_Assembly.JUMP_AND_LINK
			     (Sparc_Assembly.JMPL, MachTypes.G0,
			      reg, Sparc_Assembly.REG MachTypes.lr,
			      Debugger_Types.null_backend_annotation), absent,
			     "Branch into table") ::
			    final_instr ::
			    map
			    (fn tag =>
			     (Sparc_Assembly.BRANCH_ANNUL
			      (Sparc_Assembly.BA, 0), SOME tag, ""))
			    tag_list
			  val instrs =
			    if switch_to_global then
			      move_reg(MachTypes.global, MachTypes.lr) :: instrs
			    else
			      instrs
			in
			  (instrs, opcode_list, block_list, final_result)
			end
		    end

		| MirTypes.ALLOCATE_STACK(allocate, reg_operand, alloc_size,
					  SOME fp_offset) =>
		  (if alloc_size + fp_offset > gc_stack_alloc_size then
		     Crash.impossible("Stack allocation of " ^
				      Int.toString alloc_size ^
				      " at offset " ^
				      Int.toString fp_offset ^
				      " requested, in total area of only " ^
				      Int.toString
				      gc_stack_alloc_size ^
				      "\n")
		   else();
		   case allocate of
		     MirTypes.ALLOC =>
		       ([],
			MirTypes.BINARY(MirTypes.SUBU, reg_operand,
					MirTypes.GP_GC_REG MirRegisters.fp,
					MirTypes.GP_IMM_ANY
					(gc_stack_alloc_offset +
					 4 * (fp_offset + alloc_size) - Tags.PAIRPTR)) ::
			(* Note tagging on pointer *)
			opcode_list, block_list, final_result)
		   | _ => Crash.impossible"ALLOCATE_STACK strange allocate")
		 | MirTypes.ALLOCATE_STACK _ =>
		     Crash.impossible"ALLOCATE_STACK with no offset from fp"
		 | MirTypes.DEALLOCATE_STACK _ =>
		     ([], opcode_list, block_list, final_result)
		 | MirTypes.ALLOCATE(allocate, reg_operand, gp_operand) =>
		     let
                       val rd = lookup_reg_operand reg_operand
		       val _ =
			 if rd = MachTypes.lr then Crash.impossible "ALLOC into lr" else ()
                       val (link, gc_entry) =
                         if needs_preserve then
                           (MachTypes.lr, Sparc_Assembly.IMM (4 * Implicit_Vector.gc))
                         else
                           (MachTypes.gc2, Sparc_Assembly.IMM (4 * Implicit_Vector.gc_leaf))
                       val needs_unaligned_zero =
                         (* for strings and bytearrays don't need to put a zero at the end *)
                         case allocate of
                           MirTypes.ALLOC_STRING => false
                         | MirTypes.ALLOC_BYTEARRAY => false
                         | _ => true
                       val allocation =
                         case gp_operand of
                           MirTypes.GP_IMM_INT size =>
                              let
                                val (bytes, primary, aligned, header) =
                                  case allocate of
                                    MirTypes.ALLOC =>
                                      if size = 2 then
                                        (8, Tags.PAIRPTR, true, 0)
                                      else
                                        (8 * ((size+2) div 2), Tags.POINTER,
                                         size mod 2 <> 0, 64*size+Tags.RECORD)
                                  (* Same as records but no pair case *)
                                  | MirTypes.ALLOC_VECTOR =>
                                      (8 * ((size+2) div 2), Tags.POINTER,
                                       size mod 2 <> 0, 64*size+Tags.RECORD)
                                  | MirTypes.ALLOC_STRING =>
                                      (((size+11) div 8) * 8,
                                       Tags.POINTER, true, 64*size+Tags.STRING)
                                  | MirTypes.ALLOC_REAL =>
                                      (case MachTypes.fp_used
                                         of MachTypes.single   => Crash.unimplemented "ALLOC_REAL single"
                                          | MachTypes.extended => Crash.unimplemented "ALLOC_REAL extended"
                                          | MachTypes.double   =>
                                              (16, Tags.POINTER, true,
                                               64*(16 - 4) + Tags.BYTEARRAY))
                                  | MirTypes.ALLOC_REF  =>
                                      (8 + 8*((size+2) div 2),
                                       Tags.REFPTR, size mod 2 <> 0, 64*size+Tags.ARRAY)
                                  | MirTypes.ALLOC_BYTEARRAY =>
                                      (((size+11) div 8) * 8, Tags.REFPTR, true,
                                       64*size+Tags.BYTEARRAY)

                                val header_code =
                                  if header = 0 then [] else
				    load_large_number_into_register
				    (MachTypes.global, MirTypes.GP_IMM_ANY header) @
                                        [(Sparc_Assembly.LOAD_AND_STORE
                                          (Sparc_Assembly.ST, MachTypes.global, rd,
					   Sparc_Assembly.IMM (~primary)),
                                          absent, "Initialise header")]

                                val (high, low) = split_int (MirTypes.GP_IMM_ANY bytes)
                              in
                                if high = 0 then
				  inline_allocate
				  (rd, primary, Sparc_Assembly.IMM bytes, not needs_preserve,
				   (if aligned orelse not needs_unaligned_zero then
				      header_code
				    else
				      (Sparc_Assembly.LOAD_AND_STORE
				       (Sparc_Assembly.ST, MachTypes.G0, rd,
					Sparc_Assembly.IMM (bytes - primary - 4)),
				       absent, "Zero unaligned extra word") ::
				      header_code))
                                else
				  let val load_global1 =
				    (load_large_number_into_register
				     (MachTypes.global, MirTypes.GP_IMM_ANY bytes))
                                    val load_global2 =
				    (load_large_number_into_register
				     (MachTypes.global, MirTypes.GP_IMM_ANY (bytes - primary - 4)))
				  in
				    load_global1 @
				    inline_allocate
				    (rd, primary,
				     Sparc_Assembly.REG MachTypes.global,
				     not needs_preserve,
				     if aligned orelse not needs_unaligned_zero then
				       header_code
				     else
				       load_global2 @
				       ((Sparc_Assembly.LOAD_AND_STORE
					 (Sparc_Assembly.ST, MachTypes.G0, rd,
					  Sparc_Assembly.REG MachTypes.global),
					 absent, "Zero unaligned extra word")::
				       header_code))
				  end
                              end

                            | MirTypes.GP_GC_REG _ =>
                                let
				  val rs = lookup_gp_operand gp_operand
				  val _ =
				    if rs = MachTypes.lr then Crash.impossible"ALLOC from lr" else ()
                                  val (primary, secondary, length_code) =
                                    case allocate of
                                        MirTypes.ALLOC => Crash.unimplemented "ALLOC variable size"
                                      | MirTypes.ALLOC_VECTOR =>
                                        (Tags.POINTER,Tags.RECORD,
                                         [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                           (Sparc_Assembly.ADD, MachTypes.global, rs, Sparc_Assembly.IMM (4+7)),
                                            absent, "Calculate length of record"),
					  (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					   (Sparc_Assembly.ANDN, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM 7),
					   absent, "Calculate aligned size in bytes")])
                                       | MirTypes.ALLOC_STRING =>
                                         (Tags.POINTER, Tags.STRING,
                                          [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                            (Sparc_Assembly.SRL, MachTypes.global, rs, Sparc_Assembly.IMM 2),
                                            absent, "Calculate length of string"),
                                           (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                            (Sparc_Assembly.ADD, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM (4+7)),
                                            absent, ""),
					   (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					    (Sparc_Assembly.ANDN, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM 7),
					    absent, "Calculate aligned size in bytes")])
                                       | MirTypes.ALLOC_REAL   => Crash.unimplemented "ALLOC_REAL variable size"
                                       | MirTypes.ALLOC_REF    =>
                                         (Tags.REFPTR, Tags.ARRAY,
                                          [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                            (Sparc_Assembly.ADD, MachTypes.global, rs, Sparc_Assembly.IMM (12+7)),
                                            absent, "Calculate length of Array"),
					  (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					   (Sparc_Assembly.ANDN, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM 7),
					   absent, "Calculate aligned size in bytes")])
                                       | MirTypes.ALLOC_BYTEARRAY =>
                                         (Tags.REFPTR, Tags.BYTEARRAY,
                                          [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                            (Sparc_Assembly.SRL, MachTypes.global, rs, Sparc_Assembly.IMM 2),
                                            absent, "Calculate length of ByteArray"),
                                           (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                            (Sparc_Assembly.ADD, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM (4+7)),
                                            absent, ""),
					   (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
					    (Sparc_Assembly.ANDN, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM 7),
					    absent, "Calculate aligned size in bytes")])
                                  val header_code =
                                    [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                      (Sparc_Assembly.SLL, MachTypes.global, rs, Sparc_Assembly.IMM 4),
                                      absent, ""),
                                    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                     (Sparc_Assembly.ADD, MachTypes.global, MachTypes.global, Sparc_Assembly.IMM secondary),
                                     absent, "Calculate header tag"),
                                    (Sparc_Assembly.LOAD_AND_STORE
                                     (Sparc_Assembly.ST, MachTypes.global, rd, Sparc_Assembly.IMM (~primary)),
                                     absent, "Initialise header tag")]
                                in
                                  length_code @
				  inline_allocate
                                  (rd, primary, Sparc_Assembly.REG MachTypes.global,
				   not needs_preserve,
                                   if needs_unaligned_zero
                                     then
                                       length_code @
                                       [(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
                                         (Sparc_Assembly.ADD, MachTypes.global, MachTypes.global, Sparc_Assembly.REG rd),
                                         absent, "Calculate end of object"),
                                       (Sparc_Assembly.LOAD_AND_STORE
                                        (Sparc_Assembly.ST, MachTypes.G0, MachTypes.global, Sparc_Assembly.IMM (~4 - primary)),
                                        absent, "Zero last word in case it's unaligned")] @
                                       header_code
                                   else header_code)
                                end
                            | _ => Crash.impossible "Strange parameter to ALLOCATE"
                     in
                       (allocation, opcode_list, block_list, final_result)
                     end
		 | MirTypes.ADR(adr, reg_operand, tag) =>
		     let
		       val rd = lookup_reg_operand reg_operand
		       val _ =
			 if rd = MachTypes.lr then Crash.impossible "ADR into lr" else ()
		     in
		       (case adr of
			  MirTypes.LEA =>
			    [(Sparc_Assembly.Call
			      (Sparc_Assembly.CALL, 2, Debugger_Types.null_backend_annotation),
			      absent, "Call self"),
			     (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			      (Sparc_Assembly.ADD, rd,
			       MachTypes.lr, Sparc_Assembly.IMM 4),
			      SOME tag, "Update gc pointer")]
			(* Note that lr points to the call instruction *)
			(* Thus lr + 4, as computed by the ADD *)
			(* points to the ADD instruction, which is fixed *)
			(* up during linearisation *)
			| MirTypes.LEO =>
			    [(Sparc_Assembly.LOAD_OFFSET
			      (Sparc_Assembly.LEO, rd, 0),
			      SOME tag,
			      "Get offset of tag from procedure start")],
			    opcode_list, block_list, final_result)
		     end
(* Warning. If we ever make a leaf adr, we must ensure *)
(* handler continuations are done safely. This is not currently *)
(* true since they use o1 as the address. *)
(* But since handlers generate stack allocated stuff, they're unlikely to be leaf *)
                | MirTypes.INTERCEPT =>
		    (trace_dummy_instructions, opcode_list, block_list, final_result)

                | MirTypes.INTERRUPT =>
		    let
		      val continue_tag = MirTypes.new_tag() (* Normal flow *)
		      val check_instrs =
			[(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			  (Sparc_Assembly.ADDCC, MachTypes.G0,
			   MachTypes.stack_limit, Sparc_Assembly.IMM 1),
			  NONE, "check for interrupt"),
			 (Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BNE, 0),
			  SOME continue_tag, "branch if no interrupt"),
			 Sparc_Assembly.nop]
		      val continue =
			[(Sparc_Assembly.BRANCH_ANNUL(Sparc_Assembly.BA, 0),
			  SOME continue_tag, "branch if no interrupt"),
			 Sparc_Assembly.nop]
		      val irupt_code =
			if needs_preserve then
			  (* Non-leaf case *)
			  (Sparc_Assembly.LOAD_AND_STORE
			   (Sparc_Assembly.LD, MachTypes.global,
			    MachTypes.implicit,
			    Sparc_Assembly.IMM (4 * Implicit_Vector.event_check)),
			   absent, "Get address of event check") ::
			  (Sparc_Assembly.JUMP_AND_LINK
			   (Sparc_Assembly.JMPL, MachTypes.lr,
			    MachTypes.global, Sparc_Assembly.IMM 0,
			    Debugger_Types.null_backend_annotation),
			   absent, "Do event_check") ::
			  Sparc_Assembly.nop :: continue
			else
			  (* Leaf case *)
			  (Sparc_Assembly.LOAD_AND_STORE
			   (Sparc_Assembly.LD, MachTypes.global,
			    MachTypes.implicit,
			    Sparc_Assembly.IMM (4 * Implicit_Vector.event_check_leaf)),
			   absent, "Get address of event check") ::
			  (Sparc_Assembly.JUMP_AND_LINK
			   (Sparc_Assembly.JMPL, MachTypes.global,
			    MachTypes.global, Sparc_Assembly.IMM 0,
			    Debugger_Types.null_backend_annotation),
			   absent, "Do event_check_leaf") ::
			  Sparc_Assembly.nop :: continue
		    in
		      (check_instrs @ irupt_code, [],
		       MirTypes.BLOCK(continue_tag, opcode_list) :: block_list,
		       final_result)
		    end
		| MirTypes.ENTER _ =>
		    if needs_preserve then
		      let
			val gc_stack_slots =
			  (if stack_need_init then
			    gc_stack_alloc_size
			  else
			    0) +
			     (if spills_need_init then
				gc_spill_size
			      else
				0)
			val top_tag = MirTypes.new_tag()
			val end_tag = MirTypes.new_tag()
			val clean_start =
			  if stack_need_init then
			    register_save_size
			  else
			    register_save_size + 4 * gc_stack_alloc_size
			val (clean_stack, opcodes, block) =
			  if gc_stack_slots <= 10 then
			    if gc_stack_slots = 0 then
			      (false,
			       [(Sparc_Assembly.BRANCH_ANNUL
				 (Sparc_Assembly.BA, 0),
				 SOME end_tag,
				 "Finish cleaning stack"),
				Sparc_Assembly.nop],
			       (* The linearisation process will remove *)
			       (* this irrelevant block *)
			       (top_tag, []))
			    else
			      (false,
			       n_stores(clean_start, gc_stack_slots, end_tag),
			       (top_tag, []))
			  else
			    let
			      val branch_out =
				[(Sparc_Assembly.BRANCH_ANNUL
				  (Sparc_Assembly.BA, 0),
				  SOME top_tag,
				  "")]
			      val (clean_start, extra) =
				if clean_start mod 8 = 4 then
				  (clean_start - 4, 4)
				  (* Start one earlier if not aligned *)
				else
				  (clean_start, 0)
			      val load_limit =
				let
				  val the_limit =
				    let
				      val gc_stack_size =
					4 * gc_stack_slots + extra
				    in
				      if gc_stack_size mod 8 = 0 then
					gc_stack_size
				      else
					gc_stack_size+4
				    end
(* If not 0 mod 8, we just uselessly initialise an fp or non_gc slot *)
				in
				  if check_range(the_limit, true,
						 arith_imm_limit) then
				    move_imm(MachTypes.global,
					     the_limit) :: branch_out
				  else
				    load_large_number_into_register
				    (MachTypes.global, MirTypes.GP_IMM_ANY the_limit) @
				    branch_out
				end
			      val load_start =
				(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				 (Sparc_Assembly.ADD, MachTypes.O2,
				  MachTypes.sp, Sparc_Assembly.IMM clean_start),
                                 absent,
				 "") ::
				load_limit
			      val store_loop =
				[(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				  (Sparc_Assembly.SUBCC, MachTypes.global,
				   MachTypes.global, Sparc_Assembly.IMM 8),
				  absent, "Update counter"),
				 (Sparc_Assembly.BRANCH_ANNUL
				  (Sparc_Assembly.BGE, 0),
				  SOME top_tag,
				  "Branch if not finished"),
				 (Sparc_Assembly.LOAD_AND_STORE
				  (Sparc_Assembly.STD, MachTypes.G0,
				   MachTypes.global,
				   Sparc_Assembly.REG MachTypes.O2),
				  absent,
				  "Initialise a stack slot (delay slot)"),
				 (Sparc_Assembly.BRANCH_ANNUL
				  (Sparc_Assembly.BA, 0),
				  SOME end_tag, ""),
				 Sparc_Assembly.nop]
			    in
			      (true, load_start, (top_tag, store_loop))
			    end
			val (opcode_list, block_list, final_result) =
			  if clean_stack then
			    ([],
			     (MirTypes.BLOCK(end_tag, opcode_list)) ::
			     block_list,
			     block :: final_result)
			  else (opcode_list, block_list, final_result)

			val ov_tag = MirTypes.new_tag()  (* Overflow case *)
			val non_ov_tag = MirTypes.new_tag()
			(* Non overflow case *)

			val join_tag = MirTypes.new_tag()
			val final_result = (join_tag, opcodes) :: final_result
			val immediate_size =
			  check_range(frame_size, true, arith_imm_limit)
			val test_opcodes =
			  [(Sparc_Assembly.BRANCH_ANNUL
			    (Sparc_Assembly.BLEU, 0),
			    SOME non_ov_tag,
			    "Unsigned stack overflow test"),
			   Sparc_Assembly.nop,
			   (Sparc_Assembly.BRANCH_ANNUL
			    (Sparc_Assembly.BA, 0),
			    SOME ov_tag, ""),
			   Sparc_Assembly.nop]
			val check_and_test_opcodes =
			  if non_save_frame_size = 0 then
			    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			     (Sparc_Assembly.SUBCC, MachTypes.G0,
			      MachTypes.stack_limit, Sparc_Assembly.REG MachTypes.sp),
			     absent,
			     "Compare stack size") ::
			    test_opcodes
			  else
			    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			     (Sparc_Assembly.SUB,
                              MachTypes.global,
                              MachTypes.sp,
			      if immediate_size then
				Sparc_Assembly.IMM frame_size
			      else
				Sparc_Assembly.REG MachTypes.G7),
			     absent, "Check the stack for underflow") ::
			    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			     (Sparc_Assembly.SUBCC, MachTypes.G0,
			      MachTypes.stack_limit,
			      Sparc_Assembly.REG(MachTypes.global)),
			     absent,
			     "Compare stack size") ::
			    test_opcodes
			val check_for_stack_overflow_wrap =
			  if immediate_size then
			    check_and_test_opcodes
			  else
			    load_large_number_into_register
			    (MachTypes.G7, MirTypes.GP_IMM_ANY frame_size) @
			    check_and_test_opcodes
			val post_ov_code =
			  [(Sparc_Assembly.BRANCH_ANNUL
			    (Sparc_Assembly.BA, 0),
			    SOME non_ov_tag, ""),
			   Sparc_Assembly.nop]
			val post_ov_code =
			  if immediate_size then
			    post_ov_code
			  else
			    load_large_number_into_register
			    (MachTypes.G7, MirTypes.GP_IMM_ANY frame_size) @
			    post_ov_code
			val post_ov_code =
			     (Sparc_Assembly.LOAD_AND_STORE
			      (Sparc_Assembly.LD, MachTypes.global,
			       MachTypes.implicit,
			       Sparc_Assembly.IMM (4 * Implicit_Vector.extend)),
			      absent, "Get address of stack_overflow") ::
			     (Sparc_Assembly.JUMP_AND_LINK
			      (Sparc_Assembly.JMPL, MachTypes.global,
			       MachTypes.global,Sparc_Assembly.IMM 0,
			       Debugger_Types.null_backend_annotation),
			      absent, "Do stack_overflow") ::
			     Sparc_Assembly.nop ::
			     post_ov_code
			val ov_tag_code =
			  if immediate_size then
			    (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			     (Sparc_Assembly.OR, MachTypes.G7,
			      MachTypes.G0, Sparc_Assembly.IMM frame_size),
			     absent, "Set the required size in G7") :: post_ov_code
			  else
			    post_ov_code
		      in
			(check_for_stack_overflow_wrap,
			 [],
			 (case opcode_list of
			    [] => block_list
			  | _ =>
			      MirTypes.BLOCK(end_tag,opcode_list) ::
			      block_list),
			    (non_ov_tag,
			     (if immediate_size
				then []
			      else
				[(Sparc_Assembly.ARITHMETIC_AND_LOGICAL
				  (Sparc_Assembly.SUB, MachTypes.G7,
				   MachTypes.G0, Sparc_Assembly.REG(MachTypes.G7)),
				  absent, "Negate the frame size")]) @
				((Sparc_Assembly.SAVE_AND_RESTORE
				  (Sparc_Assembly.SAVE, MachTypes.sp,
                                   MachTypes.sp,
				   if immediate_size
				     then Sparc_Assembly.IMM(~frame_size)
				   else Sparc_Assembly.REG MachTypes.G7),
                                  absent, "New frame") ::
				(save_fps @
				 [(Sparc_Assembly.BRANCH_ANNUL
				   (Sparc_Assembly.BA, 0),
				   SOME join_tag, ""),
				  Sparc_Assembly.nop]))) ::
			    (ov_tag,ov_tag_code)  ::
			    final_result)
		      end
		    else
		      ([], opcode_list, block_list, final_result)

		| MirTypes.RTS =>
		    (if needs_preserve then
		       restore_fps @
		       [(Sparc_Assembly.JUMP_AND_LINK
			 (Sparc_Assembly.JMPL, MachTypes.G0,
			  MachTypes.after_preserve MachTypes.lr,
			  Sparc_Assembly.IMM 8,
			  Debugger_Types.null_backend_annotation),
			 absent, "Scheduled return"),
		       (Sparc_Assembly.SAVE_AND_RESTORE
			(Sparc_Assembly.RESTORE, MachTypes.G0, MachTypes.G0,
			 Sparc_Assembly.IMM 0),
                        absent, "Restore in the delay slot")]
		     else
		       [(Sparc_Assembly.JUMP_AND_LINK
			 (Sparc_Assembly.JMPL, MachTypes.G0,
			  MachTypes.lr, Sparc_Assembly.IMM 8,
			  Debugger_Types.null_backend_annotation),
			 absent, "Ordinary return"),
			Sparc_Assembly.nop],
		       opcode_list, block_list, final_result)
		| MirTypes.NEW_HANDLER(handler_frame, tag) =>
		    ([(Sparc_Assembly.LOAD_AND_STORE
		       (Sparc_Assembly.ST, MachTypes.handler,
			lookup_reg_operand handler_frame,
			Sparc_Assembly.IMM(~1)),
		       absent,
		       "Insert pointer to previous handler"),
		      move_reg(MachTypes.handler, lookup_reg_operand handler_frame)],
		     opcode_list, block_list, final_result)
		| MirTypes.OLD_HANDLER =>
		    ([(Sparc_Assembly.LOAD_AND_STORE
		       (Sparc_Assembly.LD, MachTypes.handler, MachTypes.handler,
			Sparc_Assembly.IMM(~1)),
		       absent,
		       "Restore old handler")], opcode_list, block_list, final_result)
		| MirTypes.RAISE reg =>
		    let
		      val code =
			if needs_preserve then
			  [(Sparc_Assembly.LOAD_AND_STORE
			    (Sparc_Assembly.LD, MachTypes.global,
			     MachTypes.implicit,
			     Sparc_Assembly.IMM (4 * Implicit_Vector.raise_code)),
			    absent, "Get the handler"),
			  (Sparc_Assembly.JUMP_AND_LINK
			   (Sparc_Assembly.JMPL, MachTypes.lr,
			    MachTypes.G0, Sparc_Assembly.REG MachTypes.global,
			    Debugger_Types.null_backend_annotation),
			   absent, "Raise"),
			  (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (Sparc_Assembly.OR, MachTypes.caller_arg,
                            lookup_reg_operand reg,
                            Sparc_Assembly.REG MachTypes.G0),
			   absent, "Move arg to raise into arg reg")]
			else
			  [(Sparc_Assembly.LOAD_AND_STORE
			    (Sparc_Assembly.LD, MachTypes.global,
			     MachTypes.implicit,
			     Sparc_Assembly.IMM (4 * Implicit_Vector.leaf_raise_code)),
			    absent, "Get the handler"),
			  (Sparc_Assembly.JUMP_AND_LINK
			   (Sparc_Assembly.JMPL, MachTypes.G0,
			    MachTypes.G0, Sparc_Assembly.REG MachTypes.global,
			    Debugger_Types.null_backend_annotation),
			   absent, "Raise"),
			  (Sparc_Assembly.ARITHMETIC_AND_LOGICAL
			   (Sparc_Assembly.OR, MachTypes.caller_arg,
			    lookup_reg_operand reg,
			    Sparc_Assembly.REG MachTypes.G0),
			   absent,"Move arg to raise into arg reg")]
		     in
		       (code, opcode_list, block_list, final_result)
		    end
		| MirTypes.COMMENT string =>
		    Crash.impossible"MirTypes.COMMENT not filtered out"
		| MirTypes.CALL_C =>
		    ([(Sparc_Assembly.LOAD_AND_STORE
		       (Sparc_Assembly.LD, MachTypes.global,
			MachTypes.implicit, Sparc_Assembly.IMM (4 * Implicit_Vector.external)),
		       absent, "Get address of callc"),
		    (Sparc_Assembly.JUMP_AND_LINK
		     (Sparc_Assembly.JMPL, MachTypes.lr,
		      MachTypes.global,Sparc_Assembly.IMM 0, Debugger_Types.null_backend_annotation),
		     absent, "Do call_c"), Sparc_Assembly.nop],
		    opcode_list, block_list, final_result)
	    in
	      do_everything
	      (needs_preserve, tag, opcode_list,
	       Sexpr.CONS(done, Sexpr.ATOM result_list), new_blocks,
	       new_final_result)
	    end

	in
	  do_everything(needs_preserve, tag, Lists.filter_outp is_comment opcodes,
			Sexpr.NIL, rest, [])
	end

      (* Some stuff to do with optimising unconditional branches to returns *)

      fun exit_block [] = NONE
      | exit_block((block as MirTypes.BLOCK(tag, opcode_list)) :: rest) =
	if Lists.exists
	  (fn MirTypes.RTS => true | _ => false)
	  opcode_list
	  then SOME block
	else exit_block rest

      fun small_exit_block(MirTypes.BLOCK(tag,opcode_list)) =
        let
          fun less_than_three_opcodes_that_are_not_comments([],occ) = true
            | less_than_three_opcodes_that_are_not_comments(MirTypes.COMMENT _ :: rest,occ) =
              less_than_three_opcodes_that_are_not_comments(rest,occ)
            | less_than_three_opcodes_that_are_not_comments(_,2) = false
            | less_than_three_opcodes_that_are_not_comments(h::t,occ) =
              less_than_three_opcodes_that_are_not_comments(t,occ+1)
        in
          less_than_three_opcodes_that_are_not_comments(opcode_list,0)
        end

      fun append_small_exit(MirTypes.BLOCK(tag, opcode_list), block_list) =
	let
	  fun do_block(block as MirTypes.BLOCK(tag', opc_list)) =
	    if Lists.exists
	      (fn (MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG t)) => tag = t
	      | _ => false)
	      opc_list then
	      (* Difficult case. Append the exit block onto the block *)
	      (* branching to it, and remove the branch and tag *)
	      let
		val opc' = rev opc_list
		fun get_new_opc_list((comm as MirTypes.COMMENT _) :: rest) =
		  comm :: get_new_opc_list rest
		| get_new_opc_list(MirTypes.BRANCH(MirTypes.BRA,
						   MirTypes.TAG t) ::
				   rest) =
		  if t = tag then rest
		  else
		    Crash.impossible"get_new_opc fails to find proper branch"
		| get_new_opc_list _ =
		  Crash.impossible"get_new_opc fails to find proper branch"
		val new_opc = get_new_opc_list opc'
		fun rev_app([], x) = x
		| rev_app(y, []) = y
		| rev_app(y :: ys, x) = rev_app(ys, y :: x)
	      in
		MirTypes.BLOCK(tag', rev_app(new_opc, opcode_list))
	      end
	    else
	      block
	in
	  map do_block block_list
	end

      fun proc_cg(MirTypes.PROC
		  (procedure_name,
                   proc_tag,
                   MirTypes.PROC_PARAMS {spill_sizes, stack_allocated, ...},
		   block_list,runtime_env)) =
	let
	  val exit_block = exit_block block_list

	  val block_list =
	    case exit_block of
	      NONE => block_list
	    | SOME exit_block =>
		if small_exit_block exit_block then
		  append_small_exit(exit_block, block_list)
		else
		  block_list

	  fun define_fp(map, MirTypes.FP_REG fp) =
	    case MirTypes.FP.Map.tryApply'(map, fp) of
	      NONE => MirTypes.FP.Map.define(map, fp, true)
	    | _ => map

	  fun get_fps_from_opcode(map, MirTypes.TBINARYFP(_, _, fp1, fp2, fp3)) =
	    define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(map, MirTypes.TUNARYFP(_, _, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, MirTypes.BINARYFP(_, fp1, fp2, fp3)) =
	      define_fp(define_fp(define_fp(map, fp1), fp2), fp3)
	    | get_fps_from_opcode(map, MirTypes.UNARYFP(_, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, MirTypes.STOREFPOP(_, fp1, _, _)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.REAL(_, fp1, _)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.FLOOR(_, _, _, fp1)) =
	      define_fp(map, fp1)
	    | get_fps_from_opcode(map, MirTypes.FTEST(_, _, fp1, fp2)) =
	      define_fp(define_fp(map, fp1), fp2)
	    | get_fps_from_opcode(map, _) = map

	  fun get_fps_from_block(map, MirTypes.BLOCK(_, instr_list)) =
	    Lists.reducel get_fps_from_opcode (map, instr_list)

	  val fp = MirTypes.FP.Map.domain(Lists.reducel get_fps_from_block (MirTypes.FP.Map.empty, block_list))

	  val fps = Set.list_to_set(map (fn r => MirTypes.FP.Map.apply'(fp_map, r)) fp)
	  val fps_to_preserve =
	    Set.set_to_list(Set.setdiff(fps,
					#fp MachSpec.corrupted_by_callee))
	
	  val fp_save_size = length fps_to_preserve
	  val preserve_fps = fp_save_size <> 0

	  fun check_instr(MirTypes.BRANCH_AND_LINK _) = true
	    | check_instr MirTypes.CALL_C = true
(*Now allowed to be leaf
	    | check_instr(MirTypes.SWITCH _) = true
*)
            | check_instr(MirTypes.NEW_HANDLER _) = true
	    | check_instr(MirTypes.ADR _) = true
(* Warning. If we ever make a leaf adr, we must ensure *)
(* handler continuations are done safely. This is not currently *)
(* true since they use o1 as the address. *)
            (* These need the extra slot for fp moves *)
            | check_instr (MirTypes.REAL _) = true
            | check_instr (MirTypes.FLOOR _) = true
            | check_instr (MirTypes.STACKOP _) = true
	    | check_instr _ = false

	  fun check_instr_block(MirTypes.BLOCK(_, instr_list)) =
	    Lists.exists check_instr instr_list

	  val stack_opt = stack_allocated
	  val stack_extra = case stack_opt of
	    SOME stack_extra => stack_extra
	  | _ =>  Crash.impossible"Stack size missing to mach_cg"

	  fun check_reg_op(MirTypes.GC_REG r) =
	    MachTypes.check_reg(MirTypes.GC.Map.apply'(gc_map, r))
	    | check_reg_op(MirTypes.NON_GC_REG r) =
	      MachTypes.check_reg(MirTypes.NonGC.Map.apply'(non_gc_map, r))

	  fun check_gp_op(MirTypes.GP_GC_REG r) =
	    MachTypes.check_reg(MirTypes.GC.Map.apply'(gc_map, r))
	    | check_gp_op(MirTypes.GP_NON_GC_REG r) =
	      MachTypes.check_reg(MirTypes.NonGC.Map.apply'(non_gc_map, r))
	    | check_gp_op(MirTypes.GP_IMM_INT _) = ()
	    | check_gp_op(MirTypes.GP_IMM_ANY _) = ()
	    | check_gp_op(MirTypes.GP_IMM_SYMB symbolic) =
	      case symbolic of
		MirTypes.GC_SPILL_SIZE => ()
	      | MirTypes.NON_GC_SPILL_SIZE => ()
	      | MirTypes.GC_SPILL_SLOT _ => raise MachTypes.NeedsPreserve
	      | MirTypes.NON_GC_SPILL_SLOT _ => raise MachTypes.NeedsPreserve
	      | MirTypes.FP_SPILL_SLOT _ => raise MachTypes.NeedsPreserve

	  fun check_instr_regs(MirTypes.TBINARY(_, _, reg_op, gp_op, gp_op')) =
	    (check_reg_op reg_op;
	     check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.BINARY(_, reg_op, gp_op, gp_op')) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.UNARY(_, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.NULLARY(_, reg_op )) =
	      (check_reg_op reg_op)
	    | check_instr_regs(MirTypes.TBINARYFP _) = ()
	    | check_instr_regs(MirTypes.TUNARYFP _) = ()
	    | check_instr_regs(MirTypes.BINARYFP _) = ()
	    | check_instr_regs(MirTypes.UNARYFP _) = ()
	    | check_instr_regs(MirTypes.STACKOP _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.IMMSTOREOP _) =
	      Crash.impossible"IMMSTOREOP not supported on sparc"
	    | check_instr_regs(MirTypes.STOREOP(_, reg_op, reg_op', gp_op )) =
	      (check_reg_op reg_op;
	       check_reg_op reg_op';
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.STOREFPOP(_, _, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.REAL _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.FLOOR _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.BRANCH(_, bl_dest )) =
	      (case bl_dest of
		 MirTypes.REG reg_op => (check_reg_op reg_op)
	       | _ => ())
	    | check_instr_regs(MirTypes.TEST(_, _, gp_op, gp_op')) =
	      (check_gp_op gp_op;
	     check_gp_op gp_op')
	    | check_instr_regs(MirTypes.FTEST _) = ()
	    | check_instr_regs(MirTypes.BRANCH_AND_LINK _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.TAIL_CALL(_, bl_dest,_)) =
	      (case bl_dest of
		 MirTypes.REG reg_op => (check_reg_op reg_op)
	       | _ => ())
	    | check_instr_regs(MirTypes.CALL_C) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.SWITCH _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.ALLOCATE(_, reg_op, gp_op )) =
	      (check_reg_op reg_op;
	       check_gp_op gp_op)
	    | check_instr_regs(MirTypes.ALLOCATE_STACK _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.DEALLOCATE_STACK _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.ADR _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.INTERCEPT) = ()
	    | check_instr_regs(MirTypes.INTERRUPT) = ()
	    | check_instr_regs(MirTypes.ENTER _) = ()
	    | check_instr_regs(MirTypes.RTS) = ()
	    | check_instr_regs(MirTypes.NEW_HANDLER _) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.OLD_HANDLER) =
	      raise MachTypes.NeedsPreserve
	    | check_instr_regs(MirTypes.RAISE reg_op) =
	      (check_reg_op reg_op)
	    | check_instr_regs(MirTypes.COMMENT _) = ()

	  fun check_instr_block_regs(MirTypes.BLOCK(_, instr_list)) =
	    Lists.iterate check_instr_regs instr_list

	  val needs_preserve =
	    (* First check that leaf optimisation is allowed *)
	    not (opt_leaf_fns) orelse
	    (* Then see if any stack has been used *)
	    stack_extra <> 0 orelse (* This should catch the big procedures easily *)
	    (* Then see if any fps need perserving *)
	    preserve_fps orelse
	    (* Now see if any instructions force non-leaf *)
            Lists.exists check_instr_block block_list orelse
	    (* See if we use any non-leaf registers *)
	    ((Lists.iterate check_instr_block_regs block_list;
	      false) handle MachTypes.NeedsPreserve => true)

          val _ =
            if generate_debug_info orelse debug_variables orelse generate_moduler
              then
                debug_map := Debugger_Types.set_proc_data (procedure_name,
                                                           not needs_preserve,
							   true,
							   runtime_env,
                                                           !debug_map)
            else ()
	  val _ =
	    if needs_preserve then ()
	    else
	      diagnostic_output 3
	      (fn _ => [procedure_name, " is leaf\n"])

	  fun move_first (_, []) =
	      Crash.impossible "move_first"
	    | move_first (L, (t, code) :: rest) =
	      if t = proc_tag then (t, code) :: (L @ rest)
	      else move_first ((t, code) :: L, rest)

	  fun block_needs_fp_spare(MirTypes.BLOCK(_, opc_list)) =
	    let
	      fun opc_needs_fp_spare [] = false
	      | opc_needs_fp_spare(MirTypes.REAL _ :: _) = true
	      | opc_needs_fp_spare(MirTypes.FLOOR _ :: _) = true
	      | opc_needs_fp_spare(_ :: rest) = opc_needs_fp_spare rest
	    in
	      opc_needs_fp_spare opc_list
	    end

	  fun proc_needs_fp_spare [] = false
	  | proc_needs_fp_spare(block :: block_list) =
	    block_needs_fp_spare block orelse proc_needs_fp_spare block_list

	  val needs_fp_spare = proc_needs_fp_spare block_list

	  (* Moved this from do_block as it's independent of block number *)
	  val spills_opt = spill_sizes
	  val (gc_spill_size, non_gc_spill_size, fp_spill_size) =
	    case spills_opt of
	      SOME{gc = gc_spill_size,
			       non_gc = non_gc_spill_size,
			       fp = fp_spill_size} =>
	      (gc_spill_size, non_gc_spill_size, fp_spill_size)
	     | _ => Crash.impossible"Spill sizes missing to mach_cg"
	  val non_gc_spill_size =
	    if needs_fp_spare then non_gc_spill_size + 1
	    else non_gc_spill_size
	  val float_value_size = case MachTypes.fp_used of
	    MachTypes.single => 4
	  | MachTypes.double => 8
	  | MachTypes.extended => 16
	  val total_fp_size = fp_spill_size + fp_save_size
	  val total_gc_size = gc_spill_size + stack_extra

	  val non_gc_spill_size =
	    if total_fp_size <> 0 andalso float_value_size <> 4 andalso
	      non_gc_spill_size mod 2 <> 0 then
	      non_gc_spill_size + 1
	    (* Allow an extra word to get alignment for floats *)
	    else
	      non_gc_spill_size
	  (* non_gc_spill_size * 4 is now *)
	  (* double aligned ready for floats if necessary *)

	  val needs_preserve = needs_preserve orelse needs_fp_spare

	  val non_gc_stack_size =
	    non_gc_spill_size * 4 + float_value_size * total_fp_size

	  val total = non_gc_stack_size + total_gc_size * 4
	  val non_gc_stack_size =
	    if total mod 8 = 0 then non_gc_stack_size else non_gc_stack_size + 4
	  (* Allow more non-gc space to get overall double alignment *)

	  val fp_spill_offset = non_gc_spill_size * 4
	  val fp_save_offset = fp_spill_offset + fp_spill_size * float_value_size
	  val gc_spill_offset  = non_gc_stack_size

	  val gc_stack_alloc_offset = gc_spill_offset + gc_spill_size * 4
	  val register_save_offset = gc_stack_alloc_offset + stack_extra * 4

	  val stack_layout =
	    PROC_STACK
	    {non_gc_spill_size = non_gc_spill_size,
	     fp_spill_size = fp_spill_size,
	     fp_save_size = fp_save_size,
	     gc_spill_size = gc_spill_size,
	     gc_stack_alloc_size = stack_extra,
	     register_save_size = 64,
	     non_gc_spill_offset = 0,
	     fp_spill_offset = fp_spill_offset,
	     fp_save_offset = fp_save_offset,
	     gc_spill_offset = gc_spill_offset,
	     gc_stack_alloc_offset = gc_stack_alloc_offset,
	     register_save_offset = register_save_offset,
	     allow_fp_spare_slot = needs_fp_spare,
	     float_value_size = float_value_size
	     }

(*
	  val _ = output(std_out, "non_gc_spill_size = " ^ Int.toString non_gc_spill_size ^ "\n")
	  val _ = output(std_out, "fp_spill_size = " ^ Int.toString fp_spill_size ^ "\n")
	  val _ = output(std_out, "fp_save_size = " ^ Int.toString fp_save_size ^ "\n")
	  val _ = output(std_out, "gc_spill_size = " ^ Int.toString gc_spill_size ^ "\n")
	  val _ = output(std_out, "stack_extra = " ^ Int.toString stack_extra ^ "\n")
	  val _ = output(std_out, "register_save_size = " ^ Int.toString 64 ^ "\n")
	  val _ = output(std_out, "non_gc_spill_offset = " ^ Int.toString 0 ^ "\n")
	  val _ = output(std_out, "fp_spill_offset = " ^ Int.toString fp_spill_offset ^ "\n")
	  val _ = output(std_out, "fp_save_offset = " ^ Int.toString fp_save_offset ^ "\n")
	  val _ = output(std_out, "gc_spill_offset = " ^ Int.toString gc_spill_offset ^ "\n")
	  val _ = output(std_out, "gc_stack_alloc_offset = " ^ Int.toString gc_stack_alloc_offset ^ "\n")
	  val _ = output(std_out, "register_save_offset = " ^ Int.toString register_save_offset ^ "\n")
*)

	  val block_tree =
	    Lists.reducel
	    (fn (map, MirTypes.BLOCK x) => MirTypes.Map.define'(map, x))
	    (MirTypes.Map.empty, block_list)

	  val spill_array = MLWorks.Internal.Array.array(gc_spill_size, true)
	  val stack_array = MLWorks.Internal.Array.array(stack_extra, true)

	  fun ok_store MirTypes.ST = true
	    | ok_store MirTypes.STREF = true
	    | ok_store _ = false

	  fun analyse_instr(_, MirTypes.TBINARY _) = ([], true)
	    | analyse_instr(_, MirTypes.TBINARYFP _) = ([], true)
	    | analyse_instr(_, MirTypes.TUNARYFP _) = ([], true)
	    | analyse_instr(_, MirTypes.REAL _) = ([], true)
	    | analyse_instr(_, MirTypes.FLOOR _) = ([], true)
	    | analyse_instr(_, MirTypes.BRANCH_AND_LINK _) = ([], true)
	    | analyse_instr(_, MirTypes.TAIL_CALL _) = ([], true)
	    | analyse_instr(_, MirTypes.CALL_C) = ([], true)
	    | analyse_instr(_, MirTypes.SWITCH _) = ([], true)
	    | analyse_instr(_, MirTypes.RAISE _) = ([], true)
	    | analyse_instr(_, MirTypes.INTERCEPT) = ([], true)
	    | analyse_instr(_, MirTypes.INTERRUPT) = ([], true)
	    | analyse_instr(_, MirTypes.BRANCH _) = ([], true)
	    | analyse_instr(_, MirTypes.TEST _) = ([], true)
	    | analyse_instr(_, MirTypes.FTEST _) = ([], true)
	    | analyse_instr(_, MirTypes.ALLOCATE _) = ([], true)
	    | analyse_instr(a as (list, x),
			    MirTypes.ALLOCATE_STACK(MirTypes.ALLOC, r, size, offset)) =
	      if x then a else
		let
		  val offset = case offset of
		    SOME x => x
		  | _ => Crash.impossible"offset missing from stack allocation"
		in
		  ((r, stack_extra - offset - size) :: list, false)
		end

	    | analyse_instr(a as (list, x), MirTypes.STOREOP(store, _, r2, g)) =
	      if x orelse not(ok_store store) then a else
		(case g of
		   MirTypes.GP_IMM_SYMB symb =>
		     (case symb of
			MirTypes.GC_SPILL_SLOT _ =>
			  let
			    val offset = symb_value stack_layout symb
			    val i = gc_spill_size + (offset + gc_spill_offset) div 4
			    (* Offset in words from top of the relevant region *)
			    val _ = MLWorks.Internal.Array.update(spill_array, gc_spill_size -1 - i, false)
			  in
			    a
			  end
		      | _ => a)
		 | MirTypes.GP_IMM_ANY i =>
		     (let
		       val start = Lists.assoc(r2, list)
		       val offset = (i + 1) div 4
		       val _ = MLWorks.Internal.Array.update(stack_array, offset+start, false)
		      in
			a
		      end
			handle Lists.Assoc => a)
		 | _ => a)
	    | analyse_instr(x, _) = x

	  fun analyse_block block_tag =
	    let
	      val instrs = MirTypes.Map.tryApply'(block_tree, block_tag)
	    in
	      case instrs of
		SOME instrs =>
		  Lists.reducel analyse_instr (([], false), instrs)
	      | _ => ([], false)
	    end

	  val _ = analyse_block proc_tag

	  fun needs_init(a, b) = a orelse b

	  val spills_need_init =
	    MLWorks.Internal.ExtendedArray.reducel needs_init (false, spill_array)

	  val stack_need_init =
	    MLWorks.Internal.ExtendedArray.reducel needs_init (false, stack_array)

	  val code =
	    move_first([], do_blocks(needs_preserve,
				     block_list,
				     stack_layout,
				     spills_need_init,
				     stack_need_init,
				     fps_to_preserve))

	  val code_len =
	    Lists.reducel op +
	    (0, map (fn (_, opcodes) => length opcodes) code)

          val padded_name =
            let
              fun generate_nulls 0 = ""
                | generate_nulls n = String.str (chr(0)) ^ generate_nulls (n-1)
              fun normalise_to_four_bytes (x) =
                x ^ generate_nulls((4 - ((size x) mod 4)) mod 4)
            in
              normalise_to_four_bytes(procedure_name ^ String.str(chr(0)))
            end

	in
	  {code=(proc_tag, code),
	   non_gc_area_size=non_gc_stack_size,
           name=procedure_name,
           padded_name=padded_name,
	   leaf=not needs_preserve,
	   parms=0}
	end

      fun remove_redundant_loads(acc, []) = rev acc
	| remove_redundant_loads(acc, arg as [x]) = rev(x :: acc)
	| remove_redundant_loads(acc, (ins1 as (Sparc_Assembly.LOAD_AND_STORE
						(Sparc_Assembly.ST, rd1, rs11, rs12),
						tag1, comment1)) ::
				 (ins2 as (Sparc_Assembly.LOAD_AND_STORE
					   (Sparc_Assembly.LD, rd2, rs21, rs22),
					   tag2, comment2)) :: rest) =
	  if rs11 = rs21 andalso rs12 = rs22 andalso rd1 = rd2 then
	    (diagnostic_output 3
	     (fn _ => ["Removing redundant load after store\n"]);
	     remove_redundant_loads(acc, ins1 :: rest))
	  else
	    remove_redundant_loads(ins2 :: ins1 :: acc, rest)
	| remove_redundant_loads(acc, x :: rest) = remove_redundant_loads(x :: acc, rest)

      val remove_redundant_loads = fn x => remove_redundant_loads([], x)

      fun remove_redundant_loads_from_block(tag, opcode_list) =
	(tag, remove_redundant_loads opcode_list)

      fun remove_redundant_loads_from_proc(tag, block_list) =
	(tag, map remove_redundant_loads_from_block block_list)

      fun list_proc_cg proc_list =
	let
	  fun print_unscheduled_code((tag, block_list),name) =
	    let
	      fun print_block(tag, opcode_list) =
		let
		  fun print_opcode(opcode, tag_opt, comment) =
		    Print.print(
			  Sparc_Assembly.print opcode ^
			  (case tag_opt of
			    SOME tag =>
			       " tag " ^ MirTypes.print_tag tag
			  | NONE => " no tag") ^
			     " ; " ^ comment ^ "\n")
		in
		  (Print.print("Block tag " ^ MirTypes.print_tag tag ^ "\n");
		   map print_opcode opcode_list)
		end
	    in
	      (Print.print("Procedure entry tag " ^ MirTypes.print_tag tag ^
                           " " ^ name ^
			   "\n");
	       map print_block block_list)
	    end

	  val temp_code_list =
	    Timer.xtime
	    ("main proc_cg stage", !do_timings,
	     fn () => map proc_cg proc_list)

	  val code_list =
            map (fn tuple=>remove_redundant_loads_from_proc (#code(tuple))) temp_code_list
          val procedure_name_list = map #name temp_code_list
	  val leaf_list = map #leaf temp_code_list
	  val stack_parameters = map #parms temp_code_list

	  val code_list' = code_list

	  val _ = diagnostic_output 3
	    (fn _ => ["Unscheduled code\n"])

	  val _ = diagnostic_output 3
	    (fn _ => (ignore(map print_unscheduled_code
                      (Lists.zip(code_list',procedure_name_list)));
		      []))

          fun is_static s =
            let
              fun is_prefix n =
                let
                  val l = size n
                in
                  size s > l andalso MLWorks.String.substring (s,0,l) = n
                end
            in
              is_prefix "<Setup>" orelse is_prefix "Functor "
            end

(*
          val is_static = fn s => (if is_static s then print (s ^ "is static\n") else print (s ^ " isn't static\n");
                                     is_static s)
*)
	  fun do_reschedule code_list =
	    let
	      val code_list' =
		Timer.xtime
		("rescheduling blocks", !do_timings,
		 fn () =>
		 map
		 (fn ((proc_tag, proc),name) =>
                  let
                    val static = is_static name
                  in
                    (proc_tag, map
                     (fn (tag, x) => (tag, Sparc_Schedule.reschedule_block (static,x)))
                     proc)
                  end)
		 (Lists.zip (code_list,procedure_name_list)))

	      val _ = diagnostic_output 3 (fn _ => ["Rescheduled at block level, now doing proc level\n"])
	      val _ = diagnostic_output 3 (fn _ => ["Result so far\n"])
	      val _ = diagnostic_output 3 (fn _ => (ignore(map print_unscheduled_code
                                                    (Lists.zip(code_list',procedure_name_list)));
						    []))

	      val code_list'' =
		Timer.xtime
		("rescheduling procs", !do_timings,
		 fn () => map Sparc_Schedule.reschedule_proc code_list')
	    in
	      code_list''
	    end

	  fun print_scheduled_code (code_list) =
	    let
	      fun print_proc((proc_tag, proc),name) =
		let
		  fun print_block(tag, opcode_list) =
		    let
		      fun print_opcode(opcode, tag_opt, comment) =
			Print.print(
			      Sparc_Assembly.print opcode ^
			      (case tag_opt of
				 SOME tag =>
				   " tag " ^ MirTypes.print_tag tag
			       | NONE => " no tag") ^
				 " ; " ^ comment ^ "\n")
		    in
		      (Print.print("Block tag " ^ MirTypes.print_tag tag ^ " " ^ name ^ "\n");
		       map print_opcode opcode_list)
		    end
		in
		  (Print.print("Procedure tag " ^ MirTypes.print_tag proc_tag ^ "\n");
		   map print_block proc)
		end
	    in
	      map print_proc code_list
	    end

	  val _ = diagnostic_output 3 (fn _ => (["Rescheduling code\n"]))

	  val new_code_list' =
	    Timer.xtime
	    ("rescheduling", !do_timings,
	     fn () => do_reschedule code_list')

	  val _ = diagnostic_output 3 (fn _ => ["Rescheduled code\n"])
	  val _ = diagnostic_output 3 (fn _ => (ignore(print_scheduled_code (Lists.zip(new_code_list',procedure_name_list)));
						 []))
	  val _ = diagnostic_output 3 (fn _ => ["Linearising\n"])

	  val linear_code' =
	    Timer.xtime
	    ("linearising", !do_timings,
	     fn () => linearise_list new_code_list')

	  val nop_offsets = map find_nop_offsets linear_code'
	  val _ = diagnostic_output 3 (fn _ => ["Linearised\n"])

	  val nop_instruction =
	    Sparc_Opcodes.output_opcode
	    (Sparc_Assembly.assemble (Sparc_Assembly.nop_code))
		
	  fun make_tagged_code linear_code =
            (map
	     (fn ((tag, code),{non_gc_area_size, padded_name, ...}) =>
		{a_clos=Lists.assoc(tag, loc_refs),
		 b_spills=non_gc_area_size,
		 c_saves=0,
		 d_code=
		 let
                   fun do_annotation (debug,count) =
                     let
                       val unpadded_name =
                         let
                           val s = size padded_name
                           fun check_index to =
                             if MLWorks.String.ordof(padded_name,to) = 0
                               then check_index(to-1)
                             else MLWorks.String.substring(padded_name,0,to+1)
                         in
                           check_index (s-1)
                           handle MLWorks.String.Substring => ""
                                | MLWorks.String.Ord => ""
                         end
                     in
                       debug_map := Debugger_Types.add_annotation (unpadded_name,
                                                                   count,
                                                                   debug,
                                                                   !debug_map)
                     end

                   fun annotation_points ([],_,res) = rev res
                     | annotation_points ((inst,_)::t,count,res) =
                       (case inst of
                          Sparc_Assembly.JUMP_AND_LINK (_,_,_,_,debug) => do_annotation (debug,count)
                        | Sparc_Assembly.Call (_,_,debug) => do_annotation (debug,count)
                        | _ => ();
                        annotation_points(t,count+4,
                                          Sparc_Opcodes.output_opcode(Sparc_Assembly.assemble inst)::res))
                   val code =
                     if generate_debug_info then
                       concat (annotation_points (code,0,[]))
                     else
                       concat
                       (map
                        (fn (x, _) =>
                         Sparc_Opcodes.output_opcode(Sparc_Assembly.assemble x))
                        code)

                   val padded_code =
                     if size code mod 8 = 4
                       then code ^ nop_instruction
                     else code
		 in
                   padded_code
		 end})
	       (Lists.zip(linear_code,temp_code_list)))
	      handle Lists.Assoc => Crash.impossible"Assoc tagged_code"
	    handle Lists.Assoc => Crash.impossible"Assoc tagged_code"

	  val tagged_code' = make_tagged_code linear_code'
	(* Here we have leaf_list corresponding to procedure_name_list *)
	in
	  (Code_Module.WORDSET(Code_Module.WORD_SET
			       {a_names=procedure_name_list,
				b=tagged_code',
				c_leafs=leaf_list,
				d_intercept=nop_offsets,
				e_stack_parameters=stack_parameters}),
	   Lists.zip(linear_code', procedure_name_list))
	end

      val (proc_elements, code_list) = Lists.unzip(map list_proc_cg proc_list_list)

      val _ =
        if ! print_code_size  then
	  print("Normalised code size is " ^
		Int.toString
		(Lists.reducel
		 (fn(x,Code_Module.WORDSET(Code_Module.WORD_SET{b=tagged_code', ...})) =>
		  (Lists.reducel (fn (x,{d_code=y, ...}) => (size y) + x) (x,tagged_code'))
	       | _ => Crash.impossible "what the ?")
		 (0,proc_elements)) ^ "\n")
        else ()

      fun make_external_refs(con, list) =
	map (fn (x, y) => con(y, x)) list

      val ext_elements = make_external_refs(Code_Module.EXTERNAL, ext_refs)
      val ext_vars = make_external_refs(Code_Module.VAR, vars)
      val ext_exns = make_external_refs(Code_Module.EXN, exns)
      val ext_strs = make_external_refs(Code_Module.STRUCT, strs)
      val ext_funs = make_external_refs(Code_Module.FUNCT, funs)

      val module =
	Code_Module.MODULE(value_elements @
			 proc_elements @
			 ext_elements @
			 ext_vars @
			 ext_exns @
			 ext_strs @
			 ext_funs)
    in
     ((module, !debug_map), code_list)
    end
end
