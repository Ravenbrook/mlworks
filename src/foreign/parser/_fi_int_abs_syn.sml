(*
 * Foreign Interface parser: internal abstract syntax.
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: _fi_int_abs_syn.sml,v $
 * Revision 1.2  1997/08/22 10:30:42  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "$.basis.__int";
require "$.basis.__real";
require "$.basis.__char";
require "$.basis.__word";
require "fi_abs_syntax";
require "fi_int_abs_syn";

(* FI Internal Abstract Syntax:
   Extra structures and function used for constructing abstract syntax *)

functor FIIntAbsSyn (structure FIAbsSyntax : FI_ABS_SYNTAX) : FI_INT_ABS_SYN =
  struct

    structure FIAbsSyntax = FIAbsSyntax

    open FIAbsSyntax

    (* Information for making new types from simpler ones *)
    datatype type_info =
      NO_TYPE_INFO
    | AS_POINTER of type_info
    | AS_ARRAY of 
        {dimensions: FIAbsSyntax.expression option, elemTypeInfo: type_info}
    | AS_FUNCTION of
        {returnTypeInfo : type_info,
         params: {name : string option,
                  paramType : FIAbsSyntax.types} list }

    val insertTypeInfo = fn (a, b) =>
      let
        fun ins NO_TYPE_INFO = b
          | ins (AS_POINTER a') = AS_POINTER (ins a')
          | ins (AS_ARRAY {dimensions, elemTypeInfo}) =
              AS_ARRAY{dimensions=dimensions, elemTypeInfo=ins elemTypeInfo}
          | ins (AS_FUNCTION {returnTypeInfo, params}) =
              AS_FUNCTION{returnTypeInfo=ins returnTypeInfo, params=params}
      in ins a end

    fun makeSignedType INT = INT
      | makeSignedType CHAR = CHAR
      | makeSignedType SHORT = SHORT
      | makeSignedType LONG = LONG
      | makeSignedType (ILLEGAL_TYPE s) = ILLEGAL_TYPE s
      | makeSignedType _ = ILLEGAL_TYPE "can't make signed"

    fun makeUnsignedType INT = UNS_INT
      | makeUnsignedType CHAR = UNS_CHAR
      | makeUnsignedType SHORT = UNS_SHORT
      | makeUnsignedType LONG = UNS_LONG
      | makeUnsignedType (ILLEGAL_TYPE s) = ILLEGAL_TYPE s
      | makeUnsignedType _ = ILLEGAL_TYPE "can't make unsigned"

    fun makeLongType INT = LONG
      | makeLongType UNS_INT = UNS_LONG
      | makeLongType (ILLEGAL_TYPE s) = ILLEGAL_TYPE s
      | makeLongType _ = ILLEGAL_TYPE "can't make long"

    fun makeShortType INT = SHORT
      | makeShortType UNS_INT = UNS_SHORT
      | makeShortType (ILLEGAL_TYPE s) = ILLEGAL_TYPE s
      | makeShortType _ = ILLEGAL_TYPE "can't make short"

    fun makeType (t, ti) =
      let
        fun modify NO_TYPE_INFO = t
          | modify (AS_POINTER i) = POINTER (modify i)
          | modify (AS_ARRAY{dimensions, elemTypeInfo}) =
              ARRAY{elemType= modify elemTypeInfo, dimensions = dimensions}
          | modify (AS_FUNCTION {returnTypeInfo, params}) =
              FUNCTION{returnType = modify returnTypeInfo, params = params}
      in
        modify ti
      end

    fun makeField (t, {name, typeInfo}) =
      FIELD{name = name, fieldType = makeType(t, typeInfo)}

    fun makeDeclaration (theType, {name, typeInfo}) =
          ID_DECL{name = name,
                  idType = makeType (theType, typeInfo) }

    fun makeTypedef (ty, {name, typeInfo}) =
          TYPE_DEF{oldType = makeType(ty, typeInfo), newName = name}

    fun makeConst (ty, {name, typeInfo}, v) =
          CONSTANT_DECL{name = name,
                        value = v,
                        valueType = makeType(ty, typeInfo) }

  end
