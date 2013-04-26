(*
 *
 * $Log: lego_grm.sml,v $
 * Revision 1.2  1998/08/05 17:34:55  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
require "base";
signature Lego_TOKENS =
sig
type ('a,'b) token
type svalue
val VREG:  'a * 'a -> (svalue,'a) token
val CONSTRS:  'a * 'a -> (svalue,'a) token
val PARAMS:  'a * 'a -> (svalue,'a) token
val NOREDS:  'a * 'a -> (svalue,'a) token
val INDUCTIVE:  'a * 'a -> (svalue,'a) token
val UNDO:  'a * 'a -> (svalue,'a) token
val UNFREEZE:  'a * 'a -> (svalue,'a) token
val UNDERSCORE:  'a * 'a -> (svalue,'a) token
val TYPEOF:  'a * 'a -> (svalue,'a) token
val TYPE:  'a * 'a -> (svalue,'a) token
val TREG:  'a * 'a -> (svalue,'a) token
val TILDE:  'a * 'a -> (svalue,'a) token
val STRING: (string) *  'a * 'a -> (svalue,'a) token
val STARTTIMER:  'a * 'a -> (svalue,'a) token
val SLASHS:  'a * 'a -> (svalue,'a) token
val SEMICOLON:  'a * 'a -> (svalue,'a) token
val DOLLARSAVE:  'a * 'a -> (svalue,'a) token
val SAVE:  'a * 'a -> (svalue,'a) token
val RELOAD:  'a * 'a -> (svalue,'a) token
val RSQBR:  'a * 'a -> (svalue,'a) token
val RRBR:  'a * 'a -> (svalue,'a) token
val RPTBR:  'a * 'a -> (svalue,'a) token
val RELINT: (int) *  'a * 'a -> (svalue,'a) token
val REFINE:  'a * 'a -> (svalue,'a) token
val RCBR:  'a * 'a -> (svalue,'a) token
val QREPL:  'a * 'a -> (svalue,'a) token
val QM:  'a * 'a -> (svalue,'a) token
val PWD:  'a * 'a -> (svalue,'a) token
val PROP:  'a * 'a -> (svalue,'a) token
val PRINTTIMER:  'a * 'a -> (svalue,'a) token
val PRF:  'a * 'a -> (svalue,'a) token
val ORIR:  'a * 'a -> (svalue,'a) token
val ORIL:  'a * 'a -> (svalue,'a) token
val ORE:  'a * 'a -> (svalue,'a) token
val OR:  'a * 'a -> (svalue,'a) token
val NOTI:  'a * 'a -> (svalue,'a) token
val NOTE:  'a * 'a -> (svalue,'a) token
val NORMAL:  'a * 'a -> (svalue,'a) token
val NEXT:  'a * 'a -> (svalue,'a) token
val MARKS:  'a * 'a -> (svalue,'a) token
val MODULE:  'a * 'a -> (svalue,'a) token
val LOAD:  'a * 'a -> (svalue,'a) token
val LSQBR:  'a * 'a -> (svalue,'a) token
val LRBR:  'a * 'a -> (svalue,'a) token
val LPTBR:  'a * 'a -> (svalue,'a) token
val LINE:  'a * 'a -> (svalue,'a) token
val LCBR:  'a * 'a -> (svalue,'a) token
val LOGIC:  'a * 'a -> (svalue,'a) token
val KILLREF:  'a * 'a -> (svalue,'a) token
val IMPORT:  'a * 'a -> (svalue,'a) token
val iNTROS:  'a * 'a -> (svalue,'a) token
val INTROS:  'a * 'a -> (svalue,'a) token
val INT: (int) *  'a * 'a -> (svalue,'a) token
val INIT:  'a * 'a -> (svalue,'a) token
val IMPI:  'a * 'a -> (svalue,'a) token
val IMPE:  'a * 'a -> (svalue,'a) token
val IMMED:  'a * 'a -> (svalue,'a) token
val INCLUDE:  'a * 'a -> (svalue,'a) token
val ID: (string) *  'a * 'a -> (svalue,'a) token
val HNF:  'a * 'a -> (svalue,'a) token
val HELP:  'a * 'a -> (svalue,'a) token
val HASH:  'a * 'a -> (svalue,'a) token
val GOAL:  'a * 'a -> (svalue,'a) token
val GEN:  'a * 'a -> (svalue,'a) token
val FROM:  'a * 'a -> (svalue,'a) token
val FORGETMARK:  'a * 'a -> (svalue,'a) token
val FORGET:  'a * 'a -> (svalue,'a) token
val FREEZE:  'a * 'a -> (svalue,'a) token
val EXPORT:  'a * 'a -> (svalue,'a) token
val EXPAND:  'a * 'a -> (svalue,'a) token
val EXPALL:  'a * 'a -> (svalue,'a) token
val EXI:  'a * 'a -> (svalue,'a) token
val EXE:  'a * 'a -> (svalue,'a) token
val EQUIV:  'a * 'a -> (svalue,'a) token
val EQUL:  'a * 'a -> (svalue,'a) token
val EOF:  'a * 'a -> (svalue,'a) token
val ELIM:  'a * 'a -> (svalue,'a) token
val ECHO:  'a * 'a -> (svalue,'a) token
val DECLS:  'a * 'a -> (svalue,'a) token
val DOT2:  'a * 'a -> (svalue,'a) token
val DOT1:  'a * 'a -> (svalue,'a) token
val DOT:  'a * 'a -> (svalue,'a) token
val DNF:  'a * 'a -> (svalue,'a) token
val DISCHARGEKEEP:  'a * 'a -> (svalue,'a) token
val DISCHARGE:  'a * 'a -> (svalue,'a) token
val DOLLARSQ:  'a * 'a -> (svalue,'a) token
val DEQ:  'a * 'a -> (svalue,'a) token
val CHOICE:  'a * 'a -> (svalue,'a) token
val CTXT:  'a * 'a -> (svalue,'a) token
val COMMA:  'a * 'a -> (svalue,'a) token
val CONTRACT:  'a * 'a -> (svalue,'a) token
val CONFIG:  'a * 'a -> (svalue,'a) token
val COLON:  'a * 'a -> (svalue,'a) token
val CLAIM:  'a * 'a -> (svalue,'a) token
val CD:  'a * 'a -> (svalue,'a) token
val BAR:  'a * 'a -> (svalue,'a) token
val BACKSLASH:  'a * 'a -> (svalue,'a) token
val ARROW:  'a * 'a -> (svalue,'a) token
val AND:  'a * 'a -> (svalue,'a) token
val ANDI:  'a * 'a -> (svalue,'a) token
val ANDE:  'a * 'a -> (svalue,'a) token
val ALLI:  'a * 'a -> (svalue,'a) token
val ALLE:  'a * 'a -> (svalue,'a) token
end
signature Lego_LRVALS=
sig
structure Tokens : Lego_TOKENS
structure ParserData:PARSER_DATA
sharing type ParserData.Token.token = Tokens.token
sharing type ParserData.svalue = Tokens.svalue
end
