/*
 * Foreign Interface parser: Miscellaneous tests
 *
 * Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * $Log: misc.c,v $
 * Revision 1.1  1997/08/22 09:44:34  brucem
 * new unit
 * Miscellaneous tests for the FI parser.
 *
 *
 */

/* test ennumeration */
enum eA { A, B, C=1, D};

/* struct, union */
struct sA{
  unsigned int A; /* note the modifier */
  short int *B;
  char C[1];
  char *D[2];
  int *E, **F[3][4], G;
  union{
    int Q; char *BAadf;
  }dsfdsf;
};

/* This is allowed but doesn't do anything */
struct sC;

/* Union */
union uA {
  struct {int A; int B;} C;
  struct {char A; char B;} D[4];
};

/* typedef of a simple type */
typedef int number;

/* row of typedefs, fancy declarators */
typedef int numberB, *pointer, array[5];


/* Typedef a struct */
typedef struct {
  int A; char B;
} intChar, *intCharPtr, intCharArray[10];

/* typedef an enum */
typedef enum {sdfdsfd, dfdsfdsaf, erewrew} ABC, *ABCPtr;

/* constants */
const int aNumber = 5;
/* hex and octal */
const long * hexPointer = 0xFF, * octalPointer = 077;
/* constant of a named type */
const number twenty_five = 25;

/* simple function */
int function();

/* more complex functions
int functionA(mlw_int a), functionB(mlw_int16_array a, mlw_word32_vector b);

/* test comments */
/* const shouldNotAppear = 100; */

struct sA blurgle(struct sA *, int j);

/* this is a function which returns a pointer, not a pointer to a function */
enum e1 *flurgle();

/* This is a pointer to a function */
enum e1 (*gurgle)();

int fT(int (number)); /* this takes a function which takes a number */
int fT(int number); /* this takes an integer called number */



