datatype lexresult= DIV | EOF | EOS | ID of string | LPAREN |
                     NUM of int | PLUS | PRINT | RPAREN | SUB | TIMES 

val linenum = ref 1
val error = fn x => print(x ^ "\n")
val eof = fn () => EOF
val inc = fn x => x:=(!x)+1
%%
%structure CalcLex
alpha=[A-Za-z];
digit=[0-9];
ws = [\ \t];
%%
\n       => (inc linenum; lex());
{ws}+    => (lex());
"/"      => (DIV);
";"      => (EOS);
"("      => (LPAREN);
{digit}+ => (NUM (foldl (fn(a,r)=>ord(a)-ord(#"0")+10*r) 0 (explode yytext)));
")"      => (RPAREN);
"+"      => (PLUS);
{alpha}+ => (if yytext="print" then PRINT else ID yytext);
"-"      => (SUB);
"*"      => (TIMES);
.        => (error ("calc: ignoring bad character "^yytext); lex());
