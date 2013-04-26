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
# $Id: Makefile,v 1.71 1999/03/08 11:02:06 mitchell Exp $
#
#

all: pervasive.img lexer.img gui.img batch.img guib.img basis.img foreign.img xm.img

PLATFORM_DISTRIBUTED_IMAGES = xm.img

RUNTIME =	$(SRC)/rts/runtime-g
RUNTIMEOPTS =	-verbose -d 1 -delivery -batch
MODE = 		Release

LEXERSYS = 	basis/__sys_word \
		unix/unixos \
		unix/_unixos \
		unix/__unixos 
   
BASISSYS = 

BASISSYS2 = 	unix/unix \
		unix/__unix

INTERSYS = 	main/stack_interface \
		sparc/_stack_interface \
		sparc/__stack_interface \
		editor/editor \
		unix/_editor \
		unix/__editor

COMPILER1 =	utils/getenv \
		utils/messages \
		utils/__messages \
		unix/_unixgetenv \
		unix/__getenv \
		sparc/machtypes \
		sparc/_machtypes \
		sparc/__machtypes \
		main/machspec \
		utils/bignum \
		utils/_bignum \
		utils/__bignum_inf \
		sparc/_machspec \
		sparc/__machspec \
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
		harp/virtualregister \
		utils/mutableintset \
		harp/_virtualregister \
		harp/mirtypes \
		harp/_mirtypes \
		utils/_smallintset \
		harp/__mirtypes \
		main/machperv \
		sparc/_machperv \
		sparc/__machperv \
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
		harp/mirregisters \
		harp/_mirregisters \
		harp/__mirregisters \
		harp/mirprint \
		harp/_mirprint \
		harp/__mirprint \
		harp/mir_env \
		harp/_mir_env \
		harp/__mir_env \
		harp/mir_utils \
		harp/_mir_utils \
		harp/__mir_utils \
		harp/mirtables \
		harp/_mirtables \
		harp/__mirtables \
		harp/mir_cg \
		harp/_mir_cg \
		harp/__mir_cg \
		harp/mirprocedure \
		harp/registerpack \
		harp/_mirprocedure \
		harp/_registerpack \
		harp/__registerpack \
		harp/__mirprocedure \
		harp/registerallocator \
		harp/mirvariable \
		harp/_mirvariable \
		harp/registercolourer \
		harp/_registercolourer \
		harp/_registerallocator \
		utils/__smallintset \
		harp/__gccolourer \
		harp/__nongccolourer \
		harp/__fpcolourer \
		harp/__registerallocator \
		harp/__mirvariable \
		harp/stackallocator \
		harp/_stackallocator \
		harp/__stackallocator \
		harp/mirexpr \
		harp/_mirexpr \
		harp/__mirexpr \
		harp/miroptimiser \
		harp/_miroptimiser \
		harp/__miroptimiser \
		main/reals \
		main/_reals \
		main/__reals \
		main/code_module \
		main/__code_module \
		sparc/sparc_opcodes \
		sparc/_sparc_opcodes \
		sparc/__sparc_opcodes \
		sparc/sparc_assembly \
		sparc/_sparc_assembly \
		sparc/__sparc_assembly \
		sparc/sparc_schedule \
		sparc/_sparc_schedule \
		sparc/__sparc_schedule \
		main/mach_cg \
		sparc/_mach_cg \
		sparc/__sparc_mach_cg \
		sparc/__mach_cg \
		main/machprint \
		sparc/_machprint \
		sparc/__sparc_machprint \
		sparc/__machprint \
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
		basis/__bin_stream_io \
		basis/bin_io \
		basis/_bin_io \
		basis/__bin_io \
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
		unix/__file_time \
		main/link_support \
		unix/_unix_link_support \
		unix/__link_support \
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
		sparc/__object_output \
		main/toplevel \
		main/_toplevel \
		main/__toplevel \
		main/version \
		main/__version \
		main/user_options \
		main/_user_options \
		main/__user_options

SYSTEM = unix

# ARCH_OS might be already set by the Solaris makefile, which includes
# this one.
ifeq (,$(ARCH_OS))
  ARCH_OS = SPARC/SunOS
endif

include ../../GNUmake

shell-files: force
	echo $(COMPILERMO) $(SHELLMO) > $@

tty2-files: force
	echo $(INTERMO) $(TTYMO) > tty2-files

SET_PERVASIVE = MLWORKS_PERVASIVE=`pwd`/$(SRC)/pervasive/; \
                export MLWORKS_PERVASIVE

shell.img: typechecker.img $(COMPILERMO) $(SHELLMO)
	echo make: $@
	$(SET_PERVASIVE)   ;    \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img -save $@ \
		$(COMPILERMO) $(SHELLMO) MLWargs

TTY_LOADER = 'Shell.saveImage("tty.img", false);'

tty.img: typechecker.img $(COMPILERMO) $(SHELLMO) $(INTERMO) $(TTYMO)
	echo make: $@ from typechecker.img
	$(SET_PERVASIVE)   ;    \
	echo $(TTY_LOADER) |    \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img \
		$(COMPILERMO) $(SHELLMO) $(INTERMO) $(TTYMO) MLWargs

TTYB_LOADER = 'Shell.Project.openProject "$(SRC)/basis.mlp"; \
               Shell.Project.setConfiguration "$(ARCH_OS)"; \
               Shell.Project.setTargets ["require_all.sml", \
                                         "platform_specific_exports.sml"]; \
               Shell.Project.loadAll () ; \
               Shell.saveImage("ttyb.img", false);'

ttyb.img: typechecker.img $(COMPILERMO) $(SHELLMO) $(INTERMO) $(TTYMO) $(BASIS_AND_LOADERMO)
	echo make: $@ from typechecker.img
	$(SET_PERVASIVE)      ;      \
	echo $(TTYB_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img \
		$(COMPILERMO) $(SHELLMO) $(INTERMO) $(TTYMO) MLWargs

tty2.img: shell.img $(INTERMO) $(TTYMO)
	echo make: $@ from shell.img
	echo $(TTY_LOADER) |    \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img \
		 $(INTERMO) $(TTYMO) MLWargs

GUI_LOADER = 'Shell.saveImage("gui.img", false);'

gui.img: typechecker.img $(COMPILERMO) $(SHELLMO) $(INTERMO) $(XGUIMO)
	echo make: $@ from typechecker.img
	$(SET_PERVASIVE)     ;      \
	echo $(GUI_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img \
		$(COMPILERMO) $(SHELLMO) $(INTERMO) $(XGUIMO) MLWargs

GUIB_LOADER = 'Shell.Project.openProject "$(SRC)/basis.mlp"; \
               Shell.Project.setConfiguration "$(ARCH_OS)"; \
               Shell.Project.setTargets ["require_all.sml", \
                                         "platform_specific_exports.sml"]; \
               Shell.Project.loadAll () ; \
               Shell.saveImage("guib.img", false);'

guib.img: typechecker.img $(COMPILERMO) $(SHELLMO) $(INTERMO) $(XGUIMO) $(BASIS_AND_LOADERMO)
	echo make: $@ from typechecker.img
	$(SET_PERVASIVE)      ;      \
	echo $(GUIB_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load typechecker.img \
		$(COMPILERMO) $(SHELLMO) $(INTERMO) $(XGUIMO) MLWargs

gui2.img: shell.img $(INTERMO) $(XGUIMO)
	echo make: $@ from shell.img
	echo $(GUI_LOADER) |      \
	$(RUNTIME) -MLWpass MLWargs $(RUNTIMEOPTS) -load shell.img \
		$(INTERMO) $(XGUIMO) MLWargs
