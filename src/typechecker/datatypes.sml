(* datatypes.sml the signature *)
(*
$Log: datatypes.sml,v $
Revision 1.32  1999/02/02 16:01:51  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.31  1997/05/01  12:55:14  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.30  1996/10/04  15:36:34  andreww
 * [Bug #1592]
 * Threading extra level argument through tynames.
 *
 * Revision 1.29  1996/02/23  16:53:05  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.28  1996/02/21  17:15:32  jont
 * Removing map in favour of newmap
 *
 * Revision 1.27  1995/12/27  11:23:28  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.26  1995/03/24  16:13:23  matthew
Adding tyname map to COPYSTR's

Revision 1.25  1995/01/17  13:18:13  matthew
Rationalizing debugger

Revision 1.24  1994/06/17  10:44:09  jont
Allow alternative printing of types to include quantifiers

Revision 1.23  1994/05/12  11:07:20  daveb
Revised previous log message.

Revision 1.22  1994/05/05  13:08:21  daveb
META_OVERLOADED now includes the overloaded type variable and the location.
Overloaded schemes include the type variable.

Revision 1.21  1994/02/28  05:52:47  nosa
Debugger structures and extra TYNAME valenv for Modules Debugger.

Revision 1.20  1993/11/30  11:04:43  matthew
Added is_abs field to TYNAME and METATYNAME

Revision 1.19  1993/11/25  09:34:19  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.18  1993/09/22  12:46:50  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.17  1993/07/09  11:45:20  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger;
structure Option.

Revision 1.16  1993/07/07  16:41:59  daveb
Removed exception environments and interfaces.

Revision 1.15  1993/04/06  12:02:56  jont
Added push and pop functions for the id counters

Revision 1.14  1993/03/09  12:52:49  matthew
Str to Structure

Revision 1.13  1993/02/08  16:02:33  matthew
not much changed here

Revision 1.12  1993/02/05  15:07:33  matthew
New representation of structures
Removed TypeLocation type

Revision 1.11  1992/12/22  15:16:49  jont
Anel's last changes

Revision 1.10  1992/12/08  14:50:04  jont
Removed a number of duplicated signatures and structures

Revision 1.9  1992/10/09  14:12:06  clive
Tynames now have a slot recording their definition point

Revision 1.8  1992/10/02  15:53:49  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.7  1992/08/11  10:52:14  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/07/30  14:32:56  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/01/24  14:42:11  jont
Updated to allow valenv in METATYNAME

Revision 1.4  1992/01/14  16:22:05  jont
Changed ref unit in valenv to ref int to assist encoder

Revision 1.3  1991/11/21  16:51:08  jont
Added copyright message

Revision 1.2  91/06/17  17:27:00  nickh
Gives new ValEnv definition with ref unit to allow reading and
writing circular data structures.

Revision 1.1  91/06/07  11:43:01  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../utils/map";
require "../basics/ident";

signature DATATYPES =
  sig
    structure NewMap  : MAP
    structure Ident   : IDENT

    eqtype Stamp
    type 'a StampMap

    (****
     For detailed comments see the functor Datatypes.
     ****)

    datatype OverLoaded =
      UNARY of Ident.ValId * Ident.TyVar | 
      BINARY of Ident.ValId * Ident.TyVar |
      PREDICATE of Ident.ValId * Ident.TyVar

    datatype Strname = 
      STRNAME of Stamp | 
      METASTRNAME of Strname ref |
      NULLNAME of Stamp

    datatype InstanceInfo = 
      ZERO
    | ONE of int
    | TWO of int * int

    datatype Tyname = 
      TYNAME of (Stamp * string * int * bool ref 
                 * Valenv ref * string option * bool ref
                 * Valenv ref * int) |
      METATYNAME of (Tyfun ref * string * int * bool ref * Valenv ref
                     * bool ref)
      (* Valenv ref added for code generator's benefit *)
    
    and Type =
      METATYVAR of ((int * Type * Instance) ref * bool * bool) |
      META_OVERLOADED of
	(Type ref * Ident.TyVar * Ident.ValId * Ident.Location.T) |
      TYVAR of ((int * Type * Instance) ref * Ident.TyVar) |
      METARECTYPE of ((int * bool * Type * bool * bool) ref) |
      (* bool1 == this is an uninstantiated flex rectype,
       Type is a rectype giving flex contents if bool1 true 
       If bool1 is false, Type is a rectype giving rigid rectype 
       or a metarectype if instance of metarectype is another metarectype,
       bool2 == eq , bool3 == imp *)
      RECTYPE of (Ident.Lab,Type) NewMap.map |
      FUNTYPE of (Type * Type) |
      CONSTYPE of ((Type list) * Tyname) |
      DEBRUIJN of (int * bool * bool 
                   * (int * Type * Instance) ref option) |
      NULLTYPE
    
    and Tyfun =
      TYFUN of Type * int |
      ETA_TYFUN of Tyname |
      NULL_TYFUN of Stamp * Tyfun ref

          
    and Typescheme =
        SCHEME of (int * (Type * (Instance ref * Instance ref option ref) option))
      | UNBOUND_SCHEME of Type * (Instance ref * Instance ref option ref) option
      | OVERLOADED_SCHEME of OverLoaded

    and Instance = 
        INSTANCE of (int * Type * Instance) ref list
      | SIGNATURE_INSTANCE of InstanceInfo
      | NO_INSTANCE


    and Valenv = VE of int ref * ((Ident.ValId,Typescheme) NewMap.map)

    and Tystr = TYSTR of (Tyfun * Valenv)

    and Tyenv = TE of (Ident.TyCon,Tystr) NewMap.map

    and Env = ENV of (Strenv * Tyenv * Valenv)

    and Structure =
      STR of (Strname * MLWorks.Internal.Value.ml_value option ref * Env) |
      COPYSTR of ((Strname StampMap * Tyname StampMap) * Structure)

    and Strenv = SE of (Ident.StrId,Structure) NewMap.map

    datatype DebuggerStr = 
      DSTR of (Ident.StrId,DebuggerStr) NewMap.map * (Ident.TyCon,int) NewMap.map 
      * (Ident.ValId,int option) NewMap.map |
      EMPTY_DSTR

    val empty_valenv : Valenv

    (* atoms for a type error message, which is a list of these atoms.
     This is so tyvars in separate types printed in a message match up; see
     Types.print_type_with_seen_tyvars and Completion.report_type_error *)

    datatype type_error_atom =
        Err_String of string
      | Err_Type of Type	(* print a type with remembered tyvars *)
      | Err_Scheme of Type      (* Print a type with quantifiers *)
      | Err_Reset		(* reset remembered tyvars *)

end
