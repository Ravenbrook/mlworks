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
 * Win32 OS.Path implementation.  This is just a shell of a definition
 * to satisfy the signature.  To be fleshed out ASAP.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_path.sml,v $
 * Revision 1.10  1999/03/17 10:55:48  daveb
 * [Bug #30092]
 * Added InvalidArc exception.
 *
 *  Revision 1.9  1998/08/13  10:17:38  jont
 *  [Bug #30468]
 *  Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 *  Revision 1.8  1998/02/20  10:55:50  mitchell
 *  [Bug #30337]
 *  Change OS.Path.concat to take a string list, instead of a pair of strings.
 *
 *  Revision 1.7  1997/03/31  12:16:50  johnh
 *  [Bug #1967]
 *  Changed mkCanonical to return lowercase paths.
 *
 *  Revision 1.6  1997/03/04  14:57:12  jont
 *  [Bug #1939]
 *  Add fromUnixPath and toUnixPath
 *
 *  Revision 1.5  1996/10/30  20:28:46  io
 *  [Bug #1614]
 *  removing toplevel String
 *
 *  Revision 1.4  1996/10/21  15:24:06  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.3  1996/06/19  13:33:36  andreww
 *  Checking for empty argument to isDir.
 *
 *  Revision 1.1  1996/05/21  14:35:13  stephenb
 *  new unit
 *
 *)

require "^.basis.__list";
require "^.basis.__string";
require "^.basis.os_path";
require "^.basis.__char";

structure OSPath_ : OS_PATH =
  struct

    exception Path

    exception InvalidArc

    val dirSeparator = #"\\"

    val extSeparator = #"."

    val parentArc = ".."

    val currentArc = "."

    val volumeSeparator = #":"

    fun isVolumePrefix s = 
      size s >= 2 andalso 
      String.sub(s,1) = volumeSeparator andalso 
      Char.isAlpha (String.sub(s,0))
      
    fun validVolume {isAbs= isAbs, vol = vol} = 
      (vol = "") orelse
      (size vol = 2 andalso isVolumePrefix vol)
      
    fun invalidArc s = Char.contains s dirSeparator

    fun fromString "" = {isAbs=false, vol="", arcs=[]}
      | fromString s = 
      let
        val (vol, s) = 
          if isVolumePrefix s then
            (String.extract (s, 0, SOME 2), String.extract (s, 2, NONE))
          else
            ("", s)
      in
        {isAbs=
         size s > 0 andalso String.sub(s,0) = dirSeparator,
         vol=vol,
         arcs=
         case String.fields (fn c=> c=dirSeparator) s of
          ""::xs => xs
         | xs => xs
         }
      end

    val sep = String.str dirSeparator


    fun toString {isAbs, vol, arcs} = 
      if not (validVolume {isAbs=isAbs, vol=vol}) then
        raise Path
      else
        case arcs of
          [] => if isAbs then vol^sep else ""
        | (arc::arcs) =>
            let 
	      val _ =
                if invalidArc arc then
                  raise InvalidArc
                else
                  ()

              val initialPath = 
                if isAbs then 
                   concat [vol, sep, arc] 
                else if arc <> "" then 
                  arc
                else
                  raise Path

	      fun addArc (arc, path) =
		if invalidArc arc then
		  raise InvalidArc
		else
		  concat [path, sep, arc]
            in
              List.foldl addArc initialPath arcs
            end (* toString *)

    fun getVolume s = (* #vol (fromString s) *)
      if isVolumePrefix s then
        substring(s, 0, 2)
      else ""
        
    (* OSPath_.getParent "a:\\bcd\\efg\\hij" = "a:\\bcd\\efg"
     * OSPath_.getParent "a:\\" = "a:\\"
     * OSPath_.getParent "a:xyz\\abc" = "a:xyz"
     * OSPath_.getParent "a:xyz\\abc\\" = "a:xyz\\abc\\.."
     * OSPath_.getParent "xyz" = "."
     * OSPath_.getParent ".." = "..\\.."
     * OSPath_.getParent "." = ".."
     * OSPath_.getParent "a:." = "a:.."
     * OSPath_.getParent "" = ".."
     *)
    fun getParent s = 
      let
        val {isAbs, vol, arcs} = fromString s
        fun scan1 [] = parentArc
          | scan1 [""] = ""
          | scan1 ["."] = parentArc
          | scan1 [".."] = s^sep^parentArc
          | scan1 [x] = currentArc
          | scan1 [x, ""] = s^parentArc
          | scan1 ["", x] = ""
          | scan1 [x, y] = x
          | scan1 (x::xs) = List.foldl (fn (arc, path)=> path^sep^arc) 
                                       x (scan2 ([],xs))
        and scan2 (acc, []) = rev acc
          | scan2 (acc, ["."]) = rev (parentArc::acc)
          | scan2 (acc, [x, ""]) = rev (parentArc::x::acc)
          | scan2 (acc, [x, y]) = rev (x::acc)
          | scan2 (acc, x::xs) = scan2(x::acc, xs)
      in
        vol ^ (if isAbs then sep else "")^(scan1 arcs)
      end
        
    (* An auxiliary function which returns (dirLength, fileStart).
     * for a given (path, start, end, end).  
     *)
    fun splitDirFile' (s, xmin, n, e) = 
      let
        fun scan (n, e) = 
          if n < xmin then (xmin, xmin)
          else if String.sub (s, n) = dirSeparator then
            (if n = xmin then (n+1, n+1) 
             else
               (n, n+1))
          else
            scan (n-1, e)
      in
        scan (n, e)
      end
    
    fun splitDirFile s =
      let
        val l = size s
        val e = l - 1
        val xmin = if isVolumePrefix s then 2 else 0
        val (m, n) = splitDirFile' (s, xmin, l-1, l-1)
      in
        { dir =  substring (s, 0, m)
         , file = substring (s, n, l-n)
         }
      end

    fun joinDirFile {dir, file} = 
      let
        val xmin = if isVolumePrefix dir then 2 else 0
	val _ = if invalidArc file then raise InvalidArc else ()
      in
        if dir = "" then
	  file
        else if size dir > xmin then
          if String.sub(dir, size dir -1) = dirSeparator then
            dir ^ file
          else
            dir ^ sep ^ file
        else
          dir ^ file
      end

    fun dir s = 
      let
        val e = size s - 1
        val xmin = if isVolumePrefix s then 2 else 0
        val (m,_) = splitDirFile' (s, xmin, e, e)
      in
        substring(s, 0, m)
      end

    fun file s = 
      let
        val sz = size s
        val xmin = if isVolumePrefix s then 2 else 0
        val (_, n) = splitDirFile' (s, xmin, sz-1, sz-1)
      in
        substring (s, n, sz-n)
      end


    fun splitBaseExt' (s, xmin, n, e) =
      let
        fun scan (n, e) = 
          if n <= xmin then
            NONE
          else
            let
              val c = String.sub(s, n)
            in
              if c = extSeparator then
                if n = e  
                   orelse String.sub (s, n-1) = dirSeparator then
                  NONE
                else
                  SOME n
              else if c = dirSeparator then 
                NONE
              else
                scan (n-1, e)
            end
      in
        scan (n, e)
      end
    
    fun splitBaseExt s =
      let
        val e = size s - 1
        val xmin = if isVolumePrefix s then 2 else 0
      in
        case splitBaseExt' (s, xmin, e, e) of
          NONE => {base = s, ext = NONE}
        | SOME n => { base = substring (s, 0, n)
                     , ext =  SOME (substring (s, n+1, e-n))
                     }
      end

    fun joinBaseExt {base, ext = NONE} = base
      | joinBaseExt {base, ext = SOME ""} = base
      | joinBaseExt {base, ext = SOME ext} = base 
                                           ^ (String.str extSeparator) ^ ext

    fun base s = 
      let
        val e = size s - 1
        val xmin = if isVolumePrefix s then 2 else 0
      in
        case splitBaseExt' (s, xmin, e, e) of
          NONE => s
        | SOME n => substring (s, 0, n)
      end


    fun ext s = 
      let
        val e = size s - 1
        val xmin = if isVolumePrefix s then 2 else 0
      in
        case splitBaseExt' (s, xmin, e, e) of
          NONE => NONE
        | SOME n => SOME (substring (s, n+1, e-n))
      end


    fun mkCanonical s = 
      let
        val {isAbs, vol, arcs} = fromString s
        fun canon ([], 0, result) = result
        |   canon ([], n, result) =
          (* n > 0 => need parent arcs at the beginning, unless the path is
             absolute *)
          if isAbs
          then result
          else canon ([], n-1, parentArc :: result)
        |   canon ("" :: arcs, level, result) =  (* ignore empty arcs *)
          canon (arcs, level, result)
        |   canon ("." :: arcs, level, result) =
          canon (arcs, level, result)
        |   canon (".." :: arcs, level, result) =
          canon (arcs, level + 1, result)
        |   canon (arc :: arcs, 0, result) =
          canon (arcs, 0, arc :: result)
        |   canon (_ :: arcs, n, result) =
          (* n > 0 => this arc is overridden by a parent arc *)
          canon (arcs, n-1, result)

        val arcs' = canon (rev arcs, 0, [])
        val s' = toString {isAbs=isAbs, vol=vol, arcs=arcs'}

 	fun toLowerStr s = implode (map Char.toLower (explode s)) 
      in
        toLowerStr (if s' = "" then currentArc else s')
      end

(*
    fun mkCanonical s = 
      let
        val {isAbs, vol, arcs} = fromString s
        fun scan1 (level, []) =
          if isAbs andalso level >= 0 then [] 
          else
            raise Path
          | scan1 (level, ["."]) = "." :: scan1 (level,[])
          | scan1 (level, ".."::xs) = ".." :: scan2 (level-1, xs)
          | scan1 (level, ""::xs) = ""::scan3(level, xs)
          | scan1 xs = scan3 xs
        and scan2 (level, ".."::xs) = ".." :: scan2 (level-1, xs)
          | scan2 (level, xs) = scan3 (level, xs)
        and scan3 (level, []) = 
          if level >= 0 then []
          else 
            raise Path
          | scan3 (level, ("."::xs)) = scan3 (level,xs)
          | scan3 (level, (".."::xs)) = scan3 (level-1, xs)
          | scan3 (level, (""::xs)) = scan3
*)              
          

                     
    fun isCanonical s = 
      let
        val {isAbs, vol, arcs} = fromString s
        (* check for currentArc on its own *)
        fun scan1 ["."] = not isAbs
          | scan1 (".."::xs) = isAbs = false andalso scan2 xs
          | scan1 (""::xs) = scan3 xs
          | scan1 xs = scan3 xs
        (* grep initial segments of ".." *)
        and scan2 (".."::xs) = scan2 xs
          | scan2 xs = scan3 xs
        (* do the usual bit *)
        and scan3 [] = true
          | scan3 ("."::_) = false
          | scan3 (".."::_) = false
          | scan3 (""::_) = false
          | scan3 (_::xs) = scan3 xs
      in
        scan1 arcs
      end



    fun isAbsolute "" = false
      | isAbsolute s = 
      let
        val xmin = if isVolumePrefix s then 2 else 0
      in
        if size s - xmin <= 0 then
          false
        else
          String.sub(s, xmin) = dirSeparator
      end

    fun isRelative s = not (isAbsolute s)



    local
      
      fun strip_common_prefix (l, []:string list) = (l, [])
        | strip_common_prefix ([],l) = ([],l)
        |   strip_common_prefix (l1 as h1::t1, l2 as h2::t2) =
            if h1 = h2
              then strip_common_prefix (t1, t2)
            else (l1, l2)
              
              
      fun mkRel ([], result) = result
        |   mkRel (_::t, result) = mkRel (t, parentArc :: result)
            
      fun noroot [""] = []
        | noroot x = x

      fun diff (s1, s2) =
        (* s1 and s2 are both absolute.  s2 is a directory. *)
        let
          val canon1 = mkCanonical s1
          val canon2 = s2
          val {arcs = arcs1, ...} = fromString canon1
          val {arcs = arcs2, ...} = fromString canon2
          val (arcs1', arcs2') = strip_common_prefix (arcs1, arcs2)
          val arcs = mkRel (arcs1', noroot arcs2')
        in
          toString {isAbs = false, vol = "", arcs = arcs}
        end
      

        fun isDir s = size s>1
           andalso String.sub(s,size s-1)=dirSeparator

      
    in
      
      fun mkRelative {path, relativeTo} = 
        let
          (*isDir s = true if s is a non-root directory *)

          val r1 = 
            if isAbsolute relativeTo then
              if isAbsolute path
                then diff (relativeTo, path)
              else path
            else
              raise Path

          val r2 = if isDir path andalso not (isDir r1) 
                     then r1^sep else r1

        in
          if path="" then "" else if r2="" then currentArc else r2
        end
    end






    (* isRoot "a:\\" = true
     * isRoot "\\" = true
     * isRoot "\\aaa" = false
     *)

    fun isRoot "" = false
      | isRoot s = 
      case size s of
        1 => String.sub(s, 0) = dirSeparator
      | 3 => String.sub(s, 1) = volumeSeparator andalso 
                                String.sub(s, 2) = dirSeparator
      | _ => false



    (* concat ["a:", "b:"] = raise Path
     * concat ["a:bcd", "a:def"] = "a:bcd\\def"
     * assume volume identifiers are not case sensitive
     *)

    fun concat2backwards (t,s) = 
      let
        val s = 
          if isVolumePrefix s then 
            if isVolumePrefix t then
              let
                val (c,d) = (Char.toLower (String.sub(s, 0)), 
                             Char.toLower (String.sub(t, 0)))
              in
                if c <> d then raise Path
                else
                  s
              end
            else (* not isVolumePrefix t *)
              s
          else (* not isVolumePrefix s *)
          if isVolumePrefix t then
            substring(t, 0, 2)^s
          else
            s
        val xmint = if isVolumePrefix t then 2 else 0
        val sz = size t
      in
        (* identify if relative *)
        if isVolumePrefix t then
          if (sz > 2 andalso String.sub(t, 2) = dirSeparator) then
            raise Path
          else
            s^sep^String.extract(t, 2, NONE)
        else (* not isVolumePrefix t *)
          if (sz > 0 andalso String.sub(t, 0) = dirSeparator) then
            raise Path
          else
            if s="" then t else s^sep^ t
      end

    fun concat [] = ""
      | concat (h::t) = foldl concat2backwards h t;
     
    fun mkAbsolute {path, relativeTo} =
      if isAbsolute relativeTo then
        if isAbsolute path then
          path
        else mkCanonical (concat [relativeTo, path])
      else
        raise Path

    val unixSeparator = #"/"
    val win32Separator = #"\\"

    (* Conversions to and from unix *)
    (* We use MKS conventions for the drive letters *)
    (* Convert a path of the form *)
    (* C:\foo\bar to C:/foo/bar *)
    fun toUnixPath s =
      let
	fun trans #"\\" = unixSeparator
	  | trans x = x
      in
	String.implode(map trans (String.explode s))
      end

    (* Convert a path of the form *)
    (* C:/foo/bar to C:\foo\bar *)
    fun fromUnixPath s =
      let
	fun trans #"/" = win32Separator
	  | trans x = x
      in
	String.implode(map trans (String.explode s))
      end

  end
