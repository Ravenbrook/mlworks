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
 * Unix OS.Path implementation.
 *
 * Note
 *    Some of the functions are not as efficient as possible.  For example,
 *    much use is made of fromString, toString and mkCanonical when it
 *    would be more efficient to do the work directly on the string.
 *
 * Revision Log
 * ------------
 *
 * $Log: __os_path.sml,v $
 * Revision 1.15  1999/03/19 12:26:48  mitchell
 * [Bug #30092]
 * Fix typo
 *
 *  Revision 1.14  1999/03/17  10:57:16  daveb
 *  [Bug #30092]
 *  Added InvalidArc exception.
 *
 *  Revision 1.13  1999/02/02  16:01:53  mitchell
 *  [Bug #190500]
 *  Remove redundant require statements
 *
 *  Revision 1.12  1998/08/13  11:29:37  jont
 *  [Bug #30468]
 *  Change types of mkAbsolute and mkRelative to uses records with names fields
 *
 *  Revision 1.11  1998/02/20  15:36:13  mitchell
 *  [Bug #30337]
 *  Change OS.Path.concat to take a string list, instead of a pair of strings.
 *
 *  Revision 1.10  1997/04/02  15:27:04  matthew
 *  Fixing concat
 *
 *  Revision 1.9  1997/03/04  14:19:31  jont
 *  [Bug #1939]
 *  Add fromUnixPath and toUnixPath
 *
 *  Revision 1.8  1996/11/06  11:31:24  matthew
 *  [Bug #1728]
 *  __integer becomes __int
 *
 *  Revision 1.7  1996/10/21  15:22:43  jont
 *  Remove references to basis.toplevel
 *
 *  Revision 1.6  1996/06/19  13:41:42  stephenb
 *  Remove the out of date comment about mkRelative not working.
 *
 *  Revision 1.5  1996/06/19  13:30:02  stephenb
 *  Fix mkRelative so that it matches the basis spec.
 *
 *  Revision 1.4  1996/05/23  11:43:14  stephenb
 *  Implement mkCanonical, isCanonical, mkAbsolute, mkRelative and isRoot.
 *
 *  Revision 1.3  1996/05/22  12:19:20  stephenb
 *  Fix some of the already implemented functions so that they pass their
 *  section of the test suite.
 *
 *  Revision 1.2  1996/05/21  13:59:21  stephenb
 *  Fix toString, joineDirFile and joinBaseExt so that they pass their
 *  respective test suites.
 *
 *  Revision 1.1  1996/05/17  15:35:43  stephenb
 *  new unit
 *
 *)

require "^.basis.__list";
require "^.basis.__char";
require "^.basis.__string";
require "^.basis.os_path";


structure OSPath_ : OS_PATH =
  struct

    exception Path

    exception InvalidArc

    val dirSeparator = #"/"

    val extSeparator = #"."

    val parentArc = ".."

    val currentArc = "."


    (*
     * Unix doesn't have volumes, so a volume is only valid if it is the
     * empty string.
     *)
    fun validVolume {isAbs = _, vol = vol} = vol = ""

    fun invalidArc s = Char.contains s dirSeparator


    local
      fun fromString' (s, 0, l, arcs) =
        if String.sub (s, 0) = dirSeparator then
          { isAbs= true
          , vol=   ""
          , arcs=  String.substring (s, 1, l)::arcs
          }
        else
          { isAbs= false
          , vol=   ""
          , arcs=  String.substring (s, 0, l+1)::arcs
          }
      | fromString' (s, p, l, arcs) =
        if String.sub (s, p) = dirSeparator then
          fromString' (s, p-1, 0, String.substring (s, p+1, l)::arcs)
        else
          fromString' (s, p-1, l+1, arcs)
    in
      fun fromString s =
        let
          val l = size s
        in
          if l = 0 then
            {isAbs = false, vol = "", arcs = []}
          else if l = 1 then
            if String.sub (s, 0) = dirSeparator then
              {isAbs = true, vol = "", arcs = [""]}
            else
              {isAbs = false, vol = "", arcs = [s]}
          else
            fromString' (s, l-1, 0, [])
        end
    end




    local
      val sep = String.str dirSeparator
    in
      fun toString {isAbs, vol, arcs} =
        if vol <> "" then
          raise Path
        else
          case arcs of
            [] => if isAbs then sep else ""
          | (arc::arcs) =>
              if arc = "" andalso not isAbs then
                raise Path
   	      else if invalidArc arc then
		raise InvalidArc
              else
                let
                  val initialPath = if isAbs then sep^arc else arc

	          fun addArc (arc, path) =
	   	    if invalidArc arc then
		      raise InvalidArc
		    else
		      concat [path, sep, arc]

                in
                  List.foldl addArc initialPath arcs
                end
    end



    (*
     * Unix doesn't have volumes, so no matter what the path, the volume
     * is the empty string.
     *)
    fun getVolume _ = ""




    (* The spec. for this getParent is defined in terms of arcs.
     *
     * An obvious implementation would therefore be to use fromString
     * to convert to arcs, apply the rules and then use toString to
     * convert it back to a string.
     *
     * The following implementation avoids the overhead of this approach
     * at the expense of this approach by applying the rules directly to
     * a string as it is parsed backwards.  However, it does so at the
     * expense of being rather cryptic :-<
     *)
    local
      fun getParent' (s, n) =
        if n = 0 then
          if String.sub (s, 0) = dirSeparator
          then String.str dirSeparator
          else currentArc
        else if String.sub (s, n) = dirSeparator
        then String.substring (s, 0, n)
        else getParent' (s, n-1)
    in
      fun getParent "" = parentArc
        | getParent s = 
        let
          val e = size s - 1
        in
          case String.sub (s, e) of
            #"/" => if e = 0 then s else s ^ parentArc
          | #"." => 
            if e = 0 then
              parentArc
            else 
              (case String.sub (s, e-1) of
                #"." => 
                  if e = 1 
                  then s ^ String.str dirSeparator ^ parentArc
                  else if String.sub (s, e-2) = dirSeparator
                  then s ^ String.str dirSeparator ^ parentArc
                  else getParent' (s, e-2)
              | #"/" => String.substring (s, 0, e) ^ parentArc
              | _    => getParent' (s, e-1))
          | _ => getParent' (s, e)
        end
    end



    local

      (* An auxiliary function which returns (dirLength, fileStart).
       * for a given (path, end, end).  
       *)
      fun splitDirFile' (s, n, e) =
        if n = ~1 then
          (0, 0)
        else
          if String.sub (s, n) = dirSeparator
          then if n = 0 then (n+1, n+1) else (n, n+1)
          else splitDirFile' (s, n-1, e)



    in

      fun splitDirFile s =
        let
          val l = size s
          val e = l - 1
          val (m, n) = splitDirFile' (s, e, e)
        in
          { dir =  String.substring (s, 0, m)
          , file = String.substring (s, n, l-n)
          }
        end


      (*
       * Could implement this as #dir o splitDirFile, but the following
       * is slightly more efficient in that it avoids performing the
       * file substring operation.
       *)
      fun dir s =
        let
          val e = size s - 1
          val (m, n) = splitDirFile' (s, e, e)
        in
          String.substring (s, 0, m)
        end



      (* 
       * Could implement this as #file o splitDirFile, but it is not, for the
       * same reason that dir is not implemented that way.
       *)
      fun file s =
        let
          val l = size s
          val e = l - 1
          val (m, n) = splitDirFile' (s, e, e)
        in
          String.substring (s, n, l-n)
        end
    end



    fun joinDirFile {dir, file} =
      let
	val dirSepStr = String.str dirSeparator
      in
        if invalidArc file then
  	  raise InvalidArc
        else if dir = "" then
	  file
        else if dir = dirSepStr then
	  dirSepStr ^ file
        else
          dir ^ dirSepStr ^ file
      end




    local

      fun splitBaseExt' (s, n, e) =
        if n = ~1 then
          NONE
        else 
          let
            val ch = String.sub (s, n)
          in
            if ch = extSeparator then
              if n = e orelse n = 0 orelse String.sub (s, n-1) = dirSeparator
              then NONE
              else SOME n
            else if ch = dirSeparator
            then NONE
            else splitBaseExt' (s, n-1, e)
          end
    in

      fun splitBaseExt s =
        let
           val e = size s - 1
        in
          case splitBaseExt' (s, e, e) of
            NONE => {base = s, ext = NONE}
          | SOME n => { base = String.substring (s, 0, n)
                      , ext =  SOME (String.substring (s, n+1, e-n))
                      }
        end


      fun base s = 
        let
           val e = size s - 1
        in
          case splitBaseExt' (s, e, e) of
            NONE => s
          | SOME n => String.substring (s, 0, n)
        end


      fun ext s = 
        let
           val e = size s - 1
        in
          case splitBaseExt' (s, e, e) of
            NONE => NONE
          | SOME n => SOME (String.substring (s, n+1, e-n))
        end
    end



    fun joinBaseExt {base, ext = NONE} = base
      | joinBaseExt {base, ext = SOME ""} = base
      | joinBaseExt {base, ext = SOME ext} = base ^ (String.str extSeparator) ^ ext



    (*
     * The following is a slightly modified version of mkCanonical
     * as found in _unixpath.sml.  It would be more efficient to
     * to the cannonicalisation directly on the string, but since
     * this does work ...
     *)
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
      in
        if s' = "" then currentArc else s'
      end



    (* 
     * Should reimplement at some point to be more efficient.
     *)
    fun isCanonical s = s = mkCanonical s



    fun isAbsolute "" = false
      | isAbsolute s = String.sub(s, 0) = dirSeparator


    fun concat2backwards (t, "") = t
      | concat2backwards (t, s) =
      if t <> "" andalso String.sub(t, 0) = dirSeparator then
        raise Path
      else if String.sub(s, size s - 1) = dirSeparator then
        s ^ t
      else
        s ^ String.str dirSeparator ^ t
        
        
    fun concat [] = ""
      | concat (h::t) = foldl concat2backwards h t;


(*
    fun mkAbsolute (p, abs) = 
      if isAbsolute abs then
        if isAbsolute p
        then p
        else mkCanonical (concat2backwards (p, abs))
      else
        raise Path
*)
    fun mkAbsolute {path, relativeTo} =
      if isAbsolute relativeTo then
        if isAbsolute path then
          path
        else mkCanonical (concat2backwards (path, relativeTo))
      else
        raise Path



    fun isRelative "" = true
      | isRelative s = String.sub(s, 0) <> dirSeparator



    (*
     * The following is borrowed from the Win32 version.
     *)
    local
      fun strip_common_prefix (l, []:string list) = (l, [])
      |   strip_common_prefix ([], l) = ([], l)
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
     
      fun isDir s = String.size s>1 andalso 
                    String.sub(s,String.size s-1) = dirSeparator

    in

(*
      fun mkRelative (p, abs) = 
        let
          val r1 = 
            if isAbsolute abs then
              if isAbsolute p
                then diff (abs, p)
              else p
            else
              raise Path

          val r2 = if isDir p andalso not (isDir r1) 
                   then r1^(String.str dirSeparator) else r1
        in
          if p = "" then "" else if r2="" then currentArc else r2
        end
*)
      fun mkRelative {path, relativeTo} = 
        let
          val r1 = 
            if isAbsolute relativeTo then
              if isAbsolute path
                then diff (relativeTo, path)
              else path
            else
              raise Path

          val r2 = if isDir path andalso not (isDir r1) 
		     then r1^(String.str dirSeparator) else r1

        in
          if path="" then "" else if r2="" then currentArc else r2
        end
    end



    fun isRoot path = path = "/"

    (* Translation between local paths and unix paths. Identity on unix *)
    fun fromUnixPath s = s
    fun toUnixPath s = s

 end
