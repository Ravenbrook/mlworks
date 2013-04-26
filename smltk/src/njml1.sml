(* ***************************************************************************
 
   $Source: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/smltk/src/RCS/njml1.sml,v $
 
   Implementation of system-dependend functions for SMLNJ 109/110.
  
   $Date: 1999/06/16 10:02:16 $
   $Revision: 1.1 $
   Author: stefan (Last modification by $Author: johnh $)

   (C) 1996, Bremen Institute for Safe Systems, Universitaet Bremen
 
  ************************************************************************** *)

require "export";
require "njml_sig";

structure SysDep : SYS_DEP
	
=
struct

    (* from Isabelle --- to be used in Makefiles *)
    fun xSmlTk filename banner =
      let val runtime = List.hd (SMLofNJ.getAllArgs())
	  val exec_file = TextIO.openOut filename
      in (TextIO.output (exec_file,
			 String.concat
			 ["#!/bin/sh\n",
			  runtime, " @SMLdebug=/dev/null @SMLload=", filename,
			  ".heap\n"]);
	  (*"@SMLdebug=..." sends GC messages to /dev/null*)
				      
	  TextIO.closeOut exec_file;
	  OS.Process.system ("chmod a+x " ^ filename);
	             (* That function is broken and will disable ^C. 
		      * Here's the fix: *)
          SMLofNJ.exportML (filename^".heap");
	  (* --- This code is executed when the image is loaded -- *)
          print(banner^"\n");
	  SmlTk.initSmlTk()
	 )
	  
      end

    fun setPrintDepth n = (Compiler.Control.Print.printDepth := n div 2;
			   Compiler.Control.Print.printLength := n)


end;


