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
 * Test Win32 OS.PATH.*.  All tests should return true.
 * 
 *
 * Revision Log
 * ------------
 *
 * $Log: os_path.sml,v $
 * Revision 1.8  1999/03/17 10:42:58  daveb
 * [Bug #30092]
 * Added tests for invalid arcs.
 *
 *  Revision 1.7  1998/08/13  13:08:22  jont
 *  [Bug #30468]
 *  mkAbsolute and mkRelative now takes records arguments rather than tuples
 *
 *  Revision 1.6  1998/03/03  18:10:28  jont
 *  [Bug #30323]
 *  Remove use of loadSource, and fix uses of concat to new spec
 *
 *  Revision 1.5  1998/01/22  16:26:22  jont
 *  [Bug #30323]
 *  Remove unnecessary uses of Shell.Build.loadSource
 *
 *  Revision 1.4  1997/08/11  14:45:47  jont
 *  [Bug #30245]
 *  Fix problems with basis structures changing
 *
 *  Revision 1.3  1997/03/05  17:20:06  jont
 *  [Bug #1939]
 *  Add tests for toUnixPath and fromUnixPath
 *
 *  Revision 1.2  1996/10/22  13:24:57  jont
 *  Remove references to toplevel
 *
 *  Revision 1.1  1996/06/20  11:32:09  andreww
 *  new unit
 *  Test file for win_nt/__os_path.sml
 *
 *
 *)

local 
  open OS.Path
  val dirSeparator = #"\\"
  val extSeparator = #"."
  val parentArc = ".."
  val currentArc = "."
  val volumeSeparator = #":"
  val sep = String.str dirSeparator
  val cur = currentArc
  val par = parentArc

  infix 1 seq
  fun e1 seq e2 = e2;
  fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN";

in
    
  val test1a = 
    check'(fn _ => fromString "" = {isAbs=false, vol = "", arcs = []});
  val test1b = 
    check'(fn _ => fromString sep = {isAbs=true, vol="", arcs=[""]});
  val test1c = 
    check'(fn _ => fromString (sep^sep)
           = {isAbs=true, vol="", arcs=["", ""]});
  val test1d = 
    check'(fn _ => fromString "a" = {isAbs=false, vol = "", arcs = ["a"]});
  val test1e =
    check'(fn _ => fromString (sep^"a") = {isAbs=true, vol="", arcs=["a"]});
  val test1f = 
    check'(fn _ => fromString (sep^sep^"a")
           = {isAbs=true, vol="", arcs=["","a"]});
  val test1g = 
    check'(fn _ => fromString ("a"^sep)
           = {isAbs=false, vol = "", arcs = ["a", ""]});
  val test1h = 
    check'(fn _ => fromString ("a"^sep^sep)
	   = {isAbs=false, vol = "", arcs = ["a", "", ""]});
  val test1i = 
    check'(fn _ => fromString ("a"^sep^"b")
           = {isAbs=false, vol = "", arcs = ["a", "b"]});
  val test1j = 
    check'(fn _ => fromString ("a.b"^sep^"c") = 
           {isAbs=false, vol = "", arcs = ["a.b", "c"]});
  val test1k = 
    check'(fn _ => fromString ("a.b"^sep^"c"^sep) =
           {isAbs=false, vol = "", arcs = ["a.b", "c", ""]});
  val test1l = 
    check'(fn _ => fromString ("a"^sep^cur^sep^"c")
           = {isAbs=false, vol = "", arcs = ["a", ".", "c"]});
  val test1m = 
    check'(fn _ => fromString ("a"^sep^par^sep^"c")
           = {isAbs=false, vol = "", arcs = ["a", "..", "c"]});
  val test1n = 
    check'(fn _ => fromString cur = {isAbs=false, vol = "", arcs = ["."]});

  val test2a =
    check'(fn _ => toString {isAbs=false, vol = "", arcs = []} = "");
  val test2b = 
    check'(fn _ => toString {isAbs=true, vol="a:", arcs=[]} = "a:"^sep);
  val test2c = 
    check'(fn _ => toString {isAbs=true, vol="A:", arcs=["", ""]} = 
           "A:"^sep^sep);
  val test2d = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a"]} = "a");
  val test2e = 
    check'(fn _ => toString {isAbs=true, vol="a:", arcs=["a"]} = "a:"^sep^"a");
  val test2f = 
    check'(fn _ => toString {isAbs=true, vol="a:", arcs=["","a"]} = 
           "a:"^sep^sep^"a");
  val test2g = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a", ""]} = "a"^sep);
  val test2h = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a", "", ""]} = 
           "a"^sep^sep);
  val test2i = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a", "b"]} = 
           "a"^sep^"b");
  val test2j = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a.b", "c"]} = 
           "a.b"^sep^"c");
  val test2k = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a.b", "c", ""]} 
           = "a.b"^sep^"c"^sep);
  val test2l = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a", ".", "c"]} 
           = "a"^sep^cur^sep^"c");
  val test2m = 
    check'(fn _ => toString {isAbs=false, vol = "", arcs = ["a", "..", "c"]} 
           = "a"^sep^par^sep^"c");
  val test2n = 
    check'(fn _ => toString {isAbs=true, vol="", arcs=["a", "..", "c"]} 
           = sep^"a"^sep^par^sep^"c");
  val test2o = (toString {isAbs=false, vol = "", arcs =  ["", "a"]} seq "WRONG")
    handle Path => "OK" | _ => "WRONG";
  val test2p = 
    check'(fn _ => 
	   (toString {isAbs=true, vol = "C:", arcs =  ["windows"]} 
	    = "C:"^sep^"windows"));
  val test2q =
    (toString {isAbs=false, vol="", arcs = ["a\\b"]} seq "WRONG")
    handle InvalidArc => "OK" | _ => "WRONG"

  val test3b = 
    check'(fn _ => getVolume "\\" = "");
  val test3c = 
    check'(fn _ => getVolume "\\\\" = "");
  val test3d = 
    check'(fn _ => getVolume "a\\b\\c\\" = "");
  val test3e = 
    check'(fn _ => getVolume ".\\" = "");
  val test3f = 
    check'(fn _ => getVolume "..\\" = "");
  val test3g = 
    check'(fn _ => getVolume "" = "");
  val test3h = 
    check'(fn _ => getVolume "C:" = "C:");

  val test4a = 
    check'(fn _ => 
	   List.all isRelative ["", ".", "..", "a\\\\"]
	   andalso not (List.exists isRelative ["\\", "\\a", "\\\\"]));
  val test4b = 
    check'(fn _ => 
	   List.all isAbsolute ["\\", "\\a", "\\\\", "\\.", "\\.."]
	   andalso not (List.exists isAbsolute ["", ".", "..", "a\\\\"]));

  val test5a = 
    check'(fn _ => 
	   getParent "\\" = "\\"
	   andalso getParent "a" = "."
	   andalso getParent "a\\" = "a\\.."
	   andalso getParent "a\\\\\\" = "a\\\\\\.."
	   andalso getParent "a\\b" = "a"
	   andalso getParent "a\\b\\" = "a\\b\\.."
	   andalso getParent "\\a\\b" = "\\a"
	   andalso getParent "\\a\\b\\" = "\\a\\b\\.." 
	   andalso getParent ".." = "..\\.."
	   andalso getParent "." = ".."
	   andalso getParent "..\\" = "..\\.."
	   andalso getParent ".\\" = ".\\.."
	   andalso getParent "" = "..");

  val test6a = 
    check'(fn _ => 
	   concat(["a", "b"]) = "a\\b"
	   andalso concat(["a", "b\\c"]) = "a\\b\\c"
	   andalso concat(["\\", "b\\c"]) = "\\\\b\\c"
	   andalso concat(["", "b\\c"]) = "b\\c"
	   andalso concat(["\\a", "b\\c"]) = "\\a\\b\\c"
	   andalso concat(["a\\", "b\\c"]) = "a\\\\b\\c"
	   andalso concat(["a\\\\", "b\\c"]) = "a\\\\\\b\\c"
	   andalso concat([".", "b\\c"]) = ".\\b\\c"
	   andalso concat(["a\\b", ".."]) = "a\\b\\.."
	   andalso concat(["a\\b", "..\\c"]) = "a\\b\\..\\c");
  val test6b = (concat (["a", "\\b"]) seq "WRONG")
    handle Path => "OK" | _ => "WRONG";

  val test7a = 
    check'(fn _ => 
	   mkAbsolute{path="\\a\\b", relativeTo="\\c\\d"} = "\\a\\b"
	   andalso mkAbsolute{path="\\", relativeTo="\\c\\d"} = "\\"
	   andalso mkAbsolute{path="a\\b", relativeTo="\\c\\d"} = "\\c\\d\\a\\b");
  val test7b = (mkAbsolute{path="a", relativeTo="c\\d"} seq "WRONG")
    handle Path => "OK" | _ => "WRONG";
  val test7c = (mkAbsolute{path="\\a", relativeTo="c\\d"} seq "WRONG")
    handle Path => "OK" | _ => "WRONG";

  val test8a = 
    check'(fn _ => 
	   mkRelative{path="a\\b", relativeTo="\\c\\d"} = "a\\b"
	   andalso mkRelative{path="\\", relativeTo="\\a\\b\\c"}	   = "..\\..\\.." 
	   andalso mkRelative{path="\\a\\", relativeTo="\\a\\b\\c"}	   = "..\\..\\" 
	   andalso mkRelative{path="\\a\\b\\", relativeTo="\\a\\c"}	   = "..\\b\\"     
	   andalso mkRelative{path="\\a\\b",relativeTo= "\\a\\c\\"}	   = "..\\b"      
	   andalso mkRelative{path="\\a\\b\\", relativeTo="\\a\\c\\"}	   = "..\\b\\"     
	   andalso mkRelative{path="\\", relativeTo="\\"}		   = "."	      
	   andalso mkRelative{path="\\", relativeTo="\\."}	   = "."	      
	   andalso mkRelative{path="\\", relativeTo="\\.."}	   = "."	      
	   andalso mkRelative{path="\\", relativeTo="\\a"}	   = ".."	      
	   andalso mkRelative{path="\\a\\b\\..\\c", relativeTo="\\a\\d"} = "..\\b\\..\\c" 
	   andalso mkRelative{path="\\a\\b", relativeTo="\\c\\d"}      = "..\\..\\a\\b"
	   andalso mkRelative{path="\\c\\a\\b", relativeTo="\\c\\d"}    = "..\\a\\b"
	   andalso mkRelative{path="\\c\\d\\a\\b", relativeTo="\\c\\d"}  = "a\\b");
  val test8b = (mkRelative{path="\\a", relativeTo="c\\d"} seq "WRONG")
    handle Path => "OK" | _ => "WRONG";
  val test8c = (mkRelative{path="a", relativeTo="c\\d"} seq "WRONG")
    handle Path => "OK" | _ => "WRONG";

  val test9a =
    let
      fun chkCanon (a, b) =
	(mkCanonical a = b) 
	andalso (mkCanonical b = b)
	andalso (isCanonical b)
    in
      check'(fn _ => 
	     chkCanon("", ".")
	     andalso chkCanon(".", ".")
	     andalso chkCanon(".\\.", ".")
	     andalso chkCanon("\\.", "\\")
	     andalso chkCanon("..", "..")
	     andalso chkCanon("..\\..", "..\\..")
	     andalso chkCanon("b", "b")
	     andalso chkCanon("a\\b", "a\\b")
	     andalso chkCanon("\\a\\b", "\\a\\b")
	     andalso chkCanon("a\\b\\", "a\\b")
	     andalso chkCanon("a\\b\\\\", "a\\b")
	     andalso chkCanon("a\\..\\b", "b")
	     andalso chkCanon("a\\..", ".")
	     andalso chkCanon("a\\.", "a")
	     andalso chkCanon("a\\", "a")
	     andalso chkCanon("\\a\\..\\b\\", "\\b")
	     andalso chkCanon("\\..", "\\")
	     andalso chkCanon("\\..\\..\\a\\b", "\\a\\b")
	     andalso chkCanon("\\.\\..\\..\\a\\b", "\\a\\b")
	     andalso chkCanon("\\.\\..\\..", "\\")
	     andalso chkCanon("a\\..\\b", "b")
	     andalso chkCanon("a\\.\\b", "a\\b")
	     andalso chkCanon("a\\\\\\\\b", "a\\b")
	     andalso chkCanon("a\\\\\\\\b", "a\\b"))
    end

  val test10a = 
    check'(fn _ => 
	   not (isCanonical ".\\."
		orelse isCanonical "\\.."
		orelse isCanonical "\\."
		orelse isCanonical "\\\\"
		orelse isCanonical "a\\.."
		orelse isCanonical "a\\\\b"
		orelse isCanonical "a\\."
	        orelse isCanonical "a\\b\\"
		orelse isCanonical "a\\.."))

  val test11a = 
    check'(fn _ => 
	   splitDirFile "" = {dir = "", file = ""}
	   andalso splitDirFile "." = {dir = "", file = "."}
	   andalso splitDirFile ".." = {dir = "", file = ".."}
	   andalso splitDirFile "b" = {dir = "", file = "b"}
	   andalso splitDirFile "b\\" = {dir = "b", file = ""}
	   andalso splitDirFile "a\\b" = {dir = "a", file = "b"}
	   andalso splitDirFile "\\a" = {dir = "\\", file = "a"}
	   andalso splitDirFile "\\a\\b" = {dir = "\\a", file = "b"}
	   andalso splitDirFile "\\c\\a\\b" = {dir = "\\c\\a", file = "b"}
	   andalso splitDirFile "\\c\\a\\b\\" = {dir = "\\c\\a\\b", file = ""}
	   andalso splitDirFile "\\c\\a\\b.foo.bar" = {dir = "\\c\\a", file="b.foo.bar"}
	   andalso splitDirFile "\\c\\a\\b.foo" = {dir = "\\c\\a", file = "b.foo"});
    
  val test12 = 
    check'(fn _ => 
	   "" = joinDirFile {dir = "", file = ""}
	   andalso "b" = joinDirFile {dir = "", file = "b"}
	   andalso "\\" = joinDirFile {dir = "\\", file = ""}
	   andalso "\\b" = joinDirFile {dir = "\\", file = "b"}
	   andalso "a\\b" = joinDirFile {dir = "a", file = "b"}
	   andalso "\\a\\b" = joinDirFile {dir = "\\a", file = "b"}
	   andalso "\\c\\a\\b" = joinDirFile {dir = "\\c\\a", file = "b"}
	   andalso "\\c\\a\\b\\" = joinDirFile {dir = "\\c\\a\\b", file = ""}
	   andalso "\\c\\a\\b.foo.bar" = joinDirFile {dir = "\\c\\a", file="b.foo.bar"}
	   andalso "\\c\\a\\b.foo" = joinDirFile {dir = "\\c\\a", file = "b.foo"});
  val test12a =
    (joinDirFile {dir = "", file = "a\\b"} seq "WRONG")
    handle InvalidArc => "OK" | _ => "WRONG"

  val test13 = 
    check'(fn _ => 
	   dir "b" = ""
	   andalso dir "a\\b" = "a"
	   andalso dir "\\" = "\\"
	   andalso dir "\\b" = "\\"
	   andalso dir "\\a\\b" = "\\a"
	   andalso dir "\\c\\a\\b" = "\\c\\a"
	   andalso dir "\\c\\a\\b\\" = "\\c\\a\\b"
	   andalso dir "\\c\\a\\b.foo.bar" = "\\c\\a"
	   andalso dir "\\c\\a\\b.foo" = "\\c\\a");

  val test14 = 
    check'(fn _ => 
	   file "b" = "b"
	   andalso file "a\\b" = "b"
	   andalso file "\\" = ""
	   andalso file "\\b" = "b"
	   andalso file "\\a\\b" = "b"
	   andalso file "\\c\\a\\b" = "b"
	   andalso file "\\c\\a\\b\\" = ""
	   andalso file "\\c\\a\\b.foo.bar" = "b.foo.bar"
	   andalso file "\\c\\a\\b.foo" = "b.foo");

  val test15 = 
    check'(fn _ => 
	   splitBaseExt "" = {base = "", ext = NONE}
	   andalso splitBaseExt ".login" = {base = ".login", ext = NONE}
	   andalso splitBaseExt "\\.login" = {base = "\\.login", ext = NONE}
	   andalso splitBaseExt "a" = {base = "a", ext = NONE}
	   andalso splitBaseExt "a." = {base = "a.", ext = NONE}
	   andalso splitBaseExt "a.b" = {base = "a", ext = SOME "b"}
	   andalso splitBaseExt "a.b.c" = {base = "a.b", ext = SOME "c"}
	   andalso splitBaseExt "\\a.b" = {base = "\\a", ext = SOME "b"}
	   andalso splitBaseExt "\\c\\a.b" = {base = "\\c\\a", ext = SOME "b"}
	   andalso splitBaseExt "\\c\\a\\b\\.d" = {base = "\\c\\a\\b\\.d", ext = NONE}
	   andalso splitBaseExt "\\c.a\\b.d" = {base = "\\c.a\\b", ext = SOME "d"}
	   andalso splitBaseExt "\\c.a\\bd" = {base = "\\c.a\\bd", ext = NONE}
	   andalso splitBaseExt "\\c\\a\\b.foo.bar" = {base="\\c\\a\\b.foo",ext=SOME "bar"}
	   andalso splitBaseExt "\\c\\a\\b.foo" = {base = "\\c\\a\\b", ext = SOME "foo"});

  val test16 = 
    check'(fn _ => 
	   "" = joinBaseExt {base = "", ext = NONE}
	   andalso ".login" = joinBaseExt {base = ".login", ext = NONE}
	   andalso "a" = joinBaseExt {base = "a", ext = NONE}
	   andalso "a" = joinBaseExt {base = "a", ext = SOME ""}
	   andalso "a.b" = joinBaseExt {base = "a", ext = SOME "b"}
	   andalso "a.b.c" = joinBaseExt {base = "a.b", ext = SOME "c"}
	   andalso "a.b.c.d" = joinBaseExt {base = "a.b", ext = SOME "c.d"}
	   andalso "\\a.b" = joinBaseExt {base = "\\a", ext = SOME "b"}
	   andalso "\\c\\a.b" = joinBaseExt {base = "\\c\\a", ext = SOME "b"}
	   andalso "\\c\\a\\b\\.d" = joinBaseExt {base = "\\c\\a\\b\\", ext = SOME "d"}
	   andalso "\\c\\a\\b.foo.bar" = joinBaseExt {base="\\c\\a\\b",ext=SOME "foo.bar"}
	   andalso "\\c\\a\\b.foo" = joinBaseExt {base = "\\c\\a\\b", ext = SOME "foo"});

  val test17 = 
    check'(fn _ => 
	   ext "" = NONE
	   andalso ext ".login" = NONE
	   andalso ext "\\.login" = NONE
	   andalso ext "a" = NONE
	   andalso ext "a." = NONE
	   andalso ext "a.b" = SOME "b"
	   andalso ext "a.b.c" = SOME "c"
	   andalso ext "a.b.c.d" = SOME "d"
	   andalso ext "\\a.b" = SOME "b"
	   andalso ext "\\c\\a.b" = SOME "b"
	   andalso ext "\\c\\a\\b\\.d" = NONE
	   andalso ext "\\c.a\\b.d" = SOME "d"
	   andalso ext "\\c.a\\bd" = NONE
	   andalso ext "\\c\\a\\b.foo.bar" = SOME "bar"
	   andalso ext "\\c\\a\\b.foo" = SOME "foo");

  val test18 = 
    check'(fn _ => 
	   base "" = ""
	   andalso base ".d" = ".d"
	   andalso base ".login" = ".login"
	   andalso base "\\.login" = "\\.login"
	   andalso base "a" = "a"
	   andalso base "a." = "a."
	   andalso base "a.b" = "a"
	   andalso base "a.b.c" = "a.b" 
	   andalso base "a.b.c.d" = "a.b.c"
	   andalso base "\\a.b" = "\\a"
	   andalso base "\\c\\a.b" = "\\c\\a"
	   andalso base "\\c\\a\\b\\.d" = "\\c\\a\\b\\.d"
	   andalso base "\\c.a\\b.d" = "\\c.a\\b"
	   andalso base "\\c.a\\bd" = "\\c.a\\bd"
	   andalso base "\\c\\a\\b.foo.bar" = "\\c\\a\\b.foo"
	   andalso base "\\c\\a\\b.foo" = "\\c\\a\\b");

  val test19 = 
    check'(fn () => validVolume{isAbs=false, vol=""}
	   andalso validVolume{isAbs=true, vol=""}
	   andalso validVolume{isAbs=true, vol="C:"}
	   andalso validVolume{isAbs=false, vol="C:"}
	   andalso not (validVolume{isAbs=true, vol="\\"}
			orelse validVolume{isAbs=false, vol="\\"} 
			orelse validVolume{isAbs=true, vol=" "}
			orelse validVolume{isAbs=false, vol=" "})); 

  val toUnixPath_a = toUnixPath"" = ""

  val toUnixPath_b = toUnixPath"/" = "/"

  val toUnixPath_c = toUnixPath"." = "."

  val toUnixPath_d = toUnixPath"foo" = "foo"

  val toUnixPath_e = toUnixPath".." = ".."

  val toUnixPath_f = toUnixPath"\\" = "/"

  val toUnixPath_g = toUnixPath"\\foo" = "/foo"

  val toUnixPath_h = toUnixPath"c:\\foo" = "c:/foo"

  val toUnixPath_i = toUnixPath"\\foo\\bar" = "/foo/bar"

  val toUnixPath_j = toUnixPath"bar\\foo" = "bar/foo"

  val toUnixPath_g = toUnixPath"c:bar\\foo" = "c:bar/foo"

  val fromUnixPath_a = fromUnixPath"" = ""

  val fromUnixPath_b = fromUnixPath"/" = "\\"

  val fromUnixPath_c = fromUnixPath"." = "."

  val fromUnixPath_d = fromUnixPath"foo" = "foo"

  val fromUnixPath_e = fromUnixPath".." = ".."

  val fromUnixPath_f = fromUnixPath"/" = "\\"

  val fromUnixPath_g = fromUnixPath"/foo" = "\\foo"

  val fromUnixPath_h = fromUnixPath"c:/foo" = "c:\\foo"

  val fromUnixPath_i = fromUnixPath"/foo/bar" = "\\foo\\bar"

  val fromUnixPath_j = fromUnixPath"bar/foo" = "bar\\foo"

  val fromUnixPath_g = fromUnixPath"c:bar/foo" = "c:bar\\foo"

end
