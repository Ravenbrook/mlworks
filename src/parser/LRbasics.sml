(* LRbasics.sml the signature *)
(*
$Log: LRbasics.sml,v $
Revision 1.11  1996/09/20 14:49:26  andreww
[Bug #1577]
Adding datatype replication to the grammar

 * Revision 1.10  1996/04/01  09:51:32  matthew
 * Updating
 *
 * Revision 1.9  1996/03/26  10:49:19  matthew
 * Updating for new language
 *
 * Revision 1.8  1995/07/28  14:26:57  matthew
 * Disallowing = as a strid etc.
 *
Revision 1.7  1995/07/24  16:06:00  jont
Adding literal words

Revision 1.6  1995/07/19  11:51:12  jont
Adding CHAR to grammar

Revision 1.5  1995/03/08  15:22:18  matthew
Adding get_all_actions

Revision 1.4  1993/05/20  13:28:22  matthew
Added code for abstractions.

Revision 1.3  1993/02/18  10:59:28  matthew
Changes for magic brackets.

Revision 1.2  1992/11/25  11:42:42  matthew
Fixed parsing bugs
with rec and abstype

Revision 1.1  1992/08/25  16:29:41  matthew
Initial revision

Copyright (c) 1992 Harlequin Ltd.
*)
(* defines the semantic action type *)

signature LRBASICS =
  sig
datatype GSymbol =
   EOF
(* Do not delete this line *)
 | ABSCOLON
 | ABSDATBIND
 | ABSTRACTION
 | ABSTYPE
 | AND
 | ANDALSO
 | APPEXP
 | ARROW
 | AS
 | ATEXP
 | ATPAT
 | ATPAT1
 | ATPATLIST
 | BIN_ATPAT
 | BRA
 | CASE
 | CHAR
 | COLON
 | COMMA
 | CONBIND
 | CONBIND1
 | CONDEF
 | CONDESC
 | CONDESC1
 | DARROW
 | DATAHEADER
 | DATATYPE
 | DATBIND
 | DATBIND1
 | DATDESC
 | DATDESC1
 | DATREPL
 | DATREPLDESC
 | DEC
 | DEC0
 | DEC1
 | DECSEP
 | DO
 | ELLIPSIS
 | ELSE
 | END
 | EQTYPE
 | EQUAL
 | EXBIND
 | EXBIND1
 | EXCEPTION
 | EXCONDEF
 | EXDESC
 | EXDESC1
 | EXP
 | EXPLIST
 | EXPLIST2
 | EXPROW
 | EXPSEQ
 | EXPSEQ2
 | FN
 | FUN
 | FUNBIND
 | FUNBIND1
 | FUNCTOR
 | FUNDEC1
 | FUNDEC1PLUS
 | FUNID
 | FUNIDBIND
 | FVAL
 | FVALBIND
 | FVALLIST
 | HANDLE
 | HASH
 | IF
 | IN
 | INCLUDE
 | INFEXP
 | INFIX
 | INFIXR
 | INFVAR
 | INTEGER
 | KET
 | LAB
 | LBRACE
 | LET
 | LOCAL
 | LONGID
 | LONGIDLIST
 | LONGSTRID
 | LONGSTRIDEQLIST
 | LONGSTRIDLIST
 | LONGTYCON
 | LONGTYCONEQLIST
 | LONGTYPBIND
 | LONGTYPBIND1
 | LONGVAR
 | LPAR
 | MAGICOPEN
 | MATCH
 | MRULE
 | NONFIX
 | OF
 | OP
 | OPCONDEF
 | OPEN
 | OPEXCONDEF
 | OPLONGVAR
 | OPTOFTYPE
 | OPTTYPE
 | OPVARDEF
 | ORELSE
 | PAT
 | PATLIST2
 | PATROW
 | PATROW1
 | PATVAR
 | PROGRAM
 | RAISE
 | RBRACE
 | REAL
 | REC
 | REQUIRE
 | RPAR
 | SCON
 | SEMICOLON
 | SHAREQ
 | SHAREQ1
 | SHARING
 | SIG
 | SIGBIND
 | SIGBINDER
 | SIGDEC1
 | SIGDEC1PLUS
 | SIGEXP
 | SIGID
 | SIGIDLIST
 | SIGNATURE
 | SIG_START
 | SPEC
 | SPEC1
 | STAR
 | START
 | STARTFUNBIND1
 | STARTFUNBIND2
 | START_LET
 | START_LOCAL
 | STRBIND
 | STRBIND1
 | STRDEC
 | STRDEC0
 | STRDEC1
 | STRDEC1PLUS
 | STRDEC1PLUS0
 | STRDESC
 | STRDESC1
 | STREXP
 | STRID
 | STRING
 | STRUCT
 | STRUCTURE
 | STRUCT_START
 | SYM
 | SYMID
 | SYMLIST
 | THEN
 | TOPDEC
 | TOPDEC1
 | TY
 | TYCON
 | TYLIST
 | TYPBIND
 | TYPBIND1
 | TYPDESC
 | TYPDESC1
 | TYPE
 | TYROW
 | TYSEQ
 | TYTUPLE
 | TYVAR
 | TYVARLIST
 | TYVARSEQ
 | TYVARSEQ1
 | UNDERBAR
 | VAL
 | VALBIND
 | VALBIND1
 | VALDESC
 | VAR
 | VARDEF
 | VBAR
 | WHERE
 | WHILE
 | WITH
 | WITHTYPE
 | WORD
(* Do not delete this line *)

    datatype Action =
      Accept
    | Shift
    | Reduce of int * GSymbol * int
    | Funcall of int * int * Action * Action
    | Resolve of Action list
    | NoAction

    exception NoNextState
    val get_next_state : (GSymbol * int) -> int
    val get_possible_symbols : int -> GSymbol list
    val get_action : (GSymbol * int) -> Action
    val get_all_actions : int -> Action list
    val token_string : GSymbol -> string
  end
