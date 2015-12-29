(* _mir_cg.sml the functor *)
(*
$Log: _mir_cg.sml,v $
Revision 1.311  1998/09/18 15:27:48  jont
[Bug #20119]
Stop fmake_if and imake_if from creating empty blocks

 * Revision 1.310  1998/03/16  15:20:22  jont
 * [Bug #30357]
 * Make sure tail position is passed through into letrec bodies
 *
 * Revision 1.309  1997/09/18  15:41:13  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.308  1997/08/14  17:10:41  jont
 * [Bug #30243]
 * Fix problems with constant shifts by word32 values
 *
 * Revision 1.307  1997/08/07  11:14:18  jont
 * [Bug #30243]
 * Ensure no overlong shifts produced by 32 bit shift operations
 *
 * Revision 1.306  1997/08/01  10:08:18  jont
 * [Bug #30215]
 * Remove BIC in favour of INTTAG
 *
 * Revision 1.305  1997/07/03  15:20:20  jkbrook
 * [Bug #30186]
 * Use optimising/debugging compiler options consistently with the
 * lambda optimiser
 *
 * Revision 1.304  1997/04/11  17:17:34  jont
 * [Bug #2408]
 * Sort out problems with missing tags left out by optimisations
 * performed by the match compiler
 *
 * Revision 1.303  1997/01/21  12:13:25  matthew
 * Pass options to library functions
 *
 * Revision 1.302  1997/01/16  13:12:19  matthew
 * Have tag list in tagged operations
 *
 * Revision 1.301  1997/01/10  17:03:55  andreww
 * [Bug #1818]
 * implementing floatarrays
 *
 * Revision 1.300  1997/01/03  14:44:24  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.299  1996/11/06  11:08:05  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.298  1996/10/30  21:12:15  io
 * moving String from toplevel
 *
 * Revision 1.297  1996/09/26  14:00:33  matthew
 * Bytearray update is always integral
 *
 * Revision 1.296  1996/09/23  12:09:56  matthew
 * Always add end_blocks to result in make_cgt
 *
 * Revision 1.295  1996/08/06  12:28:12  andreww
 * [Bug #1521]
 * propagating changes made to lambda/_auglambda.sml (and ultimately
 * to typechecker/_types.sml).
 *
 * Revision 1.294  1996/05/21  15:37:47  matthew
 * Changed type of word32 shift operarators
 *
 * Revision 1.293  1996/05/14  10:17:42  matthew
 * Adding NOT32 MIR instruction
 *
 * Revision 1.292  1996/04/30  16:54:38  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.290  1996/04/29  14:46:40  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.289  1996/04/19  10:52:33  matthew
 * Removed some exceptions
 *
 * Revision 1.288  1996/03/28  10:50:32  matthew
 * Adding where type clause
 *
 * Revision 1.287  1996/03/20  12:46:53  matthew
 * Change for value polymorphism
 *
 * Revision 1.286  1996/02/02  11:09:52  jont
 * Recode integer 32 bit overflow detecting operations in terms of ADDW
 *
Revision 1.285  1996/01/31  17:36:25  jont
Fix problems with abs of positive int32

Revision 1.284  1996/01/31  17:16:02  jont
Fix code generation of unary negate for int32

Revision 1.283  1996/01/30  10:42:22  jont
Add warning comments to polymorphic equality about mips implementation

Revision 1.282  1995/12/27  13:02:37  jont
Removing Option in favour of MLWorks.Option

Revision 1.281  1995/12/22  17:39:41  jont
Remove references to option structure
in favour of MLWorks.Option

Revision 1.280  1995/12/20  13:17:06  jont
Add extra field to procedure_parameters to contain old (pre register allocation)
spill sizes. This is for the i386, where spill assignment is done in the backend

Revision 1.279  1995/12/04  12:35:41  matthew
Simplifying lambdatypes

Revision 1.278  1995/11/06  13:52:25  jont
Disallow handler optimisation when debug_variables is set

Revision 1.277  1995/11/01  10:16:39  jont
Modify NONE in handler case to allow compilation under NJ

Revision 1.276  1995/10/30  16:33:28  jont
Adding code to optimise compilation of handlers

Revision 1.275  1995/09/25  09:41:44  jont
Fix problems with spill counting during switch arms

Revision 1.274  1995/09/12  18:03:17  daveb
Added types for different lengths of words, ints and reals.

Revision 1.273  1995/09/01  15:17:51  jont
Improved array and vector bounds checking

Revision 1.272  1995/07/28  15:35:31  jont
Handle INTMOD and INTDIV

Revision 1.271  1995/07/26  11:16:09  jont
Fix problem of wrong integer reported too big

Revision 1.270  1995/07/25  15:30:56  jont
Translate WORD SCons

Revision 1.269  1995/07/20  15:50:23  jont
Add pervasive word operations

Revision 1.268  1995/07/19  12:39:29  jont
Deal with code generation of special constant chars

Revision 1.267  1995/07/14  09:48:55  jont
Add new operations on chars

Revision 1.266  1995/07/07  14:33:48  jont
Avoid use of global as an internediate in variable shifts
This makes code generation on the MIPS impossible

Revision 1.265  1995/06/19  11:05:46  jont
Modify handlers to put handler restoration in common sequence

Revision 1.264  1995/05/30  11:53:23  matthew
Removing timer structure

Revision 1.263  1995/05/18  12:27:57  matthew
Improving simple comparison code

Revision 1.262  1995/05/02  11:29:28  matthew
Adding CAST and UMAP primitives

Revision 1.261  1995/03/01  15:45:38  matthew
Adding GET_IMPLICIT pervasive

Revision 1.260  1995/02/07  17:25:53  matthew
Removing use of Types structure

Revision 1.259  1995/01/30  12:07:59  matthew
Renaming debugger_env to runtime_env
Other rationalizations of debugger stuff

Revision 1.258  1995/01/16  14:58:36  jont
Fix range testing in MLWorks.String.ordof

Revision 1.257  1994/11/23  13:15:00  matthew
Added code generation for various "unsafe" pervasives/
Added ALLOC_VECTOR

Revision 1.256  1994/11/16  17:14:04  jont
Do store immediate formation after copy propagation

Revision 1.255  1994/11/16  11:57:12  jont
Add immediate store operations

Revision 1.254  1994/11/10  15:40:37  matthew
Replaced use of BIC with shifts in array lengths.
BIC is hard to translate for the MIPS.
It is still used in one place.

Revision 1.253  1994/11/02  12:29:42  matthew
Fixing problem with intercept code and multiple arguments

Revision 1.252  1994/10/26  18:04:27  jont
Make continuation offsets for handlers guaranteed tagged integers

Revision 1.251  1994/10/24  13:54:56  matthew
Make lookup_in_closure return an Option value
Some reformatting and tidying up
This is ongoing work really

Revision 1.250  1994/10/17  16:11:15  jont
Also array update

Revision 1.249  1994/10/11  12:02:54  matthew
Tidying up

Revision 1.248  1994/09/30  12:58:21  jont
Remove handler register concept

Revision 1.247  1994/09/23  11:31:30  matthew
Abstraction of debug information

Revision 1.246  1994/09/16  16:36:23  jont
Removed explicit use of callee_arg in allocation of
 final result for compilation unit

Revision 1.245  1994/09/14  16:11:48  jont
Reduce handler frame size to four words
by leaving out fp

Revision 1.244  1994/09/09  17:24:37  jont
Machine specific functions is_fun and implicit_references moved to machperv

Revision 1.243  1994/08/25  13:32:20  matthew
More work on multiple arguments

Revision 1.242  1994/08/16  09:14:48  jont
Change count decrement in array and bytearray creation to
be by GP_IMM_INT ~1, as the count is always an ml integer.

Revision 1.241  1994/08/02  15:45:39  matthew
Fix for blunder

Revision 1.240  1994/07/25  14:06:39  matthew
Fixed a bug with is_integral

Revision 1.239  1994/07/25  11:37:32  matthew
Added support for multiple arguments in lambda and mir representations.
This isn't complete yet, but the old one argument case should be as it was.
Tidied up and rearranged the code a lot.  Not too many functional changes
except for the above.

Revision 1.238  1994/06/22  14:44:39  jont
Update debugger information production

Revision 1.237  1994/06/09  15:58:58  nickh
New runtime directory structure.

Revision 1.236  1994/06/07  09:44:33  jont
Added code to remove unreferenced blocks

Revision 1.235  1994/05/12  12:40:46  richard
Passing out the loop entry tag for _mirvariable.

Revision 1.234  1994/03/10  14:48:45  jont
Change handler to use LEO instead of LEA

Revision 1.233  1994/03/04  12:32:55  jont
Changes for automatic_callee mechanism removal
and moving machspec from machine to main

Revision 1.232  1994/02/21  18:24:40  nosa
Improved Control Transfer determining in HANDLEs.

Revision 1.231  1994/02/04  15:16:22  matthew
Always insert interrupt if flag is set.

Revision 1.230  1994/01/19  10:52:29  matthew
Added ConvertInt exception to MirUtils

Revision 1.230  1994/01/19  10:52:29  matthew
convert_int raises ConvertInt exception

Revision 1.229  1994/01/17  18:27:19  daveb
Removed unnecessary exceptions from closures.

Revision 1.228  1993/11/17  18:26:47  jont
Added extra indirection required to get fp values from the closure
for pattern matching

Revision 1.227  1993/11/04  16:55:38  jont
Added code generation of INTERRUPT instruction

Revision 1.226  1993/10/05  13:42:31  daveb
Merged in bug fix.

Revision 1.225  1993/09/28  15:11:02  daveb
Merged in bug fix.

Revision 1.224  1993/09/23  11:26:03  nosa
Polymorphic debugger.

Revision 1.223.1.3  1993/10/05  13:11:17  daveb
The initial value to a bytearray must be untagged before being assigned to
the bytearray.  The register must be cleaned immediately after, to avoid
GC problems.

Revision 1.223.1.2  1993/09/28  14:53:12  daveb
Handled BigNum.Unrepresentable where necessary.

Revision 1.223.1.1  1993/08/23  14:42:17  jont
Fork for bug fixing

Revision 1.223  1993/08/23  14:42:17  richard
Added missing intercept instruction after function entry in the simple
case.

Revision 1.222  1993/08/18  16:50:04  jont
Moved a few more functions into mir_utils

Revision 1.221  1993/08/17  17:21:36  jont
Fixed problem of require statements getting inside handlers etc
due to lambda optimisation.

Revision 1.220  1993/07/30  14:47:06  nosa
Local and Closure variable inspection in the debugger;
new compiler option debug_variables;
values of these variables are spilled unto the stack;
call recording to determine control transfer.

Revision 1.219  1993/07/20  16:52:38  jont
Better version of do_shift

Revision 1.218  1993/07/20  12:57:37  jont
Added support for unsafeintplus, and redid some of the bitwise operations
Dealt with the case of overlarge integers in special constants, both in
matches and atomic values using shifts and adds at runtime

Revision 1.217  1993/07/12  16:48:34  daveb
Made primitive operations refer to exception values instead of exception
names - we have to build them explicitly as a result of the recent changes
to exception environments.

Revision 1.216  1993/07/07  17:29:02  daveb
Removed Primitives structure.
Removed exception environments, and therefore references to EX*VAL.

Revision 1.215  1993/05/28  17:31:34  jont
Fixed a couple of problems which show up when compiling unoptimised lambda
code as required for the debugger. These caused references to undefined registers
and blocks without unconditional control transfers at the end.

Revision 1.214  1993/05/18  16:31:04  daveb
The debug_warning compatability option is no more (it has ceased to be).
Replaced Integer.makestring with MLWorks.Integer.makestring and removed
the Integer structure.

Revision 1.213  1993/05/11  15:35:21  richard
Added a move instruction to put the argument register back in the
right place after a return from an INTERCEPT.

Revision 1.212  1993/04/30  15:47:55  matthew
Changed name of setup function again.

Revision 1.211  1993/04/28  15:18:04  richard
Unified profiling and tracing options into `intercept'.
The argument is always in the argument register before an
INTERCEPT instruction.
Changed PROFILE instruction to INTERCEPT.

Revision 1.210  1993/04/26  16:16:21  matthew
Changed format of debug_info strings.

Revision 1.209  1993/04/15  15:48:40  jont
Removed handler chain restore code, now generated in _mach_cg from OLD_HANDLER

Revision 1.208  1993/03/25  15:29:53  jont
Ensured that the results of unsafe sub for byte array are tagged as integer

Revision 1.207  1993/03/23  15:49:26  jont
Added vector primitives and changed bytearray implementation to use ref tags

Revision 1.206  1993/03/19  16:21:44  jont
Fixed problems in ByteArray.{length,sub,update} to do with loading from
the wrong offset to get the header length, and also not tagging the result
from sub.

Revision 1.205  1993/03/17  14:05:27  jont
Modified Array.sub and Array.update to use MirRegisters.global when bounds
checking to avoid leaving dirty values in the registers

Revision 1.204  1993/03/10  18:14:12  matthew
Signature revisions

Revision 1.203  1993/03/09  17:26:05  jont
Added code for dealing with builtin string relationals

Revision 1.202  1993/03/04  15:16:07  matthew
Options & Info changes

Revision 1.201  1993/03/04  11:59:10  jont
Removed LVar_eq in favour of polymorphic equality

Revision 1.200  1993/03/02  16:53:43  matthew
Rationalised use of Mapping structure
Change of Jon's for polyeq

Revision 1.199  1993/03/01  15:09:41  matthew
Added MLVALUE lambda exp
This is handled just like a string SCON

Revision 1.198  1993/02/26  15:08:53  jont
Modified to use new variable size hashsets

Revision 1.197  1993/02/23  19:37:28  daveb
Added check that argument to ordof is non-negative.
Also removed some commented-out code.

Revision 1.196  1992/12/17  17:06:37  matthew
Changed int and real scons to carry a location around

Revision 1.195  1992/12/14  12:01:24  clive
Raised Info.errors for overflow of constants during code generation

Revision 1.194  1992/12/08  19:38:52  jont
Removed a number of duplicated signatures and structures

Revision 1.193  1992/12/02  15:59:46  daveb
Changes to propagate compiler options as parameters instead of references.

Revision 1.192  1992/12/01  20:18:26  jont
Modified to use new improved hashset signature

Revision 1.191  1992/11/30  10:34:48  jont
Removed a large number of unnecessary map operations

Revision 1.190  1992/11/25  14:40:25  daveb
Fixed misleading typo in generated Mir comment.
Also deleted redefinition of append.

Revision 1.189  1992/11/19  16:24:58  daveb
Commented out the code dealing with switches on integers, as the lambda
optimiser should deal with these.  Also stopped do_chained_tests from
generating unnecessary code in the case of an exhaustive switch without
a default (althought the lambda optimiser should catch this case too).

Revision 1.188  1992/11/10  13:54:13  matthew
Changed Error structure to Info

Revision 1.187  1992/11/04  15:55:31  jont
Removed curry_reduce. Changed top_tags map to use intnewmap

Revision 1.186  1992/11/03  12:03:45  daveb
Switches now have both value-carrying and immediate constructors in the
same switch.  Much fancy code to optimise special cases.

Revision 1.185  1992/10/30  13:47:03  jont
Changed to use LambdaTypes.Map and MirTypes.Map

Revision 1.184  1992/10/28  11:37:26  jont
Removed dependence on environ in favour of environtypes

Revision 1.183  1992/10/02  16:53:52  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.182  1992/09/24  15:35:17  jont
Removed the curry module, it wasn't doing anything

Revision 1.181  1992/09/09  10:02:52  clive
Added flag to switch off warning messages in generating recipes

Revision 1.180  1992/09/01  14:36:28  clive
Added switches for self call optimisation

Revision 1.179  1992/08/26  14:53:59  jont
Removed some redundant structures and sharing

Revision 1.178  1992/08/25  20:20:46  jont
Corrected bug in known escaping functions

Revision 1.177  1992/08/24  16:13:18  richard
Added unsafe update and bytearray primitives.

Revision 1.176  1992/08/24  13:43:46  jont
Ensured not all primitives are regarded as escaping

Revision 1.175  1992/08/20  12:59:29  davidt
Mir_Env now uses NewMap instead of Map.

Revision 1.174  1992/08/20  11:06:31  richard
Added code to do UNSAFE_UPDATE and UNSAFE_SUB.

Revision 1.173  1992/08/18  14:37:06  jont
Fixed an inexhaustive match

Revision 1.172  1992/08/17  16:41:08  jont
Added inline ordof

Revision 1.171  1992/08/07  16:52:08  davidt
String structure is now pervasive.

Revision 1.170  1992/08/07  11:40:16  clive
Added a flag to turn off tail-call optimisation

Revision 1.169  1992/08/06  16:11:43  jont
Fixed a sharing constraint problem

Revision 1.169  1992/08/06  16:11:43  jont
Fixed sharing constraint

Revision 1.168  1992/08/05  18:14:46  jont
Removed some structures and sharing

Revision 1.167  1992/08/05  15:01:03  jont
Improved polymorphic equality by anding the tags before testing

Revision 1.166  1992/08/04  18:22:02  jont
Removed various uses of NewMap.to_list in favour of fold and union

Revision 1.165  1992/08/04  16:25:07  davidt
Removed various redundant structure arguments. Added UPDATE and BECOMES optimisation.
Fixed bug causing bad code to be compiled in the interpreter.

Revision 1.164  1992/07/29  17:25:01  jont
Fixed bug in ftest usage

Revision 1.163  1992/07/27  09:44:45  richard
Changed calls to C to pass a single argument.

Revision 1.162  1992/07/23  15:55:53  clive
Used BIC to clear the bottom two bits when calculating array length

Revision 1.161  1992/07/20  11:49:26  clive
Added jont's curry_reduce

Revision 1.160  1992/07/14  10:15:34  clive
Setup procedure name needs to be passed to count_gc_objects

Revision 1.159  1992/07/08  16:37:23  clive
Jont fix to get more tail calling

Revision 1.158  1992/07/07  10:27:25  clive
Added call point information

Revision 1.157  1992/07/06  09:55:44  davida
Added LET constructor and new slot to APP.
Added diagnostic level control on curry message.

Revision 1.156  1992/06/29  15:20:59  jont
Turned off automatic printing of various timings

Revision 1.155  1992/06/29  09:46:28  clive
Added type annotation information at application points

Revision 1.154  1992/06/25  10:55:41  jont
Changed ml_call to return the result instead of the code!

Revision 1.153  1992/06/19  15:52:26  jont
Added ML_REQUIRE builtin for interpreter to get builtin library

Revision 1.152  1992/06/19  09:41:34  richard
Added parameter to RAISE once again, and some stuff that jont asked
me to put in.

Revision 1.151  1992/06/17  15:08:32  jont
Added code to deal with externals from interpretive environment

Revision 1.150  1992/06/16  20:18:10  jont
Added code to handle externals defined by the interpreter

Revision 1.150  1992/06/16  19:54:20  jont
Added code to handle externals involved with interpretation

Revision 1.149  1992/06/15  16:24:06  jont
Coded load_var etc as unimplemented at present

Revision 1.148  1992/06/12  13:03:23  clive
Changed flag so that debug information generation is off by default

Revision 1.147  1992/06/11  11:05:35  clive
Changes for the recording of FNexp type information

Revision 1.146  1992/06/10  14:42:06  jont
Some minor sharing changes

Revision 1.145  1992/06/08  16:25:21  jont
Modified to use newmap

Revision 1.144  1992/05/22  16:00:47  jont
Added some comments in the poly eq case

Revision 1.143  1992/05/21  09:14:14  clive
Added arithmetic right shift

Revision 1.142  1992/05/14  11:10:26  clive
Added the Bits structure

Revision 1.141  1992/05/13  09:54:27  jont
Changed to use lambda code augmented by number of static gc objects within
at each stage, rather than calculating every time. This produced a big win
on pathological cases like long manifest lists. Also changed the
bounds_and_frees implementation for one which calculates those lambdas
which could be free which are actually required, thus avoiding producing
huge bound variable sets which are of little use.

Revision 1.140  1992/05/08  12:51:16  clive
Added profiling to the setup procedure

Revision 1.139  1992/05/06  15:54:10  jont
Rewritten to use augmented lambda calculus to avoid recalculating
number of static garbage collectable objects within lambda expressions
Also fixed superfluous ALLOCs during integer relational operations

Revision 1.138  1992/04/28  15:56:17  clive
Arrays no longer have their size stored as one of the elements

Revision 1.137  1992/04/24  16:20:36  jont
Added code to reduce number of registers used per block

Revision 1.136  1992/04/14  15:48:13  clive
First version of the profiler

Revision 1.135  1992/04/08  15:56:11  jont
Split out utility functions into separate file. Recoded do_app for
better reliability

Revision 1.134  1992/04/02  23:01:37  jont
Fixed precedence problem in source between @ and ::

Revision 1.133  1992/04/02  14:50:21  jont
Fixed a problem with self tail recursive functions with
escaping arguments

Revision 1.132  1992/03/31  15:52:14  jont
Removed references to pervasive hd and length

Revision 1.131  1992/03/30  17:24:45  jont
Fixed problem with if code short circuiting for more complicated tests.
Removed bug in code generation of LETREC final expression, whereby
func_in_closure was set to the number of funs generated in the LETREC,
rather than funs_in_closure of the enclosing function.

Revision 1.130  1992/03/26  16:28:44  jont
Fixed a problem with finding the function pointers when the enclosing
function is one of a set (more than one element) of mutually recursive
functions. All down the the damn zeroes. Fixed the same problem
potentially in two other places as well.

Revision 1.129  1992/03/20  18:47:23  jont
Fixed problems whereby static gc objects weren't being correctly picked
up from the surrounding closure when that closure was for more than one
function.

Revision 1.128  1992/03/19  16:41:38  jont
Ensured the correct closure pointer is made available when tail calling
a function in the same recursive set but not the same one

Revision 1.127  1992/03/10  19:13:43  jont
Fixed problem of single argument tail-recursive functions with
escaping arguments where the argument wasn't set up properly
on the tail call

Revision 1.126  1992/03/10  15:33:32  clive
Switch staements for characters did not assume a tagged stack alloc

Revision 1.125  1992/03/09  17:17:07  clive
On code to take off the modified list, code here assumed backward and forward
were tagged

Revision 1.124  1992/03/04  21:35:40  jont
Fixed problem with argument register overwrite in recursive procedures
Fixed incorrect size generated for strings by CHR
Fixed incorrect offset used to find string size by size and ord
Added some inline equality testing before invoking full polymorphic
equality
Fixed problem whereby one argument tail recursive procedures were not
putting the argument in the right register

Revision 1.123  1992/03/03  14:03:38  richard
Added missing case for Pervasives.EQFUN and lowered the diagnostic level
of the message about polymorphic equality.

Revision 1.122  1992/03/02  16:44:52  richard
Made Pervasives.EQ an inline operation.  At the moment it just calls
Pervasives.EQFUN, but soon will do some tests in inline.

Revision 1.121  1992/02/27  16:03:39  richard
Changed the way virtual registers are handled.  See MirTypes.

Revision 1.120  1992/02/25  11:00:59  clive
In chr, stb was used but the word into which we store needs to be zeroed first,
otherwise the strings are not null terminated and so confuse C

Revision 1.119  1992/02/24  17:53:42  clive
Chr and Ord did not deal with tagging of integers

Revision 1.117  1992/02/24  12:59:33  clive
Bug in ARRAY_FN - fixed

Revision 1.116  1992/02/21  09:02:30  clive
In the previous change, the link fiedls were set as (0,1) instead
of (1,0) - (1,0) represents points to older object, (0,1) represents
"on the modified list"

Revision 1.115  1992/02/20  17:01:07  richard
Changed the code for allocation of REF cells and arrays so
that they are no longer placed on any modified list.  They _cannot_
point at younger data, after all!

Revision 1.114  1992/02/19  18:08:08  clive
Arrays of size zero were not allowed - I fixed this (we often need placeholders
- see the lexer for an example)

Revision 1.113  1992/02/19  12:08:37  clive
Didn't handle the (0,0) case in the modified ref chain

Revision 1.112  1992/02/18  08:56:08  clive
Making a letrec closure was fetching at twice the offset

Revision 1.111  1992/02/17  19:12:28  jont
Fixed cg_lvar so that when code generating lambdas representing functions
in the current recursive set, where we are not using this to call,
returns an offset from the current closure, rather than a pointer to
the code

Revision 1.110  1992/02/11  11:24:16  clive
Reworking of the pervasive library

Revision 1.109  1992/02/07  16:55:03  jont
Fixed bug in SELECT(LIST...) whereby offset rather than index was
used to index the list.

Revision 1.108  1992/02/06  20:28:44  jont
Added check to cg_lvar to ensure that variables code generated
really were defined

Revision 1.107  1992/02/05  16:19:30  richard
Abolished PREVIOUS_ENVIRONMENT and PRESERVE_ALL_REGS.

Revision 1.106  1992/02/04  11:06:14  clive
Arrays expected all arguments to be present - they didn't expect a single tuple argument
That is now fixed

Revision 1.105  1992/01/31  16:16:43  jont
Fixed up ordering of stack allocation and handler declaration,
and added handler removal to continuation point after handler called

Revision 1.104  1992/01/28  19:03:06  jont
Fixed problem whereby impossible values in make_cgt went to the
continuation point. They need to define the result first

Revision 1.103  1992/01/25  12:21:42  jont
Allowed handler to be a variable (may occur by CSE)

Revision 1.102  1992/01/24  17:02:32  clive
Modified some of the ref_chain code, and added a copy of the callee_argument
to a new virtual register to the enter section of a lambda

Revision 1.101  1992/01/24  10:48:26  clive
Added array linkage to the ref_chain (for the garbage collector)

Revision 1.100  1992/01/23  10:12:07  clive
Added EXSIZEVAL and EXSUBSCRIPTVAL

Revision 1.99  1992/01/22  15:24:26  clive
Fixed some errors in references

Revision 1.98  1992/01/21  18:20:16  clive
Arrays almost work now

Revision 1.97  1992/01/17  17:22:56  clive
More MIR for arrays

Revision 1.96  1992/01/16  17:24:08  clive
Added some inlineable code for arrays - not quite working yet

Revision 1.95  1992/01/14  15:26:31  jont
Changed raise and handle to new form using implicit vector

Revision 1.94  1992/01/13  10:08:28  richard
Prevented unnecessary ADD 0 instructions being generated when look at
closures.  Added a fix to LETREC generation.

Revision 1.93  1992/01/10  11:52:13  richard
Added a SUBSTRING pervasive as a temporary measure so that the same code
can be compiled under under both New Jersey and MLWorks.

Revision 1.92  1992/01/08  14:45:59  jont
Used curried function application optimisation

Revision 1.91  1992/01/07  15:30:33  richard
Removed the raw spill size field from function closures.

Revision 1.90  1992/01/07  12:21:26  jont
Fixed bug whereby APP(BUILTIN...) demanded empty tuple_binding list,
which isn't necessarily the case

Revision 1.89  1992/01/03  18:00:50  jont
Changed use of InterProc to fit new interface

Revision 1.88  1992/01/03  11:42:33  jont
Ensured result of CALL_C moved away from caller_arg to avoid overwriting

Revision 1.87  1991/12/23  15:28:45  richard
Changed the format of handler records so that the garbage collector can deal
with them.  They now contain a pointer to a procedure (a GC object) and an offet
rather than a pointer into arbitrary code.

Revision 1.86  91/12/20  13:59:19  richard
Added EXxxxVAL exception values to some matches to make them complete.
Corrected the offsets used to load and store the exception record.
Changed raise of built-in exceptions to use the values rather than
reconstructing the packets each time.

Revision 1.85  91/12/16  15:41:27  jont
Fixed bugs in ORD and SIZE

Revision 1.84  91/12/09  16:51:39  jont
Tidied up in tail recursion/continuation

Revision 1.83  91/12/06  16:10:11  jont
More work on tail continuations and recursions

Revision 1.82  91/12/05  19:08:37  jont
Tidied up tail recursion, fixed some bugs and did exit block appending
where relevant.

Revision 1.81  91/12/04  17:34:23  jont
Added tail calling for multi argument functions to self in the case where
the argument doesn't escape.

Revision 1.80  91/12/02  22:04:00  jont
Added tail recursion for two (of the six possible) cases. Added hooks
for two others, involving recursion to self rather than continuation

Revision 1.79  91/11/29  18:07:01  jont
Added tail detection. Ensured that stack allocated stuff is deallocated.
Added parameter for detecting tail thread of control

Revision 1.78  91/11/28  17:14:14  richard
Changed the calls to the Library module to reflect the changes there.

Revision 1.77  91/11/27  19:47:23  jont
Removed some spurious debugging messages

Revision 1.76  91/11/27  13:08:37  jont
Changed Match_Utils.Qsort for Lists.qsort

Revision 1.75  91/11/27  12:10:53  jont
Fixed bug whereby tupled up updates of refs failed.

Revision 1.74  91/11/21  19:54:17  jont
Added some brackets to keep njml 0.75 happy

Revision 1.73  91/11/20  14:52:56  jont
Changed to use exception generating versions of fp opcodes

Revision 1.72  91/11/18  14:43:16  richard
Fixed the in-line code for CALL_C.  Generated lambda expression will
pervasive references filled in before making the top level tags and
counting the garbage collectible objects.

Revision 1.71  91/11/14  17:06:00  jont
Replaced eta_abstract with reference to LambdaSub

Revision 1.70  91/11/14  15:43:05  richard
Added code generation for CALL_C pervasive.  This seems to produce
incorrect code at the moment.

Revision 1.69  91/11/14  12:39:39  jont
Fixed redundant match problem

Revision 1.68  91/11/13  19:05:04  jont
Fixed bug whereby an allocation could happen before the fields of
the previous one had been written. Occurred when tupling up a list
contain FP registers, eg in val x = sqrt 1.0

Revision 1.67  91/11/12  18:36:11  jont
Added case spotting code to handle if relation and avoid doubled tests

Revision 1.66  91/11/08  14:44:59  jont
Corrected writing of stack tuples to assume correctly tagged pointers

Revision 1.65  91/11/07  16:43:37  jont
Added stack allocation of arguments in the instance where the referenced
function does not allow its argument to escape

Revision 1.64  91/11/04  10:37:44  jont
Added use of InterProc for determining procedures which don't return
their arguments

Revision 1.63  91/10/30  17:34:16  jont
Modified mutually recursive closures to have holes in them to get
code pointer alignment correct

Revision 1.62  91/10/29  18:29:10  davidt
Fixed code determining whether a procedure is a leaf procedure or not.

Revision 1.61  91/10/29  17:39:46  jont
Modified instruction order on a raise to allow better scheduling

Revision 1.60  91/10/28  15:36:18  richard
Changed the form of the ALLOCATE and DEALLOCATE instructions yet again.

Revision 1.59  91/10/28  13:15:33  davidt
Changed type of destruct_2_tuple to avoid a lot of the inexhaustive
bindings that were around in this functor. Fixed a bug where an
absent tag was mistakenly flagged as an impossible condition.

Revision 1.58  91/10/28  11:54:34  davidt
The ALLOCATE opcode doesn't need a scratch register or a way of
referencing callc so the extra arguments required to pass this
information around have been completely removed.

Revision 1.57  91/10/25  17:09:07  jont
Allowed () as a final result for programs like
val _ = output(std_out, "Hello world") (which are obviously
very important!)

Revision 1.56  91/10/24  11:49:19  jont
Fixed bug whereby call_c was being generated from wrong closure during
function and letrec generation

Revision 1.55  91/10/24  11:04:52  jont
Added BTA and BNT for tagged value testing
Allowed multiple top level blocks for handlers

Revision 1.54  91/10/23  13:34:01  davidt
Took out some old printing functions which used NewJersey print.
Put in a Crash.impossible instead of raise ...

Revision 1.53  91/10/22  18:29:54  davidt
The structure LambdaSub.LambdaTypes is now called LambdaSub.LT

Revision 1.52  91/10/21  14:45:32  jont
Modified local and external reference production.

Revision 1.51  91/10/18  17:39:41  jont
Sorted out returned value from top level procedure
Fixed bug whereby values were being lost in combine

Revision 1.50  91/10/17  15:37:07  jont
Modified ALLOC stuff again, hopefully code generation possible this time

Revision 1.49  91/10/16  17:22:41  jont
Added determination of implicit call_c requirements

Revision 1.48  91/10/16  14:08:29  jont
Updated to reflect new simplified module structure
Still needs work on call_c stuff in allocate

Revision 1.47  91/10/15  15:43:03  jont
Fixed up pointer offsets. Still to add CALL_C stuff for GC

Revision 1.46  91/10/11  15:29:25  richard
Added use of DEALLOC_STACK where possible. Fixed problem with
use of callee_arg as temporary register.

Revision 1.45  91/10/11  10:45:22  richard
Slight alterations to cope with new MirTypes.

Revision 1.44  91/10/10  14:47:30  richard
Added ENTER and RTS to final block, making it into a bona fide
proceedure.

Revision 1.43  91/10/10  13:43:51  richard
Changed register use to implement register windows on machines that
have them. Removed RESTORE_REGS and PRESERVE_REGS and replaced with
parameters on the ENTER instruction. Changed raise from an ordinary
BSR to a parameterized RAISE instruction.

Revision 1.42  91/10/09  18:12:59  jont
Mended SELECT

Revision 1.41  91/10/09  16:40:54  davidt
Made changes to generate code for selections from pairs properly

Revision 1.40  91/10/09  14:45:03  richard
Modified to generate a different procedure entry routine for those
machines with register windows.

Revision 1.39  91/10/08  18:21:44  jont
Replaced raise Lambdatypes.impossible with Crash.impossible

Revision 1.38  91/10/08  15:58:02  richard
Changed handler code to use global register when traversing the stack.

Revision 1.37  91/10/08  11:52:55  jont
Replaced lambdasub.number_from by lists.number_from_by_one

Revision 1.36  91/10/04  13:05:12  jont
Changed to use new PROC type for bundling up procedures

Revision 1.35  91/10/03  21:23:09  jont
Sorted out values from procedures

Revision 1.34  91/10/02  11:40:21  jont
Removed real register options, these are being done elsewhere

Revision 1.33  91/09/25  11:20:33  richard
Reversed the order of the RAISE and BSR instructions when raising an
exception. This makes dead code elimination easier.

Revision 1.32  91/09/24  15:44:55  jont
Fixed bug whereby blocks were getting lost during HANDLE clauses
Fixed up all exception generating instructions automatically

Revision 1.31  91/09/23  12:31:35  jont
Added implicit exception handling (eg for ADDV)

Revision 1.30  91/09/20  15:53:57  jont
Added PRESERVE_ALL_REGS for benefit of RAISE/HANDLE
Started work on impicitly used exceptions (eg ADDV)

Revision 1.29  91/09/19  17:08:15  jont
Fixed bugs in LETREC and default cases in SWITCH.
Added code for SWITCH into empty list, as this can occur
Also added exception tag for MODV, newly created

Revision 1.28  91/09/18  15:51:40  jont
Fixed bug in HANDLE causing empty blocks, and removed
fn_arg etc to separate module for better external structure

Revision 1.27  91/09/17  17:04:42  jont
Added raise and handle

Revision 1.26  91/09/16  16:33:35  jont
Started on HANDLE

Revision 1.25  91/09/10  15:14:10  jont
Added use of NON_GC_SPILL_SIZE to closure production

Revision 1.24  91/09/09  13:54:45  jont
Added slot in closure for non-gc spill area size

Revision 1.23  91/09/05  18:19:03  jont
Added code generation of switches against exception values,
and augmenting of lambda -> register environment following code
generation of certain expressions

Revision 1.22  91/09/04  18:14:26  jont
Added ord, chr, size. Sorted out STRINGEQ calling.
Removed bug in subst_ext_prims.

Revision 1.21  91/09/03  18:19:22  jont
Added STRING match (almost)

Revision 1.20  91/09/03  14:24:58  jont
Added SWITCH on REAL and recursive function call to arbitrary member
of same recursive set.

Revision 1.19  91/09/02  16:35:26  jont
Removed translations from primitives to HARP

Revision 1.18  91/08/30  17:37:18  jont
Added floating point ops, and reorganised cg_result to allow for
fp results

Revision 1.17  91/08/29  16:10:14  jont
Added code for ref, !, :=

Revision 1.16  91/08/23  18:15:17  jont
Redid primitive application coding

Revision 1.15  91/08/23  15:00:11  jont
Changed to use pervasives

Revision 1.14  91/08/15  16:22:23  jont
Added optimisation for simple recursive functions to avoid reloading via
closure by use of BSR

Revision 1.13  91/08/15  14:00:11  jont
Modified in line with later version of HARP
Added pervasives module references, plus overflow exception detection

Revision 1.12  91/08/14  14:56:03  jont
Added external references. Fixed bug in SELECT

Revision 1.11  91/08/13  18:24:06  jont
Added code to start dealing with pervasives and external references

Revision 1.10  91/08/09  19:12:35  jont
Added stuff to generate pervasive environment prior to code generating
general builtins

Revision 1.9  91/08/07  11:31:21  jont
Added relational operations for integers

Revision 1.8  91/08/06  18:38:58  jont
Added SWITCH on ints using chained branches,
and LETRECs.

Revision 1.7  91/08/05  12:30:04  jont
Added some comments to the output Harp. Ensured that SCON_TAGs involving
strings and reals were treated as garbage collectable. Spotted leaf
(no call) procedures.

Revision 1.6  91/08/02  16:49:06  jont
Completed function definition. Added function call.

Revision 1.5  91/08/01  18:52:17  jont
Sorted out closures and the top level argument a bit more

Revision 1.4  91/07/31  19:39:19  jont
Started on FNs. Looking at global analysis of static gc objects

Revision 1.3  91/07/30  17:48:59  jont
Coded most of switch, apart from reals and strings, and sparse ints

Revision 1.2  91/07/26  20:17:27  jont
Updated to deal with simple APP of FN

Revision 1.1  91/07/25  18:11:54  jont
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "$.basis.__int";
require "$.basis.__string";

require "../utils/diagnostic";
require "../utils/_hashset";
require "../utils/lists";
require "../utils/crash";
require "../utils/intnewmap";
require "../utils/bignum";
require "../main/info";
require "../main/options";
require "../lambda/lambdaprint";
require "../lambda/simpleutils";
require "../match/type_utils";
require "../main/library";
require "../rts/gen/implicit";
require "../main/machspec";
require "../main/machperv";
require "mirregisters";
require "mirprint";
require "mir_utils";
require "mirtables";
require "mir_cg";

functor Mir_Cg(
  include sig
  structure Diagnostic : DIAGNOSTIC
  structure Lists : LISTS
  structure Crash : CRASH
  structure Info : INFO
  structure Options : OPTIONS
  structure IntMap : INTNEWMAP
  structure BigNum : BIGNUM
  structure BigNum32 : BIGNUM
  structure Library : LIBRARY
  structure LambdaPrint : LAMBDAPRINT
  structure SimpleUtils : SIMPLEUTILS
  structure MirPrint : MIRPRINT
  structure MirRegisters : MIRREGISTERS
  structure Mir_Utils : MIR_UTILS
  structure MirTables : MIRTABLES
  structure Implicit_Vector : IMPLICIT_VECTOR
  structure MachSpec : MACHSPEC
  structure MachPerv : MACHPERV
  structure TypeUtils : TYPE_UTILS

  sharing Library.AugLambda.Debugger_Types.Options = Options
  sharing TypeUtils.Datatypes.Ident.Location = Info.Location
  sharing LambdaPrint.LambdaTypes = Library.AugLambda.LambdaTypes =
    SimpleUtils.LambdaTypes = Mir_Utils.Mir_Env.LambdaTypes
  sharing MirRegisters.MirTypes = MirPrint.MirTypes = Mir_Utils.Mir_Env.MirTypes =
    MirTables.MirTypes
  sharing Library.AugLambda = Mir_Utils.AugLambda
  sharing Mir_Utils.Mir_Env.MirTypes.Debugger_Types =
	  Library.AugLambda.Debugger_Types
  sharing TypeUtils.Datatypes.NewMap = Library.NewMap = Mir_Utils.Map
  sharing LambdaPrint.LambdaTypes.Ident = TypeUtils.Datatypes.Ident

  sharing type Library.CompilerOptions = Options.compiler_options
  sharing type Mir_Utils.Mir_Env.Map = IntMap.T
  sharing type MirPrint.MirTypes.Debugger_Types.RuntimeEnv.VarInfo = LambdaPrint.LambdaTypes.VarInfo
  sharing type TypeUtils.Datatypes.Ident.SCon = MirPrint.MirTypes.SCon
  sharing type LambdaPrint.LambdaTypes.Type = TypeUtils.Datatypes.Type
  sharing type MachPerv.Pervasives.pervasive = LambdaPrint.LambdaTypes.Primitive
  sharing type MirPrint.MirTypes.Debugger_Types.RuntimeEnv.Type = LambdaPrint.LambdaTypes.Type =
    TypeUtils.Datatypes.Type
  sharing type MirPrint.MirTypes.Debugger_Types.RuntimeEnv.Tyfun = LambdaPrint.LambdaTypes.Tyfun
  sharing type MirPrint.MirTypes.Debugger_Types.RuntimeEnv.Instance = LambdaPrint.LambdaTypes.Instance =
    TypeUtils.Datatypes.Instance
  sharing type MirPrint.MirTypes.Debugger_Types.RuntimeEnv.FunInfo = LambdaPrint.LambdaTypes.FunInfo
  end where type LambdaPrint.LambdaTypes.LVar = int
): MIR_CG =
struct
  structure Pervasives = MachPerv.Pervasives
  structure LambdaTypes = LambdaPrint.LambdaTypes
  structure Set = LambdaTypes.Set
  structure Sexpr = Mir_Utils.Sexpr
  structure Mir_Env = Mir_Utils.Mir_Env
  structure AugLambda = Library.AugLambda
  structure MirTypes = MirPrint.MirTypes
  structure Datatypes = TypeUtils.Datatypes
  structure Ident = Datatypes.Ident
  structure Symbol = Ident.Symbol
  structure NewMap = Datatypes.NewMap
  structure Diagnostic = Diagnostic
  structure Debugger_Types = AugLambda.Debugger_Types
  structure HashSet = HashSet(
    structure Crash = Crash
    structure Lists = Lists
    type element = LambdaTypes.LVar
    val eq = op=
    val size = 200
    val hash = fn x => x
      )

  structure Info = Info
  structure Options = Options
  structure RuntimeEnv = Debugger_Types.RuntimeEnv

  val do_diagnostics = false
  val print_timings = false

  val N = Int.toString

  val real_offset = 3

  val hashset_size = 64

  (* A local definition for profiling purposes *)
  fun lists_reducel f =
    let
      fun red (acc, []) = acc
        | red (acc, x::xs) = red (f(acc,x), xs)
    in
      red
    end

  fun empty_hashset () = HashSet.empty_set hashset_size

  val caller_arg = MirRegisters.caller_arg
  (* The argument register for all functions *)

  val callee_arg = MirRegisters.callee_arg
  (* The local copy of the argument register *)

  val caller_closure = MirRegisters.caller_closure
  (* The closure pointer for all function calls *)

  val callee_closure = MirRegisters.callee_closure
  (* The local copy of the closure pointer *)

  val fp = MirRegisters.fp
  (* The frame pointer within all functions *)

  val sp = MirRegisters.sp
  (* The stack pointer within all functions *)

  val no_code = ((Sexpr.NIL, [], NONE, Sexpr.NIL), [], [])

  val ident_fn = fn x => x

  fun count_gc_tags(AugLambda.SCON_TAG(Ident.REAL _, _)) = 1		(* Need size? *)
    | count_gc_tags(AugLambda.SCON_TAG(Ident.STRING _, _)) = 1
    | count_gc_tags _ = 0

  val empty_string_tree : (string, LambdaTypes.LVar) NewMap.map =
      NewMap.empty ((op<):string*string->bool,op= : string * string -> bool)

  fun last [] = Crash.impossible"Last empty list"
    | last [x] = x
    | last (_ :: xs) = last xs

  fun new_frees(vars as (old_set, new_set), {lexp=lexp, size=_}) =
    case lexp of
      AugLambda.APP(le, (lel,fpel),_) => new_frees_list (new_frees (vars, le), fpel @ lel)
    | AugLambda.LET((_,_,lb),le) =>
	new_frees (new_frees (vars,lb), le)
    | AugLambda.FN (args, le,_,_) => new_frees (vars, le)
    | AugLambda.STRUCT le_list => new_frees_list (vars, le_list)
    | AugLambda.SELECT(_, le) => new_frees (vars, le)
    | AugLambda.SWITCH(le, info, tag_le_list, opt) =>
	lists_reducel
	(fn (vars, (tag, le)) =>
	 let
	   val vars = new_frees (vars, le)
	 in
	   case tag of
	     AugLambda.EXP_TAG lexp => new_frees (vars, lexp)
	   | _ => vars
	 end)
	(bandf_opt (new_frees (vars, le), opt), tag_le_list)
    | AugLambda.VAR lv =>
	(old_set,
	 if HashSet.is_member(old_set, lv)
           then HashSet.add_member(new_set, lv)
	 else new_set)
    | AugLambda.LETREC(lv_list, le_list, le) =>
	new_frees_list (vars, le :: le_list)
    | AugLambda.INT _ => vars
    | AugLambda.SCON _ => vars
    | AugLambda.MLVALUE _ => vars
    | AugLambda.HANDLE(le, le') =>
	new_frees(new_frees (vars, le), le')
    | AugLambda.RAISE (le) => new_frees (vars, le)
    | AugLambda.BUILTIN _ => vars

  and new_frees_list (vars, []) = vars
    | new_frees_list (vars,le::rest) = new_frees_list (new_frees (vars,le),rest)

  and bandf_opt(vars, SOME le) = new_frees (vars, le)
    | bandf_opt(vars,_) = vars

  (* Can someone think of a better name for these functions? *)
  fun do_pos1(_, []) = []
    | do_pos1(pos, (_, {size=size:int, lexp=_}) :: rest) =
      pos :: do_pos1(pos+size, rest)

  fun do_pos2(_, []) = []
    | do_pos2(pos, (tag,_) :: rest) =
      pos :: do_pos2(pos+count_gc_tags tag, rest)

  fun do_pos3(_, []) = []
    | do_pos3(pos, {size=size:int, lexp=_} :: rest) =
      pos :: do_pos3(pos+size, rest)

  (* General utilities *)

  val zip2 = Lists.zip

  fun zip3 (l1,l2,l3) =
    let
      fun aux ([],[],[],acc) = rev acc
        | aux (a1::b1,a2::b2,a3::b3,acc) =
          aux (b1,b2,b3,(a1,a2,a3)::acc)
        | aux _ = Crash.impossible "zip3"
    in
      aux (l1,l2,l3,[])
    end

  fun zip4 (l1,l2,l3,l4) =
    let
      fun aux ([],[],[],[],acc) = rev acc
        | aux (a1::b1,a2::b2,a3::b3,a4::b4,acc) =
          aux (b1,b2,b3,b4,(a1,a2,a3,a4)::acc)
        | aux _ = Crash.impossible "zip5"
    in
      aux (l1,l2,l3,l4,[])
    end

  fun zip5 (l1,l2,l3,l4,l5) =
    let
      fun aux ([],[],[],[],[],acc) = rev acc
        | aux (a1::b1,a2::b2,a3::b3,a4::b4,a5::b5,acc) =
          aux (b1,b2,b3,b4,b5,(a1,a2,a3,a4,a5)::acc)
        | aux _ = Crash.impossible "zip5"
    in
      aux (l1,l2,l3,l4,l5,[])
    end

  fun zip7 (l1,l2,l3,l4,l5,l6,l7) =
    let
      fun aux ([],[],[],[],[],[],[],acc) = rev acc
        | aux (a1::b1,a2::b2,a3::b3,a4::b4,a5::b5,a6::b6,a7::b7,acc) =
          aux (b1,b2,b3,b4,b5,b6,b7,(a1,a2,a3,a4,a5,a6,a7)::acc)
        | aux _ = Crash.impossible "zip7"
    in
      aux (l1,l2,l3,l4,l5,l6,l7,[])
    end

  (* Stuff for multi-argument functions *)

  (* Map function parameters onto a fixed set of registers *)
  local
    val caller_arg_regs = MirRegisters.caller_arg_regs
    val callee_arg_regs = MirRegisters.callee_arg_regs

    fun assign_regs regs args =
      let
        fun assign ([],regs,acc) = rev acc
          | assign (rest,[reg],acc) = rev (reg::acc)
          | assign (arg::rest,reg::restregs,acc) = assign (rest,restregs,reg::acc)
          | assign _ = Crash.impossible "Not enough arg regs"
      in
        assign (args,regs,[])
      end
  in
    fun assign_caller_regs args = assign_regs caller_arg_regs args
    fun assign_callee_regs args = assign_regs callee_arg_regs args
    fun assign_fp_regs args = assign_regs MirRegisters.fp_arg_regs args
  end

  fun make_get_args_code (args,copies) =
    let
      fun make_code ([],[],acc) = rev acc
        | make_code ([arg],copies as (_::_::_),acc) =
          let
            fun do_loads (n,copy::rest,acc) =
              do_loads (n+1,rest,
                        MirTypes.STOREOP (MirTypes.LD,
                                          MirTypes.GC_REG copy,
                                          MirTypes.GC_REG arg,
                                          MirTypes.GP_IMM_ANY (n * 4 - 1)) ::
                        acc)
              | do_loads (n,[],acc) = rev acc
          in
            do_loads (0,copies,acc)
          end
        | make_code (arg::restargs,copy::restcopies,acc) =
          make_code (restargs,restcopies,
                     MirTypes.UNARY(MirTypes.MOVE,
                                    MirTypes.GC_REG copy,
                                    MirTypes.GP_GC_REG arg) ::
                     acc)
        | make_code _ = Crash.impossible "make_get_args_code"
    in
      make_code (args,copies,[])
    end

  fun make_fp_get_args_code (args,copies) =
    let
      fun make_code ([],[],acc) = rev acc
        | make_code (arg::restargs,copy::restcopies,acc) =
          make_code (restargs,restcopies,
                     MirTypes.UNARYFP(MirTypes.FMOVE,
                                      MirTypes.FP_REG copy,
                                      MirTypes.FP_REG arg) ::
                     acc)
        | make_code _ = Crash.impossible "make_fp_get_args_code"
    in
      make_code (args,copies,[])
    end

  fun is_simple_relation lexp =
    case lexp of
      AugLambda.APP({lexp=AugLambda.BUILTIN(prim,_), ...},_,_) =>
        (case prim of
           Pervasives.INTLESS => true
         | Pervasives.REALLESS => true
         | Pervasives.CHARLT => true
         | Pervasives.WORDLT => true
         | Pervasives.INTGREATER => true
         | Pervasives.REALGREATER => true
         | Pervasives.CHARGT => true
         | Pervasives.WORDGT => true
         | Pervasives.INTLESSEQ => true
         | Pervasives.REALLESSEQ => true
         | Pervasives.CHARLE => true
         | Pervasives.WORDLE => true
         | Pervasives.INTGREATEREQ => true
         | Pervasives.REALGREATEREQ => true
         | Pervasives.CHARGE => true
         | Pervasives.WORDGE => true
         | Pervasives.INTEQ => true
         | Pervasives.INTNE => true
         | Pervasives.REALEQ => true
         | Pervasives.REALNE => true
         | Pervasives.CHAREQ => true
         | Pervasives.CHARNE => true
         | Pervasives.WORDEQ => true
         | Pervasives.WORDNE => true
         | _ => false)
    | _ => false

  fun convert_tag tag =
    case tag of
      AugLambda.VCC_TAG(tag,_) => RuntimeEnv.CONSTRUCTOR(tag)
    | AugLambda.IMM_TAG(tag,_) => RuntimeEnv.CONSTRUCTOR(tag)
    | AugLambda.SCON_TAG(tag, _) => 				(* Need size? *)
        (case tag of
           Ident.INT(tag,_) => RuntimeEnv.INT(tag)
         | Ident.REAL(tag,_) => RuntimeEnv.REAL(tag)
         | Ident.STRING(tag) => RuntimeEnv.STRING(tag)
         | Ident.CHAR(tag) => RuntimeEnv.CHAR(tag)
         | Ident.WORD(tag, _) => RuntimeEnv.WORD(tag))
    | AugLambda.EXP_TAG(_) => RuntimeEnv.DYNAMIC

    (* Generates a map from primitives to lambda variables *)
    fun make_prim_info (options,lambda_exp) =
      let
        val (prim_to_lambda_map, new_lambda_exp) =
          Library.build_external_environment (options, lambda_exp)
        val prim_to_lambda = NewMap.apply prim_to_lambda_map
      in
        (prim_to_lambda,new_lambda_exp)
      end

  fun do_externals (new_exp_and_size,number_of_gc_objects) =
    let

    val (top_tags_list, next) =
      Lists.number_from_by_one(Mir_Utils.list_of_tags (number_of_gc_objects+1), 0,
                               ident_fn)

    val top_closure = IntMap.apply (IntMap.from_list (map (fn (x,y) => (y,x)) top_tags_list))

(*
      (lists_reducel
       (fn (x, (t, i)) => IntMap.define(x, i, t))
       (IntMap.empty, top_tags_list))
*)

    fun wrap_tree_bindings(tree, prim, le) =
      NewMap.fold
      (* Theoretically the wrong order, but there is no dependence *)
      (fn (le as {size=size, ...}, string, lv) =>
       {lexp=AugLambda.LET
        ((lv, NONE,
         {lexp=AugLambda.APP
	      ({lexp=AugLambda.BUILTIN(prim,LambdaTypes.null_type_annotation),
		size=0},
	       ([{lexp=AugLambda.SCON(Ident.STRING string, NONE), size=0}],[]),
               Debugger_Types.null_backend_annotation),
               size=0}), le), size=size})
      (le, tree)

    val needs_transform = Mir_Utils.transform_needed(false, new_exp_and_size)

    val ((var_tree, exn_tree, str_tree, fun_tree, ext_tree), new_exp_and_size) =
      if needs_transform then
	Mir_Utils.lift_externals((empty_string_tree, empty_string_tree, empty_string_tree,
                                  empty_string_tree, empty_string_tree), new_exp_and_size)
      else
	((empty_string_tree, empty_string_tree, empty_string_tree,
	  empty_string_tree, empty_string_tree), new_exp_and_size)

    val ext_vars = NewMap.domain var_tree
    val ext_exns = NewMap.domain exn_tree
    val ext_strs = NewMap.domain str_tree
    val ext_funs = NewMap.domain fun_tree
    val new_exp_and_size =
      if needs_transform then
	wrap_tree_bindings
	(ext_tree, Pervasives.LOAD_STRING, wrap_tree_bindings
	 (var_tree, Pervasives.LOAD_VAR, wrap_tree_bindings
	  (exn_tree, Pervasives.LOAD_EXN, wrap_tree_bindings
	   (str_tree, Pervasives.LOAD_STRUCT, wrap_tree_bindings
	    (fun_tree, Pervasives.LOAD_FUNCT, new_exp_and_size)))))
      else
	new_exp_and_size

    val ext_strings =
      if needs_transform
        then NewMap.domain ext_tree
      else Set.set_to_list (Mir_Utils.get_string new_exp_and_size)

    val (ext_string_list, next) =
      Lists.number_from_by_one(ext_strings, next, ident_fn)
    val (ext_var_list, next) =
      Lists.number_from_by_one(ext_vars, next, ident_fn)
    val (ext_exn_list, next) =
      Lists.number_from_by_one(ext_exns, next, ident_fn)
    val (ext_str_list, next) =
      Lists.number_from_by_one(ext_strs, next, ident_fn)
    val (ext_fun_list, next) =
      Lists.number_from_by_one(ext_funs, next, ident_fn)
    in
      (new_exp_and_size, top_tags_list, top_closure,
       (ext_string_list,ext_var_list,ext_exn_list,ext_str_list,ext_fun_list))
  end


  fun find_frees (env,closure,fcn,prim_to_lambda) =
          let
            val Mir_Env.LAMBDA_ENV lambda_env = env
            val Mir_Env.CLOSURE_ENV closure_env = closure
            fun add_members x = IntMap.fold (fn (set, x,_) => HashSet.add_member(set, x)) x
            val (_,free) =
              new_frees
              ((add_members (add_members (empty_hashset(), closure_env), lambda_env),
                empty_hashset()),
               {lexp=fcn, size=0})
            val free' =
              if Mir_Utils.needs_prim_stringeq fcn then
                HashSet.add_member(free, prim_to_lambda Pervasives.STRINGEQ)
              else
                free
          in
            HashSet.set_to_list
            (lists_reducel
             (fn (free', x) => HashSet.add_member(free', prim_to_lambda x))
             (free', Set.set_to_list (Library.implicit_external_references fcn)))
          end

      (* Code generation utilities *)
      fun load_external (lexp,index_fn,env,spills,calls) =
	(case lexp of
	  AugLambda.SCON(Ident.STRING chars, _) =>
	    let
	      val result = MirTypes.GC.new()
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
               ((Sexpr.ATOM[MirTypes.STOREOP(MirTypes.LD,
                                             MirTypes.GC_REG result,
                                             MirTypes.GC_REG callee_closure,
                                             MirTypes.GP_IMM_ANY(~1 + 4 * (index_fn chars)))],
               [], NONE, Sexpr.NIL), [], []),
               env,spills,calls)
	    end
	| _ => Crash.impossible"Bad parameter to load_external")

      fun do_get_implicit (lexp,env,spills,calls) =
        (case lexp of
           AugLambda.INT offset =>
             let
               val result = MirTypes.GC.new()
             in
               (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_GC_REG result)),
                ((Sexpr.ATOM
                  [MirTypes.STOREOP(MirTypes.LDREF, MirTypes.GC_REG result,
                                    MirTypes.GC_REG MirRegisters.implicit,
                                    MirTypes.GP_IMM_ANY (4 * offset))],
                [],NONE, Sexpr.NIL),[],[]),
               env,spills,calls)
             end
         | _ => Crash.impossible "Bad parameter to get_implicit")

      fun get_int_pair regs =
        case regs of
          Mir_Utils.ONE(Mir_Utils.INT(reg as MirTypes.GP_GC_REG _)) =>
	    Mir_Utils.destruct_2_tuple reg
        | Mir_Utils.LIST[Mir_Utils.INT reg1, Mir_Utils.INT reg2] =>
	    (reg1, reg2, [])
        | _ => Crash.impossible "get_int_pair"

      fun get_real_pair regs =
        case regs of
          Mir_Utils.ONE(Mir_Utils.INT(reg as MirTypes.GP_GC_REG _)) =>
            let
              val (reg1, reg2, des_code) = Mir_Utils.destruct_2_tuple reg
              val (fp1, code1) = Mir_Utils.get_real (Mir_Utils.INT reg1)
              val (fp2, code2) = Mir_Utils.get_real (Mir_Utils.INT reg2)
            in
              (fp1, fp2, des_code @ code1 @ code2)
            end
        | Mir_Utils.LIST[reg1, reg2] =>
            let
              val (fp1, code1) = Mir_Utils.get_real reg1
              val (fp2, code2) = Mir_Utils.get_real reg2
            in
              (fp1, fp2, code1 @ code2)
            end
        | _ => Crash.impossible"get_real_pair"

      (* Word32 (and Int32) values are stored as four-byte strings. *)
      fun get_word32_pair regs =
        case regs of
          Mir_Utils.ONE(Mir_Utils.INT(reg as MirTypes.GP_GC_REG _)) =>
            let
              val (reg1, reg2, des_code) = Mir_Utils.destruct_2_tuple reg
              val (w1, code1, clean1) =
		Mir_Utils.get_word32 (Mir_Utils.INT reg1)
              val (w2, code2, clean2) =
		Mir_Utils.get_word32 (Mir_Utils.INT reg2)
            in
              (w1, w2, des_code @ code1 @ code2, clean1 @ clean2)
            end
        | Mir_Utils.LIST[reg1, reg2] =>
            let
              val (w1, code1, clean1) = Mir_Utils.get_word32 reg1
              val (w2, code2, clean2) = Mir_Utils.get_word32 reg2
            in
              (w1, w2, code1 @ code2, clean1 @ clean2)
            end
        | _ => Crash.impossible"get_word32_pair"

      fun getint (Mir_Utils.INT x) = x
        | getint _ = Crash.impossible "getint"

      (* Word32 (and Int32) values are stored as four-byte strings. *)
      fun get_word32_and_word regs =
        case regs of
          Mir_Utils.ONE(Mir_Utils.INT(reg as MirTypes.GP_GC_REG _)) =>
            let
              val (reg1, reg2, des_code) = Mir_Utils.destruct_2_tuple reg
              val (w1, code1, clean1) =
		Mir_Utils.get_word32 (Mir_Utils.INT reg1)
            in
              (w1, reg2, des_code @ code1, clean1)
            end
        | Mir_Utils.LIST[reg1, reg2] =>
            let
              val (w1, code1, clean1) = Mir_Utils.get_word32 reg1
            in
              (w1, getint reg2, code1, clean1)
            end
        | _ => Crash.impossible"get_word32_pair"

      fun unary_negate(opcode,regs,the_code,exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (exn_blocks, exn_tag_list) = exn_code
	in
	  case regs of
	    Mir_Utils.ONE(Mir_Utils.INT reg) =>
	      (Mir_Utils.ONE(Mir_Utils.INT res1),
	       Mir_Utils.combine(the_code,
                                 ((Sexpr.ATOM[(MirTypes.TBINARY(opcode, exn_tag_list, res2,
                                                                MirTypes.GP_IMM_INT 0, reg))], exn_blocks,
                                   NONE, Sexpr.NIL), [], [])))
	  | _ => Crash.impossible"unary_negate"
	end

      (* This doesn't work if an exception is raised, because it the
	 exception is handled by a trap, and the argument register isn't
	 cleaned. See also int32_binary_calc and do_int32abs. *)

      fun int32_unary_negate (opcode, Mir_Utils.ONE(Mir_Utils.INT reg), the_code, exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (exn_blocks, exn_tag_list) = exn_code

          val (w, arg_code, clean_arg) =
	    Mir_Utils.get_word32 (Mir_Utils.INT reg)

	  val new_code =
	    arg_code @
	    [MirTypes.TBINARY
	       (opcode, exn_tag_list, res2, MirTypes.GP_IMM_INT 0, w)] @ clean_arg
	  val (final_res, final_code) = Mir_Utils.save_word32 result
	  val clean_res = [MirTypes.NULLARY(MirTypes.CLEAN, res2)]
	in
	  (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG final_res)),
	   Mir_Utils.combine
	     (the_code,
              ((Sexpr.ATOM(new_code @ final_code @ clean_res), exn_blocks,
		NONE, Sexpr.NIL),
	       [], [])))
	end
	| int32_unary_negate _ = Crash.impossible "int32_unary_negate"

      fun tagged_binary_fcalc(opcode,regs,the_code,exn_code) =
	let
	  val result = MirTypes.FP_REG(MirTypes.FP.new())
	  val (val1,val2, new_code) = get_real_pair regs
	  val (exn_blocks, exn_tag_list) = exn_code
	in
          (Mir_Utils.ONE(Mir_Utils.REAL result),
           Mir_Utils.combine(the_code,
                              ((Sexpr.ATOM(new_code @
                                           [(MirTypes.TBINARYFP(opcode, exn_tag_list, result,
                                                                val1, val2))]),
                              exn_blocks, NONE, Sexpr.NIL), [], [])))
	end

      fun unary_fcalc (opcode,regs,the_code) =
	let
	  val result = MirTypes.FP_REG(MirTypes.FP.new())
	in
	  (Mir_Utils.ONE(Mir_Utils.REAL result),
	    Mir_Utils.combine(the_code,
                              (((case regs of
                                   Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
                                     Sexpr.ATOM[MirTypes.STOREFPOP(MirTypes.FLD, result,
                                                                   MirTypes.GC_REG reg,
                                                                   MirTypes.GP_IMM_ANY real_offset),
                                     MirTypes.UNARYFP(opcode, result, result)]
                                 | Mir_Utils.ONE(Mir_Utils.REAL reg) =>
                                     Sexpr.ATOM[MirTypes.UNARYFP(opcode, result, reg)]
                                 | _ => Crash.impossible"unary_fcalc"),
                                   [], NONE, Sexpr.NIL), [], [])))
	end

      fun tagged_unary_fcalc (opcode,regs,the_code,exn_code) =
	let
	  val result = MirTypes.FP_REG(MirTypes.FP.new())
	  val (exn_blocks, exn_tag_list) = exn_code
	in
	  (Mir_Utils.ONE(Mir_Utils.REAL result),
	    Mir_Utils.combine(the_code,
	      (((case regs of
		Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
		  Sexpr.ATOM[MirTypes.STOREFPOP(MirTypes.FLD, result,
				      MirTypes.GC_REG reg,
				      MirTypes.GP_IMM_ANY real_offset),
		    MirTypes.TUNARYFP(opcode, exn_tag_list, result, result)]
		| Mir_Utils.ONE(Mir_Utils.REAL reg) =>
		    Sexpr.ATOM[MirTypes.TUNARYFP(opcode, exn_tag_list, result, reg)]
		| _ => Crash.impossible"tagged_unary_fcalc"),
		  exn_blocks, NONE, Sexpr.NIL), [], [])))
	end

      fun make_test (test_instr,res_reg,finish_tag) =
        [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
                        MirTypes.GP_IMM_INT 1),
         test_instr,
         MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
                        MirTypes.GP_IMM_INT 0),
         MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG finish_tag)]

      fun test (opcode,regs,the_code) =
	let
	  val res_reg = MirTypes.GC.new()
	  val finish_tag = MirTypes.new_tag()
          val (val1, val2, new_code) = get_int_pair regs
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res_reg)),
           Mir_Utils.combine(the_code,
                             ((Sexpr.ATOM(new_code @
                                          make_test (MirTypes.TEST(opcode, finish_tag, val1, val2),
                                                     res_reg,
                                                     finish_tag)),
			       [], SOME finish_tag,
			       Sexpr.ATOM[MirTypes.COMMENT"Code following test"]), [], [])))
        end

      fun test32 (opcode,regs,the_code) =
	let
	  val res = MirTypes.GC.new()
	  val res2 = MirTypes.GC_REG res
	  val finish_tag = MirTypes.new_tag()

          val (val1, val2, arg_code, clean_arg_code) = get_word32_pair regs

	  val new_code =
	    arg_code
	    @ make_test
		(MirTypes.TEST (opcode, finish_tag, val1, val2),
		 res, finish_tag)
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res)),
           Mir_Utils.combine
	     (the_code,
              ((Sexpr.ATOM new_code, [], SOME finish_tag,
		Sexpr.ATOM clean_arg_code),
	       [], [])))
        end

      (* These functions are used in switches on relational expressions *)
      fun imake_if (opcode,regs,the_code,true_tag,false_tag) =
        let
          val (val1, val2, new_code) = get_int_pair regs
        in
          Mir_Utils.combine(the_code,
                             ((Sexpr.ATOM(new_code @
                                          [MirTypes.TEST(opcode, true_tag, val1, val2),
                                           MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG false_tag)]),
                               [], NONE, Sexpr.NIL), [], []))
        end

      fun fmake_if (opcode,sense,regs,the_code,true_tag,false_tag) =
        let
          val (val1, val2, new_code) = get_real_pair regs
          val (val1, val2) = if sense then (val1, val2) else (val2, val1)
        in
          Mir_Utils.combine(the_code,
                             ((Sexpr.ATOM(new_code @
                                          [MirTypes.FTEST(opcode, true_tag, val1, val2),
                                           MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG false_tag)]),
                               [], NONE, Sexpr.NIL), [], []))
        end

      fun make_if (test, regs, code, true_tag, false_tag) =
	case test
	of Pervasives.INTLESS =>
	  imake_if (MirTypes.BLT, regs, code, true_tag, false_tag)
	|  Pervasives.CHARLT =>
	  imake_if (MirTypes.BLT, regs, code, true_tag, false_tag)
	|  Pervasives.WORDLT =>
	  imake_if (MirTypes.BLO, regs, code, true_tag, false_tag)
	|  Pervasives.REALLESS =>
          fmake_if (MirTypes.FBLT,true, regs, code, true_tag, false_tag)
        |  Pervasives.INTGREATER =>
	  imake_if (MirTypes.BGT, regs, code, true_tag, false_tag)
        |  Pervasives.CHARGT =>
	  imake_if (MirTypes.BGT, regs, code, true_tag, false_tag)
        |  Pervasives.WORDGT =>
	  imake_if (MirTypes.BHI, regs, code, true_tag, false_tag)
        |  Pervasives.REALGREATER =>
	  fmake_if (MirTypes.FBLT,false, regs, code, true_tag, false_tag)
        |  Pervasives.INTLESSEQ =>
	  imake_if (MirTypes.BLE, regs, code, true_tag, false_tag)
        |  Pervasives.CHARLE =>
	  imake_if (MirTypes.BLE, regs, code, true_tag, false_tag)
        |  Pervasives.WORDLE =>
	  imake_if (MirTypes.BLS, regs, code, true_tag, false_tag)
        |  Pervasives.REALLESSEQ =>
	  fmake_if (MirTypes.FBLE, true, regs, code, true_tag, false_tag)
        |  Pervasives.INTGREATEREQ =>
	  imake_if (MirTypes.BGE, regs, code, true_tag, false_tag)
        |  Pervasives.CHARGE =>
	  imake_if (MirTypes.BGE, regs, code, true_tag, false_tag)
        |  Pervasives.WORDGE =>
	  imake_if (MirTypes.BHS, regs, code, true_tag, false_tag)
        |  Pervasives.REALGREATEREQ =>
	  fmake_if (MirTypes.FBLE, false, regs, code, true_tag, false_tag)
        |  Pervasives.INTEQ =>
	  imake_if (MirTypes.BEQ, regs, code, true_tag, false_tag)
        |  Pervasives.INTNE =>
	  imake_if (MirTypes.BNE, regs, code, true_tag, false_tag)
        |  Pervasives.CHAREQ =>
	  imake_if (MirTypes.BEQ, regs, code, true_tag, false_tag)
        |  Pervasives.CHARNE =>
	  imake_if (MirTypes.BNE, regs, code, true_tag, false_tag)
        |  Pervasives.WORDEQ =>
	  imake_if (MirTypes.BEQ, regs, code, true_tag, false_tag)
        |  Pervasives.WORDNE =>
	  imake_if (MirTypes.BNE, regs, code, true_tag, false_tag)
        |  Pervasives.REALEQ =>
	  fmake_if (MirTypes.FBEQ, true, regs, code, true_tag, false_tag)
        |  Pervasives.REALNE =>
	  fmake_if (MirTypes.FBNE, true, regs, code, true_tag, false_tag)
        |  _ => Crash.impossible "bad relational operator"

      fun ftest(opcode,sense,regs,the_code) =
	let
	  val res_reg = MirTypes.GC.new()
	  val finish_tag = MirTypes.new_tag()
	in
	  let
	    val (val1, val2, new_code) = get_real_pair regs
	    val (val1, val2) = if sense then (val1, val2) else (val2, val1)
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res_reg)),
	      Mir_Utils.combine
              (the_code,
               ((Sexpr.ATOM(new_code @
                            make_test (MirTypes.FTEST(opcode, finish_tag, val1, val2),
                                       res_reg,finish_tag)),
                 [], SOME finish_tag,
		 Sexpr.ATOM[MirTypes.COMMENT"End of float test"]), [], [])))
	  end
	end

      fun do_external_prim prim =
	Crash.impossible"do_external_prim"

      fun make_size_code regs =
	let
	  val new_reg = case regs of
	    Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) => MirTypes.GC_REG reg
	  | _ => Crash.impossible"Bad string pointer"
	  val res_reg = MirTypes.GC.new()
	in
	  (new_reg, MirTypes.GP_GC_REG res_reg,
	    [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG res_reg, new_reg,
			      MirTypes.GP_IMM_ANY ~5),
	     (* Reference size from header at offset -5 *)
	     MirTypes.BINARY(MirTypes.LSR, MirTypes.GC_REG res_reg,
			     MirTypes.GP_GC_REG res_reg,
			     MirTypes.GP_IMM_ANY 6),
	     MirTypes.COMMENT"Divide by 64",
	     MirTypes.BINARY(MirTypes.SUBU, MirTypes.GC_REG res_reg,
			     MirTypes.GP_GC_REG res_reg,
			     MirTypes.GP_IMM_ANY 1),
	     MirTypes.COMMENT"Remove one for 0 terminator",
	     MirTypes.BINARY(MirTypes.ASL, MirTypes.GC_REG res_reg,
			     MirTypes.GP_GC_REG res_reg,
			     MirTypes.GP_IMM_ANY 2),
	     MirTypes.COMMENT"And tag"])
	end

      fun tagged_binary_calc(opcode,regs,the_code,exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (val1, val2, new_code) = get_int_pair regs
	  val (exn_blocks, exn_tag_list) = exn_code
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1),
           Mir_Utils.combine (the_code,
                              ((Sexpr.ATOM(new_code @
                                           [(MirTypes.TBINARY(opcode,
                                                              exn_tag_list, res2, val1, val2))]),
                                exn_blocks, NONE, Sexpr.NIL), [], [])))
	end

      fun tagged_binary_calc(opcode,regs,the_code,exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (val1, val2, new_code) = get_int_pair regs
	  val (exn_blocks, exn_tag_list) = exn_code
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1),
           Mir_Utils.combine (the_code,
                              ((Sexpr.ATOM(new_code @
                                           [(MirTypes.TBINARY(opcode,
                                                              exn_tag_list, res2, val1, val2))]),
                                exn_blocks, NONE, Sexpr.NIL), [], [])))
	end

      (* NB This doesn't work.  The exceptions are handled by traps, so
	 the argument registers are never cleaned if an exception occurs. *)
      fun tagged32_binary_calc (opcode, regs, the_code, exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val tmp = MirTypes.GC.new()
	  val tmp2 = MirTypes.GC_REG tmp

	  val (val1, val2, arg_code, clean_arg_code) = get_word32_pair regs
	  val (exn_blocks, exn_tag_list) = exn_code

	  val new_code =
	    (* Do the allocation first - we are using unsafe values *)
	    MirTypes.ALLOCATE
	      (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 4)
	    :: arg_code
	    @ [MirTypes.TBINARY(opcode, exn_tag_list, tmp2, val1, val2),
	       MirTypes.STOREOP
		 (MirTypes.ST, tmp2, res2, MirTypes.GP_IMM_ANY ~1),
	       MirTypes.NULLARY(MirTypes.CLEAN, tmp2)]
	    @ clean_arg_code
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1),
	   Mir_Utils.combine
	     (the_code,
	      ((Sexpr.ATOM new_code, exn_blocks, NONE, Sexpr.NIL),
	       [], [])))
	end

      fun binary_calc (opcode,regs,the_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (val1, val2, new_code) = get_int_pair regs
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1), Mir_Utils.combine
	   (the_code,
	    ((Sexpr.ATOM(new_code @
	     [(MirTypes.BINARY(opcode, res2, val1, val2))]),
	      [], NONE, Sexpr.NIL), [], [])))
	end

      fun untagged32_binary_calc (opcode,regs,the_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val tmp = MirTypes.GC.new()
	  val tmp2 = MirTypes.GC_REG tmp

	  val (val1, val2, arg_code, clean_arg_code) = get_word32_pair regs

	  val new_code =
	    (* Do the allocation first - we are using unsafe values *)
	    MirTypes.ALLOCATE
	      (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 4)
	    :: arg_code
	    @ [MirTypes.BINARY(opcode, tmp2, val1, val2),
	       MirTypes.STOREOP
		 (MirTypes.ST, tmp2, res2, MirTypes.GP_IMM_ANY ~1),
	       MirTypes.NULLARY(MirTypes.CLEAN, tmp2)]
	    @ clean_arg_code
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1),
	   Mir_Utils.combine
	     (the_code,
	      ((Sexpr.ATOM new_code, [], NONE, Sexpr.NIL), [], [])))
	end

      fun do_shift_operator(mir_operator,need_to_clear_bottom_two_bits,regs,the_code) =
	let
	  val _ =
	    if need_to_clear_bottom_two_bits then
	      if mir_operator = MirTypes.ASR orelse
		mir_operator = MirTypes.LSR then
		()
	      else
		Crash.impossible("mir_cg:do_shift_operator:bad shift and clear combination with " ^ MirPrint.binary_op mir_operator)
	    else
	      ()
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val spare = MirTypes.GC.new()
	  val spare1 = MirTypes.GP_GC_REG spare
	  val spare2 = MirTypes.GC_REG spare
	  val (val1, val2, new_code) = get_int_pair regs
	  val shift_code =
            case val2 of
              MirTypes.GP_IMM_INT i =>
		(* Optimise the shift by constant case *)
		(* Also check for shifts by more than word size here *)
		let
		  val (shift_limit, replace_by_zero) = case mir_operator of
		    MirTypes.ASR => (MachSpec.bits_per_word-1, false)
		  | _ => (MachSpec.bits_per_word, true)
		  val i = if i > shift_limit then shift_limit else i
		in
		  if i >= shift_limit andalso replace_by_zero then
		    [MirTypes.UNARY(MirTypes.MOVE, res2, MirTypes.GP_IMM_INT 0)]
		  else
		    if need_to_clear_bottom_two_bits then
		      (* Must be the shift right case, *)
		      (* so go two further then shift back *)
		      [MirTypes.BINARY(mir_operator, res2, val1,
				       MirTypes.GP_IMM_ANY(i+2)),
		       MirTypes.BINARY(MirTypes.ASL, res2, res1,
				       MirTypes.GP_IMM_ANY 2)]
		    else
		      [MirTypes.BINARY(mir_operator, res2, val1,
				       MirTypes.GP_IMM_ANY i)]
		end
            | _ =>
		let
		  val clean_code =
		    [MirTypes.NULLARY(MirTypes.CLEAN, spare2)]
		  val clear_code =
		    if need_to_clear_bottom_two_bits then
		      MirTypes.UNARY(MirTypes.INTTAG, res2, res1) :: clean_code
		    else
		      clean_code
		in
		  MirTypes.BINARY(MirTypes.LSR, spare2,
				  val2, MirTypes.GP_IMM_ANY 2) ::
		  MirTypes.BINARY(mir_operator,MirTypes.GC_REG result,val1,
				  spare1) ::
		  clear_code
		end
	in
	  (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
	   Mir_Utils.combine(the_code,
			     ((Sexpr.CONS(Sexpr.ATOM new_code, Sexpr.ATOM shift_code),
			       [],NONE,Sexpr.NIL),[],[])))
	end

      fun full_machine_word_shift_operator(mir_operator, regs, the_code) =
	let
	  val result = MirTypes.GC.new()
	  val res2 = MirTypes.GC_REG result
	  val tmp = MirTypes.GC.new()
	  val tmp2 = MirTypes.GC_REG tmp
          val spare = MirTypes.GC.new()
	  val spare1 = MirTypes.GP_GC_REG spare
          val spare2 = MirTypes.GC_REG spare

	  val (val1, val2, arg_code, clean_arg_code) = get_word32_and_word regs

	  val alloc_code = MirTypes.ALLOCATE
	    (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 4)
	  val imm_val = case val2 of
	    MirTypes.GP_IMM_INT i => SOME i
	  | MirTypes.GP_IMM_ANY w => SOME w (* immediate word32s can come out like this *)
	  | _ => NONE
	  val new_code =
            case imm_val of
              SOME i =>
		let
		  val (shift_limit, replace_by_zero) = case mir_operator of
		    MirTypes.ASR => (MachSpec.bits_per_word+1, false)
		  | _ => (MachSpec.bits_per_word+2, true)
		  val i = if i > shift_limit then shift_limit else i
		  val shift_operation =
		    if i >= shift_limit andalso replace_by_zero then
		      MirTypes.UNARY(MirTypes.MOVE, tmp2, MirTypes.GP_IMM_INT 0)
		    else
		      MirTypes.BINARY(mir_operator, tmp2, val1, MirTypes.GP_IMM_ANY i)
		in
		  alloc_code ::
		  (arg_code @
		   (shift_operation ::
		    MirTypes.STOREOP
		    (MirTypes.ST, tmp2, res2, MirTypes.GP_IMM_ANY ~1) ::
		    MirTypes.NULLARY(MirTypes.CLEAN, tmp2) ::
		    clean_arg_code))
		end
            | _ =>
		alloc_code ::
                (arg_code @
		 (MirTypes.BINARY(MirTypes.LSR, spare2,val2, MirTypes.GP_IMM_ANY 2) ::
		  MirTypes.BINARY(mir_operator, tmp2, val1, spare1) ::
		  MirTypes.STOREOP(MirTypes.ST, tmp2, res2, MirTypes.GP_IMM_ANY ~1) ::
		  MirTypes.NULLARY(MirTypes.CLEAN, tmp2) ::
		  MirTypes.NULLARY(MirTypes.CLEAN, spare2) ::
		  clean_arg_code))
	in
	  (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
	   Mir_Utils.combine
	     (the_code,
	      ((Sexpr.ATOM new_code, [],NONE,Sexpr.NIL),
	       [],[])))
	end


      fun array_code (bytearray,regs,the_code,exn_code) =
        let
          val (constantp, constant_value) =
            (case regs
               of Mir_Utils.LIST[Mir_Utils.INT(size), initial] =>
                 (case size
                    of MirTypes.GP_IMM_INT v => (true,v )
                     | _ => (false,0))
                | _ => (false,0))


          val ((new_reg, code),(new_reg', code')) =
            case regs of
              Mir_Utils.LIST[ Mir_Utils.INT(size), initial] =>
                 (Mir_Utils.send_to_new_reg(Mir_Utils.ONE(initial)),
                  Mir_Utils.send_to_new_reg(Mir_Utils.ONE(Mir_Utils.INT size)))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                  val new_reg = MirTypes.GC.new()
                  val new_reg' = MirTypes.GC.new()
                in
                  ((MirTypes.GP_GC_REG new_reg,[MirTypes.STOREOP(MirTypes.LD,
                                    MirTypes.GC_REG new_reg,
                                    Mir_Utils.reg_from_gp reg,
                                    MirTypes.GP_IMM_ANY 3)]),
                  (MirTypes.GP_GC_REG new_reg',[MirTypes.STOREOP(MirTypes.LD,
                                              MirTypes.GC_REG new_reg',
                                              Mir_Utils.reg_from_gp reg,
                                              MirTypes.GP_IMM_ANY ~1)]))
                  end)
            | _ => Crash.impossible "_mir_cg : array_fn can't code generate arguments "

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val work1 = MirTypes.GC_REG(MirTypes.GC.new())
          val work2 = MirTypes.GC_REG(MirTypes.GC.new())
          val temp_reg = MirTypes.GC.new()
	  val temp = MirTypes.GC_REG temp_reg
	  val temp_gp = MirTypes.GP_GC_REG temp_reg
          val count =  MirTypes.GC.new()
          val main_tag = MirTypes.new_tag()
          val loop_tag = MirTypes.new_tag()
          val finish_tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code
	  val exn_tag =
	    case exn_tag_list of
              [tag] => tag
	    |  _ => Crash.impossible "bad exn_tag for Bytearray.array"
          val after_alignment = MirTypes.new_tag()
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @ code' @
               (if constantp then
                  (if constant_value >= 0 then
                     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG main_tag)]
                   else
                     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])
                else
                  [MirTypes.TEST(MirTypes.BGE, main_tag, new_reg', MirTypes.GP_IMM_INT 0),
                   MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])),

              (* begin main block: allocate memory *)
              MirTypes.BLOCK(main_tag,
               (if constantp then
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  Mir_Utils.reg_from_gp new_reg',
                                  MirTypes.GP_IMM_INT constant_value)]
                else []) @
               (if bytearray then
                  [MirTypes.COMMENT"ByteArray creation operation",
                   MirTypes.ALLOCATE(MirTypes.ALLOC_BYTEARRAY, res1,
                                     if constantp then
                                       MirTypes.GP_IMM_INT constant_value
                                     else new_reg')]
                else
                   [MirTypes.COMMENT"Array creation operation",
                    MirTypes.ALLOCATE(MirTypes.ALLOC_REF, res1,
                                      (if constantp then
                                         MirTypes.GP_IMM_INT constant_value
                                       else new_reg'))]
                )@
               [MirTypes.COMMENT"Initialise all of the values"] @
               (if constantp then
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  MirTypes.GC_REG count,
                                  MirTypes.GP_IMM_INT constant_value)]
                else
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  MirTypes.GC_REG count,
                                  new_reg')]
               ) @
	       (if bytearray then (* remove integer tags (least 2 bits) *)
		    [MirTypes.BINARY(MirTypes.LSR,
		   	      Mir_Utils.reg_from_gp new_reg,
			      new_reg,
			      MirTypes.GP_IMM_ANY 2)]
		else []) @
               [MirTypes.UNARY(MirTypes.MOVE,
                               temp,
                               MirTypes.GP_GC_REG result),
                MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag)])

              (* end main block *)
              ::
              (* begin loop block: initializing values *)
              (if bytearray then
                 MirTypes.BLOCK
                   (loop_tag,
                    [MirTypes.STOREOP(MirTypes.STB,
			 	      Mir_Utils.reg_from_gp new_reg,
                                      temp,
                                      MirTypes.GP_IMM_ANY 1),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     temp,
                                     temp_gp,
                                     MirTypes.GP_IMM_ANY 1),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG count,
                                     MirTypes.GP_GC_REG count,
                                     MirTypes.GP_IMM_INT ~1),
                     MirTypes.TEST(MirTypes.BGT,
                                   loop_tag,
                                   MirTypes.GP_GC_REG count,
                                   MirTypes.GP_IMM_ANY 0),
		     MirTypes.NULLARY(MirTypes.CLEAN,
				      Mir_Utils.reg_from_gp new_reg),
		     MirTypes.NULLARY(MirTypes.CLEAN, temp),
                     MirTypes.BRANCH(MirTypes.BRA,
                                     MirTypes.TAG finish_tag)])
               else
                 MirTypes.BLOCK
                   (loop_tag,
                    [MirTypes.STOREOP(MirTypes.STREF,
                                      Mir_Utils.reg_from_gp new_reg,
                                      temp,
                                      MirTypes.GP_IMM_ANY 9),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     temp,
                                     temp_gp,
                                     MirTypes.GP_IMM_ANY 4),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG count,
                                     MirTypes.GP_GC_REG count,
                                     MirTypes.GP_IMM_INT ~1),
                     MirTypes.TEST(MirTypes.BGT,
                                   loop_tag,
                                   MirTypes.GP_GC_REG count,
                                   MirTypes.GP_IMM_ANY 0),
		     MirTypes.NULLARY(MirTypes.CLEAN, temp),
                     MirTypes.BRANCH(MirTypes.BRA,
                                     MirTypes.TAG finish_tag)]))
              (* end of loop block *)
              ::
              exn_blocks,
              SOME finish_tag,
              if bytearray then
                Sexpr.ATOM[MirTypes.COMMENT"End bytearray code"]
              else
                Sexpr.ATOM[MirTypes.UNARY(MirTypes.MOVE,
                                          work1,
                                          MirTypes.GP_IMM_ANY 0),
                           MirTypes.STOREOP(MirTypes.STREF,
                                            work1,
                                            res1,
                                            MirTypes.GP_IMM_ANY 5),
                           MirTypes.UNARY(MirTypes.MOVE,
                                          work2,
                                          MirTypes.GP_IMM_INT 1),
                           MirTypes.STOREOP(MirTypes.STREF,
                                            work2,
                                            res1,
                                            MirTypes.GP_IMM_ANY 1)]),
            [], [])))
        end




      (* have a special treatment for float arrays: essentially to
         avoid boxing and then unboxing fp values.
         See <URI:MLW/design/floatarray.doc> for details.*)


      fun floatarray_code (regs,the_code,exn_code) =
        let
          val (constantp, constant_value) =
            (case regs
               of Mir_Utils.LIST[Mir_Utils.INT(size), initial] =>
                 (case size
                    of MirTypes.GP_IMM_INT v => (true,v )
                     | _ => (false,0))
                | _ => (false,0))

          val ((float_reg,code),(new_reg', code')) =
            case regs of
              Mir_Utils.LIST[Mir_Utils.INT(size),
                             Mir_Utils.REAL reg] =>
                ((reg,[]),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE(Mir_Utils.INT size)))
            | Mir_Utils.LIST[Mir_Utils.INT(size),
                             Mir_Utils.INT(MirTypes.GP_GC_REG reg)] =>
                let val float_reg = MirTypes.FP_REG(MirTypes.FP.new())
                in
                 ((float_reg,
                  [MirTypes.STOREFPOP(MirTypes.FLD,
                                      float_reg,
                                      MirTypes.GC_REG reg,
                                      MirTypes.GP_IMM_ANY real_offset)]),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE(Mir_Utils.INT size)))
                end
            | Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
                (let
                  val float_reg = MirTypes.FP.new()
                  val new_reg' = MirTypes.GC.new()
                in
                   (* note --- does double word alignment affect us here?
                      (yes on a SPARC v9) *)
                  ((MirTypes.FP_REG float_reg,
                    [MirTypes.STOREFPOP(MirTypes.FLD,
                                        MirTypes.FP_REG float_reg,
                                        MirTypes.GC_REG reg,
                                        MirTypes.GP_IMM_ANY 3)]),
                  (MirTypes.GP_GC_REG new_reg',
                   [MirTypes.STOREOP(MirTypes.LD,
                                     MirTypes.GC_REG new_reg',
                                     MirTypes.GC_REG reg,
                                     MirTypes.GP_IMM_ANY ~1)]))
                  end)
            | _ => Crash.impossible "_mir_cg : floatarray can't code generate arguments "

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val work1 = MirTypes.GC_REG(MirTypes.GC.new())
          val work2 = MirTypes.GC_REG(MirTypes.GC.new())
          val temp_reg = MirTypes.GC.new()
	  val temp = MirTypes.GC_REG temp_reg
	  val temp_gp = MirTypes.GP_GC_REG temp_reg
          val count =  MirTypes.GC.new()
          val main_tag = MirTypes.new_tag()
          val loop_tag = MirTypes.new_tag()
          val finish_tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code
	  val exn_tag =
	    case exn_tag_list of
              [tag] => tag
	    |  _ => Crash.impossible "bad exn_tag for FloatArray.array"
          val after_alignment = MirTypes.new_tag()
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @ code' @
               (if constantp then
                  (if constant_value >= 0 then
                     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG main_tag)]
                   else
                     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])
                else
                  [MirTypes.TEST(MirTypes.BGE, main_tag, new_reg', MirTypes.GP_IMM_INT 0),
                   MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])),

              (* begin main block: allocate memory *)
              MirTypes.BLOCK(main_tag,
               (if constantp then
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  Mir_Utils.reg_from_gp new_reg',
                                  MirTypes.GP_IMM_INT constant_value)]
                else []) @
                [MirTypes.COMMENT"FloatArray creation operation"] @
                (if constantp then []
                        (* convert number of floats into number of bytes
                           --- i.e., multiply by 8, or shift left by 3
                           and add 4 (a blank word inserted after header
                             word to regain double-word alignment) *)
                 else [MirTypes.BINARY(MirTypes.ASL,
                                       temp,
                                       new_reg',
                                       MirTypes.GP_IMM_ANY 3),
                       MirTypes.BINARY(MirTypes.ADDU,
                                       temp,
                                       temp_gp,
                                       MirTypes.GP_IMM_ANY 4)]) @
                 [MirTypes.ALLOCATE(MirTypes.ALLOC_BYTEARRAY, res1,
                                    if constantp then
                                        MirTypes.GP_IMM_INT(constant_value*8+4)
                                    else temp_gp)]
                @
               [MirTypes.COMMENT"Initialise all of the values"] @
               (if constantp then
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  MirTypes.GC_REG count,
                                  MirTypes.GP_IMM_INT constant_value)]
                else
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  MirTypes.GC_REG count,
                                  new_reg')]
               ) @
               [MirTypes.UNARY(MirTypes.MOVE,
                               temp,
                               MirTypes.GP_GC_REG result),
                MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag)])

              (* end main block *)
              ::
              (* begin loop block: initializing values *)
              (MirTypes.BLOCK
                 (loop_tag,
                  (* temp is ptr to bytearray.  1st word is header,
                     2nd is a dummy to maintain double-word alignment.
                     Since ptr tag is 3, we add 5 to pt to the 8th
                     byte in the array.  This is addr of 1st float. *)
                  [MirTypes.STOREFPOP(MirTypes.FST,
                                      float_reg,
                                      temp,
                                      MirTypes.GP_IMM_ANY 5),
                   MirTypes.BINARY(MirTypes.ADDU,
                                   temp,
                                   temp_gp,
                                   MirTypes.GP_IMM_ANY 8),
                   MirTypes.BINARY(MirTypes.ADDU,
                                   MirTypes.GC_REG count,
                                   MirTypes.GP_GC_REG count,
                                   MirTypes.GP_IMM_INT ~1),
                   MirTypes.TEST(MirTypes.BGT,
                                 loop_tag,
                                 MirTypes.GP_GC_REG count,
                                 MirTypes.GP_IMM_ANY 0),
		   MirTypes.NULLARY(MirTypes.CLEAN, temp),
                   MirTypes.BRANCH(MirTypes.BRA,
                                   MirTypes.TAG finish_tag)]))
              (* end of loop block *)
              ::
              exn_blocks,
              SOME finish_tag,
	      Sexpr.ATOM[MirTypes.COMMENT"End of float_array code"]),
            [], [])))
        end


      fun do_alloc_vector_code (regs,arg_code) =
        let
          val (constantp, constant_value) =
            (case regs of
               Mir_Utils.ONE (Mir_Utils.INT size) =>
                 (case size
                    of MirTypes.GP_IMM_INT v => (true,v )
                     | _ => (false,0))
             | _ => (false,0))

          val (size_reg, get_arg_code) =
            case regs of
              Mir_Utils.ONE(Mir_Utils.INT(reg)) => Mir_Utils.send_to_reg regs
            | _ => Crash.impossible "_mir_cg : args to alloc_vector_code "

          val result = MirTypes.GC.new()
          val result_gc = MirTypes.GC_REG result
          val temp_reg = MirTypes.GC.new()     (* temporary pointer into vector *)
	  val temp = MirTypes.GC_REG temp_reg
	  val temp_gp = MirTypes.GP_GC_REG temp_reg
          val value_reg = MirTypes.GC_REG (MirTypes.GC.new ())
          val count =  MirTypes.GC.new()       (* Count register for loop *)
          val loop_tag = MirTypes.new_tag()    (* Entry for while loop to fill with zero *)
          val finish_tag = MirTypes.new_tag()  (* Final block -- clean the temporary pointer reg *)
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (arg_code,
            ((Sexpr.ATOM
              (get_arg_code @
               [MirTypes.COMMENT "Vector creation",
                MirTypes.ALLOCATE(MirTypes.ALLOC_VECTOR, result_gc,
                                  (if constantp then
                                     MirTypes.GP_IMM_INT constant_value
                                   else
                                     size_reg))] @
               [MirTypes.COMMENT"Initialise all of the values"] @
               (if constantp then
                  [MirTypes.UNARY(MirTypes.MOVE,
                                  MirTypes.GC_REG count,
                                  MirTypes.GP_IMM_INT constant_value)]
                else
                  [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG count, size_reg)]) @
               [MirTypes.UNARY(MirTypes.MOVE,
                               temp,
                               MirTypes.GP_GC_REG result),
                MirTypes.UNARY(MirTypes.MOVE,
                               value_reg,
                               MirTypes.GP_IMM_ANY 0),
                MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag)]),
            MirTypes.BLOCK(loop_tag,
                           [MirTypes.TEST(MirTypes.BLE, finish_tag, MirTypes.GP_GC_REG count,MirTypes.GP_IMM_ANY 0),
                            MirTypes.STOREOP(MirTypes.STREF, value_reg,
                                             temp,
                                             MirTypes.GP_IMM_ANY ~1),
                            MirTypes.BINARY(MirTypes.ADDU,
                                            temp,
                                            temp_gp,
                                            MirTypes.GP_IMM_ANY 4),
                            MirTypes.BINARY(MirTypes.ADDU,
                                            MirTypes.GC_REG count,
                                            MirTypes.GP_GC_REG count,
                                            MirTypes.GP_IMM_INT ~1),
                            MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag)]) ::
            [],
            SOME finish_tag,
            Sexpr.ATOM [MirTypes.NULLARY(MirTypes.CLEAN, temp)]),
            [], [])))
        end




      fun do_alloc_pair_code (regs,arg_code) =
        let
          val result = MirTypes.GC.new()
          val result_gc = MirTypes.GC_REG result
          val value_reg = MirTypes.GC_REG (MirTypes.GC.new ())
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (arg_code,
            ((Sexpr.ATOM
              ([MirTypes.COMMENT "Pair creation",
                MirTypes.ALLOCATE(MirTypes.ALLOC, result_gc,
                                  (MirTypes.GP_IMM_INT 2)),
                MirTypes.COMMENT"Initialise the values",
                MirTypes.UNARY(MirTypes.MOVE,
                               value_reg,
                               MirTypes.GP_IMM_ANY 0),
                MirTypes.STOREOP(MirTypes.STREF, value_reg,
                                 result_gc,
                                 MirTypes.GP_IMM_ANY ~1),
                MirTypes.STOREOP(MirTypes.STREF, value_reg,
                                 result_gc,
                                 MirTypes.GP_IMM_ANY 3)]),
              [],
              NONE,
              Sexpr.NIL),
           [], [])))
        end

      fun do_alloc_string_code (regs,arg_code) =
        let
          val (constantp, constant_value) =
            (case regs of
               Mir_Utils.ONE (Mir_Utils.INT size) =>
                 (case size
                    of MirTypes.GP_IMM_INT v => (true,v )
                     | _ => (false,0))
             | _ => (false,0))

          val (size_reg, get_arg_code) =
            case regs of
              Mir_Utils.ONE(Mir_Utils.INT(reg)) => Mir_Utils.send_to_reg regs
            | _ => Crash.impossible "_mir_cg : args to alloc_string_code "

          val result = MirTypes.GC.new()
          val result_gc = MirTypes.GC_REG result
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (arg_code,
            ((Sexpr.ATOM
              (get_arg_code @
               [MirTypes.COMMENT "String creation",
                MirTypes.ALLOCATE(MirTypes.ALLOC_STRING, result_gc,
                                  (if constantp then
                                     MirTypes.GP_IMM_INT (constant_value)
                                   else
                                     size_reg))]),
            [],
            NONE,
            Sexpr.NIL),
            [], [])))
        end

      fun length_code (bytearray,floatarray,regs,the_code) =
        (case regs of
           Mir_Utils.ONE(array) =>
             let
               val (new_reg, code) = Mir_Utils.send_to_reg regs
               val result = MirTypes.GC.new()
               val res1 = MirTypes.GC_REG result
             in
               (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
                Mir_Utils.combine
                (the_code,
                 ((Sexpr.ATOM
                   (code @
                    [MirTypes.COMMENT ((if bytearray then "Byte" else
                                          if floatarray then "Float" else "")
                                       ^ "Array length operation"),
                     MirTypes.STOREOP(MirTypes.LDREF,res1,
                                      Mir_Utils.reg_from_gp new_reg,
                                      MirTypes.GP_IMM_ANY (~3)),
                         (* next remove 6 lowest header bits to get size.
                            if also floatarray, divide also by 8 (i.e.,
                              shift left 3 more) to convert num bytes into
                              num floats *)
                     MirTypes.BINARY(MirTypes.LSR,res1,
                                     MirTypes.GP_GC_REG result,
                                     MirTypes.GP_IMM_ANY
                                     (if floatarray then 9 else 6)),
                         (* next add two 0 bits for integer tag *)
                     MirTypes.BINARY(MirTypes.ASL,res1,
                                     MirTypes.GP_GC_REG result,
                                     MirTypes.GP_IMM_ANY 2)
                     ]),
                   [], NONE, Sexpr.NIL), [], [])))
             end
         | _ =>
             Crash.impossible "Array.length not called with one argument")



      fun vector_length_code (regs,the_code) =
        (case regs of
           Mir_Utils.ONE vector =>
             let
               val (new_reg, code) = Mir_Utils.send_to_reg regs
               val result = MirTypes.GC.new()
               val res1 = MirTypes.GC_REG result
             in
               (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
                Mir_Utils.combine
                (the_code,
                 ((Sexpr.ATOM
                   (code @
                    [MirTypes.COMMENT"Vector length operation",
                     MirTypes.STOREOP(MirTypes.LDREF, res1, Mir_Utils.reg_from_gp new_reg,
                                      MirTypes.GP_IMM_ANY(~5)),
                     MirTypes.BINARY(MirTypes.LSR, res1,
                                     MirTypes.GP_GC_REG result, MirTypes.GP_IMM_ANY 6),
                     MirTypes.BINARY(MirTypes.ASL,res1,
                                     MirTypes.GP_GC_REG result,MirTypes.GP_IMM_ANY 2)
                     ]),
                   [], NONE, Sexpr.NIL), [], [])))
             end
         | _ =>
             Crash.impossible "Vector.length not called with one argument")



      fun sub_code (bytearray, safe,regs,the_code,exn_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[array,offset] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((new_reg, code),(new_reg', code')) =
            case regs of
              Mir_Utils.LIST[array,offset] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE array))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                  val new_reg = MirTypes.GC.new()
                  val new_reg' = MirTypes.GC.new()
                in
                  ((MirTypes.GP_GC_REG new_reg,[MirTypes.STOREOP(MirTypes.LD,
                                    MirTypes.GC_REG new_reg,
                                    Mir_Utils.reg_from_gp reg,
                                    MirTypes.GP_IMM_ANY 3)]),
                  (MirTypes.GP_GC_REG new_reg',[MirTypes.STOREOP(MirTypes.LD,
                                              MirTypes.GC_REG new_reg',
                                              Mir_Utils.reg_from_gp reg,
                                              MirTypes.GP_IMM_ANY ~1)]))
                  end)
            | _ => Crash.impossible
                   "can't code generate the argument given to\
                    \ Array.sub in _mir_cg"

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val res2 = MirTypes.GP_GC_REG result
        in
          if safe then
            let
	      val (exn_blocks, exn_tag_list) = exn_code
	      val exn_tag =
	        case exn_tag_list
	        of [tag] => tag
	        |  _ => Crash.impossible "no exn_tag for Array.sub"
              val main_tag = MirTypes.new_tag()
              val finish_tag = MirTypes.new_tag()
            in
              (Mir_Utils.ONE(Mir_Utils.INT res2),
               Mir_Utils.combine
               (the_code,
                ((Sexpr.ATOM
                  (code @ code' @
                   [MirTypes.COMMENT "Check the subscript range"] @
		(if constantp then
		   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                   else
                     [MirTypes.STOREOP(MirTypes.LDREF,
                                       MirTypes.GC_REG MirRegisters.global,
                                       Mir_Utils.reg_from_gp new_reg',
                                       MirTypes.GP_IMM_ANY ~3),
		      MirTypes.BINARY(MirTypes.LSR,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY 6),
                                                (* Length in words *)
		      MirTypes.TEST(MirTypes.BGT,
                                    main_tag,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY constant_value),
		      MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                 else
(*
                   (if constantp then
                      if constant_value < 0 then
                        [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]
                      else
                        []
                    else
                      [MirTypes.TEST(MirTypes.BLT, exn_tag, new_reg,
                       MirTypes.GP_IMM_INT 0)]) @
                   [MirTypes.STOREOP(MirTypes.LDREF,
                                     MirTypes.GC_REG MirRegisters.global,
                                     Mir_Utils.reg_from_gp new_reg',
                                     MirTypes.GP_IMM_ANY ~3),
                    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
                                    MirTypes.GP_GC_REG MirRegisters.global,
                                    MirTypes.GP_IMM_ANY 4),
                    MirTypes.BINARY(MirTypes.SUBU,
                                    MirTypes.GC_REG MirRegisters.global,
                                    MirTypes.GP_GC_REG MirRegisters.global,
                                    MirTypes.GP_IMM_ANY 1),
                    MirTypes.TEST(MirTypes.BGE, main_tag,
			          MirTypes.GP_GC_REG MirRegisters.global,
				  MirTypes.GP_IMM_ANY 5),
		    (* Note that the 5 includes the left over bit of
                       secondary tag *)
                    MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]
*)
		   [MirTypes.STOREOP(MirTypes.LDREF,
                                     MirTypes.GC_REG MirRegisters.global,
				     Mir_Utils.reg_from_gp new_reg',
				     MirTypes.GP_IMM_ANY ~3),
		    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 4),
		    MirTypes.BINARY(MirTypes.SUBU,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 1),
		    MirTypes.TEST(MirTypes.BHI, main_tag,
				  MirTypes.GP_GC_REG MirRegisters.global,
				  new_reg),
		    MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])
		   ),
                  MirTypes.BLOCK
                    (main_tag,
                     if bytearray then
                       [MirTypes.COMMENT "ByteArray subscript operation",
                        MirTypes.BINARY(MirTypes.LSR,
                                        MirTypes.GC_REG MirRegisters.global,
                                        new_reg,
                                        MirTypes.GP_IMM_ANY 2),
                        MirTypes.BINARY(MirTypes.ADDU,
                                        MirTypes.GC_REG MirRegisters.global,
                                        MirTypes.GP_GC_REG MirRegisters.global,
                                        new_reg'),
                        MirTypes.STOREOP(MirTypes.LDB,
                                         res1,
                                         MirTypes.GC_REG MirRegisters.global,
                                         MirTypes.GP_IMM_ANY 1),
			MirTypes.BINARY(MirTypes.ASL,
                                        res1,
                                        res2,
					MirTypes.GP_IMM_ANY 2),
                        MirTypes.BRANCH(MirTypes.BRA,
                                        MirTypes.TAG finish_tag)]

                      else (*not bytearray *)
                       [MirTypes.COMMENT "Array subscript operation",
                        MirTypes.BINARY(MirTypes.ADDU,
                                        MirTypes.GC_REG MirRegisters.global,
                                        new_reg',
                                        new_reg),
                        MirTypes.STOREOP(MirTypes.LDREF,
                                         res1,
                                         MirTypes.GC_REG MirRegisters.global,
                                         MirTypes.GP_IMM_ANY 9),
                        MirTypes.BRANCH(MirTypes.BRA,
                                        MirTypes.TAG finish_tag)]) ::
                  exn_blocks, SOME finish_tag,
		  Sexpr.ATOM[MirTypes.COMMENT"End of array sub"]), [], [])))
            end
          else
            (Mir_Utils.ONE(Mir_Utils.INT res2),
             Mir_Utils.combine
             (the_code,
              ((Sexpr.ATOM
                (code @ code' @
                 (if bytearray then
                   [MirTypes.COMMENT "Unsafe ByteArray subscript operation",
                    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
                                    new_reg,
                                    MirTypes.GP_IMM_ANY 2),
                    MirTypes.BINARY(MirTypes.ADDU,
			            MirTypes.GC_REG MirRegisters.global,
                                    MirTypes.GP_GC_REG MirRegisters.global,
				    new_reg'),
                    MirTypes.STOREOP(MirTypes.LDB,
                                     res1,
                                     MirTypes.GC_REG MirRegisters.global,
				     MirTypes.GP_IMM_ANY 1),
		    MirTypes.BINARY(MirTypes.ASL,
                                    res1,
                                    res2,
				    MirTypes.GP_IMM_ANY 2)]

                  else (*not bytearray*)
                    [MirTypes.COMMENT "Unsafe array subscript operation",
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG MirRegisters.global,
                                     new_reg',
                                     new_reg),
                     MirTypes.STOREOP(MirTypes.LDREF,
                                      res1,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY 9)])),
              [], NONE, Sexpr.NIL), [], [])))
        end



      (* special version for floatarrays: returns result in an FP register
         rather than a normal int register. See
         <URI:MLW/design/floatarray.doc> for details. *)


      fun floatarray_sub_code (safe,regs,the_code,exn_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[array,offset] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((new_reg, code),(new_reg', code')) =
            case regs of
              Mir_Utils.LIST[array,offset] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE array))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                  val new_reg = MirTypes.GC.new()
                  val new_reg' = MirTypes.GC.new()
                in
                  ((MirTypes.GP_GC_REG new_reg,
                    [MirTypes.STOREOP(MirTypes.LD,
                                      MirTypes.GC_REG new_reg,
                                      Mir_Utils.reg_from_gp reg,
                                      MirTypes.GP_IMM_ANY 3)]),
                  (MirTypes.GP_GC_REG new_reg',
                   [MirTypes.STOREOP(MirTypes.LD,
                                     MirTypes.GC_REG new_reg',
                                     Mir_Utils.reg_from_gp reg,
                                     MirTypes.GP_IMM_ANY ~1)]))
                  end)
            | _ => Crash.impossible
                   "can't code generate the argument given to\
                    \ FloatArray.sub in _mir_cg"

          val result = MirTypes.FP.new()
          val res1 = MirTypes.FP_REG result
        in
          if safe then
            let
	      val (exn_blocks, exn_tag_list) = exn_code
	      val exn_tag =
	        case exn_tag_list
	        of [tag] => tag
	        |  _ => Crash.impossible "no exn_tag for FloatArray.sub"
              val main_tag = MirTypes.new_tag()
              val finish_tag = MirTypes.new_tag()
            in
              (Mir_Utils.ONE(Mir_Utils.REAL res1),
               Mir_Utils.combine
               (the_code,
                ((Sexpr.ATOM
                  (code @
                    [MirTypes.BINARY(MirTypes.ASL,
                                     Mir_Utils.reg_from_gp new_reg,
                                     new_reg,
                                     MirTypes.GP_IMM_ANY 1)] @
                     (* cunning hack: since new_reg is an integer, its
                        lower two bits will be 00.  Shifting it left one
                        more will mean new_reg will be a number 8 times
                        the size of the offset --- i.e., the number of
                        bytes from the beginning of array. *)
                   code' @
                   [MirTypes.COMMENT "Check the subscript range"] @
		(if constantp then
		   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                   else
                     [MirTypes.STOREOP(MirTypes.LDREF,
                                       MirTypes.GC_REG MirRegisters.global,
                                       Mir_Utils.reg_from_gp new_reg',
                                       MirTypes.GP_IMM_ANY ~3),
		      MirTypes.BINARY(MirTypes.LSR,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY 9),
                                                  (* remove 6 header bits
                                                     for number of bytes.
                                                     Then divide by 8
                                                     (ie shift right 3)
                                                     for number of floats.*)
		      MirTypes.TEST(MirTypes.BLE,
                                    exn_tag,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY constant_value),
		      MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG main_tag)]
                 else
		   [MirTypes.STOREOP(MirTypes.LDREF,
                                     MirTypes.GC_REG MirRegisters.global,
				     Mir_Utils.reg_from_gp new_reg',
				     MirTypes.GP_IMM_ANY ~3),
                                     (* 3 is tag of reference pointer. *)
		    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 9),
		    MirTypes.BINARY(MirTypes.ASL,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 3),
                                    (* remove the header bits.  Gives
                                       number of floats * 8.  The two shifts
                                       effectively mask off the 4 bytes used
                                       in the dummy word. *)
                    MirTypes.TEST(MirTypes.BLS ,
                                  exn_tag,
                                  MirTypes.GP_GC_REG MirRegisters.global,
                                  new_reg),
                                    (* unsigned test here is cunning:
                                       it Mir_Utils.combine lowerand upper
                                       bound tests together.  If a subscript
                                       is less than 0, as an unsigned
                                       integer, it is very big, much bigger
                                       than the maximum size of any array *)
                    MirTypes.BRANCH(MirTypes.BRA,
                                    MirTypes.TAG main_tag)]
		   )),
                  MirTypes.BLOCK
                    (main_tag,
                       [MirTypes.COMMENT "FloatArray subscript operation",
                        MirTypes.BINARY(MirTypes.ADDU,
                                        MirTypes.GC_REG MirRegisters.global,
                                        new_reg',
                                        new_reg),
                        MirTypes.STOREFPOP(MirTypes.FLD,
                                           res1,
                                           MirTypes.GC_REG MirRegisters.global,
                                           MirTypes.GP_IMM_ANY 5),
                                           (* offset 5 points to first
                                              entry in array (since we're
                                              3 bytes into the header
                                              word because the pointer tag
                                              equals 3, and the next
                                              word is a dummy to maintain
                                              double word alignment.) *)
                        MirTypes.BRANCH(MirTypes.BRA,
                                        MirTypes.TAG finish_tag)]) ::
                  exn_blocks, SOME finish_tag,
		  Sexpr.ATOM[MirTypes.COMMENT"End of floatarray_sub"]), [], [])))
            end
          else
            (Mir_Utils.ONE(Mir_Utils.REAL res1),
             Mir_Utils.combine
             (the_code,
              ((Sexpr.ATOM
                (code @ code' @
                 [MirTypes.COMMENT "Unsafe FloatArray subscript operation",
                  MirTypes.BINARY(MirTypes.ASL,
                                  Mir_Utils.reg_from_gp new_reg,
                                  new_reg,
                                  MirTypes.GP_IMM_ANY 1),
                                  (* add extra 0 to int tag 00 in order
                                     to multiply num floats by 8 for num
                                     bytes. *)
                  MirTypes.BINARY(MirTypes.ADDU,
                                  MirTypes.GC_REG MirRegisters.global,
                                  new_reg',
                                  new_reg),
                  MirTypes.STOREFPOP(MirTypes.FLD,
                                     res1,
                                     MirTypes.GC_REG MirRegisters.global,
                                     MirTypes.GP_IMM_ANY 5)]),
              [], NONE, Sexpr.NIL), [], [])))
        end



      fun vector_sub_code (safe,regs,the_code,exn_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[vector, offset] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((vector_reg, code),(offset_reg, code')) =
            case regs of
              Mir_Utils.LIST[vector ,offset] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE vector),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                  val new_reg = MirTypes.GC.new()
                  val new_reg' = MirTypes.GC.new()
                in
                  ((MirTypes.GP_GC_REG new_reg,[MirTypes.STOREOP(MirTypes.LD,
                                    MirTypes.GC_REG new_reg,
                                    Mir_Utils.reg_from_gp reg,
                                    MirTypes.GP_IMM_ANY ~1)]),
                  (MirTypes.GP_GC_REG new_reg',[MirTypes.STOREOP(MirTypes.LD,
                                              MirTypes.GC_REG new_reg',
                                              Mir_Utils.reg_from_gp reg,
                                              MirTypes.GP_IMM_ANY 3)]))
                  end)
            | _ => Crash.impossible "can't code generate the argument given to Vector.sub in _mir_cg"

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val res2 = MirTypes.GP_GC_REG result
        in
          if safe then
	    let
	      val (exn_blocks, exn_tag_list) = exn_code
	      val exn_tag =
		case exn_tag_list
		  of [tag] => tag
		|  _ => Crash.impossible "no exn_tag for Vector.sub"
	      val finish_tag = MirTypes.new_tag()
	      val main_tag = MirTypes.new_tag()
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT res2),
	       Mir_Utils.combine
	       (the_code,
		((Sexpr.ATOM
		  (code @ code' @
		   [MirTypes.COMMENT "Check the subscript range"] @
		(if constantp then
		   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]
                   else
                     [MirTypes.STOREOP
		      (MirTypes.LDREF, MirTypes.GC_REG MirRegisters.global,
		       Mir_Utils.reg_from_gp vector_reg, MirTypes.GP_IMM_ANY ~5),
		      MirTypes.BINARY
		      (MirTypes.LSR, MirTypes.GC_REG MirRegisters.global,
		       MirTypes.GP_GC_REG MirRegisters.global,
		       MirTypes.GP_IMM_ANY 6), (* Length in words *)
		      MirTypes.TEST(MirTypes.BGT, main_tag,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY constant_value),
		      MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]
                 else
		   [MirTypes.STOREOP(MirTypes.LDREF, MirTypes.GC_REG MirRegisters.global,
				     Mir_Utils.reg_from_gp vector_reg,
				     MirTypes.GP_IMM_ANY ~5),
		    MirTypes.BINARY(MirTypes.LSR,MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 4),
		    MirTypes.TEST(MirTypes.BHI, main_tag,
				  MirTypes.GP_GC_REG MirRegisters.global,
				  offset_reg),
		    MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)])
(*
		      [MirTypes.STOREOP(MirTypes.LDREF, MirTypes.GC_REG MirRegisters.global,
					Mir_Utils.reg_from_gp vector_reg,
					MirTypes.GP_IMM_ANY(~5)),
		       MirTypes.BINARY(MirTypes.LSR,MirTypes.GC_REG MirRegisters.global,
				       MirTypes.GP_GC_REG MirRegisters.global,
				       MirTypes.GP_IMM_ANY 4),
		       MirTypes.BINARY(MirTypes.SUBU,MirTypes.GC_REG MirRegisters.global,
				       MirTypes.GP_GC_REG MirRegisters.global,
				       offset_reg),
		       MirTypes.TEST(MirTypes.BGE, main_tag,
				     MirTypes.GP_GC_REG MirRegisters.global,
				     MirTypes.GP_IMM_ANY 4),
		       MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)]
*)
		      ),
		  MirTypes.BLOCK(main_tag,
				 [MirTypes.COMMENT "Vector subscript operation",
				  MirTypes.BINARY(MirTypes.ADDU,
						  MirTypes.GC_REG MirRegisters.global,
						  vector_reg, offset_reg),
				  MirTypes.STOREOP(MirTypes.LD, res1,
						   MirTypes.GC_REG MirRegisters.global,
						   MirTypes.GP_IMM_ANY(~1)),
				  MirTypes.BRANCH(MirTypes.BRA,
						  MirTypes.TAG finish_tag)]) ::
		  exn_blocks, SOME finish_tag,
		  Sexpr.ATOM[MirTypes.COMMENT"End of vector sub"]), [], [])))
	    end
          else
            (* Unsafe code *)
            (Mir_Utils.ONE(Mir_Utils.INT res2),
             Mir_Utils.combine
             (the_code,
              ((Sexpr.ATOM
                (code @ code' @
                 [MirTypes.COMMENT "Unsafe vector subscript operation"] @
                 (if constantp
                    then
                      [MirTypes.STOREOP(MirTypes.LD, res1,
                                        Mir_Utils.reg_from_gp vector_reg,
                                        MirTypes.GP_IMM_ANY((constant_value * 4) - 1))]
                  else
                    [MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG MirRegisters.global,
                                     vector_reg, offset_reg),
                     MirTypes.STOREOP(MirTypes.LD, res1,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY(~1))])),
                [], NONE, Sexpr.NIL), [], [])))
        end



      fun update_code (bytearray,safe,isIntegral,regs,the_code,exn_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[array,offset,value] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((new_reg, code),(new_reg', code'),(new_reg'', code'')) =
            case regs of
              Mir_Utils.LIST[array,offset,value] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE array),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE value))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                   val new_reg = MirTypes.GC.new()
                   val new_reg' = MirTypes.GC.new()
                   val new_reg'' = MirTypes.GC.new()
                in
                   ((MirTypes.GP_GC_REG new_reg,
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg,
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 3)]),
                    (MirTypes.GP_GC_REG new_reg',
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY ~1)]),
                    (MirTypes.GP_GC_REG new_reg'',
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg'',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 7)]))
                 end)
            | _ => Crash.impossible "_mir_cg : update can't code generate\
                                     \ arguments "

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val reg1 = new_reg'
          val scratch = MirTypes.GC.new()
          val scratch_reg = MirTypes.GC_REG scratch
          val forward = MirTypes.GC.new()
          val forward_reg = MirTypes.GC_REG forward
          val backward = MirTypes.GC.new()
          val backward_reg = MirTypes.GC_REG backward
          val unlink_tag = MirTypes.new_tag()
          val modified_tag = MirTypes.new_tag()

          val main_tag = MirTypes.new_tag()
          val finish_tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code

	  val exn_test =
	    if safe then
	      let val exn_tag =
		    case exn_tag_list
	            of [tag] => tag
	            |  _ => Crash.impossible "no exn_tag for update"
	      in
                [MirTypes.COMMENT "Check the subscript range"] @
		(if constantp then
		   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                   else
                     [MirTypes.STOREOP(MirTypes.LDREF,
                                       MirTypes.GC_REG MirRegisters.global,
                                       Mir_Utils.reg_from_gp new_reg',
                                       MirTypes.GP_IMM_ANY ~3),
		      MirTypes.BINARY(MirTypes.LSR,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY 6),
                                                (* Length in words *)
		      MirTypes.TEST(MirTypes.BGT,
                                    main_tag,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY constant_value),
		      MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                 else
(*
		(if constantp then
                   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                   else
                     []
                 else
                   [MirTypes.TEST(MirTypes.BLT,
                                  exn_tag,
                                  new_reg,
		                  MirTypes.GP_IMM_INT 0)]) @
                [MirTypes.STOREOP(MirTypes.LDREF,
                                  MirTypes.GC_REG MirRegisters.global,
                                  Mir_Utils.reg_from_gp new_reg',
                                  MirTypes.GP_IMM_ANY ~3),
                 MirTypes.BINARY(MirTypes.LSR,
                                 MirTypes.GC_REG MirRegisters.global,
                                 MirTypes.GP_GC_REG MirRegisters.global,
                                 MirTypes.GP_IMM_ANY 4),
                 MirTypes.BINARY(MirTypes.SUBU,
                                 MirTypes.GC_REG MirRegisters.global,
                                 MirTypes.GP_GC_REG MirRegisters.global,
                                 new_reg),
                 MirTypes.TEST(MirTypes.BGE,
                               main_tag,
		               MirTypes.GP_GC_REG MirRegisters.global,
		               MirTypes.GP_IMM_ANY 5),
		 (* Note that the 5 includes the left over bit of
		    secondary tag *)
                 MirTypes.BRANCH(MirTypes.BRA,
                                 MirTypes.TAG exn_tag)]
*)
		   [MirTypes.STOREOP(MirTypes.LDREF,
                                     MirTypes.GC_REG MirRegisters.global,
				     Mir_Utils.reg_from_gp new_reg',
				     MirTypes.GP_IMM_ANY ~3),
		    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 4),
		    MirTypes.BINARY(MirTypes.SUBU,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 1),
		    MirTypes.TEST(MirTypes.BHI,
                                  main_tag,
				  MirTypes.GP_GC_REG MirRegisters.global,
				  new_reg),
		    MirTypes.BRANCH(MirTypes.BRA,
                                    MirTypes.TAG exn_tag)])
	      end
            else
              [MirTypes.BRANCH(MirTypes.BRA,
                               MirTypes.TAG main_tag)]

        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @ code' @ code'' @ exn_test),
              MirTypes.BLOCK
               (main_tag,
                let
                  val address = MirTypes.GC.new ()
                in
                  if bytearray then
                    [MirTypes.COMMENT ((if safe then "" else "Unsafe ")
                                       ^ "ByteArray update operation"),
                     MirTypes.BINARY(MirTypes.LSR,
                                     MirTypes.GC_REG address,
                                     new_reg,
                                     MirTypes.GP_IMM_ANY 2),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG address,
                                     MirTypes.GP_GC_REG address,
                                     new_reg'),
                     MirTypes.BINARY(MirTypes.LSR,
                                     MirTypes.GC_REG MirRegisters.global,
                                     new_reg'',
                                     MirTypes.GP_IMM_ANY 2),
                     MirTypes.STOREOP(MirTypes.STB,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GC_REG address,
                                      MirTypes.GP_IMM_ANY 1),
                     MirTypes.NULLARY(MirTypes.CLEAN,
                                      MirTypes.GC_REG address),
                     MirTypes.BRANCH(MirTypes.BRA,
                                     MirTypes.TAG finish_tag)]
                  else
                    [MirTypes.COMMENT ((if safe then "" else "Unsafe ")
                                       ^ "Array update operation"),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG address,
                                     new_reg',
                                     new_reg),
                     MirTypes.STOREOP(MirTypes.STREF,
                                      Mir_Utils.reg_from_gp new_reg'',
                                      MirTypes.GC_REG address,
                                      MirTypes.GP_IMM_ANY 9),
                     MirTypes.NULLARY(MirTypes.CLEAN,
                                      MirTypes.GC_REG address)] @
                    (if isIntegral then
                       [MirTypes.BRANCH(MirTypes.BRA,
                                        MirTypes.TAG finish_tag)]
                     else
                       [MirTypes.COMMENT"Do we need to unlink it",
                        MirTypes.STOREOP(MirTypes.LDREF,
                                         forward_reg,
                                         Mir_Utils.reg_from_gp reg1,
                                         MirTypes.GP_IMM_ANY 1),
                        MirTypes.TEST(MirTypes.BEQ,
                                      finish_tag,
                                      MirTypes.GP_GC_REG forward,
                                      MirTypes.GP_IMM_INT 0),
                        MirTypes.BRANCH(MirTypes.BRA,
                                        MirTypes.TAG unlink_tag)])
                end) ::
               (if isIntegral then
                  exn_blocks
                else
                  MirTypes.BLOCK
                   (unlink_tag,
                    [MirTypes.STOREOP(MirTypes.LDREF,
                                      backward_reg,
                                      Mir_Utils.reg_from_gp reg1,
                                      MirTypes.GP_IMM_ANY 5),
                     MirTypes.TEST(MirTypes.BEQ,
                                   modified_tag,
                                   MirTypes.GP_GC_REG backward,
                                   MirTypes.GP_IMM_INT 0),
                     MirTypes.COMMENT "Unlink the cell",
                     MirTypes.STOREOP(MirTypes.STREF,
                                      backward_reg,
                                      forward_reg,
                                      MirTypes.GP_IMM_ANY 8),
                     MirTypes.STOREOP(MirTypes.STREF,
                                      forward_reg,
                                      backward_reg,
                                      MirTypes.GP_IMM_ANY 4),
                     MirTypes.BRANCH(MirTypes.BRA,
                                     MirTypes.TAG modified_tag)]) ::
                 MirTypes.BLOCK
                  (modified_tag,
                   [MirTypes.UNARY(MirTypes.MOVE,
                                   scratch_reg,
                                   MirTypes.GP_IMM_INT 0),
                    MirTypes.STOREOP(MirTypes.STREF,
                                     scratch_reg,
                                     Mir_Utils.reg_from_gp reg1,
                                     MirTypes.GP_IMM_ANY 1),
                    MirTypes.STOREOP(MirTypes.LDREF,
                                     scratch_reg,
                                     MirTypes.GC_REG MirRegisters.implicit,
                                     MirTypes.GP_IMM_ANY
                                               Implicit_Vector.ref_chain),
                    MirTypes.STOREOP(MirTypes.STREF,
                                     scratch_reg,
                                     Mir_Utils.reg_from_gp reg1,
                                     MirTypes.GP_IMM_ANY 5),
                    MirTypes.BINARY(MirTypes.ADDU,
                                    MirTypes.GC_REG MirRegisters.global,
                                    reg1,
                                    MirTypes.GP_IMM_ANY ~3),
                    MirTypes.STOREOP(MirTypes.STREF,
                                     MirTypes.GC_REG MirRegisters.global,
                                     MirTypes.GC_REG MirRegisters.implicit,
                                     MirTypes.GP_IMM_ANY
                                               Implicit_Vector.ref_chain),
                    MirTypes.BRANCH(MirTypes.BRA,
                                    MirTypes.TAG finish_tag)]) ::
                 exn_blocks),
                 SOME finish_tag,
                 Sexpr.ATOM[MirTypes.UNARY(MirTypes.MOVE,
                                           res1,
                                           MirTypes.GP_IMM_INT 0)]), [], [])))
        end


      (* see <URI:MLW/src/floatarray.doc> for an explanation of
         the implementation of floatarrays. *)

      fun floatarray_update_code (safe,regs,the_code,exn_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[array,offset,value] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((new_reg, code),(new_reg', code'),(float_reg, code'')) =
            case regs of
              Mir_Utils.LIST[array,offset,Mir_Utils.REAL fp_op] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE array),
                 (fp_op,[]))
            | Mir_Utils.LIST[array,offset,
                             Mir_Utils.INT(MirTypes.GP_GC_REG reg)] =>
                let val float_reg = MirTypes.FP_REG(MirTypes.FP.new())
                in
                 (Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                  Mir_Utils.send_to_new_reg(Mir_Utils.ONE array),
                  (float_reg,
                   [MirTypes.STOREFPOP(MirTypes.FLD,
                                       float_reg,
                                       MirTypes.GC_REG reg,
                                       MirTypes.GP_IMM_ANY real_offset)]))
                end
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                   val new_reg = MirTypes.GC.new()
                   val new_reg' = MirTypes.GC.new()
                   val float_reg = MirTypes.FP.new()
                in
                   ((MirTypes.GP_GC_REG new_reg,
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg,
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 3)]),
                    (MirTypes.GP_GC_REG new_reg',
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY ~1)]),
                    (MirTypes.FP_REG float_reg,
                     [MirTypes.STOREFPOP(MirTypes.FLD,
                                       MirTypes.FP_REG float_reg,
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 7)]))
                 end)
            | _ => Crash.impossible "_mir_cg : update can't code generate\
                                     \ arguments "

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val reg1 = new_reg'
          val scratch = MirTypes.GC.new()
          val scratch_reg = MirTypes.GC_REG scratch
          val forward = MirTypes.GC.new()
          val forward_reg = MirTypes.GC_REG forward
          val backward = MirTypes.GC.new()
          val backward_reg = MirTypes.GC_REG backward
          val unlink_tag = MirTypes.new_tag()
          val modified_tag = MirTypes.new_tag()

          val main_tag = MirTypes.new_tag()
          val finish_tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code

	  val exn_test =
	    if safe then
	      let val exn_tag =
		    case exn_tag_list
	            of [tag] => tag
	            |  _ => Crash.impossible "no exn_tag for floatarray_update"
	      in
                [MirTypes.COMMENT "Check the subscript range"] @
		(if constantp then
		   if constant_value < 0 then
                     [MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                   else
                     [MirTypes.STOREOP(MirTypes.LDREF,
                                       MirTypes.GC_REG MirRegisters.global,
                                       Mir_Utils.reg_from_gp new_reg',
                                       MirTypes.GP_IMM_ANY ~3),
		      MirTypes.BINARY(MirTypes.LSR,
                                      MirTypes.GC_REG MirRegisters.global,
                                      MirTypes.GP_GC_REG MirRegisters.global,
                                      MirTypes.GP_IMM_ANY 9),
                                                  (* remove 6 header bits
                                                     for number of bytes, then
                                                     divide by 8 (shift 3 bits)
                                                     for number of floats *)
		      MirTypes.TEST(MirTypes.BGT,
                                    main_tag,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY constant_value),
		      MirTypes.BRANCH(MirTypes.BRA,
                                      MirTypes.TAG exn_tag)]
                 else
		   [MirTypes.STOREOP(MirTypes.LDREF,
                                     MirTypes.GC_REG MirRegisters.global,
				     Mir_Utils.reg_from_gp new_reg',
				     MirTypes.GP_IMM_ANY ~3),
                                     (* 3 is tag of reference pointer. *)
		    MirTypes.BINARY(MirTypes.LSR,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 9),
		    MirTypes.BINARY(MirTypes.ASL,
                                    MirTypes.GC_REG MirRegisters.global,
				    MirTypes.GP_GC_REG MirRegisters.global,
				    MirTypes.GP_IMM_ANY 3),
                                    (* remove the header bits.  Gives
                                       size of array *in bytes*. note
                                       that shifing right by 9 and then
                                       shifting left by 3 removes the
                                       4 bytes associated with the dummy
                                       word. *)
(*                    MirTypes.BINARY(MirTypes.ASL,
                                    Mir_Utils.reg_from_gp new_reg,
                                    new_reg,
                                    MirTypes.GP_IMM_ANY 1),
                                    (* cunning hack: since new_reg is an
                                       integer, its lower two bits will
                                       be 00.  Shifting it left one more
                                       will mean new_reg will be a number
                                       8 times the size of the offset ---
                                       i.e., the number of bytes from
                                       beginning of array. *)*)
                    MirTypes.TEST(MirTypes.BHI,
                                  main_tag,
                                  MirTypes.GP_GC_REG MirRegisters.global,
                                  new_reg),
                    MirTypes.BRANCH(MirTypes.BRA,
                                    MirTypes.TAG exn_tag)])
              end
            else
              [MirTypes.BRANCH(MirTypes.BRA,
                               MirTypes.TAG main_tag)]

        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @
                [MirTypes.BINARY(MirTypes.ASL,
                                 Mir_Utils.reg_from_gp new_reg,
                                 new_reg,
                                 MirTypes.GP_IMM_ANY 1)
                 (* cunning hack: since new_reg is an integer, its lower
                    two bits will be 00.  Shifting it left one more will
                    mean new_reg will be a number 8 times the size of the
                    offset --- i.e., the number of bytes from beginning
                    of array. *)] @
               code' @ code'' @ exn_test),
              MirTypes.BLOCK
               (main_tag,
                let
                  val address = MirTypes.GC.new ()
                in
                    [MirTypes.COMMENT ((if safe then "" else "Unsafe ")
                                       ^ "FloatArray update operation"),
                     MirTypes.BINARY(MirTypes.ADDU,
                                     MirTypes.GC_REG address,
                                     new_reg',
                                     new_reg),
                     MirTypes.STOREFPOP(MirTypes.FST,
                                        float_reg,
                                        MirTypes.GC_REG address,
                                        MirTypes.GP_IMM_ANY 5),
                             (* the address is a ptr, which means it has
                                an extra 3 tag, i.e., it pts to an address
                                3 bytes into the header.  To maintain
                                double word alignment, we have to pad
                                an extra dummy word between the header
                                and the first float.  Hence we add 5 offset
                                to pt to the start of the 3rd word (the 1st
                                actual float *)
                     MirTypes.NULLARY(MirTypes.CLEAN,
                                      MirTypes.GC_REG address),
                     MirTypes.BRANCH(MirTypes.BRA,
                                     MirTypes.TAG finish_tag)]
                end) ::
               exn_blocks,
            SOME finish_tag,
            Sexpr.ATOM[MirTypes.UNARY(MirTypes.MOVE,
                                      res1,
                                      MirTypes.GP_IMM_INT 0)]), [], [])))
        end



      fun string_unsafe_update_code (regs,the_code) =
        let
          val (constantp,constant_value) =
            case regs of
              Mir_Utils.LIST[array,offset,value] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          val ((string_reg, code),(offset_reg, code'),(value_reg, code'')) =
            case regs of
              Mir_Utils.LIST[string,offset,value] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE string),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE value))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                   val new_reg = MirTypes.GC.new()
                   val new_reg' = MirTypes.GC.new()
                   val new_reg'' = MirTypes.GC.new()
                in
                   ((MirTypes.GP_GC_REG new_reg,
                     [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY ~1)]),
                    (MirTypes.GP_GC_REG new_reg',
                     [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 3)]),
                    (MirTypes.GP_GC_REG new_reg'',
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg'',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 7)]))
                 end)
            | _ => Crash.impossible "_mir_cg : string update can't code generate arguments "

          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val reg1 = offset_reg
          val address = MirTypes.GC.new ()
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @ code' @ code'' @
               [MirTypes.COMMENT ("Unsafe string update operation"),
                MirTypes.BINARY(MirTypes.LSR, MirTypes.GC_REG address,
                                offset_reg, MirTypes.GP_IMM_ANY 2),
                MirTypes.BINARY(MirTypes.ADDU, MirTypes.GC_REG address,
                                MirTypes.GP_GC_REG address, string_reg),
                MirTypes.BINARY(MirTypes.LSR, MirTypes.GC_REG MirRegisters.global,
                                value_reg, MirTypes.GP_IMM_ANY 2),
                MirTypes.STOREOP(MirTypes.STB, MirTypes.GC_REG MirRegisters.global,
                                 MirTypes.GC_REG address, MirTypes.GP_IMM_ANY ~1),
                MirTypes.NULLARY(MirTypes.CLEAN, MirTypes.GC_REG address),
                MirTypes.UNARY(MirTypes.MOVE, res1, MirTypes.GP_IMM_INT 0)]),
              [],
              NONE,
              Sexpr.NIL), [], [])))
        end

      fun record_unsafe_update_code (regs,the_code) =
        let
          (* Is the offset a constant *)
          val (constantp,offset_value) =
            case regs of
              Mir_Utils.LIST[array,offset,value] =>
                (case offset of
                   Mir_Utils.INT(MirTypes.GP_IMM_INT v) => (true,v)
                 | _ => (false,0))
            | _ => (false,0)

          (* Move the stuff into registers *)
          val ((vector_reg, code),(offset_reg, code'),(value_reg, code'')) =
            case regs of
              Mir_Utils.LIST[vector,offset,value] =>
                (Mir_Utils.send_to_new_reg(Mir_Utils.ONE vector),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE offset),
                 Mir_Utils.send_to_new_reg(Mir_Utils.ONE value))
            | Mir_Utils.ONE(Mir_Utils.INT(reg)) =>
                (let
                   val new_reg = MirTypes.GC.new()
                   val new_reg' = MirTypes.GC.new()
                   val new_reg'' = MirTypes.GC.new()
                in
                   ((MirTypes.GP_GC_REG new_reg,
                     [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY ~1)]),
                    (MirTypes.GP_GC_REG new_reg',
                     [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 3)]),
                    (MirTypes.GP_GC_REG new_reg'',
                     [MirTypes.STOREOP(MirTypes.LD,
                                       MirTypes.GC_REG new_reg'',
                                       Mir_Utils.reg_from_gp reg,
                                       MirTypes.GP_IMM_ANY 7)]))
                 end)
            | _ => Crash.impossible "_mir_cg : update can't code generate arguments "

          val result = MirTypes.GC.new()
          val address = MirTypes.GC.new ()

        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
           (the_code,
            ((Sexpr.ATOM
              (code @ code' @ code'' @
               [MirTypes.COMMENT ("Unsafe vector update operation")] @
               (if constantp
                  then
                    [MirTypes.STOREOP(MirTypes.STREF,
                                      Mir_Utils.reg_from_gp value_reg,
                                      Mir_Utils.reg_from_gp vector_reg,
                                      MirTypes.GP_IMM_ANY ((4 * offset_value) - 1))]
                else
                  [MirTypes.BINARY(MirTypes.ADDU,
                                   MirTypes.GC_REG address, offset_reg,
                                   vector_reg),
                   MirTypes.STOREOP(MirTypes.STREF,
                                    Mir_Utils.reg_from_gp value_reg,
                                    MirTypes.GC_REG address,
                                    MirTypes.GP_IMM_ANY ~1),
                   MirTypes.NULLARY(MirTypes.CLEAN,
                                    MirTypes.GC_REG address)]) @
               [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG result, MirTypes.GP_IMM_INT 0)]),
              [],
              NONE,
              Sexpr.NIL), [], [])))
        end

      fun do_ml_call (regs,the_code) =
	  let
	    val res = MirTypes.GC.new()
            val scratch_reg = MirTypes.GC_REG (MirTypes.GC.new ())
	    val opcodes = Sexpr.ATOM (Mir_Utils.send_to_given_reg(regs, caller_arg))
	    val call_code =
	      Sexpr.ATOM
	      ([MirTypes.UNARY(MirTypes.MOVE,
			       MirTypes.GC_REG caller_closure,
			       MirTypes.GP_GC_REG caller_arg),
		MirTypes.STOREOP(MirTypes.LD, scratch_reg,
				 MirTypes.GC_REG caller_closure,
				 MirTypes.GP_IMM_ANY ~1),
		MirTypes.BRANCH_AND_LINK(MirTypes.BLR,
					 MirTypes.REG scratch_reg,
                                         Debugger_Types.null_backend_annotation,
                                         [MirTypes.GC caller_arg]),
		MirTypes.UNARY(MirTypes.MOVE,
			       MirTypes.GC_REG res,
			       MirTypes.GP_GC_REG caller_arg)])
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res)),
	     Mir_Utils.combine(the_code,
			       ((Sexpr.CONS(opcodes, call_code), [],
				 NONE, Sexpr.NIL), [], [])))
	  end

      fun do_ref (regs,the_code) =
        let
          val scratch = MirTypes.GC.new()
          val scratch_reg = MirTypes.GC_REG scratch
          val (new_reg, code) = Mir_Utils.send_to_reg(regs)
          val result = MirTypes.GC.new()
          val res1 = MirTypes.GC_REG result
          val work1 = MirTypes.GC_REG(MirTypes.GC.new ())
          val work2 = MirTypes.GC_REG(MirTypes.GC.new ())
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine(the_code,
                             ((Sexpr.ATOM(code @
                                          [MirTypes.ALLOCATE(MirTypes.ALLOC_REF, res1, MirTypes.GP_IMM_INT 1),
                                           MirTypes.COMMENT"Allocate a ref cell",
                                           MirTypes.STOREOP(MirTypes.STREF, Mir_Utils.reg_from_gp new_reg, res1,
                                                            MirTypes.GP_IMM_ANY 9),
                                           MirTypes.UNARY(MirTypes.MOVE, work1, MirTypes.GP_IMM_ANY 0),
                                           MirTypes.STOREOP(MirTypes.STREF, work1, res1, MirTypes.GP_IMM_ANY 5),
                                           MirTypes.UNARY(MirTypes.MOVE, work2, MirTypes.GP_IMM_INT 1),
                                           MirTypes.STOREOP(MirTypes.STREF, work2, res1, MirTypes.GP_IMM_ANY 1),
                                           MirTypes.COMMENT"Initialise the other pointers"]),
                             [], NONE, Sexpr.NIL), [], [])))
        end

      fun do_ml_offset (regs,the_code) =
	  let
	    val (reg1, reg2, code) =
             case regs of
	      Mir_Utils.LIST[Mir_Utils.INT reg1, Mir_Utils.INT reg2] =>
		(reg1, reg2, [])
	    | Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
		let
		  val reg1 = MirTypes.GC.new()
		  val reg2 = MirTypes.GC.new()
		  val gc_reg = MirTypes.GC_REG reg
		in
		  (MirTypes.GP_GC_REG reg1, MirTypes.GP_GC_REG reg2,
		   [MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG reg1,
				     gc_reg, MirTypes.GP_IMM_ANY ~1),
		    MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG reg2,
				     gc_reg, MirTypes.GP_IMM_ANY 3)])
		end
	    | _ => Crash.impossible"Mir_Cg bad args for ML_OFFSET"
	    val reg = MirTypes.GC.new()
	    val gc_reg = MirTypes.GC_REG reg
	    val gp_gc_reg = MirTypes.GP_GC_REG reg
	    val op_code =
	      [MirTypes.BINARY(MirTypes.LSR, gc_reg, reg2,
			       MirTypes.GP_IMM_ANY 2),
	       MirTypes.BINARY(MirTypes.ADDU, gc_reg, reg1, gp_gc_reg)]
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT gp_gc_reg),
	     Mir_Utils.combine(the_code,
			       ((Sexpr.ATOM(code @ op_code), [],
				 NONE, Sexpr.NIL), [], [])))
	  end

          fun do_becomes (isIntegral,regs,the_code) =
	  let
            val scratch = MirTypes.GC.new()
            val scratch_reg = MirTypes.GC_REG scratch
            val forward = MirTypes.GC.new()
            val forward_reg = MirTypes.GC_REG forward
            val backward = MirTypes.GC.new()
            val backward_reg = MirTypes.GC_REG backward
	    val unlink_tag = MirTypes.new_tag()
	    val modified_tag = MirTypes.new_tag()
	    val already_on_ref_chain_tag = MirTypes.new_tag()
            val result = MirTypes.GC.new()
	    val res1 = MirTypes.GP_GC_REG result
	    val res2 = MirTypes.GC_REG result
	    val (reg1, arg, new_code) =
	      case regs of
		Mir_Utils.ONE(Mir_Utils.INT reg) => Mir_Utils.destruct_2_tuple reg
	      | Mir_Utils.LIST[Mir_Utils.INT reg1, arg] =>
		  let
		    val (new_reg, code) = Mir_Utils.send_to_reg(Mir_Utils.ONE arg)
		  in
		    (reg1, new_reg, code)
		  end
	    | _ => Crash.impossible"BECOMES of bad parms"
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT res1),
	     Mir_Utils.combine(the_code,
		     ((Sexpr.ATOM(new_code @
		       [MirTypes.COMMENT"Update a reference cell",
                        MirTypes.STOREOP(MirTypes.STREF,
					 Mir_Utils.reg_from_gp arg,
                                         Mir_Utils.reg_from_gp reg1,
					 MirTypes.GP_IMM_ANY 9)] @
		       (if isIntegral then
			  [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG already_on_ref_chain_tag)]
			else
                        [MirTypes.COMMENT"Do we need to unlink it",
                         MirTypes.STOREOP(MirTypes.LDREF, forward_reg,
					  Mir_Utils.reg_from_gp reg1,
					  MirTypes.GP_IMM_ANY 1),
			 MirTypes.TEST(MirTypes.BEQ, already_on_ref_chain_tag,
				       MirTypes.GP_GC_REG forward,
				       MirTypes.GP_IMM_INT 0),
			 MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG unlink_tag)])),
		       (if isIntegral then [] else
			 [MirTypes.BLOCK(unlink_tag,
                                       [MirTypes.STOREOP(MirTypes.LDREF, backward_reg,
                                                         Mir_Utils.reg_from_gp reg1,
                                                         MirTypes.GP_IMM_ANY 5),
                                       MirTypes.TEST(MirTypes.BEQ, modified_tag,
                                                     MirTypes.GP_GC_REG backward,
                                                     MirTypes.GP_IMM_INT 0),
                                       MirTypes.COMMENT "Unlink the cell",
                                        MirTypes.STOREOP(MirTypes.STREF, backward_reg,
                                                         forward_reg,
                                                         MirTypes.GP_IMM_ANY 8),
                                        MirTypes.STOREOP(MirTypes.STREF, forward_reg,
                                                         backward_reg,
                                                         MirTypes.GP_IMM_ANY 4),
                                        MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG modified_tag)]),
                         MirTypes.BLOCK(modified_tag,
                                      [MirTypes.UNARY(MirTypes.MOVE, scratch_reg, MirTypes.GP_IMM_INT 0),
                                       MirTypes.STOREOP(MirTypes.STREF,
                                                        scratch_reg,
                                                        Mir_Utils.reg_from_gp reg1,
                                                        MirTypes.GP_IMM_ANY 1),
                                       MirTypes.STOREOP(MirTypes.LDREF, scratch_reg,
                                                        MirTypes.GC_REG MirRegisters.implicit,
                                                        MirTypes.GP_IMM_ANY Implicit_Vector.ref_chain),
                                       MirTypes.STOREOP(MirTypes.STREF, scratch_reg,
                                                        Mir_Utils.reg_from_gp reg1,
                                                        MirTypes.GP_IMM_ANY 5),
                                       MirTypes.BINARY(MirTypes.ADDU, MirTypes.GC_REG MirRegisters.global,
                                                       reg1,
                                                       MirTypes.GP_IMM_ANY ~3),
                                       MirTypes.STOREOP(MirTypes.STREF,
                                                        MirTypes.GC_REG MirRegisters.global,
                                                        MirTypes.GC_REG MirRegisters.implicit,
                                                        MirTypes.GP_IMM_ANY Implicit_Vector.ref_chain),
                                        MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG already_on_ref_chain_tag)])]),
                       SOME already_on_ref_chain_tag,
                       Sexpr.ATOM[MirTypes.UNARY(MirTypes.MOVE, res2, MirTypes.GP_IMM_INT 0),
			MirTypes.COMMENT"Dummy result"]), [], [])))
	  end

          fun do_deref (regs,the_code) =
	  (case regs of
	    Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
	      let
		val result = MirTypes.GC.new()
		val res1 = MirTypes.GC_REG result
	      in
		(Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
		  Mir_Utils.combine(the_code,
		    ((Sexpr.ATOM [MirTypes.STOREOP(MirTypes.LDREF, res1,
					MirTypes.GC_REG reg,
					MirTypes.GP_IMM_ANY 9),
		      MirTypes.COMMENT"Dereference a ref cell"],
		  [], NONE, Sexpr.NIL), [], [])))
	      end
          | _ => Crash.impossible"DEREF of non-gc")

          fun do_floor (regs,the_code,exn_code) =
	  let
	    val result = MirTypes.GC.new()
	    val result_gp = MirTypes.GP_GC_REG result
	    val result_reg = MirTypes.GC_REG result
	    val (exn_blocks, exn_tag_list) = exn_code
	    val exn_tag =
	      case exn_tag_list
	      of [tag] => tag
	      |  _ => Crash.impossible "no exn_tag for floor"
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT result_gp),
	      Mir_Utils.combine(the_code,
		(((case regs of
		  Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
		    let
		      val fp_op = MirTypes.FP_REG(MirTypes.FP.new())
		    in
		      Sexpr.ATOM[MirTypes.STOREFPOP(MirTypes.FLD, fp_op,
					  MirTypes.GC_REG reg,
					  MirTypes.GP_IMM_ANY real_offset),
		        MirTypes.FLOOR(MirTypes.FTOI, exn_tag, result_reg,
				       fp_op)]
		    end
		| Mir_Utils.ONE(Mir_Utils.REAL reg) =>
		    Sexpr.ATOM[MirTypes.FLOOR(MirTypes.FTOI, exn_tag, result_reg, reg)]
		| _ => Crash.impossible"FLOOR bad value"),
		  exn_blocks, NONE, Sexpr.NIL), [], [])))
	  end

          fun do_real (regs,the_code) =
	  let
	    val result = MirTypes.FP_REG(MirTypes.FP.new())
	  in
	    (Mir_Utils.ONE(Mir_Utils.REAL result),
	     Mir_Utils.combine(the_code,
	       (((case regs of
		 Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_GC_REG _)) =>
		   Sexpr.ATOM[MirTypes.REAL(MirTypes.ITOF, result,
				  arg)]
	       | Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_IMM_INT _)) =>
		   Sexpr.ATOM[MirTypes.REAL(MirTypes.ITOF, result,
				    arg)]
	       | Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_IMM_SYMB _)) =>
		   Sexpr.ATOM[MirTypes.REAL(MirTypes.ITOF, result,
				    arg)]
	       | _ => Crash.impossible"convert of non-gc"),
		  [], NONE, Sexpr.NIL), [], [])))
	  end

      fun do_size (regs,the_code) =
	let
	  val (_, result, code) = make_size_code regs
	in
	  (Mir_Utils.ONE(Mir_Utils.INT result),
	   Mir_Utils.combine(the_code,
			     ((Sexpr.ATOM code, [], NONE,
			       Sexpr.NIL), [], [])))
	end
      fun do_char_chr(regs, the_code, exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (exn_blocks, exn_tag_list) = exn_code
	  val exn_tag =
	    case exn_tag_list
	    of [tag] => tag
	    |  _ => Crash.impossible "no exn_tag for chr"
	in
	  case regs of
	    Mir_Utils.ONE(Mir_Utils.INT reg) =>
	    let
	      val (new_reg, code) = Mir_Utils.send_to_reg(regs)
	      val byte_reg = MirTypes.GC.new()
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT res1), Mir_Utils.combine(the_code,
		((Sexpr.ATOM(code @
		  [MirTypes.TEST(MirTypes.BLT, exn_tag, new_reg,
				 MirTypes.GP_IMM_INT 0),
                   MirTypes.TEST(MirTypes.BGT, exn_tag, new_reg,
				MirTypes.GP_IMM_INT 255),
		  MirTypes.COMMENT"Fail if out of range 0 <= x <= 255",
		  MirTypes.ALLOCATE(MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 2),
		  MirTypes.UNARY(MirTypes.MOVE, res2, new_reg)]), exn_blocks,
		NONE, Sexpr.NIL), [], [])))
	    end
	  | _ => Crash.impossible"do_char_chr"
	end

      fun do_chr (regs,the_code,exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val (exn_blocks, exn_tag_list) = exn_code
	  val exn_tag =
	    case exn_tag_list
	    of [tag] => tag
	    |  _ => Crash.impossible "no exn_tag for chr"
	in
	  case regs of
	    Mir_Utils.ONE(Mir_Utils.INT reg) =>
	    let
	      val (new_reg, code) = Mir_Utils.send_to_reg(regs)
	      val byte_reg = MirTypes.GC.new()
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT res1), Mir_Utils.combine(the_code,
		((Sexpr.ATOM(code @
		  [MirTypes.TEST(MirTypes.BLT, exn_tag, new_reg,
				 MirTypes.GP_IMM_INT 0),
                   MirTypes.TEST(MirTypes.BGT, exn_tag, new_reg,
				MirTypes.GP_IMM_INT 255),
		  MirTypes.COMMENT"Fail if out of range 0 <= x <= 255",
		  MirTypes.ALLOCATE(MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 2),
		  (* Allow space for null termination of string *)
                  MirTypes.UNARY(MirTypes.MOVE,MirTypes.GC_REG byte_reg,MirTypes.GP_IMM_ANY 0),
                  MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG byte_reg, res2,
                                   MirTypes.GP_IMM_ANY ~1),
		  MirTypes.BINARY(MirTypes.LSR,MirTypes.GC_REG byte_reg,
                                  new_reg,MirTypes.GP_IMM_ANY 2),
                  MirTypes.STOREOP(MirTypes.STB, MirTypes.GC_REG byte_reg, res2,
                                   MirTypes.GP_IMM_ANY ~1),
		  MirTypes.NULLARY(MirTypes.CLEAN, MirTypes.GC_REG byte_reg)
		  ]), exn_blocks,
		NONE, Sexpr.NIL), [], [])))
	    end
	  | _ => Crash.impossible"do_chr"
	end

      fun do_ord  (regs,the_code,exn_code) =
	let
	  val (the_ptr, the_size, code) = make_size_code regs
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GC_REG result
	  val res2 = MirTypes.GP_GC_REG result
	  val (exn_blocks, exn_tag_list) = exn_code
	  val exn_tag =
	    case exn_tag_list
	    of [tag] => tag
	    |  _ => Crash.impossible "no exn_tag for ord"
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res2),
	   Mir_Utils.combine(the_code,
		   ((Sexpr.ATOM(code @
		     [MirTypes.TEST(MirTypes.BLE, exn_tag, the_size,
				    MirTypes.GP_IMM_INT 0),
		      MirTypes.STOREOP(MirTypes.LDB, res1, the_ptr,
				       MirTypes.GP_IMM_ANY ~1),
                      MirTypes.BINARY(MirTypes.ASL, res1,res2, MirTypes.GP_IMM_ANY 2)]),
		     exn_blocks, NONE, Sexpr.NIL), [], [])))
	end

      fun do_ordof (safe,regs,the_code,exn_code) =
	let
	  val (string, offset, new_code) = get_int_pair regs
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GC_REG result
	  val res2 = MirTypes.GP_GC_REG result
	  val (is_constant, constant_value) =
	    case offset of
	      MirTypes.GP_IMM_INT x => (true, x)
	    | _ => (false, 0)
	in
          if safe
            then
              let
                val (exn_blocks, exn_tag_list) = exn_code
                val exn_tag =
                  case exn_tag_list
                    of [tag] => tag
                     |  _ => Crash.impossible "no exn_tag for ordof"
              in
                if is_constant andalso constant_value < 0 then
                  (Mir_Utils.ONE(Mir_Utils.INT res2),
                   Mir_Utils.combine(the_code,
                                     ((Sexpr.ATOM[MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG exn_tag)],
                                       exn_blocks, NONE, Sexpr.NIL),
                                      [], [])))
                else
                  let
                    val (the_ptr, the_size, code) =
                      make_size_code(Mir_Utils.ONE(Mir_Utils.INT string))
                    val final_instructions =
                      case offset of
                        MirTypes.GP_IMM_INT i =>
                          [MirTypes.STOREOP(MirTypes.LDB, res1, the_ptr,
                                            MirTypes.GP_IMM_ANY(i-1)),
                           MirTypes.BINARY(MirTypes.ASL, res1,res2,
                                           MirTypes.GP_IMM_ANY 2)]
                      | reg as MirTypes.GP_GC_REG _ =>
                          [MirTypes.TEST(MirTypes.BGT, exn_tag,
                                         MirTypes.GP_IMM_INT 0, reg),
                           MirTypes.BINARY(MirTypes.LSR, res1, reg,
                                           MirTypes.GP_IMM_ANY 2),
                           MirTypes.BINARY(MirTypes.ADDU, res1, res2,
                                           Mir_Utils.gp_from_reg the_ptr),
                           MirTypes.STOREOP(MirTypes.LDB, res1, res1,
                                            MirTypes.GP_IMM_ANY ~1),
                           MirTypes.BINARY(MirTypes.ASL, res1,res2,
                                           MirTypes.GP_IMM_ANY 2)]
                      | _ => Crash.impossible"Bad args for ordof"
                  in
                    (Mir_Utils.ONE(Mir_Utils.INT res2),
                     Mir_Utils.combine(the_code,
                                       ((Sexpr.ATOM(new_code @ code @
                                                    (MirTypes.TEST(MirTypes.BLE,exn_tag,the_size,offset) ::
                                                     final_instructions)),
                                       exn_blocks, NONE, Sexpr.NIL), [], [])))
                  end
              end
          else
            let
              val string_reg = Mir_Utils.reg_from_gp string
              val final_instructions =
                case offset of
                  MirTypes.GP_IMM_INT i =>
                    [MirTypes.STOREOP(MirTypes.LDB, res1, string_reg,
                                      MirTypes.GP_IMM_ANY(i-1)),
                     MirTypes.BINARY(MirTypes.ASL, res1,res2,
                                     MirTypes.GP_IMM_ANY 2)]
                | reg as MirTypes.GP_GC_REG _ =>
                    [MirTypes.BINARY(MirTypes.LSR, res1, reg,
                                     MirTypes.GP_IMM_ANY 2),
                     MirTypes.BINARY(MirTypes.ADDU, res1, res2,string),
                     MirTypes.STOREOP(MirTypes.LDB, res1, res1,MirTypes.GP_IMM_ANY ~1),
                     MirTypes.BINARY(MirTypes.ASL, res1,res2,MirTypes.GP_IMM_ANY 2)]
                | _ => Crash.impossible"Bad args for ordof"
            in
              (Mir_Utils.ONE(Mir_Utils.INT res2),
               Mir_Utils.combine(the_code,
                                 ((Sexpr.ATOM(new_code @ final_instructions),
                                   [], NONE, Sexpr.NIL), [], [])))
            end
        end

      fun do_intabs (regs,the_code,exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code
	  val opcode = MirTypes.SUBS
	in
	  case regs of
	    Mir_Utils.ONE(Mir_Utils.INT reg) =>
	      (Mir_Utils.ONE(Mir_Utils.INT res1), Mir_Utils.combine(the_code,
	        ((Sexpr.ATOM[MirTypes.UNARY(MirTypes.MOVE, res2, reg),
		  MirTypes.TEST(MirTypes.BGE, tag, reg, MirTypes.GP_IMM_INT 0),
		  MirTypes.TBINARY(opcode, exn_tag_list, res2,
				   MirTypes.GP_IMM_INT 0, reg),
                   MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG tag)], exn_blocks,
		  SOME tag,
		  Sexpr.ATOM[MirTypes.COMMENT"End of intabs"]), [], [])))
	  | _ => Crash.impossible"do_intabs"
	end

      (* This doesn't clean the argument register in the exceptional case,
	 because the exception is handled by trapping. *)
      fun do_int32abs (Mir_Utils.ONE(Mir_Utils.INT reg), the_code, exn_code) =
	let
	  val result = MirTypes.GC.new()
	  val res1 = MirTypes.GP_GC_REG result
	  val res2 = MirTypes.GC_REG result
	  val tag = MirTypes.new_tag()
	  val (exn_blocks, exn_tag_list) = exn_code
	  val opcode = MirTypes.SUB32S
          val (w, arg_code, clean_arg_code) =
	    Mir_Utils.get_word32 (Mir_Utils.INT reg)
	  val tmp = MirTypes.GC.new()
	  val tmp2 = MirTypes.GC_REG tmp
	  val new_code =
	    arg_code @
	    [MirTypes.UNARY(MirTypes.MOVE, res2, reg),
	     MirTypes.TEST(MirTypes.BGE, tag, w, MirTypes.GP_IMM_INT 0),
	     MirTypes.TBINARY
	     (opcode, exn_tag_list, tmp2, MirTypes.GP_IMM_INT 0, w)] @
	    Mir_Utils.save_word32_in_reg(tmp, result) @
	    [MirTypes.NULLARY(MirTypes.CLEAN, tmp2),
	     MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG tag)]
	in
	  (Mir_Utils.ONE(Mir_Utils.INT res1),
	   Mir_Utils.combine
	     (the_code,
	      ((Sexpr.ATOM new_code,
	        exn_blocks,
	        SOME tag,
	        Sexpr.ATOM clean_arg_code),
	       [], [])))
	end
	| do_int32abs _ = Crash.impossible "do_int32abs"

      fun do_call_c (regs,the_code) =
        let
          val res_reg = MirTypes.GC.new()
          fun make_args_for_call_c arg =
            let
              val get_result =
                [MirTypes.CALL_C,
                 MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG res_reg,
                                MirTypes.GP_GC_REG caller_arg),
                 MirTypes.COMMENT"And acquire result"]
            in
              case arg of
                Mir_Utils.ONE (Mir_Utils.INT(reg)) =>
                  MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG caller_arg, reg) ::
                  get_result
              | _ => Crash.impossible "Bad arguments to make_args_for_call_c"
            end
        in
          (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res_reg)),
           Mir_Utils.combine (the_code,
                              ((Sexpr.ATOM(make_args_for_call_c regs), [],
                                NONE, Sexpr.NIL),
                               [], [])))
        end

      fun do_cast_code (regs,the_code) = (regs,the_code)

      fun do_notb (regs,the_code) =
          let
            val (new_reg,code) =
	      Mir_Utils.send_to_new_reg regs
	      (*
              case regs of
                (arg as Mir_Utils.ONE(_)) => Mir_Utils.send_to_new_reg arg
              | _ => Crash.impossible "Not applied to more than one argument"
	      *)
            val result = MirTypes.GC.new()
          in
	    (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
             Mir_Utils.combine(the_code,
                     ((Sexpr.ATOM(code @ [MirTypes.UNARY(MirTypes.NOT,MirTypes.GC_REG result,new_reg)]),
                       [],NONE,Sexpr.NIL),
                      [],[])))
          end

      fun word32_notb (regs,the_code) =
        let
          val (new_reg, arg_code, clean_arg_code) =
            case regs of
              (arg as Mir_Utils.ONE(reg)) => Mir_Utils.get_word32 reg
            | _ => Crash.impossible "Not32 applied to more than one argument"

          val result = MirTypes.GC.new()
          val res2 = MirTypes.GC_REG result
          val tmp = MirTypes.GC.new()
          val tmp2 = MirTypes.GC_REG tmp

	  val new_code =
	    MirTypes.ALLOCATE
	      (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT 4)
	    :: arg_code
	    @ [MirTypes.UNARY (MirTypes.NOT32, tmp2, new_reg),
	       MirTypes.STOREOP
	         (MirTypes.ST, tmp2, res2, MirTypes.GP_IMM_ANY ~1),
	       MirTypes.NULLARY(MirTypes.CLEAN, tmp2)]
	    @ clean_arg_code
        in
	  (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result)),
           Mir_Utils.combine
	     (the_code,
              ((Sexpr.ATOM new_code, [], NONE, Sexpr.NIL),
               [],[])))
        end


  (* convert32 stores an integer or word in a 4-byte string, the
     representation used for 32-bit values. *)
  fun convert32 (w, size, spills, calls) =
    let
      val result = MirTypes.GC.new()
      val res1 = MirTypes.GP_GC_REG result
      val res2 = MirTypes.GC_REG result
      val tmp = MirTypes.GC.new()

      val (use_zero, zero_reg) =
	if w = 0 then
	  case MirRegisters.zero of
	    SOME zero_reg => (true, zero_reg)
	  | _ => (false, MirRegisters.global)
	else
	  (false, MirRegisters.global)
	
      val opcodes =
	if MachSpec.has_immediate_stores then
	  [MirTypes.ALLOCATE
	   (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT (size div 8)),
	   MirTypes.IMMSTOREOP
	   (MirTypes.ST, MirTypes.GP_IMM_ANY w , res2, MirTypes.GP_IMM_ANY ~1)]
	else
	  if use_zero then
	    [MirTypes.ALLOCATE
	     (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT (size div 8)),
	     MirTypes.STOREOP
	     (MirTypes.ST, MirTypes.GC_REG zero_reg , res2, MirTypes.GP_IMM_ANY ~1)]
	  else
	    [MirTypes.ALLOCATE
	     (MirTypes.ALLOC_STRING, res2, MirTypes.GP_IMM_INT (size div 8)),
	     MirTypes.UNARY
	     (MirTypes.MOVE, MirTypes.GC_REG tmp, MirTypes.GP_IMM_ANY w),
	     MirTypes.STOREOP
	     (MirTypes.ST, MirTypes.GC_REG tmp, res2, MirTypes.GP_IMM_ANY ~1),
	     MirTypes.NULLARY(MirTypes.CLEAN, MirTypes.GC_REG tmp)]

      val code =
        ((Sexpr.ATOM opcodes, [], NONE, Sexpr.NIL), [], [])
    in
      (Mir_Utils.ONE(Mir_Utils.INT res1), code, RuntimeEnv.EMPTY, spills, calls)
    end

  fun mir_cg
    error_info
      (options as Options.OPTIONS {compiler_options,print_options,...},
     lambda_exp, filename, mapping) =
  let

    (* Reset the virtual register counters *)

    val Options.COMPILEROPTIONS {generate_debug_info,
                                 debug_variables,
                                 generate_moduler,
                                 intercept,
                                 interrupt,
                                 opt_handlers,
                                 opt_self_calls,
                                 opt_tail_calls,
				 local_functions,
                                 ...} =
      compiler_options

    (* We need to know which of the optimisations at the lambda stage
       which are controlled by the debugging and local_functions options
       are being done. The following code should be kept consistent
       with that in lambda/_simplelambda.sml#optimise.
    *)

    (* Full lambda optimisation is done only if no debug options set *)

    val do_full_lambda_opt = not generate_moduler andalso
                             not generate_debug_info andalso
                             not debug_variables andalso
                             not intercept

    (* local-function optimisations are done only if already doing full
     lambda optimisation *)

    val do_local_functions = do_full_lambda_opt andalso local_functions


    val _ =
      (MirTypes.GC.reset();
       MirTypes.NonGC.reset();
       MirTypes.FP.reset())

    val name_of_setup_function = "<Setup>[" ^ filename ^ ":1,1]"

    (* Always insert interrupt if the flag is set *)
    (* Not relevant if no tail optimisation *)
    val insert_interrupt = interrupt

    (* Variable debugging stuff *)
    val variable_debug = debug_variables orelse generate_moduler

    (* Note this ref is _not_ global *)

    val opt_first_spill : RuntimeEnv.Offset ref list ref option =
      if variable_debug then
        SOME (ref ( [ref(RuntimeEnv.OFFSET1 1)]))
      else
        NONE

    fun get_current_spills () =
      case opt_first_spill of
        NONE => Crash.impossible "current_spills:mir_cg:mir_cg"
      | SOME first_spill => !first_spill

    (* Make a function to reset the spills ref (if there is one) *)
    fun spill_restorer () =
      case opt_first_spill of
        NONE => (fn _ => ())
      | SOME first_spill =>
          let
            val old_spill = !first_spill
          in
            fn _ => first_spill := old_spill
          end

    (* Reset spills to initial state.  Return the new initial state *)
    fun initialize_spills () =
      case opt_first_spill of
        NONE => []
      | SOME first_spill =>
          let
            val spill = [ref(RuntimeEnv.OFFSET1 1)]
          in
            (first_spill := spill;
             spill)
          end

    (* Set the spills to the given value *)
    fun reset_spills spill =
      case opt_first_spill of
        NONE => ()
      | SOME first_spill =>
          first_spill := spill

    (* Add the given spill to the front of the list *)
    (* This only seems to be used during HANDLEs *)
    fun append_spill spill =
      case opt_first_spill of
        NONE => ()
      | SOME first_spill =>
          first_spill := spill::(!first_spill)

    fun head_spill [spill] = spill
      | head_spill _ = Crash.impossible "head_spill:mir_cg:mir_cg"

    fun new_ref_slot slot = ref (RuntimeEnv.OFFSET1 slot)

    (* calls is some kind of index of the calls made *)

    fun make_call_code(calls,code) =
      if variable_debug then
        let
          val reg = MirTypes.GC.new()
          val current_spills = get_current_spills ()
          val ((code,bs,ts,ops),vs,ps) = code
        in
          ((Lists.reducer
            (fn (ref_slot,code) =>
             Sexpr.CONS(Sexpr.ATOM [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG reg,
                                                   MirTypes.GP_IMM_INT (calls)),
                                    MirTypes.STOREOP(MirTypes.STREF,MirTypes.GC_REG (reg),
                                                     MirTypes.GC_REG fp,
                                                     MirTypes.GP_IMM_SYMB (MirTypes.GC_SPILL_SLOT
                                                                           (MirTypes.DEBUG (ref_slot,
                                                                                            "call_code"))))],
                        code))
            (current_spills,code),bs,ts,ops),vs,ps)
        end
      else
        code

    (* End of variable debugging stuff *)

    val (prim_to_lambda, new_lambda_exp) = make_prim_info (compiler_options, lambda_exp)

    (* Get the lambda variables representing all the functions *)

    val top_lambdas = SimpleUtils.function_lvars new_lambda_exp

    (* Construct a loop entry tag for every function *)

    val top_lambda_loop_tags =
      IntMap.apply
      (lists_reducel
       (fn (tree, lv) =>
	IntMap.define(tree, lv, MirTypes.new_tag()))
       (IntMap.empty, top_lambdas))

(*
    val _ = Diagnostic.output 5
      (fn _ => (["Lambdas representing functions"] @
                (map (fn x => " " ^ LambdaTypes.printLVar x)
                 top_lambdas)))
*)

    (* Count the static gc objects *)
    val (new_exp_and_size as {size=number_of_gc_objects, lexp=new_lambda_exp},debug_information) =
      AugLambda.count_gc_objects (options,new_lambda_exp,
                                  true (* generate_debug_info *), (* always generate debug info, for now *)
                                  mapping,
                                  name_of_setup_function)

    (* Construct references to external values *)
    (* top_closure is the static object *)
    (* top_tags_list is the list of corresponding tags *)
    (* The others are lists of external references *)

    val (new_exp_and_size, top_tags_list, top_closure,
         (ext_string_list,ext_var_list,ext_exn_list,ext_str_list,ext_fun_list)) =
      do_externals (new_exp_and_size,number_of_gc_objects)

    (* new_lambda_exp is what cg_sub gets called on *)

    val {lexp = new_lambda_exp, ... } = new_exp_and_size

    (* And make some mapping functions to get external indices *)

    local
      val make_str_order_tree = NewMap.from_list ((op<):string*string->bool, op =)
      val ext_string_tree = make_str_order_tree ext_string_list
      val ext_var_tree = make_str_order_tree ext_var_list
      val ext_exn_tree = make_str_order_tree ext_exn_list
      val ext_str_tree = make_str_order_tree ext_str_list
      val ext_fun_tree = make_str_order_tree ext_fun_list
    in
      val find_ext_string = NewMap.apply ext_string_tree
      val find_ext_var = NewMap.apply ext_var_tree
      val find_ext_exn = NewMap.apply ext_exn_tree
      val find_ext_str = NewMap.apply ext_str_tree
      val find_ext_fun = NewMap.apply ext_fun_tree
    end

    fun append_runtime_envs(env1,env2) =
      case !env1 of
        RuntimeEnv.LIST(env) => RuntimeEnv.LIST(env@[env2])
      | RuntimeEnv.EMPTY => env2
      | env1 => RuntimeEnv.LIST[env1,env2]

    fun has_local_functions ({lexp = AugLambda.FN (vl,e,s,info),size} :: _) =
      LambdaTypes.isLocalFn info
      | has_local_functions _ = false

    (* Put the returned value in the right place *)
    fun make_exit_code res =
      let
        val restemp = MirTypes.GC.new ()
      in
        ((Sexpr.ATOM
          (Mir_Utils.send_to_given_reg(res, restemp) @
           [MirTypes.UNARY(MirTypes.MOVE,
                           MirTypes.GC_REG callee_arg,
                           MirTypes.GP_GC_REG restemp),
            MirTypes.RTS]),
          [], NONE, Sexpr.NIL), [], [])
      end

    (* Code generate for a variable binding *)

    fun cg_bind({lexp=lexp, size=gc_in_arg},
                env, static_offset,start_at,

                (closure,funs_in_closure, fn_tag_list, local_fns),
                spills,calls) =
      let
        (* Code generate the expression *)
	val (regs,the_code,runtime_env,spills,calls) =
	  cg_sub(lexp, env, static_offset, start_at,false,
                 (closure,funs_in_closure, fn_tag_list, local_fns),spills,calls)
        (* Now assemble the result into a single register *)
	val (reg, more_code) =
          case regs of
            Mir_Utils.ONE(Mir_Utils.INT reg) =>
              (case reg of
                 MirTypes.GP_GC_REG x =>
                   (MirTypes.GC x, [])
               | MirTypes.GP_NON_GC_REG x =>
                   (MirTypes.NON_GC x, [])
               | MirTypes.GP_IMM_INT _ =>
                   let
                     val new_reg = MirTypes.GC.new()
                   in
                     (MirTypes.GC new_reg,
                      [MirTypes.UNARY(MirTypes.MOVE,
                                      MirTypes.GC_REG new_reg,
                                      reg)])
                   end
               | MirTypes.GP_IMM_SYMB _ =>
                   let
                     val new_reg = MirTypes.GC.new()
                   in
                     (MirTypes.GC new_reg,
                      [MirTypes.UNARY(MirTypes.MOVE,
                                      MirTypes.GC_REG new_reg,
                                      reg)])
                   end
               | _ => Crash.impossible"Untagged value to LET")
          | Mir_Utils.ONE(Mir_Utils.REAL(MirTypes.FP_REG fp_reg)) =>
              (MirTypes.FLOAT fp_reg, [])
          | Mir_Utils.LIST many =>
              let val (gc_reg, more_code) = Mir_Utils.tuple_up many
              in
                (MirTypes.GC gc_reg, more_code)
              end
      in
	(reg,
	 Mir_Utils.combine(the_code,((Sexpr.ATOM more_code, [], NONE,Sexpr.NIL),[], [])),
	 static_offset + gc_in_arg, start_at + gc_in_arg,runtime_env,spills,calls)
      end

    (* Code generate a list of bindings, typically for a let *)
    and cg_bind_list([], env,static_offset, start_at,_,spills,calls) =
      (no_code, env, static_offset, start_at,RuntimeEnv.LIST(nil),spills,calls)

    | cg_bind_list((lv, le) :: rest, env, static_offset, start_at,
                   (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
      let
	val (reg, code, static_offset', start_at',runtime_env,spills,calls) =
	  cg_bind(le, env, static_offset, start_at,
                  (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls)
	val env' = Mir_Env.add_lambda_env ((lv, reg), env)
	val (new_code, env, static_offset, start_at, runtime_envs,spills,calls) =
	  cg_bind_list (rest, env', static_offset', start_at',
                        (closure,funs_in_closure, fn_tag_list,local_fns), spills,calls)
        val runtime_envs =
          case runtime_envs of
            RuntimeEnv.LIST runtime_envs => runtime_envs
          | _ => Crash.impossible "cg_bind_list:_mir_cg.sml"
      in
	(Mir_Utils.combine(code, new_code), env, static_offset, start_at,
         RuntimeEnv.LIST(runtime_env::runtime_envs),spills,calls)
      end

    (* This is used for compiling function bodies *)
    and cg_letrec_sub (lexp,env,static_offset,start_at,tail_position,
                         (closure,funs_in_closure,fn_tag_list,local_fns),
                         spills,calls) =
        case lexp of
          AugLambda.LETREC (lv_list,le_list,{lexp = body_exp,...}) =>
            if not (has_local_functions le_list)
              then
                cg_sub (lexp,env,static_offset,start_at,tail_position,
                        (closure,funs_in_closure,fn_tag_list,local_fns),
                        spills,calls)
            else
              let
                (* val _ = print (Int.toString (Lists.length lv_list) ^ " in local\n") *)

(*
                val _ =
                  Lists.iterate
                  (fn {lexp=AugLambda.FN((lvl,fp_args),e,name,info),...} =>
                   (case fp_args of [] => ()
                 | _ => (print ("Local " ^ name ^ ":");
                         Lists.iterate (fn v => print (N v ^ " ")) fp_args;
                         print "\n"))
                | _ => ())
                  le_list
*)

                val vars = map #1 lv_list
                val tags = map (fn _ => MirTypes.new_tag ()) vars

                val args_bodies = map
                                  (fn {lexp = AugLambda.FN((args,fp_args),body,_,_),...} =>
                                   ((args,fp_args),body)
                                   | _ => Crash.impossible ("Bad function in letrec"))
                                  le_list
                val full_args_list = map #1 args_bodies
                val args_list = map #1 full_args_list
                val fp_args_list = map #2 full_args_list
                val bodies = map #2 args_bodies
                val arg_regs_list = map (map (fn _ => MirTypes.GC.new ())) args_list
                val fp_arg_regs_list = map (map (fn _ => MirTypes.FP.new ())) fp_args_list

                val new_local_functions =
                  local_fns @
                  map
                  (fn (var,tag,args,fp_args) => (var,(tag,(args,fp_args))))
                  (zip4 (vars,tags, arg_regs_list,fp_arg_regs_list))

                (* The environments for compiling the bodies of the local functions *)
                val new_envs =
                  map
                  (fn (args,regs,fp_args,fp_regs) =>
                   let
                     val env =
                       Lists.reducel
                       (fn (env,(arg,reg)) => Mir_Env.add_lambda_env ((arg,MirTypes.GC reg),env))
                       (Mir_Env.empty_lambda_env, zip2 (args,regs))
                   in
                     Lists.reducel
                     (fn (env,(arg,reg)) => Mir_Env.add_lambda_env ((arg,MirTypes.FLOAT reg),env))
                     (env, zip2 (fp_args,fp_regs))
                   end)
                  (zip4 (args_list,arg_regs_list,fp_args_list,fp_arg_regs_list))

                val start_offsets = ref 0
                val locals_code =
                  map
                  (fn ({lexp=body,size=body_size},new_env,tag) =>
                   let
                     val (regs, body_code,runtime_env,spills,calls) =
                       cg_sub (body,new_env,static_offset + !start_offsets,start_at + !start_offsets,tail_position,
                               (closure,funs_in_closure,fn_tag_list,new_local_functions),
                               spills,calls)
                     val ((first,blocks,tag_opt,last),vals,procs) =
                       Mir_Utils.combine (body_code, make_exit_code (regs))
                     val _ = start_offsets := !start_offsets + body_size
                   in
                     (MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr first) ::
                      blocks @
                      (case tag_opt of
                         NONE => []
                       | SOME tag =>
                           [MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr last)]),
                      vals,
                      procs)
                   end)
                  (zip3 (bodies,new_envs,tags))

                fun appendl' ([],[],acc) = rev acc
                  | appendl' (a::b, rest, acc) = appendl' (b,rest,a::acc)
                  | appendl' ([], l :: rest, acc) = appendl' (l,rest,acc)
                fun appendl l = appendl' ([],l,[])

                val local_blocks = appendl (map #1 locals_code)
                val local_vals = appendl (map #2 locals_code)
                val local_procs = appendl (map #3 locals_code)

                (* And finally the body *)
                val (regs, ((first, body_blocks, tag_opt, last), body_vals, body_procs),runtime_env,spills,calls) =
                  cg_sub (body_exp,env,static_offset + !start_offsets,start_at + !start_offsets,tail_position,
                          (closure,funs_in_closure,fn_tag_list,new_local_functions),
                          spills,calls)
              in
                (regs, ((first, body_blocks @ local_blocks, tag_opt, last), body_vals @ local_vals, body_procs @ local_procs),
                 runtime_env,spills,calls)
              end

        | _ =>
            cg_sub (lexp,env,static_offset,start_at,tail_position,
                    (closure,funs_in_closure,fn_tag_list,local_fns),
                    spills,calls)

    (* Code generate for an expression *)
    (* Application of builtin case *)
    and cg_sub(arg as AugLambda.APP ({lexp=AugLambda.BUILTIN(prim,primTy), ...},
                                     ([{lexp=lexp, size=gc_objects_in_parm}],[]),_),
               env,static_offset, start_at, tail_position,
               (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
      (* env is the local lambda to register environment
       closure is the free lambda to offsets from callee_closure environment
       static_offset is the offset within the closure of the current function
       of static garbage collectable objects (functions and non-integer scons)
       start_at is the offset within the outermost closure of the tags
       for the static garbage collectable objects
       funs_in_closure is the number of functions following callee_closure
       within the current closure
       *)
    let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(APP), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating APP(BUILTIN...)\n",
	LambdaPrint.string_of_lambda arg])
*)

    in
    (case prim of
       (* External loads are treated specially *)
       Pervasives.LOAD_STRING => load_external (lexp,find_ext_string, RuntimeEnv.EMPTY,spills,calls)
     | Pervasives.LOAD_VAR => load_external (lexp,find_ext_var, RuntimeEnv.EMPTY,spills,calls)
     | Pervasives.LOAD_EXN => load_external (lexp,find_ext_exn, RuntimeEnv.EMPTY,spills,calls)
     | Pervasives.LOAD_STRUCT => load_external (lexp,find_ext_str, RuntimeEnv.EMPTY,spills,calls)
     | Pervasives.LOAD_FUNCT => load_external (lexp,find_ext_fun, RuntimeEnv.EMPTY,spills,calls)
     | Pervasives.GET_IMPLICIT => do_get_implicit (lexp,RuntimeEnv.EMPTY,spills,calls)
     | _ =>
         let
           (* Otherwise, we code generate for the argument *)
           val (regs, the_code,runtime_env',spills,calls') =
             cg_sub(lexp, env, static_offset, start_at, false,
                    (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls)

           val calls : int ref = ref(calls')
           val spills : (int * int * int) ref = ref(spills)
           val runtime_env : RuntimeEnv.RuntimeEnv ref = ref(RuntimeEnv.BUILTIN)

           (* Don't like the refs here *)
           fun exn_code_for_prim prim =
             let
               fun scan [] = ([], [])
                 | scan (exception_needed::rest) =
                  let
                      val exception_packet =
                        AugLambda.VAR(prim_to_lambda exception_needed)

                      val (exn_f, exn_b, exn_o, exn_l) =
                        case cg_sub (AugLambda.RAISE({lexp=AugLambda.STRUCT
                                                      [{lexp=exception_packet, size=0},
                                                       {lexp=AugLambda.STRUCT[], size=0}],
                                                      size=0}),
                                     env, static_offset, start_at, false,
                                     (closure,funs_in_closure,fn_tag_list,local_fns),!spills,!calls)
                          of (_, ((exn_f, exn_b, exn_o, exn_l), [], []),
                              runtime_env',spills',calls') =>
                            (calls := calls';
                             runtime_env := append_runtime_envs(runtime_env,runtime_env');
                             spills := spills';
                             (exn_f, exn_b, exn_o, exn_l))
                            | _ => Crash.impossible"Bad code for RAISE primitive exception"

                      val _ =
                        case exn_o of
                          NONE => ()
                        | _ => Crash.impossible"Too much raise code"

                      val exn_tag = MirTypes.new_tag()
                      val (rest_blocks,rest_tags) = scan rest
                    in
                      (MirTypes.BLOCK(exn_tag, Mir_Utils.contract_sexpr exn_f) :: exn_b @ rest_blocks,
                       exn_tag :: rest_tags)
                    end
             in
               scan (MachPerv.implicit_references prim)
             end

           (* Need to put poly eq here because of recursive call *)
           fun do_eq (regs,the_code) =
             let
(*
               val _ = Diagnostic.output 3 (fn _ => ["Mir_Cg: Translating polymorphic equality"])
*)
               val primitive =
                 case MachPerv.implicit_references Pervasives.EQ
                   of [p] => p
                    | _ =>
                        Crash.impossible
                        ("Mir_Cg: I was expecting the implicit reference of EQ " ^
                         "to be a single external thing!")

               val polymorphic_equality =
                 AugLambda.VAR(prim_to_lambda primitive)
               val (reg, extra_code) =
                 case Mir_Utils.send_to_reg regs of
                   (MirTypes.GP_GC_REG reg, code) => (reg, code)
                 | _ => Crash.impossible"Mir_Utils.send_to_reg doesn't give GP_GC_REG"
               val extra_code = ((Sexpr.ATOM extra_code, [], NONE,Sexpr.NIL), [], [])
               val lvar = LambdaTypes.new_LVar()
               val env' = Mir_Env.add_lambda_env((lvar, MirTypes.GC reg), env)
               val (reg, poly_code,runtime_env',spills',calls') =
                 cg_sub(AugLambda.APP({lexp=polymorphic_equality, size=0},
                                      ([{lexp=AugLambda.VAR lvar, size=0}],[]),
                                      Debugger_Types.null_backend_annotation), env',
                        static_offset + gc_objects_in_parm,
                        start_at + gc_objects_in_parm,
                        tail_position,
                        (closure,funs_in_closure,fn_tag_list,local_fns),!spills,!calls)
               val _ = calls := calls'
               val _ = spills := spills'
               val _ = runtime_env := append_runtime_envs(runtime_env,runtime_env')
             in
               case regs of
                 Mir_Utils.LIST[Mir_Utils.INT reg1, Mir_Utils.INT reg2] =>
                   let
                     val good_tag = MirTypes.new_tag()  (* For true *)
                     val bad_tag = MirTypes.new_tag()   (* For false *)
                     val test_tag = MirTypes.new_tag()  (* For dunno *)
                     val final_tag = MirTypes.new_tag() (* Where we end up *)
                     val res_reg = MirTypes.GC.new()
                     val gc_res_reg = MirTypes.GC_REG res_reg
                     val new_code =
                       (Sexpr.ATOM[MirTypes.COMMENT"Start of poly eq",
                                   MirTypes.TEST(MirTypes.BEQ, good_tag, reg1,
                                                 reg2),
                                   (* Ok if equal values in the registers *)
                                   MirTypes.BINARY(MirTypes.AND,
                                                   MirTypes.GC_REG(MirRegisters.global),
                                                   reg1, MirTypes.GP_IMM_ANY 3),
                                   MirTypes.BINARY(MirTypes.AND,
                                                   MirTypes.GC_REG MirRegisters.global, reg2,
                                                   MirTypes.GP_GC_REG MirRegisters.global),
                                   MirTypes.TEST(MirTypes.BNE, bad_tag,
                                                 MirTypes.GP_GC_REG(MirRegisters.global),
                                                 MirTypes.GP_IMM_ANY 1),
				   (* Warning: On the MIPS we implement this by *)
				   (* decrementing global, in order to avoid *)
				   (* overloading global and thus always entering *)
				   (* the rts to do polymorphic equality *)
				   (* If you change this, polymorphic equality *)
				   (* on the mips may stop working, *)
				   (* or may lose efficiency *)

                                   (* Is second one an ordinary pointer *)
                                   MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG test_tag)],
                       [MirTypes.BLOCK(good_tag,
                                       [MirTypes.UNARY(MirTypes.MOVE, gc_res_reg,
                                                       MirTypes.GP_IMM_INT 1),
                                        MirTypes.BRANCH(MirTypes.BRA,
                                                        MirTypes.TAG final_tag)]),
                       MirTypes.BLOCK(bad_tag,
                                      [MirTypes.UNARY(MirTypes.MOVE, gc_res_reg,
                                                      MirTypes.GP_IMM_INT 0),
                                       MirTypes.BRANCH(MirTypes.BRA,
                                                       MirTypes.TAG final_tag)])],
                       SOME test_tag, Sexpr.NIL)
                     val new_code =
                       Mir_Utils.combine
                       (the_code,
                        Mir_Utils.combine
                        ((new_code, [], []),
                         Mir_Utils.combine
                         (Mir_Utils.combine(extra_code, poly_code),
                          ((Sexpr.ATOM(Mir_Utils.send_to_given_reg(reg, res_reg) @
                                       [MirTypes.BRANCH(MirTypes.BRA,
                                                        MirTypes.TAG final_tag)]),
                          [], SOME final_tag,
                          Sexpr.ATOM[MirTypes.COMMENT"End of poly eq"]),
                          [], []))))
                   in
                     (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG res_reg)),
                      new_code)
                   end
               | _ =>
                   (reg,
                    Mir_Utils.combine(the_code,
                                      Mir_Utils.combine(extra_code, poly_code)))
             end

      (* Primitives *)
      val (result, code) =
      case prim of
	Pervasives.IDENT_FN => Crash.impossible"Unexpanded IDENT_FN"
      | Pervasives.ENTUPLE => do_external_prim prim
      | Pervasives.ML_REQUIRE => do_external_prim prim
      | Pervasives.ML_CALL => do_ml_call (regs,the_code)
      | Pervasives.ML_OFFSET => do_ml_offset (regs,the_code)
      | Pervasives.LOAD_VAR => do_external_prim prim
      | Pervasives.LOAD_EXN => do_external_prim prim
      | Pervasives.LOAD_STRUCT => do_external_prim prim
      | Pervasives.LOAD_FUNCT => do_external_prim prim
      | Pervasives.REF => do_ref (regs,the_code)
      | Pervasives.BECOMES => do_becomes (TypeUtils.is_integral2 primTy,regs,the_code)
      | Pervasives.DEREF => do_deref (regs,the_code)
      | Pervasives.EXORD => Crash.impossible"APP of non-function"
      | Pervasives.EXCHR => Crash.impossible"APP of non-function"
      | Pervasives.EXDIV => Crash.impossible"APP of non-function"
      | Pervasives.EXSQRT => Crash.impossible"APP of non-function"
      | Pervasives.EXEXP => Crash.impossible"APP of non-function"
      | Pervasives.EXLN => Crash.impossible"APP of non-function"
      | Pervasives.EXIO => Crash.impossible"APP of non-function"
      | Pervasives.EXMATCH => Crash.impossible"APP of non-function"
      | Pervasives.EXBIND => Crash.impossible"APP of non-function"
      | Pervasives.EXINTERRUPT => Crash.impossible"APP of non-function"
      | Pervasives.EXOVERFLOW => Crash.impossible"APP of non-function"
      | Pervasives.EXRANGE => Crash.impossible"APP of non-function"
      | Pervasives.MAP => do_external_prim prim
      | Pervasives.UMAP => do_external_prim prim
      | Pervasives.REV => do_external_prim prim
      | Pervasives.NOT => Crash.impossible"Primitive NOT"
      | Pervasives.ABS => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.FLOOR => do_floor (regs,the_code,exn_code_for_prim prim)
      | Pervasives.REAL => do_real (regs,the_code)
      | Pervasives.SQRT => tagged_unary_fcalc(MirTypes.FSQRTV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.SIN => unary_fcalc (MirTypes.FSIN,regs,the_code)
      | Pervasives.COS => unary_fcalc (MirTypes.FCOS,regs,the_code)
      | Pervasives.ARCTAN => unary_fcalc (MirTypes.FATAN,regs,the_code)
      | Pervasives.EXP => tagged_unary_fcalc(MirTypes.FETOXV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.LN => tagged_unary_fcalc(MirTypes.FLOGEV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.SIZE => do_size (regs,the_code)
      | Pervasives.CHR => do_chr (regs,the_code,exn_code_for_prim prim)
      | Pervasives.ORD => do_ord (regs,the_code,exn_code_for_prim prim)
      | Pervasives.CHARCHR => do_char_chr (regs,the_code,exn_code_for_prim prim)
      | Pervasives.CHARORD => (regs, the_code) (* Ord on char is nop *)
      | Pervasives.ORDOF => do_ordof (true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.EXPLODE => do_external_prim prim
      | Pervasives.IMPLODE => do_external_prim prim
      | Pervasives.FDIV => tagged_binary_fcalc(MirTypes.FDIVV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.DIV => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.MOD => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.INTDIV => tagged_binary_calc(MirTypes.DIVS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTMOD => tagged_binary_calc(MirTypes.MODS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.PLUS => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.STAR => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.MINUS => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.HAT => do_external_prim prim
      | Pervasives.AT => do_external_prim prim
      | Pervasives.NE => do_external_prim prim
      | Pervasives.LESS => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.GREATER => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.LESSEQ => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.GREATEREQ => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.O => Crash.impossible"Primitive composition"
      | Pervasives.UMINUS => Crash.impossible"Unresolved overloaded primitive"
      | Pervasives.EQFUN => do_external_prim prim (* This shouldn't ever occur *)
      | Pervasives.EQ => do_eq (regs,the_code)
      | Pervasives.REALPLUS => tagged_binary_fcalc(MirTypes.FADDV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTPLUS => tagged_binary_calc(MirTypes.ADDS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.UNSAFEINTPLUS => binary_calc (MirTypes.ADDU,regs,the_code)
      | Pervasives.UNSAFEINTMINUS => binary_calc (MirTypes.SUBU,regs,the_code)
      | Pervasives.WORDPLUS => binary_calc (MirTypes.ADDU,regs,the_code)
      | Pervasives.WORDMINUS => binary_calc (MirTypes.SUBU,regs,the_code)
      | Pervasives.WORDSTAR => binary_calc (MirTypes.MULU,regs,the_code)
      | Pervasives.WORDDIV => tagged_binary_calc (MirTypes.DIVU,regs, the_code, exn_code_for_prim prim)
      | Pervasives.WORDMOD => tagged_binary_calc (MirTypes.MODU,regs, the_code, exn_code_for_prim prim)
      | Pervasives.INT32PLUS => tagged32_binary_calc (MirTypes.ADD32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32MINUS => tagged32_binary_calc (MirTypes.SUB32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32STAR => tagged32_binary_calc (MirTypes.MUL32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32DIV => tagged32_binary_calc (MirTypes.DIV32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32MOD => tagged32_binary_calc (MirTypes.MOD32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32UMINUS => int32_unary_negate(MirTypes.SUB32S,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INT32ABS => do_int32abs (regs,the_code,exn_code_for_prim prim)
      | Pervasives.WORD32PLUS => untagged32_binary_calc (MirTypes.ADDU,regs,the_code)
      | Pervasives.WORD32MINUS => untagged32_binary_calc (MirTypes.SUBU,regs,the_code)
      | Pervasives.WORD32STAR => untagged32_binary_calc (MirTypes.MUL32U,regs,the_code)
      | Pervasives.WORD32DIV => tagged32_binary_calc (MirTypes.DIV32U,regs,the_code,exn_code_for_prim prim)
      | Pervasives.WORD32MOD => tagged32_binary_calc (MirTypes.MOD32U,regs,the_code,exn_code_for_prim prim)
      | Pervasives.REALSTAR => tagged_binary_fcalc(MirTypes.FMULV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTSTAR => tagged_binary_calc(MirTypes.MULS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.REALMINUS => tagged_binary_fcalc(MirTypes.FSUBV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTMINUS => tagged_binary_calc(MirTypes.SUBS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.REALUMINUS => tagged_unary_fcalc(MirTypes.FNEGV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTUMINUS => unary_negate(MirTypes.SUBS,regs,the_code,exn_code_for_prim prim)
      | Pervasives.INTLESS => test (MirTypes.BLT,regs,the_code)
      | Pervasives.CHARLT => test (MirTypes.BLT,regs,the_code)
      | Pervasives.WORDLT => test (MirTypes.BLO,regs,the_code)
      | Pervasives.REALLESS => ftest(MirTypes.FBLT, true,regs,the_code)
      | Pervasives.INTGREATER => test (MirTypes.BGT,regs,the_code)
      | Pervasives.CHARGT => test (MirTypes.BGT,regs,the_code)
      | Pervasives.WORDGT => test (MirTypes.BHI,regs,the_code)
      | Pervasives.REALGREATER => ftest(MirTypes.FBLT, false,regs,the_code)
      | Pervasives.INTLESSEQ => test (MirTypes.BLE,regs,the_code)
      | Pervasives.CHARLE => test (MirTypes.BLE,regs,the_code)
      | Pervasives.WORDLE => test (MirTypes.BLS,regs,the_code)
      | Pervasives.REALLESSEQ => ftest(MirTypes.FBLE, true,regs,the_code)
      | Pervasives.INTGREATEREQ => test (MirTypes.BGE,regs,the_code)
      | Pervasives.CHARGE => test (MirTypes.BGE,regs,the_code)
      | Pervasives.WORDGE => test (MirTypes.BHS,regs,the_code)
      | Pervasives.REALGREATEREQ => ftest(MirTypes.FBLE, false,regs,the_code)
      | Pervasives.INTEQ => test (MirTypes.BEQ,regs,the_code)
      | Pervasives.INTNE => test (MirTypes.BNE,regs,the_code)
      | Pervasives.CHAREQ => test (MirTypes.BEQ,regs,the_code)
      | Pervasives.CHARNE => test (MirTypes.BNE,regs,the_code)
      | Pervasives.WORDEQ => test (MirTypes.BEQ,regs,the_code)
      | Pervasives.WORDNE => test (MirTypes.BNE,regs,the_code)
      | Pervasives.REALEQ => ftest(MirTypes.FBEQ, true,regs,the_code)
      | Pervasives.REALNE => ftest(MirTypes.FBNE, true,regs,the_code)
      | Pervasives.INT32EQ => test32 (MirTypes.BEQ,regs,the_code)
      | Pervasives.INT32NE => test32 (MirTypes.BNE,regs,the_code)
      | Pervasives.INT32LESS => test32 (MirTypes.BLT,regs,the_code)
      | Pervasives.INT32LESSEQ => test32 (MirTypes.BLE,regs,the_code)
      | Pervasives.INT32GREATER => test32 (MirTypes.BGT,regs,the_code)
      | Pervasives.INT32GREATEREQ => test32 (MirTypes.BGE,regs,the_code)
      | Pervasives.WORD32EQ => test32 (MirTypes.BEQ,regs,the_code)
      | Pervasives.WORD32NE => test32 (MirTypes.BNE,regs,the_code)
      | Pervasives.WORD32LT => test32 (MirTypes.BLO,regs,the_code)
      | Pervasives.WORD32LE => test32 (MirTypes.BLS,regs,the_code)
      | Pervasives.WORD32GT => test32 (MirTypes.BHI,regs,the_code)
      | Pervasives.WORD32GE => test32 (MirTypes.BHS,regs,the_code)
      | Pervasives.STRINGEQ => do_external_prim prim
      | Pervasives.STRINGNE => do_external_prim prim
      | Pervasives.STRINGLT => do_external_prim prim
      | Pervasives.STRINGLE => do_external_prim prim
      | Pervasives.STRINGGT => do_external_prim prim
      | Pervasives.STRINGGE => do_external_prim prim
      | Pervasives.INTABS => do_intabs (regs,the_code,exn_code_for_prim prim)
      | Pervasives.REALABS => tagged_unary_fcalc(MirTypes.FABSV,regs,the_code,exn_code_for_prim prim)
      | Pervasives.CALL_C => do_call_c (regs,the_code)
      | Pervasives.LOAD_STRING => Crash.impossible "Impossible load_string"

      | Pervasives.ARRAY_FN =>
          array_code (false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.LENGTH => length_code (false,false,regs,the_code)
      | Pervasives.SUB =>
          sub_code (false, true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.UPDATE =>
          update_code (false, true,TypeUtils.is_integral3 primTy,
                       regs,the_code,exn_code_for_prim prim)
      | Pervasives.UNSAFE_SUB =>
          sub_code (false, false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.UNSAFE_UPDATE =>
          update_code(false, false,TypeUtils.is_integral3 primTy,
                      regs,the_code,exn_code_for_prim prim)

      | Pervasives.BYTEARRAY =>
          array_code (true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.BYTEARRAY_LENGTH => length_code (true,false,regs,the_code)
      | Pervasives.BYTEARRAY_SUB =>
          sub_code (true, true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.BYTEARRAY_UNSAFE_SUB =>
          sub_code (true, false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.BYTEARRAY_UPDATE =>
          update_code (true, true,true,regs, the_code,
                       exn_code_for_prim prim)
      | Pervasives.BYTEARRAY_UNSAFE_UPDATE =>
          update_code(true, false, true,regs,the_code,
                      exn_code_for_prim prim)

      | Pervasives.FLOATARRAY =>
          floatarray_code(regs,the_code,exn_code_for_prim prim)
      | Pervasives.FLOATARRAY_LENGTH =>
          length_code (false,true,regs,the_code)
      | Pervasives.FLOATARRAY_SUB =>
          floatarray_sub_code (true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.FLOATARRAY_UPDATE =>
          floatarray_update_code (true,regs, the_code,
                                  exn_code_for_prim prim)
      | Pervasives.FLOATARRAY_UNSAFE_SUB =>
          floatarray_sub_code (false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.FLOATARRAY_UNSAFE_UPDATE =>
          floatarray_update_code (false,regs, the_code,
                                  exn_code_for_prim prim)

      | Pervasives.VECTOR_LENGTH => vector_length_code (regs,the_code)
      | Pervasives.VECTOR_SUB => vector_sub_code (true,regs,the_code,exn_code_for_prim prim)
      | Pervasives.VECTOR => do_external_prim prim
      | Pervasives.EXSIZE => Crash.impossible"APP of non-function"
      | Pervasives.EXSUBSCRIPT => Crash.impossible"APP of non-function"

      | Pervasives.ANDB => binary_calc (MirTypes.AND,regs,the_code)
      | Pervasives.ORB => binary_calc (MirTypes.OR,regs,the_code)
      | Pervasives.XORB => binary_calc (MirTypes.EOR,regs,the_code)
      | Pervasives.WORDANDB => binary_calc (MirTypes.AND,regs,the_code)
      | Pervasives.WORDORB => binary_calc (MirTypes.OR,regs,the_code)
      | Pervasives.WORDXORB => binary_calc (MirTypes.EOR,regs,the_code)
      | Pervasives.WORD32ANDB => untagged32_binary_calc (MirTypes.AND,regs,the_code)
      | Pervasives.WORD32ORB => untagged32_binary_calc (MirTypes.OR,regs,the_code)
      | Pervasives.WORD32XORB => untagged32_binary_calc (MirTypes.EOR,regs,the_code)

      | Pervasives.LSHIFT => do_shift_operator(MirTypes.ASL,false,regs,the_code)
      | Pervasives.RSHIFT => do_shift_operator(MirTypes.LSR,true,regs,the_code)
      | Pervasives.ARSHIFT => do_shift_operator(MirTypes.ASR,true,regs,the_code)
      | Pervasives.WORDLSHIFT =>
	do_shift_operator(MirTypes.ASL,false,regs,the_code)
      | Pervasives.WORDRSHIFT =>
	do_shift_operator(MirTypes.LSR,true,regs,the_code)
      | Pervasives.WORDARSHIFT =>
	do_shift_operator(MirTypes.ASR,true,regs,the_code)
      (* Note: For the 32 bit shift operations, we currently assume *)
      (* that these are on full machine words *)
      (* If/when we code generate for a 64 bit machine, *)
      (* this may have to change *)
      | Pervasives.WORD32LSHIFT =>
	full_machine_word_shift_operator (MirTypes.ASL, regs, the_code)
      | Pervasives.WORD32RSHIFT =>
	full_machine_word_shift_operator (MirTypes.LSR, regs, the_code)
      | Pervasives.WORD32ARSHIFT =>
	full_machine_word_shift_operator (MirTypes.ASR, regs, the_code)
      | Pervasives.NOTB => do_notb (regs,the_code)
      | Pervasives.WORDNOTB => do_notb (regs,the_code)
      | Pervasives.WORD32NOTB => word32_notb (regs,the_code)
      | Pervasives.CAST => do_cast_code (regs,the_code)
      | Pervasives.ALLOC_STRING => do_alloc_string_code (regs,the_code)
      | Pervasives.ALLOC_VECTOR => do_alloc_vector_code (regs,the_code)
      | Pervasives.ALLOC_PAIR => do_alloc_pair_code (regs,the_code)
      | Pervasives.RECORD_UNSAFE_SUB => vector_sub_code (false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.RECORD_UNSAFE_UPDATE => record_unsafe_update_code (regs,the_code)
      | Pervasives.STRING_UNSAFE_SUB => do_ordof (false,regs,the_code,exn_code_for_prim prim)
      | Pervasives.STRING_UNSAFE_UPDATE => string_unsafe_update_code (regs, the_code)
      | Pervasives.GET_IMPLICIT => do_external_prim "get_implicit"

      (* End of switch on pervasives *)

      val (runtime_env,calls) = (!runtime_env,!calls)
      val (code,option,calls) =
       case runtime_env of
         RuntimeEnv.BUILTIN => (code,NONE,calls)
       | _ => (make_call_code(calls+1,code),
               SOME calls',
               calls+1)
    in
      (result, code,
       if variable_debug then
         RuntimeEnv.APP(runtime_env,runtime_env',option)
       else
         RuntimeEnv.EMPTY,
       !spills,calls)
    end)
    end

    | cg_sub(arg as AugLambda.LET ((lvar, info,lexp2), {lexp=lexp1,...}),
             env,static_offset, start_at, tail_position,
             (closure,funs_in_closure, fn_tag_list,local_fns),
             spills,calls) =
    let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(LET), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating LET...\n",
	LambdaPrint.string_of_lambda arg])
*)
      (* Code generate the bound expression *)
      val (reg, code, static_offset', start_at', runtime_env,
           spills as (gc_spills,non_gc_spills,fp_spills),calls) =
	cg_bind(lexp2, env, static_offset, start_at,
                (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls)

      (* Find the debug info, if any *)
      val debug_info =
        case info of
          SOME (ref debug_info) => debug_info
        | _ => RuntimeEnv.NOVARINFO

      (* This seems to be concerned with moving the bound var into a spill slot, if necessary *)
      (* And updating the debug info accordingly *)
      val ((code,spills),debug_info) =
        case debug_info of
          RuntimeEnv.NOVARINFO => ((code,spills),RuntimeEnv.NOVARINFO)
        | RuntimeEnv.VARINFO (name,info,tyvar_slot) =>
            let
              fun find_tyvar_slot (tyvar_slot,slot) =
                case tyvar_slot of
                  NONE =>
                    (ref (RuntimeEnv.OFFSET1 slot),false)
                | SOME offset =>
                    (offset := RuntimeEnv.OFFSET1 slot;
                     (offset,true))
            in
              (case reg of
               MirTypes.GC reg =>
                 let
                   val slot = gc_spills+1
                   val (ref_slot,has_tyvar_slot) = find_tyvar_slot (tyvar_slot,slot)
                 in
                   ((Mir_Utils.combine(code,
                    ((Sexpr.ATOM [MirTypes.STOREOP(MirTypes.STREF,MirTypes.GC_REG (reg),
		     MirTypes.GC_REG fp,
                     MirTypes.GP_IMM_SYMB (MirTypes.GC_SPILL_SLOT (MirTypes.DEBUG (ref_slot,name))))],
		     [],NONE, Sexpr.NIL), [], [])),
		    	               (slot,non_gc_spills,fp_spills)),
                   if has_tyvar_slot then RuntimeEnv.NOVARINFO
                   else RuntimeEnv.VARINFO (name,info,SOME(ref_slot)))
                 end
             | MirTypes.NON_GC reg =>
                 let
                   val slot = non_gc_spills+1
                   val (ref_slot,has_tyvar_slot) = find_tyvar_slot (tyvar_slot,slot)
                 in
                   ((Mir_Utils.combine(code,
                    ((Sexpr.ATOM [MirTypes.STOREOP(MirTypes.STREF,
                                                   MirTypes.NON_GC_REG reg,
                                                   MirTypes.GC_REG fp,
                                                   MirTypes.GP_IMM_SYMB (MirTypes.NON_GC_SPILL_SLOT
                                                                         (MirTypes.DEBUG (ref_slot,name))))],
                    [],NONE, Sexpr.NIL), [], [])),
                   (gc_spills,slot,fp_spills)),
                   if has_tyvar_slot then RuntimeEnv.NOVARINFO
                   else RuntimeEnv.VARINFO(name,info,SOME(ref_slot)))
                 end
             | MirTypes.FLOAT reg =>
                 let
                   val slot = fp_spills+1
                   val (ref_slot,has_tyvar_slot) = find_tyvar_slot (tyvar_slot,slot)
                 in
                   ((Mir_Utils.combine
                     (code,
                      ((Sexpr.ATOM [MirTypes.STOREFPOP(MirTypes.FSTREF,
                                                       MirTypes.FP_REG reg,
                                                       MirTypes.GC_REG fp,
                                                       MirTypes.GP_IMM_SYMB (MirTypes.FP_SPILL_SLOT
                                                                             (MirTypes.DEBUG (ref_slot,name))))],
                      [],NONE, Sexpr.NIL), [], [])),
                     (gc_spills,non_gc_spills,slot)),
                   if has_tyvar_slot then RuntimeEnv.NOVARINFO
                   else RuntimeEnv.VARINFO (name,info,SOME(ref_slot)))
                 end)
            end

      (* Extend lambda environment *)
      val env' = Mir_Env.add_lambda_env((lvar, reg), env)

(*
      val (foo, fp_spills) =
	let
	  val (_, _, fp_spills) = spills
	in
	  (fp_spills > 0, fp_spills)
	end
      val _ =
	if foo then
	  output(std_out,
		 "After spilling fp, fp_spills = " ^ Int.toString fp_spills ^ "\n")
	else
	  ()
*)

      (* And code generate the body *)
      val (rest_regs, rest_code, runtime_env',spills,calls) =
	cg_sub(lexp1, env', static_offset', start_at',tail_position,
	       (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls)
(*
      val _ =
	if foo then
	  let
	    val (_, _, fp_spills) = spills
	  in
	    output(std_out,
		 "After let body, fp_spills = " ^ Int.toString fp_spills ^ "\n")
	  end
	else
	  ()
*)
    in
      (rest_regs, Mir_Utils.combine(code, rest_code),
       if variable_debug then
         RuntimeEnv.LET([(debug_info,runtime_env)], runtime_env')
       else
         RuntimeEnv.EMPTY,spills,calls)
    end

      (* Regular function application *)
    | cg_sub(arg as AugLambda.APP({lexp=le1,size=gc_objects_in_call},
				  (arg_list,fp_arg_list),
                                  debugger_information),
             env,static_offset, start_at,tail_position,
	     (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
      let
        (* First code generate to evaluate which function should be called, *)
        (* then evaluate the argument, then call the function *)
        fun lookup (lvar, l) =

          if (opt_self_calls orelse do_local_functions) andalso tail_position

            then
              let
                fun lookup' (lvar, []) = NONE
                  | lookup' (lvar, (lvar',stuff)::rest) =
                  if lvar = lvar' then SOME stuff else lookup' (lvar,rest)
              in
                lookup' (lvar,l)
              end
          else NONE
        val dummy_info =
          (* The cg_result here is just a dummy *)
          (* We should get an error if it actually gets used *)
          (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_IMM_INT 0)),
           ((Sexpr.ATOM [], [], NONE, Sexpr.NIL), [], []),
           RuntimeEnv.EMPTY,spills,calls+1)
        val ((fn_reg,fn_code,runtime_env,spills,calls'), calltype) =
          case le1 of
            (* If its a lambda var, then we may know the function *)
            AugLambda.VAR lvar =>
              (case lookup (lvar, local_fns) of
                 SOME (tag,(arglist,fp_arglist)) => (dummy_info,Mir_Utils.LOCAL (tag,arglist,fp_arglist))
               | _ =>
                   let
                     val ((reg, code), pos, is_same_set) =
                       Mir_Utils.cg_lvar (lvar, env, closure, funs_in_closure)
                   in
                     if is_same_set then
                       (dummy_info, Mir_Utils.SAMESET pos)
                     else
                       ((Mir_Utils.ONE reg,
                         ((Sexpr.ATOM code, [], NONE, Sexpr.NIL), [], []),
                         RuntimeEnv.EMPTY,spills,calls+1),
                        Mir_Utils.EXTERNAL)
                   end)
          | _ =>
              (* Else code generate as usual *)
              (cg_sub(le1, env, static_offset, start_at,false,
                      (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls+1),
               Mir_Utils.EXTERNAL)

        val gc_objects_in_arglist =
          Lists.reducel
          (fn (n,{size,lexp}) => n + size)
          (0,arg_list)

        (* Do the argument *)
        val (arg_reg, arg_code,runtime_env',spills,calls') =
          cg_sub(AugLambda.STRUCT arg_list, env,
                 static_offset + gc_objects_in_call,
                 start_at + gc_objects_in_call, false,
                 (closure,funs_in_closure, fn_tag_list,local_fns),
                 spills,calls')

        (* This should leave things in FP registers *)
        val (fp_arg_reg, fp_arg_code,runtime_env'',spills,calls') =
          cg_sub(AugLambda.STRUCT fp_arg_list, env,
                 static_offset + gc_objects_in_call + gc_objects_in_arglist,
                 start_at + gc_objects_in_call + gc_objects_in_arglist,
                 false,
                 (closure,funs_in_closure, fn_tag_list,local_fns),
                 spills,calls')

        (* Punt the complicated stuff to Mir_Utils *)
        val (reg, fn_code, arg_code, call_code) =
          Mir_Utils.do_multi_app(debugger_information,
                                 fn_reg, fn_code,
                                 arg_reg, arg_code,
                                 fp_arg_reg,fp_arg_code,
                                 calltype,
                                 funs_in_closure, fn_tag_list,
                                 tail_position andalso opt_tail_calls)
        val code as ((first, blocks, tag_opt, last), values, procs_list) =
          Mir_Utils.combine
          (fn_code,
           Mir_Utils.combine
           (arg_code, make_call_code(calls+1,call_code)))
        val runtime_env =
          if variable_debug then
            RuntimeEnv.APP (RuntimeEnv.APP(runtime_env,runtime_env',NONE),runtime_env'',NONE)
          else
            RuntimeEnv.EMPTY
      in
        (reg, code, runtime_env,spills,calls')
      end

    | cg_sub(arg as AugLambda.STRUCT le_list, env, static_offset, start_at,_,
	   (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
    (* Dispose of unit case *)
    (case le_list of
      [] => (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_IMM_INT 0)), no_code,
             RuntimeEnv.EMPTY,spills,calls)
    | _ =>
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(STRUCT), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating STRUCT\n",
	LambdaPrint.string_of_lambda arg])
*)

        (* Iterate over the subexpressions *)
	fun make_code([],_,spills,calls) = ([],no_code,[],spills,calls)
	  | make_code({lexp=le, size=size} :: rest, pos,spills,calls) =
	    let
	      val (reg,code,runtime_env,spills,calls) =
		cg_sub(le, env, static_offset + pos, start_at + pos, false,
                       (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls)
              val (reg_list,code',runtime_envs,spills,calls) =
                                         make_code(rest, pos+size,spills,calls)
	    in
	      (reg::reg_list,Mir_Utils.combine(code, code'),
               runtime_env::runtime_envs,spills,calls)
	    end
        val (reg_list,the_code,runtime_env,spills,calls) = make_code(le_list, 0, spills,calls)

        (* Coerce to single registers *)
	val new_reg_list =
	  map
	  (fn Mir_Utils.ONE reg =>
	   (reg, [MirTypes.COMMENT("Argument to tuple")])
	  |   Mir_Utils.LIST regs =>
	      let
		val (reg, code) = Mir_Utils.tuple_up regs
	      in
		(Mir_Utils.INT(MirTypes.GP_GC_REG reg),
		 MirTypes.COMMENT("Argument to tuple") :: code)
	      end)
	  reg_list

	val new_code =
	  lists_reducel
	  (fn (code', (_,code)) => Sexpr.CONS(code', Sexpr.ATOM code))
	  (Sexpr.NIL, new_reg_list)

        val runtime_env =
          if variable_debug
            then RuntimeEnv.STRUCT runtime_env
          else
            RuntimeEnv.EMPTY

      (* Note that all the tuple elements are constructed, and then are themselves tupled up *)
      in
	(Mir_Utils.LIST(map #1 new_reg_list),
	 Mir_Utils.combine(the_code, ((new_code, [], NONE,
				       Sexpr.NIL), [], [])),
         runtime_env,spills,calls)
      end)

    | cg_sub(arg as AugLambda.SELECT({index, size}, {lexp=lexp, ...}),
	     env, static_offset, start_at,_,
             (closure,funs_in_closure, fn_tag_list,local_fns),
             spills,calls) =
    let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(SELECT), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating SELECT\n",
	LambdaPrint.string_of_lambda arg])
*)

      val (regs, the_code,runtime_env,spills,calls) =
	cg_sub(lexp, env, static_offset,start_at, false,
               (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls)
      val offset = (index * 4) - 1

    in
      case regs of
	Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG reg)) =>
	  let
	    val new_reg = MirTypes.GC.new()
	  in
	    (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG new_reg)), Mir_Utils.combine(the_code,
	      ((Sexpr.ATOM[MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
				 MirTypes.GC_REG reg,
		  MirTypes.GP_IMM_ANY offset),
		MirTypes.COMMENT("Destructure tuple")], [], NONE,
	      Sexpr.NIL), [], [])),
            if variable_debug
              then RuntimeEnv.SELECT(index,runtime_env)
            else RuntimeEnv.EMPTY,
            spills,calls)

	  end
      | Mir_Utils.ONE _ => Crash.impossible"SELECT(Mir_Utils.ONE(bad value))"
      | Mir_Utils.LIST many =>
          (* This case should be optimized by the lambda optimizer *)
          ((Mir_Utils.ONE(Lists.nth(index, many)), the_code,
            if variable_debug
              then RuntimeEnv.SELECT(index,runtime_env)
            else RuntimeEnv.EMPTY,spills,calls)
           handle Lists.Nth =>
             Crash.impossible
             ("Trying to select item " ^
              Int.toString index ^ " from list size " ^
              Int.toString(length many) ^
              " with struct size " ^ Int.toString size ^ "\n"))
    end

    | cg_sub(arg as AugLambda.SWITCH
	      ({lexp=lexp,size=arg_size}, info, tag_le_list, dflt),
	     env, static_offset, start_at,tail_position,
             (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls) =
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(SWITCH), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
*)
        val positions = do_pos1(arg_size, tag_le_list)
        val list_size =
          lists_reducel (fn (x:int, (_, {size=size, lexp=_})) => x + size)
          (0, tag_le_list)
        val tag_sizes =
          lists_reducel
          (fn (x, (tag,_)) => x + count_gc_tags tag)
          (0, tag_le_list)
	val tag_test_mask = 3
        val (gc_spills,non_gc_spills,fp_spills) = spills
        val slot = gc_spills+1
        val ref_slot = new_ref_slot slot
      in
        let
          (* Initial set up *)
          val tag_positions = do_pos2(arg_size + list_size, tag_le_list)

          val main_tag = MirTypes.new_tag() (* This tag marks the start of the body of the switch. *)
          val end_tag = MirTypes.new_tag() (* For the end of switch *)

          val main_branch = MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG main_tag)
          val final_branch = MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG end_tag)

          val is_con =
            case tag_le_list of
              (AugLambda.IMM_TAG _,_) :: _ => true
            | (AugLambda.VCC_TAG _,_) :: _ => true
            | _ => false

          val dflt_exists = case dflt of
            NONE => false
          | SOME _ => true

          val end_reg = MirTypes.GC.new() (* For the result *)

          (* Construct the default blocks and tags *)
          fun get_blocks_for_dflts(dflt, static_offset, start_at, comment) =
            case dflt of
              NONE => ([], end_tag, [], [],RuntimeEnv.EMPTY,spills,calls)
            | SOME {lexp,size} =>
                let
                  (* Code generate the body of the default case *)
                  val (regs, body_code,runtime_env,spills,calls) =
                    cg_sub(lexp, env, static_offset, start_at,tail_position,
                           (closure,funs_in_closure, fn_tag_list,local_fns),
                           (slot,non_gc_spills,fp_spills),calls)

                  val debug_code =
                    if variable_debug then
		      let
			val new_reg = MirTypes.GC.new()
		      in
			((Sexpr.ATOM [MirTypes.UNARY(MirTypes.MOVE,
						     MirTypes.GC_REG (new_reg),
						     MirTypes.GP_IMM_INT 0),
				      MirTypes.STOREOP(MirTypes.STREF,
						       MirTypes.GC_REG (new_reg),
						       MirTypes.GC_REG fp,
						       MirTypes.GP_IMM_SYMB
						       (MirTypes.GC_SPILL_SLOT
							(MirTypes.DEBUG (ref_slot,"default for switch"))))],
                          [],NONE, Sexpr.NIL), [], [])
		      end
                    else
                      no_code

                  val result_code =
                    (case regs of
                       Mir_Utils.ONE(Mir_Utils.INT reg) =>
                         [MirTypes.UNARY(MirTypes.MOVE,
                                         MirTypes.GC_REG end_reg,
                                         reg)]
                     | Mir_Utils.ONE(Mir_Utils.REAL reg) =>
                         Mir_Utils.save_real_to_reg(reg,
                                                    MirTypes.GC_REG end_reg)
                     | Mir_Utils.LIST many =>
                         (#2 (Mir_Utils.tuple_up_in_reg (many,end_reg))))
		
                  val full_body_code =
                    Mir_Utils.combine (debug_code,
                                       Mir_Utils.combine (body_code,
                                                          ((Sexpr.ATOM(MirTypes.COMMENT comment ::
                                                                       result_code @ [final_branch]),
							    [],NONE,Sexpr.NIL),
							   [],[])))

                  val new_tag =  MirTypes.new_tag()
                  val ((first,blocks,opttag,last),values,procs) = full_body_code
                  val newblocks =
                    case opttag of
                      NONE =>
                        MirTypes.BLOCK(new_tag,Mir_Utils.contract_sexpr first) ::
                        blocks
                    | SOME tag =>
                        MirTypes.BLOCK(new_tag,Mir_Utils.contract_sexpr first) ::
                        MirTypes.BLOCK(tag,Mir_Utils.contract_sexpr last) ::
                        blocks
                in
                  (newblocks,new_tag,values,procs,runtime_env,spills,calls)
                end (* of get_blocks_for_dflts *)

          (* Generate for the default case, if it exists *)
          val (dflt_blocks, dflt_tag, dflt_values, dflt_procs,runtime_env,spills',calls') =
            get_blocks_for_dflts(dflt,
                                 static_offset + arg_size + list_size + tag_sizes,
                                 start_at + arg_size + list_size + tag_sizes,
                                 "simple default")

          (* Count the different types of constructor, if appropriate. *)
          val (num_vcc_tags, num_imm_tags) =
            if not is_con then (0, 0)
            else
              lists_reducel
              (fn ((nv, ni), (AugLambda.IMM_TAG _,_)) => (nv, ni + 1)
               | ((nv, ni), (AugLambda.VCC_TAG _,_)) => (nv + 1, ni)
               | _ => Crash.impossible "bad constructor tag")
              ((0, 0), tag_le_list)

          (* Generate for the non-default cases *)
          val tagged_code =
            if variable_debug
              then
                let
                  val switch_cases = length tag_le_list
                in
                  #2 (Lists.reducer
                      (fn (((t, {lexp=x, ...}), le_offset),(switch_case,tagged_code)) =>
                       let
                         val (reg, code,runtime_env,spills,calls) =
                           cg_sub(x, env, static_offset + le_offset,start_at + le_offset,tail_position,
                                  (closure,funs_in_closure, fn_tag_list, local_fns),
                                  (slot,non_gc_spills,fp_spills),calls)
                         (* This may be a tail, but only if we are in the tail line *)
                         val new_reg = MirTypes.GC.new()
                       in
                         (switch_case-1,
                          (t, (reg,
                               Mir_Utils.combine
                               (((Sexpr.ATOM [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG (new_reg),
                                                             MirTypes.GP_IMM_INT switch_case),
                                              MirTypes.STOREOP(MirTypes.STREF,MirTypes.GC_REG (new_reg),
                                                               MirTypes.GC_REG fp,
                                                               MirTypes.GP_IMM_SYMB
                                                               (MirTypes.GC_SPILL_SLOT
                                                                (MirTypes.DEBUG (ref_slot,
                                                                                 "switch case " ^
                                                                                 Int.toString switch_case))))],
				  [],NONE, Sexpr.NIL), [], []),code),
                               (convert_tag t,runtime_env),
                               spills,calls),
                          MirTypes.new_tag ()) :: tagged_code)
                       end)
                      (Lists.zip (tag_le_list, positions), (switch_cases,nil)))
                end
            else
              map
              (fn ((t, {lexp=x, ...}), le_offset) =>
               let
                 val (reg, code,runtime_env,spills,calls) =
                   cg_sub(x, env, static_offset + le_offset,start_at + le_offset,tail_position,
                          (closure,funs_in_closure, fn_tag_list, local_fns),
                          (slot,non_gc_spills,fp_spills),calls)
               (* This may be a tail, but only if we are in the tail line *)
               in
                 (t, (reg, code, (convert_tag t,runtime_env),
                      spills,calls),MirTypes.new_tag())
               end)
              (Lists.zip (tag_le_list, positions))

          (* I wonder what this is about *)
          val spills = map (fn tuple => #4 (#2 tuple)) tagged_code
          val calls = map (fn tuple => #5 (#2 tuple)) tagged_code

          local
	    fun max(a, b : int) = if a >= b then a else b
            fun order ((gc_spills:int, non_gc_spills:int, fp_spills:int),
                       (gc_spills':int, non_gc_spills':int, fp_spills':int)) =
              gc_spills >= gc_spills' andalso
              non_gc_spills >= non_gc_spills' andalso
              fp_spills >= fp_spills'
          in
            val maximum_spills =
              lists_reducel
              (fn (max_spill as (s1, s2, s3),spill as (t1, t2, t3)) =>
               if order (max_spill,spill) then
		 max_spill
	       else
		 if order(spill, max_spill) then
		   spill
		 else
		   (max(s1, t1), max(s2, t2), max(s3, t3)))
              ((spills', spills))
          end

(*
	  val (_, _, fp_spills) = maximum_spills
	  val _ = output(std_out,
			 "maximum_spills = " ^ Int.toString fp_spills ^ "\n")
*)

          val maximum_calls =
            lists_reducel
            (fn (max_app,app) => if max_app > app then max_app else app)
            (0,(calls'::calls))

          val switch_runtime_env = (RuntimeEnv.DEFAULT,runtime_env) :: map (fn tuple => #3 (#2 tuple)) tagged_code

          (* Test is we are going to do a simple relational test *)
          val is_rel = is_simple_relation lexp

          (* In the case of if..then, need to know this *)
          val (true_tag, false_tag) =
            if is_rel then
              case (tagged_code, dflt) of
                ([(AugLambda.IMM_TAG (_,t1),_, tag)], SOME _) =>
                  if t1 = 1 then (tag, dflt_tag) else (dflt_tag, tag)
            | ([(AugLambda.IMM_TAG (_,t1),_, tag),
		    (AugLambda.IMM_TAG (_,t2),_, tag')], NONE) =>
		    if t1 = 1 then (tag, tag') else (tag', tag)
		  | _ => Crash.impossible "Relational expression with bad IMM_TAGs"
            else (dflt_tag, dflt_tag) (* Rubbish values *)

          (* get_vcc_tag and get_imm_tag are only called when there is only one tag of the appropriate type. *)

          fun get_vcc_tag [] = Crash.impossible "Missing VCC tag"
            | get_vcc_tag ((AugLambda.VCC_TAG _,_, tag) :: _) = tag
            | get_vcc_tag (_ :: rest) = get_vcc_tag rest

          fun get_imm_tag [] = Crash.impossible "Missing IMM tag"
            | get_imm_tag ((AugLambda.IMM_TAG t,_, tag) :: _) = tag
            | get_imm_tag (_ :: rest) = get_imm_tag rest

          fun con_tag_to_reg (from_reg, to_reg) =
            let
              val offset = ~1
            in
              MirTypes.STOREOP(MirTypes.LD,
                               MirTypes.GC_REG to_reg,
                               MirTypes.GC_REG from_reg,
                               MirTypes.GP_IMM_ANY offset)
            end

          (* Put the correct value in the register on which we switch.
           In the general case this requires testing the runtime tag
           on the value, but in some common cases we can improve on this.
           The boolean third field of the result is true if we still
           need to test the actual tag number.
           *)
          (* Returns:
           1: The register with the value to test
           2: The code to extract the value
           3: Do we still need to test?
           *)
          (* This seems to do the extraction of tags so the subsequent code doesn't *)
          (* have to worry about the difference between VCC's and IMM's *)

          (* only used in the is_con case *)

          fun destructuring_code regs =
            case regs of
              (* Single value case *)
              Mir_Utils.ONE(Mir_Utils.INT(gp_op as MirTypes.GP_GC_REG reg)) =>
                let
		  val (num_vccs, num_imms) = case info of
                    (* Only called for constructor matches *)
                    NONE => Crash.impossible "Missing switch info"
                  | SOME {num_imms, num_vccs, ...} => (num_vccs, num_imms)
		  val tmp_reg = MirTypes.GC.new()
                in
                  if num_imms = 0 then
                    (* No immediate values, all VCC's *)
		    (MirTypes.GP_GC_REG tmp_reg,
		     [MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 0 IMM_TAG",
		      con_tag_to_reg (reg, tmp_reg),
		      main_branch],
		     true)
                  else if num_vccs = 0 then
                    (* All immediates *)
                    (gp_op,
                     [MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 0 VCC_TAG",
                      main_branch],
                     true)
                  else if num_vccs = 1 then
                    (* Just one vcc *)
		    if num_vcc_tags = 1 orelse dflt_exists then
		      let
			val vcc_tag =
			  if num_vcc_tags = 1 then
			    get_vcc_tag tagged_code
			  else
			    dflt_tag
		      in
			(gp_op,
			 MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 1 VCC" ::
			 (* Branch if it's a boxed value *)
			 MirTypes.TEST (MirTypes.BTA,
					vcc_tag,
					gp_op,
					MirTypes.GP_IMM_ANY tag_test_mask) ::
			 (if num_imm_tags = 1 andalso num_imms = 1 then
			    (* 1 VCC and 1 IMM *)
			    [MirTypes.BRANCH (MirTypes.BRA,
					      MirTypes.TAG (get_imm_tag tagged_code))]
			  else if num_imm_tags = 0 then
			    (* num_imms = 1 => num_imm_tags = 0 here *)
			    (* So any imm tag must be the default *)
			    let
			      val branch =
				[MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG dflt_tag)]
			    in
			      case dflt of
				NONE =>
				  (* This is the nasty semantically invalid case *)
				  (* Why isn't this a Crash? *)
				  MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG end_reg,
						 MirTypes.GP_IMM_INT 0) :: branch
			      | _ => branch
			    end
			       else [main_branch]),
			    num_imms <> 1 andalso num_imm_tags <> 0)
		      end
		    else
		      (* The match compiler has optimised away a case *)
		      (* given that it can't occur from any of the call sites *)
		      (* We must be in a match default function *)
		      (* Treat as for the num_vccs = 0 case above *)
		      (gp_op,
		       [MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 0 VCC_TAG",
			main_branch],
		       true)
                  else if num_imms = 1 then
		    (* 1 IMM case *)
		    if num_imm_tags = 1 orelse dflt_exists then
		      let
			val imm_tag =
			  if num_imm_tags = 1 then
			    get_imm_tag tagged_code
			  else dflt_tag
		      in
			(MirTypes.GP_GC_REG tmp_reg,
			 MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 1 IMM_TAG" ::
			 MirTypes.TEST(MirTypes.BNT,
				       imm_tag,
				       gp_op,
				       MirTypes.GP_IMM_ANY tag_test_mask) ::
			 (if num_vcc_tags = 0 then
			    [MirTypes.BRANCH(MirTypes.BRA,
					     MirTypes.TAG dflt_tag)]
			  else
			    [con_tag_to_reg (reg, tmp_reg),
			     main_branch]),
			    num_vcc_tags <> 0)
		      end
		    else
		      (* The match compiler has optimised away a case *)
		      (* given that it can't occur from any of the call sites *)
		      (* We must be in a match default function *)
		      (* Treat as for the num_imms = 0 case above *)
		      (MirTypes.GP_GC_REG tmp_reg,
		       [MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, 0 IMM_TAG",
			con_tag_to_reg (reg, tmp_reg),
			main_branch],
		       true)
		  else
		    (* num_vccs > 1 andalso num_imms > 1 *)
		    if num_vcc_tags = 0 then
		      (gp_op,
		       [MirTypes.TEST(MirTypes.BTA,
				      dflt_tag,
				      gp_op,
				      MirTypes.GP_IMM_ANY tag_test_mask),
			main_branch],
		       true)
                  else if num_imm_tags = 0 then
		    (MirTypes.GP_GC_REG tmp_reg,
		     [MirTypes.TEST(MirTypes.BNT,
				    dflt_tag,
				    gp_op,
				    MirTypes.GP_IMM_ANY tag_test_mask),
		      con_tag_to_reg (reg, tmp_reg),
		      main_branch],
		     true)
                  else
		    (MirTypes.GP_GC_REG tmp_reg,
		     [MirTypes.COMMENT "select for ONE/INT/GP_GC_REG, general case",
		      MirTypes.UNARY(MirTypes.MOVE,
				     MirTypes.GC_REG tmp_reg,
				     gp_op),
		      MirTypes.TEST(MirTypes.BNT,
				    main_tag,
				    MirTypes.GP_GC_REG tmp_reg,
				    MirTypes.GP_IMM_ANY tag_test_mask),
		      con_tag_to_reg (reg, tmp_reg),
		      main_branch],
		     true)
		end
	    | Mir_Utils.ONE(Mir_Utils.INT(gp_op)) => Crash.impossible "_mir_cg: Mir_Utils.INT\n"
	    (* Do we need to handle GP_NON_GC_REG? *)
	    | Mir_Utils.ONE(Mir_Utils.REAL _) => Crash.impossible "SWITCH(Mir_Utils.ONE(Mir_Utils.REAL))"
	    | Mir_Utils.LIST many =>
		(* It's implausible that this gets past the lambda optimizer *)
		let
		  val tmp_reg = MirTypes.GC.new()
		  val index = 0
		  val extra =
		    (case Lists.nth(index, many) of
		       Mir_Utils.INT gp_op =>
			 MirTypes.UNARY(MirTypes.MOVE,
					MirTypes.GC_REG tmp_reg,
					gp_op)
		     | Mir_Utils.REAL fp_op => Crash.impossible "REAL when decoding list")
                       handle
	               Lists.Nth =>
	                 Crash.impossible("Trying to select constructor tag " ^
                                          " from list size " ^
                                          Int.toString(length many) ^
                                          "\n")
		in
		  (MirTypes.GP_GC_REG tmp_reg,
		   MirTypes.COMMENT "select for LIST" ::
		   [extra, main_branch],
		   true)
		end

	  (* what is the result here? *)
	  (* it depends on what sort of switch we have *)
	  (* arg_regs:  The switch argument, possible unboxed, literal or untupled -- only used for scons and exns *)
	  (* the_reg_opt:  A register with the switch arg in *)
	  (* switch_arg_code:  Code for producing the switch argument *)
	  (* need_main_test:  Something cunning! *)

	  val (arg_regs, the_reg_opt, switch_arg_code,need_main_test,runtime_env',spills,calls) =
	    (* A simple relational test *)
	    if is_rel then
	      let
		val (test,arg) =
		  case lexp of
		    AugLambda.APP({lexp=AugLambda.BUILTIN (test,_), ...},([{lexp=arg,...}],[]),_) =>
		      (test,arg)
		  | AugLambda.APP({lexp=AugLambda.BUILTIN _, ...},args,_) =>
		      Crash.impossible "Arglist in rel expr"
		  | _ => Crash.impossible"Bad rel lexp"

		(* Code generate the arguments *)
		val (arg_regs, arg_code,arg_runtime_env,spills,calls) =
		  cg_sub
		  (arg, env, static_offset, start_at,false,
		   (closure, funs_in_closure, fn_tag_list, local_fns),
		   maximum_spills,maximum_calls)

		val (the_reg, extra) = Mir_Utils.send_to_reg arg_regs
		(* This is bogus -- but it doesn't matter!!! *)

		val code =
		  make_if (test, arg_regs,arg_code, true_tag, false_tag)
	      in
		(arg_regs, SOME the_reg, code,
		 false,arg_runtime_env,spills,calls)
	      end
	    else if is_con then
	      (* datatype constructor matches *)
	      let
		val (regs, the_code,runtime_env,spills,calls) =
		  (* Code generate the switch argument *)
		  cg_sub(lexp, env, static_offset, start_at,false,
			 (closure,funs_in_closure, fn_tag_list,local_fns),
			 maximum_spills,maximum_calls)

		(* And make some code to get the tags *)
		val (the_reg, select_code, need_main_test) = destructuring_code regs

		val block =
		  Mir_Utils.combine(the_code,
				    ((Sexpr.ATOM (select_code),[],NONE,Sexpr.NIL),
				     [],
				     []))
	      in
		(Mir_Utils.ONE(Mir_Utils.INT(the_reg)),
		 SOME the_reg,
		 block,   (* Compute arg and extract tag *)
		 need_main_test,runtime_env,spills,calls)
	      end
	    else
	      (* scon and expression matches *)
	      let
		val (regs, the_code,runtime_env,spills,calls) =
		  (* Code generate the switch argument *)
		  cg_sub(lexp, env, static_offset, start_at,false,
			 (closure,funs_in_closure, fn_tag_list,local_fns),
			 maximum_spills,maximum_calls);

		val block =
		  Mir_Utils.combine(the_code,
				    ((Sexpr.ATOM [main_branch],[],NONE,Sexpr.NIL),
				     [],[]))
	      in
		(regs, NONE, block, true,runtime_env,spills,calls)
	      end

	  val calls : int ref = ref calls
	  val spills : (int * int * int) ref = ref spills
	  val runtime_env' : RuntimeEnv.RuntimeEnv ref = ref runtime_env'

	  (* Some auxiliary functions *)

	  (* Handle the case of using computed gotos *)
	  fun make_cgt(MirTypes.GP_IMM_INT _,_,_,_) =
	    Crash.impossible"make_cgt GP_IMM_INT"
	    | make_cgt(MirTypes.GP_IMM_ANY _,_,_,_) =
	    Crash.impossible"make_cgt GP_IMM_ANY"
	    | make_cgt(MirTypes.GP_IMM_SYMB _,_,_,_) =
	    Crash.impossible"make_cgt GP_IMM_SYMB"
	    | make_cgt(gp_operand, low, high, val_code_tag_list) =
	    let
	      val reg_op = Mir_Utils.reg_from_gp gp_operand
	      val (dflt_tag, end_blocks) =
		case dflt of
		  NONE =>
		    let val tag1 = MirTypes.new_tag()
		    in (tag1,
			[MirTypes.BLOCK(tag1,
					[MirTypes.COMMENT "CGT default",
					 MirTypes.UNARY(MirTypes.MOVE,
							MirTypes.GC_REG end_reg,
							MirTypes.GP_IMM_ANY 1),
					 final_branch])])
		    end
		| _ => (dflt_tag, [])

	      val full_tag_list =
		let
		  fun expand [] = []
		    | expand ([(_,_, tag)]) = [tag]
		    | expand ((i,_, tag) :: (rest as ((j,_,_) :: _))) =
		    tag :: Mir_Utils.list_of (j-i-1, dflt_tag) @ expand rest
		in
		  expand val_code_tag_list
		end

	      val values =
		Lists.reducer
		(fn ((_, (_, (_, value,_),_,_,_),_), value') =>
		 value @ value')
		(val_code_tag_list, [])

	      val procs =
		Lists.reducer
		(fn ((_, (_, (_,_, proc),_,_,_),_), proc') => proc @ proc')
		(val_code_tag_list, [])

	      val body =
		map
		(fn (_, (regs, ((first, blocks, tag_opt, last),_,_),_,_,_),tag) =>
		 let
		   val end_code =
		     Mir_Utils.send_to_given_reg(regs, end_reg) @
		     [MirTypes.COMMENT "end CGT", final_branch]
		 in
		   (case tag_opt of
		      NONE =>
			[MirTypes.BLOCK(tag,
					Mir_Utils.contract_sexpr(Sexpr.CONS(first, Sexpr.ATOM end_code)))]
		    | SOME tag1 =>
			[MirTypes.BLOCK(tag,
					Mir_Utils.contract_sexpr first),
			 MirTypes.BLOCK(tag1,
					Mir_Utils.contract_sexpr(Sexpr.CONS(last, Sexpr.ATOM end_code)))])
		      @ blocks
		 end)
		val_code_tag_list
	    in
	      ((if is_rel orelse not need_main_test
		  then Sexpr.NIL
		else
		  Sexpr.ATOM(
			     if low = 0 then
			       [MirTypes.SWITCH(MirTypes.CGT,
						reg_op,
						full_tag_list)]
			     else
			       let val new_reg_op = MirTypes.GC.new()
			       in [MirTypes.TEST(MirTypes.BLT,
						 dflt_tag,
						 gp_operand,
						 MirTypes.GP_IMM_INT low),
				   MirTypes.BINARY(MirTypes.SUBU,
						   MirTypes.GC_REG new_reg_op,
						   gp_operand,
						   MirTypes.GP_IMM_INT low),
				   MirTypes.SWITCH(MirTypes.CGT,
						   MirTypes.GC_REG new_reg_op,
						   full_tag_list),
				   MirTypes.COMMENT "Switch relative to lowest tag"]
			       end
			     ),
		  Lists.reducer
		  op@
		  (end_blocks :: body, []),
		  NONE,
		  Sexpr.NIL
		  ),
		  values,
		  procs
		  )
	    end (* of make_cgt *)

	  fun bounds(low:int, high, []) = (low, high)
	    | bounds(low, high, i :: xs) =
	    if (i < low) then bounds(i, high, xs)
	    else if (i > high) then bounds(low, i, xs)
                 else bounds(low, high, xs)

	  (* Test as one damn thing after another *)
	  fun do_chained_tests(_, default, [], test_opt, clean_code) =
	    (((case (default, test_opt) of
		 (* This should never be called without a default,
		  but it's worth being on the safe side.
		  *)
		 (SOME _, SOME _) =>
		   Sexpr.ATOM
		   (clean_code @
		    [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG dflt_tag),
		     MirTypes.COMMENT "default or end"])
	       | (SOME _, NONE) =>
		   Sexpr.NIL (* This one ok *)
	       | (_, SOME _) =>
		   (* This one ok, but should have converted previous *)
		   (* conditional branch to be unconditional *)
		   Sexpr.NIL
	       | _ => Sexpr.NIL (* This one ok *)),
		 [],
		 NONE,
		 Sexpr.NIL),
		 [],[])
	    | do_chained_tests
		 (the_reg, default, head :: rest, test_opt, clean_code) =
                 let
		   val (scon, le, (regs, code_block, _, _, _), tag) = head

                   val ((first, blocks, tag_opt, last), values, procs) =
		     code_block

                   val {test_code, test_clean} =
		     case test_opt of
		       SOME f => f (the_reg, scon, le, tag)
		     | NONE => {test_code = Sexpr.NIL, test_clean = []}

		   val the_test = case rest of
		     [] =>
		       (* Last test coming up *)
		       (case default of
			  NONE =>
			    (* Constructor stuff *)
			    (case test_opt of
			       SOME _ =>
				 (* A real test *)
				 (case test_code of
				    Sexpr.ATOM[MirTypes.TEST(MirTypes.BEQ, tag,_,_)] =>
				      Sexpr.ATOM
				      [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG tag)]
				  | _ => Crash.impossible"Bad constructor test")
			     | _ => test_code)
			| _ => test_code)
		   | _ => test_code

                   val end_code =
                     Mir_Utils.send_to_given_reg(regs, end_reg) @
		       [MirTypes.COMMENT "end chained test", final_branch]

                   val result =
                     case tag_opt of
                       NONE =>
                         (Sexpr.CONS (the_test, Sexpr.ATOM test_clean),
                          MirTypes.BLOCK
			    (tag,
                             Mir_Utils.contract_sexpr
                               (Sexpr.CONS
				  (Sexpr.ATOM (test_clean @ clean_code),
				   Sexpr.CONS
				     (first, Sexpr.ATOM end_code))))
			  :: blocks,
                          NONE,
			  Sexpr.NIL)
                     | SOME tag'=>
                         (Sexpr.CONS (the_test, Sexpr.ATOM test_clean),
                          MirTypes.BLOCK
			    (tag,
			     Mir_Utils.contract_sexpr
			       (Sexpr.CONS
				  (Sexpr.ATOM (test_clean @ clean_code),
				   first)))
			  :: blocks
			  @ [MirTypes.BLOCK
			       (tag',
				Mir_Utils.contract_sexpr
                                  (Sexpr.CONS(last, Sexpr.ATOM end_code)))],
                          NONE,
                          Sexpr.NIL)
                 in Mir_Utils.combine(
		      (result, values, procs),
                      do_chained_tests(the_reg, default, rest, test_opt, clean_code))
                 end (* of do_chained_tests *)

               (* This seems to be the main point for doing datatype switches *)
	  fun constructor_code () =
	    let
	      (* Bind tags to previously generated body code *)
	      val val_code_tags_list =
		Lists.qsort (fn ((i:int,_,_), (i',_,_)) => i < i')
		(map
		 (fn (AugLambda.IMM_TAG (_,i), le, tag) => (i, le, tag)
	       |  (AugLambda.VCC_TAG (_,i), le, tag) => (i, le, tag)
	       | _ => Crash.impossible "Mixed tag type in switch")
		 tagged_code)

	      val (i, (result_reg, code,_,_,_), first_tag) =
		case val_code_tags_list of
		  x :: _ => x
		| _ => Crash.impossible "Empty datatype list"

	      val the_reg =
		case the_reg_opt of
		  SOME x => x
		| NONE => Crash.impossible "Missing the_reg"
	    in
	      if length val_code_tags_list < 3
		(* The small case *)
		then
		  let
		    fun do_test(reg, i,_, tag) =
		      {test_code =
		       Sexpr.ATOM [MirTypes.TEST(MirTypes.BEQ, tag, reg,
						 MirTypes.GP_IMM_INT i)],
		       test_clean = []}
		    val val_le_tags_list =
		      map
		      (fn (i, code, tag) => (i, 0, code, tag))
		      val_code_tags_list
		  in ([],
		      do_chained_tests
		      (the_reg, dflt, val_le_tags_list,
		       if need_main_test then
			 SOME do_test
		       else
			 NONE,
			 []))
		  end
	      else
		(* Computed goto case *)
		let
		  val (low, high) = bounds (i, i, map #1 val_code_tags_list)
		  val dflt_code =
		    case dflt of
		      NONE => []
		    | SOME _ =>
			[MirTypes.TEST(MirTypes.BGT, dflt_tag, the_reg,
				       MirTypes.GP_IMM_INT high)]
		  val main =
		    make_cgt(the_reg, low, high, val_code_tags_list)
		in
		  (dflt_code, main)
		end
	    end

	  fun empty_tel_code () =
	    let
	      val dflt_code = case dflt of
		NONE => []
	      | SOME _ =>
		  [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG dflt_tag)]
	    in
	      (MirTypes.COMMENT "nil main def" :: dflt_code, no_code)
	    end

	  fun find_large_value to_bignum (v1, v2) =
	    let
	      val v = to_bignum v1
	    in
	      v2
	    end
	  handle
	  BigNum.Unrepresentable => v1
	| BigNum32.Unrepresentable => v1

	  fun scon_code (scon, max_size_opt) =
	    (* Returns (main_default, main_code).   Both opcode lists.
	     main_default: the code for the default case
	     main_code : the code for the non-default cases *)
	    (* From a special constant match, use a computed goto for ints
	     in a suitably small range, and multiple tests and branches
	     for other int cases, reals and strings. *)
	    (* We now have to deal with chars, which could in some cases
	     be treated as constructors from a set of 256.
	     Also there are words. *)
	    (case scon of
	       Ident.INT _ =>
		 let
		   (* 32-bit ints are stored as four-byte strings on
		    32-bit architectures, and require special code. *)
		   val is_32_bits =
		     case max_size_opt of
		       NONE => false
		     | SOME sz =>
			 if sz <= MachSpec.bits_per_word then
			   false
			 else if sz = 32 then
			   true
                              else
                                Crash.impossible
				("Unknown integer size in pattern " ^ Int.toString sz)
		   (* clean_code cleans the register that holds the
		    unboxed 32-bit value. *)
		   val (the_reg, extra, clean_code) =
		     if is_32_bits then
		       case arg_regs of
			 Mir_Utils.ONE reg => Mir_Utils.get_word32 reg
		       |  _ =>
			   Crash.impossible "LIST found in switch on Integer32"
		     else
		       let
			 val (reg, code) = Mir_Utils.send_to_reg arg_regs
		       in
			 (reg, code, [])
		       end
		 in
		   let
		     fun do_conversion (AugLambda.SCON_TAG (Ident.INT (i,location), max_size_opt),
					code, tag) =
		       (Mir_Utils.convert_int (i, max_size_opt), 0, code, tag)
		       | do_conversion _ = Crash.impossible "Mixed tag type in switch"

		     (* If we get here (i.e. no exception has been
		      raised), then all the scons fit in integers
		      of the compiling machine.  We still don't
			know the size of the value being switched on. *)
		     val val_le_tags_list =
		       Lists.qsort
		       (fn ((i:int,_,_,_), (i',_,_,_)) => i < i')
		       (map do_conversion tagged_code)

		     (* Patch for Jont *)
		     val a_value = case val_le_tags_list of
		       {1=i, ...} :: _ => i
		     | _ => Crash.impossible"empty val_le_tags_list"

		     val (low, high) =
		       bounds (a_value, a_value, map #1 val_le_tags_list)

		     val len = length val_le_tags_list

		     val use_cgt =
		       not (is_32_bits) andalso
		       high + 1 - low <= 2 * len andalso len > 2

		     (* Not too many holes, but a bigger than two list *)

		     (* We possibly could construct a computed goto for
		      32 bit integers, since all the patterns fit in
		      single integers.  We would first test the argument
		      to see if the top two bits were set, branching
		      to the default case if so, and shifting left by
		      two otherwise. *)

		     val dflt_code = case dflt of
		       NONE =>
			 [MirTypes.COMMENT
			  "No default (strange for scon match)"]
		     | SOME _ =>
			 if is_32_bits then
			   [MirTypes.COMMENT "Default",
			    MirTypes.TEST
			    (MirTypes.BGT, dflt_tag, the_reg,
			     MirTypes.GP_IMM_ANY high)]
			 else
			   [MirTypes.COMMENT "Default",
			    MirTypes.TEST
			    (MirTypes.BGT, dflt_tag, the_reg,
			     MirTypes.GP_IMM_INT high)]
		   in
		     if use_cgt then
		       (extra @ dflt_code,
			make_cgt
			(the_reg, low, high,
			 map
			 (fn (x,_, y, z) => (x, y, z))
			 val_le_tags_list))
		     else
		       let
			 fun do_test(reg, i, _, tag) =
			   if is_32_bits then
			     {test_code =
			      Sexpr.ATOM
			      [MirTypes.TEST
			       (MirTypes.BEQ, tag, reg,
				MirTypes.GP_IMM_ANY i)],
			      test_clean = []}
			   else
			     {test_code =
			      Sexpr.ATOM
			      [MirTypes.TEST
			       (MirTypes.BEQ, tag, reg,
				MirTypes.GP_IMM_INT i)],
			      test_clean = []}
		       in
			 (extra,
			  do_chained_tests
			  (the_reg, dflt, val_le_tags_list,
			   SOME do_test, clean_code))
		       end
		   end
		 handle
		 Mir_Utils.ConvertInt =>
		   (* If we have values that don't fit in a machine
		    word on the compiling machine, we use runtime
		    evaluation of the integers in the patterns. *)
		   let
		     fun to_string(Ident.INT(i,_)) = i
		       | to_string _ =
		       Crash.impossible"Mixed tag type in switch"

		     fun location_scon(Ident.INT(_, location)) =
		       location
		       |   location_scon _ =
		       Crash.impossible"Mixed tag type in switch"

		     fun to_bignum x =
		       let
			 val str_x = to_string x
		       in
			 if size str_x < 2 then
			   BigNum.string_to_bignum str_x
			 else
			   case substring (* could raise Substring *)(str_x, 0, 2)
			     of "0x" =>
			       BigNum.hex_string_to_bignum str_x
			   | _ =>
			       BigNum.string_to_bignum str_x
		       end

		     (* Again, 32-bit values are a special case. *)
		     fun to_bignum32 x =
		       let
			 val str_x = to_string x
		       in
			 if size str_x < 2 then
			   BigNum32.string_to_bignum str_x
			 else
			   case substring (* could raise Substring *)(str_x, 0, 2)
			     of "0x" =>
			       BigNum32.hex_string_to_bignum str_x
			   | _ =>
			       BigNum32.string_to_bignum str_x
		       end

		     fun compare_bignums ((i,_,_,_), (i',_,_,_)) =
		       BigNum.<(to_bignum i, to_bignum i')
		       handle BigNum.Unrepresentable =>
			 let
			   val i = find_large_value to_bignum (i, i')
			 in
			   Info.error'
			   error_info
			   (Info.FATAL, location_scon i,
			    "Integer too big: " ^ to_string i)
			 end

		     fun compare_bignums32 ((i,_,_,_), (i',_,_,_)) =
		       BigNum32.<(to_bignum32 i, to_bignum32 i')
		       handle BigNum32.Unrepresentable =>
			 let
			   val i = find_large_value to_bignum32 (i, i')
			 in
			   Info.error'
			   error_info
			   (Info.FATAL, location_scon i,
			    "Integer too big: " ^ to_string i)
			 end

		     (* This is the equivalent of do_conversion in the
		      main case.  It differs in that it doesn't
		      convert the scon. *)
		     fun check_tag
		       (AugLambda.SCON_TAG (scon, _), code, tag) =
		       (scon, 0, code, tag)
		       |   check_tag _ =
		       Crash.impossible"Mixed tag type in switch"

		     val val_le_tags_list =
		       Lists.qsort
		       (if is_32_bits then
			  compare_bignums32
			else
			  compare_bignums)
			  (map check_tag tagged_code)

		     val low =
		       case val_le_tags_list of
			 (scon,_,_,_) :: _ => scon
		       | _ => Crash.impossible "Empty switch list"

		     val high =
		       case (last val_le_tags_list) of
			 (scon,_,_,_) => scon

		     fun do_test(reg, long_i,_, tag) =
		       let
			 val (reg', the_code) =
			   (case cg_sub(Mir_Utils.convert_long_int (long_i, max_size_opt), env,
					static_offset, start_at,false,
					(closure,funs_in_closure, fn_tag_list,local_fns),
					!spills,!calls) of
			      (Mir_Utils.ONE(Mir_Utils.INT(r as MirTypes.GP_GC_REG _)),
			       ((code, [], NONE, Sexpr.NIL),
				[], []),_,_,_) => (r, code)
			      | _ => Crash.impossible"Bad code for big integer")
			      handle
			      Mir_Utils.Unrepresentable =>
				Info.error'
				error_info
				(Info.FATAL, location_scon long_i,
				 "Integer too big: " ^ to_string long_i)

			 val (arg_reg, arg_code, arg_clean) =
			   Mir_Utils.get_word32 (Mir_Utils.INT reg')

			 val test =
			   MirTypes.TEST
			   (MirTypes.BEQ, tag, reg, arg_reg)
		       in
			 {test_code =
			  Sexpr.CONS
			  (the_code,
			   Sexpr.ATOM (arg_code @ [test ])),
			  test_clean = arg_clean}
		       end
		   in
		     (extra,
		      do_chained_tests
		      (the_reg, dflt, val_le_tags_list,
		       SOME do_test, clean_code))
		   end (* of handler *)
		 end (* of INTSCON case *)
	     | Ident.WORD _ =>
		 (* Words are very much like ints *)
		 (* 32-bit words are stored as four-byte strings on
		  32-bit architectures, and require special code. *)
		 let
		   val is_32_bits =
		     case max_size_opt
		       of NONE => false
		     |  SOME sz =>
			 if sz <= MachSpec.bits_per_word then
			   false
			 else if sz = 32 then
			   true
			      else
				Crash.impossible
				("Unknown word size in pattern "
				 ^ Int.toString sz)

		   val (the_reg, extra, clean_code) =
		     if is_32_bits then
		       case arg_regs
			 of Mir_Utils.ONE reg =>
			   Mir_Utils.get_word32 reg
		       |  _ =>
			   Crash.impossible
			   "LIST found in switch on Word32"
		     else
		       let
			 val (reg, code) = Mir_Utils.send_to_reg arg_regs
		       in
			 (reg, code, [])
		       end
		 in
		   let
		     fun do_conversion
		       (AugLambda.SCON_TAG
			(Ident.WORD (i,location), max_size_opt),
			code, tag) =
		       (Mir_Utils.convert_word (i, max_size_opt),
			0, code, tag)
		       |   do_conversion _ =
		       Crash.impossible "Mixed tag type in switch"

		     (* If we get here (i.e. no exception has been
		      raised), then all the scons fit in words
		      of the compiling machine.  We still don't know
			the size of the value being switched on. *)
		     val val_le_tags_list =
		       Lists.qsort
		       (fn ((i:int,_,_,_), (i',_,_,_)) => i < i')
		       (map do_conversion tagged_code)

		     (* Patch for Jont *)
		     val a_value = case val_le_tags_list of
		       {1=i, ...} :: _ => i
		     | _ => Crash.impossible"empty val_le_tags_list"

		     val (low, high) =
		       bounds (a_value, a_value, map #1 val_le_tags_list)

		     val len = length val_le_tags_list

		     val use_cgt =
		       not (is_32_bits) andalso
		       high + 1 - low <= 2 * len andalso len > 2

		     (* Not too many holes, but a bigger than two list *)

		     (* We possibly could construct a computed goto for
		      32 bit words, since all the patterns fit in
		      single words.  We would first test the argument
		      to see if the top two bits were set, branching
		      to the default case if so, and shifting left by
		      two otherwise. *)

		     val dflt_code = case dflt of
		       NONE =>
			 [MirTypes.COMMENT
			  "No default (strange for scon match)"]
		     | SOME _ =>
			 if is_32_bits then
			   [MirTypes.COMMENT "Default",
			    MirTypes.TEST
			    (MirTypes.BHI, dflt_tag, the_reg,
			     MirTypes.GP_IMM_ANY high)]
			 else
			   [MirTypes.COMMENT "Default",
			    MirTypes.TEST
			    (MirTypes.BHI, dflt_tag, the_reg,
			     MirTypes.GP_IMM_INT high)]
		   in
		     if use_cgt then
		       (extra @ dflt_code,
			make_cgt
			(the_reg, low, high,
			 map
			 (fn (x,_, y, z) => (x, y, z))
			 val_le_tags_list))
		     else
		       let
			 fun do_test(reg, i, _, tag) =
			   if is_32_bits then
			     {test_code =
			      Sexpr.ATOM
			      [MirTypes.TEST
			       (MirTypes.BEQ, tag, reg,
				MirTypes.GP_IMM_ANY i)],
			      test_clean = []}
			   else
			     {test_code =
			      Sexpr.ATOM
			      [MirTypes.TEST
			       (MirTypes.BEQ, tag, reg,
				MirTypes.GP_IMM_INT i)],
			      test_clean = []}
		       in
			 (extra,
			  do_chained_tests
			  (the_reg, dflt, val_le_tags_list,
			   SOME do_test, clean_code))
		       end
		   end
		 handle
		 Mir_Utils.ConvertInt =>
		   (* If we have values that don't fit in a machine
		    word on the compiling machine, we use runtime
		    evaluation of the words in the patterns. *)
		   let
		     fun to_string(Ident.WORD(i,_)) = i
		       | to_string _ =
		       Crash.impossible"Mixed tag type in switch"

		     fun location_scon(Ident.WORD(_, location)) =
		       location
		       |   location_scon _ =
		       Crash.impossible"Mixed tag type in switch"

		     fun to_bignum x =
		       let
			 val str_x = to_string x
		       in
			 if size str_x < 3 then
			   BigNum.word_string_to_bignum str_x
			 else
			   case substring (* could raise Substring *)(str_x, 0, 3)
			     of "0wx" =>
			       BigNum.hex_word_string_to_bignum str_x
			   | _ =>
			       BigNum.word_string_to_bignum str_x
		       end

		     (* Again, 32-bit values are a special case. *)
		     fun to_bignum32 x =
		       let
			 val str_x = to_string x
		       in
			 if size str_x < 3 then
			   BigNum32.word_string_to_bignum str_x
			 else
			   case substring (* could raise Substring *)(str_x, 0, 3)
			     of "0wx" =>
			       BigNum32.hex_word_string_to_bignum str_x
			   | _ =>
			       BigNum32.word_string_to_bignum str_x
		       end

		     fun compare_bignums ((i,_,_,_), (i',_,_,_)) =
		       BigNum.<(to_bignum i, to_bignum i')
		       handle BigNum.Unrepresentable =>
			 let
			   val i = find_large_value to_bignum (i, i')
			 in
			   Info.error'
			   error_info
			   (Info.FATAL, location_scon i,
			    "Word too big: " ^ to_string i)
			 end

		     fun compare_bignums32 ((i,_,_,_), (i',_,_,_)) =
		       BigNum32.<(to_bignum32 i, to_bignum32 i')
		       handle BigNum32.Unrepresentable =>
			 let
			   val i = find_large_value to_bignum32 (i, i')
			 in
			   Info.error'
			   error_info
			   (Info.FATAL, location_scon i,
			    "Word too big: " ^ to_string i)
			 end

		     (* This is the equivalent of do_conversion in the
		      main case.  It differs in that it doesn't
		      convert the scon. *)
		     fun check_tag
		       (AugLambda.SCON_TAG (scon, _), code, tag) =
		       (scon, 0, code, tag)
		       |   check_tag _ =
		       Crash.impossible"Mixed tag type in switch"

		     val val_le_tags_list =
		       Lists.qsort
		       (if is_32_bits then
			  compare_bignums32
			else
			  compare_bignums)
			  (map check_tag tagged_code)

		     val low =
		       case val_le_tags_list of
			 (scon,_,_,_) :: _ => scon
		       | _ => Crash.impossible "Empty switch list"

		     val high =
		       case (last val_le_tags_list) of
			 (scon,_,_,_) => scon

		     fun do_test(reg, long_i,_, tag) =
		       let
			 val (reg', the_code) =
			   (case cg_sub(Mir_Utils.convert_long_word (long_i, max_size_opt), env,
					static_offset, start_at,false,
					(closure,funs_in_closure, fn_tag_list,local_fns),
					!spills,!calls) of
			      (Mir_Utils.ONE(Mir_Utils.INT(r as MirTypes.GP_GC_REG _)),
			       ((code, [], NONE, Sexpr.NIL),
				[], []),_,_,_) => (r, code)
			      | _ => Crash.impossible"Bad code for big word")
			      handle
			      Mir_Utils.Unrepresentable =>
				Info.error'
				error_info
				(Info.FATAL, location_scon long_i,
				 "Word too big: " ^ to_string long_i)

			 val (arg_reg, arg_code, arg_clean) =
			   Mir_Utils.get_word32 (Mir_Utils.INT reg')

			 val test =
			   MirTypes.TEST
			   (MirTypes.BEQ, tag, reg, arg_reg)
		       in
			 {test_code =
			  Sexpr.CONS
			  (the_code,
			   Sexpr.ATOM (arg_code @ [test ])),
			  test_clean = arg_clean}
		       end
		   in
		     (extra,
		      do_chained_tests
		      (the_reg, dflt, val_le_tags_list,
		       SOME do_test, clean_code))
		   end (* of handler *)
		 end (* of WORDSCON case *)
	     | Ident.CHAR _ =>
		 let
		   val (the_reg, extra) = Mir_Utils.send_to_reg arg_regs
		 in
		   let
		     val val_le_tags_list =
		       Lists.qsort (fn ((i:int,_,_,_), (i',_,_,_)) =>
				    i < i')
		       (map (fn (AugLambda.SCON_TAG(Ident.CHAR s, _), code, tag) =>
			     (ord(String.sub (s, 0)), 0, code, tag)
		     | _ => Crash.impossible"Mixed tag type in switch")
			tagged_code)
		     (* Patch for Jont *)
		     val a_value = case val_le_tags_list of
		       {1=i, ...} :: _ => i
		     | _ => Crash.impossible"empty val_le_tags_list"
		     val (low, high) = bounds(a_value, a_value, map #1 val_le_tags_list)
		     val len = length val_le_tags_list
		     val use_cgt = high + 1 - low <= 2 * len andalso len > 2
		     (* Not too many holes, but a bigger than two list *)

		     val dflt_code = case dflt of
		       NONE => [MirTypes.COMMENT"No default (strange for scon match)"]
		     | SOME _ =>
			 [MirTypes.COMMENT "Default",
			  MirTypes.TEST(MirTypes.BHI, dflt_tag, the_reg,
					MirTypes.GP_IMM_INT high)]
		   in
		     if use_cgt then
		       (extra @ dflt_code,
			make_cgt(the_reg, low, high,
				 map
				 (fn (x,_, y, z) => (x, y, z))
				 val_le_tags_list))
		     else
		       let
			 fun do_test(reg, i,_, tag) =
			   {test_code =
			    Sexpr.ATOM
			    [MirTypes.TEST(MirTypes.BEQ, tag, reg,
					   MirTypes.GP_IMM_INT i)],
			    test_clean = []}
		       in
			 (extra,
			  do_chained_tests(the_reg,
					   dflt,
					   val_le_tags_list,
					   SOME do_test,
					   []))
		       end
		   end
		 end (* of CHARSCON case *)
	     | Ident.REAL _ =>
		 (* The real case *)
		 let
		   val val_le_tags_list =
		     map (fn ((AugLambda.SCON_TAG(Ident.REAL _, _), code, tag), p) =>
			  (p, 0, code, tag)
		   | _ => Crash.impossible"Mixed tag type in switch")
		     (Lists.zip(tagged_code, tag_positions))
		   val (the_reg, extra) =
		     case arg_regs of
		       Mir_Utils.ONE reg => Mir_Utils.get_real reg
		     | _ => Crash.impossible "struct gives single REAL"

		   fun do_test(reg, i,_, tag) =
		     (* reg is the value input,
		      i is the immediate constant (in the case of an int)
		      or the position in the closure for this function,
		      relative to static_offset + funs_in_closure
		      in the case of a real or string
		      tag is where to go to on successful comparison *)
		     let
		       val fp_op = MirTypes.FP_REG(MirTypes.FP.new())
		     in
		       {test_code =
			Sexpr.ATOM
			[MirTypes.STOREOP
			 (MirTypes.LD,
			  MirTypes.GC_REG MirRegisters.global,
			  MirTypes.GC_REG callee_closure,
			  MirTypes.GP_IMM_ANY
			  (4 * (static_offset + i + (funs_in_closure * 2 - 1)) - 1)),
			 MirTypes.STOREFPOP
			 (MirTypes.FLD, fp_op,
			  MirTypes.GC_REG MirRegisters.global,
			  MirTypes.GP_IMM_ANY real_offset),
			 MirTypes.FTEST(MirTypes.FBEQ, tag, fp_op, reg)],
			test_clean = []}
		     end

		   val tags_code =
		     map
		     (fn (p, (t,_)) =>
		      case t of
			AugLambda.SCON_TAG(scon as Ident.REAL _, _) =>
			  MirTypes.VALUE(top_closure (start_at + p + 1),
					 MirTypes.SCON scon)
		      | _ => Crash.impossible"non-REAL in REAL switch"
			  )
		     (Lists.zip(tag_positions, tag_le_list))
		 in
		   (extra,
		    Mir_Utils.combine(((Sexpr.NIL, [], NONE, Sexpr.NIL), tags_code, []),
				      do_chained_tests(the_reg, dflt, val_le_tags_list, SOME do_test, [])))
		 end (* of REALSCON case *)
	     | Ident.STRING _ =>
		 let
		   val val_le_tags_list =
		     map
		     (fn ((AugLambda.SCON_TAG(Ident.STRING _, _), code, tag), p) =>
		      (p, 0, code, tag)
		   | _ => Crash.impossible"Mixed tag type in switch")
		     (Lists.zip(tagged_code, tag_positions))
		   val the_reg =
		     case arg_regs of
		       Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_GC_REG _)) => arg
		     | _ => Crash.impossible"struct gives single STRING"

		   fun do_test(reg, i,_, tag) =
		     (* reg is the value input,
		      i is the immediate constant (in the case of an int)
		      or the position in the closure for this function,
		      relative to static_offset + funs_in_closure
		      in the case of a real or string
		      tag is where to go to on successful comparison *)
		     let
		       val scon_reg = MirTypes.GC_REG(MirTypes.GC.new())
		       val (regs', the_code',runtime_env'',spills',calls') =
			 cg_sub(AugLambda.VAR(prim_to_lambda Pervasives.STRINGEQ),
				env, static_offset, start_at,false,
				(closure,funs_in_closure, [], []),!spills,!calls)
		       val _ = calls := calls'
		       val _ = spills := spills'
		       val _ =
			 runtime_env' := append_runtime_envs(runtime_env',runtime_env'')
		       val app_code =
			 case Mir_Utils.do_app(Debugger_Types.null_backend_annotation,
					       regs', the_code',
					       Mir_Utils.ONE (Mir_Utils.INT(MirTypes.GP_GC_REG
									    caller_arg)),
					       no_code)
			   of
			     (_, ((app_code, [], NONE, last), [], [])) =>
			       (case Mir_Utils.contract_sexpr last of
				  [] => app_code
				| _ => Crash.impossible"Bad result for STRINGEQ")
			   | _ => Crash.impossible"Bad result for STRINGEQ"
		     in
		       {test_code =
			Sexpr.CONS
			(Sexpr.ATOM
			 [MirTypes.STOREOP
			  (MirTypes.LD, scon_reg,
			   MirTypes.GC_REG callee_closure,
			   MirTypes.GP_IMM_ANY
			   (4 * (static_offset + i + (2 * funs_in_closure - 1)) - 1)),
			  MirTypes.ALLOCATE_STACK
			  (MirTypes.ALLOC,
			   MirTypes.GC_REG caller_arg,
			   2, NONE),
			  MirTypes.STOREOP
			  (MirTypes.ST,
			   Mir_Utils.reg_from_gp the_reg,
			   MirTypes.GC_REG caller_arg,
			   MirTypes.GP_IMM_ANY ~1),
			  MirTypes.STOREOP
			  (MirTypes.ST, scon_reg,
			   MirTypes.GC_REG caller_arg,
			   MirTypes.GP_IMM_ANY 3),
			  MirTypes.COMMENT "Call external STRINGEQ"],
			 Sexpr.CONS
			 (app_code,
			  Sexpr.ATOM
			  [MirTypes.DEALLOCATE_STACK
			   (MirTypes.ALLOC, 2),
			   MirTypes.TEST
			   (MirTypes.BEQ, tag,
			    MirTypes.GP_GC_REG caller_arg,
			    MirTypes.GP_IMM_INT 1)])),
			test_clean = []}
		     end
		   val tags_code =
		     map
		     (fn (p, (t,_)) =>
		      case t of
			AugLambda.SCON_TAG (scon as Ident.STRING _, _) =>
			  MirTypes.VALUE(
					 top_closure(start_at + p + 1),
					 MirTypes.SCON scon)
		      | _ =>
			  Crash.impossible"non-STRING in STRING switch")
		     (Lists.zip(tag_positions, tag_le_list))
		 in
		   ([],
		    Mir_Utils.combine(((Sexpr.NIL, [], NONE, Sexpr.NIL), tags_code, []),
				      do_chained_tests(the_reg, dflt, val_le_tags_list, SOME do_test, [])))
		 end (* of STRINGSCON case *) )

	  fun exp_code () =
	    (* From an exception constructor match, use tests and branches *)
	    let
	      val val_le_tags_list =
		map
		(fn (AugLambda.EXP_TAG{lexp=le, ...}, code, tag) =>
		 (0, le, code, tag)
	         | _ => Crash.impossible"Mixed tag type in switch")
		tagged_code
	      val the_reg =
		case arg_regs of
		  Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_GC_REG _)) => arg
		| _ => Crash.impossible"Bad reg for exception"
	      fun do_test(reg,_, le, tag) =
		(* reg is the value input,
		 le is the exception expression to match
		 tag is where to go to on successful comparison *)
		let
		  val (regs, the_code) =
		    case cg_sub(le, env, static_offset, start_at,false,
				(closure,funs_in_closure, [],[]),!spills,!calls) of
		      (Mir_Utils.ONE(Mir_Utils.INT(reg as MirTypes.GP_GC_REG _)),
		       ((code, [], NONE, last), [], []),
		       runtime_env'',spills',calls') =>
		      (calls := calls';
		       spills := spills';
		       runtime_env' := append_runtime_envs(runtime_env',runtime_env'');
		       (case Mir_Utils.contract_sexpr last of
			  [] => (reg, code)
			| _ => Crash.impossible"Bad result from cg(exception)"))
		     | _ =>
		      Crash.impossible"Bad result from cg(exception)"
		(* Get the value to test against *)
		in
		  {test_code =
		   Sexpr.CONS
		   (the_code,
		    Sexpr.ATOM
		    [MirTypes.TEST(MirTypes.BEQ, tag, reg, regs)]),
		   test_clean = []}
		end
	    in
	      ([], do_chained_tests(the_reg, dflt, val_le_tags_list, SOME do_test, []))
	    end

	  (* End of auxiliary functions *)

	  (* Despatch on type of switch *)
	  (* main_default: the code for the default case *)
	  (* main_code : the code for the non-default cases *)

	  val (main_default, main_code) =
	    case tag_le_list of
	      [] => empty_tel_code ()
	    | (AugLambda.IMM_TAG _,_) :: _ => constructor_code ()
	    | (AugLambda.VCC_TAG _,_) :: _ => constructor_code ()
	    | (AugLambda.SCON_TAG scon,_) :: rest => scon_code scon
	    | (AugLambda.EXP_TAG _,_) :: rest => exp_code ()

	  (* Put it all together *)
	  val result_code =
	    Mir_Utils.combine
	    (Mir_Utils.combine
	     (switch_arg_code,
	      Mir_Utils.combine
	      (((Sexpr.NIL, [], SOME main_tag,
		 Sexpr.ATOM main_default),
		[],
		[]),
	       main_code
	       )
	      ),
	     ((Sexpr.NIL, dflt_blocks, SOME end_tag,
	       Sexpr.ATOM[MirTypes.COMMENT"End of switch"]),
	      dflt_values,
	      dflt_procs)
	     )
	in
(*
		  let
		    val (_, _, fp_spills) = !spills
		  in
		    output(std_out,
			   "After cg_sub(SWITCH), fp_spill = " ^ Int.toString fp_spills ^ "\n")
		  end;
*)
	  (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG end_reg)), result_code,
	   if variable_debug
	     then RuntimeEnv.SWITCH(!runtime_env',ref_slot,
				    maximum_calls,switch_runtime_env)
	   else RuntimeEnv.EMPTY,
	     !spills,!calls)
	end
      end

    | cg_sub(arg as AugLambda.VAR lvar,env,_,_,_,(closure,funs_in_closure,_,_),spills,calls) =
    let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(VAR), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating VAR\n",
	LambdaPrint.string_of_lambda arg, " funs_in_closure = " ^ Int.toString funs_in_closure ^ "\n"])
*)
      val (reg, code) = Mir_Utils.cg_lvar_fn(lvar, env, closure, funs_in_closure)
    in
      (Mir_Utils.ONE reg, ((Sexpr.ATOM code, [], NONE,
			    Sexpr.NIL), [], []),RuntimeEnv.EMPTY,spills,calls)
    end

    | cg_sub(arg as AugLambda.INT i,_,_,_,_,_,spills,calls) =
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(INT), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
      val _ =
	Diagnostic.output 4
	(fn i => ["Mir generating INT\n",
	LambdaPrint.string_of_lambda arg])
*)
      in
	(Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_IMM_INT i)), no_code,
         RuntimeEnv.EMPTY,spills,calls)
      end
    | cg_sub(arg as AugLambda.SCON (scon, size), e,static_offset, start_at,tail_position,
	     (closure,funs_in_closure, fn_tag_list, local_fns),spills,calls) =
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(SCON), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
	val _ =
	  Diagnostic.output 4
	  (fn i => ["Mir generating SCON\n",
		    LambdaPrint.string_of_lambda arg])
*)
      in
	(case scon of
	   Ident.INT(i,location) =>
	   ((let
	       val w = Mir_Utils.convert_int (i, size)
	     in
	       case size
	       of NONE =>
		 (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_IMM_INT w)),
	          no_code,RuntimeEnv.EMPTY,spills,calls)
	       |  SOME sz =>
	         if sz <= MachSpec.bits_per_word then
		   (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_IMM_INT w)),
	            no_code,RuntimeEnv.EMPTY,spills,calls)
	         else if sz = 32 then
		   (* NB. If bits_per_word >= 32, this code is not used *)
		   convert32 (w, sz, spills, calls)
		 else
		   Crash.impossible
		     ("unknown int size " ^ Int.toString sz)
	     end
	     handle Mir_Utils.ConvertInt =>
	       (* The value is too large to fit in one word on the compiler's
		  machine, but may fit on the target machine.  Compile an
		  expression to calculate the value instead of using an
		  immediate value. *)
	           cg_sub(Mir_Utils.convert_long_int (scon, size), e,
		          static_offset,start_at,tail_position,
		          (closure,funs_in_closure,fn_tag_list,local_fns),
		          spills,calls))
	      handle
	        Mir_Utils.Unrepresentable =>
	          Info.error'
	            error_info
		    (Info.FATAL, location, "Integer too big: " ^ i))
	 | Ident.WORD(i, location) =>
	   ((let
	       val w = Mir_Utils.convert_word (i, size)
	     in
	       case size
	       of NONE =>
		 (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_IMM_INT w)),
	          no_code,RuntimeEnv.EMPTY,spills,calls)
	       |  SOME sz =>
	         if sz <= MachSpec.bits_per_word then
		   (Mir_Utils.ONE (Mir_Utils.INT (MirTypes.GP_IMM_INT w)),
	            no_code,RuntimeEnv.EMPTY,spills,calls)
	         else if sz = 32 then
		   (* NB. If bits_per_word >= 32, this code is not used *)
		   convert32 (w, sz, spills, calls)
		 else
		   Crash.impossible
		     ("unknown word size " ^ Int.toString sz)
	     end
	     handle Mir_Utils.ConvertInt =>
	       (* The value is too large to fit in one word on the compiler's
		  machine, but may fit on the target machine.  Compile an
		  expression to calculate the value instead of using an
		  immediate value. *)
	           cg_sub(Mir_Utils.convert_long_word (scon, size), e,
		          static_offset,start_at,tail_position,
		          (closure,funs_in_closure,fn_tag_list,local_fns),
		          spills,calls))
	    handle
	      Mir_Utils.Unrepresentable =>
	        Info.error'
	          error_info
		  (Info.FATAL, location, "Word too big: " ^ i))

	 | Ident.CHAR s =>
	     (Mir_Utils.ONE
	      (Mir_Utils.INT
	       (MirTypes.GP_IMM_INT
		(ord (String.sub(s, 0))))),
	      no_code,RuntimeEnv.EMPTY,spills,calls)
	 | _ =>
	     let
	       val new_reg = MirTypes.GC.new()
	       val new_tag =
		 top_closure(start_at + 1)
	     in
	       (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG new_reg)),
		((Sexpr.ATOM[MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
					      MirTypes.GC_REG callee_closure,
					      MirTypes.GP_IMM_ANY(4*(static_offset +
                                                                     (funs_in_closure * 2 - 1)) - 1))],
	      [],
	      NONE, Sexpr.NIL),
	      [MirTypes.VALUE(new_tag, MirTypes.SCON scon)],
	      []),RuntimeEnv.EMPTY,spills,calls)
	end)
      end
    | cg_sub(arg as AugLambda.MLVALUE mlvalue,_,static_offset, start_at,_,
	     (closure,funs_in_closure,_,_),spills,calls) =
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(MLVALUE), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
*)
        val new_reg = MirTypes.GC.new()
        val new_tag = top_closure(start_at + 1)
      in
        (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG new_reg)),
         ((Sexpr.ATOM[MirTypes.STOREOP(MirTypes.LD, MirTypes.GC_REG new_reg,
                                       MirTypes.GC_REG callee_closure,
                                       MirTypes.GP_IMM_ANY(4*(static_offset +
                                                              (funs_in_closure * 2 - 1)) - 1))],
         [],
         NONE, Sexpr.NIL),
         [MirTypes.VALUE(new_tag, MirTypes.MLVALUE mlvalue)],
         []),RuntimeEnv.EMPTY,spills,calls)
      end

    (* Non recursive function case *)
    | cg_sub(fcn as AugLambda.FN((lvl,fp_vars),
                                 {lexp=lexp, size=gc_objects_within},
				 name_string,instances),
	     env, static_offset,start_at,_,
             (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
      let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(FN), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
*)
(*
        val _ = case fp_vars of [] => ()
          | _ => (print (name_string ^ ":");
                  Lists.iterate (fn v => print (N v ^ " ")) fp_vars;
                  print "\n")
*)
        val _ =
          if do_diagnostics
            then
              if LambdaTypes.isLocalFn instances then print "local function found\n"
              else if name_string = "letbody fun" then print "letbody found\n"
              else if name_string = "switch body<Match>" then print "switch body found\n"
              else ()
          else ()

        val restore_spills = spill_restorer ()
        val _ = initialize_spills()

        (* Determine the free variables of the function *)
        val free = find_frees (env,closure,fcn,prim_to_lambda)

        (* The preassigned tag for the function (code vector?) *)
        val tag = top_closure (start_at + gc_objects_within + 1)
        val gc_reg = MirTypes.GC_REG(MirTypes.GC.new())

        (* Code to make the closure *)

        val (cl_reg, code, new_closure) =
          case Mir_Utils.make_closure([tag], free, gc_objects_within,
                                      static_offset + (funs_in_closure * 2 - 1), env,
                                      closure, funs_in_closure) of
            (reg, code, [new_closure]) =>
              (reg,
               Sexpr.CONS(code,
                          Sexpr.ATOM[MirTypes.COMMENT"Copy in function pointer",
                                     MirTypes.STOREOP(MirTypes.LD, gc_reg,
                                                      MirTypes.GC_REG callee_closure,
                                                      MirTypes.GP_IMM_ANY(4*((funs_in_closure*2-1) + static_offset +
                                                                             gc_objects_within) - 1)),
                                     MirTypes.STOREOP(MirTypes.ST, gc_reg, reg,
                                                      MirTypes.GP_IMM_ANY ~1)]),
               new_closure)
          | _ => Crash.impossible"Single FN with multiple tags"

        (* Now for the function itself *)

        val arg_regs = assign_callee_regs lvl
        val fp_arg_regs = assign_fp_regs fp_vars
        val internal_regs = map (fn lvar => (lvar,MirTypes.GC.new())) lvl
        val fp_internal_regs = map (fn lvar => (lvar,MirTypes.FP.new())) fp_vars

        val comment_string =
          if name_string = ""
            then []
          else [MirTypes.COMMENT name_string]

        (* Enter the function *)

        (* Move the arguments to somewhere safe, and let register colouring deal with allocation *)
        val entry_code =
          (Sexpr.ATOM
           (comment_string @
            [MirTypes.ENTER (map MirTypes.GC arg_regs @ map MirTypes.FLOAT fp_arg_regs)] @
            (* Put the intercept call right after function entry *)
            (if intercept then [MirTypes.INTERCEPT] else []) @
             make_get_args_code (arg_regs,map #2 internal_regs) @
             make_fp_get_args_code (fp_arg_regs,map #2 fp_internal_regs)),
           [], NONE, Sexpr.NIL)

        val lambda_env =
          lists_reducel
          (fn (env,(lvar,copy)) =>
           Mir_Env.add_lambda_env((lvar, MirTypes.GC copy),env))
          (Mir_Env.empty_lambda_env,internal_regs)

        val lambda_env =
          lists_reducel
          (fn (env,(lvar,copy)) =>
           Mir_Env.add_lambda_env((lvar, MirTypes.FLOAT copy),env))
          (lambda_env,fp_internal_regs)

        (* Code generate the body with the args in the assigned registers *)
        val (fn_reg, fn_code,runtime_env,(gc_spills,non_gc_spills,fp_spills),_) =
          cg_letrec_sub(lexp,lambda_env, 0, start_at, true,
                        (new_closure,1, [tag] (* tag for this function *), []),
                        (1,0,0),0)

        (* No information for untupling, cos function doesn't recurse *)

        val exit_code =
          let
            val result_temporary = MirTypes.GC.new ()
          in
            (Sexpr.ATOM (Mir_Utils.send_to_given_reg(fn_reg, result_temporary) @
                         [MirTypes.UNARY(MirTypes.MOVE,
                                         MirTypes.GC_REG callee_arg,
                                         MirTypes.GP_GC_REG result_temporary),
                          MirTypes.RTS]),
            [], NONE, Sexpr.NIL)
          end

        (* And put it all together *)
        val ((first, blocks, tag_opt, last), values, procs) =
          Mir_Utils.combine((entry_code, [], []), Mir_Utils.combine (make_call_code (0,fn_code), (exit_code, [], [])))

        val spill_sizes =
          if variable_debug
            then SOME{gc = gc_spills+1,
                                non_gc = non_gc_spills+1,
                                fp = fp_spills+1}
          else NONE

        val runtime_env =
          if variable_debug
            then RuntimeEnv.FN (name_string,runtime_env,head_spill (get_current_spills ()),instances)
          else RuntimeEnv.EMPTY

        val the_fn =
          [MirTypes.PROC(name_string,
                         tag,
                         MirTypes.PROC_PARAMS {spill_sizes =  spill_sizes,
					       old_spill_sizes = NONE,
                                               stack_allocated = NONE},
                         MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr first) ::
                         blocks @
                         (case tag_opt of
                            NONE => []
                          | SOME tag =>
                              [MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr last)]),
                         runtime_env)]

        val _ = restore_spills()
      in
        (Mir_Utils.ONE (Mir_Utils.INT (Mir_Utils.gp_from_reg cl_reg)),
         ((code, [], NONE, Sexpr.NIL),
          values,
          the_fn :: procs),
         RuntimeEnv.EMPTY,spills,calls)
      end

      (* The LETREC case *)
   | cg_sub(exp as AugLambda.LETREC(lv_list, le_list, {lexp=lexp, ...}),
	     env, static_offset, start_at,tail_position,
             (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
    let
      (* Could we not move this down to where used? *)
      val runtime_lets =
        Lists.reducer
        (fn ((lvar, SOME (ref (RuntimeEnv.VARINFO (name,ty,_)))),acc) =>
         (RuntimeEnv.VARINFO (name,ty,NONE),RuntimeEnv.EMPTY) :: acc
      | ((lvar,_),acc) => acc)
        (lv_list,[])

      val lv_list = map #1 lv_list
      val funs = length lv_list

(*
      val _ =
        Lists.iterate
        (fn {lexp=AugLambda.FN((lvl,fp_args),e,name,info),...} =>
         (case fp_args of [] => ()
      | _ => (print (name ^ ":");
	    Lists.iterate (fn v => print (N v ^ " ")) fp_args;
	    print "\n"))
      | _ => ())
        le_list
*)

      (* Make sure all the functions look like functions *)
      val fn_args_and_bodies =
	map
	(fn {lexp=AugLambda.FN((lvl,fp_args), le,_,info), ...} => ((lvl,fp_args), le)
          | _ => Crash.impossible"non-FN in LETREC")
	le_list

      val lambda_names =
	map
	(fn {lexp=AugLambda.FN(_,_,name,instances), ...} => (name,instances)
        | _ => Crash.impossible"non-FN in LETREC")
	le_list

      val _ =
        if do_diagnostics
          then
            Lists.iterate
            (fn ((name,instances),lv) =>
             if LambdaTypes.isLocalFn instances then print ("local function found: " ^ N lv ^ " \n")
             else if name = "letbody fun" then print ("letbody found: " ^ N lv ^ " \n")
             else if name = "switch body<Match>" then print ("switch body found: " ^ N lv ^ "\n")
             else ())
            (zip2 (lambda_names,lv_list))
        else ()

      val (fn_args, fn_bodies) = Lists.unzip fn_args_and_bodies

      val free = find_frees (env,closure,AugLambda.STRUCT fn_bodies,prim_to_lambda)

      val gc_objects_within =
	lists_reducel (fn (x, {size=size, lexp=_}) => x+size) (0, fn_bodies)
      val positions = do_pos3 (0, fn_bodies)
      val offsets =
	map #2 (#1 (Lists.number_from (Mir_Utils.list_of (funs, 0), 0, 2, ident_fn)))
      (* Changed above to allow for interspersed zeroes in closures *)

      val tags =
	map (fn x => top_closure(start_at + gc_objects_within + (x div 2) + 1))
	offsets

      val gc_reg = MirTypes.GC_REG(MirTypes.GC.new())

      val (cl_reg, code, new_closure_list) =
	Mir_Utils.make_closure(tags, free, gc_objects_within,
                               static_offset + (2 * funs_in_closure - 1),
                               env, closure,funs_in_closure)

      val new_reg_list = map (fn x => (x, MirTypes.GC.new())) offsets

      val new_closure_code =
	map
	(fn (0, reg) => MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG reg,
                                       Mir_Utils.gp_from_reg cl_reg)
          | (x, reg) => MirTypes.BINARY(MirTypes.ADDU, MirTypes.GC_REG reg,
					Mir_Utils.gp_from_reg cl_reg,
					MirTypes.GP_IMM_INT x))
	new_reg_list

      (* Load in the code vector pointers *)
      val code = Lists.reducer
	(fn (x, y) => Sexpr.CONS(x, y))
	(code :: Sexpr.ATOM new_closure_code ::
	  Sexpr.ATOM[MirTypes.COMMENT "Copy in function pointers"] :: (map
	  (fn x =>
	    Sexpr.ATOM[MirTypes.STOREOP(MirTypes.LD, gc_reg,
                                        MirTypes.GC_REG callee_closure,
                                        MirTypes.GP_IMM_ANY(4*((funs_in_closure*2-1) + static_offset +
                                                               gc_objects_within + (x div 2)) - 1)),
                       MirTypes.STOREOP(MirTypes.ST, gc_reg, cl_reg,
                                        MirTypes.GP_IMM_ANY(4*x-1))])
	  offsets), Sexpr.NIL)

      (* Pad out the closure with zeros, if necessary *)
      val code = case offsets of
	[] => Crash.impossible"Empty recursive set"
      | [_] => code (* Single recursive function, no padding *)
      | _ =>
	  let
	    val gc_reg = MirTypes.GC_REG(MirTypes.GC.new())
	  in
	    Sexpr.CONS
	    (code,
	     Sexpr.ATOM
	     (MirTypes.UNARY(MirTypes.MOVE, gc_reg, MirTypes.GP_IMM_INT 0) ::
	      map
	      (fn x =>
	       MirTypes.STOREOP(MirTypes.ST, gc_reg, cl_reg,
				MirTypes.GP_IMM_ANY(4*(x-1)-1)))
	      (Lists.tl offsets)))
	  end

      (* Here we generate the code for the function bodies *)

      (* Calculate the closures for the code generation of the functions *)
      val new_closure_list =
	map (fn (closure, offset) =>
	  lists_reducel
	  (fn (clos, (lv, off)) => Mir_Env.add_closure_env((lv, off), clos))
	  (closure, #1 (Lists.number_from(lv_list, 0 - offset, 2, fn x=> x))))
	(Lists.zip(new_closure_list, offsets))

      (* Assign argument registers and copies thereof *)
      val arg_regs_list =
        map (fn (arg_regs,fp_regs) => (assign_callee_regs arg_regs,
                                       assign_fp_regs fp_regs))
        fn_args

      val args_and_copied_callee_arg_list =
	map
        (fn (arg_regs, fp_regs) =>
         (map (fn lvar => (lvar, MirTypes.GC.new())) arg_regs,
          map (fn lvar => (lvar, MirTypes.FP.new())) fp_regs))
         fn_args

      (* The initial environments -- just the parameters are defined *)
      val initial_env_list =
	map
        (fn (arg_reg_copies,fn_arg_reg_copies) =>
         let
           val env =
             lists_reducel
             (fn (env,(lvar, copy)) => Mir_Env.add_lambda_env((lvar, MirTypes.GC copy),env))
             (Mir_Env.empty_lambda_env,arg_reg_copies)
         in
           lists_reducel
           (fn (env,(lvar, copy)) => Mir_Env.add_lambda_env((lvar, MirTypes.FLOAT copy),env))
           (env,fn_arg_reg_copies)
         end)
         args_and_copied_callee_arg_list

      (* Insertion of intercept put here instead of in end_block *)
      (* see comment at that point *)
      fun generate_entry_code ((name,_),arginfo) =
        let
          val comment_for_name =
            if name = ""
              then []
            else [MirTypes.COMMENT name]
        in
          ((Sexpr.ATOM(comment_for_name @ [MirTypes.ENTER arginfo] @
                       (if intercept
                          then [MirTypes.INTERCEPT]
                        else [])),
            [], NONE, Sexpr.NIL), [], [])
        end

      val entry_code_list =
        map
        generate_entry_code
        (Lists.zip (lambda_names,
                    map (fn (arg_regs,fp_arg_regs) =>
                         map MirTypes.GC arg_regs @
                         map MirTypes.FLOAT fp_arg_regs)
                    arg_regs_list))


      (* All bets for registers are off, barring the argument *)
      val arg_copy_list =
	(map (fn ((arg_regs,fp_arg_regs),(arg_copies,fp_arg_copies)) =>
              (make_get_args_code (arg_regs,map #2 arg_copies) @
               make_fp_get_args_code (fp_arg_regs,map #2 fp_arg_copies)))
         (Lists.zip (arg_regs_list,args_and_copied_callee_arg_list)))

      val restore_spills = spill_restorer()

      (* Move and detuple the parameter, if necessary *)
      val code_env_static_start_list =
	map
	(fn (arg_copy, env, new_closure, pos, x) =>
	 let
           val first_spill = initialize_spills()
	   val (static, start,spills,calls) = (pos, start_at + pos, (1,0,0),0)
           val entry_code = ((Sexpr.ATOM arg_copy, [], NONE, Sexpr.NIL), [], [])
	 in
	   (make_call_code (0,entry_code),env, static, start,spills,calls,first_spill)
	 end)
	(zip5 (arg_copy_list,
               initial_env_list,
               new_closure_list,
               positions,
               offsets))

      (* Make a map of from detupled arguments to registers *)
      val tuple_bindings_list =
        map
        (fn (args,fp_args) => (map #2 args,map #2 fp_args))
        args_and_copied_callee_arg_list

      val fn_reg_code_list =
	map
	(fn ({lexp,...},
             (entry_code, env, static_offset, start_at,spills,calls,first_spill),
             new_closure, x, lvar, tuple_bindings, fn_args) =>
	 let
           val _ = reset_spills first_spill
           (* generate the code for the body *)
           val loop_tag = top_lambda_loop_tags lvar
           val new_local_functions = [(lvar,(loop_tag,tuple_bindings))]
	   val (regs, body_code,runtime_env',spills,calls) =
                cg_letrec_sub(lexp, env, static_offset, start_at,true,
                              (new_closure,funs - x div 2, tags,new_local_functions),spills,calls)
           (* Leave a point at which tail recursion can re-enter *)
           (* Jumps to here are generated from the APP code *)
             (* We used to put INTERCEPT's here, but the interaction with *)
             (* the debugger is poor when arguments are in registers so it *)
             (* has been moved to immediately after function entry (as in *)
             (* the non-recursive case *)
	   val end_block =
             ((Sexpr.ATOM [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG loop_tag)],
               [],
               SOME loop_tag,
	       Sexpr.ATOM
	       [if insert_interrupt then
		  MirTypes.INTERRUPT
               else
		  MirTypes.COMMENT"Interrupt point (not coded)"]),
              [], [])
           val runtime_env =
             RuntimeEnv.LIST([runtime_env'])
	 in
	   (regs, Mir_Utils.combine(Mir_Utils.combine(entry_code, end_block),body_code),
            (runtime_env,spills,first_spill),
            loop_tag)
	 end)
        (zip7 (fn_bodies,
               code_env_static_start_list,
               new_closure_list,
               offsets,
               lv_list,
               tuple_bindings_list,
               fn_args))
	
      val _ = restore_spills()

      val fn_list =
	map
	(fn ((res, fn_code, env_spills, loop_tag), entry_code) =>
	  (Mir_Utils.combine (entry_code, Mir_Utils.combine (fn_code, make_exit_code res)),
	   env_spills,
           loop_tag))
	(zip2 (fn_reg_code_list, entry_code_list))

      val fn_val_procs_proc_list =
	map
	(fn (tag,

             (((first, blocks, tag_opt, last), vals, procs),
              (runtime_env, (gc_spills, non_gc_spills, fp_spills), first_spill),
              loop_tag),
             (name,instances)) =>
        let
          val spill_sizes =
            if variable_debug
              then SOME{gc = gc_spills+1,
                                  non_gc = non_gc_spills+1,
                                  fp = fp_spills+1}
            else NONE
          val runtime_env =
            if variable_debug
              then RuntimeEnv.FN(name,runtime_env,head_spill(first_spill),instances)
            else RuntimeEnv.EMPTY
          val proc =
            MirTypes.PROC(name,
                          tag,
                          MirTypes.PROC_PARAMS {spill_sizes = spill_sizes,
						old_spill_sizes = NONE,
                                                stack_allocated = NONE},
                          MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr first) ::
                          blocks @
                          (case tag_opt of
                             NONE => []
                           | SOME tag =>
                               [MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr last)]),
                          runtime_env)
        in
          (vals,procs,proc)
        end)
	(zip3 (tags, fn_list,lambda_names))

      val letrec_vals =
	Lists.reducer
	(fn ((value,_,_), value') => value @ value')
	(fn_val_procs_proc_list, [])

      (* The subprocedures of the letrec *)
      val proc_list =
	Lists.reducer
	(fn ((_, procs,_), procs') => procs @ procs')
	(fn_val_procs_proc_list, [])

      (* The new procedures *)
      val letrec_proc_list = map #3 fn_val_procs_proc_list

      (* Code generate the body *)

      (* Calculate the bindings of letrec functions to registers *)
      val letrec_env =
	lists_reducel
	(fn (env, (lv, (_, reg))) =>
	  Mir_Env.add_lambda_env((lv, MirTypes.GC reg), env))
	(Mir_Env.empty_lambda_env, Lists.zip(lv_list, new_reg_list))

      val (regs, ((first, body_blocks, tag_opt, last), body_vals, body_procs),runtime_env,spills,calls) =
	cg_sub(lexp, Mir_Env.augment_lambda_env (env, letrec_env),
	       static_offset + gc_objects_within + funs,start_at + gc_objects_within + funs,tail_position,
               (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls)

      val runtime_env =
        if variable_debug
          then RuntimeEnv.LET(runtime_lets,runtime_env)
        else RuntimeEnv.EMPTY
    in
      (regs, ((Sexpr.CONS(code, first), body_blocks, tag_opt, last),
	      body_vals @ letrec_vals,
	      letrec_proc_list :: body_procs @ proc_list),
       runtime_env,
       spills,calls)
    end

      (* RAISE expressions *)
    | cg_sub(arg as AugLambda.RAISE({lexp=le, ...}), env, static_offset,start_at,_,
             (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
    let
(*
      val _ =
	let
	  val (_, _, fp_spills) = spills
	in
	  output(std_out,
		 "In cg_sub(RAISE), fp_spill = " ^ Int.toString fp_spills ^ "\n")
	end
*)
      val (reg, code,runtime_env,spills,calls') =
	cg_sub(le, env, static_offset, start_at, false,
               (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls+1)
      val final_code =
        let
          val r = MirTypes.GC.new ()
        in
          Mir_Utils.send_to_given_reg(reg, r) @
          [MirTypes.RAISE (MirTypes.GC_REG r),
           MirTypes.COMMENT"Call the exception handler, so we can backtrace"]
        end
      val total_code =
             Mir_Utils.combine(code,
                               make_call_code(calls+1,
                                              ((Sexpr.ATOM final_code, [], NONE,
                                                Sexpr.NIL), [], [])))
    in
      (reg, total_code,
       if variable_debug then
         RuntimeEnv.RAISE(runtime_env)
       else
         RuntimeEnv.EMPTY,spills,calls')
    end

      (* HANDLE expression *)
    | cg_sub(exp as AugLambda.HANDLE
	     ({lexp=le, size=gc_objects_in_le}, {lexp=le', size=gc_objects_in_le'}),
	       env, static_offset,start_at, tail_position,
               (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls) =
      (* Modify for tail case with a simple handler *)
      let
	val lv = LambdaTypes.new_LVar()
	val handler_arg = MirTypes.GC.new()
	val foo = ref ""
	fun convert_handler(AugLambda.FN(([lv'],[]), body, name, _)) =
	  (foo := name;
	  SOME
	  (AugLambda.LET((lv', NONE,
			  {size=0, lexp=AugLambda.VAR lv}), body))
	   )
	  | convert_handler(AugLambda.LET(larg, {lexp=body, ...})) =
	    (case convert_handler body of
	       SOME le =>
		 SOME
		 (AugLambda.LET(larg, {size=0, lexp=le}))
	     | x => x)
	  | convert_handler(AugLambda.FN _) =
	    Crash.impossible"Handler has multiple parameters"
	  | convert_handler le = NONE
	val end_tag = MirTypes.new_tag() (* The end of the code we'll generate *)
	val common_tag = MirTypes.new_tag() (* Some common handler restoration stuff *)
	val continue_tag = MirTypes.new_tag() (* Where a taken handler returns to *)
	val handler_frame_reg = MirTypes.GC.new()
	val handler_frame = MirTypes.GC_REG handler_frame_reg

	(* Allocate a new gc_spill *)
	val (gc_spills,non_gc_spills,fp_spills) = spills
	val slot = gc_spills+1
	val spills = (gc_spills+1,non_gc_spills,fp_spills)
	val ref_slot = new_ref_slot slot
	val result_reg = MirTypes.GC.new()
	val frame_size = (*length frame_setup*)4
	val exn_common = (* Common between exceptional and normal route *)
	  MirTypes.BLOCK
	  (common_tag,
	   [MirTypes.OLD_HANDLER,
	    MirTypes.DEALLOCATE_STACK(MirTypes.ALLOC, frame_size),
	    MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG end_tag)])
	(* Handler record layout *)
	(* Offset Name *)
	(* 0      previous handler record *)
	(* 1      stack pointer (machine stack) *)
	(* 2	handler closure pointer *)
	(* 3	offset from procedure start of continuation point (GC safe) *)

	fun make_frame_setup(Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG r))) =
	  let
	    val exn_result_reg = MirTypes.GC_REG r
	    val offset_reg = MirTypes.GC.new()
	    val offset = MirTypes.GC_REG offset_reg
	    val gp_offset = MirTypes.GP_GC_REG offset_reg
	    val frame_setup =
	      [MirTypes.STOREOP(MirTypes.ST, MirTypes.GC_REG sp, handler_frame,
				MirTypes.GP_IMM_ANY 3),
	       MirTypes.STOREOP(MirTypes.ST, exn_result_reg,
				handler_frame, MirTypes.GP_IMM_ANY 7),
	       MirTypes.STOREOP(MirTypes.ST, offset, handler_frame,
				MirTypes.GP_IMM_ANY 11)]
	  in
	    MirTypes.ALLOCATE_STACK(MirTypes.ALLOC,
				    handler_frame,
				    frame_size,
				    NONE) ::
	    MirTypes.ADR(MirTypes.LEO, offset, continue_tag) ::
	    MirTypes.COMMENT "Calculate offset of continuation code" ::
	    MirTypes.BINARY(MirTypes.ASL, offset, gp_offset, MirTypes.GP_IMM_ANY 2) ::
	    MirTypes.COMMENT "Ensure it's tagged" ::
	    MirTypes.NEW_HANDLER(handler_frame, continue_tag) ::
	    frame_setup @
	    [MirTypes.COMMENT"Set up new handler pointer"]
	  end
	| make_frame_setup _ =
	  Crash.impossible"Exn_result_reg""Exn_result_reg"

      in
	case (convert_handler le',
	      opt_handlers andalso gc_objects_in_le' = 1 andalso not debug_variables) of
	  (SOME new_la, true) =>
	    let
	      val new_handler_lambda =
		let
		  val lv = LambdaTypes.new_LVar()
		in
		  AugLambda.FN(([lv],[]),{size = 0, lexp = AugLambda.VAR lv},
			       "replacement handler", RuntimeEnv.USER_FUNCTION)
		end
	      val (exn_result_reg, (* Pointer to closure of handler *)
		   exn_code (*(exn_f, exn_b, exn_o, exn_l),
				exn_vals, exn_procs*),runtime_env,spills,calls') =
		cg_sub(new_handler_lambda, env,
		       static_offset + gc_objects_in_le,
		       start_at + gc_objects_in_le,false,
		       (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls)
	      local
		val env' = Mir_Env.add_lambda_env ((lv, MirTypes.GC handler_arg), env)
		val (tail_reg, tail_code,runtime_env',spills,calls) =
		  cg_sub(new_la, env',
			 static_offset + gc_objects_in_le,start_at + gc_objects_in_le,tail_position,
			 (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls)
	      in
		val exn_end =
		  Mir_Utils.combine
		  (Mir_Utils.combine
		   (((Sexpr.NIL, [], SOME continue_tag,
		      Sexpr.ATOM
		      (Mir_Utils.send_to_given_reg(Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG caller_arg)),
						   handler_arg) @
		       [MirTypes.OLD_HANDLER,
			MirTypes.DEALLOCATE_STACK(MirTypes.ALLOC, frame_size)])),
		   [], []), tail_code),
		   ((Sexpr.ATOM
		     (Mir_Utils.send_to_given_reg(tail_reg, result_reg) @
		      [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG end_tag)]),
		     [], SOME end_tag,
		     Sexpr.ATOM[MirTypes.COMMENT"Handle result point"]), [], [])
		   )
	      end

	      val frame_setup = make_frame_setup exn_result_reg

	      val exn_whole =
		Mir_Utils.combine(exn_code,
				  ((Sexpr.ATOM frame_setup, [exn_common], NONE,
				    Sexpr.NIL), [], []))
	      val restore_spills = spill_restorer()
	      (* This is the only call to append_spill *)
	      val _ = append_spill ref_slot
	      val (main_reg, main_code,runtime_env',spills,calls) =
		cg_sub(le, env, static_offset, start_at, false,
		       (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls')
	      val _ = restore_spills()
	      val main_end =
		Mir_Utils.send_to_given_reg(main_reg, result_reg) @
		[MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG common_tag)]
	      val main_whole =
		Mir_Utils.combine(main_code,
				  ((Sexpr.ATOM main_end, [], NONE,
				    Sexpr.NIL), [], []))
	      val total_code =
		Mir_Utils.combine(Mir_Utils.combine(exn_whole, main_whole), exn_end)
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result_reg)), total_code,
	       RuntimeEnv.EMPTY,spills,calls)
	    end
	| _ =>
	    let
	      val (exn_result_reg, (* Pointer to closure of handler *)
		   exn_code (*(exn_f, exn_b, exn_o, exn_l),
				exn_vals, exn_procs*),runtime_env,spills,calls') =
		cg_sub(le', env,
		       static_offset + gc_objects_in_le,start_at + gc_objects_in_le,false,
		       (closure,funs_in_closure, fn_tag_list,local_fns),spills,calls)
	      val exn_end =
		MirTypes.BLOCK
		(continue_tag,
		 Mir_Utils.send_to_given_reg(Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG caller_arg)),
					     result_reg) @
		 [MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG common_tag)])

	      val frame_setup = make_frame_setup exn_result_reg

	      val exn_whole =
		Mir_Utils.combine(exn_code,
				  ((Sexpr.ATOM frame_setup, [exn_common, exn_end], NONE,
				    Sexpr.NIL), [], []))
	      val restore_spills = spill_restorer()
	      (* This is the only call to append_spill *)
	      val _ = append_spill ref_slot
	      val (main_reg, main_code,runtime_env',spills,calls) =
		cg_sub(le, env, static_offset, start_at, false,
		       (closure,funs_in_closure,fn_tag_list,local_fns),spills,calls')
	      val _ = restore_spills()
	      val main_end =
		Mir_Utils.send_to_given_reg(main_reg, result_reg) @
		[MirTypes.BRANCH(MirTypes.BRA, MirTypes.TAG common_tag)]
	      val main_whole =
		Mir_Utils.combine(main_code,
			       ((Sexpr.ATOM main_end, [], SOME end_tag,
				 Sexpr.ATOM[MirTypes.COMMENT"Handle result point"]), [], []))
	      val total_code =
		Mir_Utils.combine(exn_whole, main_whole)
	    in
	      (Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_GC_REG result_reg)), total_code,
	       if variable_debug then
		 RuntimeEnv.HANDLE(runtime_env',ref_slot,calls',calls,runtime_env)
	       else
		 RuntimeEnv.EMPTY,spills,calls)
	    end
      end
    | cg_sub(AugLambda.BUILTIN(prim,_), env, static_offset,start_at,_,
             (closure,funs_in_closure, fn_tag_list,local_fns),_,_) =
      let
        val string = LambdaPrint.string_of_lambda(LambdaTypes.BUILTIN prim)
      in
	Crash.impossible (concat ["cg_sub(BUILTIN): ",string, " should have been translated"])
      end (* of cg_sub *)

    val restore_spills = spill_restorer()
    val new_tag = top_closure 0
    val (regs,
         ((first, blocks, tag_opt, last), values, proc_lists),
         runtime_env,
         (gc_spills,non_gc_spills,fp_spills),_) =
      (* Initial spills are (1,0,0) *)
      cg_sub(new_lambda_exp, Mir_Env.empty_lambda_env, 0, 0, false,
             (Mir_Env.empty_closure_env,1, [new_tag], []),(1,0,0),0)

    val (reg, last') =
     case regs of
      Mir_Utils.LIST sub_regs =>
      let
	val result_reg = MirTypes.GC.new()
	val (reg, new_code) = Mir_Utils.tuple_up_in_reg (sub_regs, result_reg)
      in
	(MirTypes.GP_GC_REG callee_arg,
	 Sexpr.CONS
	 (last,
	  Sexpr.CONS
	  (Sexpr.ATOM new_code,
	   Sexpr.ATOM [MirTypes.UNARY(MirTypes.MOVE,
				      MirTypes.GC_REG callee_arg,
				      MirTypes.GP_GC_REG result_reg)])))
      end
    | Mir_Utils.ONE(Mir_Utils.INT(arg as MirTypes.GP_GC_REG _)) =>
	(* This compilation unit equal to another one, a rarity! *)
	(MirTypes.GP_GC_REG callee_arg,
	 Sexpr.CONS(last,
		    Sexpr.ATOM
		    [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG callee_arg,
				    arg)]))
    | Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_IMM_INT 0)) =>
	(* This is the case of struct[], a rarity! *)
	(MirTypes.GP_GC_REG callee_arg,
	 Sexpr.CONS
	 (last, Sexpr.ATOM
	  [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG callee_arg,
			  MirTypes.GP_IMM_INT 0)]))
    | Mir_Utils.ONE(Mir_Utils.INT(MirTypes.GP_IMM_INT 1)) =>
	(* This is the case of [], a rarity! *)
	(MirTypes.GP_GC_REG callee_arg,
	 Sexpr.CONS
	 (last, Sexpr.ATOM
	  [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG callee_arg,
			  MirTypes.GP_IMM_INT 1)]))
    | _ => Crash.impossible"Non-struct final result??"

    val last'' = Sexpr.CONS(last', Sexpr.ATOM[MirTypes.RTS])

    val setup_entry =
      Sexpr.CONS
      ((if intercept then
	  Sexpr.ATOM[MirTypes.ENTER [MirTypes.GC callee_arg],
		     MirTypes.INTERCEPT]
	else
	  Sexpr.ATOM[MirTypes.ENTER [MirTypes.GC callee_arg]]),
	  Sexpr.CONS
	  (Sexpr.ATOM
	  [MirTypes.UNARY(MirTypes.MOVE, MirTypes.GC_REG callee_closure,
                      MirTypes.GP_GC_REG callee_arg)],  first))

    val (first, blocks) =
      case (tag_opt, Mir_Utils.contract_sexpr last) of
	(NONE, []) => (Sexpr.CONS (setup_entry, last''), blocks)
      | (SOME tag,_) =>
	  (setup_entry, MirTypes.BLOCK(tag, Mir_Utils.contract_sexpr last'') ::
	   blocks)
      | (NONE,_) =>
	  Crash.impossible "ABSENT tag with non-empty last"

    val loc_refs = top_tags_list

    val set_up_proc =
      MirTypes.PROC(name_of_setup_function,
                    new_tag,
		    MirTypes.PROC_PARAMS {spill_sizes =
                                          if variable_debug then
                                            SOME{gc = gc_spills+1,
                                                           non_gc = non_gc_spills+1,
                                                           fp = fp_spills+1}
                                          else
                                            NONE,
					  old_spill_sizes = NONE,
					  stack_allocated = NONE},
		    MirTypes.BLOCK(new_tag,
				   Mir_Utils.contract_sexpr first) :: blocks,
                    if variable_debug then
                      (restore_spills ();
                       RuntimeEnv.FN(name_of_setup_function,runtime_env,
                                     head_spill(get_current_spills ()),RuntimeEnv.USER_FUNCTION))
                    else
                      RuntimeEnv.EMPTY)

    val all_procs = [set_up_proc] :: proc_lists

(*
    (* and now some post optimizations *)
    local
      open MirTypes

      fun get_opt NONE = []
	| get_opt(SOME tag) = [tag]

      fun tag_ref(TBINARY(_, tag_opt,_,_,_)) = get_opt tag_opt
	| tag_ref(BINARY _) = []
	| tag_ref(UNARY _) = []
	| tag_ref(NULLARY _) = []
	| tag_ref(TBINARYFP(_, tag_opt,_,_,_)) = get_opt tag_opt
	| tag_ref(TUNARYFP(_, tag_opt,_,_)) = get_opt tag_opt
	| tag_ref(BINARYFP _) = []
	| tag_ref(UNARYFP _) = []
	| tag_ref(STACKOP _) = []
	| tag_ref(STOREOP _) = []
	| tag_ref(IMMSTOREOP _) = []
	| tag_ref(STOREFPOP _) = []
	| tag_ref(REAL _) = []
	| tag_ref(FLOOR(_, tag,_,_)) = [tag]
	| tag_ref(BRANCH(_, bl_dest)) =
	  (case bl_dest of
	     TAG tag => [tag]
	   | REG _ => [])
	| tag_ref(TEST(_, tag,_,_)) = [tag]
	| tag_ref(FTEST(_, tag,_,_)) = [tag]
	| tag_ref(BRANCH_AND_LINK(_,bl_dest,_,_)) =
	  (case bl_dest of
	     TAG tag => [tag]
	   | REG _ => [])
	| tag_ref(TAIL_CALL(_, bl_dest,_)) =
	  (case bl_dest of
	     TAG tag => [tag]
	   | REG _ => [])
	| tag_ref CALL_C = []
	| tag_ref(SWITCH(_,_, tag_list)) = tag_list
	| tag_ref(ALLOCATE _) = []
	| tag_ref(ALLOCATE_STACK _) = []
	| tag_ref(DEALLOCATE_STACK _) = []
	| tag_ref(ADR(_,_, tag)) = [tag]
	| tag_ref INTERCEPT = []
	| tag_ref INTERRUPT = []
	| tag_ref (ENTER _) = []
	| tag_ref RTS = []
	| tag_ref(NEW_HANDLER(_, tag)) = [tag]
	| tag_ref OLD_HANDLER = []
	| tag_ref(RAISE _) = []
	| tag_ref(COMMENT _) = []

      fun rev_app([], acc) = acc
	| rev_app(x :: xs, acc) = rev_app(xs, x :: acc)

      (* collect the tags referenced by an opcode list *)
      fun process_block(tags, []) = tags
	| process_block(tags, opcode :: opcode_list) =
	  process_block(rev_app (tag_ref opcode, tags), opcode_list)
    in
      (* This discards unreferenced blocks in a procedure *)
      fun process_blocks(_, new_block_map, []) = Map.range new_block_map
	| process_blocks(old_block_map, new_block_map, tag :: tag_list) =
	  case Map.tryApply'(new_block_map, tag) of
	    SOME _ => process_blocks(old_block_map, new_block_map, tag_list)
	  | NONE =>
	      case Map.tryApply'(old_block_map, tag) of
		SOME(block as BLOCK(_, opcodes)) =>
		  process_blocks(old_block_map, Map.define(new_block_map, tag, block),
				 process_block(tag_list, opcodes))
	      | NONE =>
		  (* This case occurs with a call to a different function *)
		  (* in the same recursive set *)
		  process_blocks(old_block_map, new_block_map, tag_list)
	
    end

    fun add_block(map, block as MirTypes.BLOCK(tag,_)) =
      MirTypes.Map.define(map, tag, block)

    (* If there is a 'small' exit block, then this gets appended onto other blocks that *)
    (* branch to it -- maybe we should do this for all short blocks and for blocks only referenced once *)

    fun sort_out_small_exit_blocks(proc as MirTypes.PROC(name,tag, params, blocks,runtime_env)) =
      let
	val exit_block = Mir_Utils.exit_block blocks
	val block_list =
	  case exit_block of
	    NONE =>
              blocks
	  | SOME exit_block =>
	      if Mir_Utils.small_exit_block exit_block then
		let
		  val block_list = Mir_Utils.append_small_exit (exit_block, blocks)
		  val old_block_map = lists_reducel add_block (MirTypes.Map.empty, block_list)
		in
                  (* Throw out unused exit block if possible *)
		  process_blocks(old_block_map, MirTypes.Map.empty, [tag])
		end
	      else
		blocks
      in
	MirTypes.PROC(name,tag, params, block_list,runtime_env)
      end

    val all_procs =
      map
      (fn proc_list => map sort_out_small_exit_blocks proc_list)
      all_procs
*)
  in
    (MirTypes.CODE(MirTypes.REFS(loc_refs,
				 {requires = ext_string_list,
				  vars = ext_var_list,
				  exns = ext_exn_list,
				  strs = ext_str_list,
				  funs = ext_fun_list}),
		  values, all_procs),
     debug_information)
  end
end
