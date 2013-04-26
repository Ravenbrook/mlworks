/* Copyright (C) 1996 The Harlequin Group Limited.  All rights reserved. */

#include <stdio.h>

int hello(char *str, int num)
{
   printf("%s %i\n", str, num);
   return(42 + num);
}
