# ==== MLWORKS RUNTIME SYSTEM (GNU) MAKEFILE ====
#
# $Log: GNUmakefile,v $
# Revision 1.112  1998/08/18 10:46:10  jont
# [Bug #70154]
# Delete libmlw.dll and libmlw-g.dll during make clean
#
# Revision 1.111  1998/08/07  15:56:17  jont
# [Bug #70126]
# Don't try to remove license server objects when under Win32
#
# Revision 1.110  1998/08/03  16:21:07  jkbrook
# [Bug #30457]
# Differentiate between price not OS when indexing into license codes
#
# Revision 1.109  1998/08/03  15:46:49  jont
# [Bug #70126]
# Make sure license server stuff cleaned up on make clean
#
# Revision 1.108  1998/07/15  14:47:47  jkbrook
# [Bug #30435]
# Make standalone and DLL-ised license validators
# and distribute as appropriate to platform
#
# Revision 1.107  1998/06/15  15:01:18  johnh
# [Bug #30411]
# Put spalsh pixmaps in right place.
#
# Revision 1.106  1998/06/11  15:37:52  johnh
# [Bug #30411]
# Distribute splash screen bitmaps.
#
# Revision 1.105  1998/05/01  19:28:14  jkbrook
# [Bug #30354]
# Temporarily restore old FI to distribution
#
# Revision 1.104  1998/03/30  11:40:19  jont
# [Bug #70086]
# Add make_key_rights for windows NT registry key security
#
# Revision 1.103  1998/02/13  14:56:16  jont
# [Bug #30242]
# Add new file ml_utilities
#
# Revision 1.102  1998/01/30  15:26:27  jont
# [Bug #70025]
# Reinsert a couple of @ that accidentally got removed
#
# Revision 1.101  1998/01/28  14:54:59  jont
# [Bug #20103]
# Ensure main-windows is built using libmlw.dll
#
# Revision 1.100  1998/01/20  10:26:02  jkbrook
# [Bug #30289]
# Merging from MLWorks_10r3:
# strip is in /usr/bin on Linux
#
# Revision 1.99  1998/01/13  17:38:58  jkbrook
# [Bug #30306]
# Removing incomplete FI from 2.0m2 distribution
#
# Revision 1.98  1997/12/16  14:42:35  jont
# [Bug #30246]
# Move dummy script creation from rts/GNUmakefile to scripts/Makefile
#
# Revision 1.97  1997/12/09  15:55:32  johnh
# [Bug #30185]
# make main-windows and main-windows-g depend on $(proj).rbj to link to resources.
#
# Revision 1.96  1997/10/29  09:40:02  johnh
# [Bug #30059]
# Fix build problem - generate __control_names.sml although only used on Win32 platforms.
#
# Revision 1.95  1997/10/27  13:40:58  johnh
# [Bug #30059]
# Add Win32 specific generated files.
#
# Revision 1.94  1997/10/23  09:59:16  jont
# [Bug #7015]
# Modify definition of RMRECURSIVELY for Win32
#
# Revision 1.93  1997/10/22  15:37:54  daveb
# [Bug #30044]
# Removed main-static from the default list of targets and distributed files.
#
# Revision 1.92  1997/10/09  10:19:23  jont
# [Bug #30279]
# Add localreals implementation
# This corrects some defects in the linux pow function
#
# Revision 1.91  1997/09/10  14:54:42  jont
# [Bug #70004]
# Produce all generated files required to build the rts
# in arch/OS specific directories. Remove gen from all vpaths
# and include paths. Modify the general rule for %.h (which is
# only used for offsets.h) to build its result in gen/$(ARCH)/$(OS)
# Modify all explicit dependencies on offsets.h accordingly
#
# Revision 1.90  1997/09/03  15:10:47  jkbrook
# [Bug #30227]
# Getting mlw_mklic to make recursively under Windows
#
# Revision 1.89  1997/09/01  16:32:33  jkbrook
# [Bug #30227]
# New cross-platform license generator is made recursively
# and from rts/sha not rts/src/sha due to hope restrictions
#
# Revision 1.88  1997/07/28  14:28:20  jont
# [Bug #20098]
# Copy the win32 dlls into rts to avoid path problems
#
# Revision 1.87  1997/07/28  11:35:33  jont
# [Bug #50024]
# Make a runtime script to get the LD_LIBRARY_PATH right automatically
#
# Revision 1.86  1997/07/22  10:36:48  andreww
# [Bug #30045]
# Add targets for the new DLLized runtime
#
# Revision 1.85  1997/06/27  09:26:17  stephenb
# [Bug #30029]
# Add mlw_c_io
#
# Revision 1.84  1997/06/04  11:41:52  jont
# [Bug #1816]
# Allow for possibilty that gcc may write object file direct to
# standard .o file rather than .obj file under Win32.
#
# Revision 1.83  1997/05/22  10:51:04  stephenb
# [Bug #30121]
# Get the new FI into the distribution.
#
# Revision 1.82  1997/05/07  08:36:58  stephenb
# Request 30030: add mlw_ci_os and mlw_ci to list of modules.
#
# Revision 1.81  1997/04/08  10:49:14  jont
# Adding src/OS/$OS_TYPE/arch/$ARCH to path
#
# Revision 1.80  1997/04/07  10:28:37  jont
# [Bug #0]
# Fix problems creating mlimage-windows.bat and friends under new make
#
# Revision 1.79  1997/03/13  18:22:21  jont
# [Bug #0]
# Make generated stuff first
#
# Revision 1.78  1997/03/03  12:52:00  matthew
# Adding dtoa.c
#
# Revision 1.77  1997/01/28  11:31:52  nickb
# Change make rules for test_fixup, so that it gets the license archive
# for linking.
#
# Revision 1.76  1997/01/10  16:02:26  jont
# [Bug #1890]
# Removed all recursive makes, replacing with an equivalent but better mechanism
#
# Revision 1.75  1997/01/08  15:32:18  jont
# [Bug #1816]
# Modify to use improved PC make
#
# Revision 1.74  1996/12/24  14:58:00  jont
# [Bug #1816]
# Remove expiry from list of modules
#
# Revision 1.73  1996/12/19  12:28:48  jont
# [Bug #1809]
# Stop make clean deleting runtime.res, which is no longer a generated file
#
# Revision 1.72  1996/11/20  11:10:45  jont
# [Bug #0]
# Ensure splash.bmp is added to Win32 distribution
#
# Revision 1.71  1996/11/19  14:04:32  jont
# Add stuff to make the registerer
#
# Revision 1.70  1996/11/07  14:57:06  daveb
# Support for registration-style licensing:
# Added src/sha to INCLUDE directories and vpath; added sha to MODULES.
#
# Revision 1.69  1996/11/06  15:41:31  jont
# Modifications mlimage splits into mlimage-windows and mlimage-console
#
# Revision 1.68  1996/10/28  14:19:45  stephenb
# As discussed in mlworks.mail.{8739,8740}, change do-make to ./do-make
# so that it is not necessary for . to be your path.
#
# Revision 1.67  1996/10/17  16:02:36  jont
# Merging in license server stuff
#
# Revision 1.66.2.2  1996/10/08  16:16:51  jont
# Add license serving stuff
#
# Revision 1.66.2.1  1996/10/07  16:13:05  hope
# branched from 1.66
#
# Revision 1.66  1996/07/02  15:40:00  jont
# Add dummy files for the scripts under NT so install process will remove them properly
#
# Revision 1.65  1996/06/26  15:22:27  brianm
# Removed unnecessary dependnecies on libml.h ...
#
# Revision 1.64  1996/06/22  13:20:48  brianm
# Adding expiry to CMODULES.
#
# Revision 1.63  1996/06/13  13:00:31  jont
# Sort out problems with libml.h in NT distribution
#
# Revision 1.62  1996/06/07  12:46:51  jont
# Ensure distributed files are made suitably readable
#
# Revision 1.61  1996/06/04  13:26:21  brianm
# Adding src/foreign/auxfiles/libml.h to distribution ...
#
# Revision 1.60  1996/05/31  11:42:57  stephenb
# Fix the problem with the dependency on the generated file os_errors.c
# which make it impossible to do a build in a clean directory without
# manually creating gen/$(ARCH)/$(OS).
#
# Revision 1.59  1996/05/29  14:24:06  stephenb
# Add support for Timer as defined in March 1996 basis definition.
#
# Revision 1.58  1996/05/24  15:04:17  stephenb
# Add generated file os_errors to sources and modify vpath to pick it up
# from rts/gen/$(ARCH)/$(OS).
#
# Revision 1.57  1996/05/14  16:37:38  jont
# Fix problem building main-windows
#
# Revision 1.56  1996/05/13  16:04:02  nickb
# Make "include" and "define" C compiler options more portable.
#
# Revision 1.55  1996/05/07  10:00:38  stephenb
# Add time_date and os_io_poll to the list of source files.
#
#

#
# Most of this Makefile should be split into common and OS specific 
# portions with the latter being moved off to OS/{Win32,Unix}/GNUmake
#

# To make, provide environment variables OS, ARCH:
# 
# (SunOS, SPARC), (Solaris, SPARC), (Irix, MIPS), ...
#
# and do "gnumake"

CMODULES = alloc allocator arena bytearrays cache diagnostic endian \
          environment event exceptions fi_call_stub fixup foreign_loader \
          gc global image implicit initialise integers intercept \
          libml license lists loader marshal mem modules \
          options pack_words pervasives print profiler reals dtoa stacks state \
          streams strings system time trace utils value values vector words \
          os signals stubs threads mach_state arch_code exec_delivery explore \
          export time_date os_io_poll os_errors mlw_timer mlw_ci_os \
	  mlw_ci mlw_ci_io localreals ml_utilities

MODULES	= $(CMODULES) main interface
DLLMODULES= $(CMODULES) mlw_dll interface 

# RTSMODULES contains the list of objects used to build the workaround
# rts that loads the runtime dynamic library and behaves "as if" it were
# the normal runtime.   for unix platforms, main_stub suffices, but for
# windows, we also need heap (because it is this workaround that is used
# when delivering executables: the delivered heap is inserted into the
# workaround).

RTSMODULES= main_stub

MODULESSTATIC = $(MODULES)

ifeq "$(OS)" "NT"
NTTYPE=TRUE
else
ifeq "$(OS)" "Win95"
NTTYPE=TRUE
else
NTTYPE=FALSE
endif
endif

ifeq "$(NTTYPE)" "TRUE"
TARGETFILES	= main main-g main-windows
else
TARGETFILES	= main main-g
endif

TARGETDIR 	= bin/$(ARCH)/$(OS)
NTTARGETDIR 	= bin\\$(ARCH)\\$(OS)
ifeq "$(NTTYPE)" "TRUE"
DISTFILES	= main.exe main-windows.exe libmlw.dll libmlw.lib
else
DISTFILES	= main libmlw.so
endif

GENFILES = objectfile.sml __objectfile.sml \
           implicit.sml __implicit.sml \
           tags.sml __tags.sml \
	   __control_names.sml \
           $(ARCH)/$(OS)/offsets.h \
           $(ARCH)/$(OS)/asm_offsets.h \
           fi_call_stub.c fi_call_stub.h \
           $(ARCH)/$(OS)/os_errors.c

INCLUDEDIRS    = gen/$(ARCH)/$(OS) gen src/OS/$(OS)/arch/$(ARCH) \
                 src/OS/$(OS) src/OS/$(OS_TYPE) src/OS/$(OS_TYPE)/arch/$(ARCH) \
		 src/arch/$(ARCH) src

DEFINES      =
DEFINESDEBUG = DEBUG DIAGNOSTICS COLLECT_STATS EXPLORER

FI_CALL_SIZE    = 32
# Maximum number of arguments to foreign foreign calls

ifeq "$(NTTYPE)" "TRUE"
OBJ		= obj
RM		= rm
RMRECURSIVELY   = rm -r -f
AWK		= gawk
MKDIR           = mkdir -p
MKDIREND        =
QUOTE		= "
EXEC            = sh -c
TAR 		= tar
else
OBJ		= o
RM              = /bin/rm -f
RMRECURSIVELY   = /bin/rm -r -f
AWK		= /usr/bin/awk
# mkdir -p on Irix warns and errors if a directory already exists
MKDIR		= /bin/mkdir -p 2>/dev/null
MKDIREND	= || :
QUOTE		= '
EXEC            =
TAR 		= /bin/tar
endif

LN		= /bin/ln
FIND            = /bin/find
AS		= as

ifeq "$(OS)" "Linux"
STRIP		= /usr/bin/strip
else
STRIP		= /bin/strip
endif

chmod_exec=chmod 775
chmod_read_only=chmod 444

# now include the target-specific makefiles, which can redefine any of
# the above macros as it likes. Typically will add to MODULES,
# DEFINES, INCLUDES, LIBRARIES, and may tinker with CCOPTS.

# Need to define OBJECTDIR first so this included file can see it.

OBJECTDIR	= obj/$(ARCH)/$(OS)
OBJ		= o

include src/OS/$(OS)/arch/$(ARCH)/GNUmake
include src/OS/$(OS_TYPE)/GNUmake

GENERATED      = $(GENFILES:%=gen/%)
OBJECTS         = $(MODULES:%=$(OBJECTDIR)/%.$(OBJ))
DLLOBJECTS      = $(DLLMODULES:%=$(OBJECTDIR)/%.$(OBJ))
RTSOBJECTS	= $(RTSMODULES:%=$(OBJECTDIR)/%.$(OBJ))
OBJECTSDEBUG    = $(MODULES:%=$(OBJECTDIR)/%-g.$(OBJ))
DLLOBJECTSDEBUG = $(DLLMODULES:%=$(OBJECTDIR)/%-g.$(OBJ))
RTSOBJECTSDEBUG = $(RTSMODULES:%=$(OBJECTDIR)/%-g.$(OBJ))
OBJECTSSBR	= $(CMODULES:%=%.sbr)
DLLOBJECTSSBR	= $(CMODULES:%=%.sbr) mlw_dll.sbr
OBJECTSSTATIC   = $(MODULESSTATIC:%=$(OBJECTDIR)/%.$(OBJ))
TARGETS 	= $(TARGETFILES:%=$(TARGETDIR)/%)
DISTRIB		= $(DISTFILES:%=$(TARGETDIR)/%)
ifeq "$(NTTYPE)" "TRUE"
DISTRIBUTED	= $(DISTRIB) runtime.ico splash.bmp splash_free.bmp
else
DISTRIBUTED	= $(DISTRIB) splash.xpm splash_free.xpm
endif

TESTFIXOBJECTS	= $(subst main,test_fixup,$(OBJECTSDEBUG))

DEPENDDIR	= depend/$(ARCH)/$(OS)

ifeq "$(NTTYPE)" "TRUE"
RUNTIMES	= runtime runtime-g runtime-windows runtime-windows-g
else
RUNTIMES	= runtime runtime-g runtime-static
endif

all: $(GENERATED) $(RUNTIMES)
generated: $(GENERATED)
objects: $(OBJECTS)
objectsdebug: $(OBJECTSDEBUG)

# === MAKE DIRECTIVES ===

# Disable traditional suffix searches.

.SUFFIXES:

# == General Rules ==

$(DEPENDDIR)/%.d: %.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(DEPENDDIR) $(MKDIREND)
	@$(DEPENDGEN) $(DEPENDGENFLAGS) $< | sed $(QUOTE)/:/s!$*.$(OBJ)!$(OBJECTDIR)/$*.$(OBJ) $(OBJECTDIR)/$*-g.$(OBJ) $@!$(QUOTE) > $@

# bit of a bizarre rule here; when making the dependency files, gnumake
# needs the directory of the source file to exist in order to make it.
# In the case of the fi_call_stub.d dependency, this is gen/

$(DEPENDDIR)/%.d: misc/%_c_gen.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen $(MKDIREND)



# gen/$(ARCH)/$(OS)/os_errors.c is automatically generated (see 
# rts/src/OS/{Win32,Unix}/GNUmake) and so does not exist when the dependency
# maker runs.  This confuses it no end and it fails to generate a dependency
# file.  The following rule makes the dependency maker build the C file before
# continuing, so all is well.  There may be a better way of doing this, but I 
# don't know it.

$(DEPENDDIR)/os_errors.d: gen/$(ARCH)/$(OS)/os_errors.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(DEPENDDIR) $(MKDIREND)
	@$(DEPENDGEN) $(DEPENDGENFLAGS) $< | sed $(QUOTE)/:/s!os_errors.$(OBJ)!$(OBJECTDIR)/os_errors.$(OBJ) $(OBJECTDIR)/os_errors-g.$(OBJ) $@!$(QUOTE) > $@


$(DEPENDDIR)/%.d: %.S
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(DEPENDDIR) $(MKDIREND)
	@$(DEPENDGEN) $(DEPENDGENFLAGS) $< | sed $(QUOTE)/:/s!$*.$(OBJ)!$(OBJECTDIR)/$*.$(OBJ) $(OBJECTDIR)/$*-g.$(OBJ) $@!$(QUOTE) > $@

$(OBJECTDIR)/%-dll.$(OBJ): %.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(COMPILE) /DRUNTIME_DLL $(COMPILEFLAGS)$@ $<

$(OBJECTDIR)/%.$(OBJ): %.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(COMPILE) $(COMPILEFLAGS)$@ $<

$(OBJECTDIR)/%-dll-g.$(OBJ): %.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(COMPILE) /DRUNTIME_DLL $(COMPILEFLAGSDEBUG)$@ $<

$(OBJECTDIR)/%-g.$(OBJ): %.c
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(COMPILE) $(COMPILEFLAGSDEBUG)$@ $<

$(OBJECTDIR)/%.$(OBJ): %.S
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(ASM) $(ASMFLAGS)$@ $<
ifeq "$(NTTYPE)" "TRUE"
	@if test -f $(OBJECTDIR)/$*.$(OBJ); then mv $(OBJECTDIR)/$*.$(OBJ) $@; fi
endif

$(OBJECTDIR)/%-g.$(OBJ): %.S
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(OBJECTDIR) $(MKDIREND)
	@$(ASM) $(ASMFLAGSDEBUG)$@ $<
ifeq "$(NTTYPE)" "TRUE"
	@if test -f $(OBJECTDIR)/$*.$(OBJ); then mv $(OBJECTDIR)/$*-g.$(OBJ) $@; fi
endif

gen/%.sml: src/%.h awk/%.awk
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen $(MKDIREND)
	@$(AWK) -f awk/$*.awk < src/$*.h > gen/$*.sml

gen/__%.sml: src/%.h awk/__%.awk
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen $(MKDIREND)
	@$(AWK) -f awk/__$*.awk < src/$*.h > gen/__$*.sml

gen/$(ARCH)/$(OS)/%.h: awk/%.awk src/implicit.h
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen/$(ARCH)/$(OS) $(MKDIREND)
	@$(AWK) -f awk/$*.awk < src/implicit.h > $@

# == Specific Rules

gen/__control_names.sml: awk/__control_names.awk resource.h
	echo 'MAKE: $< -> $@'
	$(AWK) -f awk/__control_names.awk < resource.h > $@

gen/$(ARCH)/$(OS)/asm_offsets.h: $(TARGETDIR)/make_asm_offsets
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen/$(ARCH)/$(OS) $(MKDIREND)
	@$(EXEC) $< > $@

$(TARGETDIR)/make_asm_offsets: $(OBJECTDIR)/make_asm_offsets.$(OBJ)
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGS)$@.exe $< $(LINKENDFLAGS) /SUBSYSTEM:console
else
	@$(LINK) $(LINKFLAGS)$@ $< $(LINKENDFLAGS)
endif

$(TARGETDIR)/fi_call_stub_h_gen: $(OBJECTDIR)/fi_call_stub_h_gen.$(OBJ)
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGS)$@.exe $< $(LINKENDFLAGS) -subsystem:console
else
	@$(LINK) $(LINKFLAGS)$@ $< $(LINKENDFLAGS)
endif

gen/fi_call_stub.h: $(TARGETDIR)/fi_call_stub_h_gen
	@echo 'MAKE: $< -> $@'
	@$(MKDIR) gen $(MKDIREND)
	@$< $(FI_CALL_SIZE) > $@

$(TARGETDIR)/fi_call_stub_c_gen: $(OBJECTDIR)/fi_call_stub_c_gen.$(OBJ)
	@echo 'MAKE: $< -> $@'
	$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGS)$@.exe $< $(LINKENDFLAGS) -subsystem:console 
else
	@$(LINK) $(LINKFLAGS)$@ $< $(LINKENDFLAGS)
endif

gen/fi_call_stub.c: $(TARGETDIR)/fi_call_stub_c_gen
	@echo 'MAKE: $< -> $@'
	$(MKDIR) gen $(MKDIREND)
	$< $(FI_CALL_SIZE) > $@

# Have to put explicit dependencies on the offsets files here, because
# Make isn't smart enough to figure them all out (in fact, because gcc
# -MM insists on finding all the depended-upon files, rather than
# recording them as dependencies).

$(OBJECTDIR)/interface.$(OBJ): gen/$(ARCH)/$(OS)/offsets.h gen/$(ARCH)/$(OS)/asm_offsets.h
$(OBJECTDIR)/interface-g.$(OBJ): gen/$(ARCH)/$(OS)/offsets.h gen/$(ARCH)/$(OS)/asm_offsets.h
$(OBJECTDIR)/poly_equal.$(OBJ): gen/$(ARCH)/$(OS)/offsets.h
$(OBJECTDIR)/poly_equal-g.$(OBJ): gen/$(ARCH)/$(OS)/offsets.h
$(OBJECTDIR)/foreign_loader-g.$(OBJ): gen/fi_call_stub.h
$(OBJECTDIR)/foreign_loader.$(OBJ): gen/fi_call_stub.h
$(OBJECTDIR)/fi_call_stub.$(OBJ): gen/fi_call_stub.h gen/fi_call_stub.c
$(OBJECTDIR)/fi_call_stub-g.$(OBJ): gen/fi_call_stub.h gen/fi_call_stub.c


# == Search paths ==
#
# NOTE: The order of these paths is IMPORTANT.  Please think about it.

# C sources may be located in general source and architecture-specific
# directories.

vpath %.c \
  src/OS/$(OS)/arch/$(ARCH) \
  src/OS/$(OS) \
  src/OS/$(OS_TYPE) \
  src/OS/$(OS_TYPE)/arch/$(ARCH) \
  src/arch/$(ARCH) \
  src \
  gen/$(ARCH)/$(OS) \
  gen \
  misc

# C headers may be generated.

vpath %.h gen/$(ARCH)/$(OS) misc

# Name-value and name-offset definition files are like C sources.
# 
# vpath %.nv \
#   src/OS/$(OS)/arch/$(ARCH) \
#   src/OS/$(OS) \
#   src/arch/$(ARCH) \
#   src gen
# 
# vpath %.no \
#   src/OS/$(OS)/arch/$(ARCH) \
#   src/OS/$(OS) \
#   src/arch/$(ARCH) \
#   src gen

# Note that assembler sources may only be located in
# architecture-specific directories.

vpath %.S \
  src/OS/$(OS)/arch/$(ARCH) \
  src/arch/$(ARCH) \
  gen/$(ARCH)/$(OS)

# === AUTOMATIC DEPENDENCIES ===
#
# Dependency files are kept in the depend directory and are
# automatically kept up to date by the general rules above.
# For details, see the GNU make documentation.

include $(MODULESSTATIC:%=$(DEPENDDIR)/%.d)
include $(DEPENDDIR)/test_fixup.d

# === TARGETS ===

$(TARGETDIR)/libmlw: $(DLLOBJECTS)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) /LD $(LINKFLAGS)$@ $(DLLOBJECTS) $(DLLLIBRARIES) $(LIBRARIES) $(LINKENDFLAGS) /SUBSYSTEM:console
else
# 	for the sole benefit of Irix 5.1 OS, we have to name the shared library
# 	"libmlw.so" rather than "bin/MIPS/Irix/libmlw.so", otherwise at
# 	run time the system will start looking for a shared object called
#	"bin/MIPS..."
	@$(LINK) $(DLLFLAGS) $(LINKFLAGS) libmlw.so $(DLLOBJECTS) $(LIBRARIES) $(DLLLIBRARIES) $(LINKENDFLAGS)
	@mv libmlw.so $(TARGETDIR)
endif



$(TARGETDIR)/libmlw-g: $(DLLOBJECTSDEBUG)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) /LDd  $(LINKFLAGSDEBUG)$@ $(DLLOBJECTSDEBUG) $(DLLLIBRARIES) $(LIBRARIES) $(LINKENDFLAGSDEBUG) /SUBSYSTEM:console
	@bscmake /oruntime-g.bsc $(DLLOBJECTSSBR)
else
#see note in libmlw target
	@$(LINK) $(DLLFLAGS) $(LINKFLAGS)libmlw-g.so $(DLLOBJECTSDEBUG) $(LIBRARIES) $(DLLLIBRARIES) $(LINKENDFLAGS)
	@mv libmlw-g.so $(TARGETDIR)
endif





#Runtime as a shared object.  Creates both a "libmlw" dynamic
#library and an rts workaround which simply calls it in the target
#directory.  Note that the fact that we don't build a dynamic library
#runtime on SunOS is handled at the top level runtime target.

ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/main: $(TARGETDIR)/libmlw $(RTSOBJECTS) $(proj)-res.$(OBJ)
else
$(TARGETDIR)/main: $(TARGETDIR)/libmlw $(RTSOBJECTS)
endif
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGS)$@ $(RTSOBJECTS) $(proj)-res.$(OBJ) $(TARGETDIR)/libmlw.lib  $(LINKENDFLAGS) /SUBSYSTEM:console
else
	@$(LINK) $(LINKFLAGS)$@ $(RTSOBJECTS) -L$(TARGETDIR) -lmlw $(LINKENDFLAGS)
	@$(STRIP) $@
endif


ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/old-main: $(OBJECTS) $(proj)-res.$(OBJ)
else
$(TARGETDIR)/old-main: $(OBJECTS)
endif
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGS)$(TARGETDIR)/main $(OBJECTS) $(proj)-res.$(OBJ) $(LIBRARIES) $(LINKENDFLAGS) /SUBSYSTEM:console
else
	@$(LINK) $(LINKFLAGS)$(TARGETDIR)/main $(OBJECTS) $(LIBRARIES) $(LINKENDFLAGS)
	@$(STRIP) $(TARGETDIR)/main
endif

ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/main-windows: $(TARGETDIR)/libmlw $(RTSOBJECTS) $(proj)-res.$(OBJ)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
	@$(LINK) $(LINKFLAGS)$@ $(RTSOBJECTS) $(proj)-res.$(OBJ) $(TARGETDIR)/libmlw.lib  $(LINKENDFLAGS) /SUBSYSTEM:windows
endif

ifeq "$(NTTYPE)" "TRUE"
else
$(TARGETDIR)/main-static: $(OBJECTSSTATIC)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
	@$(LINK) -Xlinker -Bstatic $(LINKFLAGS)$@ $(OBJECTSSTATIC) $(LIBRARIESSTATIC) $(LINKENDFLAGS)
	@$(STRIP) $@
endif



ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/main-g: $(TARGETDIR)/libmlw-g $(RTSOBJECTSDEBUG) $(proj)-res.$(OBJ)
else
$(TARGETDIR)/main-g: $(TARGETDIR)/libmlw-g $(RTSOBJECTSDEBUG)
endif
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGSDEBUG)$@  $(RTSOBJECTSDEBUG) $(proj)-res.$(OBJ) $(TARGETDIR)/libmlw-g.lib $(LINKENDFLAGS) /SUBSYSTEM:console
	@bscmake /oruntime-g.bsc $(OBJECTSSBR) main_stub.sbr
else
	@$(LINK) $(LINKFLAGSDEBUG)$@ $(RTSOBJECTSDEBUG) -L$(TARGETDIR) -lmlw-g $(LINKENDFLAGS)
endif


ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/old-main-g: $(OBJECTSDEBUG) $(proj)-res.$(OBJ)
else
$(TARGETDIR)/old-main-g: $(OBJECTSDEBUG)
endif
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
ifeq "$(NTTYPE)" "TRUE"
	@$(LINK) $(LINKFLAGSDEBUG)runtime-g  $(OBJECTSDEBUG) $(proj)-res.$(OBJ) $(LIBRARIES) $(LINKENDFLAGSDEBUG) /SUBSYSTEM:console
	@cp runtime-g.exe $(TARGETDIR)/main-g.exe
	@bscmake /oruntime-g.bsc $(OBJECTSSBR) main.sbr
else
	@$(LINK) $(LINKFLAGSDEBUG)$(TARGETDIR)/main-g $(OBJECTSDEBUG) $(LIBRARIES) $(LINKENDFLAGSDEBUG)
endif




ifeq "$(NTTYPE)" "TRUE"
$(TARGETDIR)/main-windows-g: $(TARGETDIR)/libmlw-g $(RTSOBJECTSDEBUG) $(proj)-res.$(OBJ)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
	@$(LINK) $(LINKFLAGSDEBUG)$@  $(RTSOBJECTSDEBUG) $(proj)-res.$(OBJ) $(TARGETDIR)/libmlw-g.lib $(LINKENDFLAGS) /SUBSYSTEM:windows
	@bscmake /oruntime-g.bsc $(OBJECTSSBR) main_stub.sbr
endif

$(TARGETDIR)/test_fixup-g: $(TESTFIXOBJECTS)
	@echo 'MAKE: $@'
	@$(MKDIR) $(TARGETDIR) $(MKDIREND)
	@$(LINK) $(LINKFLAGSDEBUG) $@ $(TESTFIXOBJECTS) $(LIBRARIES) $(LINKENDFLAGSDEBUG)
 
# === PSUEDO TARGETS ===

clean: force
ifeq "$(NTTYPE)" "TRUE"
	$(RM) -f $(OBJECTDIR)/* $(TARGETDIR)/* $(RUNTIMES:%=%.exe) runtime-res.$(OBJ) libmlw.dll libmlw-g.dll
else
	$(RM) -f $(OBJECTDIR)/* core $(TARGETDIR)/* $(RUNTIMES)
endif

cleandepend: force
	$(RM) $(DEPENDDIR)/*

cleangen: force
	$(RMRECURSIVELY) gen/*

#the following creates a dynamic library version of the runtime
#on all platforms except SunOS, which just builds a normal runtime.

ifeq "$(OS)" "SunOS"
runtime: old-runtime
else
runtime: force $(TARGETDIR)/main
endif
ifeq "$(NTTYPE)" "TRUE"
	@rm -f $@.exe
	cp $(TARGETDIR)/main.exe $@.exe
	cp $(TARGETDIR)/libmlw.dll .
else
	@$(RM) $@
	@echo '#!/bin/sh' > $@
	@echo 'exec_dir=`dirname $$0`' >> $@
	@echo 'LD_LIBRARY_PATH=$$exec_dir/bin/${ARCH}/${OS}:$$LD_LIBRARY_PATH;export LD_LIBRARY_PATH'  >> $@
	@echo '$$exec_dir/bin/${ARCH}/${OS}/main $$*' >> $@
	@chmod 775 $@
endif

old-runtime: force $(TARGETDIR)/old-main
ifeq "$(NTTYPE)" "TRUE"
	@rm -f runtime.exe
	cp $(TARGETDIR)/main.exe runtime.exe
else
	@$(RM) runtime
	$(LN) -s $(TARGETDIR)/main runtime
endif

ifeq "$(NTTYPE)" "TRUE"
runtime-windows: force $(TARGETDIR)/main-windows
	@rm -f $@.exe
	cp $(TARGETDIR)/main-windows.exe $@.exe
	cp $(TARGETDIR)/libmlw.dll .
endif

ifeq "$(NTTYPE)" "TRUE"
else
runtime-static: force $(TARGETDIR)/main-static
	@$(RM) $@
	$(LN) -s $(TARGETDIR)/main-static $@
endif

ifeq "$(OS)" "SunOS"
runtime-g: old-runtime-g
else
runtime-g: force $(TARGETDIR)/main-g
endif
ifeq "$(NTTYPE)" "TRUE"
	@rm -f $@.exe
	cp $(TARGETDIR)/main-g.exe $@.exe
	cp $(TARGETDIR)/libmlw-g.dll .
else
	@$(RM) $@
	@echo '#!/bin/sh' > $@
	@echo 'exec_dir=`dirname $$0`' >> $@
	@echo 'LD_LIBRARY_PATH=$$exec_dir/bin/${ARCH}/${OS}:$$LD_LIBRARY_PATH;export LD_LIBRARY_PATH'  >> $@
	@echo '$$exec_dir/bin/${ARCH}/${OS}/main-g $$*' >> $@
	@chmod 775 $@
endif

old-runtime-g: force $(TARGETDIR)/old-main-g
ifeq "$(NTTYPE)" "TRUE"
	@rm -f runtime-g.exe
	cp $(TARGETDIR)/main-g.exe runtime-g.exe
else
	@$(RM) runtime-g
	$(LN) -s $(TARGETDIR)/main-g runtime-g
endif


ifeq "$(NTTYPE)" "TRUE"
runtime-windows-g: force $(TARGETDIR)/main-windows-g
	@rm -f $@.exe
	cp $(TARGETDIR)/main-windows-g.exe $@.exe
	cp $(TARGETDIR)/libmlw-g.dll .
endif


test_fixup-g: $(TARGETDIR)/test_fixup-g
	@$(RM) $@
	@$(LN) -s $(TARGETDIR)/test_fixup-g $@

distribution: $(DISTRIBUTED)
	cd $(DISTDIR) && $(RM) -rf bin
	$(MKDIR) $(DISTDIR)/bin $(MKDIREND)
	$(MKDIR) $(DISTDIR)/bin/$(ARCH) $(MKDIREND)
	$(MKDIR) $(DISTDIR)/bin/$(ARCH)/$(OS) $(MKDIREND)
	cp $(DISTRIBUTED) $(DISTDIR)/bin/$(ARCH)/$(OS)
	chmod o+r $(DISTDIR)/bin/$(ARCH)/$(OS)/*
	cd $(DISTDIR) && $(RM) -rf examples
	$(MKDIR) $(DISTDIR)/examples
	$(chmod_exec) $(DISTDIR)/examples

force:
