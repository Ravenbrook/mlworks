(* _datatypes.sml the functor *)
(*
$Log: _datatypes.sml,v $
Revision 1.31  1997/05/01 12:53:49  jont
[Bug #30088]
Get rid of MLWorks.Option

 * Revision 1.30  1996/10/04  15:35:44  andreww
 * [Bug #1592]
 * Threading extra level argument through tynames.
 *
 * Revision 1.29  1996/02/23  16:53:31  jont
 * newmap becomes map, NEWMAP becomes MAP
 *
 * Revision 1.28  1996/02/21  17:16:47  jont
 * Removing map in favour of newmap
 *
 * Revision 1.27  1995/12/27  11:24:40  jont
 * Removing Option in favour of MLWorks.Option
 *
Revision 1.26  1995/03/24  16:13:41  matthew
Change tyfun_id etc. to stamp

Revision 1.25  1995/01/17  13:18:29  matthew
Rationalizing debugger

Revision 1.24  1994/06/17  10:44:24  jont
Allow alternative printing of types to include quantifiers

Revision 1.23  1994/05/05  13:26:57  daveb
META_OVERLOADED now includes the overloaded type variable and the location.
Overloaded schemes include the type variable.

Revision 1.22  1994/02/28  05:52:54  nosa
Debugger structures and extra TYNAME valenv for Modules Debugger.

Revision 1.21  1993/11/30  11:04:20  matthew
> Added is_abs field to TYNAME and METATYNAME

Revision 1.20  1993/11/25  09:34:07  nickh
Added code to encode type errors as a list of strings and types.

Revision 1.19  1993/09/22  12:48:10  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.18  1993/07/30  10:45:34  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger;
structure Option.

Revision 1.17  1993/07/06  13:14:30  daveb
Removed exception environments and interfaces.

Revision 1.16  1993/04/06  12:04:32  jont
Added push and pop functions for the id counters

Revision 1.15  1993/03/09  12:53:20  matthew
Str to Structure

Revision 1.14  1993/02/08  11:49:34  matthew
Rationalised substructures

Revision 1.13  1993/02/05  15:07:20  matthew
Added COPYSTR representation of structures

Revision 1.12  1992/12/22  15:19:42  jont
Anel's last changes

Revision 1.11  1992/12/08  14:50:07  jont
Removed a number of duplicated signatures and structures

Revision 1.10  1992/10/27  19:04:52  jont
Modified to use less than functions for maps

Revision 1.9  1992/10/09  14:12:40  clive
Tynames now have a slot recording their definition point

Revision 1.8  1992/10/02  15:58:20  clive
Change to NewMap.empty which now takes < and = functions instead of the single-function

Revision 1.7  1992/08/11  10:55:09  jont
Removed some redundant structure arguments and sharing
Converted where relevant to use NewMap.{forall,exists,iterate}

Revision 1.6  1992/07/30  14:35:39  jont
Anel's changes to use NewMap instead of Map

Revision 1.5  1992/01/24  14:43:43  jont
Updated to allow valenv in METATYNAME

Revision 1.4  1992/01/14  16:23:16  jont
Changed ref unit in valenv to ref int to assist encoder

Revision 1.3  1991/11/21  16:45:11  jont
Added copyright message

Revision 1.2  91/06/17  17:13:00  nickh
Modified to take new ValEnv definition with ref unit to allow
reading and writing of circular data structures.

Revision 1.1  91/06/07  11:35:21  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)

require "../utils/map";
require "../basics/ident";
require "stamp";
require "datatypes";

functor Datatypes (structure Stamp : STAMP
    		   structure Ident : IDENT
    		   structure NewMap : MAP
                  ) : DATATYPES = 
  struct
    structure Ident = Ident
    structure NewMap = NewMap
    structure Stamp = Stamp

    type Stamp= Stamp.Stamp
    type 'a StampMap = 'a Stamp.Map.T

    (****
     OverLoaded is used to indicate the form of the type of the different
     overloaded operations in the type schemes of VE in the initial basis:
        UNARY for num -> num
	BINARY for num * num -> num
	PREDICATE for num * num -> bool
     ****)

    datatype OverLoaded = 
      UNARY of Ident.ValId * Ident.TyVar | 
      BINARY of Ident.ValId * Ident.TyVar |
      PREDICATE of Ident.ValId * Ident.TyVar

    (****
     METASTRNAME is used to name signatures, the names of which can change 
     through sharing.  Initially they point to NULLNAME (unique strname_id).
     ****)

    datatype Strname = 
      STRNAME of Stamp.Stamp | 
      METASTRNAME of Strname ref |
      NULLNAME of Stamp.Stamp

    datatype InstanceInfo = 
      ZERO
    | ONE of int
    | TWO of int * int

    (****
     The different fields in the TYNAME constructor contain the following 
     info for each type name:
        Stamp  --> a unique identifier
	string     --> string which is printed when this type name is printed
	int        --> arity of the type name
	bool ref   --> equality attribute of the type name
	Valenv ref --> Constructor environment, used to find out the ML 
	               type associated with this type name during code 
		       generation. Also to elaborate the set of all
		       constructors for indexing, exhaustiveness etc.
        string     --> string describing the locational information for
                       this datatype

        ...

        int        --> level information for the type name.  See bug
                       1592 fix report, and the documentation
                       .typechecker.levels.doc.tynames, which lives
                       in MLW/design/typechecker_levels.doc


     METATYNAME is used to name flexible types descibed in signature 
     declarations.  They point to type functions because
        o when types are shared their type functions must be the same
        o in a type realisation type names are mapped to type functions
     The string, int, bool ref and Valenv ref fields contain the same info
     as for the TYNAME constructor.
     ****)

    datatype Tyname = 
      TYNAME of (Stamp.Stamp * string * int * bool ref 
                 * Valenv ref * string option * bool ref
                 * Valenv ref * int) |
      METATYNAME of (Tyfun ref * string * int * bool ref * Valenv ref * bool ref)
      (* Valenv ref added for code generator's benefit *)
    
    and Type =

      (****
       METATYVAR is a constructor for implicit type variables used during
       type inference.
	 int         --> level of type variable - used to indicate whether 
	                 the type can be schemified, i.e. closed over.
	 first bool  --> equality attribute
	 second bool --> imperative attribute
       ****)

      METATYVAR of ((int * Type * Instance) ref * bool * bool) |

      (****
       META_OVERLOADED is a constructor for overloaded type variables during
       type inference.  The tyvar is the tyvar ot be instantiated; the type
       is what it's instantiated to.  The valid and location are for errors.
       ****)

      META_OVERLOADED of
	(Type ref * Ident.TyVar * Ident.ValId * Ident.Location.T)|

      (****
       TYVAR is a constructor for explicit type variables.
         int --> level of type variable
       ****)

      TYVAR of ((int * Type * Instance) ref * Ident.TyVar) |

      (****
       METARECTYPE is a constructor for flexible record types.
         int        --> level of flexible record type
         first bool --> indicates whether the flexible record type is 
	                uninstantiated (not all fields are known) or
			instantiated. 
			If the value of this field is true this is an
			uninstantiated flexible rectype with Type a
			rectype containing all the available info in the 
			flexible record type.
			If the value is false Type is a rectype giving the
			rigid rectype or another metarectype if the instance
			of this metarectype is another flexible record type.
	 second bool --> equality attribute
	 third bool  --> imperative attribute
       ****)

      METARECTYPE of ((int * bool * Type * bool * bool) ref) |

      (****
       RECTYPE is the constructor for RecTypes.  It is represented as
       a mapping from labels to Types.
       ****)

      RECTYPE of (Ident.Lab,Type) NewMap.map |

      (****
       FUNTYPE is the constructor for FunTypes with fields for the 
       argument and result types.
       ****)

      FUNTYPE of (Type * Type) |

      (****
       CONSTYPE is the constructor for ConsTypes with fields for the type 
       name and list of types.
       ****)

      CONSTYPE of ((Type list) * Tyname) |

      (****
       DEBRUIJN is the constructor for the place holders for type variables 
       (explicit as well as implicit) in closed over type schemes.
          int         --> identifier for the debruijn variable
	  first bool  --> equality attribute
	  second bool --> imperative attribute
       ****)

      DEBRUIJN of (int * bool * bool 
                   * (int * Type * Instance) ref option) |

      (****
       Initially METATYVARS point to NULLTYPES.  NULLTYPE is replaced with 
       the actual type during type inference.
       ****)

      NULLTYPE
    
    and Tyfun =

      (****
       TYFUN is the constructors for type functions with int indicating
       the arity of the type function.
       ****)

      TYFUN of Type * int |

      (****
       ETA_TYFUN is the constructor for eta-convertable type functions.
       ****)

      ETA_TYFUN of Tyname |

      (****
       METATYNAME is instantiated to NULL_TYFUN for new flexible type
       names.
       ****)

      NULL_TYFUN of Stamp.Stamp * Tyfun ref

    and Typescheme =

      (****
       SCHEME is the constructor for the type scheme generalising the type 
       Type.  
	  int --> arity of Type
       ****)

      SCHEME of (int * (Type * (Instance ref * Instance ref option ref) option)) | 

      (****
       UNBOUND_SCHEME is the type scheme for types without any type 
       variables or for types with type variables which are still to 
       be schemified.
       ****)

      UNBOUND_SCHEME of Type * (Instance ref * Instance ref option ref) option |

      (****
       OVERLOADED_SCHEME is used for the type schemes of overloaded operations
       in the initial basis.
       ****)

      OVERLOADED_SCHEME of OverLoaded

      (****
       Some of the other compound semantic objects.
       ****)

    (* An instance of a type variable; 
       this information is used by the polymorphic debugger; 
       integers are passed around at runtime that point to the particular 
       instance in question *)
    and Instance = 
        INSTANCE of (int * Type * Instance) ref list
      | SIGNATURE_INSTANCE of InstanceInfo
      | NO_INSTANCE

    and Valenv = VE of int ref * ((Ident.ValId,Typescheme) NewMap.map)

      (* unit ref is used for doing `eq' on valenv's for encoding and
       decoding these (circular) data structures *)

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
  
    val empty_valenv = VE (ref 0,NewMap.empty (Ident.valid_lt, Ident.valid_eq))

    (* atoms for a type error message, which is a list of these atoms.
     This is so tyvars in separate types printed in a message match up; see
     Types.print_type_with_seen_tyvars and Completion.report_type_error *)

    datatype type_error_atom =
        Err_String of string
      | Err_Type of Type	(* print a type with remembered tyvars *)
      | Err_Scheme of Type      (* Print a type with quantifiers *)
      | Err_Reset		(* reset remembered tyvars *)

  end
