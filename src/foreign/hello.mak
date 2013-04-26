# Hello example makefile (SunOS variant)

CC 		= gcc
CFLAGS		= -ansi -pedantic -g -Wall

XLIBS           = -lXm -lXt -lX11

LD              = ld

hello.o: hello.c
	$(CC) $(CFLAGS) -c hello.c -o hello.o

hello.so: hello.o
	$(LD) -Bdynamic hello.o -o hello.so
