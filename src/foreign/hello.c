#include <stdio.h>

int hello(char *str, int num)
{
   printf("%s %i\n", str, num);
   return(42 + num);
}
