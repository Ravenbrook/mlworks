(*  ==== INTERPRETER LINK/LOADER ====
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Implementation
 *  --------------
 *
 *  Revision Log
 *  ------------
 *  $Log: _interload.sml,v $
 *  Revision 1.13  1996/03/19 16:24:43  matthew
 *  Changes for value polymorphism\
 *
 * Revision 1.12  1994/12/07  13:22:31  matthew
 * Changing uses of cast
 *
 *  Revision 1.11  1994/06/09  16:01:46  nickh
 *  New runtime directory structure.
 *
 *  Revision 1.10  1994/05/26  13:54:02  jont
 *  Change Lists.qsort to Lists.msort
 *
 *  Revision 1.9  1994/03/09  10:53:11  jont
 *  Moving module types into separate file
 *
 *  Revision 1.8  1993/07/05  14:00:32  daveb
 *  Removed exception environments.
 *
 *  Revision 1.7  1993/04/20  13:20:11  richard
 *  Corrected #define symbols to upper case.
 *
 *  Revision 1.6  1993/03/11  11:09:03  matthew
 *  Signature revisions
 *
 *  Revision 1.5  1993/03/01  15:21:17  matthew
 *  Added MLVALUE ot MachTypes
 *
 *  Revision 1.4  1993/01/15  11:24:12  daveb
 *  Changed ObjectFile.version to ObjectFile.object_file_version to avoid
 *  problem on the C side of the run time system.
 *
 *  Revision 1.3  1993/01/14  14:26:52  daveb
 *  Added  ObjectFile.version parameter to load_wordset call.
 *
 *  Revision 1.2  1992/11/20  16:14:01  jont
 *  Modified sharing constraints to remove superfluous structures
 *
 *  Revision 1.1  1992/10/09  08:13:03  richard
 *  Initial revision
 *
 *)

require "../main/code_module";
require "../rts/gen/objectfile";
require "../utils/lists";
require "inter_envtypes";
require "interload";

functor InterLoad (
  structure Code_Module : CODE_MODULE
  structure Inter_EnvTypes : INTER_ENVTYPES
  structure Lists : LISTS
  structure ObjectFile: OBJECTFILE
) : INTERLOAD =
  struct
    structure Inter_EnvTypes = Inter_EnvTypes
    structure Ident = Inter_EnvTypes.EnvironTypes.LambdaTypes.Ident
    structure Symbol = Ident.Symbol
    structure NewMap = Inter_EnvTypes.EnvironTypes.NewMap

    type Module = Code_Module.Module

    val cast = MLWorks.Internal.Value.cast

    fun load debugger
             (Inter_EnvTypes.INTER_ENV (values, structures, functors),
              module_map)
             (Code_Module.MODULE module_element_list) =
      let
        val value_map     = NewMap.apply values
        val structure_map = NewMap.apply structures
        val functor_map   = NewMap.apply functors

        fun element (result, []) = result
          | element (result, Code_Module.REAL (i, string) :: rest) =
            element ((i, cast (MLWorks.Internal.Value.string_to_real string))::result, rest)
          | element (result, Code_Module.STRING (i, string) :: rest) =
            element ((i, cast string)::result, rest)
          | element (result, Code_Module.MLVALUE (i, value) :: rest) =
            element ((i, cast value)::result, rest)
          | element (result, Code_Module.VAR (i, name) :: rest) =
            element ((i, value_map (Ident.VAR (Symbol.find_symbol name)))::result, rest)
          | element (result, Code_Module.EXN (i, name) :: rest) =
            element ((i, value_map (Ident.EXCON (Symbol.find_symbol name)))::result, rest)
          | element (result, Code_Module.STRUCT (i, name) :: rest) =
            element ((i, structure_map (Ident.STRID (Symbol.find_symbol name)))::result, rest)
          | element (result, Code_Module.FUNCT (i, name) :: rest) =
            element ((i, functor_map (Ident.FUNID (Symbol.find_symbol name)))::result, rest)
          | element (result, Code_Module.WORDSET (Code_Module.WORD_SET list) :: rest) =
            element (MLWorks.Internal.Runtime.Loader.load_wordset (
		       ObjectFile.OBJECT_FILE_VERSION,
		       list
		     ) @ result,
		     rest
		    )
          | element (result, Code_Module.EXTERNAL (i, name) :: rest) =
            element ((i, module_map name)::result, rest)

	fun order_fn((i:int, _), (j, _)) = i < j

	val elements = element([], module_element_list)

        val closure =
          MLWorks.Internal.Value.list_to_tuple
          (map #2
           (if Lists.check_order order_fn elements then
              elements
            else
              Lists.msort order_fn elements))
      in
        cast ((debugger (cast closure)) (cast closure)) : MLWorks.Internal.Value.T
      end

  end
