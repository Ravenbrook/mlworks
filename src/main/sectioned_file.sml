(*
 * $Log: sectioned_file.sml,v $
 * Revision 1.1  1998/06/08 12:11:28  mitchell
 * new unit
 * [Bug #30418]
 * Support for structured project file
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
 *
 *)

(* A section consists of a section name, zero or more subsections and zero or
 * more items, where section names and items are just strings.  Support is
 * provided for storing sections in files.  A sectioned file contains a 
 * single section and a file_stamp giving an indication of how to
 * interpret the elements of the section.  
 *)

signature SECTIONED_FILE =
  sig
    type item = string
    type name = string
    type path = name list
    type file_stamp = string

    type section
    type descendent = section * path
    type subsection = section

    exception InvalidPath
    exception InvalidSectionedFile of string

    val readSectionedFile:  string -> file_stamp * section
    val writeSectionedFile: string * file_stamp * section -> unit

    val createSection: name * subsection list * item list -> section

    val getName: section -> name
    val getItems: section -> item list
    val getSubsections: section -> subsection list
    val getDescendent: descendent -> subsection

    val addSubsection: section -> subsection -> section
    val removeSubsection: section -> name -> section * bool
    val addItem: section -> item -> section
    val filterItems: section -> (item -> bool) -> section        
    val replaceDescendent: descendent -> subsection -> section
  end;






