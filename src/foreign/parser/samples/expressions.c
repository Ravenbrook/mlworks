/*
 * Foreign Interface parser: Sample file testing expressions
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: expressions.c,v $
 * Revision 1.1  1997/08/22 09:44:34  brucem
 * new unit
 * Test parsing of expressions by the Foreign Interface parser.
 *
 *
 */


/* constants */
const int decTest = 100, octTest = 0100, hexTest = 0x100;

const char *stringTest = "string test.\n", charTest = '\0';

const float floatTest = 100.100;

const int idTest = decTest;

/* initialiser lists */
const int listTest[] = {0, 1, 2, 3, 4, 5, 6, 7};

const int listTest2[] = {0, 1, 2, 3, };

/* PRIMARY_EXPRESSION: BRAC EXPRESSION KET */
const int a = (1+2);

/* UNARY_EXPRESSION */
const unsigned int b = ! 0xFF;

/* CAST_EXPRESSION */

const unsigned int c = (unsigned) 0xFF;
const unsigned long c2 = (long) (unsigned) 0xFF;

/* MULT_EXPRESSION */

const int d = 5 * 6;
const int d2 = 2 / 1;
const int d3 = 3 % 3;

/* ADD_EXPRESSION */
const int e = 1 + 2 * 3; /* 1 + (2*3) */
const int e2 = 1 * 2 + 3; /* (1*2) + 3 */
const int e3 = 1 - 2 * 3; /* 1 - (2*3) */
const int e4 = 1 * 2 - 3; /* (1*2) - 3 */

/* SHIFT_EXPRESSION */
const int f = 0x01 << 2+2;
const int f2 = 2+2 << 0x01;
const int f3= 0x01 >> 2+2;
const int f4 = 2+2 >> 0x01;

/* AND_EXPRESSION */
const int g = 0xFF & 0xFF << 01;
const int g2 = 0xFF & 0xFF << 01;

/* EXC_OR_EXPRESSION */
const int h = 1 ^ 2 & 3;
const int h2 = 1 & 2 ^ 3;

/* INC_OR_EXPRESSION */
const int i = 1 | 2 ^ 3;
const int i2 = 1 ^ 2 | 3;

/* Check brackets overcome precendence */
const int j = (1 | 2) * 3;
