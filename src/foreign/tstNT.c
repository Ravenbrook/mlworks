#include <stdio.h>
#include "prototype.h"
#include "tstNT.h"

int my_value = 42;

void hw(void)
{
   printf("\n\n  Hello World!  -- from a Foreign Function\n\n");
   return;
}

int hw1(void)
{
   printf("\n\n  This is a Value Returning Foreign Function \n\n");
   return(42);
}


int hw2(int arg)
{
   printf("\n\n  This is a single argument, value-returning Foreign Function\n");
   printf("  Here is the input value : %i (= %x)\n\n", (int)arg, (unsigned)arg);
   return(23 + arg);
}

char *hw3(int arg)
{
   static char msgbuf[64];

   printf("\n\n  This is another single argument, value-returning Foreign Function\n");
   printf("  The return value is a string pointer : %i (= %x)\n", (int)msgbuf, (unsigned)msgbuf);

   sprintf(msgbuf,"Surprise! Bet you didn't think this would be here! (%i)", arg);
/*                 01234567890123456789012345678901234567890123456789012345678901234 */
/*                 0         1         2         3         4         5         6     */

   return(msgbuf);
}


int hw4(char *arg)
{
   printf("\n\n  This is another single argument, value-returning Foreign Function\n");
   printf("  The message is : %s\n", arg);

   return(strlen(arg));
}



void byte_print(char *buf, int count)
{
   int i;

   if (count <= 0) return;

   printf("%02x",((unsigned)buf[0] & 0xff));
   for(i=1; i < count; i++)
      printf(" %02x", ((unsigned)buf[i] & 0xff));
}


 
int hw5 (struct my_type *arg)
{
   struct my_type data = {0}, *pdata;
   int v, v1;
   char c;
   int *p;

   v = 4242;
   v1 = 4353;
   c='Z';
   p = &v1;

   data.num = v;
   data.ch  = c;
   data.iptr = p;
   
   pdata = &data;

   printf("hw5 : pdata = [");
   byte_print((char *)pdata,sizeof(struct my_type));
   printf("]\n");

   printf("hw5 : Addr. pdata         = 0x%08x\n\n", (unsigned)pdata);

   printf("hw5 : pdata -> num        = 0x%08x = %i\n", (pdata -> num), (pdata -> num));
   printf("hw5 : Addr. pdata -> num  = 0x%08x\n\n", (unsigned)&(pdata -> num));

   printf("hw5 : pdata -> ch         = '%c' (ASCII value = 0x%x)\n"
         ,(pdata -> ch),(pdata -> ch));
   printf("hw5 : Addr. pdata -> ch   = 0x%x\n\n", (unsigned)&(pdata -> ch));

   printf("hw5 : pdata -> iptr       = 0x%x\n", (unsigned)(pdata -> iptr));
   printf("hw5 : Addr. pdata -> iptr = 0x%x\n\n\n", (unsigned)&(pdata -> iptr));

   printf("hw5 : arg = [");
   byte_print((char *)arg,sizeof(struct my_type));
   printf("]\n");

   printf("hw5 : arg               = 0x%x\n", (unsigned)arg);
   printf("hw5 : Addr. arg -> num  = 0x%x\n", (unsigned)&(arg -> num));
   printf("hw5 : Addr. arg -> ch   = 0x%x\n", (unsigned)&(arg -> ch));
   printf("hw5 : Addr. arg -> iptr = 0x%x\n", (unsigned)&(arg -> iptr));

   v = arg -> num;
   c = arg -> ch;
   p  = arg -> iptr;

   printf("hw5 : *arg.num  = %i\n", v);
   printf("hw5 : *arg.ch   = %c (ASCII value = 0x%x)\n", c, (unsigned)c);
   printf("hw5 : *arg.iptr = 0x%x (value = %i)\n", (unsigned)p, *p);

   printf("\nhw5 : Returning and setting structure ...\n");

   (arg -> num) = 42;
   v  = arg -> num;
   printf("hw5 : *arg.num  = %i\n", v);

   (arg -> ch)  = 'c';
   c = arg -> ch;
   printf("hw5 : *arg.ch   = '%c' (ASCII value = 0x%x)\n", c, (unsigned)c);

   *(arg -> iptr) = 23;
   p  = arg -> iptr;
   printf("hw5 : *arg.iptr = 0x%x (value = %i)\n", (unsigned)p, *p);

   return(v);
}

unsigned hw6(void)
{
   printf("hw6: The value of `my_value' = %i = 0x%08x \n", my_value, my_value);
   printf("hw6: Returning the address of `my_value' = 0x%08x \n", (unsigned)&my_value);

   return((unsigned)&my_value);
}
