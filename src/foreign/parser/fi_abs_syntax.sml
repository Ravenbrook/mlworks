(*
 * Foreign Interface parser: Abstract syntax
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: fi_abs_syntax.sml,v $
 * Revision 1.3  1997/08/22 14:58:18  brucem
 * [Bug #30034]
 * Change comment.
 *
 *  Revision 1.2  1997/08/22  10:09:30  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

signature FI_ABS_SYNTAX =
  sig

    datatype field = FIELD of {name : string, fieldType : types}
         and e_field = E_FIELD of {name : string, value : expression option }
         and aggregate_type = STRUCT | UNION
         and types =     (* Types *)
             NAME of string 
           | ILLEGAL_TYPE of string
                    (* for semantic errors, e.g. `signed unsigned' *)
           | SIGNED | INT | CHAR | SHORT | LONG 
           | UNSIGNED| UNS_INT | UNS_CHAR | UNS_SHORT | UNS_LONG
           | FLOAT | DOUBLE | VOID
           | MLW_INT | MLW_WORD | MLW_INT32 | MLW_CHAR | MLW_WORD8
           | MLW_INT32_V | MLW_INT32_A | MLW_WORD32_V | MLW_WORD32_A 
           | MLW_INT16_V | MLW_INT16_A | MLW_WORD16_V | MLW_WORD16_A
           | MLW_STRING | MLW_CHAR_A | MLW_WORD8_V | MLW_WORD8_A
           | MLW_FLOAT_V | MLW_FLOAT_A | MLW_DOUBLE_V | MLW_DOUBLE_A
           | POINTER of types
                         (* Pointer to a value of type types *)
           | ENUM of {name : string option, fields : e_field list}
                         (* e.g. enum {A, B} *)
           | AGGREGATE of
             {aggType : aggregate_type, name : string option,
              fields : field list}
                         (* e.g. struct {int a; char b;} *)
           | ARRAY of {elemType: types, dimensions: expression option}
                         (* Array with elements of type and size given *)
           | FUNCTION of
               {returnType : types,
                params : {name: string option, paramType: types} list}
           | FLEX (* ellipsis in a parameter list *)
         and expression = (* expressions for constants *)
             HEX_CONSTANT of string
           | OCT_CONSTANT of string
           | DEC_CONSTANT of string
           | STRING_CONSTANT of string 
           | CHAR_CONSTANT of string
           | FLOAT_CONSTANT of string
           | IDENTIFIER_EXP of string
           | UNARY_EXP of unary_op * expression (* e.g. ("!", ...) *)
           | BINARY_EXP of expression * binary_op * expression 
           | CAST_EXP of types * expression
           | LIST_EXP of expression list
         and unary_op =
             BIN_NEG (* `!' *)
         and binary_op =
             MULTIPLY | DIVIDE | MODULUS | PLUS | MINUS 
           (*   *         /        %        +      -        *)
           | L_SHIFT | R_SHIFT | BIT_AND | BIT_EOR | BIT_OR
           (*  <<         >>        &        ^         |    *)

    (* These are top level declarations: *)
    datatype declaration =
        TYPE_DEF of {oldType: types, newName:string}
                        (* Give a new name to a type, e.g.
                             typdef int number; *)
      | TYPE_DECL of types
                        (* for things like `enum bool {false, true};' *)
      | ID_DECL of {name: string, idType : types}
                        (* Declare a name, e.g. a function
                             int main (int argc, char *argv[]);
                           (or an array?) *)
      | CONSTANT_DECL of {name: string, value: expression, valueType :types }
                        (* Define a constant, e.g.
                             int number = 5;
                             const char *name = "Bob";
                             int a[5]={1, 2, 3, 4, 5}; *)

      (* Final result of parsing is a declaration list. *)
      datatype declaration_list = DECL_LIST of declaration list
      
      val stringDeclList : declaration_list -> string

  end
