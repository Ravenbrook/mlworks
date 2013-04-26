# ==== BUILD MLWORKS IMAGES ====
#
# Instructions
# ------------
# This makefile builds images in the usual way, but has extra targets
# called *-files for producing files containing lists of .mo's for use
# with the runtime system `-from' option.  This makes debugging using
# adb possible since adb will not accept the massive command lines
# generated for the normal rules.
#
# To build images from a source tree other than `..' use:
#
#   make SRC='source directory name' target...
#
# To build the file list for the parser relative to /usr/sml, for
# example, use:
#
#   make SRC=/usr/sml parser-files
#
# note --- owing to repeated use of MAKE_COMMAND in rules, do not use
# make -f <mymakefile> --- this option will not be passed to the recursive
# calls, and therefore the make will fail.
#
# Revision Log
# ------------
#
# $Log: Makefile,v $
# Revision 1.118  1999/03/18 17:34:14  daveb
# [Bug #190523]
# Moved basis/*flags to basis/*bit_flags.
# Added the generated statuses file.
# Set the pervasive directory explicitly when loading the basis.
#
# Revision 1.117  1999/03/08  13:59:13  mitchell
# [Bug #30286]
# Build Windows structure into guib image
#
# Revision 1.116  1999/03/08  11:02:06  mitchell
# [Bug #30286]
# Export Windows structure
#
# Revision 1.115  1999/02/10  17:28:31  mitchell
# [Bug #190507]
# Add new dependency files to makefile.
#
# Revision 1.114  1999/02/09  09:50:00  mitchell
# [Bug #190505]
# Support for precompilation of subprojects
#
# Revision 1.113  1998/10/27  15:32:42  jont
# [Bug #70222]
# Reinstate Windows structure in guib.img
#
# Revision 1.112  1998/10/21  13:37:57  jont
# [Bug #70196]
# Add link support stuff
#
# Revision 1.111  1998/10/19  15:24:43  jont
# [Bug #70203]
# Modify for new argument passing
#
# Revision 1.110  1998/09/25  15:33:36  jont
# [Bug #30108]
# Add rules for making DLLs
#
# Revision 1.109  1998/08/20  15:36:46  jont
# [Bug #70133]
# Add COFF outputter
#
# Revision 1.108  1998/07/31  13:56:25  jkbrook
# [Bug #30454]
# Remove Windows structure from distribution until it is more robust
# and the Unix structure is also implemented
#
# Revision 1.107  1998/07/08  10:15:46  jont
# [Bug #20123]
# Remove basis/{,__}list from list of gui files
#
# Revision 1.106  1998/07/03  12:32:18  mitchell
# [Bug #30434]
# Change load order to allow _win_ntgetenv to use Windows structure
#
# Revision 1.105  1998/06/08  12:20:08  mitchell
# [Bug #30418]
# Add sectioned_file etc
#
# Revision 1.104  1998/05/06  14:36:06  jkbrook
# [Bug #30354]
# Temporarily restore old FI to distribution
#
# Revision 1.103  1998/04/20  12:13:52  jont
# [Bug #70101]
# Move getenv and messages into compiler and out of basis and parser
#
# Revision 1.102  1998/04/20  10:56:07  jont
# [Bug #70104]
# Fix the script loading flags etc
#
# Revision 1.101  1998/04/07  17:17:07  jont
# [Bug #70086]
# Ensure Flags loaded at top level as well
#
# Revision 1.100  1998/04/07  14:35:25  jont
# [Bug #70086]
# Adding in windows and __windows to basis, guib.img and ttyb.img
#
# Revision 1.99  1998/04/03  16:29:52  jont
# [Bug #70088]
# Get rid of cat
#
# Revision 1.98  1998/04/01  12:20:57  jont
# [Bug #70086]
# *windows has moved to *windows_gui
#
# Revision 1.97  1998/03/31  12:06:28  jont
# [Bug #70077]
# Removing path, _unixpath, _win_ntpath and __path
# These are replaced by OS.Path
#
# Revision 1.96  1998/03/20  15:15:56  jont
# [Bug #30090]
# cat.img now depends on basis.img
#
# Revision 1.95  1998/03/16  14:04:32  johnh
# [Bug #70081]
# Look for cat.mo in ml_utils/debug now.
#
# Revision 1.94  1998/03/16  11:02:44  johnh
# [Bug #30365]
# Projects now use subprojects.
#
# Revision 1.93  1998/02/26  13:59:52  johnh
# [Bug #30362]
# Setting mode means object files live in a different place.
#
# Revision 1.92  1998/02/19  17:11:27  jont
# [Bug #30071]
# Don't set maximumStrDepth when building guib.img
#
# Revision 1.91  1998/02/18  17:48:26  jont
# [Bug #70070]
# Add terminal.mo and __terminal.mo to COMPILER
#
# Revision 1.90  1998/02/10  15:58:51  jont
# [Bug #70065]
# Load messages and __messages before getenv
#
# Revision 1.89  1998/01/30  17:03:52  johnh
# [Bug #30071]
# Merge in Project Workspace changes.
#
# Revision 1.88  1997/10/29  10:19:06  johnh
# [Bug #30059]
# __control_names.sml (generated) now lives in rts/gen
#
# Revision 1.87  1997/10/27  13:23:40  johnh
# [Bug #30059]
# Implement interface to Win32 resource dialogs.
#
# Revision 1.86  1997/10/21  12:03:36  jont
# [Bug #30089]
# Removing OldOS
#
# Revision 1.85  1997/09/30  09:19:10  jkbrook
# [Bug #30247]
# TTY listener gets confused by error messages during distribution
# builds -- implementing workaround
#
# Revision 1.84.2.7  1998/01/19  12:26:53  daveb
# [Bug #30071]
# Set ARCH_OS to I386/NT, if not already set.  Use this in ttyb.img & guib.img.
# Added missing backslashes to path of cat.mlp.
#
# Revision 1.84.2.5  1997/11/26  17:32:16  daveb
# [Bug #30071]
# Removed basics/*module.
#
# Revision 1.84.2.4  1997/11/26  13:29:17  daveb
# [Bug #30071]
# Source and object paths are redundant.  Need to use Shell.Project to build
# guib.img.
#
# Revision 1.84.2.3  1997/11/25  15:01:50  daveb
# [Bug #30326]
# Renamed utils/*timer to utils/*mlworks_timer and main/*io to main/*mlworks_io.
#
# Revision 1.84.2.2  1997/09/12  14:52:41  johnh
# [Bug #30071]
# Redesign Compilation Manager -> Project Workspace.
# New files: main/*proj_file.sml
#
# Revision 1.84  1997/05/23  12:07:39  jont
# [Bug #30090]
# Replace MLWorks.IO with TextIO where applicable
#
# Revision 1.83  1997/05/16  10:46:46  stephenb
# [Bug #30121]
# Move to new FI: remove any reference to foreign.img
#
# Revision 1.82  1997/05/13  22:06:16  jont
# Further modifications after change to encapsulator to use basis io
# Part of bug 30091
#
# Revision 1.81  1997/05/09  14:36:23  jont
# [Bug #30091]
# Make various basis code available to encapsulator
#
# Revision 1.80  1997/01/08  17:03:37  jont
# [Bug #1816]
# [Bug #1816]
# Improvements to use new (beta-17) GNU tools
#
# Revision 1.79  1997/01/06  16:51:01  andreww
# [Bug #1885]
# removing two spaces at end of line 193.
#
# Revision 1.78  1996/12/18  13:36:29  matthew
# lambda optimizer changes
#
# Revision 1.77  1996/10/31  14:08:47  jont
# [Bug #1709]
# Fix problems building cat.mo from cat.sml following registry changes
#
# Revision 1.76  1996/10/23  13:26:08  jont
# [Bug #1696]
# Add -batch to RUNTIMEOPTS
#
# Revision 1.75  1996/10/09  14:31:28  jont
# [Bug #1642]
# Modify make mechanism for guib.img to load object files instead of compiling source
#
# Revision 1.74  1996/09/04  16:52:28  jont
# Remove tty.img from list of files to be made for all
#
# Revision 1.73  1996/09/04  14:42:33  jont
# Extend list of targets for all to include all distributed targets
#
# Revision 1.72  1996/07/22  17:35:02  brianm
# Adding existence check for $(CATMO) before rm $(CATMO) ...
#
# Revision 1.71  1996/06/28  17:26:12  jont
# Ensure CATMO rebuilt if a new batch compiler produced
#
# Revision 1.70  1996/06/28  13:04:25  andreww
# Ensuring ARCH_OS values are propagated to recursive calls of make
# and that they are used to find correct object paths for NTGUIMO.
#
# Revision 1.69  1996/06/27  11:47:43  jont
# Add missing dependency of CATMO on batch.img
#
# Revision 1.68  1996/06/11  10:19:22  jont
# Make guib.img from the right things (basis, not foreign)
#
# Revision 1.67  1996/06/04  10:03:09  jont
# Remove BASISSYS, no longer necessary
#
# Revision 1.66  1996/05/21  09:39:39  jont
# Moving preferences out of batch system
#
# Revision 1.65  1996/05/17  09:42:41  stephenb
# Change filesys -> file_sys in accordance with latest file naming conventions.
#
# Revision 1.64  1996/05/17  07:24:26  stephenb
# Remove redundant references to files.
# PARSERSYS basis/path is now loaded in images/GNUmake.
#
# Revision 1.63  1996/05/16  17:03:30  jont
# ** No reason given. **
#
# Revision 1.62  1996/05/16  16:51:29  jont
# Set SYSTEM explicitly here
#
# Revision 1.61  1996/05/15  15:29:24  jont
# Add rule for guib.img, a gui with the revised basis loaded
# Also a rule for ttyb.img
#
# Revision 1.60  1996/05/09  11:39:24  stephenb
# Remove any reference to FILESYS since it is subsumed by PARSERSYS
# now that filesys stuff is needed for the parser.
#
# Revision 1.59  1996/05/08  13:42:49  stephenb
# Rename filesys to be os_filesys in line with latest file naming conventions.
#
# Revision 1.58  1996/05/08  11:25:04  stephenb
# Change any reference to basis/lists -> basis/list now that the
# file has been changed to have the same name as the signature.
#
# Revision 1.57  1996/04/29  17:28:51  jont
# Add rules for basis-files
#
# Revision 1.56  1996/04/29  12:14:44  jont
# Add extra parameter to Shell.saveImage to indicate not to use executable format
#
# Revision 1.55  1996/04/18  17:12:26  jont
# initbasis becomes basis
#
# Revision 1.54  1996/04/03  12:24:04  stephenb
# Patch up NTGUISRC wrt to change in definition of GUI
#
#
#

all: pervasive.img lexer.img batch.img gui.img guib.img basis.img foreign.img windows.img

everything: all tty.img ttyb.img

PLATFORM_DISTRIBUTED_IMAGES = windows.img


RUNTIME =	$(SRC)/rts/runtime-g
RUNTIMEOPTS =	-verbose -d 1 -delivery	-batch
MODE = 		Release

LEXERSYS =	system/win32 \
		system/_win32 \
		system/__win32 \
		system/win32os \
		system/_win32os \
		system/__win32os

INTERSYS = 	main/stack_interface \
		machine/_stack_interface \
		machine/__stack_interface \
		editor/editor \
		system/_editor \
		system/__editor

COMPILER1 =	utils/getenv \
		utils/messages \
		utils/__messages \
		system/__sys_word \
		system/_win_ntgetenv \
		system/__getenv \
		machine/i386types \
		machine/_i386types \
		machine/__i386types \
		main/machspec \
		utils/bignum \
		utils/_bignum \
		utils/__bignum_inf \
		machine/_i386spec \
		machine/__machspec \
		utils/_bignumsize \
		utils/__bignum \
		basics/scons \
		basics/_scons \
		basics/__scons \
		debugger/debugger_types \
		debugger/_debugger_types \
		debugger/__debugger_types \
		lambda/lambdaprint \
		lambda/_lambdaprint \
		lambda/__lambdaprint \
		lambda/environprint \
		lambda/_environprint \
		lambda/__environprint \
		match/type_utils \
		match/_type_utils \
		match/__type_utils \
		match/match \
		match/_match \
		match/__match \
		lambda/lambda \
		lambda/lambdaoptimiser \
		typechecker/typerep_utils \
		typechecker/_typerep_utils \
		typechecker/__typerep_utils \
		rts/gen/implicit \
		rts/gen/__implicit \
		utils/inthashtable \
		utils/_inthashtable \
		utils/__inthashtable

BASISSYS =	system/win32os \
		system/_win32os \
		system/__win32os 

BASISSYS2 =	system/__sys_word \
                basis/bit_flags \
                basis/__bit_flags \
		rts/gen/I386/NT/keys \
		rts/gen/I386/NT/statuses \
		system/windows \
		system/__windows


COMPILER = $(COMPILER1) main/mlworks_io \
		main/_mlworks_io \
		main/__mlworks_io \
		lambda/_lambda \
		lambda/simpleutils \
		lambda/_simpleutils \
		lambda/__simpleutils \
		lambda/transsimple \
		lambda/_transsimple \
		lambda/__transsimple \
		lambda/lambdaflow \
		lambda/_lambdaflow \
		lambda/__lambdaflow \
		lambda/_simplelambda \
		lambda/__lambdaoptimiser \
		lambda/__lambda \
		utils/monoset \
		utils/intset \
		utils/_intsetlist \
		utils/mutablemonoset \
		mir/virtualregister \
		utils/mutableintset \
		mir/_virtualregister \
		mir/mirtypes \
		mir/_mirtypes \
		utils/_smallintset \
		mir/__mirtypes \
		main/machperv \
		machine/_i386perv \
		machine/__machperv \
		rts/gen/tags \
		rts/gen/__tags \
		debugger/debugger_utilities \
		debugger/_debugger_utilities \
		debugger/__debugger_utilities \
		lambda/auglambda \
		lambda/_auglambda \
		lambda/__auglambda \
		main/library \
		main/_library \
		main/__library \
		mir/mirregisters \
		mir/_mirregisters \
		mir/__mirregisters \
		mir/mirprint \
		mir/_mirprint \
		mir/__mirprint \
		mir/mir_env \
		mir/_mir_env \
		mir/__mir_env \
		mir/mir_utils \
		mir/_mir_utils \
		mir/__mir_utils \
		mir/mirtables \
		mir/_mirtables \
		mir/__mirtables \
		mir/mir_cg \
		mir/_mir_cg \
		mir/__mir_cg \
		mir/mirprocedure \
		mir/registerpack \
		mir/_mirprocedure \
		mir/_registerpack \
		mir/__registerpack \
		mir/__mirprocedure \
		mir/registerallocator \
		mir/mirvariable \
		mir/_mirvariable \
		mir/registercolourer \
		mir/_registercolourer \
		mir/_registerallocator \
		utils/__smallintset \
		mir/__gccolourer \
		mir/__nongccolourer \
		mir/__fpcolourer \
		mir/__registerallocator \
		mir/__mirvariable \
		mir/stackallocator \
		mir/_stackallocator \
		mir/__stackallocator \
		mir/mirexpr \
		mir/_mirexpr \
		mir/__mirexpr \
		mir/miroptimiser \
		mir/_miroptimiser \
		mir/__miroptimiser \
		main/reals \
		main/_reals \
		main/__reals \
		main/code_module \
		main/__code_module \
		machine/i386_opcodes \
		machine/_i386_opcodes \
		machine/__i386_opcodes \
		machine/i386_assembly \
		machine/_i386_assembly \
		machine/__i386_assembly \
		machine/i386_schedule \
		machine/_i386_schedule \
		machine/__i386_schedule \
		main/mach_cg \
		machine/_i386_cg \
		machine/__mach_cg \
		main/machprint \
		machine/_i386print \
		machine/__machprint \
		rts/gen/__objectfile \
		rts/gen/objectfile \
		lambda/lambdamodule \
		lambda/_lambdamodule \
		lambda/__lambdamodule \
		main/enc_sub \
		main/_enc_sub \
		main/__enc_sub \
		basis/byte \
		basis/__byte \
		main/encapsulate \
		main/_encapsulate \
		main/__encapsulate \
		main/compiler \
		main/_compiler \
		main/__compiler \
		make/depend \
		make/_depend \
		make/__depend \
		utils/terminal \
		utils/__terminal \
		main/sectioned_file \
		main/_sectioned_file \
		main/__sectioned_file \
		main/proj_file \
		main/_proj_file \
		main/__proj_file \
		main/file_time \
		system/__file_time \
		main/link_support \
		system/_win_nt_link_support \
		system/__link_support \
		dependency/module_name \
		dependency/_module_name \
		dependency/__module_name \
		dependency/module_dec \
		dependency/_module_dec \
		dependency/__module_dec \
		dependency/import_export \
		dependency/_import_export \
		dependency/__import_export \
		dependency/convert_ast \
		dependency/_convert_ast \
		dependency/__convert_ast \
		dependency/module_dec_io \
		dependency/_module_dec_io \
		dependency/__module_dec_io \
		dependency/ordered_set \
		dependency/__ordered_set \
		dependency/group_dag \
		dependency/_group_dag \
		main/project \
		main/_project \
		main/__project \
		main/object_output \
		machine/_i386_object_output \
		machine/__object_output \
		main/toplevel \
		main/_toplevel \
		main/__toplevel \
		main/user_options \
		main/_user_options \
		main/__user_options

WINSYS =	winsys/windows_gui \
		winsys/_windows_gui \
		winsys/__windows_gui \
		winsys/labelstrings \
		winsys/__labelstrings \
		utils/lisp \
		utils/_lisp \
		utils/__lisp \
		winsys/capitypes \
		winsys/_capitypes \
		winsys/__capitypes \
		winsys/control_names \
		rts/gen/__control_names \
		gui/menus \
		winsys/_menus \
		winsys/__menus \
		gui/capi \
		winsys/_capi \
		winsys/__capi

SYSTEM = system

# ARCH_OS might be already set by the Win95 makefile, which includes
# this one.
ifeq (,$(ARCH_OS))
  ARCH_OS = I386/NT
endif

include ../../GNUmake

NTGUISRC = 	$(WINSYS) $(GUI)
NTGUIMO =	$(addsuffix .mo,$(addprefix $(OBJ)/$(ARCH_OS)/$(MODE)/, $(notdir $(NTGUISRC))))


shell-files: force
	echo $(COMPILERMO) $(SHELLMO) > $@

tty2-files: $(INTERMO) $(TTYMO)
	echo $(INTERMO) $(TTYMO) > $@

gui2-files: $(INTERMO) $(NTGUIMO)
	echo $(INTERMO) $(NTGUIMO) > $@

shell.img: typechecker.img $(COMPILERMO) $(SHELLMO)
	echo make: $@
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img -save $@ $(COMPILERMO) $(SHELLMO) MLWargs -pervasive-dir ${SRC}/pervasive

TTY_LOADER = 'Shell.saveImage("tty.img", false);'

tty.img: shell.img $(INTERMO) $(TTYMO)
	echo make: $@ from shell.img
	echo $(TTY_LOADER) |    \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img $(INTERMO) $(TTYMO) MLWargs

GUI_LOADER = 'Shell.saveImage("gui.img", false);'
GUI_DLL_LOADER = 'Shell.saveImage("gui-dll.img", false);'

gui.img: shell.img $(INTERMO) $(NTGUIMO)
	echo make: $@ from shell.img
	echo $(GUI_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img $(INTERMO) $(NTGUIMO) MLWargs

# note --- in the following rule, if using object-path, the gui2-files
# file can be fairly big, the construction of which may cause the make file
# to crash.  In this instance, the procedure is to make the gui2-files
# manually (do a make -n ARCH_OS=<whatever, e.g. I386/NT/> gui2-files)
# and then cut'n'paste the appropriate files into another file called
# "gui2-files", and edit it so that each .mo file appears on a separate line.
# Then remove the gui2-files dependency from below, and carry on.

GUIB_LOADER = 'Shell.Path.setPervasive "$(SRC)/pervasive"; \
	       Shell.Project.openProject "$(SRC)/basis.mlp"; \
               Shell.Project.setConfiguration "$(ARCH_OS)"; \
               Shell.Project.setTargets ["require_all.sml", \
                                         "platform_specific_exports.sml"]; \
               Shell.Project.loadAll () ; \
               Shell.saveImage("guib.img", false);'

guib.img: shell.img $(INTERMO) $(NTGUIMO) $(BASIS_AND_LOADERMO)
	echo make: $@ from shell.img
	echo $(GUIB_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img $(INTERMO) $(NTGUIMO) MLWargs

TTYB_LOADER = 'Shell.Path.setPervasive "$(SRC)/pervasive"; \
	       Shell.Project.openProject "$(SRC)/basis.mlp"; \
               Shell.Project.setConfiguration "$(ARCH_OS)"; \
               Shell.Project.setTargets ["require_all.sml", \
                                         "platform_specific_exports.sml"]; \
               Shell.Project.loadAll () ; \
               Shell.saveImage("ttyb.img", false);'

ttyb.img: shell.img $(INTERMO) $(TTYMO) $(BASIS_AND_LOADERMO)
	echo make: $@ from shell.img
	echo $(TTYB_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img $(INTERMO) $(TTYMO) MLWargs

PERVASIVE_TEXT_S=${PERVASIVEMO:.mo=_text.S}
PERVASIVE_DATA_S=${PERVASIVEMO:.mo=_data.S}
LEXER_TEXT_S=${LEXERMO:.mo=_text.S}
LEXER_DATA_S=${LEXERMO:.mo=_data.S}
PARSER_TEXT_S=${PARSERMO:.mo=_text.S}
PARSER_DATA_S=${PARSERMO:.mo=_data.S}
TYPER_TEXT_S=${TYPERMO:.mo=_text.S}
TYPER_DATA_S=${TYPERMO:.mo=_data.S}
COMPILER_TEXT_S=${COMPILERMO:.mo=_text.S}
COMPILER_DATA_S=${COMPILERMO:.mo=_data.S}
BATCH_TEXT_S=${BATCHMO:.mo=_text.S}
BATCH_DATA_S=${BATCHMO:.mo=_data.S}
SHELL_TEXT_S=${SHELLMO:.mo=_text.S}
SHELL_DATA_S=${SHELLMO:.mo=_data.S}
INTER_TEXT_S=${INTERMO:.mo=_text.S}
INTER_DATA_S=${INTERMO:.mo=_data.S}
NTGUI_TEXT_S=${NTGUIMO:.mo=_text.S}
NTGUI_DATA_S=${NTGUIMO:.mo=_data.S}

pervasive.lib pervasive.dll:	$(PERVASIVE_TEXT_S) $(PERVASIVE_DATA_S) extend
	echo make: $@
	sh ./make-dll pervasive ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib

lexer.lib lexer.dll:	 ${LEXER_TEXT_s} pervasive.lib extend
	echo make: $@
	sh ./make-dll lexer ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib pervasive.lib

typer.lib typer.dll:	  $(PARSER_TEXT_S) $(TYPER_TEXT_S) pervasive.lib lexer.lib extend
	echo make: $@
	sh ./make-dll typer ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib pervasive.lib lexer.lib

batch.lib batch.dll:	  $(COMPILER_TEXT_S) $(BATCH_TEXT_S) pervasive.lib lexer.lib typer.lib extend
	echo make: $@
	sh ./make-dll batch ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib pervasive.lib lexer.lib typer.lib

shell.lib shell.dll:	  $(COMPILER_TEXT_S) $(SHELL_TEXT_S) pervasive.lib lexer.lib typer.lib extend
	echo make: $@
	sh ./make-dll shell ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib pervasive.lib lexer.lib typer.lib

gui2.lib gui2.dll:	   $(INTER_TEXT_S) $(NTGUI_TEXT_S) pervasive.lib lexer.lib typer.lib shell.lib extend
	echo make: $@
	sh ./make-dll gui2 ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib pervasive.lib lexer.lib typer.lib shell.lib

extend:	extend.c
	gcc extend.c -o $@

xinterpreter:	gui2.lib  shell.lib  typer.lib  lexer.lib  pervasive.lib ${OBJ}/${ARCH_OS}/${MODE}/xinterpreter_text.S ${OBJ}/${ARCH_OS}/${MODE}/xinterpreter_data.S
	echo make: $@
	cp -p ${OBJ}/${ARCH_OS}/${MODE}/xinterpreter_{text,data}.S .
	sh ./make-exe xinterpreter gui2.lib shell.lib typer.lib lexer.lib pervasive.lib ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib

__batch:	batch.lib typer.lib lexer.lib pervasive.lib ${OBJ}/${ARCH_OS}/${MODE}/__batch_text.S ${OBJ}/${ARCH_OS}/${MODE}/__batch_data.S
	echo make: $@
	cp -p ${OBJ}/${ARCH_OS}/${MODE}/__batch_{text,data}.S .
	sh ./make-exe __batch batch.lib typer.lib lexer.lib pervasive.lib ${SRC}/rts/bin/$(ARCH_OS)/libmlw.lib

gui-dll.img:	xinterpreter gui2.dll shell.dll typer.dll lexer.dll pervasive.dll
	echo make: $@
	PATH=.:${SRC}/rts/bin/${ARCH_OS}:${PATH} && echo $(GUI_DLL_LOADER) | ./xinterpreter -tty -pervasive-dir ${SRC}/pervasive -source-path ${SRC} -parser-tables ${SRC}/parser/ml-tables/

GUIB_DLL_LOADER=	\
	'Shell.Project.openProject "${SRC}/basis.mlp";	\
	Shell.Project.setConfiguration "${ARCH_OS}";	\
        Shell.Project.setTargets ["require_all.sml", \
                                  "platform_specific_exports.sml"]; \
	Shell.Project.loadAll () ;			\
	Shell.saveImage("guib-dll.img", false);'

guib-dll.img:	xinterpreter gui2.dll shell.dll typer.dll lexer.dll pervasive.dll  $(BASIS_AND_LOADERMO)
	echo make: $@
	PATH=.:${SRC}/rts/bin/${ARCH_OS}:${PATH} && echo $(GUIB_DLL_LOADER) | ./xinterpreter -tty -pervasive-dir ${SRC}/pervasive -source-path ${SRC} -parser-tables ${SRC}/parser/ml-tables/
