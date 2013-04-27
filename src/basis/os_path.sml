(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
 *
 *
 * Revision Log
 * ------------
 *
 * $Log: os_path.sml,v $
 * Revision 1.6  1999/03/14 12:19:10  daveb
 * [Bug #30092]
 * Added InvalidArc exception.
 *
 *  Revision 1.5  1998/08/13  10:02:16  jont
 *  [Bug #30468]
 *  Change types of mkAbsolute and mkRelative to use records with named fields
 *
 *  Revision 1.4  1998/02/19  08:57:05  mitchell
 *  [Bug #30337]
 *  Change OS.Path.concat to take a string list, instead of a pair of strings.
 *
 *  Revision 1.3  1997/03/04  14:22:09  jont
 *  [Bug #1939]
 *  Add fromUnixPath and toUnixPath
 *
 *  Revision 1.2  1996/10/03  15:23:25  io
 *  [Bug #1614]
 *  remove redundant requires
 *
 *  Revision 1.1  1996/05/17  13:43:18  stephenb
 *  new unit
 *
 *)

signature OS_PATH =
  sig

    exception Path

    exception InvalidArc

    val parentArc : string

    val currentArc : string

    val validVolume : {isAbs : bool, vol : string} -> bool

    val fromString : string -> {isAbs : bool, vol : string, arcs : string list}

    val toString : {isAbs : bool, vol : string, arcs : string list} -> string

    val getVolume : string -> string

    val getParent : string -> string

    val splitDirFile : string -> {dir : string, file : string}

    val joinDirFile : {dir : string, file : string} -> string

    val dir : string -> string
    val file : string -> string

    val splitBaseExt : string -> {base : string, ext : string option}

    val joinBaseExt : {base : string, ext : string option} -> string

    val base : string -> string
    val ext : string -> string option

    val mkCanonical : string -> string

    val isCanonical : string -> bool

    val mkAbsolute : {path : string, relativeTo : string} -> string

    val mkRelative : {path : string, relativeTo : string} -> string

    val isAbsolute : string -> bool
    val isRelative : string -> bool

    val isRoot : string -> bool

    val concat : string list -> string

    val fromUnixPath : string -> string

    val toUnixPath : string -> string

  end;
