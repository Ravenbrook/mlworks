(* Exports from the batch compiler to the rest of the system 
 *
 * $Log: batch_common_export_filter.sml,v $
 * Revision 1.2  1999/05/13 11:05:02  daveb
 * [Bug #190553]
 * Replaced basis/exit with utils/mlworks_exit.
 *
 *  Revision 1.1  1999/02/09  11:55:40  mitchell
 *  new unit
 *  [Bug #190505]
 *  "Support for precompilation of subprojects"
 *
 * 
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

require "lists.sml";
require "__lists.sml";
require "crash.sml";
require "__crash.sml";
require "options.sml";
require "__options.sml";
require "types.sml";
require "__types.sml";
require "tags.sml";
require "__tags.sml";
require "runtime_env.sml";
require "__runtime_env.sml";
require "debugger_utilities.sml";
require "__debugger_utilities.sml";
require "location.sml";
require "__location.sml";
require "info.sml";
require "__info.sml";
require "mlworks_io.sml";
require "__mlworks_io.sml";
require "environ.sml";
require "environtypes.sml";
require "compiler.sml";
require "diagnostic.sml";
require "basis.sml";
require "stamp.sml";
require "lexer.sml";
require "parserenv.sml";
require "module_id.sml";
require "project.sml";
require "proj_file.sml";
require "encapsulate.sml";
require "datatypes.sml";
require "code_module.sml";
require "__code_module.sml";
require "objectfile.sml";
require "__objectfile.sml";
require "identprint.sml";
require "__identprint.sml";
require "__basis.sml";
require "__stamp.sml";
require "__lexer.sml";
require "__parserenv.sml";
require "__module_id.sml";
require "__project.sml";
require "__proj_file.sml";
require "__environ.sml";
require "__environtypes.sml";
require "__compiler.sml";
require "__encapsulate.sml";
require "__basistypes.sml";
require "_diagnostic.sml";
require "text.sml";
require "__text.sml";
require "user_options.sml";
require "valenv.sml";
require "__valenv.sml";
require "scheme.sml";
require "__scheme.sml";
require "basistypes.sml";
require "debugger_types.sml";
require "topdecprint.sml";
require "__topdecprint.sml";
require "environment.sml";
require "__environment.sml";
require "map.sml";
require "user_options.sml";
require "strenv.sml";
require "completion.sml";
require "__completion.sml";
require "sigma.sml";
require "__sigma.sml";
require "parser.sml";
require "__parser.sml";
require "__user_options.sml";
require "getenv.sml";
require "__getenv.sml";
require "__strenv.sml";
require "tyenv.sml";
require "__tyenv.sml"; 
require "toplevel.sml";
require "__toplevel.sml";
require "__mlworks_exit.sml";
require "__terminal.sml";
require "__debugger_types";
require "__btree.sml";
require "__messages.sml";
require "parser.sml";
require "link_support.sml";
require "__link_support.sml";
require "object_output.sml";
require "version.sml";
require "__version.sml";
require "mlworks_exit.sml";
require "__object_output.sml";
require "machspec.sml";
require "__machspec.sml";
require "__file_time.sml";


signature LISTS = LISTS;
signature CRASH = CRASH ;
signature OPTIONS = OPTIONS;
signature TYPES = TYPES;
signature TAGS = TAGS;
signature RUNTIMEENV = RUNTIMEENV;
signature DEBUGGER_UTILITIES = DEBUGGER_UTILITIES;
signature LOCATION = LOCATION;
signature INFO = INFO;
signature MLWORKS_IO = MLWORKS_IO;
signature ENVIRON = ENVIRON;
signature ENVIRONTYPES = ENVIRONTYPES;
signature COMPILER = COMPILER;
signature DIAGNOSTIC = DIAGNOSTIC;
signature BASIS = BASIS;
signature STAMP = STAMP;
signature LEXER = LEXER;
signature PARSERENV = PARSERENV;
signature MODULE_ID = MODULE_ID;
signature PROJECT = PROJECT;
signature PROJ_FILE = PROJ_FILE;
signature ENCAPSULATE = ENCAPSULATE;
signature DATATYPES = DATATYPES;
signature CODE_MODULE = CODE_MODULE;
signature OBJECTFILE = OBJECTFILE;
signature IDENTPRINT = IDENTPRINT;
signature USER_OPTIONS = USER_OPTIONS;
signature VALENV = VALENV;
signature SCHEME = SCHEME;
signature BASISTYPES = BASISTYPES;
signature DEBUGGER_TYPES = DEBUGGER_TYPES;
signature TOPDECPRINT = TOPDECPRINT;
signature ENVIRONMENT = ENVIRONMENT;
signature MAP = MAP;
signature USER_OPTIONS = USER_OPTIONS;
signature STRENV = STRENV;
signature COMPLETION = COMPLETION;
signature SIGMA = SIGMA;
signature PARSER = PARSER;
signature GETENV = GETENV;
signature TYENV = TYENV;
signature TOPLEVEL = TOPLEVEL;
signature PARSER = PARSER;
signature LINK_SUPPORT = LINK_SUPPORT;
signature OBJECT_OUTPUT = OBJECT_OUTPUT;
signature VERSION = VERSION;
signature MLWORKS_EXIT = MLWORKS_EXIT;
signature MACHSPEC = MACHSPEC;

structure Lists_ = Lists_;
structure Crash_ = Crash_;
structure Options_ = Options_;
structure Types_ = Types_;
structure Tags_ = Tags_;
structure RuntimeEnv_ = RuntimeEnv_;
structure DebuggerUtilities_ = DebuggerUtilities_;
structure Location_ = Location_;
structure Info_ = Info_;
structure MLWorksIo_ = MLWorksIo_;
structure Code_Module_ = Code_Module_;
structure ObjectFile_ = ObjectFile_;
structure IdentPrint_ = IdentPrint_;
structure Basis_ = Basis_;
structure Stamp_ = Stamp_;
structure Lexer_ = Lexer_;
structure ParserEnv_ = ParserEnv_;
structure ModuleId_ = ModuleId_;
structure Project_ = Project_;
structure ProjFile_ = ProjFile_;
structure Environ_ = Environ_;
structure EnvironTypes_ = EnvironTypes_;
structure Compiler_ = Compiler_;
structure Encapsulate_ = Encapsulate_;
structure BasisTypes_ = BasisTypes_;
structure Text_ = Text_;
structure Valenv_ = Valenv_;
structure Scheme_ = Scheme_;
structure TopdecPrint_ = TopdecPrint_;
structure Environment_ = Environment_;
structure Sigma_ = Sigma_;
structure Completion_ = Completion_;
structure Parser_ = Parser_;
structure UserOptions_ = UserOptions_;
structure Getenv_ = Getenv_;
structure Strenv_ = Strenv_;
structure Tyenv_ = Tyenv_;
structure TopLevel_ = TopLevel_;
structure MLWorksExit = MLWorksExit;
structure Terminal = Terminal;
structure Debugger_Types_ = Debugger_Types_;
structure BTree_ = BTree_;
structure Messages = Messages;
structure LinkSupport_ = LinkSupport_;
structure Version_ = Version_;
structure Object_Output_ = Object_Output_;
structure MachSpec_ = MachSpec_;
structure FileTime = FileTime;

functor Diagnostic ( structure Text : TEXT ) : DIAGNOSTIC =
  Diagnostic (structure Text = Text);









