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
Result: OK

 *
 * Test Unix OS.Path.  All tests should return true.
 * 
 * Revision Log
 * ------------
 *
 * $Log: os_path.sml,v $
 * Revision 1.9  1999/04/20 17:11:19  daveb
 * [Bug #30092]
 * Added tests for invalid arcs.
 *
 *  Revision 1.8  1998/08/13  13:39:32  jont
 *  [Bug #30468]
 *  Change mkAbsolute and mkRelative to take record parameters instead of tuples
 *
 *  Revision 1.7  1998/03/11  12:34:09  mitchell
 *  [Bug #30337]
 *  Fix because of change to spec of concat
 *
 *  Revision 1.6  1998/02/18  11:56:02  mitchell
 *  [Bug #30349]
 *  Fix test to avoid non-unit sequence warning
 *
 *  Revision 1.5  1997/11/26  13:50:44  daveb
 *  [Bug #30323]
 *  Removed uses of Shell.Build.loadSource.
 *
 *  Revision 1.4  1997/11/14  15:02:34  jont
 *  [Bug #30089]
 *  rework following change to basis time
 *
 *  Revision 1.3  1997/03/05  12:46:10  jont
 *  [Bug #1939]
 *  Add tests for toUnixPath and fromUnixPath
 *
 *  Revision 1.2  1996/10/22  13:24:09  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/06/20  11:29:05  stephenb
 *  new unit
 *  Replaces ../unix_os_path_*.sml
 *
 *)


local
  open OS.Path;
in
  val base_a = base "" = "";
  val base_b = base ".login" = ".login";
  val base_c = base "/.login" = "/.login";
  val base_d = base "a" = "a";
  val base_e = base "a." = "a.";
  val base_f = base "a.b" = "a";
  val base_g = base "a.b.c" = "a.b";
  val base_h = base "/a.b" = "/a";
  val base_i = base "/c/a.b" = "/c/a";
  val base_j = base "/c/a/b/.d" = "/c/a/b/.d";
  val base_k = base "/c.a/b.d" = "/c.a/b";
  val base_l = base "/c.a/bd" = "/c.a/bd";
  val base_m = base "/c/a/b.foo.bar" = "/c/a/b.foo";
  val base_n = base "/c/a/b.foo" = "/c/a/b";
  val base_p = base ".news/comp" = ".news/comp";
  val concat_a = concat ["a", "b"] = "a/b";
  val concat_b = concat ["a", "b/c"] = "a/b/c";
  val concat_c = concat ["/", "b/c"] = "/b/c";
  val concat_d = concat ["", "b/c"] = "b/c";
  val concat_e = concat ["/a", "b/c"] = "/a/b/c";
  val concat_f = concat ["a/", "b/c"] = "a/b/c";
  val concat_g = concat ["a//", "b/c"] = "a//b/c";
  val concat_h = concat [".", "b/c"] = "./b/c";
  val concat_i = concat ["a/b", ".."] = "a/b/..";
  val concat_j = concat ["a/b", "../c"] = "a/b/../c";
  val concat_k = (ignore(concat ["a", "/b"]); false) handle Path => true;
  val dir_a = dir "b" = "";
  val dir_b = dir "a/b" = "a";
  val dir_c = dir "/" = "/";
  val dir_d = dir "/b" = "/";
  val dir_e = dir "/a/b" = "/a";
  val dir_f = dir "/c/a/b" = "/c/a";
  val dir_g = dir "/c/a/b/" = "/c/a/b";
  val dir_h = dir "/c/a/b.foo.bar" = "/c/a";
  val dir_i = dir "/c/a/b.foo" = "/c/a";
  val ext_a = ext "" = NONE;
  val ext_b = ext ".login" = NONE;
  val ext_c = ext "/.login" = NONE;
  val ext_d = ext "a" = NONE;
  val ext_e = ext "a." = NONE;
  val ext_f = ext "a.b" = SOME "b";
  val ext_g = ext "a.b.c" = SOME "c";
  val ext_h = ext "/a.b" = SOME "b";
  val ext_i = ext "/c/a.b" = SOME "b";
  val ext_j = ext "/c/a/b/.d" = NONE;
  val ext_k = ext "/c.a/b.d" = SOME "d";
  val ext_l = ext "/c.a/bd" = NONE;
  val ext_m = ext "/c/a/b.foo.bar" = SOME "bar";
  val ext_n = ext "/c/a/b.foo" = SOME "foo";
  val ext_p = ext ".news/comp" = NONE;
  val file_a = file "b" = "b";
  val file_b = file "a/b" = "b";
  val file_c = file "/" = "";
  val file_d = file "/b" = "b";
  val file_e = file "/a/b" = "b";
  val file_f = file "/c/a/b" = "b";
  val file_g = file "/c/a/b/" = "";
  val file_h = file "/c/a/b.foo.bar" = "b.foo.bar";
  val file_i = file "/c/a/b.foo" = "b.foo";
  val fromString_a = fromString "" = {isAbs=false, vol = "", arcs = []};
  val fromString_b = fromString "/" = {isAbs=true, vol = "", arcs = [""]};
  val fromString_c = fromString "//" = {isAbs=true, vol = "", arcs = ["",""]};
  val fromString_d = fromString "a" = {isAbs=false, vol = "", arcs = ["a"]};
  val fromString_e = fromString "/a" = {isAbs=true, vol = "", arcs = ["a"]};
  val fromString_f = fromString "//a" = {isAbs=true, vol = "", arcs = ["","a"]};
  val fromString_g = fromString "a/" = {isAbs=false, vol = "", arcs = ["a",""]};
  val fromString_h = fromString "a//" = {isAbs=false, vol = "", arcs = ["a","", ""]};
  val fromString_i = fromString "a/b" = {isAbs=false, vol = "", arcs = ["a", "b"]};
  val fromString_j = fromString "a.b/c" = {isAbs=false, vol = "", arcs = ["a.b", "c"]};
  val fromString_k = fromString "a.b/c/" = {isAbs=false, vol = "", arcs = ["a.b", "c", ""]};
  val fromString_l = fromString "a/./c" = {isAbs=false, vol = "", arcs = ["a", ".", "c"]};
  val fromString_m = fromString "a/../c" = {isAbs=false, vol = "", arcs = ["a", "..", "c"]};
  val fromString_n = fromString "." = {isAbs=false, vol = "", arcs = ["."]};
  val getParent_a = getParent "/" = "/";
  val getParent_b = getParent "a" = ".";
  val getParent_c = getParent "a/" = "a/..";
  val getParent_d = getParent "a///" = "a///..";
  val getParent_e = getParent "a/b" = "a";
  val getParent_f = getParent "a/b/" = "a/b/..";
  val getParent_g = getParent ".." = "../..";
  val getParent_h = getParent "." = "..";
  val getParent_i = getParent "../" = "../.."
  val getParent_j = getParent "./" = "./..";
  val getParent_k = getParent "" = "..";
  val getParent_l = getParent "/abc" = "/";
  val getParent_m = getParent "/abc." = "/";
  val getParent_p = getParent "/abc.." = "/";
  val getParent_q = getParent "/abc/.." = "/abc/../..";
  val getParent_r = getParent "../.." = "../../..";
  val getParent_s = getParent "/abc/." = "/abc/..";
  val getVolume_a = getVolume "/" = "";
  val getVolume_b = getVolume "//" = "";
  val getVolume_c = getVolume "a//b/c/" = "";
  val getVolume_d = getVolume "./" = "";
  val getVolume_e = getVolume "../" = "";
  val getVolume_f = getVolume "" = "";
  val getVolume_g = getVolume "C:" = "";
  val isAbsolute_a = isAbsolute "" = false;
  val isAbsolute_b = isAbsolute "/";
  val isAbsolute_c = isAbsolute "/a";
  val isAbsolute_d = isAbsolute "//a";
  val isAbsolute_e = isAbsolute "//";
  val isAbsolute_f = isAbsolute "/.";
  val isAbsolute_g = isAbsolute "/..";
  val isAbsolute_h = isAbsolute "." = false;
  val isAbsolute_i = isAbsolute ".." = false;
  val isAbsolute_j = isAbsolute "a//" = false;
  val isCanonical_a = isCanonical "" = false;
  val isCanonical_b = isCanonical "./." = false;
  val isCanonical_c = isCanonical "/." = false;
  val isCanonical_d = isCanonical "..";
  val isCanonical_e = isCanonical "../..";
  val isCanonical_f = isCanonical "b";
  val isCanonical_g = isCanonical "a/b";
  val isCanonical_h = isCanonical "/a/b";
  val isCanonical_i = isCanonical "a/b/" = false;
  val isCanonical_j = isCanonical "a/b//" = false;
  val isCanonical_k = isCanonical "a/../b" = false;
  val isCanonical_l = isCanonical "a/.." = false;
  val isCanonical_m = isCanonical "a/." = false;
  val isCanonical_n = isCanonical "a/" = false;
    
  val isCanonical_p = isCanonical "/a/../b/" = false;
  val isCanonical_q = isCanonical "/.." = false;
  val isCanonical_r = isCanonical "/../../a/b/" = false;
  val isCanonical_s = isCanonical "/./../../a/b/" = false;
  val isCanonical_t = isCanonical "/./../.." = false;
  val isCanonical_u = isCanonical "a/../b" = false;
  val isCanonical_v = isCanonical "a/./b" = false;
  val isCanonical_w = isCanonical "a////b" = false;
    
  val isCanonical_x = isCanonical "foo1//../..//foo2/bar.sml" = false;
  val isCanonical_y = isCanonical "foo1.ext/./foo2/../bar.sml/" = false;
  val isCanonical_z = isCanonical "//foo1/../../foo2/bar.sml" = false;
  val isRelative_a = isRelative "";
  val isRelative_b = isRelative ".";
  val isRelative_c = isRelative "..";
  val isRelative_d = isRelative "a//";
  val isRelative_e = isRelative "/" = false;
  val isRelative_f = isRelative "/a" = false;
  val isRelative_g = isRelative "//" = false;
  val joinBaseExt_a = joinBaseExt {base = "", ext = NONE} = "";
  val joinBaseExt_b = joinBaseExt {base = ".login", ext = NONE} = ".login";
  val joinBaseExt_c = joinBaseExt {base = "a", ext = NONE} = "a";
  val joinBaseExt_d = joinBaseExt {base = "a", ext = SOME ""} = "a";
  val joinBaseExt_e = joinBaseExt {base = "a", ext = SOME "b"} = "a.b";
  val joinBaseExt_f = joinBaseExt {base = "a.b", ext = SOME "c"} = "a.b.c";
  val joinBaseExt_g = joinBaseExt {base = "a.b", ext = SOME "c.d"} = "a.b.c.d";
  val joinBaseExt_h = joinBaseExt {base = "/a", ext = SOME "b"} = "/a.b";
  val joinBaseExt_i = joinBaseExt {base = "/c/a", ext = SOME "b"} = "/c/a.b";
  val joinBaseExt_j = joinBaseExt {base = "/c/a/b/", ext = SOME "d"} = "/c/a/b/.d";
  val joinBaseExt_k = joinBaseExt {base = "/c/a/b", ext = SOME "foo.bar"} = "/c/a/b.foo.bar";
  val joinBaseExt_l = joinBaseExt {base = "/c/a/b", ext = SOME "foo"} = "/c/a/b.foo";
  val joinDirFile_a = joinDirFile {dir = "", file = ""} = "";
  val joinDirFile_b = joinDirFile {dir = "", file = "."} = ".";
  val joinDirFile_c = joinDirFile {dir = "", file = "b"} = "b";
  val joinDirFile_d = joinDirFile {dir = "b", file = ""} = "b/";
  val joinDirFile_e = joinDirFile {dir = "a", file = "b"} = "a/b";
  val joinDirFile_f = joinDirFile {dir = "/", file = "a"} = "/a";
  val joinDirFile_g = joinDirFile {dir = "/a", file = "b"} = "/a/b";
  val joinDirFile_h = joinDirFile {dir = "/c/a", file = "b"} = "/c/a/b";
  val joinDirFile_i = joinDirFile {dir = "/c/a/b", file = ""} = "/c/a/b/";
  val joinDirFile_j = joinDirFile {dir = "/c/a", file = "b.foo.bar"} = "/c/a/b.foo.bar";
  val joinDirFile_k = joinDirFile {dir = "/c/a", file = "b.foo"} = "/c/a/b.foo";
  val joinDirFile_l =
       (ignore(joinDirFile {dir = "", file = "a/b"}); false)
       handle InvalidArc => true | _ => false
  val mkAbsolute_a = mkAbsolute{path="/a/b", relativeTo="/c/d"} = "/a/b";
  val mkAbsolute_b = mkAbsolute{path="/", relativeTo="/c/d"} = "/";
  val mkAbsolute_c = mkAbsolute{path="a/b", relativeTo="/c/d"} = "/c/d/a/b";
  val mkAbsolute_d = (ignore(mkAbsolute{path="a", relativeTo="c/d"}); false) handle Path => true;
  val mkAbsolute_e = (ignore(mkAbsolute{path="/a", relativeTo="c/d"}); false) handle Path => true;
  val mkAbsolute_f = (ignore(mkAbsolute{path="/foo", relativeTo="bar"}); false) handle Path => true;
  val mkAbsolute_g = mkAbsolute{path="~foo", relativeTo="/bar"} = "/bar/~foo";
  val mkAbsolute_h = mkAbsolute{path="/foo", relativeTo="/bar"} = "/foo";
  val mkCanonical_a = mkCanonical "" = ".";
  val mkCanonical_b = mkCanonical "./." = ".";
  val mkCanonical_c = mkCanonical "/." = "/";
  val mkCanonical_d = mkCanonical ".." = "..";
  val mkCanonical_e = mkCanonical "../.." = "../..";
  val mkCanonical_f = mkCanonical "b" = "b";
  val mkCanonical_g = mkCanonical "a/b" = "a/b";
  val mkCanonical_h = mkCanonical "/a/b" = "/a/b";
  val mkCanonical_i = mkCanonical "a/b/" = "a/b";
  val mkCanonical_j = mkCanonical "a/b//" = "a/b";
  val mkCanonical_k = mkCanonical "a/../b" = "b";
  val mkCanonical_l = mkCanonical "a/.." = ".";
  val mkCanonical_m = mkCanonical "a/." = "a";
  val mkCanonical_n = mkCanonical "a/" = "a";
  val mkCanonical_p = mkCanonical "/a/../b/" = "/b";
  val mkCanonical_q = mkCanonical "/.." = "/";
  val mkCanonical_r = mkCanonical "/../../a/b/" = "/a/b";
  val mkCanonical_s = mkCanonical "/./../../a/b/" = "/a/b";
  val mkCanonical_t = mkCanonical "/./../.." = "/";
  val mkCanonical_u = mkCanonical "a/../b" = "b";
  val mkCanonical_v = mkCanonical "a/./b" = "a/b";
  val mkCanonical_w = mkCanonical "a////b" = "a/b";
  val mkCanonical_x = mkCanonical "foo1//../..//foo2/bar.sml" = "../foo2/bar.sml";
  val mkCanonical_y = mkCanonical "foo1.ext/./foo2/../bar.sml/" = "foo1.ext/bar.sml";
  val mkCanonical_z = mkCanonical "//foo1/../../foo2/bar.sml" = "/foo2/bar.sml";
  val mkRelative_a = mkRelative{path="a/b", relativeTo="/c/d"} = "a/b";
  val mkRelative_b = mkRelative{path="/", relativeTo="/a/b/c"} = "../../..";
  val mkRelative_c = mkRelative{path="/a/b/", relativeTo="/a/c"} = "../b/";
  val mkRelative_d = mkRelative{path="/a/b", relativeTo="/a/c"} = "../b";
  val mkRelative_e = mkRelative{path="/", relativeTo="/"} = ".";
  val mkRelative_f = mkRelative{path="/", relativeTo="/."} = ".";
  val mkRelative_g = mkRelative{path="/", relativeTo="/a"} = "..";
  val mkRelative_h = mkRelative{path="/a/b/../c", relativeTo="/a/d"} = "../b/../c";
  val mkRelative_i = mkRelative{path="/a/b", relativeTo="/c/d"} = "../../a/b";
  val mkRelative_j = mkRelative{path="/c/a/b", relativeTo="/c/d"} = "../a/b";
  val mkRelative_k = mkRelative{path="/c/d/a/b", relativeTo="/c/d"} = "a/b";
  val mkRelative_l = (ignore(mkRelative{path="/a", relativeTo="c/d"}); false) handle Path => true;
  val mkRelative_m = (ignore(mkRelative{path="a", relativeTo="c/d"}); false) handle Path => true;
  val splitBaseExt_a = splitBaseExt "" = {base = "", ext = NONE};
  val splitBaseExt_b = splitBaseExt ".login" = {base = ".login", ext = NONE};
  val splitBaseExt_c = splitBaseExt "/.login" = {base = "/.login", ext = NONE};
  val splitBaseExt_d = splitBaseExt "a" = {base = "a", ext = NONE};
  val splitBaseExt_e = splitBaseExt "a." = {base = "a.", ext = NONE};
  val splitBaseExt_f = splitBaseExt "a.b" = {base = "a", ext = SOME "b"};
  val splitBaseExt_g = splitBaseExt "a.b.c" = {base = "a.b", ext = SOME "c"};
  val splitBaseExt_h = splitBaseExt "/a.b" = {base = "/a", ext = SOME "b"};
  val splitBaseExt_i = splitBaseExt "/c/a.b" = {base = "/c/a", ext = SOME "b"};
  val splitBaseExt_j = splitBaseExt "/c/a/b/.d" = {base = "/c/a/b/.d", ext = NONE};
  val splitBaseExt_k = splitBaseExt "/c.a/b.d" = {base = "/c.a/b", ext = SOME "d"};
  val splitBaseExt_l = splitBaseExt "/c.a/bd" = {base = "/c.a/bd", ext = NONE};
  val splitBaseExt_m = splitBaseExt "/c/a/b.foo.bar" = {base = "/c/a/b.foo", ext = SOME "bar"};
  val splitBaseExt_n = splitBaseExt "/c/a/b.foo" = {base = "/c/a/b", ext = SOME "foo"};
  val splitBaseExt_p = splitBaseExt ".news/comp" = {base = ".news/comp", ext = NONE};
  val splitDirFile_a = splitDirFile "" = {dir = "", file = ""};
  val splitDirFile_b = splitDirFile "." = {dir = "", file = "."};
  val splitDirFile_c = splitDirFile "b" = {dir = "", file = "b"};
  val splitDirFile_d = splitDirFile "b/" = {dir = "b", file = ""};
  val splitDirFile_e = splitDirFile "a/b" = {dir = "a", file = "b"};
  val splitDirFile_f = splitDirFile "/a" = {dir = "/", file = "a"};
  val splitDirFile_g = splitDirFile "/a/b" = {dir = "/a", file = "b"};
  val splitDirFile_h = splitDirFile "/c/a/b" = {dir = "/c/a", file = "b"};
  val splitDirFile_i = splitDirFile "/c/a/b/" = {dir = "/c/a/b", file = ""};
  val splitDirFile_j = splitDirFile "/c/a/b.foo.bar" = {dir = "/c/a", file = "b.foo.bar"};
  val splitDirFile_k = splitDirFile "/c/a/b.foo" = {dir = "/c/a", file = "b.foo"};
  val toString_a = toString {isAbs=false, vol = "", arcs = []} = "";
  val toString_b = toString {isAbs=true, vol = "", arcs = []} = "/";
  val toString_c = toString {isAbs=true, vol = "", arcs = ["",""]} = "//";
  val toString_d = toString {isAbs=false, vol = "", arcs = ["a"]} = "a";
  val toString_e = toString {isAbs=true, vol = "", arcs = ["a"]} = "/a";
  val toString_f = toString {isAbs=true, vol = "", arcs = ["","a"]} = "//a";
  val toString_g = toString {isAbs=false, vol = "", arcs = ["a",""]} = "a/";
  val toString_h = toString {isAbs=false, vol = "", arcs = ["a","", ""]} = "a//";
  val toString_i = toString {isAbs=false, vol = "", arcs = ["a", "b"]} = "a/b";
  val toString_j = toString {isAbs=false, vol = "", arcs = ["a.b", "c"]} = "a.b/c" ;
  val toString_k = toString {isAbs=false, vol = "", arcs = ["a.b", "c", ""]} = "a.b/c/";
  val toString_l = toString {isAbs=false, vol = "", arcs = ["a", ".", "c"]} = "a/./c";
  val toString_m = toString {isAbs=false, vol = "", arcs = ["a", "..", "c"]} = "a/../c";
  val toString_n = toString {isAbs=false, vol = "", arcs = ["."]} = ".";
  val toString_p = (ignore(toString {isAbs=false, vol = "foo", arcs = ["."]}); false) handle Path => true;
  val toString_q = (ignore(toString {isAbs=false, vol = "", arcs = ["", "a"]}); false) handle Path => true;
  val toString_r =
      (ignore(toString {isAbs=false, vol="", arcs = ["a/b"]}); false)
       handle InvalidArc => true | _ => false
  val validVolume_a = validVolume {isAbs=false, vol=""};
  val validVolume_b = validVolume {isAbs=true, vol=""};
  val validVolume_c = validVolume {isAbs=false, vol="/"} = false;
  val validVolume_d = validVolume {isAbs=true, vol="C:"} = false;
  val validVolume_e = validVolume {isAbs=false, vol="C:"} = false;
  val validVolume_f = validVolume {isAbs=true, vol=" "} = false;
  val validVolume_g = validVolume {isAbs=false, vol=" "} = false;
  val toUnixPath_a = toUnixPath"" = ""
  val toUnixPath_b = toUnixPath"/" = "/"
  val toUnixPath_c = toUnixPath"." = "."
  val toUnixPath_d = toUnixPath"foo" = "foo"
  val toUnixPath_e = toUnixPath".." = ".."
  val fromUnixPath_a = fromUnixPath"" = ""
  val fromUnixPath_b = fromUnixPath"/" = "/"
  val fromUnixPath_c = fromUnixPath"." = "."
  val fromUnixPath_d = fromUnixPath"foo" = "foo"
  val fromUnixPath_e = fromUnixPath".." = ".."
end
