# Makefile for licshar.a
#
# $HopeName: HQNlicshar!makefile(trunk.10) $
#
# This code is actually used by both ScriptWorks and LispWorks (and
# probably other products as well): be careful to be portable!  In
# particular, don't assume much about the build system which will be used
# to compile this.
###########################################

LIB=${TARGET_MACH}/licshar.a

all: makeTargetDir licshar.a
licshar.a: ${LIB}

include ${MAKEDEFSDIR}/${TARGET_MACH}

# replace this with CCDBG or whatever if you wish...
CCFILE=${CCSPEED}

INCDIRS= \
	-I./export \
	-I./hh \
	-I${BUILDROOT}/standard/export \
	${SYSINC}

CDEFINES=-DUNIX=1

OBJECTS= \
	${LIB}(challeng.o) \
	${LIB}(comline.o) \
	${LIB}(lsadmxdr.o) \
	${LIB}(lsdata.o) \
	${LIB}(lslicxdr.o) \
	${LIB}(lsxdr.o) \
	${LIB}(md4.o) \
	${LIB}(pferrmsg.o) \
	${LIB}(uniqueid.o)

CFILES_DEPLIB= \
	src/challeng.c \
	src/comline.c \
	src/lsadmxdr.c \
	src/lsdata.c \
	src/lslicxdr.c \
	src/lsxdr.c \
	src/md4.c \
	src/pferrmsg.c \
	src/uniqueid.c 

LNFILES= \
	${TARGET_MACH}/challeng.ln \
	${TARGET_MACH}/comline.ln \
	${TARGET_MACH}/lsadmxdr.ln \
	${TARGET_MACH}/lsdata.ln \
	${TARGET_MACH}/lslicxdr.ln \
	${TARGET_MACH}/lsxdr.ln \
	${TARGET_MACH}/md4.ln \
	${TARGET_MACH}/pferrmsg.ln \
	${TARGET_MACH}/uniqueid.ln


################ The actual rules begin here ############

makeTargetDir:
	@if [ ! -d ${TARGET_MACH} ] ; then \
            echo "mkdir ${TARGET_MACH}" ; mkdir ${TARGET_MACH} ; else \
            echo "do something to keep ultrix4.2 happy" > /dev/null ; fi

${LIB}: ${OBJECTS}
	${RANLIB} ${LIB}

clean:
	rm -rf ${TARGET_MACH}

lint: ${LNFILES}
	${LINT} ${LNFILES} ${LINTLIBS} | tee licshar.lint

depend: 
	${MAKEDEPEND} -f - ${DEFS} ${INCDIRS} ${CFILES_DEPLIB} | \
	sed -e 's/^\([^:]*\):/$${LIB}(\1):/' >makefile.dep.${TARGET_MACH}

## The rest of this is because we can't make a default rule which knows
## about subdirectories: .c.a and .c.ln will only work for files like
## ./foo.c, not ./src/foo.c, and only to bar.a(foo.o), not 
## ${TARGET_MACH}/bar.a(foo.o)

${LIB}(challeng.o): src/challeng.c
	${CCFILE} -o ${TARGET_MACH}/challeng.o src/challeng.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/challeng.o
	rm ${TARGET_MACH}/challeng.o

${TARGET_MACH}/challeng.ln: src/challeng.c
	${LNFILE} -o ${TARGET_MACH}/challeng.ln src/challeng.c | tee ${TARGET_MACH}/challeng.lint


${LIB}(comline.o): src/comline.c
	${CCFILE} -o ${TARGET_MACH}/comline.o src/comline.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/comline.o
	rm ${TARGET_MACH}/comline.o

${TARGET_MACH}/comline.ln: src/comline.c
	${LNFILE} -o ${TARGET_MACH}/comline.ln src/comline.c | tee ${TARGET_MACH}/comline.lint


${LIB}(lsadmxdr.o): src/lsadmxdr.c
	${CCFILE} -o ${TARGET_MACH}/lsadmxdr.o src/lsadmxdr.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/lsadmxdr.o
	rm ${TARGET_MACH}/lsadmxdr.o

${TARGET_MACH}/lsadmxdr.ln: src/lsadmxdr.c
	${LNFILE} -o ${TARGET_MACH}/lsadmxdr.ln src/lsadmxdr.c | tee ${TARGET_MACH}/lsadmxdr.lint


${LIB}(lsdata.o): src/lsdata.c
	${CCFILE} -o ${TARGET_MACH}/lsdata.o src/lsdata.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/lsdata.o
	rm ${TARGET_MACH}/lsdata.o

${TARGET_MACH}/lsdata.ln: src/lsdata.c
	${LNFILE} -o ${TARGET_MACH}/lsdata.o src/lsdata.c | tee ${TARGET_MACH}/lsdata.lint


${LIB}(lslicxdr.o): src/lslicxdr.c
	${CCFILE} -o ${TARGET_MACH}/lslicxdr.o src/lslicxdr.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/lslicxdr.o
	rm ${TARGET_MACH}/lslicxdr.o

${TARGET_MACH}/lslicxdr.ln: src/lslicxdr.c
	${LNFILE} -o ${TARGET_MACH}/lslicxdr.ln src/lslicxdr.c | tee ${TARGET_MACH}/lslicxdr.lint


${LIB}(lsxdr.o): src/lsxdr.c
	${CCFILE} -o ${TARGET_MACH}/lsxdr.o src/lsxdr.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/lsxdr.o
	rm ${TARGET_MACH}/lsxdr.o

${TARGET_MACH}/lsxdr.ln: src/lsxdr.c
	${LNFILE} -o ${TARGET_MACH}/lsxdr.ln src/lsxdr.c | tee ${TARGET_MACH}/lsxdr.lint


${LIB}(md4.o): src/md4.c
	${CCFILE} -o ${TARGET_MACH}/md4.o src/md4.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/md4.o
	rm ${TARGET_MACH}/md4.o

${TARGET_MACH}/md4.ln: src/md4.c
	${LNFILE} -o ${TARGET_MACH}/md4.ln src/md4.c | tee ${TARGET_MACH}/md4.lint


${LIB}(pferrmsg.o): src/pferrmsg.c
	${CCFILE} -o ${TARGET_MACH}/pferrmsg.o src/pferrmsg.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/pferrmsg.o
	rm ${TARGET_MACH}/pferrmsg.o

${TARGET_MACH}/pferrmsg.ln: src/pferrmsg.c
	${LNFILE} -o ${TARGET_MACH}/pferrmsg.ln src/pferrmsg.c | tee ${TARGET_MACH}/pferrmsg.lint


${LIB}(uniqueid.o): src/uniqueid.c
	${CCFILE} -o ${TARGET_MACH}/uniqueid.o src/uniqueid.c
	${AR} ${ARFLAGS} ${LIB} ${TARGET_MACH}/uniqueid.o
	rm ${TARGET_MACH}/uniqueid.o

${TARGET_MACH}/uniqueid.ln: src/uniqueid.c
	${LNFILE} -o ${TARGET_MACH}/uniqueid.ln src/uniqueid.c | tee ${TARGET_MACH}/uniqueid.lint



##############################################
# $Log: makefile,v $
# Revision 1.11  1996/01/09 16:40:48  martin
# [Bug #4420]
# Rename MAKEDEFS to MAKEDEFSDIR since Alpha OSF/1 reserves MAKEDEFS.
#
# Revision 1.10  1996/01/03  11:31:19  nickr
# [Bug #4420]
# Use BUILDROOT and MAKEDEFS
#
# Revision 1.9  1995/03/06  19:15:44  freeland
# [Bug #none]
# moving .o files to be in platform-specific locations
#
# Revision 1.8  1994/09/07  14:07:30  sarah
# [Bug #4129]
# Intergraph was upset by having two different rules for makeObjDir
# (the other was in ScriptWorks common.unx), so rename the one here
#
# Revision 1.7  1994/08/05  11:54:52  nickr
# use ${MAKEDEPEND}
#
# Revision 1.6  1994/07/01  13:46:20  luke
# remove dependencies generated by a makedepend
#
# Revision 1.5  1994/06/30  17:51:25  luke
# another typo
#
# Revision 1.4  1994/06/30  17:27:28  luke
# get depend target working correctly
#
# Revision 1.3  1994/05/17  21:02:06  freeland
# Changes to makeObjDir: it seems that ultrix4.2 has a bug such that when if
# does nothing, it returns an error code, and make stops.  So we need to do
# something, even if the objectDir is already there.
#
# Revision 1.2  1994/05/12  13:49:49  freeland
# OSF's make doesn't know about $%, so we can't use those... it's almost a
# good thing that we can't use default rules, then.
#

# eof makefile.unx
