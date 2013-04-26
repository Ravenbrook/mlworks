(*
 * Foreign Interface parser: Internal abstract syntax
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: fi_int_abs_syn.sml,v $
 * Revision 1.2  1997/08/22 10:27:56  brucem
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)

require "fi_abs_syntax";

(* FI Internal Abstract Syntax:
   Extra structures and function used for constructing abstract syntax *)

signature FI_INT_ABS_SYN =
  sig

    structure FIAbsSyntax : FI_ABS_SYNTAX

    (* Information for making new types from simpler ones *)
    datatype type_info =
      NO_TYPE_INFO
    | AS_POINTER of type_info
    | AS_ARRAY of 
        {dimensions: FIAbsSyntax.expression option, elemTypeInfo: type_info}
    | AS_FUNCTION of
        {returnTypeInfo : type_info,
         params: {name : string option, paramType : FIAbsSyntax.types} list }

    (* insertTypeInfo a b
       Goes through `a' until it finds a NO_TYPE_INFO, and replaces
       this with `b'.  *)
    val insertTypeInfo : type_info * type_info -> type_info

    (* Make a new type using type info *)
    val makeType : FIAbsSyntax.types * type_info -> FIAbsSyntax.types

    (* Make new simple types e.g. unsigned int *)
    val makeSignedType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeUnsignedType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeLongType : FIAbsSyntax.types -> FIAbsSyntax.types
    val makeShortType : FIAbsSyntax.types -> FIAbsSyntax.types

    (* Combine a type and declarator to make a struct/union field *)
    val makeField :
      FIAbsSyntax.types * {name :string, typeInfo :type_info}
      -> FIAbsSyntax.field

    (* Combine type and declarator information to make a declaration *)
    val makeDeclaration :
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info} ->
      FIAbsSyntax.declaration

    (* Combine type and declarator information to make a typedef declaration *)
    val makeTypedef : 
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info } ->
      FIAbsSyntax.declaration

    (* Combine type, declarator and value to make a constant declaration *)
    val makeConst :
      FIAbsSyntax.types *
      {name : string, typeInfo : type_info } *
      FIAbsSyntax.expression ->
      FIAbsSyntax.declaration

  end
