(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/idl.lex,v 1.6 1999/03/09 15:02:58 clive Exp $" *)

type pos = int;
type svalue = Tokens.svalue
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult= (svalue,pos) token

val linenum = ref (0);
val eof = fn () => Tokens.EOF(!linenum,!linenum)

exception IllegalChar of string;

%%
%s C L;
%header (require "idl_grm"; 
         functor IDLLexFun(structure Tokens: IDL_TOKENS));
idstart=[a-zA-Z];
idrest=[a-zA-Z0-9_];
id={idstart}{idrest}*;
ws=[\t\ ]*;
num=[0-9]+;
%%
<INITIAL>{ws}	=> (lex());
<INITIAL>\n	=> (linenum := !linenum + 1; lex());
<INITIAL>\"([^\"]*)\" => (Tokens.STRING_LITERAL(yytext,!linenum, !linenum));
<INITIAL>"abstract" => (Tokens.ABSTRACT(!linenum, !linenum));
<INITIAL>"any" => (Tokens.ANY(!linenum, !linenum));
<INITIAL>"attribute" => (Tokens.ATTRIBUTE(!linenum, !linenum));
<INITIAL>"boolean" => (Tokens.BOOLEAN(!linenum, !linenum));
<INITIAL>"case" => (Tokens.CASE(!linenum, !linenum));
<INITIAL>"char" => (Tokens.CHAR(!linenum, !linenum));
<INITIAL>"const" => (Tokens.CONST(!linenum, !linenum));
<INITIAL>"context" => (Tokens.CONTEXT(!linenum, !linenum));
<INITIAL>"custom" => (Tokens.CUSTOM(!linenum, !linenum));
<INITIAL>"default" => (Tokens.DEFAULT(!linenum, !linenum));
<INITIAL>"double" => (Tokens.DOUBLE(!linenum, !linenum));
<INITIAL>"enum" => (Tokens.ENUM(!linenum, !linenum));
<INITIAL>"exception" => (Tokens.EXCEPTION(!linenum, !linenum));
<INITIAL>"FALSE" => (Tokens.FALSE(!linenum, !linenum));
<INITIAL>"float" => (Tokens.FLOAT(!linenum, !linenum));
<INITIAL>"in" => (Tokens.IN(!linenum, !linenum));
<INITIAL>"init" => (Tokens.INIT(!linenum, !linenum));
<INITIAL>"inout" => (Tokens.INOUT(!linenum, !linenum));
<INITIAL>"interface" => (Tokens.INTERFACE(!linenum, !linenum));
<INITIAL>"long" => (Tokens.LONG(!linenum, !linenum));
<INITIAL>"module" => (Tokens.MODULE(!linenum, !linenum));
<INITIAL>"Object" => (Tokens.OBJECT(!linenum, !linenum));
<INITIAL>"octet" => (Tokens.OCTET(!linenum, !linenum));
<INITIAL>"oneway" => (Tokens.ONEWAY(!linenum, !linenum));
<INITIAL>"out" => (Tokens.OUT(!linenum, !linenum));
<INITIAL>"private" => (Tokens.PRIVATE(!linenum, !linenum));
<INITIAL>"public" => (Tokens.PUBLIC(!linenum, !linenum));
<INITIAL>"raises" => (Tokens.RAISES(!linenum, !linenum));
<INITIAL>"readonly" => (Tokens.READONLY(!linenum, !linenum));
<INITIAL>"safe" => (Tokens.SAFE(!linenum, !linenum));
<INITIAL>"sequence" => (Tokens.SEQUENCE(!linenum, !linenum));
<INITIAL>"short" => (Tokens.SHORT(!linenum, !linenum));
<INITIAL>"string" => (Tokens.STRING(!linenum, !linenum));
<INITIAL>"struct" => (Tokens.STRUCT(!linenum, !linenum));
<INITIAL>"supports" => (Tokens.SUPPORTS(!linenum, !linenum));
<INITIAL>"switch" => (Tokens.SWITCH(!linenum, !linenum));
<INITIAL>"TRUE" => (Tokens.TRUE(!linenum, !linenum));
<INITIAL>"TypeCode" => (Tokens.TYPECODE(!linenum, !linenum));
<INITIAL>"typedef" => (Tokens.TYPEDEF(!linenum, !linenum));
<INITIAL>"union" => (Tokens.UNION(!linenum, !linenum));
<INITIAL>"unsigned" => (Tokens.UNSIGNED(!linenum, !linenum));
<INITIAL>"valuetype" => (Tokens.VALUETYPE(!linenum, !linenum));
<INITIAL>"ValueBase" => (Tokens.VALUEBASE(!linenum, !linenum));
<INITIAL>"void" => (Tokens.VOID(!linenum, !linenum));

<INITIAL>"(" => (Tokens.LPAREN(!linenum, !linenum));
<INITIAL>")" => (Tokens.RPAREN(!linenum, !linenum));
<INITIAL>"{" => (Tokens.LBRACE(!linenum, !linenum));
<INITIAL>"}" => (Tokens.RBRACE(!linenum, !linenum));
<INITIAL>"[" => (Tokens.LBRA(!linenum, !linenum));
<INITIAL>"]" => (Tokens.RBRA(!linenum, !linenum));
<INITIAL>"," => (Tokens.COMMA(!linenum, !linenum));
<INITIAL>";" => (Tokens.SEMICOLON(!linenum, !linenum));
<INITIAL>":" => (Tokens.COLON(!linenum, !linenum));
<INITIAL>"::" => (Tokens.COLON_COLON(!linenum, !linenum));
<INITIAL>"<" => (Tokens.LESS(!linenum, !linenum));
<INITIAL>"<<" => (Tokens.LSHIFT(!linenum, !linenum));
<INITIAL>">" => (Tokens.GREATER(!linenum, !linenum));
<INITIAL>">>" => (Tokens.RSHIFT(!linenum, !linenum));
<INITIAL>"=" => (Tokens.EQUAL(!linenum, !linenum));
<INITIAL>"|" => (Tokens.VBAR(!linenum, !linenum));
<INITIAL>"^" => (Tokens.HAT(!linenum, !linenum));
<INITIAL>"&" => (Tokens.AMPERSAND(!linenum, !linenum));
<INITIAL>"+" => (Tokens.PLUS(!linenum, !linenum));
<INITIAL>"-" => (Tokens.MINUS(!linenum, !linenum));
<INITIAL>"*" => (Tokens.STAR(!linenum, !linenum));
<INITIAL>"~" => (Tokens.TWIDDLE(!linenum, !linenum));
<INITIAL>"/" => (Tokens.SLASH(!linenum, !linenum));
<INITIAL>"%" => (Tokens.PERCENT(!linenum, !linenum));

<INITIAL>#pragma ([^\n]*) => (YYBEGIN L; Tokens.PRAGMA(yytext,!linenum, !linenum));
<INITIAL>"#include_begin" => (Tokens.INCLUDEBEGIN(!linenum, !linenum));
<INITIAL>"#include_end" => (Tokens.INCLUDEEND(!linenum, !linenum));

<INITIAL>"/*" =>   (YYBEGIN C; lex());
<INITIAL>"//" => (YYBEGIN L; lex());
<INITIAL>{id} => (Tokens.IDENTIFIER (yytext,!linenum, !linenum));
<INITIAL>. => (raise IllegalChar yytext);

<C>\n		=> (lex());
<C>[^*/\n]+	=> (lex());
<C>"*/"		=> (YYBEGIN INITIAL; lex());
<C>[*/]		=> (lex());

<L>\n		=> (YYBEGIN INITIAL; lex());
<L>[^\n]	=> (lex());
