(* _actionfunctions.sml functor *)
(*
$Log: _actionfunctions.sml,v $
Revision 1.95  1999/02/02 16:01:35  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.94  1998/02/27  10:41:14  mitchell
 * [Bug #30352]
 * Prune parser value environment after abstype
 *
 * Revision 1.93  1998/02/19  16:35:19  mitchell
 * [Bug #30349]
 * Fix to avoid non-unit sequence warnings
 *
 * Revision 1.92  1998/02/17  13:05:18  mitchell
 * [Bug #30341]
 * Correct derived form of where in grammar
 *
 * Revision 1.91  1998/02/02  16:00:48  mitchell
 * [Bug #50015]
 * Add missing call to check_rec_bindings
 *
 * Revision 1.90  1997/09/18  16:03:25  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.89  1997/07/31  12:28:18  daveb
 * [Bug #30209]
 * Added type constructor environments for datatype specifications.
 *
 * Revision 1.88  1997/05/19  12:30:11  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.87  1997/05/07  14:53:47  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.86  1997/05/06  10:17:17  andreww
 * [Bug #30110]
 * Handling LookupStrId exception in datatype replication properly.
 *
 * Revision 1.85  1996/11/28  16:11:48  andreww
 * [Bug #1759]
 * Allowing constructor rebinding when in a val rec binding and
 * also in a funbind.
 *
 * Revision 1.84  1996/11/06  12:46:05  andreww
 * [Bug #1711]
 * forbidding real literals as patterns in SML'96 mode.
 *
 * Revision 1.83  1996/11/04  16:03:55  jont
 * [Bug #1725]
 * Remove unsafe string operations introduced when String structure removed
 *
 * Revision 1.82  1996/10/30  18:57:31  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.81  1996/10/29  12:58:12  andreww
 * [Bug #1708]
 * Altering the syntax of datatype replication: no tyvarseqs available.
 *
 * Revision 1.80  1996/10/25  13:53:39  andreww
 * [Bug #1686]
 * Removing use of "is constructor" tests --- these are done in typechecker
 * anyway, and they don't take into account replicated constructors.
 *
 * Revision 1.79  1996/10/04  17:52:44  andreww
 * [Bug #1592]
 * threading locations in Absyn.LOCALexp
 *
 * Revision 1.78  1996/10/04  11:00:11  matthew
 * [Bug #1622]
 * Adding some locations to datatype descriptors
 *
 * Revision 1.77  1996/09/20  14:49:47  andreww
 * [Bug #1577]
 * Adding function "check_same_tyvars" that implements the syntactic restriction
 * on datatype replication.
 *
 * Revision 1.76  1996/05/09  09:51:19  daveb
 * Improved error message for "op".
 *
 * Revision 1.75  1996/05/07  10:37:10  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.74  1996/04/30  15:14:37  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.73  1996/04/01  09:51:32  matthew
 * Adding type abbreviations
 *
 * Revision 1.72  1996/03/26  16:26:54  matthew
 * Updating for new language
 *
 * Revision 1.71  1996/03/19  14:51:54  matthew
 * New language definition
 *
 * Revision 1.70  1996/01/16  12:28:06  daveb
 * Added location information to Absyn.SIGNATUREtopdec.
 *
Revision 1.69  1995/12/27  10:51:43  jont
Removing Option in favour of MLWorks.Option

Revision 1.68  1995/11/22  09:14:02  daveb
Changed Absyn.REQUIREtopdec to take a string instead of a module_id.

Revision 1.67  1995/09/11  11:02:32  daveb
Added types for different lengths of words, ints and reals.

Revision 1.66  1995/09/08  11:04:40  matthew
Improving error message for fun nil x = x;

Revision 1.65  1995/08/31  13:32:27  jont
Add location info to wild pats

Revision 1.64  1995/07/28  14:28:22  matthew
Disallowing = as a strid etc.

Revision 1.63  1995/07/24  16:07:39  jont
Adding literal words

Revision 1.62  1995/07/19  11:59:18  jont
Adding CHAR to grammar

Revision 1.61  1995/05/12  14:38:35  matthew
Adding more checks for error ids

Revision 1.60  1995/04/12  13:39:45  matthew
Add information about unbound structure identifiers in LONGVALIDs

Revision 1.59  1995/04/10  15:27:04  matthew
Problems with infix function definitions

Revision 1.58  1995/03/08  17:26:41  matthew
Improving error messages

Revision 1.57  1995/02/14  12:39:49  matthew
Need to check an exbind is to an exception constructor

Revision 1.56  1995/02/06  14:27:35  matthew
Improving lookup errors

Revision 1.55  1995/01/17  12:58:39  matthew
Rationalizing debugger
/

Revision 1.54  1994/11/16  10:27:20  matthew
Fixed problem with IfStarStack being raise
(d)

Revision 1.53  1994/10/13  09:36:15  matthew
Efficiency improvements to lookup

Revision 1.52  1994/09/15  10:08:21  matthew
Added make_id_value and print_token
Abstraction of  debug information

Revision 1.51  1994/06/14  16:23:37  jont
Modified check_rec_bindings to check the pattern being bound
for constructors, in order to get better error messages

Revision 1.50  1994/05/09  16:12:08  jont
Modify effect of fixiy in open to be more sensible

Revision 1.49  1994/04/22  15:12:25  matthew
Fixed abstractions for the second time.

Revision 1.48  1994/03/18  12:55:45  matthew
Added check for exception constructor status in "excon = excon" clause

Revision 1.47  1994/02/22  01:36:10  nosa
Type function, debugger structure, and structure recording for Modules Debugger;
Deleted compiler option debug_polyvariables passing to parser functions.

Revision 1.46  1994/02/02  12:30:44  daveb
Changed from_unix_string to from_require_string.

Revision 1.45  1993/12/10  16:13:05  matthew
Parse abstractions as abstractions (again!).

Revision 1.44  1993/12/08  10:57:59  nickh
Pass Info.options to the withtype derived functions.

Revision 1.43  1993/12/03  16:50:34  nickh
Added location information to COERCEexp.

Revision 1.42  1993/11/25  09:35:31  matthew
Added fixity annotations to abstract syntax
;

Revision 1.41  1993/11/09  11:44:55  daveb
Incorporated bug fix.

Revision 1.40  1993/10/08  15:51:21  matthew
Bug fixing

Revision 1.39  1993/09/03  10:25:28  nosa
Instances for polymorphic debugger.

Revision 1.38.1.2  1993/10/06  15:20:06  matthew
Added check on multiple occurences of variables in infix function declarations

Revision 1.38.1.1  1993/08/27  15:19:03  jont
Fork for bug fixing

Revision 1.38  1993/08/27  15:19:03  matthew
Improved message for undefined constructors in patterns

Revision 1.37  1993/08/26  11:13:25  daveb
Wired up nj_op_in_datatype option.

Revision 1.36  1993/08/24  14:09:03  daveb
Use new ModuleId.create to check that moduleids are alphanumeric.

Revision 1.35  1993/08/12  16:10:00  daveb
Require declarations now take moduleids instead of strings.

Revision 1.34  1993/08/06  14:14:51  matthew
Added location information to matches

Revision 1.33  1993/07/09  12:08:56  nosa
structure Option.

Revision 1.32  1993/07/02  17:20:57  daveb
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.31  1993/07/02  13:35:42  matthew
Fixed problem with undefined structure names in signatures.

Revision 1.30  1993/06/15  13:34:05  matthew
Changed to allow no semicolons between topdecs

Revision 1.29  1993/06/10  13:25:18  matthew
Extended grammar for NJ compatibility

Revision 1.28  1993/05/24  15:41:47  matthew
Added code for abstractions.

Revision 1.27  1993/05/18  19:16:35  jont
Removed integer parameter

Revision 1.26  1993/05/17  15:45:29  jont
Modified to allow options to determine association of two different equal
precedence right associative operators

Revision 1.25  1993/05/14  18:24:34  jont
Added New Jersey interpretation of weak type variables under option control

Revision 1.24  1993/04/26  16:18:14  matthew
 Changed format of debug_info strings.

Revision 1.23  1993/04/06  11:54:39  matthew
Change to DYNAMICexp absyn

Revision 1.22  1993/03/29  11:11:21  daveb
Minor changes to reflect addition of Lexerstate to _token.
Minor improvements to error messages.

Revision 1.21  1993/03/09  11:23:17  matthew
Options & Info changes

Revision 1.20  1993/02/24  12:59:22  matthew
Changed warning on unbound signature to an error

Revision 1.19  1993/02/23  13:55:17  matthew
Changed interface to Derived to pass a pE for some functions

Revision 1.18  1993/02/18  10:59:29  matthew
Changes for dynamic and coerce expressions
 Changed to improve error detection

Revision 1.17  1993/02/08  19:30:14  matthew
ref Nameset removed from FunBind abstract syntax

Revision 1.16  1993/01/22  16:41:55  matthew
Changed sigexps
Fixed integer label bug
Changed asterisk tycon error to be an ordinary error.

Revision 1.15  1992/12/22  10:37:17  matthew
Put back marks in SCONs

Revision 1.14  1992/12/21  19:09:32  matthew
Changed location in scons to UNKNOWNs

Revision 1.13  1992/12/18  11:30:56  matthew
Changed int and real scons to carry a location around

Revision 1.12  1992/12/08  15:16:36  jont
Removed a number of duplicated signatures and structures

Revision 1.11  1992/12/02  17:17:27  matthew
Fixed more error messages

Revision 1.10  1992/12/01  14:21:11  matthew
Changed error messages

Revision 1.9  1992/11/26  19:36:08  daveb
 Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.8  1992/11/24  19:49:27  matthew
Fixed parsing bugs
with rec and abstype

Copyright (c) 1992 Harlequin Ltd.
*)

require "^.basis.__string";
require "../utils/lists";
require "../utils/set";
require "../basics/identprint";
require "../basics/token";
require "../parser/derived";
require "../utils/crash";
require "LRbasics";
require "actionfunctions";

functor ActionFunctions (
  structure LRbasics : LRBASICS
  structure Derived : DERIVED
  structure Lists : LISTS
  structure IdentPrint : IDENTPRINT
  structure Token : TOKEN
  structure Crash : CRASH
  structure Set : SET

  sharing Set = Derived.Absyn.Set
  sharing Derived.Absyn.Ident.Symbol = Token.Symbol
  sharing Derived.PE.Ident = IdentPrint.Ident
) : ACTIONFUNCTIONS =

struct

(* structures exported *)
structure Token = Token
structure Absyn = Derived.Absyn
structure LRbasics = LRbasics
structure PE = Derived.PE
structure Info = Derived.Info
structure Options = IdentPrint.Options

(* Internal structures *)
structure Map = PE.Map
structure Location = Info.Location
structure Absyn = Derived.Absyn
structure Ident = Absyn.Ident
structure Location = Ident.Location
structure Symbol = Ident.Symbol
(* types exported *)
type ParserBasis = PE.pB;

(* the parsed_object type *)
local
  type TyVarSet = Ident.TyVar Set.Set
  type TyVarList = Ident.TyVar list
  type PatExp = Absyn.Pat * Absyn.Exp * Location.T
  type PatExpMark = Absyn.Pat * Absyn.Exp * Location.T
  type TypeRef = Absyn.Type ref
  type ConBind = ((Ident.ValId * TypeRef) * Absyn.Ty option)
  type FVal = Ident.ValId * Absyn.Pat list * Absyn.Exp * Location.T
  type LabExp = Ident.Lab * Absyn.Exp
  type LabPat = Ident.Lab * Absyn.Pat
  type ConType = Ident.ValId * Absyn.Ty option * Location.T
  type ExType = Ident.ValId * Absyn.Ty option * Location.T
  type FunBind = (Ident.FunId * Ident.StrId * Absyn.SigExp * Absyn.StrExp * (Absyn.SigExp * bool) option * string * bool ref * Location.T * Absyn.DebuggerStr ref option * Absyn.Structure option ref option)
  type DatBind = TyVarList * Ident.TyCon * TypeRef  * Absyn.Tyfun ref option * ConBind list
in
datatype Parsed_Object =
  (* Store the environment *)
    ENV of PE.pE

  (* id tokens *)
  | LONGID of Symbol.Symbol list * Symbol.Symbol
  (* parsed identifiers *)
  | LONGVALID of Ident.LongValId * string option
  | SYM of Symbol.Symbol
  | FUNID of Ident.FunId
  | STRID of Ident.StrId
  | SIGID of Ident.SigId
  | LONGSTRID of Ident.LongStrId
  | LONGTYCON of Ident.LongTyCon
  | LAB of Ident.Lab
  | SCON of Ident.SCon
  | TYVAR of Ident.TyVar
  | VALID of Ident.ValId
  | TYCON of Ident.TyCon

  (* Basic constants *)
  | INTEGER of string
  | REAL of string
  | STRING of string
  | CHAR of string
  | WORD of string

  | BOOL of bool	

  (* Abstract syntax *)
  | EXP of Absyn.Exp * TyVarSet
  | DEC of Absyn.Dec * PE.pE * TyVarSet
  | CONBIND of ConBind list * PE.pVE * TyVarSet
  | CONBIND1 of ConBind * Ident.ValId * TyVarSet
  | DATAHDR of TyVarList * Ident.TyCon
  | DATREPL of TyVarList * Ident.TyCon * Ident.LongTyCon
  | DATBIND of DatBind list * PE.pVE * PE.pTE
  | DATBIND1 of DatBind * PE.pVE * PE.pTE
  | PAT of Absyn.Pat * PE.pVE * TyVarSet
  | BINPAT of Absyn.Pat * Ident.ValId * Absyn.Pat * PE.pVE * TyVarSet
  | TY of Absyn.Ty * TyVarSet

  (* Modules *)
  | STRDEC of Absyn.StrDec * PE.pE
  | STRDECLIST of Absyn.StrDec list * PE.pE
  | STREXP of Absyn.StrExp * PE.pE
  | SIGEXP of Absyn.SigExp * (PE.pE * Ident.TyCon list)
  | SPEC of Absyn.Spec * (PE.pE * Ident.TyCon list)
  | SHAREQ of (Absyn.SharEq * Location.T) list
  | SIGBIND of (Ident.SigId * Absyn.SigExp * Location.T) list * PE.pG
  | FUNBIND of FunBind list * PE.pF
  | TOPDEC of Absyn.TopDec * PE.pB
  | EXBIND of Absyn.ExBind list * PE.pVE * TyVarSet
  | EXBIND1 of Absyn.ExBind * Ident.ValId * TyVarSet

  (* Auxiliary module structures *)

  | VALDESC of (Ident.ValId * Absyn.Ty * TyVarSet) list * PE.pVE
  | TYPDESC of (TyVarList * Ident.TyCon * (Absyn.Ty * TyVarSet) option) list
  | DATDESC of (TyVarList * Ident.TyCon * (ConType list)) list * PE.pVE * PE.pTE
  | DATREPLDESC of (TyVarList * Ident.TyCon * Ident.LongTyCon)
  | DATDESC1 of (TyVarList * Ident.TyCon * (ConType list)) * PE.pVE * PE.pTE
  | CONDESC of ConType list * PE.pVE * TyVarSet
  | EXDESC of ExType list * PE.pVE
  | EXDESC1 of ExType
  | STRDESC of (Ident.StrId * Absyn.SigExp) list * PE.pSE
  | STRDESC1 of Ident.StrId * Absyn.SigExp * PE.pE
  | STRBIND  of ((Ident.StrId * (Absyn.SigExp * bool) option * Absyn.StrExp * bool ref * Location.T * Absyn.DebuggerStr ref option * Absyn.Structure option ref option) list * PE.pSE)
  | STRBIND1 of ((Ident.StrId * (Absyn.SigExp * bool) option * Absyn.StrExp * bool ref * Location.T * Absyn.DebuggerStr ref option * Absyn.Structure option ref option) * (Ident.StrId * PE.pE))
  | FUNDEC of Absyn.FunBind list * PE.pF
  | SIGDEC of Absyn.SigBind list * PE.pG
  | FUNBIND1 of FunBind * Ident.FunId * PE.pE
  | STARTFUNBIND1 of Ident.FunId * PE.pE * Ident.StrId * Absyn.SigExp * PE.pE
  | STARTFUNBIND2 of Ident.FunId * PE.pE * Absyn.Spec * PE.pE
  | FUNIDBIND of Ident.FunId * PE.pE

  (* Auxiliary structures *)
  | LONGIDLIST of (Symbol.Symbol list * Symbol.Symbol) list
  | DECLIST of Absyn.Dec list * PE.pE * TyVarSet
  | EXPLIST of Absyn.Exp list * TyVarSet
  | EXPSEQ of (Absyn.Exp * string * Location.T) list * TyVarSet
  | EXPROW of LabExp list * TyVarSet
  | LONGSTRIDLIST of Ident.LongStrId list
  | LONGTYCONLIST of Ident.LongTyCon list
  | SIGIDLIST of Ident.SigId list
  | TYLIST of Absyn.Ty list * TyVarSet
  | TYVARLIST of TyVarList
  | TYROW of (Ident.Lab * Absyn.Ty) list * TyVarSet
  | PATROW1 of LabPat * PE.pVE * TyVarSet
  | PATROW of (LabPat list) * bool * PE.pVE * TyVarSet
  | PATLIST of Absyn.Pat list * PE.pVE * TyVarSet
  | SYMLIST of Symbol.Symbol list
  | MRULE of PatExp * TyVarSet
  | MATCH of PatExp list * TyVarSet
  | VALBIND of PatExpMark list * PatExpMark list * TyVarSet * PE.pVE
  | TYPBIND of (TyVarList * Ident.TyCon * Absyn.Ty * Absyn.Tyfun ref option) list
  | LONGTYPBIND of (TyVarList * Ident.LongTyCon * Absyn.Ty * Location.T) list
  | FVAL of (FVal * TyVarSet) * Ident.ValId
  | FVALLIST of FVal list * TyVarSet * Ident.ValId * Location.T
  | FVALBIND of ((FVal list * (string -> string) * Location.T) list * TyVarSet) * PE.pVE
  | NULLTYPE   (* represents absent types *)
  | LABEXP of LabExp * TyVarSet
  | OPPRESENT
  | DUMMY
  | EQVAL
  | LOCATION of Location.T
  | OPTsigexp of Absyn.SigExp option
(*  | OPTOFTYPE of Absyn.Ty option *)
end


datatype ActionOpts = OPTS of (Location.T * Info.options * Options.options)

fun get_location (OPTS(l,_,_)) = l
fun options_of (OPTS(_,x,_)) = x
fun options_of' (OPTS(_,_,x)) = x
fun print_options_of (OPTS(_,_,Options.OPTIONS{print_options,...})) = print_options
fun compat_options_of (OPTS(_,_,Options.OPTIONS{compat_options,...})) = compat_options

fun op_optional (OPTS(_,_,Options.OPTIONS
			    {compat_options = Options.COMPATOPTIONS x, ...})) =
  #nj_op_in_datatype x


fun generate_moduler(OPTS(_,_,
                          Options.OPTIONS
                          {compiler_options=Options.COMPILEROPTIONS{generate_moduler, ...}, ...})) =
  generate_moduler

(* Change the outermost signature constraint to be abstract *)
fun do_abstraction  (strid,SOME (sigexp,abs),strexp,boolref,location,a,b) =
  (strid,SOME (sigexp,true),strexp,boolref,location,a,b)
  | do_abstraction  (strid,NONE,Absyn.CONSTRAINTstrexp (strexp,sigexp,_,bref,location'),boolref,location,a,b) =
    (strid,NONE,Absyn.CONSTRAINTstrexp (strexp,sigexp,true,bref,location),boolref,location,a,b)
  | do_abstraction a = a

(* location *)

val dummy_location = Location.UNKNOWN

fun get_sym (Ident.VAR s) = s
  | get_sym (Ident.CON s) = s
  | get_sym (Ident.EXCON s) = s
  | get_sym (_) = Crash.impossible "get_sym:actionfunctions"

(* source info construction *)
local
  fun locate(OPTS(location,_,_),string) =
    concat [string,"[",Location.to_string location,"]"]
  fun locate'(location,string) =
    concat [string,"[",Location.to_string location,"]"]
in
  fun make_hash_info (opts,Ident.LAB sym) = locate (opts,"#" ^ Symbol.symbol_name sym ^ " ")
  fun make_seq_info (opts) = locate (opts,"<seq>")
  fun make_and_info (opts) = locate (opts,"<andalso>")
  fun make_orelse_info (opts) = locate (opts,"<orelse>")
  fun make_handle_info (opts) = locate (opts,"<handle>")
  fun make_if_info (opts) = locate (opts,"<if>")
  fun make_case_info (opts) = locate (opts,"<case>")
  fun make_fn_info (opts) = locate (opts,"<anon>")
  fun make_exbind_info (opts,Ident.EXCON sym) = locate (opts,Symbol.symbol_name sym)
    | make_exbind_info _ = Crash.impossible "Not an excon in an exbind"
  fun make_funbind_info (opts,Ident.FUNID sym) = locate (opts,"Functor " ^ Symbol.symbol_name sym)
  fun make_while_info (opts) = fn x => locate(opts,x)
  fun make_fval_info loc = fn x => locate'(loc,x)
end

(* error reporting *)
fun do_info (OPTS(location,options,_),message_type,message) =
  Info.error options (message_type,location,message)

fun error (opts,message) =
  do_info(opts,Info.RECOVERABLE,message)

fun warn (opts,message) =
  do_info(opts,Info.WARNING,message)

fun function_pattern_error (opts,pattern) =
  let
    val message = 
      case pattern of
        Absyn.VALpat ((longid,_),_) => 
          "Constructor " ^ 
          IdentPrint.printLongValId (print_options_of opts) longid ^ 
          " occurs as function name"
      | _ => "Pattern occurs as function name"
  in
    error (opts,message)
  end

fun make_id_name ([],s) =
  Symbol.symbol_name s
  | make_id_name (str :: l,s) =
    Symbol.symbol_name str ^ "." ^ make_id_name(l,s)

fun print_token (LRbasics.LONGID,LONGID x) = make_id_name x
  | print_token (LRbasics.INTEGER,INTEGER i) = i
  | print_token (LRbasics.STRING,STRING s) = "\"" ^ MLWorks.String.ml_string (s,10) ^ "\""
  | print_token (LRbasics.CHAR,CHAR s) = "#\"" ^ MLWorks.String.ml_string (s,10) ^ "\""
  | print_token (LRbasics.REAL,REAL s) = s
  | print_token (LRbasics.WORD, WORD s) = s
  | print_token (x,_) = LRbasics.token_string x

fun report_long_error (opts,longid,ty) =
  error(opts,"Unexpected long " ^ ty ^ ": " ^ (make_id_name longid))

(* debuggery *)

val do_debug = ref false

fun do_output message = (print message; print"\n")

fun debug message =
  if !do_debug then do_output message else ()

(* stuff for setting up infixes *)
fun char_digit s = (ord (String.sub(s, 0))) - ord #"0"

fun parse_precedence (opts,s) =
  case size s of
    1 => char_digit s
  | _ => (error(opts,"Only Single digit allowed for precedence, using 0");
          0)

(* symbol manipulation *)
val asterisk_symbol = Symbol.find_symbol "*"

val equal_symbol = Symbol.find_symbol "="

fun mkTyCon (opts,sym) = 
  (if sym = asterisk_symbol then
     error(opts,"Asterisk not allowed as type constructor")
   else
     ();
   Ident.TYCON sym)

val mkPath = Ident.mkPath
(* Should be done by an optimiser, but New Jersey doesn't have one *)

fun mkLongVar (syms,sym) = 
  Ident.LONGVALID (mkPath syms, Ident.VAR sym)

val equal_lvalid = mkLongVar ([],equal_symbol)

fun mkLongCon (syms,sym) = 
  Ident.LONGVALID (mkPath syms, Ident.CON sym)

fun mkLongExCon (syms,sym) = 
  Ident.LONGVALID (mkPath syms, Ident.EXCON sym)

fun mkLongTyCon (opts,syms,sym) = 
  (if sym = asterisk_symbol then
     error(opts,"Asterisk not allowed as type constructor")
   else
     ();
   Ident.LONGTYCON (mkPath syms, Ident.TYCON sym))

fun mkLongStrId (syms,sym) = 
  Ident.LONGSTRID (mkPath syms, Ident.STRID sym)

exception LongError

(* convert from short to long *)
fun make_long_id x = Ident.LONGVALID (Ident.NOPATH, x)

fun is_constructor (Ident.CON _) = true
  | is_constructor (Ident.EXCON _) = true
  | is_constructor _ = false

fun is_long_constructor (Ident.LONGVALID(_,id)) =
  is_constructor id

val error_symbol = Symbol.find_symbol "<Error>"
fun make_id_value s = LONGID ([],Symbol.find_symbol s)
val error_id_value = LONGID ([],error_symbol)
val error_id = Ident.VAR error_symbol

fun is_error_longid (Ident.LONGVALID (Ident.NOPATH,valid)) =
  get_sym valid = error_symbol
  | is_error_longid _ = false

fun get_old_definition opts =
  let
    val Options.COMPATOPTIONS {old_definition,...} = compat_options_of opts  
  in
    old_definition
  end

fun check_is_old_definition (opts,message) =
  if get_old_definition opts then ()
  else
    error (opts,message)

fun check_is_new_definition (opts,message) =
  if get_old_definition opts then error (opts,message)
  else ()


fun check_is_constructor (opts,id,strname_opt) =
  let val print_options = print_options_of opts
  in
    if is_long_constructor id then
      ()
    else
      case strname_opt of
        SOME strname =>
          error (opts,"Unbound structure " ^ strname ^ " in " ^ (IdentPrint.printLongValId print_options id))
      | _ => 
          error (opts,"Constructor " ^ (IdentPrint.printLongValId print_options id) ^ " not defined")
  end

(* Typechecker doesn't check for constructor status *)
(*
fun make_constructor (id as Ident.LONGVALID(path,valid)) =
  case valid of
    Ident.CON _ => id
  | Ident.EXCON _ => id
  | _ => Ident.LONGVALID (path,Ident.CON (get_sym valid))
*)

fun check_is_short_constructor (opts,id) =
  if get_sym id = error_symbol then ()
  else
    let val print_options = print_options_of opts
    in
      if is_constructor id then
        ()
      else
        error (opts,"Non-constructor " ^ 
               (IdentPrint.printValId print_options id) ^ " used in pattern")
    end

fun check_not_short_constructor (opts,id) =
  if get_sym id = error_symbol then ()
  else
    let val print_options = print_options_of opts
    in
      if is_constructor id then
        error (opts,"Cannot bind constructor " ^ 
               (IdentPrint.printValId print_options id))
      else
        ()
    end


fun check_integer_bounds (opts, int:string) = 
(* must be > 0 *)
  if size int = 0 then
    error (opts, "Malformed integer label")
  else
    let val c = String.sub(int, 0)
    in
      if c = #"0" then
	error (opts, "Leading zero in numeric label not allowed")
      else if c = #"~" then
	error (opts, "Integer label must be positive")
      else
	()
    end (* check_integer_bounds *)
      
(* environment manipulation *)

(* functions on environments *)

(* used when storing structure declarations *)
fun zap_pFE (OPTS(_,_,options),x as PE.E(_,pVE,pTE,pSE)) =
  let
    val Options.OPTIONS {compat_options = Options.COMPATOPTIONS{open_fixity, ...},
                         ...} = options
  in
    if open_fixity
      then x
    else
      PE.E(PE.empty_pFE,pVE,pTE,pSE)
  end

fun zap_pFE(_, x ) = x
(* Always keep the fixity environment. Throw away at open if necessary. *)

(* When adding environments in a signature, want to disregard identifier status *)
(* and fixity *)
 
fun zap_for_sig (PE.E(_,_,pTE,pSE)) =
  PE.E(PE.empty_pFE,PE.empty_pVE,pTE,pSE)

fun pe_error _ = Crash.impossible"identifier clash in empty env"

(* create initial environments *)
fun make_pSE (opts,id,pE) = PE.addStrId (pe_error,id,zap_pFE (opts,pE),PE.empty_pSE)

fun make_pVE id = PE.addValId (pe_error,id, PE.empty_pVE)
fun make_pTE (id,pVE) = PE.addTyCon (pe_error,id, pVE, PE.empty_pTE)
fun make_pFE ids_fixity = PE.make_pFE ids_fixity
fun make_pF (id,pE) = PE.addFunId (pe_error,id,pE,PE.empty_pF)
fun make_pG (id,pE,tycons) = PE.addSigId (pe_error,id,pE,tycons,PE.empty_pG)

(* injection functions *)
fun pVE_in_pE pVE = PE.E (PE.empty_pFE,pVE,PE.empty_pTE,PE.empty_pSE)
fun pVEpTE_in_pE (pVE,pTE) = PE.E (PE.empty_pFE,pVE,pTE,PE.empty_pSE)
fun pTE_in_pE pTE = PE.E (PE.empty_pFE,PE.empty_pVE,pTE,PE.empty_pSE)
fun pSE_in_pE pSE = PE.E(PE.empty_pFE,PE.empty_pVE,PE.empty_pTE,pSE)
fun pFE_in_pE pFE = PE.E(pFE,PE.empty_pVE,PE.empty_pTE,PE.empty_pSE)

fun pE_in_pB pE = PE.B(PE.empty_pF,PE.empty_pG,pE)
fun pF_in_pB pF = PE.B(pF,PE.empty_pG,PE.empty_pE)
fun pG_in_pB pG = PE.B(PE.empty_pF,pG,PE.empty_pE)

(* some functions for manipulating the global environment *)

(* store the global pE in here *)
val ref_pE = ref PE.empty_pE;
fun get_current_pE () = !ref_pE
fun set_pE pE = ref_pE := pE
(* extend global pE *)

fun extend_pE (pE) = ref_pE := PE.augment_pE (!ref_pE,pE)
fun extend_pVE (pVE) = extend_pE (pVE_in_pE pVE)
fun extend_pTE (pTE) = extend_pE (pTE_in_pE pTE)
fun extend_pSE (pSE) = extend_pE (pSE_in_pE pSE)

fun lookupValId x = PE.tryLookupValId (x,!ref_pE)
fun lookupLongTycon x  = 
  (case PE.lookupTycon (x,!ref_pE)
    of NONE => (case PE.lookupTycon (x,PE.builtins_pE)
                  of NONE => PE.empty_pVE  (* attempting to replicate
                                              non-existing datatype *)
                   | SOME x => x)
     | SOME x => x)
     handle PE.LookupStrId _ => PE.empty_pVE (*error caught in typechecker*)
               
                          

fun lookupStrId (opts,strid) =
  PE.lookupStrId (strid,!ref_pE)
  handle PE.LookupStrId sym =>
    (error (opts,
            concat (case strid of 
                       ([],_) => ["Unbound structure ",
                                  IdentPrint.printLongStrId (mkLongStrId strid)]
                     | _ => ["Unbound structure ", Symbol.symbol_name sym, 
                             " in " ^ IdentPrint.printLongStrId (mkLongStrId strid)]));
     PE.empty_pE)

(* no error here if the var is currently undefined, since it may be a pattern variable *)
fun getValId (id as ([],sym)) = 
  (case lookupValId id of
     SOME x => x
   | NONE => Ident.VAR sym)
  | getValId id = Crash.impossible "Longid in getvalid"

(* Finding status of identifiers in the global environment *)
(* The optional string returned is the name of an undefined structure, if any *)
(* In fact, I think it is always an error if we can't find the identifier *)
(* Perhaps we should just signal an error here and be done with it *)
fun resolveLongValId (opts,id) =
  let val print_options = print_options_of opts
  in
    (case PE.lookupValId (id,!ref_pE) of
       SOME (Ident.VAR _) => (mkLongVar id,NONE)
     | SOME (Ident.CON _) => (mkLongCon id,NONE)
     | SOME (Ident.EXCON _) => (mkLongExCon id,NONE)
     | SOME _ => Crash.impossible "TYCON':resolveLongValId:actionfunctions"
     | NONE => (mkLongVar id,NONE))
    handle PE.LookupStrId sym => (mkLongVar id,SOME (Symbol.symbol_name sym))
  end


fun resolveValId sym =
  case lookupValId ([],sym) of
    SOME x => x
  | NONE => Ident.VAR sym


fun is_infix s =
  case PE.lookupFixity (s, !ref_pE) of
    PE.NONFIX => false
  | _ => true

fun check_excon (id as Ident.LONGVALID (_,valid),strname_opt,opts) =
  if is_error_longid id then ()
  else
    case valid of 
      Ident.EXCON _ => ()
    | _ => 
        (case strname_opt of
           SOME strname => 
             error (opts, "Unbound Structure " ^ strname ^ " in " ^
                    IdentPrint.printLongValId (print_options_of opts) id)
         | _ => 
             error (opts,"Identifier " ^ 
                    IdentPrint.printLongValId (print_options_of opts) id ^
                    " not an exception constructor"))

fun check_is_infix (opts,id) =
  let
    val sym = get_sym id
  in
    if sym = error_symbol
      then ()
    else
      if is_infix sym then ()
      else
        let val print_options = print_options_of opts
        in
          error (opts,"Symbol " ^ 
                 (IdentPrint.printValId print_options id) ^ 
                 " not infix")
        end
  end

fun check_is_infix_constructor (opts,longid) =
  if is_error_longid longid
    then ()
  else
    let
      val print_options = print_options_of opts
      val infixp =
        (case longid of
           Ident.LONGVALID(Ident.NOPATH,id) => is_infix (get_sym id)
         | _ => false)
      val consp = is_long_constructor longid
    in
      if consp then
        if infixp
          then ()
        else
          error (opts,"Constructor " ^ 
                 (IdentPrint.printLongValId print_options longid) ^ 
                 " not infix")
      else
        if infixp
          then error (opts,"Infix constructor " ^ 
                      (IdentPrint.printLongValId print_options longid) ^
                      " not defined")
        else
          error (opts,"Constructor " ^ 
                 (IdentPrint.printLongValId print_options longid) ^ 
                 " not defined and not infix")
    end

fun check_not_constructor_symbol (opts,s) =
  (case lookupValId ([],s) of
     SOME valid =>
       if is_constructor valid
         then error (opts,"Trying to bind constructor " ^
                     Symbol.symbol_name s ^ " in record")
       else ()
   | NONE => ())

(* global parser basis *)

val ref_pB = ref PE.empty_pB
fun set_pB (pB) = ref_pB := pB

fun setParserBasis (pB as (PE.B(pF,pG,pE))) = (set_pB pB;ref_pE := pE)
fun getParserBasis () =
  let val (PE.B(pF,pG,_)) = !ref_pB
  in
    PE.B(pF,pG,!ref_pE)
  end

fun lookupFunId (opts,x) =
  PE.lookupFunId (x,!ref_pB)
  handle PE.Lookup =>
    (error (opts,"functor " ^ IdentPrint.printFunId x ^ " not defined");
     PE.empty_pE)

fun lookupSigId (opts,x) =
  PE.lookupSigId (x,!ref_pB)
  handle PE.Lookup =>
    (error (opts,"signature " ^ IdentPrint.printSigId x ^ " not defined");
     (PE.empty_pE,[]))


local
  fun get_pB () = !ref_pB
in
  fun extend_pF (pF) = set_pB(PE.augment_pB(get_pB(),
                                            PE.B(pF,PE.empty_pG,PE.empty_pE)))
  fun extend_pG (pG) = set_pB(PE.augment_pB(get_pB(),PE.B(PE.empty_pF,pG,
                                                          PE.empty_pE)))
end

fun augment_tycons ([],tycons2,opts) = tycons2
  | augment_tycons (tycon::rest,tycons2,opts) =
    (if Lists.member (tycon, tycons2)
       then error (opts,"Duplicate type specifications in signature: " ^
                   IdentPrint.printTyCon tycon)
     else ();
     augment_tycons (rest,tycon::tycons2,opts))
         
fun spec_augment_pE ((pe1,tycons1),(pe2,tycons2),opts) = 
  if get_old_definition opts
    then
      (PE.augment_pE (pe1,pe2),tycons1 @ tycons2)
  else
    (PE.unique_augment_pE 
     ((fn id => error (opts,"Duplicate value specifications in signature: " ^
                       IdentPrint.printValId (print_options_of opts) id),
       fn id => error (opts,
                       "Duplicate structure specifications in signature: " ^
                       IdentPrint.printStrId id)),
     pe1,pe2),
     augment_tycons (tycons1,tycons2,opts))

fun combine_specs (Absyn.SEQUENCEspec speclist1,Absyn.SEQUENCEspec speclist2) =
  Absyn.SEQUENCEspec (speclist1 @ speclist2)
  | combine_specs (Absyn.SEQUENCEspec speclist1,spec2) =
  Absyn.SEQUENCEspec (speclist1 @ [spec2])
  | combine_specs (spec1,Absyn.SEQUENCEspec speclist2) =
  Absyn.SEQUENCEspec (spec1 :: speclist2)
  | combine_specs (spec1,spec2) =
  Absyn.SEQUENCEspec [spec1,spec2]

fun names_of_typedesc t = map (fn (a,b,c) => b) t
fun names_of_datdesc t = map (fn (a,b,c) => b) t

fun make_long tycon = Ident.LONGTYCON (Ident.NOPATH,tycon)

fun do_type_spec (eq,speclist,opts) =
  Absyn.SEQUENCEspec
  (map
   (fn (tyvars,name,optty) =>
    case optty of
      NONE => if eq then Absyn.EQTYPEspec [(tyvars,name)]
                     else Absyn.TYPEspec [(tyvars,name)]
    | SOME (ty,tyvarset) => 
        let
          val location = get_location opts
        in
          Absyn.INCLUDEspec 
          (Absyn.WHEREsigexp(Absyn.NEWsigexp
                            (if eq then Absyn.EQTYPEspec [(tyvars,name)] 
                             else Absyn.TYPEspec [(tyvars,name)],
                               ref NONE),
                               [(tyvars,make_long name,ty,get_location opts)]),
                            get_location opts)
        end)
   speclist)

(* Semantic action for fixity declarations *)

fun extend_pE_for_fixity symbols_fixity =
  let val new_pE = pFE_in_pE (make_pFE symbols_fixity)
  in
    (extend_pE new_pE; DEC (Absyn.SEQUENCEdec [],new_pE,Set.empty_set))
  end

fun make_fixity_pE (symbols_fixity) =
  pFE_in_pE (make_pFE symbols_fixity)

(* the names of things *)
fun label_name (Ident.LAB sym) = Symbol.symbol_name sym
fun tyvar_name (Ident.TYVAR(sym,_,_)) = Symbol.symbol_name sym

(* absyn utilities *)

(* this should be in utils somewhere I think *)
fun member eq_test (a,l) =
  let
    fun member_aux [] = false
      | member_aux (b::l) =
        eq_test(a,b) orelse member_aux l
  in
    member_aux l
  end

fun get_intersection (l1,l2,eq_test,key) =
  let
    val member' = member eq_test
    fun aux ([],result) = rev result
      | aux (a::l,result) =
        if member'(a,l2)
          then aux(l,(key a)::result)
        else aux(l,result)
  in
    aux(l1,[])
  end

fun check_list_inclusion (sublist,list,eq_test) =
  let
    val member' = member eq_test
    fun check_all ([],_) = true
      | check_all (x::l,l') = member'(x,l') andalso check_all(l,l')
  in
    check_all(sublist,list)
  end

(* error checking here *)
(* numerous functions for checking on disjointness of declarations etc. *)

fun check_disjoint_labels (opts,lab,[]) = ()
  | check_disjoint_labels (opts,lab,(lab',_):: l) =
    if Ident.lab_eq(lab,lab')
      then error(opts,"Duplicate labels in record: " ^ (label_name lab))
    else check_disjoint_labels(opts,lab,l)

fun check_disjoint_tyvars (opts,tyvar,[]) = ()
  | check_disjoint_tyvars (opts,tyvar,(tyvar'::tyvars)) =
    if Ident.tyvar_eq(tyvar,tyvar')
      then error(opts,"Duplicate type variables in sequence: " ^ (tyvar_name tyvar))
    else check_disjoint_tyvars (opts,tyvar,tyvars)
  
fun check_tyvar_inclusion (opts,tyvars,tyvarlist) =
  (* ensure that all elements in tyvars are in tyvarlist *)
  (* need set operations that take an equality test parameter *)
  (* or this should be part of the specification of a set *)
  (* or I could be naughty and use polymorphic equality *)
  if check_list_inclusion (Set.set_to_list tyvars,tyvarlist,Ident.tyvar_eq)
    then ()
  else error(opts,"Free type variable in type declaration")

fun check_empty_tyvars (opts,tyvars) =
  (* checks that the list of tyvars is empty.  The revised syntax of
     datatype replication removes the need to specify type variables. *)
  if tyvars=[] then ()
  else error (opts,"Unexpected type variables in datatype replication.")



local
  fun check_disjoint_tycons (key,message)(opts,item,list) =
    if member(fn (x,y) => Ident.tycon_eq(key x,key y))(item,list)
      then
        let val Ident.TYCON sym = key item
        in
          error (opts,"Multiple declaration of type constructor " ^
                 Symbol.symbol_name sym ^ " in " ^ message)
        end
    else ()
in
  val check_disjoint_datbind = check_disjoint_tycons
                               (fn (_,x,_,_,_) => x, "datatype binding")
  val check_disjoint_typbind = check_disjoint_tycons
                               (fn (_,x,_,_) => x, "type binding")
  val check_disjoint_datdesc = check_disjoint_tycons
                               (fn (_,x,_) => x, "datatype specification")
  val check_disjoint_typdesc = check_disjoint_tycons
                               (fn (_,x,_) => x, "type specification")
end

(* need to ensure that all bindings in a rec are of form <pat,fn match> *)

fun is_con_pat(Absyn.WILDpat _) = false
  | is_con_pat(Absyn.SCONpat _) = false
  | is_con_pat(Absyn.VALpat({1=long_valid, ...}, _)) =
    is_long_constructor long_valid
  | is_con_pat(Absyn.RECORDpat _) = false
  | is_con_pat(Absyn.APPpat _) = false
  | is_con_pat(Absyn.TYPEDpat{1=pat, ...}) = is_con_pat pat
  | is_con_pat(Absyn.LAYEREDpat({1=valid, ...}, pat)) =
    is_constructor valid orelse is_con_pat pat


fun is_fn (Absyn.FNexp _) = true
  | is_fn (Absyn.TYPEDexp (exp,_,_)) = is_fn exp
  | is_fn _ = false

fun check_rec_bindings (opts,[]) = ()
  | check_rec_bindings(opts,(pat,exp,location)::l) =
    (if is_fn exp then
       if not (get_old_definition opts) orelse not (is_con_pat pat) then
	 ()
       else
	 error(opts, "Attempt to rebind constructor as variable")
     else
       error(opts,"Non-function expression in value binding");
(**)
      check_rec_bindings(opts,l))
(**)

fun check_disjoint_withtype (opts,datbindlist,typbindlist) =
  let
    fun get_datbind_tycon (_,tycon,_,_,_) = tycon
    fun get_typbind_tycon (_,tycon,_,_) = tycon
    fun compare (datbind,typbind) = Ident.tycon_eq (get_datbind_tycon datbind,get_typbind_tycon typbind)
    fun make_string [] = ""
      | make_string [Ident.TYCON sym] = Symbol.symbol_name sym
      | make_string ((Ident.TYCON sym) :: l) = (Symbol.symbol_name sym) ^ ", " ^ make_string l
    val intersection = get_intersection (datbindlist,typbindlist,compare,get_datbind_tycon)
  in
    case intersection of
      [] => ()
    | tycons => (error (opts,"Duplicate bindings in withtype: " ^ make_string tycons))
  end

(* these functions augment the environment as expected, but also generate a warning *)
(* if variable already present *)

fun identity x = x;

fun print_list([],_) = ""
  | print_list([x],f) = f x
  | print_list(x::l,f) = f x ^ ", " ^ print_list(l,f)

fun ordered_intersection(l1,l2,eq,order,key) =
  let
    fun aux([],_,result) = rev result
      | aux(_,[],result) = rev result
      | aux(all as (a::l),all' as (a'::l'),result) =
        let
          val b = key a and b' = key a'
        in
          if eq(b,b')
            then aux(l,l',b::result)
          else
            if order(b,b')
              then aux(l,all',result)
            else aux(all,l',result)
        end
  in
    aux (l1,l2,[])
  end

fun merge_pVEs (opts as OPTS(location,options,_),pVE1 as (PE.VE ve1),
                pVE2 as (PE.VE ve2)) =
  let 
    val print_options = print_options_of opts
    fun error_fun (_,valid1,valid2) =
    (error (opts,"Multiple declaration of value " ^
		 IdentPrint.printValId print_options valid1);
     valid1)
  in
    PE.VE (Map.merge error_fun (ve1,ve2))
  end


fun merge_pTEs (opts as OPTS(location,options,_),pTE1 as (PE.TE te1),
                pTE2 as (PE.TE te2)) =
  let
    val print_options = print_options_of opts
    fun error_fun (_,tycon1,tycon2) = tycon1
                 (* multiple declarations of typeconstructors dealt
                    with already when merging pVEs. *)
  in
      PE.TE (Map.merge error_fun (te1,te2))
  end

	(* varify is used in the case when we rebind constructors in
	   function definitions in sml'96 mode. *)

fun varify (v as Ident.VAR x) = v
  | varify (Ident.CON x) = Ident.VAR x
  | varify (Ident.EXCON x) = Ident.VAR x
  | varify (Ident.TYCON' x ) = Ident.VAR x


	(* The following is used in val rec bindings in sml'96 mode.
	   In those situations, constructors which appear in variable
	   positions may be rebound.  *)

local

  	(* the following version of varify and varifyLong are used by 
	   varify_valbind.  The latter only varifies longvars if they
	   have no path, as these are the only kind
	   of constructors that can be rebound in val recs and fundefs.
	   In case the constructor is rebound, we have to add it to
	   the parser Value Environment, (because they aren't in
	   ATPATS).  This will also check that the same constructor
	   isn't rebound twice. We do this using side-effects to
	   save tupling and untupling results. *)

  fun newvar (x,opts,pVE) =
	let val vid = Ident.VAR x
	 in pVE:=merge_pVEs(opts,!pVE,make_pVE vid);
	    vid
	end


  fun varify (v as Ident.VAR x,_,_) = v
    | varify (Ident.CON x,opts,pVE) = newvar (x,opts,pVE)
    | varify (Ident.EXCON x,opts,pVE) = newvar(x,opts,pVE)
    | varify (Ident.TYCON' x,opts,pVE) = newvar(x,opts,pVE)


  fun varifyLong(Ident.LONGVALID(Ident.NOPATH,id),opts,pVE) = 
	    Ident.LONGVALID(Ident.NOPATH,varify (id,opts,pVE))
    | varifyLong (x,_,_) = x


  fun map f [] = []
    | map f (h::t) = (f h)::(map f t)


  fun varify_pat (w as Absyn.WILDpat _,_,_) = w
    | varify_pat (s as Absyn.SCONpat _,_,_) = s
    | varify_pat (Absyn.VALpat((vid,s),l),opts,pVE) = 
	 Absyn.VALpat((varifyLong (vid,opts,pVE),s),l)
    | varify_pat (Absyn.RECORDpat(l,b,r),opts,pVE) = 
  	let fun varify_label_binding (lab,pat) = 
	                     (lab,varify_pat(pat,opts,pVE))
         in Absyn.RECORDpat(map varify_label_binding l,b,r)
	end
    | varify_pat (Absyn.APPpat(c,p,l,b),opts,pVE) =
	 Absyn.APPpat(c,varify_pat (p,opts,pVE),l,b)
    | varify_pat (Absyn.TYPEDpat(pat,ty,loc),opts,pVE) = 
	Absyn.TYPEDpat(varify_pat (pat,opts,pVE),ty,loc)
    | varify_pat (Absyn.LAYEREDpat((vid,tuple),pat),opts,pVE) =
	Absyn.LAYEREDpat((varify (vid,opts,pVE),tuple),
	                  varify_pat (pat,opts,pVE))

in

  fun varify_valbind(VALBIND(v1,v2,tyvars,pVE),opts) =
  	let val global_pVE = ref pVE
	    fun varify_patexp (pat,exp,loc) = 
	         (varify_pat (pat,opts,global_pVE),exp,loc)
         in VALBIND(map varify_patexp v1,
		    map varify_patexp v2, tyvars, !global_pVE)
	end
    | varify_valbind _ = Crash.impossible "_actionfunctions:varify_valbind"
end





local
  fun valid_error opts (_,_,valid) =
    let 
      val print_options = print_options_of opts
    in
      (error(opts,"Multiple declaration of value " ^
             IdentPrint.printValId print_options valid);
       valid)
    end
  fun tycon_error opts (_,_,x) = x   (* duplicate tycons ignored *)

  fun strid_error opts (strid,_,pE) =
    (error(opts,"Multiple declaration of structure " ^
		IdentPrint.printStrId strid);
     pE)
  fun funid_error opts (funid,_,pE) =
    (error(opts,"Multiple declaration of functor " ^
		IdentPrint.printFunId funid);
     pE)
  fun sigid_error opts (sigid,_,pE) =
    (error(opts,"Multiple declaration of signature " ^
		IdentPrint.printSigId sigid);
     pE)
in
  (* need to remove pFE from the pE for this one *)
  fun addNewStrId (opts,(strid,pE),pSE) =
    PE.addStrId (strid_error opts,strid,zap_pFE (opts,pE),pSE)
  fun addNewSigId (opts,(id,pE,tycons),pGE) = 
                  PE.addSigId (sigid_error opts,id,pE,tycons,pGE)
  fun addNewFunId (opts,(id,pE),pFE) = PE.addFunId (funid_error opts,id,pE,pFE)
  fun addNewValId (opts,id,pE) = PE.addValId (valid_error opts,id,pE)
  fun addNewTycon (opts,id,pVE,pTE) = PE.addTyCon (tycon_error opts,id,
                                                   pVE,pTE)
end

fun addNewSymId (opts,sym,pVE) = addNewValId(opts,Ident.VAR sym,pVE)

fun make_Sym_pVE (sym) = make_pVE(Ident.VAR sym)

(* these functions test for longvalids *)
local
  fun is_needed (Ident.NOPATH,s) = is_infix s
    | is_needed _ = false
in
  fun check_longid_op (opts,id as Ident.LONGVALID (p,v)) =
    if is_error_longid id
      then ()
    else
      if is_needed (p, get_sym v) then
        ()
      else
        warn (opts,"Reserved word `op' ignored before `" ^ Symbol.symbol_name(get_sym v) ^ "'")

  fun check_non_longid_op (opts,id as Ident.LONGVALID (p,v)) =
    if is_error_longid id
      then ()
    else
      if is_needed (p, get_sym v) then
        error (opts,"Reserved word `op' required before infix identifier `" ^ Symbol.symbol_name(get_sym v) ^ "'")
      else
        ()
end

fun check_valid_op (opts,v) =
  if get_sym v = error_symbol then ()
  else
    if is_infix (get_sym v) then
      ()
    else
      warn (opts,"Reserved word `op' ignored before `" ^
            Symbol.symbol_name(get_sym v) ^ "'")
    
fun check_non_valid_op (opts,v) =
  if get_sym v = error_symbol then ()
  else
    if is_infix (get_sym v) then
      error (opts,"Reserved word `op' required before infix identifier `" ^
             Symbol.symbol_name(get_sym v) ^ "'") else
      ()

fun check_conid_op (opts,v) =
  if get_sym v = error_symbol then ()
  else
    if not(is_infix (get_sym v)) orelse op_optional opts then
      warn (opts,"Reserved word `op' ignored before `" ^ 
            Symbol.symbol_name(get_sym v) ^ "'")
    else
      ()
    
fun check_non_conid_op (opts,v) =
  if get_sym v = error_symbol then ()
  else
    if is_infix (get_sym v) andalso not (op_optional opts) then
      error (opts,"Reserved word `op' required before infix identifier `" ^ 
             Symbol.symbol_name(get_sym v) ^ "'")
    else
      ()

(* General Utilities *)

fun annotate x = (x,ref Absyn.nullType)
fun annotate' x = (x,(ref Absyn.nullType,ref (Absyn.nullRuntimeInfo)))
fun mannotate (OPTS(l,_,_),x) = 
  (x,ref Absyn.nullType,l,
   ref(Absyn.nullInstanceInfo,NONE))

(* handling opens and includes *)

fun fold_pEs pEs =
  let fun fold ([],pE) = pE
        | fold (pE'::l,pE) = fold(l,PE.augment_pE(pE,pE'))
  in
    fold (pEs,PE.empty_pE)
  end

fun fold_sig_pEs (pEs,opts) =
  let fun fold ([],e) = e
        | fold (e::l,e') = 
          fold(l,spec_augment_pE (e,e',opts))
  in
    fold (pEs,(PE.empty_pE,[]))
  end

fun do_open_dec_action (opts as OPTS(_, _, options),longids) =
  let
    val Options.OPTIONS {compat_options = 
                         Options.COMPATOPTIONS{open_fixity, ...},
                         ...} = options
    val pEs = map (fn x => lookupStrId(opts,x)) longids
    val valids = map mkLongStrId longids
    val new_pE as PE.E(fixity, pVE, pTE, pSE) = fold_pEs pEs
    val new_pE = if open_fixity then new_pE else
                               PE.E(PE.empty_pFE, pVE, pTE, pSE)
  in
    (extend_pE new_pE;
     DEC (Absyn.OPENdec (valids,get_location opts),new_pE,Set.empty_set))
  end

fun do_open_spec_action (opts,longids) =
  let
    val pEs = map (fn x => zap_for_sig (lookupStrId(opts,x))) longids
    val valids = map mkLongStrId longids
    val new_pE = fold_pEs pEs
  in
    (extend_pE new_pE;
     SPEC(Absyn.OPENspec (valids,get_location opts),(new_pE,[])))
  end

fun do_include_action (opts,sigids) =
  let 
    val pEs = map (fn x => lookupSigId(opts,x)) sigids
    val (new_pE,new_tycons) = fold_sig_pEs (pEs,opts)
    val location = get_location opts
  in
    (extend_pE new_pE;
     SPEC (Absyn.SEQUENCEspec
           (map (fn sigid => 
                 Absyn.INCLUDEspec 
                  (Absyn.OLDsigexp 
                   (sigid,ref NONE,location),
                   location)) 
            sigids),
           (new_pE,new_tycons)))
  end

(* infix function declarations *)

fun join_tyvars [] = Set.empty_set
  | join_tyvars [t] = t
  | join_tyvars (t::l) = Set.union (t,join_tyvars l)

fun make_infix_fval (opts,id,pat1,pat2,patlist,exp,tvarlist) =
  (check_not_short_constructor(opts,id);
   check_is_infix (opts,id);
   ((id,(Derived.make_tuple_pat [pat1,pat2]) :: patlist,
     exp,get_location opts),join_tyvars tvarlist))

(* Functor bindings with specifications *)

fun do_derived_funbind (opts,funid,spec,opt_sig,strexp,pE) =
  (* pE is environment to be associated with the functor funid *)
  let
    val generate_moduler = generate_moduler opts
    val (a,b,c,d,f) =
    Derived.make_funbind (funid,
                         Absyn.NEWsigexp(spec,ref NONE),
                          strexp,
                          opt_sig,
                          get_location opts)
  in
    FUNBIND1 ((a,b,c,d,f,make_funbind_info(opts,funid),ref false,
               get_location opts,
               if generate_moduler
                 then SOME (ref(Absyn.nullDebuggerStr))
               else NONE,
               if generate_moduler
                 then SOME(ref(NONE))
               else NONE),funid,pE)
  end

fun do_fixity_spec (ids,precedence,opts as OPTS(_,_,options)) =
  let
    val Options.OPTIONS {compat_options = 
                         Options.COMPATOPTIONS{fixity_specs, ...},
                         ...} = options
  in
    if fixity_specs
      then
        SPEC(Absyn.STRUCTUREspec [],
             (make_fixity_pE (ids,precedence),
              []))
    else
      (error (opts,"Fixity declarations in signatures not valid in this mode");
       SPEC(Absyn.STRUCTUREspec [],(PE.empty_pE,[])))
  end

exception FoundTopDec of (Absyn.TopDec * PE.pB)
exception ActionError of int

(* the actions *)

val actions =
MLWorks.Internal.Array.arrayoflist[
(* Do not delete this line 1 *)










(* (defpackage "ML")  *)

(* ;; A grammar for ML for use in the LispWorks parser generator.  *)

(* (in-package 'ml)  *)

(* ;; General points --  *)
(* ;; each action assumes that the function call current_mark() returns  *)
(* ;; the mark object for the first token of the parsed sequence.  This  *)
(* ;; simplifies the data that needs to be carried around.  *)
(*     *)
(* (setq *mlg*  *)
(*   '(((START PROGRAM))  *)

                   fn ([dec],opts) => dec
 | _ => raise ActionError 0,

(* 	((ATEXP SCON))  *)

                   fn ([SCON scon],opts) => EXP (Absyn.SCONexp (annotate scon),Set.empty_set)
 | _ => raise ActionError 1,

(* 	((ATEXP OPLONGVAR))  *)

                   fn ([LONGVALID (id,_)],opts) => EXP (Absyn.VALexp (mannotate(opts,id)), Set.empty_set)
 | _ => raise ActionError 2,

(* ;; Don't want to just make :equal an identifier, otherwise too much  *)
(* ;; checking needed in patterns etc.  *)

(* 	((ATEXP :equal))  *)

                   fn ([_],opts) =>
  (check_non_longid_op (opts,equal_lvalid); 
   EXP (Absyn.VALexp (mannotate (opts,equal_lvalid)), Set.empty_set))
 | _ => raise ActionError 3,

(* 	((ATEXP :op :equal))  *)

                   fn ([_,_],opts) => 
  (check_longid_op (opts,equal_lvalid);
   EXP (Absyn.VALexp (mannotate (opts,equal_lvalid)), Set.empty_set))
 | _ => raise ActionError 4,

(* 	((ATEXP :lbrace EXPROW :rbrace))  *)

                   fn ([_,EXPROW (l,tyvars),_],opts) => EXP (Absyn.RECORDexp (rev l),tyvars)
 | _ => raise ActionError 5,

(* 	((ATEXP :lbrace :rbrace))  *)

                   fn ([_,_],opts) => EXP (Absyn.RECORDexp [],Set.empty_set)
 | _ => raise ActionError 6,

(* 	((ATEXP :hash LAB))  *)

                 fn ([_,LAB lab],opts) =>
  EXP (Derived.make_select (lab,get_location opts,make_hash_info(opts,lab)),Set.empty_set)
 | _ => raise ActionError 7,

(* 	((ATEXP :magicopen EXP :rpar)) *)
                   fn ([_,EXP (e,tyvars),_],opts) => EXP(Absyn.DYNAMICexp (e, tyvars, ref (Absyn.nullType,0,tyvars)),tyvars)
 | _ => raise ActionError 8,

(* 	((ATEXP :magicopen :type EXP :colon TY :rpar)) *)
                   fn ([_,_,EXP(e,tyvars),_,TY(ty,tyvars'),_],opts) => EXP (Absyn.COERCEexp(e,ty,ref Absyn.nullType, get_location opts),Set.union(tyvars,tyvars'))
 | _ => raise ActionError 9,

(* 	((ATEXP :LPAR :RPAR))  *)

                   fn ([_,_],opts) => EXP (Derived.make_unit_exp (),Set.empty_set)
 | _ => raise ActionError 10,

(* 	((ATEXP :LPAR EXPLIST2 :RPAR))  *)

                   fn ([_,EXPLIST (l,tyvars),_],opts) => EXP (Derived.make_tuple_exp (rev l),tyvars)
 | _ => raise ActionError 11,

(* 	((ATEXP :bra EXPLIST :ket)) ;; Expand into :: form  *)

                 fn ([_,EXPLIST (l,tyvars),_],opts) => EXP (Derived.make_list_exp (rev l,get_location opts,get_current_pE()),tyvars)
 | _ => raise ActionError 12,

(* 	((ATEXP :LPAR EXPSEQ2 :RPAR))  *)

                   fn ([_,EXPSEQ (l,tyvars),_],opts) => EXP (Derived.make_sequence_exp (rev l),tyvars)
 | _ => raise ActionError 13,

(* 	((ATEXP START_LET DEC :in EXPSEQ :end))  *)

                   fn ([ENV pE,DEC (dec,_,tyvars1),_,EXPSEQ (l,tyvars2),_],opts) =>
  (set_pE pE; EXP (Absyn.LOCALexp (dec,Derived.make_sequence_exp (rev l),
                         get_location opts),Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 14,

(* 	((ATEXP :LPAR EXP :RPAR))  *)

                   fn ([_,x,_],opts) => x
 | _ => raise ActionError 15,

(* 	((START_LET :let))  *)

                   fn ([_],opts) => ENV (get_current_pE())
 | _ => raise ActionError 16,

(* 	((EXPLIST2 EXPLIST2 :comma EXP))  *)

                   fn ([EXPLIST (l,tyvars1),_,EXP (exp,tyvars2)],opts) => EXPLIST (exp::l,Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 17,

(* 	((EXPLIST2 EXP :comma EXP))  *)

                   fn ([EXP (exp1,tyvars1),_,EXP (exp2,tyvars2)],opts) => EXPLIST ([exp2,exp1],Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 18,

(* 	((EXPLIST))  *)

                   fn ([],opts) => EXPLIST ([],Set.empty_set)
 | _ => raise ActionError 19,

(* 	((EXPLIST EXP))  *)

                   fn ([EXP (exp,tyvars)],opts) => EXPLIST ([exp],tyvars)
 | _ => raise ActionError 20,

(* 	((EXPLIST EXPLIST2))  *)

                   fn ([exp],opts) => exp
 | _ => raise ActionError 21,

(* 	((EXPSEQ EXPSEQ :semicolon EXP))  *)

                   fn ([EXPSEQ(l,tyvars1),_,EXP (exp,tyvars2)],opts) => 
  EXPSEQ ((exp,make_seq_info(opts),get_location opts)::l,Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 22,

(* 	((EXPSEQ EXP))  *)

                   fn ([EXP(exp,tyvars)],opts) => EXPSEQ ([(exp,make_seq_info(opts),get_location opts)],tyvars)
 | _ => raise ActionError 23,

(* 	((EXPSEQ2 EXPSEQ :semicolon EXP))  *)

                   fn ([EXPSEQ(l,tyvars1),_,EXP(exp,tyvars2)],opts) => 
  EXPSEQ ((exp,make_seq_info(opts),get_location opts)::l,Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 24,

(* 	((EXPROW LAB :EQUAL EXP))  *)

                   fn ([LAB lab,_,EXP (exp,tyvars)],opts) => EXPROW ([(lab,exp)],tyvars)
 | _ => raise ActionError 25,

(* 	((EXPROW EXPROW :comma LAB :EQUAL EXP))  *)

                   fn ([EXPROW(l,tyvars1),_,LAB lab,_,EXP (exp,tyvars2)],opts) =>
  (check_disjoint_labels(opts,lab,l);EXPROW ((lab,exp)::l,Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 26,

(* 	((APPEXP ATEXP))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 27,

(* 	((APPEXP APPEXP ATEXP))  *)

                   fn ([EXP (exp1,tyvars1), EXP (exp2,tyvars2)],opts) =>
  EXP(Absyn.APPexp(exp1,exp2,get_location opts,ref Absyn.nullType,false),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 28,

(* 	((INFEXP APPEXP))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 29,

(* 	((INFEXP INFEXP INFVAR INFEXP))  *)

                   fn ([EXP (exp1,tyvars1), LONGVALID (id,_), EXP (exp2,tyvars2)],opts) =>
  EXP (Absyn.APPexp (Absyn.VALexp (mannotate(opts,id)),Derived.make_tuple_exp [exp1,exp2],get_location opts,ref Absyn.nullType,true),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 30,

(* 	((INFVAR VAR))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 31,

(* 	((INFVAR :equal))  *)

                   fn ([_],opts) => LONGVALID (equal_lvalid,NONE)
 | _ => raise ActionError 32,

(* 	((EXP INFEXP))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 33,

(* 	((EXP EXP :colon TY))  *)

                   fn ([EXP (exp,tyvars1),_,TY (ty,tyvars2)],opts) =>
  EXP (Absyn.TYPEDexp (exp,ty,get_location opts),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 34,

(* 	((EXP EXP :andalso EXP))  *)

                 fn ([EXP (exp1,tyvars1),_,EXP (exp2,tyvars2)],opts) =>
  EXP (Derived.make_andalso (exp1,exp2,make_and_info(opts),get_location opts,get_current_pE()),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 35,

(* 	((EXP EXP :orelse EXP))  *)

                 fn ([EXP(exp1,tyvars1),_,EXP (exp2,tyvars2)],opts) =>
  EXP (Derived.make_orelse (exp1,exp2,make_orelse_info(opts),get_location opts,get_current_pE()),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 36,

(* 	((EXP EXP :handle MATCH))  *)

                   fn ([EXP(exp1,tyvars1),_,MATCH(match,tyvars2)],opts) =>
  EXP (Absyn.HANDLEexp (exp1, ref Absyn.nullType, (rev match),get_location opts,make_handle_info(opts)),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 37,

(* 	((EXP :RAISE EXP))  *)

                   fn ([_,EXP (exp,tyvars)],opts) => EXP (Absyn.RAISEexp (exp,get_location opts),tyvars)
 | _ => raise ActionError 38,


(* 	((EXP :if EXP :then EXP :else EXP))  *)

                   fn ([_,EXP (exp1,tyvars1),_,EXP (exp2,tyvars2),_,EXP (exp3,tyvars3)],opts) =>
  EXP(Derived.make_if (exp1,exp2,exp3,make_if_info(opts),get_location opts,get_current_pE()),join_tyvars[tyvars1,tyvars2,tyvars3])
 | _ => raise ActionError 39,

(* 	((EXP :while EXP :do EXP))  *)

                 fn ([_,EXP (exp1,tyvars1),_,EXP (exp2,tyvars2)],opts) =>
  EXP (Derived.make_while (exp1,exp2,make_while_info(opts),get_location opts,get_current_pE()),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 40,

(* 	((EXP :case EXP :of MATCH))  *)

                   fn ([_,EXP(exp,tyvars1),_,MATCH(m,tyvars2)],opts) =>
  EXP (Derived.make_case (exp,(rev m),make_case_info(opts),get_location opts),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 41,

(* 	((EXP :fn MATCH))  *)

                   fn ([_,MATCH (match,tyvars)],opts) =>
  let val (a,b) = annotate (rev match) in EXP (Absyn.FNexp (a,b,make_fn_info(opts),get_location opts),tyvars) end
 | _ => raise ActionError 42,

(* 	((MATCH MATCH :vbar MRULE))  *)

                   fn ([MATCH (match,tyvars1),_,MRULE (rule,tyvars2)],opts) => MATCH (rule::match,Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 43,

(* 	((MATCH MRULE))  *)

                   fn ([MRULE(rule,tyvars)],opts) => MATCH([rule],tyvars)
 | _ => raise ActionError 44,

(* 	((MRULE PAT :darrow EXP));; PAT determines variables present in EXP.  *)
(* 	;; Use to augment environment.  *)

                  fn ([PAT(pat,pE,tyvars1),_,EXP(exp,tyvars2)],opts) => MRULE((pat,exp,get_location opts),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 45,


(* 	((DECSEP DECSEP :semicolon))  *)

                   fn ([_,_],opts) => DUMMY
 | _ => raise ActionError 46,

(* 	((DEC DECSEP))  *)

                   fn ([_],opts) => DEC (Absyn.SEQUENCEdec[],PE.empty_pE,Set.empty_set)
 | _ => raise ActionError 47,

(* 	((DEC DECSEP DEC1 DECSEP))  *)

                   fn ([_,dec,_],opts) => dec
 | _ => raise ActionError 48,

(* 	((DEC DECSEP DEC0 DECSEP))  *)

                   fn ([_,DECLIST(l,pE,tyvars),_],opts) => DEC(Absyn.SEQUENCEdec(rev l),pE,tyvars)
 | _ => raise ActionError 49,

(* 	((DEC0 DEC1 DECSEP DEC1))  *)

                   fn ([DEC(dec1,pE1,tyvars1),_,DEC(dec2,pE2,tyvars2)],opts) => DECLIST([dec2,dec1],PE.augment_pE(pE1,pE2),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 50,

(* 	((DEC0 DEC0 DECSEP DEC1))  *)

                   fn ([DECLIST(l,pE1,tyvars1),_,DEC(dec,pE2,tyvars2)],opts) => DECLIST(dec::l,PE.augment_pE(pE1,pE2),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 51,

(* ;; End of new bit for decs  *)

(* ;; These two don't extend the global environment, as we only need constructors in there  *)

(* 	((DEC1 :val TYVARSEQ1 VALBIND))		; Extend value bindings ;; reverse both lists!!  *)

                   fn ([_, TYVARLIST explicit_tyvars, VALBIND (valbinds1,valbinds2,tyvars,pVE)],opts) =>
  DEC (Absyn.VALdec (rev valbinds1,rev valbinds2,tyvars,explicit_tyvars),pVE_in_pE pVE,Set.empty_set)
 | _ => raise ActionError 52,

(* 	((DEC1 :val VALBIND))		; Extend value bindings ;; reverse both lists!!  *)

                   fn ([_, VALBIND (valbinds1,valbinds2,tyvars,pVE)],opts) =>
  DEC (Absyn.VALdec (rev valbinds1,rev valbinds2,tyvars,[]),pVE_in_pE pVE,Set.empty_set)
 | _ => raise ActionError 53,

(* 	((DEC1 :fun TYVARSEQ1 FVALBIND))		; Extend function/value bindings ?  *)

                 fn ([_,TYVARLIST explicit_tyvars,FVALBIND ((l,tyvars),pVE)],opts) =>
DEC (Derived.make_fun ((map (fn y => Derived.make_fvalbind (y,options_of opts)) (rev l)),
                       tyvars,explicit_tyvars,get_location opts),pVE_in_pE pVE,Set.empty_set)
 | _ => raise ActionError 54,

(* 	((DEC1 :fun FVALBIND))		; Extend function/value bindings ?  *)

                 fn ([_,FVALBIND ((l,tyvars),pVE)],opts) =>
DEC (Derived.make_fun ((map (fn y => Derived.make_fvalbind (y,options_of opts)) (rev l)),
                       tyvars,[],get_location opts),pVE_in_pE pVE,Set.empty_set)
 | _ => raise ActionError 55,

(* 	((DEC1 :type TYPBIND))		; Type binding  *)

                   fn ([_,TYPBIND l],opts) => DEC (Absyn.TYPEdec (rev l),PE.empty_pE,Set.empty_set)
 | _ => raise ActionError 56,


(* 	((DEC1 :datatype DATREPL)) *)

                  fn ([_,DATREPL(tyvars,tycon,longtycon)],opts)=>
  (check_is_new_definition(opts,
            "Datatype replication is not a feature of SML'90");
   check_empty_tyvars(opts,tyvars);
   let val pVE = lookupLongTycon longtycon
       val pTE = (make_pTE (tycon,pVE))
    in 
      extend_pVE pVE;
      extend_pTE pTE;
      DEC (Absyn.DATATYPErepl (get_location opts,(tycon,longtycon),
                               ref NONE),
        pVEpTE_in_pE(pVE,pTE),Set.empty_set)
   end)
 | _ => raise ActionError 57,



(* ;; Need to extend global env with constructor definitions in next 5 rules  *)

(* 	((DEC1 :datatype DATBIND))	; Extend type constructors.  *)

                   fn ([_,DATBIND (d,pVE,pTE)],opts) => 
  (extend_pVE pVE; 
   extend_pTE pTE;
   DEC (Absyn.DATATYPEdec (get_location opts,rev d),pVEpTE_in_pE (pVE,pTE),
        Set.empty_set))
 | _ => raise ActionError 58,


(* 	((DEC1 :datatype DATBIND :withtype TYPBIND))  *)

                   fn ([_,DATBIND (d,pVE,pTE),_,TYPBIND t],opts) =>
  (check_disjoint_withtype(opts,d,t);
   extend_pVE pVE; extend_pTE pTE;
   DEC (Derived.make_datatype_withtype (get_location opts,rev d, t, 
					options_of opts),
	pVEpTE_in_pE(pVE,pTE),Set.empty_set))
 | _ => raise ActionError 59,

(* 	((DEC1 :abstype ABSDATBIND :with DEC :end))  *)

                   fn ([_,DATBIND (d,pVE,pTE),_,DEC(dec,pE,tyvars),_],opts) =>
  DEC (Absyn.ABSTYPEdec (get_location opts,rev d,dec),
       PE.augment_pE (pTE_in_pE(pTE),pE),tyvars) 
 | _ => raise ActionError 60,



(* 	((DEC1 :abstype ABSDATBIND :withtype TYPBIND :with DEC :end))  *)

          fn ([_,DATBIND (d,pVE,pTE),_,TYPBIND t,_,DEC(dec,pE,tyvars),_],
          opts) =>
        (check_disjoint_withtype(opts,d,t);
         DEC (Derived.make_abstype_withtype
                 (get_location opts,rev d,t,dec,options_of opts),
              PE.augment_pE (pTE_in_pE(pTE),pE),tyvars))
 | _ => raise ActionError 61,



(* 	((ABSDATBIND DATBIND)) *)

          fn ([d as (DATBIND(_,pVE,pTE))],opts) =>
         (extend_pVE pVE; extend_pTE pTE; d)
 | _ => raise ActionError 62,



(* 	((DEC1 :exception EXBIND))  *)

          fn ([_,EXBIND (l,pVE,tyvars)],opts) => 
        (extend_pVE pVE; DEC (Absyn.EXCEPTIONdec (rev l),pVE_in_pE pVE,
         tyvars))
 | _ => raise ActionError 63,



(* 	((DEC1 START_LOCAL DEC :in DEC :end))  *)

          fn ([ENV env_pE,DEC (dec1,_,tyvars1),_,
           DEC (dec2,pE,tyvars2),_],opts) =>
        (set_pE (PE.augment_pE (env_pE,pE));
         DEC (Absyn.LOCALdec (dec1,dec2),pE,Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 64,



(* ;; Extends global environment with new definitions  *)


(* 	((DEC1 :open LONGIDLIST))  *)

          fn ([_,LONGIDLIST l],opts) => 
         do_open_dec_action (opts,rev l)
 | _ => raise ActionError 65,



(* ;; Infix declarations extend global environment  *)
(* ;; These lists are reversed, but I don't think that matters here  *)


(* 	((DEC1 :infix SYMLIST));; Extend fixity environment.  *)

          fn ([_,SYMLIST l],opts) =>
          extend_pE_for_fixity (l, PE.LEFT 0)
 | _ => raise ActionError 66,



(* 	((DEC1 :infix :integer SYMLIST))  *)

          fn ([_,INTEGER i,SYMLIST l],opts) =>
         extend_pE_for_fixity (l, PE.LEFT (parse_precedence(opts,i)))
 | _ => raise ActionError 67,



(* 	((DEC1 :infixr SYMLIST))  *)

          fn ([_,SYMLIST l],opts) => extend_pE_for_fixity (l, PE.RIGHT 0)
 | _ => raise ActionError 68,



(* 	((DEC1 :infixr :integer SYMLIST))  *)

          fn ([_,INTEGER i,SYMLIST l],opts) =>
         extend_pE_for_fixity (l, PE.RIGHT (parse_precedence(opts,i)))
 | _ => raise ActionError 69,



(* 	((DEC1 :nonfix SYMLIST))  *)

          fn ([_,SYMLIST l],opts) =>
          extend_pE_for_fixity (l, PE.NONFIX)
 | _ => raise ActionError 70,



(* ;; Used to store the current environment when entering a scope  *)


(* 	((START_LOCAL :local))  *)

          fn ([_],opts) => ENV (get_current_pE())
 | _ => raise ActionError 71,



(* 	((VALBIND VALBIND1))  *)

          fn ([x],opts) => x
 | _ => raise ActionError 72,



(* 	((VALBIND VALBIND :and VALBIND1))  *)

          fn ([VALBIND(v1,v2,tyvars1,pVE1),_,VALBIND([a],[],tyvars2,pVE2)],
          opts) =>
      VALBIND (a::v1,v2,Set.union(tyvars1,tyvars2),
               merge_pVEs(opts,pVE1,pVE2))
 | _ => raise ActionError 73,



(* 	((VALBIND VALBIND :and :rec VALBIND))  *)

          fn ([VALBIND (v1,v1',tyvars1,pVE1),_,_,
           VALBIND(v2,v2',tyvars2,pVE2)],opts) =>
        (check_rec_bindings (opts,v2);
         VALBIND (v1,v1' @ v2 @ v2',Set.union(tyvars1,tyvars2),
                  merge_pVEs(opts,pVE1,pVE2)))
 | _ => raise ActionError 74,



(* 	((VALBIND :rec VALBIND))  *)

        fn ([_,VALBIND (v1,v2,tyvars,pVE)],opts) =>
        (check_rec_bindings (opts,v1); 
         let val vbind = VALBIND ([],v2@v1,tyvars,pVE)
          in if get_old_definition opts then vbind
             else varify_valbind (vbind,opts)  (* change all constructors
                                           that occur in var positions
                                           into vars (so can be rebound)*)
         end)
 | _ => raise ActionError 75,



(* 	((VALBIND1 PAT :EQUAL EXP))  *)

          fn ([PAT (pat,pVE,tyvars1),_,EXP (exp,tyvars2)],opts) =>
        VALBIND ([(pat,exp,get_location opts)],[],
                 Set.union (tyvars1,tyvars2),pVE)
 | _ => raise ActionError 76,



(* ;; Function definitions should return a pVE with the names of the *)
(* ;; functions declared in it.  *)


(* 	((FVALBIND FVALLIST))  *)

          fn ([FVALLIST (fvals,tyvars,id,loc)],opts) =>
        FVALBIND (([((rev fvals),make_fval_info loc,get_location opts)],
                   tyvars),make_pVE id)
 | _ => raise ActionError 77,



(* 	((FVALBIND FVALBIND :and FVALLIST))  *)

          fn ([FVALBIND ((l,tyvars1),pVE),_,
           FVALLIST (fvals,tyvars2,id,loc)],opts) =>
        FVALBIND (((rev fvals,make_fval_info loc,get_location opts)::l,
                   Set.union(tyvars1,tyvars2)),addNewValId(opts,id,pVE))
 | _ => raise ActionError 78,



(* 	((FVALLIST FVAL))  *)

          fn ([FVAL ((fval,tyvars),id)],opts) => 
          FVALLIST ([fval],tyvars,id,get_location opts)
 | _ => raise ActionError 79,



(* ;; checking that the function names are the same is done in Derived  *)


(* 	((FVALLIST FVALLIST :vbar FVAL))  *)

          fn ([FVALLIST (fvals,tyvars1,id,_),_,
           FVAL ((fval,tyvars2),id')],opts) =>
        FVALLIST (fval::fvals,Set.union(tyvars1,tyvars2),id,
                  get_location opts)
 | _ => raise ActionError 80,



(* 	((FVAL OPVARDEF ATPATLIST OPTTYPE :EQUAL EXP))  *)

          fn ([VALID id,PATLIST(l,pE,tyvars1),TY(ty,tyvars2),
           _,EXP (exp,tyvars3)],opts) =>
         let val vid = varify id 
          in FVAL(((vid,rev l,Absyn.TYPEDexp(exp,ty,get_location opts),
                    get_location opts),
                   join_tyvars[tyvars1,tyvars2,tyvars3]),vid)
         end
       | ([VALID id,PATLIST (l,pE,tyvars1),NULLTYPE,_,
           EXP (exp,tyvars3)],opts) =>
         let val vid = varify id
          in FVAL(((vid,rev l,exp,get_location opts),
                   Set.union(tyvars1,tyvars3)),vid)
         end
 | _ => raise ActionError 81,



(* 	((FVAL ATPAT1 VARDEF ATPAT OPTTYPE :EQUAL EXP))  *)

          fn ([PAT(pat1,pVE1,tyvars1),VALID id,PAT(pat2,pVE2,tyvars2),
           TY (ty,tyvars3),_,EXP (exp,tyvars4)],opts) =>
        let val vid = varify id
         in (ignore(merge_pVEs(opts,pVE1,pVE2));
             FVAL(make_infix_fval (opts,vid,pat1,pat2,[],
                  Absyn.TYPEDexp(exp,ty,get_location opts),
                  [tyvars1,tyvars2,tyvars3,tyvars4]),vid))
        end
       | ([PAT (pat1,pVE1,tyvars1),VALID id,PAT(pat2,pVE2,tyvars2),
           NULLTYPE,_,EXP (exp,tyvars3)],opts) =>
        let val vid = varify id
         in
          (ignore(merge_pVEs(opts,pVE1,pVE2));
           FVAL(make_infix_fval(opts,vid,pat1,pat2,[],exp,
                [tyvars1,tyvars2,tyvars3]),vid))
        end
 | _ => raise ActionError 82,


(* 	((FVAL ATPAT1 VARDEF ATPAT ATPATLIST OPTTYPE :EQUAL EXP))  *)

          fn ([PAT (pat1,pVE1,tyvars1),VALID id,PAT (pat2,pVE2,tyvars2),
           _,TY (ty,tyvars3),_,EXP (exp,tyvars4)],opts) =>
        (error (opts,"Too many patterns for infix identifier "
                     ^ IdentPrint.printValId (print_options_of opts) id);
         ignore(merge_pVEs(opts,pVE1,pVE2));
         FVAL(make_infix_fval (opts,id,pat1,pat2,[],
              Absyn.TYPEDexp(exp,ty,get_location opts),
              [tyvars1,tyvars2,tyvars3,tyvars4]),id))
       | ([PAT (pat1,pVE1,tyvars1),VALID id,PAT(pat2,pVE2,tyvars2),
           _,NULLTYPE,_,EXP (exp,tyvars3)],opts) =>
         (error (opts,"Too many patterns for infix identifier "
                      ^ IdentPrint.printValId (print_options_of opts) id);
          ignore(merge_pVEs(opts,pVE1,pVE2));
          FVAL(make_infix_fval (opts,id,pat1,pat2,[],exp,
               [tyvars1,tyvars2,tyvars3]),id))
 | _ => raise ActionError 83,



(* 	((FVAL ATPAT1 ATPATLIST OPTTYPE :EQUAL EXP))  *)

          fn ([PAT (pat1,pVE1,tyvars1),PATLIST(l,pE,tyvars2),
           TY (ty,tyvars3),_,EXP (exp,tyvars4)],opts) =>
        (function_pattern_error (opts,pat1);
         FVAL(((error_id,rev l,Absyn.TYPEDexp(exp,ty,get_location opts),
                get_location opts),
               Set.union (tyvars2,Set.union (tyvars3,tyvars4))),error_id))
       | ([PAT (pat1,pVE1,tyvars1),PATLIST(l,pE,tyvars2),NULLTYPE,_,
           EXP(exp,tyvars3)],opts) =>
        (function_pattern_error (opts,pat1);
         FVAL(((error_id,rev l,exp,get_location opts),
               Set.union (tyvars2,tyvars3)),error_id))
 | _ => raise ActionError 84,



(* 	((FVAL ATPAT1 VARDEF OPTTYPE :EQUAL EXP))  *)

          fn ([PAT (pat1,pVE1,tyvars1),VALID id,TY (ty,tyvars3),_,
           EXP (exp,tyvars4)],opts) =>
        (function_pattern_error (opts,pat1);
         FVAL(make_infix_fval (opts,id,pat1,pat1,[],
                               Absyn.TYPEDexp(exp,ty,get_location opts),
                               [tyvars1,tyvars3,tyvars4]),id))
       | ([PAT (pat1,pVE1,tyvars1),VALID id,NULLTYPE,_,
           EXP (exp,tyvars3)],opts) =>
        (function_pattern_error (opts,pat1);
         FVAL(make_infix_fval (opts,id,pat1,pat1,[],exp,
                               [tyvars1,tyvars3]),id))
 | _ => raise ActionError 85,



(* 	((FVAL BIN_ATPAT OPTTYPE :EQUAL EXP))  *)

          fn ([BINPAT (pat1,id,pat2,pE1,tyvars1),TY (ty,tyvars2),_,
           EXP (exp,tyvars3)],opts) =>
        let val vid = varify id
         in FVAL(make_infix_fval (opts,vid,pat1,pat2,[],
                 Absyn.TYPEDexp(exp,ty,get_location opts),
                 [tyvars1,tyvars2,tyvars3]),vid)
        end
       | ([BINPAT (pat1,id,pat2,pE1,tyvars1),NULLTYPE,_,
           EXP (exp,tyvars2)],opts) =>
        let val vid = varify id
         in FVAL(make_infix_fval (opts,vid,pat1,pat2,[],exp,
                                  [tyvars1,tyvars2]),vid)
        end
 | _ => raise ActionError 86,


(* 	((FVAL BIN_ATPAT ATPATLIST OPTTYPE :EQUAL EXP))  *)

          fn ([BINPAT (pat1,id,pat2,pE1,tyvars1),
           PATLIST(patl,pE2,tyvars2),TY (ty,tyvars3),_,
           EXP (exp,tyvars4)],opts) =>
        let val vid = varify id
         in FVAL(make_infix_fval(opts,vid,pat1,pat2,rev patl,
                                 Absyn.TYPEDexp(exp,ty,get_location opts),
                                 [tyvars1,tyvars2,tyvars3,tyvars4]),vid)
        end
       | ([BINPAT (pat1,id,pat2,pE1,tyvars1),
           PATLIST(patl,pE2,tyvars2),NULLTYPE,_,EXP (exp,tyvars3)],opts) =>
        let val vid = varify id
         in FVAL(make_infix_fval(opts,vid,pat1,pat2,rev patl,exp,
                                 [tyvars1,tyvars2,tyvars3]),vid)
        end
 | _ => raise ActionError 87,


(* 	((OPTTYPE))  *)

          fn ([],opts) => NULLTYPE
 | _ => raise ActionError 88,



(* 	((OPTTYPE :colon TY))  *)

          fn ([_,ty],opts) => ty
 | _ => raise ActionError 89,



(* 	((TYPBIND TYPBIND1))  *)

          fn ([x],opts) => x
 | _ => raise ActionError 90,



(* 	((TYPBIND TYPBIND :and TYPBIND1)) *)

          fn ([TYPBIND tbl,_,TYPBIND [tb]],opts) =>
       (check_disjoint_typbind(opts,tb,tbl);TYPBIND (tb::tbl))
 | _ => raise ActionError 91,

(* 	((TYPBIND1 TYVARSEQ TYCON :EQUAL TY)) *)

                   fn ([TYVARLIST tyvarlist, TYCON tycon,_,TY (ty,tyvars)],opts) =>
  (check_tyvar_inclusion(opts,tyvars,tyvarlist);TYPBIND [(rev tyvarlist,tycon,ty,if generate_moduler opts then SOME(ref(Absyn.nullTyfun))
   else NONE)])
 | _ => raise ActionError 92,

(* 	((LONGTYPBIND LONGTYPBIND1))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 93,

(* 	((LONGTYPBIND LONGTYPBIND :and LONGTYPBIND1))  *)

                   fn ([LONGTYPBIND tbl,_,LONGTYPBIND [tb]],opts) =>
   LONGTYPBIND (tb::tbl)
 | _ => raise ActionError 94,

(* 	((LONGTYPBIND1 TYVARSEQ LONGTYCON :EQUAL TY)) *)

                   fn ([TYVARLIST tyvarlist, LONGTYCON tycon,_,TY (ty,tyvars)],opts) =>
  (check_tyvar_inclusion(opts,tyvars,tyvarlist);
   LONGTYPBIND [(rev tyvarlist,tycon,ty,get_location opts)])
 | _ => raise ActionError 95,

(* 	((TYVARSEQ))  *)

                   fn ([],opts) => TYVARLIST []
 | _ => raise ActionError 96,

(* 	((TYVARSEQ TYVARSEQ1)) *)

         	 fn ([x],opts) => x
 | _ => raise ActionError 97,

(* 	((TYVARSEQ1 :tyvar))  *)

                   fn ([TYVAR t],opts) => TYVARLIST [t]
 | _ => raise ActionError 98,

(* 	((TYVARSEQ1 :lpar TYVARLIST :rpar))  *)

                   fn ([_,TYVARLIST l,_],opts) => TYVARLIST l
 | _ => raise ActionError 99,

(* 	((TYVARLIST :tyvar))  *)

                   fn ([TYVAR t],opts) => TYVARLIST [t]
 | _ => raise ActionError 100,

(* 	((TYVARLIST TYVARLIST :comma :tyvar))  *)

                   fn ([TYVARLIST l,_,TYVAR t],opts) => (check_disjoint_tyvars(opts,t,l);TYVARLIST (t::l))
 | _ => raise ActionError 101,

(* 	((DATREPL DATAHEADER :datatype LONGTYCON)) *)
(* 	                                ; Datatype replication. *)

                   fn ([DATAHDR(tyvars, tycon),_, LONGTYCON longtycon],opts) =>
            DATREPL(tyvars,tycon,longtycon)
 | _ => raise ActionError 102,



(* 	((DATBIND DATBIND1))  *)

                   fn ([DATBIND1(d,pVE,pTE)],opts) => DATBIND([d],pVE,pTE)
 | _ => raise ActionError 103,

(* 	((DATBIND DATBIND :and DATBIND1))  *)

                   fn ([DATBIND(l,pVE,pTE),_,DATBIND1(d,pVE',pTE')],opts) =>
(check_disjoint_datbind(opts,d,l);DATBIND(d::l,merge_pVEs(opts,pVE,pVE'),
                                          merge_pTEs(opts,pTE,pTE')))
 | _ => raise ActionError 104,

(* 	((DATBIND1 DATAHEADER CONBIND))  *)

                   fn ([DATAHDR(tyvarlist,tycon),CONBIND (conbind,pVE,tyvars)],opts) =>
  (check_tyvar_inclusion(opts,tyvars,tyvarlist);
   DATBIND1 ((rev tyvarlist,tycon,ref Absyn.nullType,
              if generate_moduler opts 
                then SOME(ref(Absyn.nullTyfun))
              else NONE,rev conbind),
             pVE, make_pTE (tycon,pVE)))
 | _ => raise ActionError 105,

(* 	((DATAHEADER TYVARSEQ TYCON :EQUAL)) *)

                  fn ([TYVARLIST tyvarlist, TYCON tycon,_],opts) =>
  DATAHDR(tyvarlist,tycon)
 | _ => raise ActionError 106,


(* 	((CONBIND CONBIND1))  *)

                   fn ([CONBIND1(cb,id,tyvars)],opts) => CONBIND([cb],make_pVE id,tyvars)
 | _ => raise ActionError 107,

(* 	((CONBIND CONBIND :vbar CONBIND1))  *)

                   fn ([CONBIND (cbl,pVE,tyvars1),_,CONBIND1 (cb,id,tyvars2)],opts) =>
  CONBIND(cb::cbl,addNewValId(opts,id,pVE),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 108,

(* 	((CONBIND1 OPCONDEF OPTOFTYPE))  *)

                      fn ([VALID id,TY (ty,tyvars)],opts) => CONBIND1 ((annotate id,SOME ty),id,tyvars)
| ([VALID id,NULLTYPE], opts) => CONBIND1 ((annotate id,NONE),id,Set.empty_set)
 | _ => raise ActionError 109,

(* 	((EXBIND EXBIND1))  *)

                   fn ([EXBIND1 (e,id,tyvars)],opts) => EXBIND ([e],make_pVE id,tyvars)
 | _ => raise ActionError 110,

(* 	((EXBIND EXBIND :and EXBIND1))  *)

                   fn ([EXBIND (l,pVE,tyvars1),_,EXBIND1 (e,id,tyvars2)],opts) =>
  EXBIND (e::l,addNewValId(opts,id,pVE),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 111,

(* 	((EXBIND1 OPEXCONDEF OPTOFTYPE))  *)

                      fn ([VALID id, TY (ty,tyvars)],opts) => 
  EXBIND1 (Absyn.NEWexbind (annotate id,SOME ty,get_location opts,make_exbind_info(opts,id)),id,tyvars)
| ([VALID id, NULLTYPE],opts) => 
  EXBIND1 (Absyn.NEWexbind (annotate id,NONE,get_location opts,make_exbind_info(opts,id)),id,Set.empty_set)
 | _ => raise ActionError 112,

(* 	((EXBIND1 OPEXCONDEF :EQUAL OPLONGVAR))  *)

                   fn ([VALID id,_,LONGVALID (id',strname_opt)],opts) => 
    (check_excon (id',strname_opt,opts);
     EXBIND1 (Absyn.OLDexbind (annotate id,id',get_location opts,make_exbind_info (opts,id)),id,Set.empty_set))
 | _ => raise ActionError 113,

(* 	((OPTOFTYPE))  *)

                   fn ([],opts) => NULLTYPE
 | _ => raise ActionError 114,

(* 	((OPTOFTYPE :OF TY))  *)

                   fn ([_,x],opts) => x
 | _ => raise ActionError 115,

(* 	((ATPAT :underbar))  *)

                   fn ([_],opts as OPTS(location,options,_)) =>
       PAT (Absyn.WILDpat location,PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 116,

(* 	((ATPAT SCON))  *)

       fn ([SCON (x as (Ident.REAL _))],opts) => 
        (check_is_old_definition
         (opts, "Real is not an equality type in SML'96");
        PAT (Absyn.SCONpat (annotate x),PE.empty_pVE,Set.empty_set))
    | ([SCON x], opts) => 
        PAT (Absyn.SCONpat (annotate x),PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 117,

(* ;; This is where variables are introduced.  Make a new environment  *)
(* ;; with just it in.  *)
(* ;; Note that there is a complication.  In sml'96 constructors *)
(* ;; may be rebound in val rec decs but not ordinary val decs.  Thus *)
(* ;; at this point, an OPVARDEF may be a short constructor.  In that *)
(* ;; case, we don't yet know if it can be rebound or not.  If it can't *)
(* ;; then there may be many occurrences of a constructor, if it can, *)
(* ;; then there may be only one.  This problem can only be resolved *)
(* ;; when we know for sure it is a val rec.  Thus to solve problems *)
(* ;; with multiple occurrences of short constructors, we do not update *)
(* ;; pVE with them until we know they can be rebound.  This will be *)
(* ;; done by the function varify_valbind. *)

(* 	((ATPAT OPVARDEF))  *)

          fn ([VALID id],opts) => 
         PAT (Absyn.VALpat (annotate' (make_long_id id),
                            get_location opts),
              if is_constructor id then PE.empty_pVE
                                   else make_pVE id,Set.empty_set)
 | _ => raise ActionError 118,



(* 	((ATPAT OPLONGVAR))  *)

        fn ([LONGVALID (id,strname_opt)],opts) => 
      (check_is_constructor (opts,id,strname_opt);
       (PAT (Absyn.VALpat (annotate' id,get_location opts),
             PE.empty_pVE,Set.empty_set)))
 | _ => raise ActionError 119,



(* 	((ATPAT :lbrace PATROW :rbrace))  *)

                   fn ([_,PATROW (columns,wild,pVE,tyvars),_],opts) => 
  PAT (Absyn.RECORDpat (rev columns,wild,ref Absyn.nullType),pVE,tyvars)
 | _ => raise ActionError 120,

(* 	((ATPAT :lbrace PATROW :comma :ellipsis :rbrace))  *)

                   fn ([_,PATROW (columns,wild,pVE,tyvars),_,_,_],opts) => 
  PAT (Absyn.RECORDpat (rev columns,true,ref Absyn.nullType),pVE,tyvars)
 | _ => raise ActionError 121,

(* 	((ATPAT :lbrace :ellipsis :rbrace))  *)

                   fn ([_,_,_],opts) => 
  PAT (Absyn.RECORDpat ([],true,ref Absyn.nullType),PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 122,

(* 	((ATPAT :lbrace :rbrace))  *)

                   fn ([_,_],opts) => PAT (Derived.make_unit_pat(),PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 123,

(* 	((ATPAT :lpar :rpar))  *)

                   fn ([_,_],opts) => PAT (Derived.make_unit_pat(),PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 124,

(* 	((ATPAT :lpar PATLIST2 :rpar))  *)

                   fn ([_,PATLIST (l,pVE,tyvars),_],opts) => PAT (Derived.make_tuple_pat (rev l),pVE,tyvars)
 | _ => raise ActionError 125,

(* 	((ATPAT :bra :ket))  *)

                   fn ([_,_],opts) => PAT (Derived.make_list_pat([],get_location opts,get_current_pE()),PE.empty_pVE,Set.empty_set)
 | _ => raise ActionError 126,

(* 	((ATPAT :bra PAT :ket))  *)

                   fn ([_,PAT(l,pVE,tyvars),_],opts) => PAT (Derived.make_list_pat([l],get_location opts,get_current_pE()),pVE,tyvars)
 | _ => raise ActionError 127,

(* 	((ATPAT :lpar PAT :rpar))  *)

                   fn ([_,x,_],opts) => x
 | _ => raise ActionError 128,

(* 	((ATPAT :bra PATLIST2 :ket))  *)

                   fn ([_,PATLIST (l,pVE,tyvars),_],opts) => PAT (Derived.make_list_pat(rev l,get_location opts,get_current_pE()),pVE,tyvars)
 | _ => raise ActionError 129,

(* 	((BIN_ATPAT :lpar ATPAT PATVAR ATPAT :rpar))  *)

                   fn ([_,PAT (pat1,pVE1,tyvars1),VALID id,
                   PAT (pat2,pVE2,tyvars2),_],opts) =>
  BINPAT(pat1,id,pat2,merge_pVEs(opts,pVE1,pVE2),Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 130,

(* 	((ATPAT1 BIN_ATPAT))  *)

                   fn ([BINPAT (pat1,id,pat2,pVE,tyvars)],opts) =>
  (check_is_short_constructor (opts,id);
   PAT (Absyn.APPpat (annotate (make_long_id id), 
                      Derived.make_tuple_pat[pat1,pat2],
                      get_location opts,true),pVE,tyvars))
 | _ => raise ActionError 131,

(* 	((ATPAT1 ATPAT))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 132,

(* 	((PATLIST2 PAT :COMMA PAT))  *)

                   fn ([PAT (pat1,pVE1,tyvars1),_,PAT (pat2,pVE2,tyvars2)],opts) =>
  PATLIST ([pat2,pat1], merge_pVEs(opts,pVE1,pVE2), Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 133,

(* 	((PATLIST2 PATLIST2 :COMMA PAT))  *)

                   fn ([PATLIST (pat1,pVE1,tyvars1),_,PAT (pat2,pVE2,tyvars2)],opts) =>
  PATLIST (pat2::pat1, merge_pVEs(opts,pVE1,pVE2), Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 134,

(* 	((PATROW PATROW1))  *)

                   fn ([PATROW1 (lp,pVE,tyvars)],opts) => PATROW ([lp],false,pVE,tyvars)
 | _ => raise ActionError 135,

(* 	((PATROW PATROW :comma PATROW1))  *)

                   fn ([PATROW (l,wild,pVE1,tyvars1),_,PATROW1 (lp as (lab,_),pVE2,tyvars2)],opts) =>
  (check_disjoint_labels(opts,lab,l);
   PATROW (lp :: l,wild,merge_pVEs(opts,pVE1,pVE2), Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 136,

(* 	((PATROW1 LAB :EQUAL PAT))  *)

                   fn ([LAB lab,_,PAT (pat,pVE,tyvars)],opts) => PATROW1 ((lab,pat),pVE,tyvars)
 | _ => raise ActionError 137,

(* 	((PATROW1 SYMID OPTTYPE))  *)

                   fn ([SYM sym, TY (ty,tyvars)],opts) =>
  (check_not_constructor_symbol (opts,sym);
   PATROW1 ((Derived.make_patrow (sym, SOME ty, NONE,get_location opts)),make_Sym_pVE sym,tyvars))
| ([SYM sym, NULLTYPE],opts) =>
  (check_not_constructor_symbol (opts,sym);
   PATROW1 (Derived.make_patrow (sym, NONE, NONE,get_location opts),make_Sym_pVE sym,Set.empty_set))
 | _ => raise ActionError 138,

(* 	((PATROW1 SYMID OPTTYPE :as PAT))  *)

                   fn ([SYM sym, TY (ty,tyvars1),_,PAT (pat,pVE,tyvars2)],opts) =>
  (check_not_constructor_symbol (opts,sym);
   PATROW1 (Derived.make_patrow (sym, SOME ty, SOME pat,get_location opts),addNewSymId(opts,sym,pVE),Set.union (tyvars1,tyvars2)))
| ([SYM sym, NULLTYPE,_,PAT (pat,pVE,tyvars)],opts) =>
  (check_not_constructor_symbol (opts,sym);
   PATROW1 (Derived.make_patrow (sym, NONE, SOME pat,get_location opts),addNewSymId(opts,sym,pVE),tyvars))
 | _ => raise ActionError 139,

(* 	((PAT ATPAT))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 140,

(* 	((PAT OPLONGVAR ATPAT))  *)

                    fn ([LONGVALID (id,strname_opt), PAT (pat,pVE,tyvars)],opts) => 
     (check_is_constructor (opts,id,strname_opt);
      (PAT (Absyn.APPpat (annotate id, pat,get_location opts,false),pVE,tyvars)))
 | _ => raise ActionError 141,

(* 	((PAT OPVARDEF ATPAT))  *)

(* ;; This is really an error case, but now we just coerce to a constructor *)
                   fn ([VALID id, PAT (pat,pVE,tyvars)],opts) => 
    (check_is_short_constructor (opts,id);
     PAT (Absyn.APPpat (annotate (make_long_id id), pat,get_location opts,false),pVE,tyvars))
 | _ => raise ActionError 142,

(* 	((PAT PAT VAR PAT))  *)

                   fn ([PAT(pat1,pVE1,tyvars1), LONGVALID (id,_), PAT(pat2,pVE2,tyvars2)],opts) =>
  (check_is_infix_constructor (opts,id);
   PAT(Absyn.APPpat(annotate id, Derived.make_tuple_pat[pat1,pat2],get_location opts,true),merge_pVEs(opts,pVE1,pVE2),Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 143,

(* 	((PAT PAT :colon TY))  *)

                   fn ([PAT (pat,pVE,tyvars1),_,TY (ty,tyvars2)],opts) => PAT (Absyn.TYPEDpat(pat,ty,get_location opts),pVE,Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 144,

(* 	((PAT OPVARDEF OPTTYPE :as PAT))  *)

                     fn ([VALID id, TY(ty,tyvars1),_,PAT(pat,pVE,tyvars2)],opts) =>
  PAT (Absyn.TYPEDpat (Absyn.LAYEREDpat (annotate' id, pat), ty,get_location opts),addNewValId(opts,id,pVE),Set.union(tyvars1,tyvars2))
| ([VALID id, NULLTYPE,_,PAT (pat,pVE,tyvars)],opts) =>
  PAT (Absyn.LAYEREDpat (annotate' id, pat),addNewValId(opts,id,pVE),tyvars)
 | _ => raise ActionError 145,

(* ;; Types need to have tyvar set added -- a field in Ty maybe?  *)

(* 	((TY :tyvar))  *)

                   fn ([TYVAR t],opts) => TY (Absyn.TYVARty (t),Set.singleton t)
 | _ => raise ActionError 146,

(* 	((TY :lbrace TYROW :rbrace))  *)

                   fn ([_,TYROW (l,tvs),_],opts) => TY (Absyn.RECORDty l,tvs)
 | _ => raise ActionError 147,

(* 	((TY :lbrace :rbrace))  *)

                   fn ([_,_],opts) => TY (Absyn.RECORDty [],Set.empty_set)
 | _ => raise ActionError 148,

(* 	((TY TYSEQ LONGTYCON))  *)

                   fn ([TYLIST (s,tvs), LONGTYCON c],opts) => TY (Absyn.APPty (rev s,c,get_location opts),tvs)
 | _ => raise ActionError 149,

(* 	((TY TY LONGTYCON))  *)

                   fn ([TY (t,tvs), LONGTYCON c],opts) => TY (Absyn.APPty ([t],c,get_location opts),tvs)
 | _ => raise ActionError 150,

(* 	((TY LONGTYCON))  *)

                   fn ([LONGTYCON c],opts) => TY (Absyn.APPty ([],c,get_location opts),Set.empty_set)
 | _ => raise ActionError 151,

(* 	((TY TYTUPLE))  *)

                   fn ([TYLIST (tl,tvs)],opts) => TY (Derived.make_tuple_ty (rev tl),tvs)
 | _ => raise ActionError 152,

(* 	((TY TY :arrow TY))  *)

                   fn ([TY (t1,tvs1),_,TY (t2,tvs2)],opts) => TY (Absyn.FNty (t1,t2),Set.union(tvs1,tvs2))
 | _ => raise ActionError 153,

(* 	((TY :LPAR TY :RPAR))  *)

                   fn ([_,t,_],opts) => t
 | _ => raise ActionError 154,

(* 	((TYSEQ :lpar TYLIST :comma TY :rpar))  *)

                   fn ([_,TYLIST (l,tyvars1),_,TY (ty,tyvars2),_],opts) => TYLIST (ty :: l,Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 155,

(* 	((TYLIST TY))  *)

                   fn ([TY (ty,tyvars)],opts) => TYLIST ([ty],tyvars)
 | _ => raise ActionError 156,

(* 	((TYLIST TYLIST :comma TY))  *)

                   fn ([TYLIST (tl,tyvars1),_,TY (ty,tyvars2)],opts) => TYLIST (ty::tl,Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 157,

(* 	((TYTUPLE TYTUPLE STAR TY))  *)

                   fn ([TYLIST (tl,tyvars1),_,TY (ty,tyvars2)],opts) => TYLIST (ty::tl,Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 158,

(* 	((TYTUPLE TY STAR TY))  *)

                   fn ([TY (t1,tyvars1),_,TY (t2,tyvars2)],opts) => TYLIST ([t2,t1],Set.union(tyvars1,tyvars2))
 | _ => raise ActionError 159,

(* 	((TYROW LAB :colon TY))  *)

                   fn ([LAB l,_,TY (ty,tyvars)],opts) => TYROW ([(l,ty)],tyvars)
 | _ => raise ActionError 160,

(* 	((TYROW TYROW :comma LAB :colon TY))  *)

                   fn ([TYROW (l,tyvars1),_,LAB lab,_,TY (ty,tyvars2)],opts) =>
(check_disjoint_labels(opts,lab,l);TYROW ((lab,ty)::l,Set.union(tyvars1,tyvars2)))
 | _ => raise ActionError 161,

(* 	;; LISTS  *)

(* 	((ATPATLIST ATPAT))  *)

                   fn ([PAT (pat,pE,tyvars)],opts) => PATLIST ([pat],pE,tyvars)
 | _ => raise ActionError 162,

(* 	((ATPATLIST ATPATLIST ATPAT))  *)

                   fn ([PATLIST (l,pVE1,tyvars1), PAT (pat,pVE2,tyvars2)],opts) => 
  PATLIST (pat::l,merge_pVEs(opts,pVE1,pVE2),Set.union (tyvars1,tyvars2))
 | _ => raise ActionError 163,

(* ;; Longid lists used for structure reference lists -- these are kept as longids  *)

(* 	((LONGIDLIST LONGIDLIST :longid))  *)

                   fn ([LONGIDLIST l,LONGID id],opts) => LONGIDLIST(id :: l)
 | _ => raise ActionError 164,

(* 	((LONGIDLIST :longid))  *)

                   fn ([LONGID id],opts) => LONGIDLIST[id]
 | _ => raise ActionError 165,

(* ;; Long symbol lists  *)

(* 	((LONGSTRIDLIST LONGSTRIDLIST LONGSTRID))  *)

                   fn ([LONGSTRIDLIST l, LONGSTRID i],opts) => LONGSTRIDLIST(i::l)
 | _ => raise ActionError 166,

(* 	((LONGSTRIDLIST LONGSTRID))  *)

                   fn ([LONGSTRID i],opts) => LONGSTRIDLIST[i]
 | _ => raise ActionError 167,

(* ;; Symbol lists  *)

(* 	((SYMLIST SYM))  *)

                   fn ([SYM sym],opts) => SYMLIST [sym]
 | _ => raise ActionError 168,

(* 	((SYMLIST SYMLIST SYM))  *)

                   fn ([SYMLIST l,SYM sym],opts) => SYMLIST (sym::l)
 | _ => raise ActionError 169,

(* 	;; Constants  *)

(* ((SCON :integer))  *)

                   fn ([INTEGER s],opts) => SCON (Ident.INT(s,get_location opts))
 | _ => raise ActionError 170,

(* 	((SCON :real))  *)

                   fn ([REAL s],opts) => SCON (Ident.REAL (s,get_location opts))
 | _ => raise ActionError 171,

(* 	((SCON :string))  *)

                   fn ([STRING s],opts) => SCON (Ident.STRING s)
 | _ => raise ActionError 172,

(* 	((SCON :char))  *)

                   fn ([CHAR s],opts) => SCON (Ident.CHAR s)
 | _ => raise ActionError 173,

(* 	((SCON :word))  *)

                   fn ([WORD s],opts) => SCON (Ident.WORD(s, get_location opts))
 | _ => raise ActionError 174,

(* 	;; Labels  *)

(* 	((LAB :longid))  *)

                   fn ([LONGID ([],s)],opts) => LAB (Ident.LAB s)
| ([LONGID (id as (p,s))],opts) =>
  (report_long_error (opts,id,"record label"); LAB (Ident.LAB s))
 | _ => raise ActionError 175,

(* 	((LAB :integer)) ;; need to check its within allowable bounds  *)

                   fn ([INTEGER int],opts) => (check_integer_bounds (opts,int); LAB (Ident.LAB (Symbol.find_symbol int)))
 | _ => raise ActionError 176,

(* 	;; Long variables  *)

(* 	((LONGVAR :longid))  *)

                   fn ([LONGID id],opts) => LONGVALID (resolveLongValId(opts,id))
 | _ => raise ActionError 177,

(* 	((OPLONGVAR LONGVAR))  *)

                   fn ([l as LONGVALID (id,_)],opts) => (check_non_longid_op (opts,id); l)
 | _ => raise ActionError 178,

(* 	((OPLONGVAR :op LONGVAR))  *)

                   fn ([_, l as LONGVALID (id,_)],opts) => (check_longid_op (opts,id); l)
 | _ => raise ActionError 179,

(* 	((LONGTYCON :longid))  *)

                   fn ([LONGID (l,s)],opts) => LONGTYCON (mkLongTyCon (opts,l,s))
 | _ => raise ActionError 180,

(* 	((LONGSTRID :longid))  *)

                   fn ([LONGID (l,s)],opts) => LONGSTRID (mkLongStrId (l,s))
 | _ => raise ActionError 181,

(* ;; This one is parsed as a symbol.  *)

(* 	((SYM :longid))  *)

                   fn ([LONGID ([],s)],opts) => SYM s
| ([LONGID (id as (l,s))],opts) =>
  (report_long_error (opts,id,"symbol"); SYM s)
 | _ => raise ActionError 182,

(* 	((SYM :equal))  *)

                   fn ([_],opts) => SYM equal_symbol
 | _ => raise ActionError 183,


(* 	((SYMID :longid))  *)

                   fn ([LONGID ([],s)],opts) => SYM s
| ([LONGID (id as (l,s))],opts) =>
  (report_long_error (opts,id,"symbol"); SYM s)
 | _ => raise ActionError 184,

(* 	((FUNID SYMID))  *)

                   fn ([SYM s],opts) => FUNID(Ident.FUNID s)
 | _ => raise ActionError 185,

(* 	((SIGID SYMID))  *)

                   fn ([SYM s],opts) => SIGID(Ident.SIGID s)
 | _ => raise ActionError 186,

(* 	((STRID SYMID))  *)

                   fn ([SYM s],opts) => STRID(Ident.STRID s)
 | _ => raise ActionError 187,

(* ;; These ones become long valids.  *)

(* ;; This one appears only in infix expressions and patterns, and can be a  *)
(* ;; constructor or a variable.  *)
(* 	((VAR :longid))  *)

                   fn ([LONGID (longid as ([],id))],opts) => LONGVALID (Ident.LONGVALID(Ident.NOPATH,resolveValId id),NONE)
 | ([LONGID (longid as (_,id))],opts) => (report_long_error(opts,longid,"variable");LONGVALID (Ident.LONGVALID(Ident.NOPATH,Ident.VAR id),NONE))
 | _ => raise ActionError 188,

(* ;; This is used for defining occurences of variables in patterns.  *)

(* 	((VARDEF :longid))  *)

          fn ([LONGID ([],id)],opts) => 
          let val valid = resolveValId id 
           in if get_old_definition opts
                then check_not_short_constructor (opts,valid)
              else (); VALID valid
          end
       | ([LONGID (longid as (_,id))],opts) =>
            (report_long_error (opts,longid,"variable"); 
            VALID (Ident.VAR id))
 | _ => raise ActionError 189,

(* 	((OPVARDEF VARDEF))  *)

                   fn ([valid as VALID id],opts) => 
              (check_non_valid_op (opts,id); valid)
 | _ => raise ActionError 190,

(* 	((OPVARDEF :op VARDEF))  *)

                   fn ([_,valid as VALID id],opts) => 
              (check_valid_op(opts,id); valid)
 | _ => raise ActionError 191,

(* ;; this is used in bin-atpats where the infixed var might be a constructor or a var  *)
(* 	((PATVAR :longid))  *)

                   fn ([LONGID (id as ([],_))],opts) => VALID (getValId id)
| ([LONGID (longid as (_,id))],opts) => (report_long_error (opts,longid,"variable"); VALID (Ident.VAR id))
 | _ => raise ActionError 192,

(* 	((CONDEF :longid))  *)

                   fn ([LONGID ([],s)],opts) => VALID (Ident.CON s)
| ([LONGID (id as (p,s))],opts) => (report_long_error (opts,id,"constructor"); VALID (Ident.CON s))
 | _ => raise ActionError 193,

(* 	((OPCONDEF CONDEF))  *)

                   fn ([valid as (VALID con)],opts) => (check_non_conid_op(opts,con); valid)
 | _ => raise ActionError 194,

(* 	((OPCONDEF :op CONDEF))  *)

                   fn ([_,valid as (VALID con)],opts) => (check_conid_op(opts,con); valid)
 | _ => raise ActionError 195,

(* 	((EXCONDEF :longid))  *)

                   fn ([LONGID ([],s)],opts) => VALID (Ident.EXCON s)
| ([LONGID (id as (p,s))],opts) => (report_long_error (opts,id,"exception constructor"); VALID (Ident.EXCON s))
 | _ => raise ActionError 196,

(* 	((OPEXCONDEF EXCONDEF))  *)

                   fn ([valid as (VALID excon)],opts) => (check_non_conid_op(opts,excon); valid)
 | _ => raise ActionError 197,

(* 	((OPEXCONDEF :op EXCONDEF))  *)

                   fn ([_,valid as (VALID excon)],opts) => (check_conid_op(opts,excon); valid)
 | _ => raise ActionError 198,

(* 	((TYCON :longid))  *)

                   fn ([LONGID ([],s)],opts) => TYCON (mkTyCon (opts,s))
| ([LONGID (id as (l,s))],opts) => (report_long_error (opts,id,"type constructor"); TYCON (mkTyCon(opts,s)))
 | _ => raise ActionError 199,

(* 	((STAR :longid))  *)

                   fn ([LONGID ([],s)],opts) => DUMMY 
               (* should check its an asterisk *)
 | _ => raise ActionError 200,

(* 	;; Modules  *)

(* 	((STREXP STRUCT_START STRDEC :end))  *)

                   fn ([ENV pE,STRDEC (x,e),_],opts) =>
              (set_pE pE;
               STREXP (Absyn.NEWstrexp x,e))
 | _ => raise ActionError 201,

(* 	((STREXP :longid))  *)

                   fn ([LONGID x],opts) =>
    STREXP (Absyn.OLDstrexp (mkLongStrId x,get_location opts,
                             if generate_moduler opts then SOME(ref(NONE))
                             else NONE),lookupStrId(opts,x))
 | _ => raise ActionError 202,

(* 	((STREXP FUNID :lpar STREXP :rpar))  *)

                   fn ([FUNID funid,_,STREXP(strexp,_),_],opts) => 
  STREXP (Absyn.APPstrexp (funid,strexp,ref false,get_location opts,if generate_moduler opts then SOME(ref(Absyn.nullDebuggerStr)) else NONE),lookupFunId (opts,funid))
 | _ => raise ActionError 203,

(* 	((STREXP FUNID :lpar STRDEC :rpar))  *)

                   fn ([FUNID funid,_,STRDEC(strdec,e),_],opts) => 
  STREXP (Absyn.APPstrexp (funid,Derived.make_strexp strdec,ref false,get_location opts,if generate_moduler opts then SOME(ref(Absyn.nullDebuggerStr)) else NONE),lookupFunId (opts,funid))
 | _ => raise ActionError 204,

(* 	((STREXP START_LET STRDEC :in STREXP :end))  *)

                   fn ([ENV pE,STRDEC(strdec,e),_,STREXP(strexp,e'),_],opts) => 
  (set_pE pE; STREXP (Absyn.LOCALstrexp(strdec,strexp),e'))
 | _ => raise ActionError 205,


(*         ((STREXP STREXP SIGBINDER SIGEXP)) *)

           fn ([STREXP (strexp,e),BOOL abs,SIGEXP (sigexp,(e',tycons))],opts) =>
  STREXP (Absyn.CONSTRAINTstrexp (strexp,sigexp,abs,ref false,get_location opts),e')
 | _ => raise ActionError 206,

(* 	((STRUCT_START :struct))  *)

                   fn ([_],opts) => ENV (get_current_pE())
 | _ => raise ActionError 207,

(* 	((STRDEC DECSEP))  *)

                   fn ([_],opts) => STRDEC (Absyn.SEQUENCEstrdec[],PE.empty_pE)
 | _ => raise ActionError 208,

(* 	((STRDEC DECSEP STRDEC1 DECSEP))  *)

                   fn ([_,strdec,_],opts) => strdec
 | _ => raise ActionError 209,

(* 	((STRDEC DECSEP STRDEC0 DECSEP))  *)

                   fn ([_,STRDECLIST(l,pE),_],opts) => STRDEC(Absyn.SEQUENCEstrdec(rev l),pE)
 | _ => raise ActionError 210,

(* 	((STRDEC0 STRDEC1 DECSEP STRDEC1))  *)

                   fn ([STRDEC(strdec1,pE1),_,STRDEC(strdec2,pE2)],opts) => STRDECLIST([strdec2,strdec1],PE.augment_pE(pE1,pE2))
 | _ => raise ActionError 211,

(* 	((STRDEC0 STRDEC0 DECSEP STRDEC1))  *)

                   fn ([STRDECLIST(l,pE1),_,STRDEC(strdec,pE2)],opts) => STRDECLIST(strdec::l,PE.augment_pE(pE1,pE2))
 | _ => raise ActionError 212,

(* ;; This is used for strdecs as topdecs - don't allow them to be separated by semicolons.  *)

(* 	((STRDEC1PLUS STRDEC1))  *)

                   fn ([STRDEC (x,pE)],opts) => STRDEC(Absyn.SEQUENCEstrdec[x],pE)
 | _ => raise ActionError 213,

(* 	((STRDEC1PLUS STRDEC1PLUS0))  *)

                   fn ([STRDECLIST(l,pE)],opts) => STRDEC(Absyn.SEQUENCEstrdec(rev l),pE)
 | _ => raise ActionError 214,

(* 	((STRDEC1PLUS0 STRDEC1 STRDEC1))  *)

                   fn ([STRDEC(strdec1,pE1),STRDEC(strdec2,pE2)],opts) => 
  STRDECLIST([strdec2,strdec1],PE.augment_pE(pE1,pE2))
 | _ => raise ActionError 215,

(* 	((STRDEC1PLUS0 STRDEC1PLUS0 STRDEC1))  *)

                   fn ([STRDECLIST(l,pE1),STRDEC(strdec,pE2)],opts) => 
  STRDECLIST(strdec::l,PE.augment_pE(pE1,pE2))
 | _ => raise ActionError 216,

(* ;; Single strdecs  *)

(* 	((STRDEC1 DEC1))  *)

                   fn ([DEC(dec,pE,tyvars)],opts) => STRDEC(Absyn.DECstrdec dec,pE) (* ignore tyvars *)
 | _ => raise ActionError 217,

(* 	((STRDEC1 :structure STRBIND))  *)

                   fn ([_,STRBIND(l,pSE)],opts) => 
  (extend_pSE pSE;STRDEC(Absyn.STRUCTUREstrdec l,pSE_in_pE pSE))
 | _ => raise ActionError 218,

(* 	((STRDEC1 :abstraction STRBIND))  *)

                   fn ([_,STRBIND(l,pSE)],opts) => 
  (extend_pSE pSE;STRDEC(Absyn.ABSTRACTIONstrdec (map do_abstraction l),pSE_in_pE pSE))
 | _ => raise ActionError 219,

(* 	((STRDEC1 START_LOCAL STRDEC :in STRDEC :end))  *)

                   fn ([ENV pE,STRDEC(strdec1,_),_,STRDEC(strdec2,pE'),_],opts) => 
  (set_pE (PE.augment_pE(pE,pE'));STRDEC(Absyn.LOCALstrdec(strdec1,strdec2),pE'))
 | _ => raise ActionError 220,

(*         ((SIGBINDER :colon)) *)
          fn ([_],opts) => BOOL false
 | _ => raise ActionError 221,

(*         ((SIGBINDER :abscolon)) *)
          fn ([_],opts) => BOOL true
 | _ => raise ActionError 222,

(* 	((STRBIND STRBIND1))  *)

                   fn ([STRBIND1 (d,(id,pE))],opts) => STRBIND([d],make_pSE (opts,id,pE))
 | _ => raise ActionError 223,

(* 	((STRBIND STRBIND :and STRBIND1))  *)

                   fn ([STRBIND(l,pSE),_,STRBIND1(d,id_pE)],opts) =>
   STRBIND(d::l,addNewStrId(opts,id_pE,pSE))
 | _ => raise ActionError 224,

(* 	((STRBIND1 STRID SIGBINDER SIGEXP :equal STREXP))  *)

                  fn ([STRID id,BOOL abs,SIGEXP(sigexp,(pE1,tycons)),_,
                  STREXP(strexp,pE2)],opts) => 
             STRBIND1((id,NONE,
                       Absyn.CONSTRAINTstrexp
                       (strexp,sigexp,abs,ref false,get_location opts),
                       ref false,
                       get_location opts,
                       if generate_moduler opts 
                         then SOME(ref(Absyn.nullDebuggerStr))
                       else NONE,
                       if generate_moduler opts
                         then SOME(ref(NONE))
                       else NONE),(id,pE1))
 | _ => raise ActionError 225,

(* 	((STRBIND1 STRID :equal STREXP))  *)

                  fn ([STRID id,_,STREXP(strexp,pE)],opts) => 
  STRBIND1((id,NONE,strexp,ref false,
            get_location opts,
            if generate_moduler opts
              then SOME(ref(Absyn.nullDebuggerStr))
            else NONE,
            if generate_moduler opts
              then SOME(ref(NONE))
            else NONE),(id,pE))
 | _ => raise ActionError 226,

(* 	((SIGEXP SIG_START SPEC :end))  *)

              fn ([ENV pE,SPEC (spec,(e,tycons)),_],opts) => 
     (set_pE pE; SIGEXP(Absyn.NEWsigexp(spec,ref NONE),(e,tycons)))
 | _ => raise ActionError 227,

(* 	((SIGEXP SIGID))  *)

              fn ([SIGID id],opts) => SIGEXP(Absyn.OLDsigexp(id,ref NONE,get_location opts),lookupSigId(opts,id))
 | _ => raise ActionError 228,

(*         ((SIGEXP SIGEXP :where :type LONGTYPBIND1)) *)
           fn ([SIGEXP (sigexp,e),_,_,LONGTYPBIND tybind],opts) =>
   SIGEXP (Absyn.WHEREsigexp (sigexp,tybind),e)
 | _ => raise ActionError 229,

(* 	((SIG_START :sig))  *)

                   fn ([_],opts) => let val pE = get_current_pE() in set_pE (zap_for_sig pE); ENV pE end
 | _ => raise ActionError 230,

(* 	((SIGDEC1PLUS SIGDEC1))  *)

                   fn ([SIGBIND(sigb,pG)],opts) => SIGDEC([Absyn.SIGBIND sigb],pG)
 | _ => raise ActionError 231,

(* 	((SIGDEC1PLUS SIGDEC1PLUS SIGDEC1))  *)

                   fn ([SIGDEC(l,pG),SIGBIND(sigb,pG')],opts) => SIGDEC((Absyn.SIGBIND sigb)::l,PE.augment_pG(pG,pG'))
 | _ => raise ActionError 232,

(* 	((SIGDEC1 :signature SIGBIND))  *)

                   fn ([_,x as SIGBIND(_,pG)],opts) => (extend_pG pG;x)
 | _ => raise ActionError 233,

(* 	((SIGBIND SIGID :EQUAL SIGEXP))  *)

                   fn ([SIGID id,_,SIGEXP(sigexp,(e,tycons))],opts) => SIGBIND([(id,sigexp,get_location opts)],make_pG(id,e,tycons))
 | _ => raise ActionError 234,

(* 	((SIGBIND  SIGBIND :and SIGID :EQUAL SIGEXP))  *)

             fn ([SIGBIND(l,pG),_,SIGID id,_,SIGEXP(sigexp,(e,tycons))],opts) => 
  SIGBIND((id,sigexp,get_location opts)::l,addNewSigId(opts,(id,e,tycons),pG))
 | _ => raise ActionError 235,

(* 	((SIGBIND  SIGBIND :and :type LONGTYPBIND1))  *)

             fn ([sb as SIGBIND(l,pG),_,_,LONGTYPBIND tybind],opts) => 
    ( case l of
        (id, wsigexp as Absyn.WHEREsigexp _, loc) :: t
           => let val new_sigexp = Absyn.WHEREsigexp(wsigexp, tybind)
               in SIGBIND((id, new_sigexp, loc) :: t, pG)
              end
      | _ => (error(opts, "Unexpected occurrence of \"and type\""); sb) )
 | _ => raise ActionError 236,


(* 	((SPEC))  *)
             fn ([],opts) => SPEC(Absyn.SEQUENCEspec [],(PE.empty_pE,[]))
 | _ => raise ActionError 237,

(* 	((SPEC SPEC SPEC1))  *)

             fn ([SPEC (spec1,specstuff1),SPEC (spec2,specstuff2)],opts) => 
  SPEC (combine_specs (spec1,spec2),spec_augment_pE (specstuff1,specstuff2,opts))
 | _ => raise ActionError 238,

(* 	((SPEC SPEC :sharing SHAREQ)) *)

           fn ([SPEC (spec,(pE,tycons)),_,SHAREQ l],opts) => 
   SPEC(Absyn.SHARINGspec (spec,rev l),(pE,tycons))
 | _ => raise ActionError 239,

(* ;; Don't need to extend global environment here -- no constructors here  *)

(*        ((SPEC1 :semicolon)) *)
         fn ([_],opts) => (SPEC (Absyn.SEQUENCEspec [],(PE.empty_pE,[])))
 | _ => raise ActionError 240,

(* 	((SPEC1 :val VALDESC))  *)

             fn ([_,VALDESC (l,pVE)],opts) => SPEC(Absyn.VALspec (rev l,get_location opts),(pVE_in_pE pVE,[]))
 | _ => raise ActionError 241,

(* 	((SPEC1 :type TYPDESC))  *)

             fn ([_,TYPDESC t],opts) => SPEC(do_type_spec (false,rev t,opts),(PE.empty_pE,names_of_typedesc t))
 | _ => raise ActionError 242,

(* 	((SPEC1 :eqtype TYPDESC))  *)

                   fn ([_,TYPDESC t],opts) => SPEC(do_type_spec (true,rev t,opts),(PE.empty_pE,names_of_typedesc t))
 | _ => raise ActionError 243,


(*         ((SPEC1 :datatype DATREPLDESC)) *)

                   fn ([_,DATREPLDESC(tyvars,tycon,longtycon)],opts) =>
    (check_is_new_definition(opts, 
         "Datatype replication is not a feature of SML'90.");		       
     check_empty_tyvars(opts,tyvars);
     let val pVE = lookupLongTycon longtycon
         val pTE = (make_pTE (tycon,pVE))
     in 
       extend_pVE pVE;
       extend_pTE pTE;
       SPEC(Absyn.DATATYPEreplSpec(get_location opts,tycon,longtycon,
                                    ref NONE),
            (pVEpTE_in_pE(pVE,pTE), nil))
     end)
 | _ => raise ActionError 244,

(* 	((SPEC1 :datatype DATDESC))  *)

                   fn ([_,DATDESC(l,pVE,pTE)],opts) =>
		  (extend_pVE pVE;
		   extend_pTE pTE;
		   SPEC(Absyn.DATATYPEspec (rev l), (pVEpTE_in_pE (pVE,pTE),
			names_of_datdesc l)))
 | _ => raise ActionError 245,

(* 	((SPEC1 :exception EXDESC))  *)

                   fn ([_,EXDESC(l,pVE)],opts) => (extend_pVE pVE;SPEC(Absyn.EXCEPTIONspec (rev l),(pVE_in_pE pVE,[])))
 | _ => raise ActionError 246,

(* 	((SPEC1 :structure STRDESC))  *)

                   fn ([_,STRDESC(l,pSE)],opts) => (extend_pSE pSE;SPEC(Absyn.STRUCTUREspec (rev l),(pSE_in_pE pSE,[])))
 | _ => raise ActionError 247,

(* 	((SPEC1 START_LOCAL SPEC :in SPEC :end))  *)

              fn ([ENV pE,SPEC(spec1,(pE1,tycons1)),_,SPEC(spec2,(pE2,tycons2)),_],opts) => 
     (check_is_old_definition (opts,"local specification no longer in language");
      set_pE (PE.augment_pE(pE,pE2));SPEC(Absyn.LOCALspec(spec1,spec2),(pE2,tycons2)))
 | _ => raise ActionError 248,

(* 	((SPEC1 :open LONGIDLIST))  *)

              fn ([_,LONGIDLIST l],opts) => 
     (check_is_old_definition (opts,"open specification no longer in language");
      do_open_spec_action (opts,rev l))
 | _ => raise ActionError 249,

(* 	((SPEC1 :include SIGIDLIST))  *)

                   fn ([_,SIGIDLIST l],opts) => do_include_action (opts,rev l)
 | _ => raise ActionError 250,

(* 	((SPEC1 :include SIGEXP))  *)
         
  fn ([_,SIGEXP (e,(pE,tycons))],opts) => 
  SPEC (Absyn.INCLUDEspec (e,get_location opts),(pE,tycons))
 | _ => raise ActionError 251,

(* ;; For compatibility with NJ *)
(* 	((SPEC1 :infix SYMLIST)) *)

                     fn ([_,SYMLIST l],opts) => do_fixity_spec (l,PE.LEFT 0,opts)
 | _ => raise ActionError 252,

(* 	((SPEC1 :infix :integer SYMLIST)) *)

                     fn ([_,INTEGER i,SYMLIST l],opts) => do_fixity_spec(l,PE.LEFT(parse_precedence (opts,i)),opts)
 | _ => raise ActionError 253,

(* 	((SPEC1 :infixr SYMLIST)) *)

                     fn ([_,SYMLIST l],opts) => do_fixity_spec (l,PE.RIGHT 0,opts)
 | _ => raise ActionError 254,

(* 	((SPEC1 :infixr :integer SYMLIST)) *)

                     fn ([_,INTEGER i,SYMLIST l],opts) => do_fixity_spec(l,PE.RIGHT(parse_precedence (opts,i)),opts)
 | _ => raise ActionError 255,

(* 	((SIGIDLIST SIGID))  *)

                   fn ([SIGID sigid],opts) => SIGIDLIST [sigid]
 | _ => raise ActionError 256,

(* 	((SIGIDLIST SIGIDLIST SIGID))  *)

                   fn ([SIGIDLIST l,SIGID sigid],opts) => SIGIDLIST(sigid::l)
 | _ => raise ActionError 257,

(* 	((VALDESC VARDEF :colon TY))  *)

                   fn ([VALID v,_,TY (ty,tyvars)],opts) => VALDESC([(v,ty,tyvars)], make_pVE v)
 | _ => raise ActionError 258,

(* 	((VALDESC VALDESC :and VARDEF :colon TY))  *)

                   fn ([VALDESC(l,pVE),_,VALID v,_,TY (ty,tyvars)],opts) => 
  VALDESC((v,ty,tyvars)::l,addNewValId(opts,v,pVE))
 | _ => raise ActionError 259,

(* 	((TYPDESC TYPDESC1))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 260,

(* 	((TYPDESC TYPDESC :and TYPDESC1))  *)

                   fn ([TYPDESC l,_,TYPDESC [t]],opts) => 
  (check_disjoint_typdesc(opts,t,l); TYPDESC (t::l))
 | _ => raise ActionError 261,

(* 	((TYPDESC1 TYVARSEQ TYCON))  *)

             fn ([TYVARLIST tyvarlist,TYCON tycon],opts) => 
     TYPDESC[(rev tyvarlist,tycon,NONE)]
 | _ => raise ActionError 262,

(* 	((TYPDESC1 TYVARSEQ TYCON :equal TY))  *)

             fn ([TYVARLIST tyvarlist,TYCON tycon,_,TY (ty,tyvarset)],opts) => 
     TYPDESC[(rev tyvarlist,tycon,SOME (ty,tyvarset))]
 | _ => raise ActionError 263,

(*         ((DATREPLDESC DATAHEADER :datatype LONGTYCON)) *)

                   fn ([DATAHDR(tyvars,tycon),_,LONGTYCON longtycon],opts) =>
              DATREPLDESC(tyvars,tycon,longtycon)
 | _ => raise ActionError 264,

(* ; Needs a value environment	  *)
(* 	((DATDESC DATDESC1))  *)

                   fn ([DATDESC1(d,pVE,pTE)],opts) =>
		  DATDESC([d],pVE,pTE)
 | _ => raise ActionError 265,

(* 	((DATDESC DATDESC :and DATDESC1))  *)

                   fn ([DATDESC(l,pVE,pTE),_,DATDESC1(d,pVE',pTE')],opts) =>
  (check_disjoint_datdesc(opts,d,l);
   DATDESC(d::l, merge_pVEs(opts,pVE,pVE'), merge_pTEs(opts,pTE,pTE')))
 | _ => raise ActionError 266,

(* 	((DATDESC1 DATAHEADER CONDESC)) *)

                   fn ([DATAHDR(tyvarlist,tycon),CONDESC (l,pVE,tyvars)],opts) =>
  (check_tyvar_inclusion(opts,tyvars,tyvarlist);
   DATDESC1((rev tyvarlist,tycon,(rev l)), pVE, make_pTE (tycon,pVE)))
 | _ => raise ActionError 267,

(* 	((CONDESC CONDESC1))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 268,

(* 	((CONDESC CONDESC :vbar CONDESC1))  *)

                   fn ([CONDESC (l,e,tyvars),_,CONDESC ([x],e',tyvars')],opts) => 
  CONDESC(x::l,merge_pVEs(opts,e,e'),Set.union(tyvars,tyvars'))
 | _ => raise ActionError 269,

(* 	((CONDESC1 CONDEF OPTOFTYPE))  *)

                      fn ([VALID con,TY(ty,tyvars)],opts) => 
  CONDESC([(con,SOME ty,get_location opts)],make_pVE con,tyvars)
 | ([VALID con,NULLTYPE],opts) => 
  CONDESC([(con,NONE,get_location opts)],make_pVE con,Set.empty_set)
 | _ => raise ActionError 270,

(* 	((EXDESC EXDESC1))  *)

                   fn ([EXDESC1(excon,ty,marks)],opts) => EXDESC([(excon,ty,marks)],make_pVE(excon))
 | _ => raise ActionError 271,

(* 	((EXDESC EXDESC :and EXDESC1))  *)

                   fn ([EXDESC(l,pVE),_,EXDESC1(excon,ty,marks)],opts) => 
  EXDESC((excon,ty,marks)::l,addNewValId(opts,excon,pVE))
 | _ => raise ActionError 272,

(* 	((EXDESC1 EXCONDEF OPTOFTYPE))  *)

                      fn ([VALID excon,TY(ty,_)],opts) => 
  EXDESC1(excon,SOME ty,get_location opts)
 | ([VALID excon,NULLTYPE],opts) => 
  EXDESC1(excon,NONE,get_location opts)
 | _ => raise ActionError 273,

(* 	((STRDESC STRDESC1))  *)

                   fn ([STRDESC1(strid,e,pE)],opts) => STRDESC([(strid,e)],make_pSE(opts,strid,pE))
 | _ => raise ActionError 274,

(* 	((STRDESC STRDESC :and STRDESC1))  *)

                   fn ([STRDESC(l,pSE),_,STRDESC1(strid,e,pE)],opts) => 
  STRDESC((strid,e)::l,addNewStrId(opts,(strid,pE),pSE))
 | _ => raise ActionError 275,

(* 	((STRDESC1 STRID :colon SIGEXP))  *)

                   fn ([STRID strid,_,SIGEXP(e,(pE,tycons))],opts) => STRDESC1(strid,e,pE)
 | _ => raise ActionError 276,

(* ((SHAREQ SHAREQ1))  *)

                   fn ([x],opts) => x
 | _ => raise ActionError 277,

(* 	((SHAREQ SHAREQ :and SHAREQ1))  *)

                   fn ([SHAREQ l,_,SHAREQ [x]],opts) => SHAREQ(x::l)
 | _ => raise ActionError 278,

(* 	((SHAREQ1 LONGSTRIDEQLIST))  *)

                   fn ([LONGSTRIDLIST l],opts) => SHAREQ[(Absyn.STRUCTUREshareq (rev l),get_location opts)]
 | _ => raise ActionError 279,

(* 	((SHAREQ1 :type LONGTYCONEQLIST))  *)

                   fn ([_, LONGTYCONLIST l],opts) => SHAREQ[(Absyn.TYPEshareq (rev l),get_location opts)]
 | _ => raise ActionError 280,

(* 	((LONGSTRIDEQLIST LONGSTRID :EQUAL LONGSTRID))  *)

                   fn ([LONGSTRID id,_,LONGSTRID id'],opts) => LONGSTRIDLIST[id',id]
 | _ => raise ActionError 281,

(* 	((LONGSTRIDEQLIST LONGSTRIDEQLIST :EQUAL LONGSTRID))  *)

                   fn ([LONGSTRIDLIST l,_,LONGSTRID id],opts) => LONGSTRIDLIST(id::l)
 | _ => raise ActionError 282,

(* 	((LONGTYCONEQLIST LONGTYCON :EQUAL LONGTYCON))  *)

                   fn ([LONGTYCON tycon,_,LONGTYCON tycon'],opts) => LONGTYCONLIST[tycon',tycon]
 | _ => raise ActionError 283,

(* 	((LONGTYCONEQLIST LONGTYCONEQLIST :EQUAL LONGTYCON))  *)

                   fn ([LONGTYCONLIST l,_,LONGTYCON tycon],opts) => LONGTYCONLIST(tycon::l)
 | _ => raise ActionError 284,

(* 	((FUNDEC1PLUS FUNDEC1))  *)

                   fn ([FUNBIND(fbind,pF)],opts) => FUNDEC([Absyn.FUNBIND fbind],pF)
 | _ => raise ActionError 285,

(* 	((FUNDEC1PLUS FUNDEC1PLUS FUNDEC1))  *)

                   fn ([FUNDEC(l,pF),FUNBIND(fbind,pF')],opts) => FUNDEC((Absyn.FUNBIND fbind)::l,PE.augment_pF(pF,pF'))
 | _ => raise ActionError 286,

(* 	((FUNDEC1 :functor FUNBIND))  *)

                   fn ([_,fbind as FUNBIND(f,pF)],opts) => (extend_pF pF; fbind)
 | _ => raise ActionError 287,

(* 	((FUNBIND FUNBIND1))  *)

                   fn ([FUNBIND1(fbind,funid,pE)],opts) =>
FUNBIND([fbind],make_pF(funid,pE))
 | _ => raise ActionError 288,

(* 	((FUNBIND FUNBIND :and FUNBIND1))  *)

                   fn ([FUNBIND(l,pF),_,FUNBIND1(fbind,funid,pE)],opts) =>
FUNBIND (fbind::l,addNewFunId(opts,(funid,pE),pF))
 | _ => raise ActionError 289,

(* 	((FUNBIND1 STARTFUNBIND1 SIGBINDER SIGEXP :EQUAL STREXP))  *)

                  fn ([STARTFUNBIND1(funid,pE,strid,sigexp,pE'),BOOL abs,SIGEXP(sigexp',(pE'',tycons)),_,STREXP(strexp,pE''')],opts) =>
          (set_pE pE;
           FUNBIND1((funid,
                     strid,
                     sigexp,
                     Absyn.CONSTRAINTstrexp (strexp,sigexp',abs,ref false,get_location opts),
                     NONE,
                     make_funbind_info(opts,funid),
                     ref false,
                     get_location opts,
                     if generate_moduler opts then SOME (ref(Absyn.nullDebuggerStr)) else NONE,
                     if generate_moduler opts then SOME (ref(NONE)) else NONE),
           funid,pE''))
 | _ => raise ActionError 290,

(* 	((FUNBIND1 STARTFUNBIND1 :EQUAL STREXP))  *)

             fn ([STARTFUNBIND1(funid,pE,strid,sigexp,pE'),_,STREXP(strexp,pE''')],opts) =>
     (set_pE pE;
      FUNBIND1((funid,
                strid,
                sigexp,
                strexp,
                NONE,
                make_funbind_info (opts,funid),
                ref false,
                get_location opts,
                if generate_moduler opts then SOME (ref (Absyn.nullDebuggerStr)) else NONE,
                if generate_moduler opts then SOME (ref (NONE)) else NONE),
      funid,pE'''))
 | _ => raise ActionError 291,

(* 	((FUNBIND1 STARTFUNBIND2 SIGBINDER SIGEXP :EQUAL STREXP))  *)

                      fn ([STARTFUNBIND2(funid,pE,spec,pE'),BOOL abs,SIGEXP(sigexp,(pE'',tycons)),_,STREXP(strexp,pE''')],opts) =>
(set_pE pE;do_derived_funbind (opts,funid,spec,NONE,Absyn.CONSTRAINTstrexp (strexp,sigexp,abs,ref false,get_location opts),pE''))
 | _ => raise ActionError 292,

(* 	((FUNBIND1 STARTFUNBIND2 :EQUAL STREXP))  *)

                      fn ([STARTFUNBIND2(funid,pE,spec,pE'),_,STREXP(strexp,pE''')],opts) =>
(set_pE pE;do_derived_funbind (opts,funid,spec,NONE,strexp,pE'''))
 | _ => raise ActionError 293,

(* 	((STARTFUNBIND1 FUNIDBIND :lpar STRID :colon SIGEXP :rpar))  *)

                   fn ([FUNIDBIND (funid,pE),_,STRID strid,_,SIGEXP(sigexp,(pE',tycons)),_],opts) =>
(extend_pSE(make_pSE(opts,strid,pE'));STARTFUNBIND1(funid,pE,strid,sigexp,pE'))
 | _ => raise ActionError 294,

(* 	((STARTFUNBIND2 FUNIDBIND :lpar SPEC :rpar))  *)

                   fn ([FUNIDBIND (funid,pE),_,SPEC(spec,(pE',tycons)),_],opts) => 
(extend_pE pE'; STARTFUNBIND2(funid,pE,spec,pE'))
 | _ => raise ActionError 295,

(*         ((FUNIDBIND FUNID))  *)

                   fn ([FUNID funid],opts) => FUNIDBIND(funid,get_current_pE())
 | _ => raise ActionError 296,

(* ;       ((TOPDEC))  *)

(* ; ;# fn ([],opts) => TOPDEC (Absyn.STRDECtopdec(Absyn.SEQUENCEstrdec [],get_location opts),PE.empty_pB) *)

(*         ((TOPDEC STRDEC1PLUS))  *)

                   fn ([STRDEC(strdec,pE)],opts) => TOPDEC (Absyn.STRDECtopdec(strdec,get_location opts),pE_in_pB pE)
 | _ => raise ActionError 297,

(*         ((TOPDEC SIGDEC1PLUS))  *)

                   fn ([SIGDEC(l,pG)],opts) => TOPDEC (Absyn.SIGNATUREtopdec (rev l,get_location opts),pG_in_pB pG)
 | _ => raise ActionError 298,

(*         ((TOPDEC FUNDEC1PLUS))  *)

                   fn ([FUNDEC(l,pF)],opts) => TOPDEC (Absyn.FUNCTORtopdec(rev l,get_location opts),pF_in_pB pF)
 | _ => raise ActionError 299,

(*          ((TOPDEC EXP))  *)

                   fn ([EXP(exp,tyvars)],opts) =>
   TOPDEC (Derived.make_it_strdec(exp,tyvars,get_location opts,get_current_pE()),PE.empty_pB)
 | _ => raise ActionError 300,

(*          ((TOPDEC :require :string))  *)

                   fn ([_,STRING s],opts) => TOPDEC (Absyn.REQUIREtopdec (s, get_location opts),PE.empty_pB)
 | _ => raise ActionError 301,

(*          ((TOPDEC1 TOPDEC)) *)

                   fn ([TOPDEC x],opts) => raise FoundTopDec x
 | _ => raise ActionError 302,

(*          ((PROGRAM TOPDEC1 DECSEP PROGRAM))  *)

                   fn ([x,_,_],opts) => x
 | _ => raise ActionError 303,

(*          ((PROGRAM DECSEP PROGRAM))  *)

                   fn ([_,x],opts) => x
 | _ => raise ActionError 304,

(*         ((PROGRAM TOPDEC1 DECSEP))  *)

                   fn ([x,_],opts) => x
 | _ => raise ActionError 305,

(*         ((PROGRAM DECSEP))  *)

                   fn ([_],opts) => raise (FoundTopDec (Absyn.STRDECtopdec(Absyn.SEQUENCEstrdec [],get_location opts),PE.empty_pB))
 | _ => raise ActionError 306,

(* ;; New bit - this clause is at the end of the file to ensure correct *)
(* ;; handling of ambiguity. *)
(* ((DECSEP))  *)

                   fn ([],opts) => DUMMY
 | _ => raise ActionError 307,

(* 	))  *)

(* (setq parsergen::*simple-resolutions*  *)
(*   '(;; associativity of tupling  *)
(* 	((:reduce (tytuple tytuple star ty))  *)
(* 	 (:shift (ty ty :arrow ty)))  *)

(* 	((:reduce (tytuple ty star ty))  *)
(* 	 (:shift (ty ty :arrow ty)))  *)

(* 	((:shift (tytuple ty star ty))  *)
(* 	 (:reduce (ty ty :arrow ty)))  *)

(* 	;; always make a tuple before a type  *)
(* 	((:shift (tytuple tytuple star ty))  *)
(* 	 (:reduce (ty tytuple)))  *)

(* 	((:shift (ty ty longtycon))  *)
(* 	 (:reduce (pat pat :colon ty))) *)

(* 	((:shift (ty ty longtycon)) *)
(* 	 (:reduce (exp exp :colon ty))) *)

(* 	((:shift (ty ty longtycon)) *)
(* 	 (:reduce (optoftype :of ty))) *)

(* 	((:shift (ty ty longtycon)) *)
(* 	 (:reduce (longtypbind1 tyvarseq longtycon :equal ty))) *)

(* 	((:shift (ty ty longtycon)) *)
(* 	 (:reduce (typbind1 tyvarseq tycon :equal ty))) *)

(* 	;; matches go far to the left  *)
(* 	((:shift (match match :vbar mrule))  *)
(* 	 (:reduce (exp exp :handle match)))  *)

(* 	((:shift (match match :vbar mrule))  *)
(* 	 (:reduce (exp :fn match)))  *)

(* 	((:shift (match match :vbar mrule))  *)
(* 	 (:reduce (exp :case exp :of match)))  *)

(* 	;; semicolons,strdecs and decs  *)
(* 	;; Reduce decs to strdecs wherever possible  *)
(* 	((:reduce (strdec decsep))  *)
(*          (:reduce (dec decsep)))  *)

(* 	((:reduce (strdec1 dec1)) *)
(* 	 (:reduce (decsep))) *)

(* 	((:shift (strdec1plus0 strdec1 strdec1))  *)
(* 	 (:reduce (strdec1plus strdec1))) *)

(* 	((:shift (strdec1plus0 strdec1plus0 strdec1))  *)
(* 	 (:reduce (strdec1plus strdec1plus0))) *)

(* 	((:shift (symlist symlist sym))  *)
(* 	 (:reduce (dec1 :nonfix symlist)))  *)

(* 	((:shift (symlist symlist sym))  *)
(* 	 (:reduce (dec1 :infixr symlist)))  *)

(* 	((:shift (symlist symlist sym))  *)
(* 	 (:reduce (dec1 :infixr :integer symlist)))  *)


(* 	((:shift (longidlist longidlist :longid))  *)
(* 	 (:reduce (dec1 :open longidlist)))  *)

(* 	((:shift (symlist symlist sym))  *)
(* 	 (:reduce (dec1 :infix symlist)))  *)


(* 	((:shift (symlist symlist sym))  *)
(* 	 (:reduce (dec1 :infix :integer symlist)))  *)

(* 	((:reduce (sigidlist sigid)) *)
(* 	 (:reduce (sigexp sigid))) *)

(* ;; self conflicts  *)
(* 	((:reduce (tytuple ty star ty))  *)
(* 	 (:shift (tytuple ty star ty)))  *)

(* 	((:shift (ty ty :arrow ty))  *)
(*          (:reduce (ty ty :arrow ty)))  *)

(* 	((:reduce (exp exp :andalso exp))  *)
(*          (:shift (exp exp :andalso exp)))  *)

(* 	((:reduce (exp exp :orelse exp))  *)
(*          (:shift (exp exp :orelse exp)))  *)

(* 	((:reduce (program topdec1 decsep)) *)
(* 	 (:reduce (topdec))) *)

(* 	((:shift (program topdec1 decsep program)) *)
(* 	 (:reduce (topdec))) *)

(* 	((:shift (program topdec1 program)) *)
(* 	 (:reduce (topdec))) *)

(* 	((:reduce (program topdec1))  *)
(* 	 (:reduce (topdec))) *)
(*  	))  *)

(* (setq parsergen::*complex-resolutions*  *)
(*   '((((:reduce (atpat opvardef))(:shift (pat opvardef opttype :as pat)))  *)
(*       (:funcall ifinfixinput (:reduce (atpat opvardef)) :shift)  *)
(*       (:colon (:resolve (:reduce (atpat opvardef)) :shift)))  *)

(*     (((:shift (pat oplongvar atpat))(:reduce (atpat oplongvar)))  *)
(*      (:funcall ifinfixinput (:reduce (atpat oplongvar)) :shift))  *)

(*     (((:shift (pat opvardef atpat))(:reduce (atpat opvardef)))  *)
(*      (:funcall ifinfixinput (:reduce (atpat opvardef)) :shift))  *)

(*     (((:reduce (infexp appexp))(:shift (appexp appexp atexp)))  *)
(*      (:funcall ifinfixinput (:reduce (infexp appexp))(:shift (appexp appexp atexp))))  *)

(*     (((:reduce (pat atpat))(:shift (fval :lpar atpat vardef atpat :rpar opttype :equal exp)))  *)
(*      (:funcall ifinfixinput (:reduce (pat atpat)) :shift))  *)

(*     (((:reduce (atpat opvardef))(:shift (fval opvardef atpatlist opttype :equal exp)))  *)
(*      (:funcall ifinfixinput (:reduce (atpat opvardef)) :shift))  *)

(*     (((:reduce (atpat1 bin_atpat))(:shift (fval bin_atpat atpatlist opttype :equal exp)))  *)
(*      (:funcall ifinfixinput (:reduce (atpat1 bin_atpat)):shift))  *)

(*     (((:reduce (pat atpat)) (:shift (bin_atpat :lpar atpat patvar atpat :rpar)))  *)
(*      (:funcall ifinfixinput :shift (:reduce (pat atpat))))  *)

(*     ;; problems with type tuples  *)
(*     (((:reduce (tytuple ty star ty)) (:shift (ty ty longtycon)))  *)
(*      (:funcall ifstarinput (:reduce (tytuple ty star ty)) :shift))  *)
(*     (((:reduce (tytuple tytuple star ty)) (:shift (ty ty longtycon)))  *)
(*      (:funcall ifstarinput (:reduce (tytuple tytuple star ty)) :shift))  *)
(*      *)
(*     ;; precedences  *)
(*     (((:reduce (pat pat var pat)) (:shift (pat pat var pat)))  *)
(*      (:funcall ifleftassoc (:reduce (pat pat var pat)) :shift))  *)
(*     (((:reduce (infexp infexp infvar infexp)) (:shift (infexp infexp infvar infexp)))  *)
(*      (:funcall ifleftassoc (:reduce (infexp infexp infvar infexp)) :shift))  *)
(*      *)
(*     ;; reduce-reduce conflicts  *)
(*     (((:reduce (vardef :longid)) (:reduce (longvar :longid))) *)
(*      (:funcall ifvarstack (:reduce (vardef :longid)) (:reduce (longvar :longid)))) *)
(*      *)
(*     (((:reduce (star :longid)) (:reduce (longtycon :longid)))  *)
(*      (:funcall ifstarstack (:reduce (star :longid)) (:reduce (longtycon :longid))))  *)
(*     ))  *)

(* (defun test ()  *)
(*   (parsergen::make-parsing-tables *mlg* ))  *)

(* (defun make-it ()  *)
(*   (compile-file "grammar.lisp" :load t)  *)
(*   (test))  *)

(* ;(op-parser::makeit)  *)
(* Do not delete this line 2 *)
fn _ => DUMMY
]

fun get_function n =
  MLWorks.Internal.Array.sub (actions,n)

type FinalValue = Absyn.TopDec

exception FinalValue

val dummy = DUMMY
fun get_final_value (TOPDEC x) = x
  | get_final_value _ = raise FinalValue

(* ambiguity resolution functions *)

(* ifInfixInput, ifVarStack, ifStarStack,ifStarInput,ifLeftAssoc *)
(* functions are of form action(s) stack_value list * stack_value => action *)

exception ResolveError of string

(* if the input symbol is an infix operator then do act1 else act2 *)
fun ifInfixInput _ (act1,act2, [], LONGID ([],s)) =
  (debug ("Checking infix for " ^ Symbol.symbol_name s);
   if is_infix s then act1 else act2)
  | ifInfixInput _ (act1,act2,[], EQVAL) =
  (debug "Checking infix for =";
   if is_infix equal_symbol then act1 else act2)
  | ifInfixInput _ (act1,act2,_,_) = act2

(* if the LongId on the stack is a short variable, do first action else 
   its a constructor and (if in sml'90 mode) do the second action *)
fun ifVarStack oldDefinition (varred,conred,[LONGID (id as ([],s))],_) =
  (case lookupValId id of
     SOME (Ident.VAR _) => varred
   | SOME (Ident.CON _) => if oldDefinition then conred else varred
   | SOME _ => conred
   | NONE => varred)
  | ifVarStack _ (_,conred,_,_) = conred

(* if the symbol on top of the stack is a star, do the first action *)
fun ifStarStack _ (starred,tyconred,[LONGID (id as ([],s))],_) =
  if Symbol.eq_symbol(s,asterisk_symbol) then starred else tyconred
  | ifStarStack _ (starred,tyconred,_,_) = tyconred

(* if the current input symbol is a star then do the first action *)
fun ifStarInput _ (staract,otheract,[],LONGID ([],s)) =
  if Symbol.eq_symbol(s,asterisk_symbol) then staract else otheract
  | ifStarInput _ (_,otheract,_,_) = otheract

fun get_precedence s =
  case PE.lookupFixity (s, !ref_pE) of
    PE.LEFT n => n
  | PE.RIGHT n => n
  | _ => 0
(*  | _ => Crash.impossible ("No fixity for infix symbol " ^ Symbol.symbol_name s) *)

fun associate_left s = 
  case PE.lookupFixity (s, !ref_pE) of
    PE.LEFT n => true
  | PE.RIGHT n => false
  | _ => false
(*  | _ => Crash.impossible "No fixity for infix symbol"  *)

(* return true if the two symbols associate to the left *)
fun get_associativity(old_definition, s1, s2) =
  ((*debug ("Comparing " ^ Symbol.symbol_name s1 ^ " and " ^ Symbol.symbol_name s2);*)
   if Symbol.eq_symbol(s1,s2)
    then associate_left s1
  else
    let
      val p1 = get_precedence s1
      val p2 = get_precedence s2
    in
      if p1 <> p2 then
	p1 > p2
      else
        if  old_definition then true
        else associate_left s1 (* New standard says use the associativity of the left hand operator *)
    end)

(* Do act1 if the symbol 2 down in the stack and the current input
   symbol associate to the left, otherwise act2 *)

fun ifLeftAssoc old_definition (act1,act2,[LONGVALID (lvalid,_),_], LONGID ([],s)) =
  let
    val Ident.LONGVALID (_,valid) = lvalid
  in
    if get_associativity (old_definition, get_sym valid, s) then act1 else act2
  end
  | ifLeftAssoc old_definition (act1,act2, [LONGVALID (lvalid,_),_], EQVAL) =
    let
      val Ident.LONGVALID (_,valid) = lvalid
    in
      if get_associativity (old_definition, get_sym valid,equal_symbol) then act1 else act2
    end
  | ifLeftAssoc _ (act1,act2,[LONGVALID (lvalid,_),_], _) = act1
  | ifLeftAssoc _ _ = raise ResolveError "Error in precedence"

type Act = LRbasics.Action
val resolutions  : (bool -> Act * Act * Parsed_Object list * Parsed_Object -> Act) MLWorks.Internal.Array.array =
  MLWorks.Internal.Array.arrayoflist[ifInfixInput,  (* 0, arity 0 *)
                    ifVarStack,    (* 1, arity 1 *)
                    ifStarStack,   (* 2, arity 1 *)
                    ifStarInput,   (* 3, arity 0 *)
                    ifLeftAssoc    (* 4, arity 2 *)
                    ]
                    
(*
MLWorks.Internal.Array.arrayoflist[
(* 0 *) sort_infexp (LRbasics.Reduce (1,LRbasics.INFEXP,27)), 
(* 1 *) sort_pat_prec (LRbasics.Reduce (3,LRbasics.INFEXP,28)),
(* 2 *) sort_patcon (LRbasics.Reduce (1,LRbasics.VARDEF,167), LRbasics.Reduce (1,LRbasics.LONGVAR,155)),
(* 3 *) sort_pat_prec (LRbasics.Reduce (3,LRbasics.PAT,131)),
(* 4 *) sort_out_asterisk (LRbasics.Reduce (1,LRbasics.STAR,177), LRbasics.Reduce (1,LRbasics.LONGTYCON,158)),
(* 5 *) sort_infexp (LRbasics.Reduce (1,LRbasics.ATPAT1,119)),
(* 6 *) sort_infexp (LRbasics.Reduce (1,LRbasics.ATPAT,108)),
(* 7 *) sort_infixfun (LRbasics.Reduce (1,LRbasics.PAT,129)),
(* 8 *) ifStarInput (LRbasics.Reduce(3,LRbasics.TYTUPLE,146),LRbasics.Shift),
(* 9 *) ifStarInput (LRbasics.Reduce(3,LRbasics.TYTUPLE,147),LRbasics.Shift)
]
*)

fun get_resolution (n, Options.OPTIONS{compat_options =
                                       Options.COMPATOPTIONS{old_definition, ...}, ...}) =
  MLWorks.Internal.Array.sub(resolutions,n) old_definition

exception UnexpectedIgnore

fun token_to_parsed_object (weak_tyvars, token) =
  case token of
    Token.RESERVED (x) =>
      (case x of
           Token.ABSTYPE => (LRbasics.ABSTYPE,DUMMY)
         | Token.ABSTRACTION => (LRbasics.ABSTRACTION,DUMMY)
         | Token.AND => (LRbasics.AND,DUMMY)
         | Token.ANDALSO => (LRbasics.ANDALSO,DUMMY)
         | Token.AS => (LRbasics.AS,DUMMY)
         | Token.CASE => (LRbasics.CASE,DUMMY)
         | Token.DO => (LRbasics.DO,DUMMY)
         | Token.DATATYPE => (LRbasics.DATATYPE,DUMMY)
         | Token.ELSE => (LRbasics.ELSE,DUMMY)
         | Token.END => (LRbasics.END,DUMMY)
         | Token.EXCEPTION => (LRbasics.EXCEPTION,DUMMY)
         | Token.FN => (LRbasics.FN,DUMMY)
         | Token.FUN => (LRbasics.FUN,DUMMY)
         | Token.HANDLE => (LRbasics.HANDLE,DUMMY)
         | Token.IF => (LRbasics.IF,DUMMY)
         | Token.IN => (LRbasics.IN,DUMMY)
         | Token.INFIX => (LRbasics.INFIX,DUMMY)
         | Token.INFIXR => (LRbasics.INFIXR,DUMMY)
         | Token.LET => (LRbasics.LET,DUMMY)
         | Token.LOCAL => (LRbasics.LOCAL,DUMMY)
         | Token.NONFIX => (LRbasics.NONFIX,DUMMY)
         | Token.OF => (LRbasics.OF,DUMMY)
         | Token.OP => (LRbasics.OP,DUMMY)
         | Token.OPEN => (LRbasics.OPEN,DUMMY)
         | Token.ORELSE => (LRbasics.ORELSE,DUMMY)
         | Token.RAISE => (LRbasics.RAISE,DUMMY)
         | Token.REC => (LRbasics.REC,DUMMY)
         | Token.REQUIRE => (LRbasics.REQUIRE,DUMMY)
         | Token.THEN => (LRbasics.THEN,DUMMY)
         | Token.TYPE => (LRbasics.TYPE,DUMMY)
         | Token.VAL => (LRbasics.VAL,DUMMY)
         | Token.WITH => (LRbasics.WITH,DUMMY)
         | Token.WITHTYPE => (LRbasics.WITHTYPE,DUMMY)
         | Token.WHERE => (LRbasics.WHERE,DUMMY)
         | Token.WHILE => (LRbasics.WHILE,DUMMY)
         | Token.EQTYPE => (LRbasics.EQTYPE,DUMMY)
         | Token.FUNCTOR => (LRbasics.FUNCTOR,DUMMY)
         | Token.INCLUDE => (LRbasics.INCLUDE,DUMMY)
         | Token.SHARING => (LRbasics.SHARING,DUMMY)
         | Token.SIG => (LRbasics.SIG,DUMMY)
         | Token.SIGNATURE => (LRbasics.SIGNATURE,DUMMY)
         | Token.STRUCT => (LRbasics.STRUCT,DUMMY)
         | Token.STRUCTURE => (LRbasics.STRUCTURE,DUMMY)
         | Token.LPAR => (LRbasics.LPAR,DUMMY)
         | Token.RPAR => (LRbasics.RPAR,DUMMY)
         | Token.BRA => (LRbasics.BRA,DUMMY)
         | Token.KET => (LRbasics.KET,DUMMY)
         | Token.LBRACE => (LRbasics.LBRACE,DUMMY)
         | Token.RBRACE => (LRbasics.RBRACE,DUMMY)
         | Token.COMMA => (LRbasics.COMMA,DUMMY)
         | Token.COLON => (LRbasics.COLON,DUMMY)
         | Token.ABSCOLON => (LRbasics.ABSCOLON,DUMMY)
         | Token.SEMICOLON => (LRbasics.SEMICOLON,DUMMY)
         | Token.ELLIPSIS => (LRbasics.ELLIPSIS,DUMMY)
         | Token.UNDERBAR => (LRbasics.UNDERBAR,DUMMY)
         | Token.VBAR => (LRbasics.VBAR,DUMMY)
         | Token.EQUAL => (LRbasics.EQUAL,EQVAL)
         | Token.DARROW => (LRbasics.DARROW,DUMMY)
         | Token.ARROW => (LRbasics.ARROW,DUMMY)
         | Token.HASH => (LRbasics.HASH,DUMMY)
         | Token.MAGICOPEN =>  (LRbasics.MAGICOPEN,DUMMY))
  | Token.EOF _ => (LRbasics.EOF,DUMMY)
  | Token.INTEGER s => (LRbasics.INTEGER,INTEGER s)
  | Token.REAL s => (LRbasics.REAL,REAL s)
  | Token.STRING s => (LRbasics.STRING, STRING s)
  | Token.CHAR s => (LRbasics.CHAR, CHAR s)
  | Token.WORD s => (LRbasics.WORD, WORD s)
  | Token.LONGID (l,s) => (LRbasics.LONGID,LONGID (l,s))
  | Token.TYVAR t =>
      if weak_tyvars then
	let
	  val (sy, eq, imp) = t
	  val string = Symbol.symbol_name sy
	  val len = size string
	  val weak =
	    if len <= 1 orelse (eq andalso len <= 2) then
	      false
	    else
	      let
		val weak_char =
		  MLWorks.String.ordof(string, if eq then 2 else 1)
	      in
		ord #"1" <= weak_char andalso ord #"9" >= weak_char
	      end
	in
	  (LRbasics.TYVAR, TYVAR (Ident.TYVAR(if weak then (sy, eq, true) else t)))
	end
      else
	(LRbasics.TYVAR, TYVAR (Ident.TYVAR t))
  | Token.IGNORE => raise UnexpectedIgnore

end;
