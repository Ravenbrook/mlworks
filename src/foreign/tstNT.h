#include "dll.h"

extern DLLexport void hw(void);

extern DLLexport int hw1(void);

extern DLLexport int hw2(int);

extern DLLexport char *hw3(int);

extern DLLexport int hw4(char *);


struct my_type {
  int num;
  char ch;
  int *iptr;
};

extern DLLexport int hw5 (struct my_type *);

extern DLLexport unsigned hw6 (void);
