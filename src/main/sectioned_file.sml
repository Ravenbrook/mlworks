(*
 * $Log: sectioned_file.sml,v $
 * Revision 1.1  1998/06/08 12:11:28  mitchell
 * new unit
 * [Bug #30418]
 * Support for structured project file
 *
 *
 * Copyright (C) 1998.  The Harlequin Group Limited.  All rights reserved.
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






