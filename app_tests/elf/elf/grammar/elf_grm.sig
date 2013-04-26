(*
 *
 * $Log: elf_grm.sig,v $
 * Revision 1.2  1998/06/03 12:25:59  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
signature Elf_TOKENS =
sig
type ('a,'b) token
type svalue
val NUM: (int) *  'a * 'a -> (svalue,'a) token
val NONE_:  'a * 'a -> (svalue,'a) token
val RIGHT:  'a * 'a -> (svalue,'a) token
val LEFT:  'a * 'a -> (svalue,'a) token
val EOFPRAGMA:  'a * 'a -> (svalue,'a) token
val NAME:  'a * 'a -> (svalue,'a) token
val INFIX:  'a * 'a -> (svalue,'a) token
val PREFIX:  'a * 'a -> (svalue,'a) token
val POSTFIX:  'a * 'a -> (svalue,'a) token
val QUERY:  'a * 'a -> (svalue,'a) token
val SIGENTRY:  'a * 'a -> (svalue,'a) token
val UNDERSCORE:  'a * 'a -> (svalue,'a) token
val QUID: (string) *  'a * 'a -> (svalue,'a) token
val UCID: (string) *  'a * 'a -> (svalue,'a) token
val LCID: (string) *  'a * 'a -> (svalue,'a) token
val SIGMA:  'a * 'a -> (svalue,'a) token
val TYPE:  'a * 'a -> (svalue,'a) token
val ARROW:  'a * 'a -> (svalue,'a) token
val BACKARROW:  'a * 'a -> (svalue,'a) token
val RBRACE:  'a * 'a -> (svalue,'a) token
val LBRACE:  'a * 'a -> (svalue,'a) token
val RBRACKET:  'a * 'a -> (svalue,'a) token
val LBRACKET:  'a * 'a -> (svalue,'a) token
val RPAREN:  'a * 'a -> (svalue,'a) token
val LPAREN:  'a * 'a -> (svalue,'a) token
val COLON:  'a * 'a -> (svalue,'a) token
val DOT:  'a * 'a -> (svalue,'a) token
val EOF:  'a * 'a -> (svalue,'a) token
end
signature Elf_LRVALS=
sig
structure Tokens : Elf_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
