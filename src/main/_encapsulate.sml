(* _encapsulate.sml the functor *)
(*
$Log: _encapsulate.sml,v $
Revision 1.186  1999/02/03 16:31:40  mitchell
[Bug #50108]
Change ModuleId from an equality type

 * Revision 1.185  1999/02/02  16:00:55  mitchell
 * [Bug #190500]
 * Remove redundant require statements
 *
 * Revision 1.184  1998/10/23  15:05:49  jont
 * [Bug #70198]
 * Add interface to get code_offset
 *
 * Revision 1.183  1998/10/23  10:59:13  jont
 * [Bug #70194]
 * Add interface for input_code taking filename to code_module
 *
 * Revision 1.182  1998/09/25  16:42:06  jont
 * [Bug #70181]
 * Handle Time.Time which can occur from decode_cons
 *
 * Revision 1.181  1998/05/26  13:56:24  mitchell
 * [Bug #30413]
 * Close streams at the stream_io level, rather than just the underlying stream
 *
 * Revision 1.180  1998/04/22  11:38:00  jont
 * [Bug #70099]
 * Changing encapsulation order to do type_env
 * before lambda_env and parser_env
 *
 * Revision 1.179  1998/04/16  21:44:35  jont
 * [Bug #70058]
 * Remove __terminal from list of requires
 *
 * Revision 1.178  1998/04/16  11:00:51  jont
 * [Bug #70058]
 * Use the proper submodule table when getting debug info
 *
 * Revision 1.177  1998/02/19  17:13:42  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.176  1998/02/19  15:01:44  jont
 * [Bug #30341]
 * Fix where type ... and syntax
 *
 * Revision 1.175  1998/02/06  16:05:17  jont
 * [Bug #70053]
 * Change Crash.impossible calls for debug info decapsulation into user errors
 *
 * Revision 1.174  1998/02/06  13:35:44  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.173  1998/02/05  12:07:48  jont
 * [Bug #30331]
 * Add input_debug_info to interface
 *
 * Revision 1.172  1998/01/28  12:23:44  jont
 * [Bug #30330]
 * Modify encapsulation mechanism for valenvs found in tynames
 * so as to avoid circularity problems.
 *
 * Revision 1.171  1997/11/25  19:48:08  jont
 * [Bug #30328]
 * Add environment parameter to decode_type_basis
 * for finding pervasive type names
 *
 * Revision 1.170  1997/11/13  11:19:00  jont
 * [Bug #30089]
 * Modify TIMER (from utils) to be INTERNAL_TIMER to keep bootstrap happy
 *
 * Revision 1.169  1997/10/21  12:35:16  jont
 * [Bug #30089]
 * Replacing MLWorks.Time with Time from the basis
 *
 * $Log: _encapsulate.sml,v $
 * Revision 1.186  1999/02/03 16:31:40  mitchell
 * [Bug #50108]
 * Change ModuleId from an equality type
 *
 * Revision 1.184  1998/10/23  15:05:49  jont
 * [Bug #70198]
 * Add interface to get code_offset
 *
 * Revision 1.183  1998/10/23  10:59:13  jont
 * [Bug #70194]
 * Add interface for input_code taking filename to code_module
 *
 * Revision 1.182  1998/09/25  16:42:06  jont
 * [Bug #70181]
 * Handle Time.Time which can occur from decode_cons
 *
 * Revision 1.181  1998/05/26  13:56:24  mitchell
 * [Bug #30413]
 * Close streams at the stream_io level, rather than just the underlying stream
 *
 * Revision 1.180  1998/04/22  11:38:00  jont
 * [Bug #70099]
 * Changing encapsulation order to do type_env
 * before lambda_env and parser_env
 *
 * Revision 1.179  1998/04/16  21:44:35  jont
 * [Bug #70058]
 * Remove __terminal from list of requires
 *
 * Revision 1.178  1998/04/16  11:00:51  jont
 * [Bug #70058]
 * Use the proper submodule table when getting debug info
 *
 * Revision 1.177  1998/02/19  17:13:42  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.176  1998/02/19  15:01:44  jont
 * [Bug #30341]
 * Fix where type ... and syntax
 *
 * Revision 1.175  1998/02/06  16:05:17  jont
 * [Bug #70053]
 * Change Crash.impossible calls for debug info decapsulation into user errors
 *
 * Revision 1.174  1998/02/06  13:35:44  johnh
 * [Bug #30326]
 * Merge in change from branch MLWorks_workspace_97
 *
 * Revision 1.168.2.3  1997/11/20  17:59:48  daveb
 * [Bug #30326]
 * Renamed utils/*timer to utils/*mlworks_timer.
 *
 * Revision 1.168.2.2  1997/10/29  14:10:27  daveb
 * [Bug #30089]
 * Merged from trunk:
 * Replacing MLWorks.Time with Time from the basis
 *
 *
 * Revision 1.168.2.1  1997/09/11  20:57:00  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.168  1997/06/03  17:30:50  jont
 * [Bug #30090]
 * Modify to handle IO.Io near BinIO.openIn
 *
 * Revision 1.167  1997/05/30  10:41:53  jont
 * [Bug #30076]
 * Modifications to allow stack based parameter passing on the I386
 *
 * Revision 1.166  1997/05/09  14:40:30  jont
 * [Bug #30091]
 * Convert from MLWorks.Internal.FileIO to BinIO from the basis
 *
 * Revision 1.165  1996/11/06  11:28:49  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.164  1996/11/04  16:28:03  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.163  1996/10/29  15:23:19  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.162  1996/10/25  09:22:26  andreww
 * [Bug #1686]
 * extending parser environment
 *
 * Revision 1.161  1996/10/04  15:48:57  andreww
 * [Bug #1592]
 * Threading extra "level" argument to tynames.
 *
 * Revision 1.160  1996/09/18  15:25:07  io
 * [Bug #1603]
 * convert MLWorks.ByteArray to MLWorks.Internal.ByteArray or equivalent basis functions
 *
 * Revision 1.159  1996/08/01  12:27:22  jont
 * [Bug #1503]
 * Add field to FUNINFO to say if arg actually saved
 *
 * Revision 1.158  1996/07/12  13:44:33  jont
 * [Bug #1469]
 * Fix problems in decode_spill
 *
 * Revision 1.157  1996/05/30  12:41:56  daveb
 * The Io and Ord exceptions are no longer at top level.
 *
 * Revision 1.156  1996/05/16  16:30:50  matthew
 * Bits becomes MLWorks.Internal.Bits
 *
 * Revision 1.155  1996/05/07  11:17:28  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.154  1996/04/30  17:12:53  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, outstream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.153  1996/04/29  14:59:39  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.152  1996/04/25  14:48:53  stephenb
 * Change interceptible so that it doesn't always return false.
 * This gets the runtime and image back in sync and so fixes bug #913.
 *
 * Revision 1.151  1996/03/20  12:52:42  matthew
 * Changes to parser signature environment
 *
 * Revision 1.150  1996/03/01  14:24:16  daveb
 * Changed type of input_info.
 *
 * Revision 1.149  1996/02/26  11:27:44  jont
 * Change newhashtable to hashtable
 *
 * Revision 1.148  1996/02/23  17:36:12  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.147  1996/02/22  14:09:22  jont
 * Replacing Map with NewMap
 *
 * Revision 1.146  1995/12/27  13:10:50  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.145  1995/11/20  16:51:09  jont
Modifications for improved runtime environments in the debugger

Revision 1.144  1995/09/21  14:10:46  matthew
Fixing problem with modules with no stamps defined

Revision 1.143  1995/09/08  17:48:28  daveb
Added realint_tyvar for abs and ~; removed real_tyvar and int_tyvar.

Revision 1.142  1995/07/28  09:47:00  jont
Add handling for overloading on words

Revision 1.141  1995/07/25  12:19:38  jont
Add WORD to runtime_env

Revision 1.140  1995/07/19  11:24:11  jont
Add CHAR constructor in runtime_env

Revision 1.139  1995/04/27  12:57:44  matthew
decode_ and write_ runtime_env used inconsistent string functions

Revision 1.138  1995/04/21  14:26:23  jont
Modify stamp_module in output_file to use an ordered array

Revision 1.137  1995/04/20  14:10:00  jont
Change decode_type_basis to accept a btree

Revision 1.136  1995/04/06  10:28:12  matthew
Use Stamp instead of Tyname_id etc.

Revision 1.135  1995/03/01  14:07:00  matthew
Changes to debugger types

Revision 1.134  1995/02/07  13:02:42  matthew
Moving pervasive name counts to Basis

Revision 1.133  1995/01/17  10:11:41  matthew
Rationalizing debugger

Revision 1.132  1994/10/13  10:46:16  matthew
Use pervasive Option.option for return values in NewMap

Revision 1.131  1994/10/06  11:54:16  matthew
Rationalizing data structures

Revision 1.130  1994/09/28  16:29:36  nickb
Reorganise the whole file so it's more legible.
Also buffer output.

Revision 1.129  1994/09/22  10:32:59  matthew
Abstraction of debug information

Revision 1.128  1994/07/19  14:49:28  jont
Modifications to include number of callee saves in wordsets

Revision 1.127  1994/06/24  14:53:27  jont
Ensure exception debug info flag stored

Revision 1.126  1994/06/22  15:25:23  jont
Update debugger information production

Revision 1.125  1994/06/21  16:03:00  nickh
Change .mo format to enable loading with immutable ancillary slots.

Revision 1.124  1994/06/09  16:05:47  nickh
New runtime directory structure.

Revision 1.123  1994/05/23  17:14:31  jont
Removed a couple of superfluous handlers and tidied up

Revision 1.122  1994/05/16  13:41:36  daveb
Added support for int_literal_tyvar and real_literal_tyvar.

Revision 1.121  1994/05/05  13:49:46  daveb
Changes for new overloading scheme.

Revision 1.120  1994/04/13  10:53:04  jont
Remove message about reset_str

Revision 1.119  1994/04/07  15:09:06  jont
Add original require file names to consistency info.

Revision 1.118  1994/03/08  17:43:46  jont
Moved module type into separate file

Revision 1.117  1994/02/28  08:14:22  nosa
Monomorphic debugger encapsulation.

Revision 1.116  1994/02/22  11:17:48  daveb
Changed Info.default_options to Info.make_default_options ().

Revision 1.115  1994/02/21  16:51:32  daveb
Added call to Info.error' to report missing modules.

Revision 1.114  1994/01/18  17:18:11  matthew
Changed NewMap.Undefined exception to BadInput

Revision 1.114  1994/01/18  17:18:11  matthew
Changed NewMap.Undefined exception to BadInput

Revision 1.113  1994/01/07  17:33:04  matthew
Added some debug info.

Also changed type of submodule info for output_file and decode_type_basis to include range information.

Revision 1.112  1994/01/05  12:52:17  daveb
Added sharing constraint to match one in result signature.

Revision 1.111  1993/12/16  14:03:07  matthew
Added level field to Basis.
Added and commented out line to save Wordset name as ""

Revision 1.110  1993/11/30  13:41:03  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.109  1993/11/15  14:13:59  nickh
New pervasive time structure.

Revision 1.108  1993/09/21  16:18:25  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.107  1993/08/26  17:39:54  daveb
Replaced header_size with ObjectFile.HEADER_SIZE.

Revision 1.106  1993/08/03  14:32:02  jont
Modifications to decode_type_basis to take module name, and to remove the gaps
stuff in encoding now that equires can't be mixed with other topdecs

Revision 1.105  1993/07/19  12:41:12  nosa
Debugger Environments for local and closure variable inspection
in the debugger;
structure Option.

Revision 1.104  1993/07/07  17:46:46  daveb
Removed exception environments and interfaces.
Funenvs no longer have interface components.
On the other hand, the constructor status of valids in lambda environments
is important now.

Revision 1.103  1993/05/28  11:39:08  jont
Cleaned up after assembly changes

Revision 1.102  1993/05/26  11:01:28  jont
Stopped encapsulating and decapsulating assemblies

Revision 1.101  1993/05/25  15:04:53  jont
Changes because Assemblies now has BasisTypes instead of Datatypes

Revision 1.100  1993/05/13  14:41:08  richard
Changed the layout of code vectors to make life _much_ easier for
the runtime system loader.

Revision 1.99  1993/04/23  13:24:48  jont
Modified to use rts write_byte. Bug fixed assembly encapsulation

Revision 1.98  1993/04/21  14:10:34  jont
Improved encapsulation of integers in assemblies

Revision 1.97  1993/03/24  15:42:09  richard
Corrected #define symbols to upper case.

Revision 1.96  1993/03/18  13:52:41  matthew
Nameset signature changes

Revision 1.95  1993/03/18  13:29:25  jont
Encapsulated extra WORDSET information

Revision 1.94  1993/03/11  11:12:05  matthew
Signature revisions

Revision 1.93  1993/03/09  12:57:03  matthew
Options & Info changes

Revision 1.92  1993/03/01  15:23:58  matthew
Added crash when trying to encapsulate an MLVALUE object
I guess this should really be an ordinary error

Revision 1.91  1993/02/19  11:44:55  jont
Modified to spot common strs. Big size improvement for large .mo files

Revision 1.90  1993/02/10  17:27:07  jont
Changes for code vector reform.

Revision 1.89  1993/02/09  10:46:21  matthew
Typechecker structure changes

Revision 1.88  1993/02/02  11:10:11  matthew
Changed for COPYSTR structures.
Added cached values in interfaces and structures.

Revision 1.87  1993/01/15  11:24:44  daveb
Changed ObjectFile.version to ObjectFile.object_file_version to avoid
problem on the C side of the run time system.

Revision 1.86  1993/01/14  14:37:57  daveb
Moved currentVersion into ObjectFile, so that it's accessible to the run-time
system too.

Revision 1.85  1993/01/06  12:32:19  jont
Anel's last changes

Revision 1.84  1992/12/22  16:51:56  jont
Ensure decode_cons is done before close_in file_handle in order to
fix file already closed bug

Revision 1.83  1992/12/01  16:59:44  matthew
Simplified some error messages

Revision 1.82  1992/11/30  14:17:40  jont
Changed to encode tyenvs where they're in common.
Some minor efficiency improvements to do with module name searching

Revision 1.81  1992/11/25  12:26:32  matthew
Changed error messages

Revision 1.80  1992/11/02  11:30:26  richard
Time is now represented by a pervasive structure.

Revision 1.79  1992/10/30  14:22:02  jont
Modified assembly encapsulation to use IntMap

Revision 1.78  1992/10/28  12:10:15  jont
Removed dependence on environ in favour of environtypes

Revision 1.77  1992/10/27  18:47:38  jont
Modified to use less than functions for maps

Revision 1.76  1992/10/15  16:19:18  clive
Anel's changes for encapsulating assemblies

Revision 1.75  1992/10/09  14:22:48  clive
Tynames now have a slot recording their definition point

Revision 1.74  1992/10/02  16:31:40  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.73  1992/09/25  17:23:50  jont
Stopped using empty_eqfunmap, no longer necessary. Simplified decode_map
and encode_map

Revision 1.72  1992/09/22  13:37:54  clive
Added a type annotation

Revision 1.71  1992/09/21  11:30:20  clive
Changed hashtables to a single structure implementation

Revision 1.70  1992/09/17  12:14:40  clive
Typo meant some things looked up in the wrong hashtable

Revision 1.69  1992/09/14  15:06:53  jont
Changed a number of handle statements for uses of lookup_default

Revision 1.68  1992/09/11  16:18:25  jont
Allowed NULLTYPEs in valenvs, produced by nameset copying

Revision 1.67  1992/09/10  10:34:21  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.66  1992/09/04  12:22:44  jont
Converted all instances to Lists.nth to use hash tables

Revision 1.65  1992/09/02  16:18:18  jont
Changed encapsulation format to include number of strings found.
Should improve input speed

Revision 1.64  1992/08/28  01:08:39  davidt
Took out some unnecessary diagnostic output.

Revision 1.63  1992/08/27  09:41:43  richard
Rationalisation of the MLWorks structure.

Revision 1.62  1992/08/26  18:33:05  davidt
Removed some of the large lists that were being built
during encapsulation. Changed some sharing constraints.

Revision 1.60  1992/08/25  10:52:42  clive
Added details about leafness to the debug information

Revision 1.59  1992/08/24  19:11:17  davidt
Added various optimisations, the most important of which being the
compression of identical strings, which results in very large
(up to 40% or 50%) reductions in the size of mo files.

Revision 1.58  1992/08/19  13:00:36  davidt
Fixed up changes since parserenv now uses NewMap. The exception BadInput
now includes the filename as part of the error messages.

Revision 1.57  1992/08/18  13:38:26  davidt
Took out various exception handlers and put them all round the
top level function body, hence only building the handlers
once for each object file.

Revision 1.56  1992/08/14  17:47:13  davidt
Implemented inputting of consistency info without requiring the
whole object file to be read.

Revision 1.55  1992/08/12  17:51:48  davidt
Did a bit more tidying up.

Revision 1.54  1992/08/12  14:41:40  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.53  1992/08/12  14:03:58  davidt
Started optimisations, removing Map.to_list etc.

Revision 1.52  1992/08/12  10:40:36  davidt
Fixed nasty bug in encapsulation of strname counts.

Revision 1.51  1992/08/10  17:23:46  davidt
Changed MLworks to MLWorks.

Revision 1.50  1992/08/10  11:27:02  davidt
Deleted various redundant structure arguments. Changed some
of the output routines to output stuff directly to the
mo file, instead of building intermediate lists etc.

Revision 1.48  1992/07/29  17:02:54  clive
Better version of the output function for the delayed structure

Revision 1.47  1992/07/28  08:54:21  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.46  1992/07/22  07:53:15  clive
Added three : int annotations required by our compiler

Revision 1.45  1992/07/21  17:40:28  jont
Modified to observe commonality within parser environments and
code generation environments in order to reduce encoding/decoding time
and size of encoded objects

Revision 1.44  1992/07/16  16:33:11  clive
Change in sharing constraint to reflect change in debugger_types

Revision 1.43  1992/07/15  16:31:38  clive
Added an element to the recipe type so needed to change encapsulator

Revision 1.42  1992/07/07  09:45:49  clive
Added call point information recording

Revision 1.41  1992/06/18  12:17:12  jont
Added furhter constructors to the module element type to express
interpretive stuff

Revision 1.40  1992/06/15  14:27:50  jont
Added decode_counts functions to speed up subrequiresd

Revision 1.39  1992/06/11  09:43:26  clive
Added the encapsulation of function debugging information

Revision 1.38  1992/06/10  15:08:40  jont
changed to use newmap

Revision 1.37  1992/05/12  15:50:15  jont
Changed version number to two for update of magic number

Revision 1.36  1992/05/01  10:12:08  jont
Some minor improvements and revisions. Fixity is now a byte

Revision 1.35  1992/04/03  10:24:36  jont
Add integer parameter to functor. Removed references to pervasive length.
Added type specifier to resolve some +

Revision 1.34  1992/03/20  15:42:49  jont
Changed to use hash tables in various places. Altered the encoding
of valenvs in tynames to give only the domain plus whether the range
is a fun or cons type. This is all the code generator needs, and the
typechecker doesn't look at this stuff. This breaks the circularity for
metatynames so we now encode them as well. Also fixed the code output
to give both the number of module elements and the number of top level
tags (both are need by the runtime system when sets of mutually
recursive procedures are around). Changed the version number to reflect
this.

Revision 1.33  1992/03/16  18:38:28  jont
Added use of hastable for encoding comon types and tynames

Revision 1.33  1992/03/16  16:57:50  jont
Added hash tables for encoding of common types (fun, rec, cons) and also
metatynames.

Revision 1.32  1992/03/03  12:39:21  richard
Changed names of functions in Pervasives.

Revision 1.31  1992/02/27  17:40:52  jont
Changed such that all maps are created with equality functions

Revision 1.30  1992/02/12  11:11:36  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.29  1992/01/30  15:34:51  jont
Fixed bug in decode_refvalenv whereby valenv maps were created
with op=, should be done with Ident.valid_eq

Revision 1.28  1992/01/25  00:55:18  jont
Modified to allow valenv field in METATYNAMEs. These are not encoded
or decoded to avoid the circularity problem. They are recalculated
by the cor rules typechecking phase as necessary

Revision 1.27  1992/01/23  16:09:32  jont
Changed to encode tyfun_ids similarly to tyname_ids

Revision 1.26  1992/01/22  18:31:19  jont
Changed encoding of Tyname slightly since we don't spot repeats any
more for TYNAME

Revision 1.25  1992/01/22  16:52:40  jont
Used new type_same from Enc_Sub to do equality on Type (not equality
types themselves)/ Pointer eq would probably be nicer

Revision 1.24  1992/01/21  13:37:10  jont
Split type encoding into all constituent parts, for improved speed.
There is a lurking problem here, Type is not an equality type,
although NJ believes it is.

Revision 1.23  1992/01/20  16:30:04  jont
Removed diagnostic stuff. Improved speed by a further factor of six or so

Revision 1.22  1992/01/17  21:21:27  jont
Fixed problem with encoding types, caused by Tyname -> Valenv -> Typescheme
-> Type -> Tyname circularity, such that the second instance of tyname
was incorrectly read as an existing Tyname, even though it hadn't been
fully decoded. Ugh!

Revision 1.21  1992/01/15  20:41:56  jont
Modified to output only one instance of each METATYNAME and Type,
for improved efficiency

Revision 1.20  1992/01/15  14:23:27  jont
Changed to use the ref int in the valenv as the encoding number

Revision 1.19  1992/01/14  12:05:54  clive
Added code for non_gc spills number in front of code objects in a closure
by changing encode_code to propogate it through

Revision 1.18  1992/01/10  18:48:34  jont
Added more diagnostics. Tried to improve output of type environments
by using balanced trees instead of association lists. Not very successful

Revision 1.17  1992/01/09  10:59:30  jont
Fixed fault in decode_tyname whereby entire string was being inserted
rather than the relevant substring.

Revision 1.16  1992/01/08  17:10:15  colin
Added code to maintain unique tyname and strname_ids across modules.

Revision 1.15  1992/01/07  17:09:25  colin
changed encode and decode tyname_id to work with new tyname_id (ie no
number of constructor field)

Revision 1.14  1992/01/06  15:20:20  colin
Changed encoding for meta strnames to mainting sharing of identical
refs on decoding of type environments.

Revision 1.13  1991/12/20  16:25:17  jont
Fixed bug whereby decoded lists arrived backwards

Revision 1.12  91/12/20  12:00:13  jont
Changed the header ordering to a more readily extensible system

Revision 1.11  91/12/20  01:19:22  jont
Fixed problem in decoding parser envs where the pointer was being reset
to 0

Revision 1.10  91/12/19  17:03:10  jont
Tidied up to use map and list and pair encodings and decodings. Should
improve consistency between encode and decode

Revision 1.9  91/12/18  19:44:40  jont
Added encoding and decoding of typechecker bases

Revision 1.8  91/12/17  19:34:04  jont
Finished parser environment encapsulation. Began typechecker basis work.

Revision 1.7  91/12/16  19:25:15  jont
Wrote input_file, and added temporary versions for encoding and decoding
parser environments

Revision 1.6  91/12/16  17:04:38  jont
Completed decoding of lambda environments

Revision 1.5  91/12/11  11:44:41  jont
Added encoding and decoding of lambda environments

Revision 1.4  91/11/11  16:55:04  jont
Output of real numbers added

Revision 1.3  91/10/18  15:23:04  jont
Put zero termination on strings

Revision 1.2  91/10/17  18:02:29  jont
Acquired opcodes and magic number from ObjectFile

Revision 1.1  91/10/16  13:47:53  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

(*
Straightforward encoding of typechecker bases, with two special points:

1. because there is a circular data structure with valenv ->
typescheme -> type -> tyname -> ref valenv, valenvs are cached (by
their ref unit component) and repeated valenvs are just encoded by
their number. Decoding is similar (although a dummy ref valenv must be
used for each valenv on the cache list until its decoding is complete).

2. tynames repeat frequently in a basis, and are cached (in a similar
way, using their ref bool) to save volume of output (a 3-fold saving
for the initial basis).

Note: we might well have to change this to modify type and structure
names (so that several decoded specs can just be added together using
the existing functions (basis_circle_plus_basis in this case, which
does a nameset union, which tests for equality among tynames, etc.).)
*)
(* 8/1/92 cim

The code has been added which maintains uniqueness of strname_id's and
tyname_id's so that generativity works properly over separately compiled
modules. The following two points should be noted:

1. tyfun_id's are not treated using this mechanism. I think that tyfun_id's are
always bound in the module's basis. but if this is a problem the code for
tyname and strname_id's can easily be applied to tyfun_id's.

2. equality of ref's in metastrnames is not guaranteed between modules
(internally within modules this is guaranteed as there was a now fixed bug with
this). However, metastrnames are only compared by ptr equality when they are
pointing to NULLNAME. (as opposed to the STRNAME of Strname_id case in which
case ptrs are followed and strname_ids are compared and the new mechanism
ensures that strname_ids are kept consistent). This would be a problem if
metastrnames pointing to NULLNAME are shared across modules but I ASSUME this
doesn't happen.

*)

require "^.basis.__int";
require "^.basis.__real";
require "^.basis.__byte";
require "^.basis.__string";
require "^.basis.__list";
require "^.basis.__word8_array";
require "^.basis.__word8";
require "^.basis.bin_io";
require "^.basis.prim_io";
require "^.basis.__io";
require "^.system.__os";
require "^.system.__time";

require "../utils/mlworks_timer";
require "../utils/crash";
require "../utils/lists";
require "../utils/intnewmap";
require "../utils/hashtable";
require "../utils/inthashtable";
require "../parser/parserenv";
require "../typechecker/basis";
require "../typechecker/nameset";
require "../typechecker/types";
require "../typechecker/stamp";
require "../typechecker/strnames";
require "../typechecker/environment";
require "../lambda/environtypes";
require "../main/pervasives";
require "../main/info";
require "../main/code_module";
require "../rts/gen/objectfile";
require "../debugger/debugger_types";
require "enc_sub";
require "encapsulate";

functor Encapsulate (
  structure Timer : INTERNAL_TIMER
  structure Crash : CRASH
  structure Lists : LISTS
  structure IntMap : INTNEWMAP
  structure ParserEnv : PARSERENV
  structure Basis : BASIS
  structure Nameset : NAMESET
  structure Types : TYPES
  structure Stamp : STAMP
  structure Strnames : STRNAMES
  structure Env : ENVIRONMENT
  structure Pervasives : PERVASIVES
  structure Info : INFO
  structure Code_Module : CODE_MODULE
  structure ObjectFile : OBJECTFILE
  structure Enc_Sub : ENC_SUB
  structure Debugger_Types : DEBUGGER_TYPES
  structure HashTable : HASHTABLE
  structure IntHashTable : INTHASHTABLE
  structure EnvironTypes : ENVIRONTYPES
  structure BinIO : BIN_IO where type StreamIO.pos = int
  structure PrimIO : PRIM_IO where type pos = int where type writer = BinIO.StreamIO.writer where type vector = BinIO.vector where type reader = BinIO.StreamIO.reader

  sharing Basis.BasisTypes.Datatypes = Types.Datatypes =
    Enc_Sub.DataTypes =
    Env.Datatypes = Strnames.Datatypes = Nameset.Datatypes
  sharing ParserEnv.Ident = Types.Datatypes.Ident = EnvironTypes.LambdaTypes.Ident
  sharing Types.Datatypes.NewMap = ParserEnv.Map = EnvironTypes.NewMap
  sharing ParserEnv.Ident.Location = Info.Location

  sharing type Basis.BasisTypes.Nameset = Nameset.Nameset
  sharing type Debugger_Types.Tyname = Basis.BasisTypes.Datatypes.Tyname
  sharing type Debugger_Types.Type = EnvironTypes.LambdaTypes.Type =
    Basis.BasisTypes.Datatypes.Type = Debugger_Types.RuntimeEnv.Type
  sharing type Pervasives.pervasive = EnvironTypes.LambdaTypes.Primitive
  sharing type Basis.BasisTypes.Datatypes.Stamp = Stamp.Stamp
  sharing type Basis.BasisTypes.Datatypes.StampMap = Stamp.Map.T
) : ENCAPSULATE =
  struct
    structure Ident = ParserEnv.Ident
    structure BasisTypes = Basis.BasisTypes
    structure Datatypes = BasisTypes.Datatypes
    structure EnvironTypes = EnvironTypes
    structure Symbol = Ident.Symbol
    structure Code_Module = Code_Module
    structure ParserEnv = ParserEnv
    structure Basis = Basis
    structure Debugger_Types = Debugger_Types
    structure NewMap = Datatypes.NewMap
    structure IntMap = IntMap
    structure RuntimeEnv = Debugger_Types.RuntimeEnv
    structure Info = Info

    structure Bits = MLWorks.Internal.Bits

    type Module = Code_Module.Module

(*    val filename_debugging_ref = ref ""  (* for debugging *)
*)

    (* A constant for hash table sizes *)
    (* We could diddle with this maybe *)

    val hash_size = 128

    (* should we print encapsulation/decapsulation timings? *)

    val do_timings = ref false

    val real_divisor = Real.fromInt(1000000);

    (* A string hashing function adding together the character values
       of a string, plus the length of the string *)

    fun add_together_ords s =
      let
	fun add_together_ords'(x, acc) =
	  if x<0 then acc
	  else add_together_ords'(x-1, acc + ord(String.sub(s,x)))
      in
	add_together_ords'(size s - 1, size s)
      end

    (* bad input exception and some functions for constructing it *)

    exception BadInput of string
    fun CorruptFile n = BadInput ("Corrupt object file - " ^
				  Int.toString n)
    fun TypeDecapError n = BadInput ("Corrupt object file \
				     \(Failed during type decapsulation) - " ^
				     Int.toString n)
    fun VersionError n = BadInput (".mo file version incorrect " ^
				   Int.toString n)

    (* First, decodings. The signature has functions input_all and
     input_info to actually open a file, read information, and decode
     bits of it. input_info reads the consistency information and the
     number of generative names (e.g. strnames). input_all also reads
     the parser and lambda environments and decodes them. It reads the
     type environment but does not decode it. Instead it returns it as
     a string. If we want a decoded version, we call decode_type_basis
     on the string. *)

    (* functions for reading values from a buffer string: *)

    (* first, ints and optints: *)

    local
      fun inputi (s:string, ptr:int):int =
	let val sz = size s
	in
	  if (ptr+3) < sz then
	    let
	      val x = Bits.lshift(ord(String.sub(s, ptr)), 8)
	      val y = Bits.lshift(Bits.orb(ord(String.sub(s, ptr + 1)), x), 8)
	      val z = Bits.lshift(Bits.orb(ord(String.sub(s, ptr + 2)), y), 8)
	    in
	      Bits.orb (z, ord(String.sub(s, ptr+3)))
	    end
	  else
	    raise MLWorks.String.Ord (* make this explicit *)
	end (* inputi *)

    in
      fun input_int(s, ptr) = (inputi(s, ptr), ptr + 4)

      fun input_opt_int(s, ptr) =
	let
	  val tag = MLWorks.String.ordof(s,ptr)
	in
	  if tag = 254 then
	    (Bits.orb(Bits.lshift(MLWorks.String.ordof(s, ptr + 1), 8),
		      MLWorks.String.ordof(s, ptr + 2)), ptr + 3)
	  else if tag = 255 then
	    (inputi(s, ptr + 1), ptr + 5)
	       else
		 (tag, ptr + 1)
	end
    end

  (* now bytes: *)

    fun input_byte(s, ptr) = (MLWorks.String.ordof(s, ptr), ptr + 1)

  (* now sized strings (the size is an optint) *)

    fun input_sz_string (s, ptr) =
      let val (sz, ptr) = input_opt_int(s, ptr)
      in (MLWorks.String.substring(s, ptr, sz), ptr + sz)
      end

  (* now opt_strings. These are cached, so many copies don't get
   * written out. They are used for (e.g) symbol names.  The cache is
   * simply an association between ints and strings. An opt_string is
   * an opt_int, followed by a sized string if the int is zero. If the
   * int is non-zero n, the string is the n'th string to appear in
   * this file. *)

    local
      val stringId = ref 1
      val stringMap = ref (MLWorks.Internal.Array.array(1, ""))
    in
      fun clear_string_map n = (stringId := 1;
				stringMap := MLWorks.Internal.Array.array(n,""))

      fun input_opt_string (s, ptr) =
	let
	  val (id, ptr) = input_opt_int(s, ptr)
	in
	  if id = 0 then
	    let
	      val (str, ptr) = input_sz_string(s, ptr)
	      val strId = !stringId
	    in
	      MLWorks.Internal.Array.update(!stringMap, strId, str);
	      stringId := strId + 1;
	      (str, ptr)
	    end
	  else
	     (MLWorks.Internal.Array.sub(!stringMap, id), ptr)
	end
    end

    (* now functions to input pairs, triples, &c *)

    fun input_pair f g ptr =
      let
	val (fval, ptr) = f ptr
	val (gval, ptr) = g ptr
      in
	((fval, gval), ptr)
      end

    fun input_triple f g h ptr =
      let
	val (fval, ptr) = f ptr
	val (gval, ptr) = g ptr
	val (hval, ptr) = h ptr
      in
	((fval, gval,hval), ptr)
      end

    fun input_quadruple f g h i ptr =
      let
	val (fval, ptr) = f ptr
	val (gval, ptr) = g ptr
	val (hval, ptr) = h ptr
	val (ival, ptr) = i ptr
      in
	((fval, gval,hval,ival), ptr)
      end

    fun input_fivetuple f g h i j ptr =
      let
	val (fval, ptr) = f ptr
	val (gval, ptr) = g ptr
	val (hval, ptr) = h ptr
	val (ival, ptr) = i ptr
	val (jval, ptr) = j ptr
      in
	((fval, gval,hval,ival,jval), ptr)
      end

    fun input_sixtuple f g h i j k ptr =
      let
	val (fval, ptr) = f ptr
	val (gval, ptr) = g ptr
	val (hval, ptr) = h ptr
	val (ival, ptr) = i ptr
	val (jval, ptr) = j ptr
	val (kval, ptr) = k ptr
      in
	((fval, gval,hval,ival,jval,kval), ptr)
      end

    (* functions to input lists. Lists are preceded by a length optint *)

    fun input_list(s, f, ptr) =
      let
	val (count, ptr) = input_opt_int(s, ptr)

	fun dec_sub(0, ptr, done) = (rev done, ptr)
	  | dec_sub(n, ptr, done) =
	    let
	      val (d, ptr) = f ptr
	    in
	      dec_sub(n-1, ptr, d :: done)
	    end
      in
	dec_sub(count, ptr, [])
      end

    (* a function to input maps. This is basically
     from_list (orderfn,eqfn) (input_list (s, input_pair f g, ptr))
     but avoiding reversing the list. *)

    fun input_newmap(s, f, g, ptr, orderfn, eqfn) =
      let
	val (count, ptr) = input_opt_int(s, ptr)
	fun dec_sub(0, ptr, done) = (done, ptr)
	  | dec_sub(n, ptr, done) =
	    let
	      val (fval, ptr) = f ptr
	      val (gval, ptr) = g ptr
	    in
	      dec_sub(n-1, ptr, (fval, gval) :: done)
	    end
	val (list, ptr) = dec_sub(count, ptr, [])
      in
	(NewMap.from_list (orderfn,eqfn) list, ptr)
      end

    (* functions to decode various symbols. They are curried on the
     * input string so they can be specialized in each function
     * which reads symbols *)

    fun decode_symbol s ptr =
      let val (str, ptr) = input_opt_string(s, ptr)
      in (Symbol.find_symbol str, ptr)
      end

    fun decode_strid decode_symbol ptr =
      let val (sy, ptr) = decode_symbol ptr
      in (Ident.STRID sy, ptr)
      end

    fun decode_funid decode_symbol ptr =
      let val (sy, ptr) = decode_symbol ptr
      in (Ident.FUNID sy, ptr)
      end

    fun decode_sigid decode_symbol ptr =
      let val (sy, ptr) = decode_symbol ptr
      in (Ident.SIGID sy, ptr)
      end

    (* a valid is preceded by a byte indicating the identifier class *)

    fun decode_valid (decode_symbol, s) ptr =
      let
	val (sy_type, ptr) = input_byte(s, ptr)
	val (sy, ptr) = decode_symbol ptr
	val id = case sy_type of
	  0 => Ident.VAR sy
	| 1 => Ident.CON sy
	| 2 => Ident.EXCON sy
	| _ => raise CorruptFile 1
      in
	(id, ptr)
      end




    (* a similarly curried function for reading a list in reverse *)

    fun decode_rev_list s f ptr =
      let
	fun dec_sub(0, ptr, done) = (done, ptr)
	  | dec_sub(n, ptr, done) =
	    let
	      val (d, ptr) = f ptr
	    in
	      dec_sub(n-1, ptr, d :: done)
	    end
	val (count, ptr) = input_opt_int(s, ptr)
      in
	dec_sub(count, ptr, [])
      end

    (* Now the type basis, which is quite heavy, but which we only
     * decode if we actually need it (i.e. this function is separately
     * visible in the signature, and is not called in input_all). *)

    fun decode_type_basis
      {type_env, file_name, sub_modules, decode_debug_information,
       pervasive_env = Datatypes.ENV(strenv, tyenv, _)} =
      let
	val s = type_env
	val debug_variables : bool ref = ref(false)
	val decfuntypehashtable = IntHashTable.new hash_size
	val strmap = ref(IntMap.empty : Datatypes.Structure IntMap.T)
	val strmap_count = ref 0
	val dummy_valenvs = ref([] : (int * Datatypes.Valenv ref) list)

	fun search_list element_fn (l, id) =
	  Lists.findOption (fn x => element_fn(x, id)) l

	fun search_tyfun(Datatypes.ETA_TYFUN name, id) =
	  search_tyname(name, id)
	  | search_tyfun(Datatypes.TYFUN(ty, _), id) =
	  search_type(ty, id)
	  | search_tyfun(Datatypes.NULL_TYFUN(_, ref tyf), id) =
	  search_tyfun(tyf, id)

	and search_tyname(Datatypes.METATYNAME{1=ref tyf, ...}, id) =
	  search_tyfun(tyf, id)
	  | search_tyname(name as Datatypes.TYNAME{1=stamp, ...}, id) =
	  if id = stamp then SOME name else NONE

	and search_type(Datatypes.METATYVAR(ref(_, ty, _), _, _), id) =
	  search_type(ty, id)
	  | search_type(Datatypes.META_OVERLOADED{1=ref ty, ...}, id) =
	  search_type(ty, id)
	  | search_type(Datatypes.TYVAR(ref(_, ty, _), _), id) =
	  search_type(ty, id)
	  | search_type(Datatypes.METARECTYPE(ref{3=ty, ...}), id) =
	  search_type(ty, id)
	  | search_type(Datatypes.RECTYPE map, id) =
	  search_list
	  (fn ((_, ty), id) => search_type(ty, id))
	  (Datatypes.NewMap.to_list map, id)
	  | search_type(Datatypes.FUNTYPE(ty1, ty2), id) =
	  (case search_type(ty1, id) of
	     NONE => search_type(ty2, id)
	   | x => x)
	  | search_type(Datatypes.CONSTYPE(ty_list, tyname), id) =
	     (case search_tyname(tyname, id) of
		NONE => search_list search_type (ty_list, id)
	      | x => x)
	  | search_type(Datatypes.DEBRUIJN _, id) = NONE
	  | search_type(Datatypes.NULLTYPE, id) = NONE

	fun search_tyenv(Datatypes.TE map, id) =
	  search_list
	  (fn ((_, Datatypes.TYSTR(tyf, _)), id) =>
	   search_tyfun(tyf, id))
	  (Datatypes.NewMap.to_list map, id)

	fun search_str(Datatypes.STR(_, _, Datatypes.ENV(s, t, _)), id) =
	  (case search_tyenv(t, id) of
	     NONE => search_strenv(s, id)
	   | x => x)
	  | search_str(str as Datatypes.COPYSTR _, id) =
	     search_str(Env.expand_str str, id)

	and search_strenv(Datatypes.SE map, id) =
	  search_list
	  (fn ((_, str), id) => search_str(str, id))
	  (Datatypes.NewMap.to_list map, id)

	fun find_pervasive_tyname tyname_id =
	  case search_tyenv(tyenv, tyname_id) of
	    NONE => search_strenv(strenv, tyname_id)
	  | x => x

	val stamp_count =
	  let
	    val name = OS.Path.base(OS.Path.file file_name)
	  in
	    case NewMap.tryApply'(sub_modules, name) of
	      SOME(_, elt, _) => elt
	    | _ =>
		raise BadInput("sub_module '" ^ name ^ "' missing")
	  end

	fun print_sub_modules_table table =
	  let
	    val names = map
	      (fn dom => dom ^ "\n")
	      (NewMap.domain table)
	  in
	    concat("Table contains:-\n" :: names)
	  end

	fun name_offsets sub_name ptr =
	  case NewMap.tryApply'(sub_modules, sub_name) of
	    SOME(_, x, _) => x
	  | _ =>
	      Info.error'
	      (Info.make_default_options ())
	      (Info.FATAL, Info.Location.FILE file_name,
	       "Unknown module " ^ sub_name)

	fun decode_bool (ptr:int) =
	  let
	    val sz = size s
	  in
	    if ptr < sz then
	      (case ord(String.sub(s, ptr)) of
		 0 => (false, ptr+1)
	       | 1 => (true, ptr+1)
	       | _ => raise CorruptFile 4)
	    else
	      raise MLWorks.String.Ord (* make this explicit *)
	  end (* decode_bool *)
	
	fun decode_string ptr =
	  input_opt_string(s, ptr)

	val decode_symbol = decode_symbol s
	val decode_funid = decode_funid decode_symbol
	val decode_strid = decode_strid decode_symbol
	val decode_sigid = decode_sigid decode_symbol
	val decode_valid = decode_valid (decode_symbol,s)

        fun decode_tycon ptr =
          let val (sy, ptr) = decode_symbol ptr
          in (Ident.TYCON sy, ptr)
          end


	fun decode_tyvar ptr =
	  let
	    val (sy, ptr) = decode_symbol ptr
	    val (b1, ptr) = decode_bool ptr
	    val (b2, ptr) = decode_bool ptr
	  in
	    (Ident.TYVAR(sy, b1, b2), ptr)
	  end

	fun decode_lab ptr =
	  let val (sy, ptr) = decode_symbol ptr
	  in (Ident.LAB sy, ptr)
	  end

	fun decode_tyname_id ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of

	      (* absolute - used for pervasives *)
	      0 =>
		let
		  val (n, ptr) = input_opt_int(s, ptr)
		in
		  (Stamp.make_stamp_n n, ptr, true)
		end

	    (* local *)
	    | 1 =>
		let
		  val (n, ptr) = input_opt_int(s, ptr)
		in
		  (Stamp.make_stamp_n (stamp_count + n), ptr, false)
		end

	    (* external *)
	    | 2 =>
		let
		  val (module, ptr) = decode_string ptr
                  val module = OS.Path.mkCanonical module
		  val (n, ptr) = input_opt_int(s, ptr)
		  val stamp_count = name_offsets module ptr
		in
		  (Stamp.make_stamp_n (stamp_count + n), ptr, false)
		end

	    | _ => raise CorruptFile 6
	  end

	fun decode_tyfun_id ptr =
	  let val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of

	      (* absolute - used for pervasives *)
	      0 =>
		let val (n, ptr) = input_opt_int(s, ptr)
		in (Stamp.make_stamp_n n, ptr)
		end

	    (* local *)
	    | 1 =>
		let val (n, ptr) = input_opt_int(s, ptr)
		in (Stamp.make_stamp_n (stamp_count + n), ptr)
		end

	    (* external *)
	    | 2 =>
		let
		  val (module, ptr) = decode_string ptr
                  val module = OS.Path.mkCanonical module
		  val (n, ptr) = input_opt_int(s, ptr)
		  val stamp_count = name_offsets module ptr
		in
		  (Stamp.make_stamp_n (stamp_count + n), ptr)
		end

	    | _ => raise CorruptFile 7
	  end

	fun decode_strname_id ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of

	      (* absolute - used for pervasives *)
	      0 =>
		let val (n, ptr) = input_opt_int(s, ptr)
		in (Stamp.make_stamp_n n, ptr)
		end

	    (* local *)
	    | 1 =>
		let val (n, ptr) = input_opt_int(s, ptr)
		in (Stamp.make_stamp_n (stamp_count + n), ptr)
		end

	    (* external *)
	    | 2 =>
		let
		  val (module, ptr) = decode_string ptr
                  val module = OS.Path.mkCanonical module
		  val (n, ptr) = input_opt_int(s, ptr)
		  val stamp_count = name_offsets module ptr
		in
		  (Stamp.make_stamp_n (stamp_count + n), ptr)
		end

	    | _ => raise CorruptFile 8
	  end

	fun decode_ol_tyvar ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      5 => (Ident.num_tyvar, ptr)
	    | 7 => (Ident.int_literal_tyvar, ptr)
	    | 8 => (Ident.real_tyvar, ptr)
	    | 9 => (Ident.real_literal_tyvar, ptr)
	    | 10 => (Ident.numtext_tyvar, ptr)
	    | 11 => (Ident.realint_tyvar, ptr)
	    | 12 => (Ident.word_literal_tyvar, ptr)
	    | 13 => (Ident.wordint_tyvar, ptr)
	    | _ => raise CorruptFile 17
	  end

	val dummy_var = Ident.VAR (Ident.Symbol.find_symbol "")

	fun decode_over_loaded ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	    val (tyvar, ptr) = decode_ol_tyvar ptr
	  in
	    case i of
	      1 => (Datatypes.UNARY (dummy_var, tyvar), ptr)
	    | 2 => (Datatypes.BINARY (dummy_var, tyvar), ptr)
	    | 3 => (Datatypes.PREDICATE (dummy_var, tyvar), ptr)
	    | _ => raise CorruptFile 9
	  end

	fun decode_map f g ptr orderfn =
	  let
	    val (assoc_list, ptr) = decode_rev_list s (input_pair f g) ptr
	  in
	    (NewMap.from_list' Ident.lab_lt assoc_list, ptr)
	  end

	val valenvs_so_far = ref 0
	val tyname_valenvs_so_far = ref 0
	val tynames_so_far = ref 0
	val meta_tynames_decoded_in_tree =
	  ref (NewMap.empty ((op<):int * int -> bool,op =))
	  : (int, Datatypes.Tyname ref)NewMap.map ref
	val meta_tynames_so_far = ref 0
	val dummy_tyname =
	  Datatypes.METATYNAME(ref(Datatypes.TYFUN(Datatypes.NULLTYPE, 0)), "",
			       0, ref false, ref Datatypes.empty_valenv,
			       ref false)
	val metatyvar_types_so_far = ref 0
	val meta_overloaded_types_so_far = ref 0
	val tyvar_types_so_far = ref 0
	val metarectype_types_so_far = ref 0
	val rectype_types_so_far = ref 0
	val funtype_types_so_far = ref 0
	val constype_types_so_far = ref 0
	val debruijn_types_so_far = ref 0
	val dummy_funtypescheme =
	  Datatypes.UNBOUND_SCHEME(Datatypes.FUNTYPE(Datatypes.NULLTYPE,
						     Datatypes.NULLTYPE),
				   NONE)
	val dummy_constypescheme =
	  Datatypes.UNBOUND_SCHEME(Types.int_type,
				   NONE)
	val strnames_so_far = ref 0

	fun makehashtable () = IntHashTable.new hash_size

	val strnamehashtable =        makehashtable()
	val metatyvarhashtable =      makehashtable()
	val metaoverloadedhashtable = makehashtable()
	val tyvarhashtable =          makehashtable()
	val metarectypehashtable =    makehashtable()
	val rectypehashtable =        makehashtable()
	val constypehashtable =       makehashtable()
	val debruijnhashtable =       makehashtable()
	val valenvhashtable =         makehashtable()
	val tynamevalenvhashtable =   makehashtable()
	val tynamehashtable =         makehashtable()
	val tyenv_table = ref(IntMap.empty : Datatypes.Tyenv IntMap.T)
	val tyenvs = ref 0

	fun I constructor (env,ptr) = (constructor env,ptr)

	fun decode_strname ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      1 => I Datatypes.STRNAME(decode_strname_id ptr)
	    | 2 =>
		let
		  val (n, ptr) = input_opt_int(s, ptr)
		in
		  if n=0 then
		    let
		      val n = (!strnames_so_far)+1
		      val _ = strnames_so_far := n
		      val (name, ptr) = decode_strname ptr
		      val strname = Datatypes.METASTRNAME(ref name)
		      val _ =
			IntHashTable.update(strnamehashtable, n, strname)
		    in
		      (strname, ptr)
		    end
		  else
		    (IntHashTable.lookup(strnamehashtable, n), ptr)
		end
	    | 3 => I Datatypes.NULLNAME(decode_strname_id ptr)
	    | _ => raise CorruptFile 10
	  end

	fun decode_tyfun ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      1 =>
		let
		  val (ty , ptr) = decode_type ptr
		  val (i, ptr) = input_opt_int(s, ptr)
		in
		  (Datatypes.TYFUN(ty, i), ptr)
		end
	    | 2 => I Datatypes.ETA_TYFUN (decode_tyname ptr)
	    | 3 =>
		let val (tyfunid, ptr) = decode_tyfun_id ptr
		in
		  (Datatypes.NULL_TYFUN(tyfunid,
					(ref(Datatypes.TYFUN(Datatypes.NULLTYPE
							     ,0)))),
		   ptr)
		end
	    | _ => raise CorruptFile 11
	  end

	and decode_typescheme ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      1 =>
		let
		  val (i, ptr) = input_opt_int(s, ptr)
		  val (ty, ptr) = decode_type ptr
		in
		  (Datatypes.SCHEME(i, (ty,NONE)), ptr)
		end
	    | 2 =>
		let val (ty, ptr) = decode_type ptr
		in (Datatypes.UNBOUND_SCHEME(ty,NONE), ptr)
		end
	    | 3 =>
		let val (over, ptr) = decode_over_loaded ptr
		in (Datatypes.OVERLOADED_SCHEME over, ptr)
		end
	    | _ => raise CorruptFile 12
	  end
	
	and decode_type ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      1 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = !metatyvar_types_so_far + 1
		      val _ = metatyvar_types_so_far := n
		      val (i, ptr) = input_opt_int(s, ptr)
		      val (ty, ptr) = decode_type ptr
		      val (b1, ptr) = decode_bool ptr
		      val (b2, ptr) = decode_bool ptr
		      val ty = Datatypes.METATYVAR(ref(i, ty,Datatypes.NO_INSTANCE), b1, b2)
		      val _ = IntHashTable.update (metatyvarhashtable, n, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup(metatyvarhashtable, i), ptr)
		end
	    | 2 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = !meta_overloaded_types_so_far + 1
		      val _ = meta_overloaded_types_so_far := n
		      val (ty, ptr) = decode_type ptr
		      val (tv, ptr) = decode_ol_tyvar ptr
		      val ty = Datatypes.META_OVERLOADED
			(ref ty, tv,
			 Ident.VAR (Ident.Symbol.find_symbol ""),
			 Info.Location.UNKNOWN)
		      val _ = IntHashTable.update (metaoverloadedhashtable, n, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup(metaoverloadedhashtable, i), ptr)
		end
	    | 3 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = (!tyvar_types_so_far)+1
		      val _ = tyvar_types_so_far := n
		      val (i, ptr) = input_opt_int(s, ptr)
		      val (tyvar, ptr) = decode_tyvar ptr
		      val ty = Datatypes.TYVAR(ref (i,Datatypes.NULLTYPE,
						    Datatypes.NO_INSTANCE), tyvar)
		      val _ = IntHashTable.update (tyvarhashtable, n, ty)
		    in
		      (ty, ptr)
		    end		
		  else
		    (IntHashTable.lookup(tyvarhashtable, i), ptr)
		end
	    | 4 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = !metarectype_types_so_far + 1
		      val _ = metarectype_types_so_far := n
		      val (i, ptr) = input_opt_int(s, ptr)
		      val (b1, ptr) = decode_bool ptr
		      val (ty, ptr) = decode_type ptr
		      val (b2, ptr) = decode_bool ptr
		      val (b3, ptr) = decode_bool ptr
		      val ty = Datatypes.METARECTYPE(ref(i, b1, ty, b2, b3))
		      val _ = IntHashTable.update (metarectypehashtable, n, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup(metarectypehashtable, i), ptr)
		end
	    | 5 =>
		let
		  val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = !rectype_types_so_far + 1
		      val _ = rectype_types_so_far := n
		      val (ty,ptr) =
			I Datatypes.RECTYPE (decode_map decode_lab
					     decode_type ptr Ident.lab_order)
		      val _ = IntHashTable.update (rectypehashtable, n, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup(rectypehashtable, i), ptr)
		end
	    | 6 =>
		let
		  val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val c = !funtype_types_so_far + 1
		      val _ = funtype_types_so_far := c
		      val (ty1, ptr) = decode_type ptr
		      val (ty2, ptr) = decode_type ptr
		      val ty = Datatypes.FUNTYPE(ty1, ty2)
		      val _ = IntHashTable.update(decfuntypehashtable,c, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup (decfuntypehashtable,i), ptr)
		end
	    | 7 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val n = !constype_types_so_far + 1
		      val _ = constype_types_so_far := n
		      val (the_list, ptr) = input_list(s, decode_type, ptr)
		      val (tyname, ptr) = decode_tyname ptr
		      val ty = Datatypes.CONSTYPE(the_list,tyname)
		      val _ = IntHashTable.update (constypehashtable, n, ty)
		    in
		      (ty, ptr)
		    end
		  else
		    (IntHashTable.lookup(constypehashtable, i), ptr)
		end
	    | 8 =>
		let val (i, ptr) = input_opt_int(s, ptr)
		in
		  if i = 0 then
		    let
		      val (i, ptr) = input_opt_int(s, ptr)
		      val (b1, ptr) = decode_bool ptr
		      val (b2, ptr) = decode_bool ptr
		      val ty = Datatypes.DEBRUIJN(i, b1, b2,NONE)
		      val n = (!debruijn_types_so_far)+1
		      val _ = debruijn_types_so_far := n
		      val _ = IntHashTable.update(debruijnhashtable, n, ty)
		    in
		      (ty, ptr)
		    end		
		  else
		    (IntHashTable.lookup(debruijnhashtable, i), ptr)
		end
	    | 9 => (Datatypes.NULLTYPE, ptr)
	    | _ => raise CorruptFile 13
	  end

	and decode_valenv ptr =
	  let
	    val (n, ptr) = input_opt_int(s, ptr)
	  in
	    if n=0 then
	      let
		val n = (!valenvs_so_far)+1
		val _ = valenvs_so_far := n
		val valenv : Datatypes.Valenv ref = ref(Datatypes.empty_valenv)
		val _ = IntHashTable.update(valenvhashtable, n, valenv)
	      in
                I (fn map => (valenv := Datatypes.VE (ref 0, map);
                              valenv))
                (input_newmap (s, decode_valid, decode_typescheme,
                               ptr, Ident.valid_lt, Ident.valid_eq))
	      end
	    else
	      let
		val (valenv,ptr) =
		  (IntHashTable.lookup(valenvhashtable, n), ptr)
	      in
		(valenv,ptr)
	      end
	  end

	and decode_dummy_scheme ptr =
	  let
	    val (n, ptr) = input_byte(s, ptr)
	  in
	    case n of
	      1 => (dummy_constypescheme, ptr)
	    | 2 => (dummy_funtypescheme, ptr)
	    | _ => raise CorruptFile 14
	  end

	and decode_dummy_valenv updatetynamehashtable ptr =
	  let
	    val (n, ptr) = input_opt_int(s, ptr)
	    val valenv = ref(Datatypes.VE(ref 0, NewMap.empty(Ident.valid_lt, Ident.valid_eq)))
	  in
	    updatetynamehashtable valenv;
	    dummy_valenvs := (n, valenv) :: !dummy_valenvs;
	    (valenv, ptr)
	  end

	and decode_dummy_valenv_no_update ptr =
	  decode_dummy_valenv (fn _ => ()) ptr

	and decode_tyname ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      1 =>
		let
		  val (n, ptr) = input_opt_int(s, ptr)
		in
		  if n = 0 then
		    let
		      val n = !tynames_so_far + 1
		      val _ = tynames_so_far := n
		      val (tyname_id, ptr, is_pervasive) =
			decode_tyname_id ptr
		      val pervasive_tyname =
			if is_pervasive then
			  find_pervasive_tyname tyname_id
			else
			  NONE
		      val (st, ptr) = decode_string ptr
		      val (i, ptr) = input_opt_int(s, ptr)
		      val (b, ptr) = (I ref o decode_bool) ptr
		      val is_abs = ref(false)
		      val (valenv, ptr) =
			(if !debug_variables then
			   decode_dummy_valenv
			   (fn valenv =>
			    let
			      val tyname =
				case pervasive_tyname of
				  SOME tyname => tyname
				| NONE =>
				    Datatypes.TYNAME
				    (tyname_id,st,i,b,valenv,
				     NONE,is_abs,
				     valenv, 0)
			    (* level is 0 since it is a topdec.
			     (see end of decode_type_basis fn) *)
			    in
			      IntHashTable.update (tynamehashtable, n, tyname)
			    end)
			 else decode_dummy_valenv_no_update) ptr
		      val (is_abs',ptr) = decode_bool ptr
		      val _ = is_abs := is_abs'
		      val tyname =
			case pervasive_tyname of
			  SOME tyname => tyname
			| NONE =>
			    Datatypes.TYNAME
			    (tyname_id,st,i,b,valenv,
			     NONE,
			     is_abs,valenv, 0)
		      (* level 0 for toplevel dec *)

		      val _ = IntHashTable.update (tynamehashtable, n, tyname)
		    in
		      (tyname, ptr)
		    end
		  else
		    (IntHashTable.lookup(tynamehashtable, n), ptr)
		end
	    | 2 =>
		let
		  val (n, ptr) = input_opt_int(s, ptr)
		in
		  if n = 0 then
		    let
		      val r = ref dummy_tyname
		      val tf = ref(Datatypes.TYFUN(Datatypes.NULLTYPE,0))
		      val next = (!meta_tynames_so_far)+1
		      val _ = meta_tynames_so_far := next
		      val _ =
			meta_tynames_decoded_in_tree :=
			NewMap.define(!meta_tynames_decoded_in_tree, next, r)
		      val ((tyfun,st,i,b,valenv,is_abs),ptr) =
			if !debug_variables then
			  let
			    val ((st,i,b,is_abs),ptr) =
			      input_quadruple
			      decode_string (fn ptr =>input_opt_int(s, ptr))
			      (I ref o decode_bool) (I ref o decode_bool)
			      ptr
			    val ((valenv,tyfun),ptr) =
			      input_pair
			      (decode_dummy_valenv
			       (fn valenv => r:=
				Datatypes.METATYNAME(tf,st,i,b,valenv,is_abs)))
			      decode_tyfun ptr
			  in
			    ((tyfun,st,i,b,valenv,is_abs),ptr)
			  end
			else
			  input_sixtuple
			  decode_tyfun decode_string
			  (fn ptr=>input_opt_int(s, ptr)) (I ref o decode_bool)
			  decode_dummy_valenv_no_update (I ref o decode_bool)
			  ptr
		      val tyname =Datatypes.METATYNAME(tf,st,i,b,valenv,is_abs)
		      val _ = tf := tyfun
		    in
		      (r := tyname;
		       (tyname, ptr))
		    end
		  else
		    (!(NewMap.apply (!meta_tynames_decoded_in_tree) n), ptr)
		end
	    | _ => raise CorruptFile 16
	  end

	and decode_runtime_env ptr =
	  let
	    val input_byte = fn ptr => input_byte(s, ptr)
	    fun input_spill_area ptr =
	      let
		val (i, ptr) = input_byte ptr
	      in
		(case i of
		   0 => RuntimeEnv.GC
		 | 1 => RuntimeEnv.NONGC
		 | 2 => RuntimeEnv.FP
		 | _ => raise BadInput"input_spill_area:decode_runtime_env:encapsulate", ptr)
	      end
	    val input_int = fn ptr => input_int(s, ptr)
	    val input_list = fn f=> fn ptr=> input_list(s,f,ptr)
	    val decode_spill =
	      fn ptr =>
	      I ref(
		    let
		      val (i, ptr) = input_byte ptr
		    in
		      case i of
			1 =>
			  let
			    val (j, ptr) = input_int ptr
			  in
			    (RuntimeEnv.OFFSET1 j, ptr)
			  end
		      | 2 =>
			  let
			    val (k, ptr) = input_spill_area ptr
			    val (j, ptr) = input_int ptr
			  in
			    (RuntimeEnv.OFFSET2(k, j), ptr)
			  end
		      | _ => raise BadInput"decode_spill:decode_runtime_env:encapsulate"
		    end)
	    fun decode_string ptr = input_sz_string(s, ptr)
	    fun decode_option decode ptr =
	      let val (i, ptr) = input_byte ptr
	      in
		case i of
		  1 => (NONE,ptr)
		| 2 => I SOME (decode ptr)
		| _ => raise BadInput"decode_option:encapsulate"
	      end
            fun decode_varinfo ptr =
	      let val (i, ptr) = input_byte ptr
	      in
		case i of
		  1 => (RuntimeEnv.NOVARINFO,ptr)
		| 2 =>
                    I RuntimeEnv.VARINFO
                    (input_triple
                     decode_string
                     (fn ptr =>
                      I (fn t =>
                         (ref t, ref (RuntimeEnv.RUNTIMEINFO
                                      (NONE,nil))))
                      (decode_type ptr))
                     (decode_option decode_spill)
                     ptr)
		| _ => raise BadInput"decode_varinfo:encapsulate"
	      end

	    val (i, ptr) = input_byte ptr
	  in
	    case i of
	      1 => I RuntimeEnv.APP(input_triple
				    decode_runtime_env decode_runtime_env
				    (decode_option input_int) ptr)
	    | 2 => (RuntimeEnv.EMPTY,ptr)
            (* Should this attempt to decode the FunInfo slot? *)
	    | 3 => I RuntimeEnv.FN(input_quadruple
				   decode_string decode_runtime_env
				   decode_spill (fn ptr => (RuntimeEnv.INTERNAL_FUNCTION,ptr))
				   ptr)
	    | 4 => I RuntimeEnv.LET
		(input_pair
		 (input_list
		  (input_pair
                   decode_varinfo
		   decode_runtime_env))
                 decode_runtime_env ptr)
	    | 5 => I RuntimeEnv.HANDLE(input_fivetuple
				       decode_runtime_env decode_spill
				       input_int input_int decode_runtime_env
				       ptr)
	    | 6 => I RuntimeEnv.RAISE(decode_runtime_env ptr)
	    | 7 => I RuntimeEnv.SELECT(input_pair input_int decode_runtime_env
				       ptr)
	    | 8 => I RuntimeEnv.STRUCT(input_list decode_runtime_env ptr)
	    | 9 =>
		I RuntimeEnv.SWITCH
		(input_quadruple decode_runtime_env decode_spill input_int
		 (input_list
		  (input_pair
		   (fn ptr =>
		    let
		      val (i, ptr) = input_byte ptr
		    in
		      case i of
			1 => I RuntimeEnv.CONSTRUCTOR(decode_string ptr)
		      | 2 => I RuntimeEnv.INT(decode_string ptr)
		      | 3 => I RuntimeEnv.REAL(decode_string ptr)
		      | 4 => I RuntimeEnv.STRING(decode_string ptr)
		      | 7 => I RuntimeEnv.CHAR(decode_string ptr)
		      | 8 => I RuntimeEnv.WORD(decode_string ptr)
		      | 5 => (RuntimeEnv.DYNAMIC,ptr)
		      | 6 => (RuntimeEnv.DEFAULT,ptr)
		      | _ => raise BadInput"decode_tag:decode_runtime_env:encapsulate"
		    end)
		   decode_runtime_env)) ptr)
	    | 10 => I RuntimeEnv.LIST(input_list decode_runtime_env ptr)
	    | 11 => (RuntimeEnv.BUILTIN,ptr)
	    | _ => raise BadInput"decode_runtime_env:decode_type_basis:encapsulate"
	  end

	fun decode_tystr ptr =
	  let
	    val (tyfun, ptr) = decode_tyfun ptr
	    val (valenv, ptr) = decode_valenv ptr
	  in
	    (Datatypes.TYSTR(tyfun, !valenv), ptr)
	  end

	fun decode_tyenv ptr =
	  let
	    val (i, ptr) = input_opt_int(s, ptr)
	    val table = !tyenv_table
	  in
	    if i = 0 then
	      let
		val (tyenv, ptr) =
		  input_newmap(s, decode_tycon, decode_tystr,
			       ptr, Ident.tycon_lt, Ident.tycon_eq)
		val tyenv = Datatypes.TE tyenv
		val envs = !tyenvs + 1
	      in
		tyenvs := envs;
		tyenv_table := IntMap.define(table, envs, tyenv);
		(tyenv, ptr)
	      end
	    else
	      (IntMap.apply'(table, i), ptr)
	  end

	fun decode_env ptr =
	  let
	    val (strenv, ptr) = decode_strenv ptr
	    val (tyenv, ptr) = decode_tyenv ptr
	    val (valenv, ptr) = decode_valenv ptr
	  in
	    (Datatypes.ENV(strenv, tyenv, !valenv), ptr)
	  end

	and decode_str ptr =
	  let
	    val (n, ptr) = input_opt_int(s, ptr)
	  in
	    case n of
	      0 =>
		let
		  val count = !strmap_count + 1
		  val _ = strmap_count := count
		  val (strname, ptr) = decode_strname ptr
		  val (env, ptr) = decode_env ptr
		  val str = Datatypes.STR(strname,ref NONE,env)
		in
		  strmap := IntMap.define(!strmap, count, str);
		  (str, ptr)
		end
	    | _ => (IntMap.apply'(!strmap, n), ptr)
	  end

	and decode_strenv ptr =
	  let
	    val (strenv, ptr) =
	      input_newmap(s, decode_strid, decode_str,
			   ptr, Ident.strid_lt, Ident.strid_eq)
	  in
	    (Datatypes.SE strenv, ptr)
	  end

	fun decode_nameset ptr =
	  let
	    val (tynames, ptr) = decode_rev_list s decode_tyname ptr
	    val (strnames, ptr) = decode_rev_list s decode_strname ptr
	  in
	    (Nameset.nameset_of_name_lists(tynames, strnames), ptr)
	  end

	fun decode_sigma ptr =
	  let
	    val (nameset, ptr) = decode_nameset ptr
	    val (str, ptr) = decode_str ptr
	  in
	    (BasisTypes.SIGMA(nameset, str), ptr)
	  end

	fun decode_sigenv ptr =
	  let
	    val (sigenv, ptr) =
	      input_newmap(s, decode_sigid, decode_sigma,
			   ptr, Ident.sigid_lt, Ident.sigid_eq)
	  in
	    (BasisTypes.SIGENV sigenv, ptr)
	  end

	fun decode_phi ptr =
	  let
	    val (nameset, ptr) = decode_nameset ptr
	    val (str, ptr) = decode_str ptr
	    val (sigma, ptr) = decode_sigma ptr
	  in
	    (BasisTypes.PHI(nameset, (str, sigma)), ptr)
	  end

	fun decode_funenv ptr =
	  let
	    val (funenv, ptr) =
	      input_newmap(s, decode_funid, decode_phi,
			   ptr, Ident.funid_lt, Ident.funid_eq)
	  in
	    (BasisTypes.FUNENV funenv, ptr)
	  end

	fun decode_int ptr = input_opt_int(s, ptr)

	fun decode_recipe ptr =
	  let
	    val (i, ptr) = input_byte(s, ptr)
	  in
	    case i of
	      0 => (Debugger_Types.NOP,ptr)
	    | 1 =>
		let val (arg,ptr) = input_pair decode_int decode_recipe ptr
		in (Debugger_Types.SELECT arg,ptr)
		end
	    | 2 =>
		let val (args,ptr) =
		  input_list(s, input_pair decode_string decode_recipe, ptr)
		in (Debugger_Types.MAKERECORD args,ptr)
		end
	    | 3 =>
		let val (arg,ptr) = decode_recipe ptr
		in (Debugger_Types.FUNARG arg,ptr)
		end
	    | 4 =>
		let val (arg,ptr) = decode_recipe ptr
		in (Debugger_Types.FUNRES arg,ptr)
		end
	    | 5 =>
		let val (arg,ptr) = input_pair decode_recipe decode_recipe ptr
		in (Debugger_Types.MAKEFUNTYPE arg,ptr)
		end
	    | 6 =>
		let val (arg,ptr) = input_pair decode_int decode_recipe ptr
		in (Debugger_Types.DECONS arg,ptr)
		end
	    | 7 =>
		let val (arg,ptr) =
		  input_pair (fn ptr => input_list(s, decode_recipe, ptr))
		  decode_tyname ptr
		in (Debugger_Types.MAKECONSTYPE arg,ptr)
		end
	    | 8 => (Debugger_Types.ERROR "Encapsulated error string",ptr)
	    | _ => raise BadInput"problems in decoding a recipe"
	  end

        fun decode_funinfo ptr =
          let
            fun foo ptr = input_list(s, input_pair decode_int decode_recipe, ptr)
            val (ty,ptr) = decode_type ptr
            val (is_leaf,ptr) = decode_bool ptr
            val (has_saved_arg,ptr) = decode_bool ptr
            val (annotations,ptr) = foo ptr
            val (runtime_env,ptr) = decode_runtime_env ptr
            val (is_exn,ptr) = decode_bool ptr
          in
            (Debugger_Types.FUNINFO
             {ty = ty,
              is_leaf = is_leaf,
	      has_saved_arg = has_saved_arg,
              annotations = annotations,
              runtime_env = runtime_env,
              is_exn = is_exn},
             ptr)
          end

	fun decode_debug decode_runtime_env ptr =
          let
            val (list,ptr) =
              input_list (s,
                          input_pair decode_string decode_funinfo,
                          ptr)
          in
            (Debugger_Types.debug_info_from_list list, ptr)
          end

	val (debug_variables, ptr) =
	  I (fn b =>
	     (debug_variables := b;b))
	  (decode_bool 0)
	val ((nameset,funenv,sigenv,env), ptr) =
	  if decode_debug_information andalso not debug_variables then
	    ((Nameset.empty_nameset(),
	      BasisTypes.FUNENV(NewMap.empty (fn _ => false,fn _ => true)),
	      BasisTypes.SIGENV(NewMap.empty (fn _ => false,fn _ => true)),
	      Datatypes.ENV
	      (Datatypes.SE(NewMap.empty (fn _ => false,fn _ => true)),
	       Datatypes.TE(NewMap.empty (fn _ => false,fn _ => true)),
	       Datatypes.empty_valenv)),
	    ptr)
	  else
	    input_quadruple
	    decode_nameset decode_funenv decode_sigenv decode_env ptr

	fun read_dummy_valenvs(map, ptr) =
	  let
	    val (count, ptr) = input_opt_int(s, ptr) (* Number of items *)
	    fun read_sub(0, res) = res
	      | read_sub(n, (map, ptr)) =
	      let
		val (i, ptr) = input_byte(s, ptr)
	      in
		case i of
		  1 =>
		    let
		      val (res, ptr) = input_pair decode_int decode_int ptr
		    in
		      read_sub(n-1, (IntMap.define'(map, res), ptr))
		    end
		| 2 =>
		    let
		      (* Here we read a new full valenv as well *)
		      val (res, ptr) = input_pair decode_int decode_int ptr
		      val (valenv, ptr) = decode_valenv ptr
		    in
		      read_sub(n-1, (IntMap.define'(map, res), ptr))
		    end
		| _ => raise CorruptFile 18
	      end

	    val (map, ptr) = read_sub(count, (map, ptr))
	    val (i, ptr) = input_byte(s, ptr) (* See if further lists to be read *)
	  in
	    case i of
	      1 => (map, ptr)
	    | 2 => read_dummy_valenvs(map, ptr)
	    | _ => raise CorruptFile 19
	  end
	val (dummy_valenv_map, ptr) = read_dummy_valenvs(IntMap.empty, ptr)

	fun fixup_valenv(n, ref_ve) =
	  let
	    val m = case IntMap.tryApply'(dummy_valenv_map, n) of
	      NONE => raise CorruptFile 17
	    | SOME m => m
	    val ve = !(IntHashTable.lookup(valenvhashtable, m))
	  in
	    ref_ve := ve
	  end
	val _ =
	  Lists.iterate
	  fixup_valenv
	  (!dummy_valenvs)

	val (debug_information,_) =
	  if debug_variables then
	    decode_debug decode_runtime_env ptr
	  else
	    if decode_debug_information then
	      decode_debug (fn ptr=>(RuntimeEnv.EMPTY,ptr)) ptr
	    else
	      (Debugger_Types.empty_information,ptr)

	(* Set level to 0 since it will be for a topdec *)
	val result = (BasisTypes.BASIS(0,nameset, funenv, sigenv, env),
		      debug_information)
      in
	result
      end handle
      MLWorks.String.Ord => raise TypeDecapError 1
    | MLWorks.String.Substring => raise TypeDecapError 2
    | NewMap.Undefined => raise TypeDecapError 3
    | BadInput m => raise BadInput(m ^ " (Failed during type decapsulation 2)")
    | IntHashTable.Lookup => raise TypeDecapError 4

    local
      (* Now we define input_info, input_all, and input_debug_info *)

      (* See lambda/environtypes.sml. a Top_Env is encoded as an
       * environment size, followed by the Fun_Env, then the
       * Env. FunEnvs and Envs use NewMap encodings. However, ValEnvs
       * occurring in Envs can be repeated, so are cached in a table. *)

      fun decode_lambda_env s =
	let
	  val decode_symbol = decode_symbol s
	  val decode_strid = decode_strid decode_symbol
	  val decode_funid = decode_funid decode_symbol
	  val decode_valid = decode_valid (decode_symbol,s)
	
	  (* keep a map of valenvs *)
	  val val_map = ref(IntMap.empty) :
	    (Ident.ValId, EnvironTypes.comp) NewMap.map IntMap.T ref
	  val val_size = ref 0
	
	  val (total_size, ptr) = input_opt_int(s, 0)
	
	  fun read_env ptr =
	    let
	      val (env_size, ptr) = input_opt_int(s, ptr)
		
	      fun read_field ptr =
		(* every field is either a FIELD or a PRIM *)
		(case input_byte(s, ptr) of
		   (0, ptr) =>
		     let val (offset, ptr) = input_opt_int(s, ptr)
		     in (EnvironTypes.FIELD{index = offset,
					    size = env_size}, ptr)
		     end
		 | (1, ptr) =>
		     let val (offset, ptr) = input_opt_int(s, ptr)
		     in (EnvironTypes.PRIM(Pervasives.decode offset), ptr)
		     end
		 | _ =>
		     raise BadInput"Decoding a field - got neither 1 nor 0")
		
	      fun decode_val_env ptr =
		case input_opt_int(s, ptr) of
		  (* if 0, we haven't seen it before *)
		  (0, ptr) =>
		    let
		      val (val_env, ptr) =
			input_newmap(s, decode_valid, read_field, ptr,
				     Ident.valid_lt, Ident.valid_eq)
		      val new_num = !val_size + 1
		    in
		      val_size := new_num;
		      val_map := IntMap.define(!val_map, new_num, val_env);
		      (val_env, ptr)
		    end
		(* otherwise, we have seen it before; look it up *)
		| (valnum, ptr) => (IntMap.apply'(!val_map, valnum), ptr)
		
	      (* the valenv precedes the strenv *)
	      val (v_env, ptr) = decode_val_env ptr
	      val (s_env, ptr) =
		input_newmap
		(s, decode_strid,
		 input_triple read_env read_field (fn ptr => (false,ptr)),
		 ptr, Ident.strid_lt, Ident.strid_eq)
	    in
	      (EnvironTypes.ENV(v_env, s_env), ptr)
	    end
	
	  fun read_functor_range ptr =
	    let
	      val (offset, ptr) = input_opt_int(s, ptr)
	      val (env, ptr) = read_env ptr
	    in
	      ((EnvironTypes.FIELD{index=offset, size=total_size}, env, false),
	       ptr)
	    end
	
	  val (fun_env, ptr) =
	    input_newmap(s, decode_funid, read_functor_range,
			 ptr, Ident.funid_lt, Ident.funid_eq)
	  val (env, _) = read_env ptr
	in
	  EnvironTypes.TOP_ENV(env, EnvironTypes.FUN_ENV fun_env)
	end

      (* Now the parser environment, which is encoded in the obvious way *)

      fun decode_parser_env s =
	let
	  val fix_map = ref IntMap.empty :
            (Symbol.Symbol, ParserEnv.Fixity) NewMap.map IntMap.T ref
	  val fix_size = ref 0
	  val val_map = ref IntMap.empty : ParserEnv.pVE IntMap.T ref
	  val val_size = ref 0

	  val decode_symbol = decode_symbol s
	  val decode_strid = decode_strid decode_symbol
	  val decode_funid = decode_funid decode_symbol
	  val decode_sigid = decode_sigid decode_symbol
	  val decode_valid = decode_valid (decode_symbol,s)
	  val decode_rev_valid_list = decode_rev_list s decode_valid

	  fun decode_fixity ptr =
	    let val (fixity, ptr) = input_byte(s, ptr)
	    in
	      case fixity of
		0 =>
		  let val (prec, ptr) = input_byte(s, ptr)
		  in (ParserEnv.LEFT prec, ptr)
		  end
	      | 1 =>
		  let val (prec, ptr) = input_byte(s, ptr)
		  in (ParserEnv.RIGHT prec, ptr)
		  end
	      | 2 => (ParserEnv.NONFIX, ptr)
	      | _ => raise CorruptFile 2
	    end
	
	  fun decode_fix_env ptr =
	    let val (fixnum, ptr) = input_opt_int(s, ptr)
	    in
	      case fixnum of
		0 =>
		  let
		    val (fix_env, ptr) =
		      input_newmap(s, decode_symbol, decode_fixity,
				   ptr, Symbol.symbol_lt, Symbol.eq_symbol)
		    val new_num = !fix_size + 1
		  in
		    fix_size := new_num;
		    fix_map := IntMap.define(!fix_map, new_num, fix_env);
		    (fix_env, ptr)
		  end
	      | _ =>
		  (IntMap.apply'(!fix_map, fixnum), ptr)
	    end
	
	  fun error_fn _ = raise BadInput"Encapsulate.decode_val_env"
	
	  fun decode_val_env ptr =
	    let val (valnum, ptr) = input_opt_int(s, ptr)
	    in
	      case valnum of
		0 =>
		  let
		    val (val_env, ptr) = decode_rev_valid_list ptr
		    val val_env =
		      Lists.reducel (fn (pve, valid) =>
				     ParserEnv.addValId(error_fn, valid, pve))
		      (ParserEnv.empty_pVE, val_env)
		    val new_num = !val_size + 1
		  in
		    (val_size := new_num;
		     val_map := IntMap.define(!val_map, new_num, val_env);
		     (val_env, ptr))
		  end
	      | _ =>
		  (IntMap.apply'(!val_map, valnum), ptr)
	    end
	

          fun decode_tycon ptr =
            let
              val (sy, ptr) = decode_symbol ptr
            in
              (Ident.TYCON sy, ptr)
            end


	  fun read_parse_env ptr =
	    let
	      val (fix_env, ptr) = decode_fix_env ptr
	      val (val_env, ptr) = decode_val_env ptr
              val (tycon_env, ptr) =
                input_newmap(s, decode_tycon, decode_val_env,
                             ptr, Ident.tycon_lt,Ident.tycon_eq)
	      val (struct_env, ptr) =
		input_newmap(s, decode_strid, read_parse_env,
			     ptr, Ident.strid_lt,Ident.strid_eq)
	    in
	      (ParserEnv.E(ParserEnv.FE fix_env, val_env,
                           ParserEnv.TE tycon_env,
			   ParserEnv.SE struct_env),
	       ptr)
	    end
	

	  val (fun_env, ptr) =
	    input_newmap(s, decode_funid, read_parse_env,
			 0, Ident.funid_lt, Ident.funid_eq)
	  val (sig_env, ptr) =
	    input_newmap(s, decode_sigid,
                         input_pair read_parse_env
                              (fn ptr => input_list (s,decode_tycon,ptr)),
			 ptr, Ident.sigid_lt, Ident.sigid_eq)
	  val (parse_env, _) = read_parse_env ptr
	in
	  ParserEnv.B(ParserEnv.F fun_env, ParserEnv.G sig_env, parse_env)
	end

      (* Now the consistency information *)

      fun decode_cons s =
	let
	  fun time_from_ints(a, b) =
	    let
	      val high = Real.fromInt a * real_divisor
	      val low = Real.fromInt b
	    in
	      high + low
	    end

	  fun decode_time ptr =
	    let
	      val (a, ptr) = input_int(s, ptr)
	      val (b, ptr) = input_int(s, ptr)
	    in
	      (Time.fromReal(time_from_ints(a, b)), ptr)
	    end
	
	  fun decode_string ptr = input_sz_string(s, ptr)
	
	  fun decode_cons_pair ptr =
	    let
	      val (mod_name, ptr) = decode_string ptr
	      val (time, ptr) = decode_time ptr
	    in
	      ({mod_name = mod_name, time = time}, ptr)
	    end
	
	  val (result, _) =
	    input_list(s, decode_cons_pair, 0)
	in
	  case result
	  of [] => raise BadInput "Missing consistency information"
	  |  {mod_name, time} :: l =>
	    {mod_name = mod_name, time_stamp = time, consistency = l}
	end

      (* Now the file header *)

      fun decode_header header =
	let
	  val (magic,       ptr) = input_int(header, 0)
	  val (version,     ptr) = input_int(header, ptr)
	  val (code_offset, ptr) = input_int(header, ptr)
	  val (cons_size,   ptr) = input_int(header, ptr)
	  val (parser_size, ptr) = input_int(header, ptr)
	  val (type_size,   ptr) = input_int(header, ptr)
	  val (lambda_size, ptr) = input_int(header, ptr)
	  val (strings,     ptr) = input_int(header, ptr)
	  val (stamps,      ptr) = input_int(header, ptr)
	in
	  if magic = ObjectFile.GOOD_MAGIC then
	    if version = ObjectFile.OBJECT_FILE_VERSION then
	      {cons_size = cons_size, parser_size = parser_size,
	       type_size = type_size, lambda_size = lambda_size,
	       stamps = stamps,
	       strings = strings,
	       code_offset = code_offset}
	    else
	      raise VersionError version
	  else
	    raise BadInput "Corrupt object file (1)"
	end

      (* Now a function to actually read from a file *)
      fun checked_input(f, len) =
	let
	  val s = Byte.bytesToString(BinIO.inputN(f, len))
	in
	  if size s <> len then raise BadInput("Corrupt object file (2) " ^ Int.toString(size s) ^ " " ^ Int.toString len)
	  else s
	end
    in
      (* just input the consistency info and numbers of generative names *)

      fun input_info filename =
	let
	  val Error = BadInput("Corrupt object file (3): " ^ filename)
	  val file_handle =
	    BinIO.openIn filename
	    handle IO.Io{name, ...} =>
	      raise BadInput ("Io error in decapsulate: " ^ name)
	in
	  let
	    val header = checked_input(file_handle, ObjectFile.HEADER_SIZE)
	    val {cons_size, stamps, ...} =
	      decode_header header
	    val cons = checked_input(file_handle, cons_size)
	    val {mod_name, time_stamp, consistency} = decode_cons cons
	  (* This must be done before the close_in *)
	  (* Otherwise we end up trying to close files already closed *)
	  in
	    BinIO.closeIn file_handle;
	    {stamps = stamps,
	     mod_name = mod_name,
	     time_stamp = time_stamp,
	     consistency = consistency}
	  end handle
	  MLWorks.String.Ord => (BinIO.closeIn file_handle; raise Error)
	| Lists.Nth => (BinIO.closeIn file_handle; raise Error) (* I dont think this is necessary, see Log 1.66 *)
	| MLWorks.String.Substring => (BinIO.closeIn file_handle; raise Error)
	| NewMap.Undefined => (BinIO.closeIn file_handle; raise Error)
	| BadInput s => (BinIO.closeIn file_handle;
			 raise BadInput (s ^ ": " ^ filename))
	| IntHashTable.Lookup => (BinIO.closeIn file_handle; raise Error)
	| Time.Time => (BinIO.closeIn file_handle; raise Error)
	end

      (* Input the environment and everything else *)

      (*
       * Beware! The ordering of the inputs in the following function
       * is important. This function is written so that immediately
       * after decoding a string it goes out of scope, hence hopefully
       * avoiding sudden increases in heap size due to a number
       * of large live (but already decoded) strings.
       *)


      fun input_all filename =
	let
	  fun error s =
	    raise BadInput ("Corrupt object file (4): " ^ s ^ ": " ^ filename)
	  val file_handle =
	    BinIO.openIn filename
	    handle IO.Io{name, ...} =>
	      raise BadInput ("Io error in decapsulate: " ^ name)
	in
	  let
	    val
	      {cons_size, parser_size, type_size,
	       lambda_size, stamps, strings, ...} =
	      decode_header(checked_input(file_handle,
					  ObjectFile.HEADER_SIZE))
	    val _ = clear_string_map strings

	    val {time_stamp, mod_name, consistency} =
	      decode_cons (checked_input (file_handle, cons_size))

	    val result =
	      {consistency = consistency,
	       time_stamp  = time_stamp,
	       mod_name    = mod_name,
	       type_env    = (checked_input(file_handle, type_size)),
	       parser_env  = (checked_input(file_handle, parser_size)),
	       lambda_env  = (checked_input(file_handle, lambda_size)),
	       stamps = stamps}
	  in
	    BinIO.closeIn file_handle;
	    result
	  end handle
	  MLWorks.String.Ord => (BinIO.closeIn file_handle; error "ord")
	| Lists.Nth => (BinIO.closeIn file_handle; error "nth")
	| MLWorks.String.Substring => (BinIO.closeIn file_handle; error "substring")
	| NewMap.Undefined => (BinIO.closeIn file_handle; error "undefined")
	| BadInput s => (BinIO.closeIn file_handle;
			 raise BadInput (s ^ ": " ^ filename))
	| IntHashTable.Lookup => (BinIO.closeIn file_handle; error "lookup")
	| Time.Time => (BinIO.closeIn file_handle; error "Time")
	end

      fun input_debug_info{file_name, sub_modules} =
	let
	  fun error s =
	    raise BadInput ("Corrupt object file (4): " ^ s ^ ": " ^ file_name)
	  val file_handle =
	    BinIO.openIn file_name
	    handle IO.Io{name, ...} =>
	      raise BadInput ("Io error in decapsulate: " ^ name)
	in
	  let
	    val
	      {cons_size, parser_size, type_size,
	       lambda_size, stamps, strings, ...} =
	      decode_header(checked_input(file_handle,
					  ObjectFile.HEADER_SIZE))
	    val _ = clear_string_map strings

	    val _ = decode_cons(checked_input(file_handle, cons_size))
	    val type_env = (checked_input(file_handle, type_size))
	  in
	    BinIO.closeIn file_handle;
	    #2(decode_type_basis
	       {type_env=type_env,
		file_name=file_name,
		sub_modules=sub_modules,
		decode_debug_information=true,
		pervasive_env =
		Datatypes.ENV(Datatypes.SE(NewMap.empty' (op =)),
			      Datatypes.TE(NewMap.empty' (op =)),
			      Datatypes.empty_valenv)})
	  end handle
	  MLWorks.String.Ord => (BinIO.closeIn file_handle; error "ord")
	| Lists.Nth => (BinIO.closeIn file_handle; error "nth")
	| MLWorks.String.Substring => (BinIO.closeIn file_handle; error "substring")
	| NewMap.Undefined => (BinIO.closeIn file_handle; error "undefined")
	| BadInput s => (BinIO.closeIn file_handle;
			 raise BadInput (s ^ ": " ^ file_name))
	| IntHashTable.Lookup => (BinIO.closeIn file_handle; error "lookup")
	| Time.Time => (BinIO.closeIn file_handle; error "Time")
	end

      fun decode_all
	{parser_env,
	 lambda_env,
	 type_env,
	 file_name,
	 sub_modules,
	 decode_debug_information,
	 pervasive_env} =
	let
	  val (type_env, debug_info) =
	    decode_type_basis
	    {type_env=type_env,
	     file_name=file_name,
	     sub_modules=sub_modules,
	     decode_debug_information=decode_debug_information,
	     pervasive_env=pervasive_env}
	in
	  (decode_parser_env parser_env,
	   decode_lambda_env lambda_env, type_env, debug_info)
	end

      fun code_offset file_name =
	let
	  fun error s =
	    raise BadInput ("Corrupt object file (4): " ^ s ^ ": " ^ file_name)

	  val file_handle =
	    BinIO.openIn file_name
	    handle IO.Io{name, ...} =>
	      raise BadInput ("Io error in decapsulate: " ^ name)
	in
	  let
	    val
	      {code_offset, ...} =
	      decode_header(checked_input(file_handle,
					  ObjectFile.HEADER_SIZE))
	  in
	    BinIO.closeIn file_handle;
	    code_offset
	  end handle
	  MLWorks.String.Ord => (BinIO.closeIn file_handle; error "ord")
	| Lists.Nth => (BinIO.closeIn file_handle; error "nth")
	| MLWorks.String.Substring => (BinIO.closeIn file_handle; error "substring")
	| NewMap.Undefined => (BinIO.closeIn file_handle; error "undefined")
	| BadInput s => (BinIO.closeIn file_handle;
			 raise BadInput (s ^ ": " ^ file_name))
	| IntHashTable.Lookup => (BinIO.closeIn file_handle; error "lookup")
	| Time.Time => (BinIO.closeIn file_handle; error "Time")
	end

      fun input_code file_name =
	let
	  fun error s =
	    raise BadInput ("Corrupt object file (4): " ^ s ^ ": " ^ file_name)

	  val file_handle =
	    BinIO.openIn file_name
	    handle IO.Io{name, ...} =>
	      raise BadInput ("Io error in decapsulate: " ^ name)

	  fun read_byte _ =
	    case BinIO.input1 file_handle of
	      SOME elem => Word8.toInt elem
	    | NONE => error"read_byte failure"

	  fun ignore_byte _ = ignore(read_byte());

	  fun read_int _ =
	    let
	      val b1 = read_byte()
	      val b2 = read_byte()
	      val b3 = read_byte()
	      val b4 = read_byte()
	    in
	      Bits.orb(Bits.lshift(b1, 24),
		       Bits.orb(Bits.lshift(b2, 16),
				Bits.orb(Bits.lshift(b3, 8), b4)))
	    end
	
	  fun read_sized_string size =
	    Byte.bytesToString(BinIO.inputN(file_handle, size))

	  fun read_string() = read_sized_string(read_int())

	  fun read_extended_string() =
	    let
	      val sz = read_int()
	      val vec = BinIO.inputN(file_handle, sz-1)
	      val string = Byte.bytesToString vec
	    in
	      (case Bits.andb(size string, 3) of
		 0 => (ignore_byte(); ignore_byte(); ignore_byte(); ignore_byte())
	       | 1 => (ignore_byte(); ignore_byte(); ignore_byte())
	       | 2 => (ignore_byte(); ignore_byte())
	       | 3 => ignore_byte()
	       | _ => Crash.impossible "Encapsulate.read_extended_string");
		 string
	    end

	  fun read_element() =
	    let
	      val opcode = read_int()
	    in
	      if opcode = ObjectFile.OPCODE_REAL then
		let
		  val i = read_int()
		  val sz = read_int()
		  val r = read_sized_string(sz * 4)
		in
		  Code_Module.REAL(i, r)
		end
	      else
	      if opcode = ObjectFile.OPCODE_STRING then
		let
		  val i = read_int()
		  val s = read_extended_string()
		in
		  Code_Module.STRING(i, s)
		end
	      else
	      if opcode = ObjectFile.OPCODE_CODESET then
		let
		  val len = read_int()
		  val wordset_size = read_int()
		  fun read_names(res, n) =
		    if n <= 0 then
		      rev res
		    else
		      let
			val str = read_extended_string()
		      in
			read_names(str :: res, n-1)
		      end
		  val names = read_names([], len)
		  val interceptible = read_int()
		  fun read(w_list, leafs, intercepts, parms, n) =
		    if n <= 0 then
		      (rev w_list, rev leafs, rev intercepts, rev parms)
		    else
		      let
			val a_clos = read_int()
			val b_spills = read_int()
			val c_saves = read_int()
			val leaf = read_int() = 1
			val offset = read_int()
			val parm = read_int()
			val d_code = read_string()
		      in
			read({a_clos=a_clos, b_spills=b_spills, c_saves=c_saves, d_code=d_code} :: w_list,
			     leaf :: leafs, offset :: intercepts, parm :: parms, n-1)
		      end
		  val (w_list, leaf_list, offsets_list, parms_list) =
		    read([], [], [], [], len)
		in
		  Code_Module.WORDSET(Code_Module.WORD_SET
				      {a_names = names,
				       b = w_list,
				       c_leafs=leaf_list,
				       d_intercept=offsets_list,
				       e_stack_parameters=parms_list})
		end
	      else
	      if opcode = ObjectFile.OPCODE_EXTERNAL then
		let
		  val i = read_int()
		  val s = read_extended_string()
		in
		  Code_Module.EXTERNAL(i, s)
		end
	      else
		error"Unknown opcode"
	    end

	  fun read_elements(elts, n) =
	    if n <= 0 then rev elts else read_elements(read_element() :: elts, n-1)

	  fun decode_code(arg as (file_handle, offset)) =
	    let
	      val _ = checked_input arg
	      (* Skip the type info etc *)
	      val elements = read_int()
	      val real_objects = read_int()
	    in
	      Code_Module.MODULE(read_elements([], elements))
	    end

	in
	  let
	    val
	      {cons_size, parser_size, type_size,
	       lambda_size, stamps, strings, code_offset} =
	      decode_header(checked_input(file_handle,
					  ObjectFile.HEADER_SIZE))
	    val code = decode_code(file_handle, code_offset - ObjectFile.HEADER_SIZE)
	  in
	    BinIO.closeIn file_handle;
	    code
	  end handle
	  MLWorks.String.Ord => (BinIO.closeIn file_handle; error "ord")
	| Lists.Nth => (BinIO.closeIn file_handle; error "nth")
	| MLWorks.String.Substring => (BinIO.closeIn file_handle; error "substring")
	| NewMap.Undefined => (BinIO.closeIn file_handle; error "undefined")
	| BadInput s => (BinIO.closeIn file_handle;
			 raise BadInput (s ^ ": " ^ file_name))
	| IntHashTable.Lookup => (BinIO.closeIn file_handle; error "lookup")
	| Time.Time => (BinIO.closeIn file_handle; error "Time")
	end

    end

    (* Now the definition of clean_basis, which resets all the uniques
     * in a type basis *)

    local

      fun reset_refs(BasisTypes.BASIS(_, nameset, funenv, sigenv, env), value)=
	let
	  fun reset_map_range fun2 m =
	    NewMap.iterate (fun2 o #2) m
	  fun reset_newmap_range fun2 m = NewMap.iterate (fun2 o #2) m
	  fun reset_strnameid_map_range fun2 m =
	    Stamp.Map.iterate (fun2 o #2) m
	  fun reset_tynameid_map_range fun2 m =
	    Stamp.Map.iterate (fun2 o #2) m
	  fun reset_tyname_id n = ()
	  fun reset_strname_id n = ()
	  fun reset_strname(Datatypes.STRNAME s) = reset_strname_id s
	    | reset_strname(Datatypes.METASTRNAME s) = ()
	    | reset_strname(Datatypes.NULLNAME s) = reset_strname_id s
	
	  fun reset_valenv(Datatypes.VE(r, M)) =
	    let val n = !r
	    in
	      if n = value then
		()
	      else
		(r := value;
		 reset_newmap_range reset_typescheme M)
	    end
	
	  and reset_tyname(Datatypes.TYNAME(ti, _, _, _, ref ve,_,_,_,_)) =
	    (reset_tyname_id ti;
	     reset_valenv ve)
	    | reset_tyname(Datatypes.METATYNAME(ref tf, _, _, _, ref ve, _)) =
	      (reset_tyfun tf;
	       reset_valenv ve)
	
	  and reset_type(Datatypes.METATYVAR(ref(_, t,_), _, _)) = reset_type t
	    | reset_type(Datatypes.META_OVERLOADED{1=ref t,...}) = reset_type t
	    | reset_type(Datatypes.TYVAR _) = ()
	    | reset_type(Datatypes.METARECTYPE(ref(_,_,t,_,_))) = reset_type t
	    | reset_type(Datatypes.RECTYPE M) =
	      reset_map_range reset_type M
	    | reset_type(Datatypes.FUNTYPE(t1, t2)) =
	      (reset_type t1;
	       reset_type t2)
	    | reset_type(Datatypes.CONSTYPE(l, t)) =
	      (app reset_type l;
	       reset_tyname t)
	    | reset_type(Datatypes.DEBRUIJN _) = ()
	    | reset_type(Datatypes.NULLTYPE) = ()
	
	  and reset_typescheme(Datatypes.SCHEME(_, (t,_))) = reset_type t
	    | reset_typescheme(Datatypes.UNBOUND_SCHEME (t,_)) = reset_type t
	    | reset_typescheme(Datatypes.OVERLOADED_SCHEME _) = ()
	
	  and reset_tyfun(Datatypes.TYFUN(t, n)) = reset_type t
	    | reset_tyfun(Datatypes.ETA_TYFUN tn) = reset_tyname tn
	    | reset_tyfun(Datatypes.NULL_TYFUN tfi) = ()
	
	  and reset_tystr(Datatypes.TYSTR(tf, ve)) =
	    (reset_tyfun tf;
	     reset_valenv ve)
	
	  and reset_tyenv(Datatypes.TE M) =
	    reset_newmap_range reset_tystr M
	
	  and reset_str(Datatypes.STR(sn,_,e)) =
	    (reset_strname sn;
	     reset_env e)
	    | reset_str(Datatypes.COPYSTR((smap,tmap),str)) =
	      (reset_str str;
	       reset_strnameid_map_range reset_strname smap;
	       reset_tynameid_map_range reset_tyname tmap)
	
	  and reset_strenv(Datatypes.SE M) = reset_newmap_range reset_str M
	
	  and reset_env(Datatypes.ENV(se, te, ve)) =
	    (reset_strenv se;
	     reset_tyenv te;
	     reset_valenv ve)
	
	  and reset_sigma(BasisTypes.SIGMA(ns, s)) =
	    (reset_nameset ns;
	     reset_str s)
	
	  and reset_sigenv(BasisTypes.SIGENV M) =
	    reset_newmap_range reset_sigma M
	
	  and reset_phi(BasisTypes.PHI(ns, (s, sg))) =
	    (reset_nameset ns;
	     reset_str s;
	     reset_sigma sg)
	
	  and reset_funenv(BasisTypes.FUNENV M) =
	    reset_newmap_range reset_phi M
	
	  and reset_nameset ns =
	    (app reset_tyname (Nameset.tynames_of_nameset ns);
	     app reset_strname (Nameset.strnames_of_nameset ns))
	in
	  (reset_nameset nameset;
	   reset_funenv funenv;
	   reset_sigenv sigenv;
	   reset_env env)
	end
    in
      fun clean_basis basis =
	(reset_refs(basis, ~1);
	 reset_refs(basis, 0))
    end

  (* Now encodings. We're working towards a definition of the function
   * output_file, which takes type information, parser environment,
   * code, &c and writes it all out. First we define a bunch of
   * encoding functions for common types. *)

    (* a type for remembering lists of things to output.  We pass
     * around reversed lists of these objects, then output them together.
     * Optimised ints use this encoding to save bytes:
     * x < 254:		one byte
     * 254 <= x < 2^16: three bytes (254, x div 256, x mod 256)
     * 2^16 <= x : 	five bytes  (255, x) *)

    datatype DelayedEvaluation =
      STRING of string
      | SYMBOL of Symbol.Symbol
      | OPTINT of int
      | BYTE of int
      | INT of int

    fun output_byte i = BYTE i
    fun output_int i = INT i
    fun optimised_output_int i = OPTINT i

    fun encode_bool false = BYTE 0
      | encode_bool true  = BYTE 1

    (* now encodings for generally useful objects. Note that most
     * encoding functions pass around a list of completed encodings,
     * onto which the result is consed. *)

    fun encode_string(done, s) = STRING(s) :: done

    fun encode_list done f l =
      let
	fun rev_map (done, []) = done
	  | rev_map (done, x :: xs) = rev_map(f(done, x), xs)
      in
	rev_map(optimised_output_int(length l) :: done, l)
      end

    fun encode_newmap done f g m =
      let
	val sz = optimised_output_int(NewMap.size m)
      in
	NewMap.fold_in_rev_order
	(fn (done, a, b) => g(f(done, a), b)) (sz :: done, m)
      end

    fun encode_map done f g m =
      let
	val sz =
	  optimised_output_int(NewMap.size m)
      in
	NewMap.fold
	(fn (done, a, b) => g(f(done, a), b))
	(sz :: done, m)
      end

    (* Now encodings for the type system *)

    fun encode_symbol(done, sy) = SYMBOL(sy) :: done

    fun encode_valid(done, Ident.VAR sy) =
      encode_symbol(output_byte 0 :: done, sy)
      | encode_valid(done, Ident.CON sy) =
	encode_symbol(output_byte 1 :: done, sy)
      | encode_valid(done, Ident.EXCON sy) =
	encode_symbol(output_byte 2 :: done, sy)
      | encode_valid _ = Crash.impossible "TYCON':encode_valid:encapsulate"

    fun encode_lab(done, Ident.LAB lab) =
      encode_symbol(done, lab)

    fun encode_tyvar(done, Ident.TYVAR(tyvar, b1, b2)) =
      encode_bool b2 :: encode_bool b1 :: encode_symbol(done, tyvar)

    fun encode_ol_tyvar tyvar =
      if tyvar = Ident.num_tyvar then output_byte 5
      else if tyvar = Ident.int_literal_tyvar then output_byte 7
      else if tyvar = Ident.real_tyvar then output_byte 8
      else if tyvar = Ident.real_literal_tyvar then output_byte 9
      else if tyvar = Ident.numtext_tyvar then output_byte 10
      else if tyvar = Ident.realint_tyvar then output_byte 11
      else if tyvar = Ident.word_literal_tyvar then output_byte 12
      else if tyvar = Ident.wordint_tyvar then output_byte 13
      else case tyvar of
	Ident.TYVAR(sym, _, _) =>
	  Crash.impossible
	  ("Bad tyvar in overloaded type: " ^ Symbol.symbol_name sym)

    fun encode_over_loaded (Datatypes.UNARY (_, tv)) =
      [output_byte 1, encode_ol_tyvar tv]
      | encode_over_loaded (Datatypes.BINARY (_, tv)) =
	[output_byte 2, encode_ol_tyvar tv]
      | encode_over_loaded (Datatypes.PREDICATE (_, tv)) =
	[output_byte 3, encode_ol_tyvar tv]

    (* bigger and more complex type system objects are encoded by
     * subfunctions of output_file, below *)

    (* how many objects in this list of wordsets? *)

    local
      fun count_real_objects'(count, []) = count
	| count_real_objects'(count,
			      Code_Module.WORDSET(Code_Module.WORD_SET
						  {b=w_list, ...})
			      :: rest) =
	  count_real_objects'(count + length w_list, rest)
	| count_real_objects'(count, _ :: rest) =
	  count_real_objects'(count + 1, rest)
    in
      fun count_real_objects l = count_real_objects'(0,l)
    end

    (* Now our one big function for creating a .mo file : *)

    fun output_file debug_variables
      {filename, code, stamps, parser_env, lambda_env,
       type_basis, debug_info, require_list,
       mod_name, time_stamp, consistency} =
      let
	local
	  (* We buffer non-string I/O in a bytearray here. So we
	   * abstract all the actual I/O in this 'local'. *)

          val out_stream = BinIO.getOutstream(BinIO.openOut filename)
	  val (file_handle, buffer_mode) = BinIO.StreamIO.getWriter out_stream
	  val PrimIO.WR{writeVec, getPos, setPos, ...} = file_handle
          fun close() = BinIO.StreamIO.closeOut out_stream
	  val writeVec = valOf writeVec
	  exception WriteFailed
	  fun write s =
	    let
	      val wrote = writeVec{buf=Byte.stringToBytes s, i=0, sz=NONE}
	    in
	      if wrote <> size s then
		raise WriteFailed
	      else
		()
	    end
	  val bufsize = 4096
	  val buffer = Word8Array.array(bufsize, Byte.charToByte#"\000");
	  val bufpos = ref 0		(* next byte position in buffer *)
	  fun flush_buffer () =		(* call this before any I/O op *)
	    if !bufpos > 0 then
	      (write(Byte.unpackString(buffer, 0, SOME(!bufpos)));
	       bufpos := 0)
	    else
	      ()
	in
	  val getPos = valOf getPos
	  val setpos = valOf setPos
	  fun getpos () = (flush_buffer (); getPos ())
	  fun seek pos = (flush_buffer (); setpos pos)
	  fun write_byte i =
	    (if !bufpos >= bufsize
				then flush_buffer ()
			      else ();
			      Word8Array.update(buffer,!bufpos,Word8.fromInt i);
			      bufpos := (!bufpos)+1)
	  fun write_string s = (flush_buffer (); write s)

	  (* pad a string *)
	  fun write_extended_string s =
	    (flush_buffer();
	     write s;
	     case Bits.andb(size s, 3) of
	       0 => (write_byte 0; write_byte 0; write_byte 0; write_byte 0)
	     | 1 => (write_byte 0; write_byte 0; write_byte 0)
	     | 2 => (write_byte 0; write_byte 0)
	     | 3 => (write_byte 0)
	     | _ => Crash.impossible "Encapsulate.write_extended_string")
	
	  val close = fn _ => (flush_buffer(); close());
	end

	fun write_int i =
	  let
	    val b1 = Bits.andb(Bits.rshift(i, 24), 255)
	    val b2 = Bits.andb(Bits.rshift(i, 16), 255)
	    val b3 = Bits.andb(Bits.rshift(i,  8), 255)
	    val b4 = Bits.andb(i, 255)
	  in
	    write_byte b1; write_byte b2; write_byte b3; write_byte b4
	  end
	
	fun write_dummies 0 = ()
	  | write_dummies n = (write_int 0; write_dummies (n-1))
	
	fun write_opt_int i =
	  if i < 254 then
	    write_byte i
	  else if i < 65535 then
	    (write_byte 254;
	     write_byte (Bits.andb(Bits.rshift(i, 8), 255));
	     write_byte(Bits.andb(i, 255)))
	       else
		 (write_byte 255; write_int i)
		
	fun write_bool false = write_byte 0
	  | write_bool true  = write_byte 1
	
	fun write_sz_string s =
	  (write_opt_int(size s); write_string s)

	val total_strings = ref 1
	local
	  val id = ref 0
	  val encodeId = total_strings
	  val encodeMap = ref (NewMap.empty
			       ((op<):string*string->bool,(op=):string*string->bool))
	  fun present (_, old, new) = (id := old; old)
	  val combine = NewMap.combine present
	in
	  fun write_opt_string s =
	    let
	      val new = !encodeId
	    in
	      id := 0;
	      encodeMap := combine (!encodeMap, s, new);
	      if !id = 0 then
		(encodeId := new + 1; write_opt_int 0; write_sz_string s)
	      else
		write_opt_int (!id)
	    end
	end

	fun write_symbol sy =
	  write_opt_string(Symbol.symbol_name sy)
	
	fun do_output object =
	  let
	    fun out [] = ()
	      | out (INT(i)::rest) = (write_int i; out rest)
	      | out (BYTE(i)::rest) = (write_byte i; out rest)
	      | out (OPTINT(i)::rest) = (write_opt_int i; out rest)
	      | out (STRING(s)::rest) = (write_opt_string s; out rest)
	      | out (SYMBOL(sy)::rest) = (write_symbol sy; out rest)
	  in
	    out (rev object)
	  end
	
	fun write_list f l =
	  (write_opt_int(length l); app f l)
	
	fun write_pair f g (a, b) =
	  (ignore(f a); g b)
	
	fun write_triple f g h (a, b, c) =
	  (ignore(f a); ignore(g b); h c)
	
	fun write_quadruple f g h i (a, b, c, d) =
	  (ignore(f a); ignore(g b); ignore(h c); i d)
	
	fun write_fivetuple f g h i j (a, b, c, d, e) =
	  (ignore(f a); ignore(g b); ignore(h c); ignore(i d); j e)
	
	fun write_newmap f g m =
	  (write_opt_int(NewMap.size m);
	   NewMap.iterate_ordered (write_pair f g) m)
	
	fun write_intmap g m =
	  (write_opt_int(IntMap.size m);
	   IntMap.iterate_ordered (write_pair write_opt_int g) m)
	
	fun write_assoc f g a =
	  write_list (write_pair f g) a
	
	(* Now some type-system things *)

	fun write_valid (Ident.VAR sy) =
	  (write_byte 0; write_symbol sy)
	  | write_valid (Ident.CON sy) =
	    (write_byte 1; write_symbol sy)
	  | write_valid (Ident.EXCON sy) =
	    (write_byte 2; write_symbol sy)
	  | write_valid _ = Crash.impossible "TYCON':write_valid:encapsulate"
	
	fun write_sigid (Ident.SIGID sigid) = write_symbol sigid
	
	fun write_funid (Ident.FUNID funid) = write_symbol funid
	
	fun write_strid (Ident.STRID strid) = write_symbol strid
	
	fun write_tycon (Ident.TYCON tycon) = write_symbol tycon
	
	fun write_index (EnvironTypes.FIELD{index, ...}) = write_opt_int index
	  | write_index _ = Crash.impossible"write_index not FIELD"
	
	fun write_index' (EnvironTypes.FIELD{index, ...}) =
          (write_byte 0; write_opt_int index)
	  | write_index' (EnvironTypes.PRIM x) =
	    (write_byte 1; write_opt_int (Pervasives.encode x))
	  | write_index' _ = Crash.impossible"write_index' not FIELD OR PRIM"
	

	(* The parser environment *)

	fun write_parser_env(ParserEnv.B(ParserEnv.F fun_map,
					 ParserEnv.G sig_map,
					 parse_env)) =
	  let
	    fun hash [] = 0
	      | hash ((sy, _) :: _) = add_together_ords (Symbol.symbol_name sy)
		
	    val valhashtable = HashTable.new(hash_size,op =,hash)
	    val fixhashtable = HashTable.new(hash_size,op =,hash)
	
	    val valsize = ref 0
	    val fixsize = ref 0
	
	    fun write_fixity (ParserEnv.LEFT i) = (write_byte 0; write_byte i)
	      | write_fixity (ParserEnv.RIGHT i) = (write_byte 1; write_byte i)
	      | write_fixity (ParserEnv.NONFIX) = write_byte 2
		
            fun write_pve (ParserEnv.VE val_map) =
              let
                val val_list = NewMap.to_list val_map
                val n = HashTable.lookup_default(valhashtable, 0,
                                                 val_list)
                val _ =
                  if n = 0 then
                    let
                      val newsize = !valsize + 1
                    in
                      valsize := newsize;
                      HashTable.update(valhashtable, val_list, newsize);
                      write_opt_int 0;
                      write_list (write_valid o #2) val_list
                    end
                  else
                    write_opt_int n
              in
                ()
              end


	    fun write_pe (ParserEnv.E(ParserEnv.FE fix_map,
                                      pve,
                                      ParserEnv.TE tycon_map,
				      ParserEnv.SE struct_map)) =
	      let
		val fix_list = NewMap.to_list fix_map
		val fixnum =
		  HashTable.lookup_default(fixhashtable, 0, fix_list)
		val _ =
		  if fixnum = 0 then
		    let
		      val newsize = !fixsize + 1
		    in
		      fixsize := newsize;
		      HashTable.update(fixhashtable, fix_list, newsize);
		      write_opt_int 0;
		      write_assoc write_symbol write_fixity fix_list
		    end
		  else
		    write_opt_int fixnum
		
                val _ = write_pve pve
                val _ = write_newmap write_tycon write_pve tycon_map

	      in
		write_newmap write_strid write_pe struct_map
	      end
	  in
	    Timer.xtime
	    ("outputting parser env", !do_timings,
	     fn () =>
	     (write_newmap write_funid write_pe fun_map;
	      write_newmap write_sigid (write_pair write_pe (write_list write_tycon)) sig_map;
	      write_pe parse_env))
	  end

	(* The lambda environment *)
	
	fun write_lambda_env(EnvironTypes.TOP_ENV
			     (env as EnvironTypes.ENV(v, s),
			      EnvironTypes.FUN_ENV fun_env)) =
	  let
	    fun hash [] = 0
	      | hash ((valid, _) :: _) =
		let
		  val sy = case valid of
		    Ident.VAR sy => sy
		  | Ident.CON sy => sy
		  | Ident.EXCON sy => sy
		  | _ => Crash.impossible "TYCON':write_lambda_env:encapsulate"
		in
		  add_together_ords (Symbol.symbol_name sy)
		end	
	
	    val lambdavalhashtable = HashTable.new(hash_size,op =,hash)
	    val valsize = ref 0
	
	    val f_map = NewMap.to_list fun_env
	    val f_len = length f_map
	    val v_len = NewMap.size v
	    val s_len = NewMap.size s
	    val env_len = v_len + s_len
	
	    fun write_sub extra (EnvironTypes.ENV(v_map, s_map)) =
	      let
		val v_list = NewMap.to_list_ordered v_map
		val s_list = NewMap.to_list s_map
		val v_len = length v_list
		val s_len = length s_list
		val env_len = v_len + s_len + extra
		
		val vnum =
		  HashTable.lookup_default(lambdavalhashtable, 0,
					      v_list)
		val _ =
		  if vnum = 0 then
		    let
		      val newsize = !valsize + 1
		    in
		      valsize := newsize;
		      HashTable.update(lambdavalhashtable, v_list, newsize)
		    end
		  else
		    ()

	      in
		write_opt_int env_len;
		write_opt_int vnum;
		if vnum = 0 then write_assoc write_valid write_index' v_list
		else ();
		write_newmap
		write_strid
		(write_triple (write_sub 0) write_index' (fn _=> ())) s_map
	      end
	
	    fun do_ftr_range (field, env, _) =
	      (write_index field; write_sub 0 env)
	
	    val _ =
	      Timer.xtime
	      ("writing lambda env", !do_timings, fn () =>
	       (write_opt_int (f_len + env_len);
		write_newmap write_funid do_ftr_range fun_env;
		write_sub f_len env))
	  in
	    ()
	  end

	(* The type basis (this is the hard part...) *)
	
	fun write_type_basis(BasisTypes.BASIS(_, nameset, funenv, sigenv, env),
			     debug_info, sub_modules) =
	  let
	    val tyenv_table =
	      ref((NewMap.empty (Ident.tycon_lt,Ident.tycon_eq)) :
		  (Ident.TyCon,
		   ((Ident.TyCon, Datatypes.Tystr) NewMap.map * int) list)
		  NewMap.map)

	    val tyenvs = ref 0
	    val metatynamehashtable =
	      HashTable.new(hash_size,Enc_Sub.tyname_same,Enc_Sub.tyname_hash)
	    val tynamehashtable =
	      HashTable.new(hash_size,Enc_Sub.tyname_same,Enc_Sub.tyname_hash)
	    val funtypehashtable =
	      HashTable.new(hash_size,Enc_Sub.type_same,Enc_Sub.type_hash)
	    val constypehashtable =
	      HashTable.new(hash_size,Enc_Sub.type_same,Enc_Sub.type_hash)
	    val rectypehashtable =
	      HashTable.new(hash_size,Enc_Sub.type_same,Enc_Sub.type_hash)
	    val valenvhashtable =
	      HashTable.new(hash_size,Enc_Sub.tyname_valenv_same,
			       Enc_Sub.tyname_valenv_hash)

            local
              (* This is used to look find the module unique stamps are defined in *)
              (* To prevent later confusion, we filter out the modules that define no stamps *)
              val sub_modules_array =
                MLWorks.Internal.Array.arrayoflist
                (Lists.msort
                 (fn ((_, n : int, _), (_, n', _)) => n < n')
                 (List.filter (fn (_,start,extent:int) => extent > 0) sub_modules))

              fun find_module(stamp, first, last) =
                if first+1 = last then
                  let
                    val (module, start, extent) = MLWorks.Internal.Array.sub(sub_modules_array, first)
                  in
                    if stamp >= start andalso stamp < start + extent then
                      (module, stamp - start)
                    else
                      Crash.impossible"stamp_module"
                  end
                else
                  let
                    val mid = (first + last) div 2
                    val (module, start, extent) = MLWorks.Internal.Array.sub(sub_modules_array, mid)
                  in
                    if stamp < start then
                      find_module(stamp, first, mid)
                    else
                      find_module(stamp, mid, last)
                  end
            in
              fun stamp_module n = find_module(n, 0, MLWorks.Internal.Array.length sub_modules_array)
            end

	    val strnames_encoded = ref [] : Datatypes.Strname ref list ref

	    fun strname_hash(Datatypes.STRNAME id) = Stamp.stamp id
	      | strname_hash(Datatypes.NULLNAME id) = Stamp.stamp id
	      | strname_hash(Datatypes.METASTRNAME(ref s)) = strname_hash s
		
	    val strname_enc_hashtable =
	      HashTable.new(hash_size, op=, strname_hash)
	    val strname_enc_count = ref 0
	
	    val valenv_no = ref 0 (* For encoding top level valenvs *)
	    val dummy_valenv_no = ref 0 (* For encoding embedded valenvs (ie in tynames) *)
	    val dummy_valenv_list = ref([] : (int * Datatypes.Valenv) list)
	    val metatyvar_types_encoded =
	      ref [] : ((int * Datatypes.Type * Datatypes.Instance) ref
			* bool * bool) list ref
	    val meta_overloaded_types_encoded = ref [] : Datatypes.Type ref list ref
	    val tyvar_types_encoded = ref [] : (int * Ident.TyVar) list ref
	    val metarectype_types_encoded =
	      ref [] : (int * bool * Datatypes.Type * bool * bool) ref list ref
	    val rectype_types_encoded = ref [] : Datatypes.Type list ref
	    val funtype_types_encoded =
	      ref [] : (Datatypes.Type * Datatypes.Type) list ref
	    val constype_types_encoded = ref [] : Datatypes.Type list ref
	    val debruijn_types_encoded = ref [] : (int * bool * bool) list ref
	    val meta_tynames_encoded = ref [] : Datatypes.Tyname list ref
	    val tyname_valenvs_encoded = ref [] : int ref list ref
	    val meta_tyname_count = ref 0
	    val tyname_count = ref 0
	    val valenv_tyname_count = ref 0
	    val funtype_count = ref 0
	    val constype_count = ref 0
	    val rectype_count = ref 0
	
	    fun encode_tyname_id (done, n) =
	      let val id = Stamp.stamp n
	      in
		if id < Basis.pervasive_stamp_count then
		  optimised_output_int id :: output_byte 0 :: done
		else
		  let
		    val (module,id') = stamp_module id
		  in
		    if module = "" then
		      optimised_output_int id' :: output_byte 1 :: done
		    else
		      optimised_output_int id' ::
		      encode_string (output_byte 2 :: done, module)
		  end
	      end
	
	    fun write_strname_id n =
	      let val id = Stamp.stamp n
	      in	
		if id < Basis.pervasive_stamp_count then
		  (write_byte 0; write_opt_int id)
		else
		  let val (module,id') = stamp_module id
		  in
		    if module = "" then
		      (write_byte 1; write_opt_int id')
		    else
		      (write_byte 2; write_opt_string module;
		       write_opt_int id')
		  end
	      end
	
	    fun encode_tyfun_id (done, n) =
	      let val id = Stamp.stamp n
	      in	
		if id < Basis.pervasive_stamp_count then
		  optimised_output_int id :: output_byte 0 :: done
		else
		  let val (module,id') = stamp_module id
		  in
		    if module = "" then
		      optimised_output_int id' :: output_byte 1 :: done
		    else
		      optimised_output_int id' ::
		      encode_string (output_byte 2 :: done, module)
		  end
	      end
	
	    fun write_strname (Datatypes.STRNAME s) =
	      (write_byte 1; write_strname_id s)
	      | write_strname (Datatypes.METASTRNAME s) =
		let
		  fun es' (h::t) =
		    if h = s then length t + 1 else es' t
		    | es' [] =
		      (strnames_encoded := (s::(!strnames_encoded)); 0)
		  val n = es'(!strnames_encoded)
		in
		  write_byte 2; write_opt_int n;
		  if n = 0 then write_strname (!s) else ()
		end
	      | write_strname (Datatypes.NULLNAME s) =
		(write_byte 3; write_strname_id s)
		
	    fun scheme_type scheme =
	      case Enc_Sub.type_from_scheme scheme of
		Datatypes.CONSTYPE _ => 1
	      | Datatypes.NULLTYPE => 1
	      | Datatypes.FUNTYPE _ => 2
	      | _ => Crash.impossible"encode_fun_or_cons"
		
	    fun encode_fun_or_cons(done, scheme) =
	      output_byte(scheme_type scheme) :: done

	    fun encode_valenv(done, Datatypes.VE(r, M)) =
	      let
		val n = !r
		val done = optimised_output_int n :: done
	      in
		if n = 0 then
		  let
		    val m = !valenv_no + 1
		  in
		    (valenv_no := m;
		     r := m;
		     encode_newmap done encode_valid encode_typescheme M)
		  end
		else done
	      end

	    and encode_dummy_valenv(done, ve) =
	      let
		val n = !dummy_valenv_no + 1
	      in
		dummy_valenv_list := (n, ve) :: !dummy_valenv_list;
		dummy_valenv_no := n;
		optimised_output_int n :: done
	      end

	    and encode_tyname(done,
			      tyn as Datatypes.TYNAME(ti, s, n, ref b,
						      ref ve,_,ref is_abs,
                                                      _,_)) =
	      let
		val pos = HashTable.lookup_default(tynamehashtable, 0, tyn)
		val done = optimised_output_int pos :: output_byte 1 :: done
	      in
		if pos = 0 then
		  let
		    val c = !tyname_count + 1
		    val _ = tyname_count := c
		    val _ = HashTable.update(tynamehashtable,tyn, c)
		  in
		    encode_bool is_abs ::
		    encode_dummy_valenv
		    (encode_bool b :: optimised_output_int n ::
		     encode_string(encode_tyname_id(done, ti), s),
		     ve)
		  end
		else
		  done
	      end
	
	      | encode_tyname(done,
			      tyn as Datatypes.METATYNAME(ref tf, s, n, ref b,
							  ref ve,ref is_abs)) =
		let
		  val pos = HashTable.lookup_default
		    (metatynamehashtable, 0, tyn)
		  val done = optimised_output_int pos :: output_byte 2 :: done
		in
		  if pos = 0 then
		    let
		      val c = !meta_tyname_count + 1
		      val _ = meta_tyname_count := c
		      val _ = HashTable.update(metatynamehashtable,tyn, c)
		    in
		      if debug_variables then
			encode_tyfun(encode_dummy_valenv
				     (encode_bool is_abs ::
				      encode_bool b ::
				      optimised_output_int n ::
				      encode_string(done, s),ve),
				     tf)
		      else
			encode_bool is_abs ::
			(encode_dummy_valenv(encode_bool b ::
					     optimised_output_int n ::
					     encode_string(encode_tyfun
							   (done, tf), s),
					     ve))
		    end
		  else
		    done
		end
	
	    and write_runtime_env env =
	      let
		fun write_spill_area RuntimeEnv.GC = write_byte 0
		  | write_spill_area RuntimeEnv.NONGC = write_byte 1
		  | write_spill_area RuntimeEnv.FP = write_byte 2

		fun write_spill (ref (RuntimeEnv.OFFSET1 spill)) =
		    (write_byte 1; write_int spill)
		  | write_spill (ref (RuntimeEnv.OFFSET2(area, spill))) =
		    (write_byte 2; write_spill_area area; write_int spill)
		fun write_option _ NONE = write_byte 1
		  | write_option write_object (SOME object) =
		    (write_byte 2;write_object object)
		fun write_tag (RuntimeEnv.CONSTRUCTOR s) =
		  (write_byte 1;write_sz_string s)
		  | write_tag (RuntimeEnv.INT s) =
		    (write_byte 2;write_sz_string s)
		  | write_tag  (RuntimeEnv.REAL s) =
		    (write_byte 3;write_sz_string s)
		  | write_tag (RuntimeEnv.STRING s) =
		    (write_byte 4;write_sz_string s)
		  | write_tag (RuntimeEnv.CHAR s) =
		    (write_byte 7;write_sz_string s)
		  | write_tag (RuntimeEnv.WORD s) =
		    (write_byte 8;write_sz_string s)
	          | write_tag RuntimeEnv.DYNAMIC = write_byte 5
		  | write_tag RuntimeEnv.DEFAULT = write_byte 6
		fun write_runtime_env(RuntimeEnv.APP(env)) =
		  (write_byte 1;
		   write_triple write_runtime_env write_runtime_env
		   (write_option write_int) env)
		  | write_runtime_env(RuntimeEnv.EMPTY) = write_byte 2
		  | write_runtime_env(RuntimeEnv.FN(env)) =
		    (write_byte 3;
		     write_quadruple write_sz_string write_runtime_env
		     write_spill (fn _ => ()) env)
		  | write_runtime_env(RuntimeEnv.LET(env as (env1,env2))) =
		    (case env2 of
		       RuntimeEnv.LET([env2],env3) =>
			 write_runtime_env(RuntimeEnv.LET(env1@[env2],env3))
		     | _ =>
			 (write_byte 4;
			  write_pair
			  (write_list
                           (write_pair
                            (fn RuntimeEnv.NOVARINFO =>
                             write_byte 1
                           | RuntimeEnv.VARINFO info =>
                               (write_byte 2;
                                write_triple
                                write_sz_string
                                (fn (ref ty,_) =>
                                 do_output(encode_type([],ty)))
                                (write_option write_spill)
                                info))
                            write_runtime_env))
			  write_runtime_env env))
		  | write_runtime_env(RuntimeEnv.HANDLE(env)) =
		    (write_byte 5;
		     write_fivetuple write_runtime_env write_spill
		     write_int write_int write_runtime_env env)
		  | write_runtime_env(RuntimeEnv.RAISE(env)) =
		    (write_byte 6;write_runtime_env env)
		  | write_runtime_env(RuntimeEnv.SELECT(env)) =
		    (write_byte 7;
		     write_pair write_int
		     write_runtime_env env)
		  | write_runtime_env(RuntimeEnv.STRUCT(envs)) =
		    (write_byte 8;
		     write_list write_runtime_env envs)
		  | write_runtime_env(RuntimeEnv.SWITCH(envs)) =
		    (write_byte 9;
		     write_quadruple write_runtime_env write_spill write_int
		     (write_list
		      (write_pair write_tag write_runtime_env)) envs)
		  | write_runtime_env(RuntimeEnv.LIST(envs)) =
		    (write_byte 10;
		     write_list write_runtime_env envs)
		  | write_runtime_env(RuntimeEnv.BUILTIN) = write_byte 11
	      in
		write_runtime_env env
	      end
	
	    and encode_type(done,
			    Datatypes.METATYVAR(arg as (ref(n, t,_), b1, b2)))=
	      let
		fun et'(h::t) = if h = arg then length t + 1
				else et' t
		  | et' [] =
		    (metatyvar_types_encoded :=
		     (arg::(!metatyvar_types_encoded)); 0)
		val pos = et'(!metatyvar_types_encoded)
		val done = optimised_output_int pos :: output_byte 1 :: done
	      in
		if pos = 0 then
		  encode_bool b2 :: encode_bool b1 ::
		  encode_type(optimised_output_int n :: done, t)
		else
		  done
	      end
	      | encode_type(done, Datatypes.META_OVERLOADED(arg as ref t,
							    tv, _, _)) =
		let
		  fun et'(h::t) = if h = arg then length t + 1
				  else et' t
		    | et' [] =
		      (meta_overloaded_types_encoded :=
		       (arg::(!meta_overloaded_types_encoded)); 0)
		  val pos = et'(!meta_overloaded_types_encoded)
		  val done = optimised_output_int pos :: output_byte 2 :: done
		in
		  if pos = 0 then
		    encode_ol_tyvar tv :: encode_type(done, t)
		  else
		    done
		end
	      | encode_type(done, Datatypes.TYVAR(ref (n,_,_), t)) =
		let
		  fun et'((n', t')::tl) =
		    if  n = n' andalso t =  t' then
		      length tl + 1
		    else et' tl
		    | et' [] =
		      (tyvar_types_encoded := ((n, t)::
					       (!tyvar_types_encoded)); 0)
		  val pos = et'(!tyvar_types_encoded)
		  val done = optimised_output_int pos :: output_byte 3 :: done
		in
		  if pos = 0 then
		    encode_tyvar(optimised_output_int n :: done, t)
		  else
		    done
		end	
	      | encode_type(done,
			    Datatypes.METARECTYPE(arg as ref(n, b1, t,
							     b2, b3))) =
		let
		  fun et'(h::t) = if h = arg then length t + 1
				  else et' t
		    | et' [] =
		      (metarectype_types_encoded :=
		       (arg::(!metarectype_types_encoded)); 0)
		  val pos = et'(!metarectype_types_encoded)
		  val done = optimised_output_int pos :: output_byte 4 :: done
		in
		  if pos = 0 then
		    encode_bool b3 :: encode_bool b2 ::
		    encode_type(encode_bool b1 :: optimised_output_int n ::
				done, t)
		  else
		    done
		end
	      | encode_type(done, arg as Datatypes.RECTYPE M) =
		let
		  val pos =
		    HashTable.lookup_default
		    (rectypehashtable, 0, arg)
		  val done = optimised_output_int pos :: output_byte 5 :: done
		in
		  if pos = 0 then
		    let
		      val c = !rectype_count + 1
		      val _ = rectype_count := c
		      val _ = if debug_variables then ()
			      else HashTable.update(rectypehashtable,arg, c)
		    in
		      encode_map done encode_lab encode_type M
		    end
		  else
		    done
		end
	      | encode_type(done,
			    full_arg as Datatypes.FUNTYPE(arg as (t1, t2))) =
		let
		  val pos =
		    HashTable.lookup_default
		    (funtypehashtable, 0, full_arg)
		
		  val done = optimised_output_int pos :: output_byte 6 :: done
		in
		  if pos = 0 then
		    let
		      val c = !funtype_count + 1
		      val _ = funtype_count := c
		      val _ = if debug_variables then ()
			      else HashTable.update(funtypehashtable,
						       full_arg, c)
		    in
		      encode_type(encode_type(done, t1), t2)
		    end
		  else
		    done
		end
	      | encode_type(done, arg as Datatypes.CONSTYPE(l, t)) =
		let
		  val pos =
		    HashTable.lookup_default
		    (constypehashtable, 0, arg)
		  val done = optimised_output_int pos :: output_byte 7 :: done
		in
		  if pos = 0 then
		    let
		      val c = !constype_count + 1
		      val _ = constype_count := c
		      val _ = if debug_variables then ()
			      else HashTable.update(constypehashtable,
						       arg, c)
		    in
		      encode_tyname(encode_list done encode_type l, t)
		    end
		  else
		    done
		end
	      | encode_type(done, Datatypes.DEBRUIJN(arg as (n, b1, b2,_))) =
		let
		  fun et'(h::t) = if h = (n,b1,b2) then length t + 1
				  else et' t
		    | et' [] =
		      (debruijn_types_encoded :=
		       ((n,b1,b2)::(!debruijn_types_encoded)); 0)
		  val pos = et'(!debruijn_types_encoded)
		  val done = optimised_output_int pos :: output_byte 8 :: done
		in
		  if pos = 0 then
		    encode_bool b2 :: encode_bool b1 ::
		    optimised_output_int n :: done
		  else
		    done
		end
	      | encode_type(done, Datatypes.NULLTYPE) = output_byte 9 ::
		done
		
	    and encode_typescheme(done, Datatypes.SCHEME(n, (t,_))) =
	      encode_type(optimised_output_int n :: output_byte 1 :: done, t)
	    | encode_typescheme(done, Datatypes.UNBOUND_SCHEME (t,_)) =
	      encode_type(output_byte 2 :: done, t)
	      | encode_typescheme(done, Datatypes.OVERLOADED_SCHEME ov) =
		encode_over_loaded ov @ (output_byte 3 :: done)
		
	    and encode_tyfun(done, tyfun as Datatypes.TYFUN(t, n)) =
	      optimised_output_int n :: encode_type(output_byte 1 :: done, t)
	      | encode_tyfun(done, Datatypes.ETA_TYFUN tn) =
		encode_tyname(output_byte 2 :: done, tn)
	      | encode_tyfun(done, Datatypes.NULL_TYFUN (tfi,_)) =
		encode_tyfun_id(output_byte 3 :: done, tfi)
		
	    fun write_tystr (Datatypes.TYSTR(tf, ve)) =
	      do_output(encode_valenv(encode_tyfun([], tf), ve))
	
	    fun scheme_eq(scheme1, scheme2) =
	      case scheme1 of
		Datatypes.SCHEME(i, (ty,_)) =>
		  (case scheme2 of
		     Datatypes.SCHEME(i', (ty',_)) =>
		       i = i' andalso Types.type_eq(ty, ty', true, false)
		   | _ => false)
	      | Datatypes.UNBOUND_SCHEME (ty,_) =>
		  (case scheme2 of
		     Datatypes.UNBOUND_SCHEME (ty',_) =>
		       Types.type_eq(ty, ty', true, false)
		   | _ => false)
	      | Datatypes.OVERLOADED_SCHEME ov =>
		  (case scheme2 of
		     Datatypes.OVERLOADED_SCHEME ov' => ov = ov'
		   | _ => false)
		
	    fun ve_eq(Datatypes.VE(_, map1), Datatypes.VE(_, map2)) =
	      NewMap.eq (*Scheme.type*) scheme_eq (map1, map2)
	
	    fun pair_eq(eq1, eq2) =
	      fn ((a, b), (a', b')) => eq1(a, a') andalso eq2(b, b')
	
	    fun tystr_eq(Datatypes.TYSTR a, Datatypes.TYSTR b) =
	      pair_eq(Types.tyfun_eq, ve_eq) (a, b)
	
	    val tyenv_eq = NewMap.eq tystr_eq
	
	    fun str_eq(Datatypes.STR(sn, _, env),
		       Datatypes.STR(sn', _, env')) =
	      Strnames.strname_eq(sn, sn') andalso env_eq(env, env')
	      | str_eq _ = Crash.impossible"str_eq on COPYSTR"
		
	    and env_eq(Datatypes.ENV(Datatypes.SE se, Datatypes.TE te, ve),
		       Datatypes.ENV(Datatypes.SE se', Datatypes.TE te', ve'))=
	      NewMap.eq str_eq (se, se') andalso
	      tyenv_eq (te, te') andalso ve_eq (ve, ve')
	
	    datatype 'a option = YES of 'a | NO
	
	    fun eq_assoc eq_fun =
	      let
		fun eq_elt elt =
		  let
		    fun try [] = NO
		      | try ((dom, ran) :: xs) =
			if eq_fun(elt, dom) then
			  YES ran
			else
			  try xs
		  in
		    try
		  end
	      in
		eq_elt
	      end
	
	    fun write_tyenv (Datatypes.TE m) =
	      let
		val tycon =
		  case NewMap.domain_ordered m of
		    tycon :: _ => tycon
		  | _ => Ident.TYCON(Symbol.find_symbol"")
		val table = !tyenv_table
		val envs = !tyenvs + 1
		val i = case NewMap.tryApply'(table, tycon) of
		  SOME list =>
		    (case eq_assoc tyenv_eq m list of
		       YES i => i
		     | NO =>
			 (tyenvs := envs;
			  tyenv_table := NewMap.define(table, tycon,
						       (m, envs) :: list);
			  0))
		| _ =>
		    (tyenvs := envs;
		     tyenv_table := NewMap.define(table, tycon, [(m, envs)]);
		     0)
	      in
		write_opt_int i;
		if i = 0 then
		  write_newmap write_tycon write_tystr m
		else
		  ()
	      end
	
	    fun str_hash(Datatypes.STR{1 = sn, ...}) = strname_hash sn
	      | str_hash(Datatypes.COPYSTR _) =
		Crash.impossible"str_hash on COPYSTR"
		
	    val strhashtable = HashTable.new(hash_size, str_eq, str_hash)
	    val strhashtable_count = ref 0
	
	    fun write_str(str as Datatypes.STR(sn,_,e)) =
	      (case HashTable.lookup_default(strhashtable, 0, str) of
		 0 =>
		   let
		     val count = !strhashtable_count + 1
		   in
		     strhashtable_count := count;
		     HashTable.update(strhashtable, str, count);
		     write_opt_int 0;
		     write_strname sn; write_env e
		   end
	       | n => write_opt_int n)
	      | write_str(Datatypes.COPYSTR((smap, tmap), str)) =
		write_str(Env.str_copy (str,smap,tmap))
		
	    and write_strenv (Datatypes.SE m) =
	      write_newmap write_strid write_str m
	
	    and write_env (Datatypes.ENV(se, te, ve)) =
	      (write_strenv se; write_tyenv te;
	       do_output(encode_valenv([], ve)))
	
	    fun write_nameset ns =
	      (do_output(encode_list []
			 encode_tyname (Nameset.tynames_of_nameset ns));
	       write_list write_strname (Nameset.strnames_of_nameset ns))
	
	    fun write_sigma (BasisTypes.SIGMA(ns, s)) =
	      (write_nameset ns; write_str s)
	
	    fun write_sigenv (BasisTypes.SIGENV M) =
	      write_newmap write_sigid write_sigma M
	
	    fun write_phi (BasisTypes.PHI(ns, (s, sg))) =
	      (write_nameset ns; write_str s; write_sigma sg)
	
	    fun write_funenv (BasisTypes.FUNENV M) =
	      write_newmap write_funid write_phi M
	
	    fun write_dummy_valenv_element(n, ve as Datatypes.VE(ve_ref as ref m, _)) =
	      if m = 0 then
		let
		  val done = encode_valenv([], ve)
		  val m = !ve_ref
		in
		  write_byte 2; write_opt_int n; write_opt_int m; do_output done
		end
	      else
		(write_byte 1; write_opt_int n; write_opt_int m)

	    fun write_dummy_valenvs _ =
	      let
		val valenvs = !dummy_valenv_list
	      in
		dummy_valenv_list := [];
		write_list write_dummy_valenv_element valenvs;
		(case !dummy_valenv_list of
		   [] => write_byte 1 (* Indicate finished writing *)
		 | _ => (write_byte 2; write_dummy_valenvs()))
	      end

	    fun write_recipe value =
	      case value of
		Debugger_Types.NOP =>
		  write_byte 0
	      | Debugger_Types.SELECT(x,y) =>
		  (write_byte 1; write_opt_int x; write_recipe y)
	      | Debugger_Types.MAKERECORD args =>
		  (write_byte 2;
		   write_assoc write_opt_string write_recipe args)
	      | Debugger_Types.FUNARG arg =>
		  (write_byte 3; write_recipe arg)
	      | Debugger_Types.FUNRES arg =>
		  (write_byte 4; write_recipe arg)
	      | Debugger_Types.MAKEFUNTYPE(x,y) =>
		  (write_byte 5; write_recipe x; write_recipe y)
	      | Debugger_Types.DECONS(x,y) =>
		  (write_byte 6; write_opt_int x; write_recipe y)
	      | Debugger_Types.MAKECONSTYPE(x, y) =>
		  (write_byte 7; write_list write_recipe x;
		   do_output(encode_tyname([], y)))
	      | Debugger_Types.ERROR _ =>
		  write_byte 8

            fun write_funinfo (Debugger_Types.FUNINFO {ty,is_leaf,has_saved_arg,annotations,runtime_env,is_exn}) =
              (do_output (encode_type ([],ty));
               write_bool is_leaf;
               write_bool has_saved_arg;
               write_assoc write_opt_int write_recipe annotations;
               write_runtime_env runtime_env;
               write_bool is_exn)

	    fun write_debug write_runtime_env debug_info =
	      write_list (write_pair  write_opt_string write_funinfo)
              (Debugger_Types.debug_info_to_list debug_info)
	  in
	    write_bool debug_variables;
	    Timer.xtime("write_nameset", !do_timings,
			fn () => write_nameset nameset);
	    Timer.xtime("write_funenv",  !do_timings,
			fn () => write_funenv funenv);
	    Timer.xtime("write_sigenv",  !do_timings,
			fn () => write_sigenv sigenv);
	    Timer.xtime("write_env",     !do_timings,
			fn () => write_env env);
	    Timer.xtime("write_dummy_valenvs", !do_timings,
			fn () => write_dummy_valenvs ());
	    Timer.xtime("write_debug",   !do_timings,
			fn () => write_debug (if debug_variables
						then write_runtime_env
					      else fn _ => ())
			debug_info);
	    ()
	  end

	(* The code *)
	
	fun write_code(Code_Module.MODULE element_list) =
	  let
	    fun output_module_element(Code_Module.REAL(i, r)) =
	      (write_int ObjectFile.OPCODE_REAL; write_int i;
	       write_int (size r div 4); write_string r)
	      | output_module_element(Code_Module.STRING(i, s)) =
		(write_int ObjectFile.OPCODE_STRING; write_int i;
		 write_int (size s + 1); write_extended_string s)
	      | output_module_element(Code_Module.MLVALUE(i, s)) =
		Crash.impossible "trying to encapsulate an MLVALUE"
	      | output_module_element
		(Code_Module.WORDSET(Code_Module.WORD_SET
				     {a_names=str_list,
				      b=w_list,
				      c_leafs=leaf_list,
				      d_intercept=offsets_list,
				      e_stack_parameters=parms_list})) =
		let
		  fun write ([], [], [], []) = ()
		    | write ({a_clos=i, b_spills=spills,
			      c_saves=saves, d_code=words}::sets,
			     leaf::leafs,
			     offset::offsets,
			     parm:: parms) =
		      (write_int i;		(* position in closure *)
		       write_int spills;	(* nr of non-gc spills *)
		       write_int saves;		(* nr of callee saves *)
		       write_int (if leaf then 1 else 0); (* leaf flag *)
		       write_int offset;	(* intercept offset *)
		       write_int parm;		(* number of stacked parameters *)
		       write_int (size words);	(* the code length *)
		       write_string words;	(* the code itself*)
		       write (sets, leafs, offsets, parms))
		    | write _ = Crash.impossible"Outputting wordset"
		  fun write_names [] = ()
		    | write_names (n::ns) =
		      (write_int (size n + 1);		(* length of name *)
		       write_extended_string n;		(* name of code item *)
		       write_names ns)
		  val wordset_size =
		    Lists.reducel (fn (res,{d_code, ...})
				   => res+size d_code) (0,w_list)
		  fun interceptible [] = false
		    | interceptible (off::offs) =
		      off <> ~1 orelse (interceptible offs)
		  val interceptible = interceptible offsets_list
		in
		  write_int ObjectFile.OPCODE_CODESET;
		  write_int (length str_list);
		  write_int wordset_size;
		  write_names str_list;
		  write_int (if interceptible then 1 else 0);
		  write (w_list, leaf_list, offsets_list, parms_list)
		end
	      | output_module_element(Code_Module.EXTERNAL(i, s)) =
		(write_int ObjectFile.OPCODE_EXTERNAL; write_int i;
		 write_int (size s + 1); write_extended_string s)
	      | output_module_element(Code_Module.VAR _) =
		Crash.impossible"Encapsulating interpretive code"
	      | output_module_element(Code_Module.EXN _) =
		Crash.impossible"Encapsulating interpretive code"
	      | output_module_element(Code_Module.STRUCT _) =
		Crash.impossible"Encapsulating interpretive code"
	      | output_module_element(Code_Module.FUNCT _) =
		Crash.impossible"Encapsulating interpretive code"
	  in
	    Timer.xtime
	    ("Outputting code", !do_timings, fn () =>
	     (write_int (length element_list);
	      write_int (count_real_objects element_list);
	      app output_module_element element_list))
	  end

	(* The consistency information *)

	fun time_to_ints time =
	  let
	    val real_time = Time.toReal time
	    val high = Real.realFloor(real_time / real_divisor)
	  in
	    (Real.floor high, Real.floor(real_time - high * real_divisor))
	  end

	fun write_cons_pair{mod_name, time} =
	  (write_sz_string mod_name;
	   write_pair write_int write_int (time_to_ints time))
	
	val write_cons = write_list write_cons_pair

	val consistency' =
	  {mod_name = mod_name, time = time_stamp} ::
	  consistency
	
	(* Finally, we start writing to the file: *)

	val _ = (write_int ObjectFile.GOOD_MAGIC;
		 write_int ObjectFile.OBJECT_FILE_VERSION)
	val (header_start, _, header_end) =
	  (getpos(), (write_dummies 6;
		      write_int stamps),
	   getpos())
	val (cons_start, _, cons_end) =
	  (getpos(), write_cons consistency', getpos())
	val (ty_start, _, ty_end) =
	  (getpos(),
	   write_type_basis (type_basis, debug_info, require_list),
	   getpos())
	val (parser_start, _, parser_end) =
	  (getpos(), write_parser_env parser_env, getpos())
	val (lambda_start, _, lambda_end) =
	  (getpos(), write_lambda_env lambda_env, getpos())
	val (code_start, _, code_end) = (getpos(), write_code code, getpos())
      in

	(* go back to the beginning of the file and write the size
	 * fields in the header *)
	seek header_start;
	write_int (code_start);
	write_int (cons_end   - cons_start);
	write_int (parser_end - parser_start);
	write_int (ty_end     - ty_start);
	write_int (lambda_end - lambda_start);
	write_int(!total_strings);
	close ()
      end
  end
