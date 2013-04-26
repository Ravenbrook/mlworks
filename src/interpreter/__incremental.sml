(*  ==== INCREMENTAL COMPILER ====
 *           STRUCTURE
 *
 *  Copyright (C) 1992 Harlequin Ltd
 *
 *  Revision Log
 *  ------------
 *  $Log: __incremental.sml,v $
 *  Revision 1.26  1998/04/24 15:31:49  mitchell
 *  [Bug #30389]
 *  Keep projects more in step with projfiles
 *
 * Revision 1.25  1998/01/26  18:28:20  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.24.2.3  1997/11/26  12:07:54  daveb
 * [Bug #30071]
 * Removed OS, Getenv, and Module parameters.
 *
 * Revision 1.24.2.2  1997/11/20  16:54:09  daveb
 * [Bug #30326]
 *
 * Revision 1.24.2.1  1997/09/11  20:54:22  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.24  1997/05/12  16:21:58  jont
 * [Bug #20050]
 * main/io now exports MLWORKS_IO
 *
 * Revision 1.23  1996/10/30  13:43:19  jont
 * [Bug #1709]
 * Parse command line to set pervasive-dir
 *
 * Revision 1.22  1996/06/21  15:19:15  stephenb
 * Pass GetEnv to the functor.  Needed as part of #1330 fix.
 *
 * Revision 1.21  1996/06/21  12:09:35  stephenb
 * Out with the old in with the new -- replaced OldOS and Lists by OS and List
 * respectively.  This was done to simplify fixing #1330.
 *
 * Revision 1.20  1996/03/27  11:44:06  stephenb
 * Change any use of Os/OS to OldOs/OLD_OS to emphasise that it is using
 * the deprecated OS interface.
 *
 * Revision 1.19  1996/03/20  18:48:13  daveb
 * Added Os and Encapsulate parameters.
 *
 * Revision 1.18  1995/11/19  15:29:48  daveb
 * Added Project structure.
 *
 *  Revision 1.17  1995/03/24  16:26:09  matthew
 *  Explicit Stamp structure parameter
 *
 *  Revision 1.16  1995/03/17  20:28:51  daveb
 *  Removed unused parameter.
 *
 *  Revision 1.15  1995/02/07  13:25:50  matthew
 *  Removins Strenv and Types structures
 *
 *  Revision 1.14  1994/03/25  17:14:48  daveb
 *  Adding ModuleId parameter.
 *
 *  Revision 1.13  1994/02/01  17:16:53  daveb
 *  Replaced ModuleId with Module.
 *
 *  Revision 1.12  1994/01/06  15:12:02  matthew
 *  Added Types parameter
 *
 *  Revision 1.11  1993/08/03  12:31:42  daveb
 *  Added ModuleId parameter.
 *
 *  Revision 1.10  1993/05/14  11:53:30  jont
 *  Added Crash parameter to functor parameter
 *
 *  Revision 1.9  1993/04/02  11:11:23  matthew
 *  Changed BasisTypes structure to Basis
 *  ,
 *
 *  Revision 1.8  1993/03/08  10:33:33  matthew
 *  Added some structures
 *
 *  Revision 1.7  1993/02/22  09:49:02  matthew
 *  Added ParserEnv structure.
 *
 *  Revision 1.6  1993/02/19  19:26:02  jont
 *  Removed redundant Option parameter
 *
 *  Revision 1.5  1993/02/05  18:21:04  matthew
 *  Typechecker structure changes
 *
 *  Revision 1.4  1992/12/03  19:30:41  daveb
 *  Changes to support the PERVASIVE_DIR Unix environment variable.
 *
 *  Revision 1.3  1992/10/14  12:15:48  richard
 *  Removed GetTypeInformation_ parameter.  Parameterised the
 *  locations of the builtin and pervasive libraries.
 *
 *  Revision 1.2  1992/10/07  15:04:59  richard
 *  The incremental compiler now uses the generalised Compiler structure.
 *
 *  Revision 1.1  1992/10/01  15:55:22  richard
 *  Initial revision
 *
 *)

require "../lambda/__environ";
require "__interload";
require "__intermake";
require "../typechecker/__basis";
require "../typechecker/__stamp";
require "../lexer/__lexer";
require "../parser/__parserenv";
require "../main/__mlworks_io";
require "../basics/__location";
require "../main/__project";
require "../main/__proj_file";
require "../main/__encapsulate";
require "../basics/__module_id";
require "^.basis.__list";
require "../utils/_diagnostic";
require "../utils/__text";
require "../utils/__crash";
require "_incremental";

local
  fun parse_args [] = ()
    | parse_args("-pervasive-dir" :: arg :: rest) =
      (MLWorksIo_.set_pervasive_dir(arg, Location_.FILE"__incremental functor application");
       parse_args rest)
    | parse_args("-source-path" :: arg :: rest) =
      (MLWorksIo_.set_source_path_from_string(arg, Location_.FILE"__incremental functor application");
       parse_args rest)
    | parse_args("-object-path" :: arg :: rest) =
      (MLWorksIo_.set_object_path(arg, Location_.FILE"__incremental functor application");
       parse_args rest)
    | parse_args(_ :: rest) = parse_args rest
  val args = MLWorks.arguments()
in
  val _ = parse_args args
end

structure Incremental_ =
  Incremental
    (structure Environ = Environ_
     structure InterLoad = InterLoad_
     structure InterMake = InterMake_
     structure Basis = Basis_
     structure Stamp = Stamp_
     structure Lexer = Lexer_
     structure ParserEnv = ParserEnv_
     structure Io = MLWorksIo_
     structure ModuleId = ModuleId_
     structure Project = Project_
     structure ProjFile = ProjFile_
     structure Encapsulate = Encapsulate_
     structure List = List
     structure Diagnostic =
       Diagnostic (structure Text = Text_)
     structure Crash = Crash_

     val initial_name = "MLWorks"
    );
