#
#
# RPM specification file for MLWorks
#
# NB: scripts (i.e., post, pre, preun, postun) are readable by users
# from the RPM
#
# Keep the %post section consistent with the corresponding
# parts of install-mlworks (symbolic links and substitution
# of paths into scripts)

Summary: Harlequin MLWorks 2.0b2 
Name: mlworks
Version: 2.0b2
Release: 1
Source: mlworks-2.0b2.tar.gz
Copyright: Copyright (c) 1998 Harlequin Group plc.  All rights reserved.
Vendor: Harlequin Group plc
Group: Development/Languages/SML
Prefix: /usr/local/lib/MLWorks
AutoReqProv: no
%description  
 MLWorks (TM) 2.0b2 for Linux.  Harlequin Group plc.  
 Graphical SML Development Environment.

%prep

# create and cd into $RPM_BUILD_ROOT/BUILD/mlworks-<VERSION>
# before unpacking the tar file containing the distribution 
%setup -c 

%build
# Do an install to get the directory structure and most of the
# filenames, although a small number of symbolic links and scripts will
# be created again during the real (user) installation ...
# Legal agreement is also shown during postinstall phase.

VERSION=2.0b2

$RPM_BUILD_DIR/mlworks-$VERSION/install-mlworks -s /usr/local/lib/MLWorks
MLDIR=/usr/local/lib/MLWorks

# ... so we need to copy the .in files into the installation tree

echo "Copying .in files into installation tree"

mkdir -p $MLDIR/scripts 
INDIR=$MLDIR/scripts
mkdir -p $INDIR/bin
mkdir -p $INDIR/x11
mkdir -p $INDIR/emacs
mkdir -p $INDIR/env
mkdir -p $INDIR/man

cd scripts && cp *.in $INDIR/bin;
cd $RPM_BUILD_DIR/mlworks-$VERSION/lib/X11/app-defaults/ &&
cp *.in $INDIR/x11;
cd $RPM_BUILD_DIR/mlworks-$VERSION/env && 
cp *.in $INDIR/env ;
cd $RPM_BUILD_DIR/mlworks-$VERSION/lib/emacs/lisp/ &&
cp *.in $INDIR/emacs;
cd $RPM_BUILD_DIR/mlworks-$VERSION/man/ && 
for d in *
do
  cd $d 
  mkdir -p $INDIR/man/$d 
  cp *.in $INDIR/man/$d
done

# Copy the documentation from the distribution directory to
# the installation directory

cp -r $RPM_BUILD_DIR/mlworks-$VERSION/documentation/ $MLDIR/documentation

%clean

rm -rf $RPM_BUILD_DIR/mlworks-2.0b2/

%post 
# MLWorks Installation 

# Get the user-specified MLWorks installation directory
# this is either supplied by the user using --prefix or is empty
# in which case the default directory /usr/local/lib/MLWorks is used.

cd $RPM_INSTALL_PREFIX &&

# Create location-specific scripts and symbolic links now that we know 
# where we are installing
MLWORKSDIR=$RPM_INSTALL_PREFIX
LIBDIR=$MLWORKSDIR/lib
IMAGEDIR=$MLWORKSDIR/images
BINDIR=$MLWORKSDIR/bin
SCRIPTDIR=$MLWORKSDIR/bin
MANDIR=$MLWORKSDIR/man
EXAMPLEDIR=$MLWORKSDIR/examples
RUNTIMEOPTS=
APP_DEFAULT_EXTENSION=%N%C
ARCH=I386
OS=Linux

cp="/bin/cp"
rm="/bin/rm -f"
ln="/bin/ln -s"
mkdir="/bin/mkdir -p"
sed=/bin/sed
zcat=zcat
chmod_exec="chmod 775"
chmod_exec_read_only="chmod 555"
chmod_non_exec="chmod 664"
chmod_read_only="chmod 444"

# This is a sed script to substitute the values of the installation
# variables into text files.

subst="s!\$MLWORKSDIR!$MLWORKSDIR!g
       s!\$LIBDIR!$LIBDIR!g
       s!\$IMAGEDIR!$IMAGEDIR!g
       s!\$BINDIR!$BINDIR!g
       s!\$SCRIPTDIR!$SCRIPTDIR!g
       s!\$MANDIR!$MANDIR!g
       s!\$RUNTIME!$RUNTIME!g"

# Make a link to the runtime
# We know that only a static runtime is available, so

RUNTIME=main-static
RUN_NAME=$RUNTIME.$ARCH.$OS;export RUN_NAME

$rm $BINDIR/mlrun &&
$ln $BINDIR/$RUN_NAME $BINDIR/mlrun

cd $MLWORKSDIR/scripts/bin &&
  for s in *
    do
      dest=$SCRIPTDIR/`basename $s .in`
      $rm $dest    # don't want to remove the runtime
      cat > $dest <<EOF
#!/bin/sh
MLWORKSDIR=$MLWORKSDIR
IMAGEDIR=$IMAGEDIR
LIBDIR=$LIBDIR
BINDIR=$BINDIR
SCRIPTDIR=$SCRIPTDIR
MANDIR=$MANDIR
RUNTIME=$RUNTIME
RUNTIMEOPTS=$RUNTIMEOPTS
MLWORKS_PERVASIVE=\${MLWORKS_PERVASIVE:-$MLWORKSDIR/pervasive}
export MLWORKS_PERVASIVE
MLWORKS_SRC_PATH=\${MLWORKS_SRC_PATH:-.}:$MLWORKSDIR
export MLWORKS_SRC_PATH
XFILESEARCHPATH=\
\$LIBDIR/X11/%L/app-defaults/$APP_DEFAULT_EXTENSION:\
\$LIBDIR/X11/%l/app-defaults/$APP_DEFAULT_EXTENSION:\
\$LIBDIR/X11/app-defaults/$APP_DEFAULT_EXTENSION:\
\$LIBDIR/X11/%T/$APP_DEFAULT_EXTENSION%S:\
\$XFILESEARCHPATH
export XFILESEARCHPATH
XKEYSYMDB=/usr/lib/X11/XKeysymDB
export XKEYSYMDB
EOF
      cat $s >> $dest 
      $chmod_exec $dest ;
    done

# Emacs LISP files are run through sed using the $subst script
# constructed above if their name matches *.in.  This allows them
# to locate other Emacs bits and bobs.  

cd $MLWORKSDIR/scripts/emacs &&
for f in *
do
   dest=$LIBDIR/emacs/lisp/`basename $f .in`
   $rm $dest 
   sed -e "$subst" < $f > $dest 
   $chmod_read_only $dest 
done

# X11 stuff: resource files matching *.in are run through the
# $subst sed script to allow them to locate the bitmaps.

cd $MLWORKSDIR/scripts/x11 &&
(for f in *
 do
   dest=$LIBDIR/X11/app-defaults/`basename $f .in` 
   $rm $dest 
   sed -e "$subst" < $f > $dest
   $chmod_read_only $dest 
 done
 $rm $LIBDIR/X11/app-defaults/MLWorks-fonts
 $ln MLWorks-normal-fonts $LIBDIR/X11/app-defaults/MLWorks-fonts
) 

# manual pages are run through the $subst sed script 
# so that they can cross-reference the installation itself.  

cd $MLWORKSDIR/scripts/man &&
for d in *
do
  for f in $d/*
  do
    dest=$MANDIR/$d/`basename $f .in` 
    $rm $dest 
    sed -e "$subst" < $f > $dest
    $chmod_read_only $dest 
  done
done

# environments

cd $MLWORKSDIR/scripts/env &&
for f in *
do
  dest=$MLWORKSDIR/env/`basename $f .in` 
  $rm $dest 
  sed -e "$subst" < $f > $dest
  $chmod_non_exec $dest 
done

echo "Installed MLWorks 2.0b2 for Linux in " $RPM_INSTALL_PREFIX

%files 
# documentation in PS and HTML
# mark this directory so that it can optionally be excluded from
# the installed version
%docdir /usr/local/lib/MLWorks/documentation

# include everything under this directory in the .rpm file
# we need the %attr command since we are not creating the RPM
# as root.  This will set group and owner to those of the
# user doing the eventual install.

%attr (-,root,root) /usr/local/lib/MLWorks
