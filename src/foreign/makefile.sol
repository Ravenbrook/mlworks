# Makefile for testing dynamic linking stuff ... (Solaris version)

CC 		= gcc
# for cc case, use:
#CC		= cc

CFLAGS		= -ansi -pedantic -g -Wall
# for cc case, use:
#CFLAGS		= -ansiposix -g

XLIBS           = -lXm -lXt -lX11

LD              = ld
LD-FLAGS        = -G -B dynamic

LIB             = -ldl -lelf

PROGS		= tst.so xtst.so xtst1.so nickb.so

all : $(PROGS)

xtst.so : xtst.o
	$(LD) $(LD-FLAGS) $< $(XLIBS) -o $@

memo : memo.c
	$(CC) $(CFLAGS) $< $(XLIBS) -o $@

%.so : %.o
	$(LD) $(LD-FLAGS) $< -o $@

%.o : %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f core $(TARGETS) *.o *.so
