(* Module identifiers - for OS-independent recompilation.
 
$Log: _module_id.sml,v $
Revision 1.33  1999/02/03 15:20:27  mitchell
[Bug #50108]
Change ModuleId from an equality type

 * Revision 1.32  1998/03/31  13:13:04  jont
 * [Bug #70077]
 * Remove use of Path, and replace with OS.Path
 *
 * Revision 1.31  1998/01/28  10:33:40  johnh
 * [Bug #30071]
 * Merge in Project Workspace changes.
 *
 * Revision 1.30  1997/09/18  14:33:19  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.29.7.2  1997/09/17  15:19:15  daveb
 * [Bug #30071]
 * Replaced build system with project workspace.
 *
 * Revision 1.29.7.1  1997/09/11  20:45:48  daveb
 * branched from trunk for label MLWorks_workspace_97
 *
 * Revision 1.29  1996/10/29  17:45:08  io
 * moving String from toplevel
 *
 * Revision 1.28  1996/05/21  11:13:05  stephenb
 * Change to pull in Path directly rather than OS.Path since the latter
 * now conforms to the latest basis and it is too much effort to update
 * the code to OS.Path at this point.
 *
 * Revision 1.27  1996/04/30  14:33:31  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.26  1996/04/18  15:17:06  jont
 * initbasis moves to basis
 *
 * Revision 1.25  1996/04/11  15:10:24  stephenb
 * Update wrt Os -> OS name change.
 *
 * Revision 1.24  1996/03/26  15:06:14  stephenb
 * Replace the use of Path by Os.Path.
 *
 * Revision 1.23  1996/03/15  12:35:20  daveb
 * Fixed use of Info.default_options.
 *
 * Revision 1.22  1995/12/06  18:00:17  daveb
 * Added the is_pervasive predicate.
 *
Revision 1.21  1995/12/05  10:02:55  daveb
Corrected previous log message.

Revision 1.20  1995/12/04  15:24:26  daveb
Added perv_from_string, perv_from_require_string and from_mo_string.
Changed error message in squash_path.

Revision 1.19  1995/09/06  15:36:24  jont
Provide non-faulting form of from_string

Revision 1.18  1995/04/28  15:51:49  jont
Modifications to from_require_string

Revision 1.17  1995/04/20  18:53:36  daveb
filesys and path moved from utils to initbasis.

Revision 1.16  1995/04/19  11:41:35  jont
Add functionality to support object paths

Revision 1.15  1995/02/28  15:55:27  daveb
New path syntax.

Revision 1.14  1995/01/25  14:36:52  daveb
Replaced FileName parameter with Path.
Added to_host function so that _module can be OS-independent.

Revision 1.13  1995/01/18  13:29:39  jont
Parameterise on pathname separator

Revision 1.12  1994/10/06  10:29:01  matthew
Added eq fun for module_ids

Revision 1.11  1994/06/02  15:50:06  brianm
Adding hyphen to module names and made invalid module name errors fatal

Revision 1.10  1994/03/22  14:52:01  daveb
Adding .mo to extensions that from_string knows about.

Revision 1.9  1994/02/02  12:08:49  daveb
changed from_unix_string (OS-specific) to from_require_string.

Revision 1.8  1993/12/22  17:13:59  daveb
from_string now checks for trailing ".sml".

Revision 1.7  1993/11/09  11:33:09  daveb
Merged in bug fix.

Revision 1.6  1993/09/10  17:43:42  jont
Merging in bug fixes

Revision 1.4.1.4  1993/10/22  15:44:22  daveb
Removed create function, as require can no longer take module ids.
Changed from_string to recognise either / or . as separators.

Revision 1.5  1993/09/02  14:24:33  jont
Merging in bug fixes

Revision 1.4.1.3  1993/09/10  15:09:47  jont
Changed the order of the terms in a moduleid. This will be a compiler
efficiency issue. Fixed lt to be a proper ordering function

Revision 1.5  1993/09/02  14:24:33  jont
Merging in bug fixes

Revision 1.4.1.2  1993/09/02  13:25:22  jont
Improvements to use String.ordof rather than String.substring

Revision 1.4.1.1  1993/08/27  13:47:55  jont
Fork for bug fixing

Revision 1.4  1993/08/27  13:47:55  daveb
Added a comparison function.

Revision 1.3  1993/08/26  13:03:36  daveb
from_string and from_unix_string return a more informative symbol on error.

Revision 1.2  1993/08/24  17:07:11  daveb
Fixed bug in from_string.
 Added create function that checks that moduleids are alphanumeric.
Checked legality of moduleids in old-fashioned require declarations.

Revision 1.1  1993/08/17  17:24:45  daveb
Initial revision


Copyright (c) 1993 Harlequin Ltd

*)

require "symbol";
require "^.main.info";
require "^.basis.os_path";
require "$.basis.__string";
require "module_id";

functor ModuleId
  (structure Symbol: SYMBOL
   structure Info: INFO
   structure Path: OS_PATH
  ): MODULE_ID =
struct
  type Symbol = Symbol.Symbol
  type Location = Info.Location.T
  structure Location = Info.Location

  (* Path components are stored in reverse order *)
  datatype ModuleId = MODID of Symbol * Symbol list
  datatype Path = PATH of Symbol list

  fun insert ([], _) = []
  |   insert ([x], _) = [x]
  |   insert (x::l, c) = x :: c :: insert (l, c)

  fun string (MODID (s, l)) =
    concat (insert (map Symbol.symbol_name (rev (s :: l)), "."))

  fun lt' ((s, l), (s', l')) =
    if Symbol.symbol_lt (s, s') then true
    else
      if Symbol.symbol_lt (s', s) then false
      else
	(* The tricky case, where we compare the path *)
	(* Shorter paths will be less than longer paths *)
	case l of
	  [] => l' <> [] (* lt provided second path not nil *)
	| (h :: t) =>
	    case l' of
	      [] => false (* ~lt if second path nil and first not *)
	    | (h' :: t') => lt'((h, t), (h', t'))

  (* Pervasive module names begin with a space. *)

  fun isPervasiveName s =
    String.sub(s, 0) = #" "

  fun is_pervasive (MODID (s, _)) =
    isPervasiveName (Symbol.symbol_name s)

  fun module_unit_to_string(MODID(s, l), ext) =
    (* Produce a file system string for the final part of the module name *)
    let
      val path_ext = if ext = "" then NONE else SOME ext
      val name = Symbol.symbol_name s
      val name' =
	(* Remove any leading space; this is there to hide the module_id
	   from the user's name space. *)
	if isPervasiveName name then
	  substring (* could raise Substring *) (name, 1, size name - 1)
	else
	  name
    in
      Path.joinBaseExt {base = name', ext = path_ext}
    end

  fun lt (MODID a, MODID b) = lt'(a, b)

  fun eq (m:ModuleId, m') = m = m'

  fun int_is_alpha c =
    (c >= ord #"A" andalso c <= ord #"Z") orelse
    (c >= ord #"a" andalso c <= ord #"z") orelse
    (c = ord #"_") orelse (c = ord #"-")
    (* underscores allowed here to cope with our file naming scheme *)
  
  fun legal c =
    (c >= ord #"0" andalso c <= ord #"9") orelse
    int_is_alpha c orelse c = ord #"'"
    
  fun path (MODID (_, l)) = PATH l

  fun path_string (PATH l) =
    concat (insert (map Symbol.symbol_name (rev l), "."))

  val empty_path = PATH []

  fun squash_path(name, [], acc) = rev acc
    | squash_path(name, x :: xs, acc) =
      case Symbol.symbol_name x of
	"^" =>
	  (case xs of
	     [] =>
	       (Info.default_error'
		(Info.FATAL, Location.UNKNOWN,
		 "can't find parent for module name: " ^ string name))
	   | y :: ys =>
	       (* We start with the final component, and work backwards *)
	       (* Therefore ^ refers to the next one in the input *)
	       squash_path(name, ys, acc))
      | "$" => rev acc
      | _ => squash_path(name, xs, x :: acc)

  (* XXX As a temporary measure, ignore the path here.  We should ignore
         it everywhere.  *)
  fun add_path (PATH l, MODID (s, l')) = MODID (s, [])
    (*
    MODID (s, squash_path(MODID(s, l' @ l), l' @ l, []))
    *)

  exception NoParent

  fun parent (PATH (_::l)) = PATH l
  |   parent _ = raise NoParent


  exception Parse of string

  fun internal_from_string (s, init_offset, ord_sep, allow_space) =
    let
      val len = size s
      val s' =
        if len - init_offset >= 3 andalso
           substring (* could raise Substring *) (s, len - 3, 3) = ".mo" then
          substring (* could raise Substring *) (s, 0, len - 3)
        else if len - init_offset >= 4 andalso
           substring (* could raise Substring *) (s, len - 4, 4) = ".sml" then
          substring (* could raise Substring *) (s, 0, len - 4)
        else
          s
      val len = size s'

      fun find_separator' i =
        if i = len then i
        else
          let
            val ch = MLWorks.String.ordof (s', i)
          in
            if ch = ord_sep then
	      i
            else
	      if legal ch then
		find_separator' (i+1)
	      else
		raise Parse s
          end
          
      fun find_separator i =
        if i = len orelse
	  let
	    val c = MLWorks.String.ordof(s', i)
	  in
	    int_is_alpha c orelse
	    (allow_space andalso c = ord #" ") orelse
	    ((c = ord #"^" orelse c = ord #"$")
	     andalso i+1 < len andalso MLWorks.String.ordof(s', i+1) = ord_sep)
	  end then
          find_separator' (i+1)
        else
          raise Parse s

      fun from i =
        if i = len then raise Parse s
        else
          let
            val split = find_separator i
            val substr =
              substring (* could raise Substring *) (s', i, split - i)
            val symbol =
              Symbol.find_symbol(Path.mkCanonical substr)
          in
            if split = len then
              ([], symbol)
            else
              let val (path, child) = from (split + 1)
              in (symbol :: path, child)
              end
          end
      val (l, s'') = from init_offset
    in
      MODID (s'', rev l)
    end

  fun from_string (s, location) =
    internal_from_string (s, 0, ord #".", false)
    handle Parse s =>
      (Info.default_error'
	 (Info.FATAL, location,
	  "from_string: invalid module name: `" ^ s ^ "'"))

  fun from_mo_string (s, location) =
    internal_from_string (s, 0, ord #".", true)
    handle Parse s =>
      (Info.default_error'
	 (Info.FATAL, location,
	  "from_mo_string: invalid module name: `" ^ s ^ "'"))

  fun perv_from_string (s, location) =
    case from_string (s, location)
    of MODID (s, l) =>
      MODID (Symbol.find_symbol (" " ^ Symbol.symbol_name s), l)

  fun from_host (s, location) =
    let
      val {dir, file} = Path.splitDirFile s

      val {isAbs, vol, arcs} = Path.fromString dir

      val name = Path.base file

      fun validComponent (s, ~1) = true
      |   validComponent (s, i) =
	if legal (MLWorks.String.ordof (s, i)) then
	  validComponent (s, i-1)
	else
	  false
	
      fun mk_symbol s =
	if validComponent (s, size s - 1) then
	  Symbol.find_symbol (Path.mkCanonical s)
	else
	  raise Parse s

      val list = map mk_symbol arcs

      val sym = mk_symbol name
    in
      MODID (sym, rev list)
    end
    handle Parse s =>
      (Info.default_error'
	 (Info.FATAL, location,
	  "from_host: invalid module name: `" ^ s ^ "'"))

  fun find_a_slash(s, i, size) =
    (i < size) andalso
    (MLWorks.String.ordof(s, i) = ord #"/" orelse find_a_slash(s, i+1, size))

  fun prefix_hats(0, list) = concat list
    | prefix_hats(n, list) =
      prefix_hats(n-1, "^/" :: list)

  val prefix_hats =
    fn ((n, hats, location)) =>
    if n < 0 then
      Info.default_error'
        (Info.FAULT, location, "negative hats value")
    else
      prefix_hats(n, hats)

  fun from_require_string (s, location) =
    let
      val len = size s

      fun from(i, hats) =
        (if len - i >= 3 andalso substring (* could raise Substring *) (s, i, 3) = "../" then
	   from (i + 3, hats+1)
         else
	   if hats >= 1 orelse find_a_slash(s, 0, size s) then
	     internal_from_string
	       (prefix_hats
		  (hats, [substring (* could raise Substring *)(s, i, size s - 3*hats)], location),
	        0, ord #"/", false)
	   else
	     internal_from_string(s, 0, ord #".", false))
        handle Parse s =>
          (Info.default_error'
	     (Info.FATAL, location,
	     "from_require_string: invalid module name: `" ^ s ^ "'"))
    in
      from(0, 0)
    end

  (* Pervasive units are all single names, without separators or parent
     notation, so we don't need the complexity of from_require_string. *)
  fun perv_from_require_string (s, location) =
    from_mo_string (s, location)

  fun from_string' s =
    SOME (internal_from_string (s, 0, ord #".", true))
    handle Parse s =>
      NONE
    
end;
