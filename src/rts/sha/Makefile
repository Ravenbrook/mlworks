# By default, the code is compiled for a "big endian" machine.
# To compile on a "little endian" machine set the LITTLE_ENDIAN flag.
# x86 is little endian.  SPARC and SGI MIPS are big endian.
# To make smaller object code, but run a little slower, don't use UNROLL_LOOPS.
# To use NIST's modified SHA of 7/11/94, define USE_MODIFIED_SHA

# Adapted from sha Makefile 
# NB: This must work with both gnumake and Solaris make as it is
# used both by MLWorks and web-page writers (see MLWorks Darwin request 30227)
# To use under Windows set OS=NT on the command line.
# To use under Linux set OS=Linux on the command line.

UNIXCC = gcc
NTCC = cl

CFLAGS = -O2 -ansi -pedantic -Wall # -DUNROLL_LOOPS # -DLITTLE_ENDIAN # -DUSE_MODIFIED_SHA

all:	sha

# disable suffix rules

.SUFFIXES:

%.o: %.c 
	if test "$(OS)" = "NT" || test "$(OS)" = "Win95" ; \
	then $(NTCC) -DLITTLE_ENDIAN -c -Fo$@ $< ; \
	elif test "$(OS)" = "Linux" ; \
	then $(UNIXCC) -DLITTLE_ENDIAN -c -o $@ $< ; \
	else $(UNIXCC) -c -o $@ $< ; \
	fi 

mlw_mklic:	sha.o mlw_mklic.o 
	if test "$(OS)" = "NT" || test "$(OS)" = "Win95" ; \
	then $(NTCC) -DLITTLE_ENDIAN -o $@ sha.o mlw_mklic.o -link -subsystem:console ; \
	elif test "$(OS)" = "Linux" ; \
	then $(UNIXCC) -DLITTLE_ENDIAN -o $@ sha.o mlw_mklic.o ; \
	else $(UNIXCC) -o $@ sha.o mlw_mklic.o ; \
	strip $@ ; \
	fi

dylan_mklic:	sha.o dylan_mklic.o 
	if test "$(OS)" = "NT" || test "$(OS)" = "Win95" ; \
	then $(NTCC) -DLITTLE_ENDIAN -o $@ sha.o dylan_mklic.o -link -subsystem:console ; \
	elif test "$(OS)" = "Linux" ; \
	then $(UNIXCC) -DLITTLE_ENDIAN -o $@ sha.o dylan_mklic.o ; \
	else $(UNIXCC) -o $@ sha.o dylan_mklic.o ; \
	strip $@ ; \
	fi

sha:	sha_driver.o sha.o
	if test "$(OS)" = "NT" || test "$(OS)" = "Win95" ; \
	then $(NTCC) -DLITTLE_ENDIAN -o $@ sha_driver.o sha.o ; \
	elif test "$(OS)" = "Linux" ; \
	then $(UNIXCC) -DLITTLE_ENDIAN -o $@ sha_driver.o sha.o ; \
	else $(UNIXCC) -o $@ sha_driver.o sha.o ; \
	strip $@ ; \
	fi

test:	sha appgen
	sha `appgen 1`
	sha `appgen 2`
	sha `appgen 3`
	@echo "Values should be:"
	@cat sha.good.outputs
	@echo "except if you defined USE_MODIFIED_SHA!"
	@echo "I have no known-good comparisons for that case!"

clean:
	rm -f *.o mlw_mklic dylan_mklic sha appgen


