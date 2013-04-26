(*  ==== FI EXAMPLES : Regular expression parser ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides ML functions to parse regular expressions, using
 *  the foreign functions defined in regexp.c.
 *
 *  Revision Log
 *  ------------
 *  $Log: regexp.sml,v $
 *  Revision 1.3  1996/11/06 14:02:55  brianm
 *  Fixing samples.
 *
 *  Revision 1.2  1996/10/25  13:26:47  io
 *  update for naming conventions
 *
 *  Revision 1.1  1996/08/30  10:55:28  davids
 *  new unit
 *
 *
 *)

require "$.foreign.__interface";


local

  structure Store = Interface.Store
  structure CStructure = Interface.C.Structure
  structure CSignature = Interface.C.Signature
  structure CFunction = Interface.C.Function
  structure CType = Interface.C.Type
  structure CValue = Interface.C.Value

  (* The maximum string length allowed in the regular expression or string
   to search. *)

  val maxLength = 1000;


  (* Loading a Structure *)
  val regexpStruct = 
    CStructure.loadObjectFile ("foreign/samples/regexp.so", CStructure.IMMEDIATE_LOAD)
   (* the filename is relative to the current directory that MLWorks is using *)


  (* Defining a c_signature object *)

  val regexpSig = CSignature.newSignature ();


  (* Adding signature entries *)
    
  val _ = 
    CSignature.defEntry (regexpSig,
			  CSignature.FUN_DECL 
			    {name   = "regexp_search",
		             source = [CType.STRING_TYPE {length = maxLength}, 
				       CType.STRING_TYPE {length = maxLength}],
			     target = CType.INT_TYPE })

  val _ = 
    CSignature.defEntry (regexpSig,
			  CSignature.FUN_DECL 
			    {name   = "get_rest",
			     source = [],
			     target = CType.STRING_TYPE {length = maxLength} })

  val _ = 
    CSignature.defEntry (regexpSig,
			  CSignature.FUN_DECL 
			    {name   = "get_match",
			     source = [],
			     target = CType.STRING_TYPE {length = maxLength} })

  val _ = 
    CSignature.defEntry (regexpSig,
			  CSignature.FUN_DECL 
			    {name   = "get_error",
			     source = [],
			     target = CType.INT_TYPE })


  (* Make a `callable object' lookup function for our foreign code *)
    
  val regexpFF = 
    CFunction.defineForeignFun (regexpStruct, regexpSig)
    

  (* Extract foreign function objects as ML values *) 
    
  val regexpSearchFF = regexpFF "regexp_search"

  val getRestFF = regexpFF "get_rest"

  val getMatchFF = regexpFF "get_match"

  val getErrorFF = regexpFF "get_error"


  (* Building a store *)

  val regexpStore =
    Store.store {alloc    = Store.ALIGNED_4,
		 overflow = Store.BREAK,
		 size     = maxLength * 10 + 20,
		 status   = Store.RDWR_STATUS}


  (* Create objects. *)

  val stringObject1 = 
    CValue.object {ctype = CType.STRING_TYPE {length = maxLength},
  		   store = regexpStore}

  val stringObject2 = 
    CValue.object {ctype = CType.STRING_TYPE {length = maxLength},
		   store = regexpStore}

  val stringObject3 = 
    CValue.object {ctype = CType.STRING_TYPE {length = maxLength},
  		   store = regexpStore}

  val stringObject4 = 
    CValue.object {ctype = CType.STRING_TYPE {length = maxLength},
		   store = regexpStore}

  val intObject1 =
    CValue.object {ctype = CType.INT_TYPE,
		   store = regexpStore}

  val intObject2 =
    CValue.object {ctype = CType.INT_TYPE,
		   store = regexpStore}

  val voidObject =
    CValue.object {ctype = CType.VOID_TYPE,
		   store = regexpStore}

in
  (* This could be flaky, give it maxLength arguments for the time being *)
  fun regexpSearch (string, regexpString) =
    (CValue.setString (stringObject1, string);
     CValue.setString (stringObject2, regexpString);
     print (CValue.getString (stringObject1) ^ "\n");
     print (CValue.getString (stringObject2) ^ "\n");	    
     CFunction.call regexpSearchFF ([stringObject1, stringObject2],
				    intObject1);
     CFunction.call getErrorFF ([], intObject2);
     if CValue.getInt (intObject2) <> 0 then
       raise Fail "Error in parsing regular expression.\n"
     else
       case CValue.getInt (intObject1) of
	 0 => NONE
       | x => (CFunction.call getRestFF ([], stringObject3);
	       CFunction.call getMatchFF ([], stringObject4);
	       SOME (CValue.getString stringObject3,
		     CValue.getString stringObject4)))

  (* A quick example -

          regexpSearch ("abcdefghijk", "def");

     The first argument is a string to be searched and the second argment
     is a UNIX style regular expression.  In the above example, this is simply
     a substring.

   *)
   
end
