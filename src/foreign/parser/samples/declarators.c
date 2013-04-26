/*
 * Foreign Interface parser: Sample file testing declarators
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: declarators.c,v $
 * Revision 1.1  1997/08/22 09:44:33  brucem
 * new unit
 * Test the parsing of declarators by the Foreign Interface parser.
 *
 *
 */


/* Test declarators, these tests are designed to use every declarator
   rule in the parser.  Similar examples to each are provided to check
   that they are interpreted correctly. */

typedef int number;

/* ID_DECLARATOR: PAREN_ID_DECLARATOR: ID */
const int a = 5;
const number a2 = 5;

/* PAREN_ID_DECLARATOR: BRAC PAREN_ID_DECLARATOR KET */
const int (b) = 5;

/* UNARY_ID_DECLARATOR: ASTERIX ID_DECLARATOR */
const int *c = (int *)0x00;

/* UNARY_ID_DECLARATOR: POSTFIX_ID_DECLARATOR:
     BRAC UNARY_ID_DECLARATOR KET */
const int (*d) = (int *)0x00;

/* POSTFIX_ID_DECLARATOR: PAREN_ID_DECLARATOR POSTFIXING_ABSTRACT_DECLARATOR */
const int e[] = (int *)0x00;

/* POSTFIX_ID_DECLARATOR:
     BRAC UNARY_ID_DECLARATOR KET POSTFIXING_ABSTRACT_DECLARATOR */
int (*f)[5]; /* pointer to array */

int *f2[5]; /* array of pointers */

/* POSTFIXING_ABSTRACT_DECLARATOR: BRAC KET */
int g();

/* POSTFIXING_ABSTRACT_DECLARATOR: ARRAY_ABSRACT_DECLARATOR:
     S_BRAC S_KET */
int h[];

/* POSTFIXING_ABSTRACT_DECLARATOR: BRAC KET */
int i();

/* POSTFIXING_ABSRACT_DECLARATOR: BRAC PARAM_TYPE_LIST KET */
int j(int a);

/* ARRAY_ABSRACT_DECLARATOR: S_BRAC EXPRESSION S_KET */
int k[5];

/* ARRAY_ABSRACT_DECLARATOR:
     ARRAY_ABSRACT_DECLARATOR S_BRAC EXPRESSION S_KET */
int l[1][2];

/* PARAM_DECLARATOR: ID */
int m(int a);
int m2(number a);

/* PARAM_DECLARATOR: ASTERIX PARAM_DECLARATOR */
int n(int *a);
int n2(number *a);

/* PARAM_DECLARATOR: PARAM_POSTFIX_DECLARATOR:
     BRAC PARAM_AST_DECLARATOR KET */
int o(int (*a)); /* equiv. to `int o(int *a);' */
int o2(number (*a));

/* PARAM_AST_DECLARATOR: ASTERIX_PARAM_AST_DECLARATOR */
int p(int (**a)); /* equiv. to `int p(int **a);' */
int p2(number (**a));

/* PARAM_AST_DECLARATOR: BRAC PARAM_AST_DECLARATOR KET */
int q(int ((*a))); /* equiv. to `int q(int *a);' */
int q2(number ((*a)));

/* PARAM_POSTFIX_DECLARATOR: ID POSTFIXING_ABSTRACT_DECLARATOR */
int r(int a()); /* `a' is a () to int function */
int r2(number a());

/* PARAM_POSTFIX_DECLARATOR:
     BRAC PARAM_AST_DECLARATOR KET POSTFIXING_ABSTRACT_DECLARATOR */
int s(int (*a)()); /* `a' is a pointer to a function */
int s2(number (*a)());
int s3(int *a()); /* in this case `a' returns a pointer */ /* FAILS!! */

/* ABSTRACT_DECLARATOR: UNARY_ABSTRACT_DECLARATOR: ASTERIX */
int t(int *);
int t2(number *);

/* UNARY_ABSTRACT_DECLARATOR: ASTERIX ABSTRACT_DECLARATOR */
int u(int **);
int u2(number **);

/* ABSTRACT_DECLARATOR: POSTFIXING_ABSTRACT_DECLARATOR */
int v(int []);
int v2(number []);

/* ABSTRACT_DECLARATOR: POSTFIX_ABSTRACT_DECLARATOR:
     BRAC UNARY_ABSTRACT_DECLARATOR KET */
int w(int (*)); /* equiv. to `int w(int *);' */
int w2(number (*));

/* POSTFIX_ABSTRACT_DECLARATOR: BRAC POSTFIX_ABSTRACT_DECLARATOR KET */
int x(int ((*))); /* as `w' */
int x2(number ((*))); /* as `w' */

/* POSTFIX_ABSTRACT_DECLARATOR: BRAC POSTFIXING_ABSTRACT_DECLARATOR KET */
int y(int (())); /* equiv. to `int y(int ());' */
int y2(number (()));


/* Big finale: */
unsigned int *(*z)(int (*a)(), int *b(), int *[], number *number(int *));
