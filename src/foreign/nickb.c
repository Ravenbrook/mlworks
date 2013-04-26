#include <stdio.h>
#include "prototype.h"

#include <malloc.h>

extern void call_me_if_you_dare(void);

void hw(void)
{
   printf("\n\n  Foreign Function called  ... calling malloc() ...\n\n");
   malloc(30);
   printf("\n\n  malloc() called...\n\n");
   call_me_if_you_dare();
   return;
}

int my_value = 42;
