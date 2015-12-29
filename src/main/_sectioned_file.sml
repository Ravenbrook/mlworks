(*
 * $Log: _sectioned_file.sml,v $
 * Revision 1.1  1998/06/08 12:12:56  mitchell
 * new unit
 * [Bug #30418]
 * Support for structured project files
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

require "^.basis.__int";
require "^.basis.__list";
require "^.basis.__char";
require "^.basis.__string";
require "^.basis.__substring";

require "^.basis.os";
require "^.basis.text_io";

require "sectioned_file";

functor SectionedFile (
    structure TextIO: TEXT_IO
    structure OS:     OS
  ) : SECTIONED_FILE =

struct
  type item = string
  type name = string
  type path = name list
  type file_stamp = string

  datatype section =
    Section of {name : name,
                size : int ref, (* Used for caching total section size *)
                subsections : subsection list,
                items : item list }
  withtype subsection  = section

  type descendent = section * path

  exception InvalidPath
  exception InvalidSectionedFile of string;

  fun eq_section_name name (Section{name=name', ...}) = name = name'


  (* Parse an integer and complain if wrong format *)

  fun cvt_int (section_name, token_name, token) =
        case Int.fromString token of
          NONE => raise InvalidSectionedFile 
                    ( "Incorrect format for " ^ token_name 
                    ^ " in section " ^ section_name )
        | SOME int => int;


  (* A section header consists of a section name, an integer indicating
   * how many lines, not including the header, make up the section, and an
   * integer indicating how many subsections there are.  
   * The function returns the name, size and number of subsections. *)

  fun parse_section_header header =
        let val tokens = String.tokens Char.isSpace header
         in case tokens of
              [] => raise InvalidSectionedFile "Missing section header"
            | [name] => 
                raise InvalidSectionedFile 
                        ("Missing section size for section " ^ name)
            | [name, size] => (name, cvt_int(name, "size", size), 0)
            | [name, size, subsections] =>
                (name, cvt_int(name, "size", size), 
                       cvt_int(name, "subsection count", subsections))
            | name :: _ => 
                raise InvalidSectionedFile 
                        ("Too many tokens in section header for " ^ name)
        end;


  (* A sectioned file consists of a single section.  
   * A section consists of a section header followed by any subsections 
   * followed by the items associated with the section. *)

  fun readSectionedFile filename =
        let val instream = TextIO.openIn filename

            fun get_line () =
              case TextIO.inputLine instream of
		  SOME line => line
		| NONE => raise (InvalidSectionedFile "Premature EOF")

            fun read_section () =
                  let val header = get_line()
                      val (name, size, subcount) = parse_section_header header
                      val (subs, subsize) = read_sections subcount
                      val items = read_items (size - subsize)
                   in (Section{name = name, size = ref 0,
                               subsections = subs, items = items}, 
                       size + 1 (* for header *))
                  end

            and read_sections 0 = ([], 0)
              | read_sections i =
                  let val (section, size) = read_section ()
                      val (rest, rest_size) = read_sections (i - 1)
                   in (section :: rest, size + rest_size)
                  end

            and read_items 0 = []
              | read_items n = 
                  let val line = Substring.all (get_line())
                      val (_, line) = Substring.splitl Char.isSpace line
                      val (line, _) = Substring.splitr Char.isSpace line
                      val item = 
                            getOpt(String.fromString(Substring.string line),"")
                  in item :: (read_items (n - 1)) end

	    val firstline = getOpt(TextIO.inputLine instream, "")
            val stamp = getOpt(String.fromString(firstline), "")
            val (section, _) = read_section()
         in (TextIO.closeIn instream; (stamp, section))
            handle exn => (TextIO.closeIn instream; raise exn)
        end 


  (* This function updates the size ref in all the sections *)

  fun update_sizes (Section{name, size, subsections, items}) =
        ( app update_sizes subsections;
          size := 
            1 + foldl (fn (Section{size=ref s, ...}, sofar) => sofar + s) 
                      (List.length items) subsections );


  (* This function writes out a section in a format that can be read in again
   * by read_sectioned_file. *)

  fun writeSectionedFile(filename, stamp, section) =
        let val _ = (* Temporary workaround for Windows IO bug, request 30416 *)
              OS.FileSys.remove filename handle _ => () 
            val outstream = TextIO.openOut filename
            fun indent 0 = ()
              | indent level = 
                  (TextIO.output(outstream, "  "); indent(level - 1))
            fun write_section level
                              (Section {name,size=ref sz,subsections,items}) =
                  ( indent level;
                    TextIO.output(outstream,
                      name ^ " " ^ (Int.toString (sz-1)) 
                           ^ " " ^ (Int.toString(length(subsections))) ^ "\n");
                    app (write_section (level + 1)) subsections;
                    app (write_item level) items )

            and write_item level string = 
                ( indent (level + 1);
                  TextIO.output (outstream, (String.toString string) ^ "\n") )
  
         in update_sizes section; (* First get an uptodate set of sizes *)
            TextIO.output (outstream, (String.toString stamp) ^ "\n");
            write_section 0 section;
            TextIO.closeOut outstream
        end;  

  fun createSection (name: name, subsections : subsection list, items : item list) =
        Section{name = name, size = ref 0, subsections = subsections, items = items}

  fun getName (Section{name, ...}) = name;
  fun getItems (Section{items, ...}) = items;
  fun getSubsections (Section{subsections, ...}) = subsections;

  fun getDescendent (section, []) = section
    | getDescendent (Section{subsections, ...}, h::t) =
        case List.find (eq_section_name h) subsections of
          NONE => raise InvalidPath
        | SOME subsection => getDescendent (subsection, t);


  (* All the functions that add or remove elements of a section do so 
   * functionally, by returning a new section *)

  fun addSubsection (section as Section{name, size, subsections, items})
                    (subsection as Section{name = subname, ...}) =
        let val subsections' =
                  List.filter (not o (eq_section_name subname)) subsections
         in Section{name = name, size = ref 0, 
                    subsections = subsection :: subsections', items = items} 
        end

  (* Removing a subsection returns the new section, plus a boolean flag
     indicating whether the subsection was found *)
  fun removeSubsection (section as Section{name = n, size, subsections, items})
                       name =
      let val (removed, subsections') =
                List.partition (eq_section_name name) subsections
       in if null removed
          then (section, false)
          else (Section{name = n, size = ref 0, subsections = subsections', 
                        items = items},
                true)
      end


  fun addItem (Section{name, size, subsections, items}) item =
        Section{name = name, size = ref 0, subsections = subsections, 
                items = item :: items} 
  
  fun filterItems (section as Section{name, size, subsections, items})
                  filter =
        let val (items', removed) = List.partition filter items
         in if null removed
            then section
            else Section{name = name, size = ref 0, 
                         subsections = subsections, items = items'} end

  fun replaceDescendent descendent replacement =
        let fun replace (section, []) = 
                  if (getName section = getName replacement)
                  then replacement
                  else raise InvalidPath
              | replace (section as Section{name, size, subsections, items}, 
                         h::t) =
                  case List.partition (eq_section_name h) subsections of
                    ([subsection], subsections') =>
                      Section{name = name, size = ref 0, items = items,
                              subsections = 
                                (replace(subsection, t)) :: subsections'}
                  | _ => raise InvalidPath
         in replace descendent end
end (* functor SectionedFile *)






