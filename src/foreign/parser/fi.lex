require "fi_grm";
require "lex_parse_interface";
require "$.basis.__int";
require "$.basis.__string_cvt";

(*
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * $Log: fi.lex,v $
 * Revision 1.1  1997/08/22 09:27:56  brucem
 * new unit
 * Lexer definition for Foreign Interface Parser (used by sml-lex).
 *
 *
 *)

type pos = LexParseInterface.pos

val pos = LexParseInterface.pos
          (* should be local to lex function rather than structure *)

type svalue = Tokens.svalue
type ('a,'b) token = ('a, 'b) Tokens.token
type lexresult = (svalue, pos) token

open Tokens (* To save typing Tokens. before every value *)

val eof = fn _ => (pos := LexParseInterface.startPos; END(!pos, !pos))

%%

%header (functor FILexFun(structure Tokens : FI_TOKENS
                                and LexParseInterface : LEX_PARSE_INTERFACE));

%s COMMENT;

identifier=[a-zA-Z_][0-9a-zA-Z_]*;
integer_suffix_opt=([uU]?[lL]?)|([lL][uU]);
decimal_constant=[1-9][0-9]*{integer_suffix_opt};
octal_constant="0"[0-7]*{integer_suffix_opt};
hex_constant="0"[xX][0-9a-fA-F]+{integer_suffix_opt};
exponent_part=[eE][-+]?[0-9]+;
fractional_constant=([0-9]*"."[0-9]+)|([0-9]+".");
floating_constant=
(({fractional_constant}{exponent_part}?)|([0-9]+{exponent_part}))[FfLl]? ;


simple_escape=[abfnrtv'"?\\];
octal_escape =[0-7]{1,3};
hex_escape="x"[0-9a-fA-F]+;

escape_sequence=[\\]({simple_escape}|{octal_escape}|{hex_escape});
c_char=[^'\\\n]|{escape_sequence};
s_char=[^"\\\n]|{escape_sequence};

form_feed=[\014];
v_tab=[\013];
c_return=[\015];

horizontal_white=[\ \t];

%%

<INITIAL>{horizontal_white}+
   => ( continue() );

<INITIAL>({v_tab}|{c_return}|{form_feed})+
   => ( continue() );

<INITIAL>({horizontal_white}|{v_tab}|{c_return}|{form_feed})*"\n"
   => ( pos := LexParseInterface.nextPos (!pos); continue() );

<INITIAL>char => ( KW_CHAR(!pos, !pos));
<INITIAL>const => ( KW_CONST(!pos, !pos));
<INITIAL>double => ( KW_DOUBLE(!pos, !pos));
<INITIAL>enum => ( KW_ENUM(!pos, !pos));
<INITIAL>extern => ( KW_EXTERN(!pos, !pos));
<INITIAL>float => ( KW_FLOAT(!pos, !pos));
<INITIAL>int => ( KW_INT(!pos, !pos));
<INITIAL>long => (KW_LONG(!pos, !pos));
<INITIAL>register => ( KW_REGISTER(!pos, !pos));
<INITIAL>short => ( KW_SHORT(!pos, !pos));
<INITIAL>signed => ( KW_SIGNED(!pos, !pos));
<INITIAL>static => ( KW_STATIC(!pos, !pos));
<INITIAL>struct => ( KW_STRUCT(!pos, !pos));
<INITIAL>typedef => ( KW_TYPEDEF(!pos, !pos));
<INITIAL>union => ( KW_UNION(!pos, !pos));
<INITIAL>unsigned => ( KW_UNSIGNED(!pos, !pos));
<INITIAL>void => ( KW_VOID(!pos, !pos));
<INITIAL>volatile => ( KW_VOLATILE(!pos, !pos));

<INITIAL>mlw_int => (KW_MLW_INT(!pos, !pos));
<INITIAL>mlw_word => (KW_MLW_WORD(!pos, !pos));
<INITIAL>mlw_int32 => (KW_MLW_INT32(!pos, !pos));
<INITIAL>mlw_char => (KW_MLW_CHAR(!pos, !pos));
<INITIAL>mlw_word8 => (KW_MLW_WORD8(!pos, !pos));
<INITIAL>mlw_int32_vector => (KW_MLW_INT32_V(!pos, !pos));
<INITIAL>mlw_int32_array => (KW_MLW_INT32_A(!pos, !pos));
<INITIAL>mlw_word32_vector => (KW_MLW_WORD32_V(!pos, !pos));
<INITIAL>mlw_word32_array => (KW_MLW_WORD32_A(!pos, !pos));
<INITIAL>mlw_int16_vector => (KW_MLW_INT16_V(!pos, !pos));
<INITIAL>mlw_int16_array => (KW_MLW_INT16_A(!pos, !pos));
<INITIAL>mlw_word16_vector => (KW_MLW_WORD16_V(!pos, !pos));
<INITIAL>mlw_word16_array => (KW_MLW_WORD16_V(!pos, !pos));
<INITIAL>mlw_string => (KW_MLW_STRING(!pos, !pos));
<INITIAL>mlw_char_array => (KW_MLW_CHAR_A(!pos, !pos));
<INITIAL>mlw_word8_vector => (KW_MLW_WORD8_V(!pos, !pos));
<INITIAL>mlw_word8_array => (KW_MLW_WORD8_A(!pos, !pos));
<INITIAL>mlw_float_vector => (KW_MLW_FLOAT_V(!pos, !pos));
<INITIAL>mlw_float_array => (KW_MLW_FLOAT_A(!pos, !pos));
<INITIAL>mlw_double_vector => (KW_MLW_DOUBLE_V(!pos, !pos));
<INITIAL>mlw_double_array => (KW_MLW_DOUBLE_A(!pos, !pos));

<INITIAL>{identifier} =>
  ( (* if LexParseInterface.isTypedefName symbolTable yytext 
   then TYPEDEF_NAME (yytext, !pos, !pos)
   else *) ID (yytext, !pos, !pos) 
  );

<INITIAL>{decimal_constant} =>
   ( DEC_INT_CONST (yytext, !pos, !pos) );
<INITIAL>{octal_constant} =>
   ( OCT_INT_CONST (yytext, !pos, !pos) );
<INITIAL>{hex_constant} =>
   ( HEX_INT_CONST(yytext, !pos, !pos) );
<INITIAL>{floating_constant} =>
   ( REAL_CONST (yytext, !pos, !pos) );

<INITIAL>"L"?[']{c_char}+['] => ( CHAR_CONST (yytext, !pos, !pos) );
<INITIAL>"L"?["]{s_char}*["] => ( STRING_CONST (yytext, !pos, !pos) );

<INITIAL>"(" => ( BRAC(!pos, !pos) );
<INITIAL>")" => ( KET(!pos, !pos) );
<INITIAL>"," => ( COMMA(!pos, !pos) );
<INITIAL>"#" => ( HASH(!pos, !pos) );
<INITIAL>"{" => ( C_BRAC(!pos, !pos) );
<INITIAL>"}" => ( C_KET(!pos, !pos) );
<INITIAL>"[" => ( S_BRAC(!pos, !pos) );
<INITIAL>"]" => ( S_KET(!pos, !pos) );
<INITIAL>"." => ( FSTOP(!pos, !pos) );
<INITIAL>"&" => ( AMP(!pos, !pos) );
<INITIAL>"*" => ( ASTERIX(!pos, !pos) );
<INITIAL>"+" => ( PLUS(!pos, !pos) );
<INITIAL>"-" => ( MINUS(!pos, !pos) );
<INITIAL>"~" => ( TILDE(!pos, !pos) );
<INITIAL>"!" => ( EXCLAM(!pos, !pos) );
<INITIAL>"/" => ( SLASH(!pos, !pos) );
<INITIAL>"%" => ( PERCENT(!pos, !pos) );
<INITIAL>"<" => ( LESS(!pos, !pos) );
<INITIAL>">" => ( GREATER(!pos, !pos) );
<INITIAL>"^" => ( UPARR(!pos, !pos) );
<INITIAL>"|" => ( BAR(!pos, !pos) );
<INITIAL>"?" => ( QUESTION(!pos, !pos) );
<INITIAL>":" => ( COLON(!pos, !pos) );
<INITIAL>";" => ( SEMICOLON(!pos, !pos) );
<INITIAL>"=" => ( EQUALS(!pos, !pos) );

<INITIAL>"->" => ( ARROW(!pos, !pos) );
<INITIAL>"++" => ( INCREMENT(!pos, !pos) );
<INITIAL>"--" => ( DECREMENT(!pos, !pos) );
<INITIAL>"<<" => ( L_SHIFT(!pos, !pos) );
<INITIAL>">>" => ( R_SHIFT(!pos, !pos) );
<INITIAL>"<=" => ( LESS_EQ(!pos, !pos) );
<INITIAL>">=" => ( GREATER_EQ(!pos, !pos) );
<INITIAL>"==" => ( EQ_EQ(!pos, !pos) );
<INITIAL>"!=" => ( NOT_EQ(!pos, !pos) );
<INITIAL>"&&" => ( AND_AND(!pos, !pos) );
<INITIAL>"||" => ( OR_OR(!pos, !pos) );
<INITIAL>"*=" => ( MULT_EQ(!pos, !pos) );
<INITIAL>"/=" => ( DIV_EQ(!pos, !pos) );
<INITIAL>"+=" => ( PLUS_EQ(!pos, !pos) );
<INITIAL>"-=" => ( MINUS_EQ(!pos, !pos) );
<INITIAL>"<<=" => ( LSHIFT_EQ(!pos, !pos) );
<INITIAL>">>=" => ( RSHIFT_EQ(!pos, !pos) );
<INITIAL>"&=" => ( AND_EQ(!pos, !pos) );
<INITIAL>"^=" => ( UP_EQ(!pos, !pos) );
<INITIAL>"|=" => ( OR_EQ(!pos, !pos) );

<INITIAL>"/*" => (YYBEGIN COMMENT; continue());
<COMMENT>\n => (pos := LexParseInterface.nextPos (!pos); continue() );
<COMMENT>"*/" => (YYBEGIN INITIAL; continue());
<COMMENT>[^*/\n]+ => (continue());
<COMMENT>[*/] => (continue());
