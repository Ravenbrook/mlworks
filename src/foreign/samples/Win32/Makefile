
OPTS = /nologo /Gd /ML
DEFS = /DWIN32
CFLAGSREL = $(OPTS) $(DEFS)

clean :
	del *.exe *.obj

hello.dll : dll.h hello.c
	cl $< $(CFLAGSREL) /LD
