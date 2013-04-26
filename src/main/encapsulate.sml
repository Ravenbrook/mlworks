(* encapsulate.sml the signature *)
(*
$Log: encapsulate.sml,v $
Revision 1.54  1998/10/23 14:56:46  jont
[Bug #70198]
Add interface to get code_offset

 * Revision 1.53  1998/10/22  10:45:12  jont
 * [Bug #70194]
 * Add interface for input_code taking filename to code_module
 *
 * Revision 1.52  1998/04/22  11:35:38  jont
 * [Bug #70099]
 * Changing encapsulation order to do type_env
 * before lambda_env and parser_env
 *
 * Revision 1.51  1998/02/05  12:07:16  jont
 * [Bug #30331]
 * Add input_debug_info to interface
 *
 * Revision 1.50  1997/11/25  10:19:14  jont
 * [Bug #30328]
 * Add environment parameter to decode_type_basis
 * for finding pervasive type names
 *
 * Revision 1.49  1997/10/20  16:39:14  jont
 * [Bug #30089]
 * Replacing MLWorks.Time with Time from the basis
 *
 * Revision 1.48  1996/03/01  14:25:04  daveb
 * Changed return type of input_info.
 *
 * Revision 1.47  1996/02/23  17:27:03  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.46  1995/04/20  13:09:26  jont
 * Change decode_type_basis to accept a btree
 *
Revision 1.45  1995/03/23  12:49:22  matthew
Combining stamp counts in one.

Revision 1.44  1995/03/01  14:05:43  matthew
Changes to Debugger_Types

Revision 1.43  1995/01/13  11:18:28  matthew
Change to debugger types

Revision 1.42  1994/09/27  16:43:38  nickb
Remove print_hash_table_stats

Revision 1.41  1994/09/13  10:09:10  matthew
Abstraction of debug information

Revision 1.40  1994/06/22  15:22:24  jont
Update debugger information production

Revision 1.39  1994/04/07  14:00:19  jont
Add original require file names to consistency info.

Revision 1.38  1994/02/22  10:26:37  nosa
Monomorphic debugger encapsulation.

Revision 1.37  1994/01/07  17:01:01  matthew
Changed type of submodule info for output_file and decode_type_basis to include range information.

Revision 1.36  1993/12/23  12:28:57  matthew
Added debugger_env sharing constraint.

Revision 1.35  1993/12/15  13:48:23  matthew
Renamed Encapsulate.Basistypes to Encapsulate.BasisTypes

Revision 1.34  1993/11/15  14:13:19  nickh
New pervasive time structure.

Revision 1.33  1993/08/03  14:31:31  jont
Modified the type of decode_type_basis to take the module name

Revision 1.32  1993/07/30  15:25:22  nosa
Debugger Environments for local and closure variable inspection
in the debugger

Revision 1.31  1993/05/28  10:51:21  jont
Cleaned up after assembly changes

Revision 1.30  1993/05/25  14:59:37  jont
Changes because Assemblies now has Basistypes instead of Datatypes

Revision 1.29  1993/03/11  11:11:47  matthew
Signature revisions

Revision 1.28  1993/03/04  14:32:59  matthew
Options & Info changes

Revision 1.27  1993/02/09  10:30:43  matthew
Typechecker structure changes

Revision 1.26  1993/02/01  16:50:15  matthew
Changed sharing.

Revision 1.25  1992/10/29  11:24:01  richard
Time is now represented by a pervasive structure.

Revision 1.24  1992/10/15  16:01:30  clive
Anel's changes for encapsulating assemblies

Revision 1.23  1992/09/10  10:35:04  clive
Changed hashtables to a single structure implementation

Revision 1.22  1992/09/10  10:35:04  richard
Created a type `information' which wraps up the debugger information
needed in so many parts of the compiler.

Revision 1.21  1992/08/26  16:41:47  jont
Removed some redundant structures and sharing

Revision 1.20  1992/08/25  08:09:06  clive
Added details about leafness to the debug information

Revision 1.19  1992/08/14  15:49:07  davidt
Made interface more abstract, providing a function which
reads the consistency informations without having to
read the whole object file.

Revision 1.18  1992/08/12  12:34:53  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.17  1992/08/06  18:40:40  davidt
Encapsulate.output_file now does everything, instead of
TopLevel calling a number of different Encapsulate
files.

Revision 1.16  1992/07/29  16:13:25  clive
Improved the datastructure for delayed outputting

Revision 1.15  1992/07/27  16:31:50  clive
Use of new hash tables, removed some concatenation and compression of integers in encapsulator

Revision 1.14  1992/07/21  12:24:28  jont
Modifications to allow less string concatenation and copying

Revision 1.13  1992/07/07  08:37:46  clive
Added call point information recording

Revision 1.12  1992/06/15  14:26:07  jont
Added decode_counts functions to speed up subrequires

Revision 1.11  1992/06/11  09:34:18  clive
Added the encapsulation of function debugging information

Revision 1.10  1992/01/23  16:12:07  clive
New pervasive library code - cut some things out of the initial type basis

Revision 1.9  1992/01/23  16:12:07  jont
Changed to encode tyfun_ids similarly to tyname_ids

Revision 1.8  1992/01/15  12:52:36  jont
Added clean_basis function to remove old encodings of pervasives

Revision 1.7  1992/01/09  10:59:04  jont
Added diagnostic parameter

Revision 1.6  1992/01/08  14:35:04  colin
Added code to maintain unique tyname and strname_ids across modules.
Changed type of type basis encoding/decoding functions.

Revision 1.5  1991/12/19  15:24:24  jont
Added encode_cons and decode_cons

Revision 1.4  91/12/17  18:08:18  jont
Added typechecker basis encapsulation functions

Revision 1.3  91/12/16  18:58:52  jont
Added parserenv parameter

Revision 1.2  91/12/11  11:44:12  jont
Added encoding and decoding of lambda environments

Revision 1.1  91/10/16  13:47:36  jont
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../parser/parserenv";
require "../typechecker/basistypes";
require "../lambda/environtypes";
require "../debugger/debugger_types";
require "../system/__time";

signature ENCAPSULATE =
sig
  structure ParserEnv : PARSERENV
  structure BasisTypes : BASISTYPES
  structure EnvironTypes : ENVIRONTYPES
  structure Debugger_Types : DEBUGGER_TYPES

  type Module

  sharing ParserEnv.Ident = BasisTypes.Datatypes.Ident

  sharing type EnvironTypes.LambdaTypes.Type = Debugger_Types.Type =
    BasisTypes.Datatypes.Type

  val do_timings : bool ref

  val clean_basis : BasisTypes.Basis -> unit

  val decode_type_basis :
    {type_env : string,
     file_name : string,
     sub_modules : (string, (string * int * int))ParserEnv.Map.map,
     decode_debug_information : bool,
     pervasive_env : BasisTypes.Datatypes.Env} ->
    BasisTypes.Basis * Debugger_Types.information

  val output_file : bool ->
    {filename : string,
     code : Module,
     stamps : int,
     parser_env : ParserEnv.pB,
     type_basis : BasisTypes.Basis,
     debug_info : Debugger_Types.information,
     require_list : (string * int * int) list,
     lambda_env : EnvironTypes.Top_Env,
     mod_name   : string,
     time_stamp : Time.time,
     consistency :
       {mod_name : string, time : Time.time} list}
    -> unit

  val input_code : string -> Module

  exception BadInput of string

  val input_info : string ->
    {stamps : int,
     mod_name : string,
     time_stamp: Time.time,
     consistency :
       {mod_name : string, time : Time.time} list}

  val input_all : string ->
    {parser_env : string,
     type_env : string,
     lambda_env : string,
     stamps : int,
     time_stamp : Time.time,
     mod_name : string,
     consistency :
       {mod_name : string, time : Time.time} list}

  val decode_all :
    {parser_env : string,
     lambda_env : string,
     type_env : string,
     file_name : string,
     sub_modules : (string, (string * int * int))ParserEnv.Map.map,
     decode_debug_information : bool,
     pervasive_env : BasisTypes.Datatypes.Env} ->
    ParserEnv.pB * EnvironTypes.Top_Env *
    BasisTypes.Basis * Debugger_Types.information

  val input_debug_info :
    {file_name : string,
     sub_modules : (string, (string * int * int))ParserEnv.Map.map} ->
    Debugger_Types.information

  val code_offset : string -> int

end
