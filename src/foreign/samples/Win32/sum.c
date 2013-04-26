/* Copyright (C) 1997  The Harlequin Group Limited.  All rights reserved. */

#include <stdio.h>
#include "dll.h"

int sum(int x, int y)
{
   printf("arg1 = %i arg2 = %i\n", x, y);

   return(x + y);
}
