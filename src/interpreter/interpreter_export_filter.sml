(* Exports from the interpreter to the rest of the system 
 *
 * $Log: interpreter_export_filter.sml,v $
 * Revision 1.1  1999/02/09 11:54:58  mitchell
 * new unit
 * [Bug #190505]
 * "Support for precompilation of subprojects"
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

require "newtrace.sml";
require "__newtrace.sml";
require "shell_types.sml";
require "__shell_types.sml";
require "shell_utils.sml";
require "__shell_utils.sml";
require "user_context.sml";
require "__user_context.sml";
require "preferences.sml";
require "__preferences.sml";
require "custom.sml";
require "__custom.sml";
require "incremental.sml";
require "__incremental.sml";
require "save_image.sml";
require "__save_image.sml";
require "inspector_values.sml";
require "__inspector_values.sml";
require "stack_frame.sml";
require "__stack_frame.sml";
require "ml_debugger.sml";
require "__ml_debugger.sml";
require "shell.sml";
require "__shell.sml";
require "tty_listener.sml";
require "__tty_listener.sml";
require "editor.sml";
require "__editor.sml";
require "shell_structure.sml";
require "__shell_structure.sml";


signature TRACE = TRACE
structure Trace_ = Trace_;
signature SHELL_TYPES = SHELL_TYPES;
structure ShellTypes_ = ShellTypes_;
signature SHELL_UTILS = SHELL_UTILS;
structure ShellUtils_ = ShellUtils_;
signature USER_CONTEXT = USER_CONTEXT;
structure UserContext_ = UserContext_;
signature PREFERENCES = PREFERENCES;
structure Preferences_ = Preferences_;
signature CUSTOM_EDITOR = CUSTOM_EDITOR;
structure CustomEditor_ = CustomEditor_;
signature INCREMENTAL = INCREMENTAL;
structure Incremental_ = Incremental_;
signature SAVE_IMAGE = SAVE_IMAGE;
structure SaveImage_ = SaveImage_;
signature INSPECTOR_VALUES = INSPECTOR_VALUES;
structure InspectorValues_ = InspectorValues_;
signature STACK_FRAME = STACK_FRAME;
structure StackFrame_ = StackFrame_;
signature ML_DEBUGGER = ML_DEBUGGER;
structure Ml_Debugger_ = Ml_Debugger_;
signature SHELL = SHELL;
structure Shell_ = Shell_;
signature TTY_LISTENER = TTY_LISTENER;
structure TTYListener_ = TTYListener_;
signature EDITOR = EDITOR;
structure Editor_ = Editor_;
signature SHELL_STRUCTURE = SHELL_STRUCTURE;
structure ShellStructure_ = ShellStructure_;








