(*
 * Result: OK
 *
 * $Log: windows.sml,v $
 * Revision 1.10  1999/03/19 10:52:22  daveb
 * Automatic checkin:
 * changed attribute _comment to ''
 *
 *  Revision 1.8  1998/10/27  15:56:09  io
 *  change Result status and bits and bobs
 *
 *  Revision 1.7  1998/10/13  16:55:24  io
 *  use findExecutable to find sh rather than using d:/bin/sh
 *
 *  Revision 1.6  1998/10/12  16:39:45  jont
 *  [Bug #30490]
 *  Add test for Windows.streamsOf
 *
 *  Revision 1.5  1998/10/01  16:58:12  io
 *  ** No reason given. **
 *  simplify test structure, beef up existing tests, new tests for Reg and DDE
 *
 *  Revision 1.4  1998/08/25  16:41:11  jont
 *  [Bug #50095]
 *  Fix SysErr and get some other test sorted so they pass
 *
 *  Revision 1.3  1998/08/11  16:58:22  jont
 *  [Bug #50094]
 *  Modify to work now Windows is not included in guib.img by default
 *
 *  Revision 1.2  1998/07/24  17:33:48  io
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 * 
 *  Copyright (C) 1998. Harlequin Group plc
 *  All rights reserved.
 *)

val _ = Shell.Options.set(Shell.Options.ValuePrinter.maximumStrDepth, 0);

let
fun check' s f = 
  (print s;
   print ":";
   ((if (f ()) then print "OK" else print "WRONG") 
       handle exn => (print "\n"; 
                      print (General.exnMessage exn);
                      print "\n";
                      print "BADEXN"
                      ));
   print "\n")

fun checkexn' s exn f = 
  let 
    val res = (ignore (f ()); "FAIL") handle exn2 => 
      if General.exnName exn = General.exnName exn2 then
        "OKEXN"
      else
        "BADEXN:" ^ (General.exnMessage exn2)
  in
    print s;
    print ":";
    print res;
    print "\n"
  end

fun all2 f g xs = 
  let
    datatype 'a Res =
      RES of 'a
    | EXN of exn
    fun myApply g x = (RES (g x)) handle exn => (EXN exn)

    fun scan (acc, count, []) = rev acc
      | scan (acc, count, (RES x) :: xs) = scan (acc, count+1, xs)
      | scan (acc, count, (EXN exn) :: xs) = scan ((count, General.exnMessage exn) :: acc, count+1, xs)

    val res = map (myApply g) xs
    val exnres = scan ([], 0, res)
      
  in
    if (List.all f (map g xs)) handle exn => false then
      true
    else
      (print "\n";
       print (foldl (fn ((y,z),x) => x ^ (Int.toString y) ^ z ^ "\n") "" exnres);
       print "\n";
       false)
  end

  
val test1 = check' "check Windows.findExecutable: notepad and notepad.exe return same results"
  (fn _=>let
           val res0 = Windows.findExecutable "notepad"
           val res1 = Windows.findExecutable "notepad.exe"
         in
           case (res0, res1) of
             (SOME res0, SOME res1) => 
               res0 = res1 andalso
               size (OS.Path.dir res0) > 0 andalso
               (OS.Path.file res0) = "notepad.exe"
           | _ => false
         end)

val test2 = check' "check Windows.findExecutable: mixed case filenames shouldnt cause any exceptions"
  (fn _=>
   all2 (fn x=> isSome x andalso 
         case (String.map Char.toUpper) (valOf x) of 
           res0 => (OS.Path.base o OS.Path.file) res0 = "NOTEPAD")
   (Windows.findExecutable)
   ["NOTEPAD", "NOTEPAD.exe", "NOTEPAD.EXE", "notepad.EXE"]
   )


val test3 = check' "check Windows.findExecutable: failures results should be NONE"
  (fn _=>
   all2 (not o isSome) (Windows.findExecutable) ["notepad2", "notepad2.exe", "c:\\WINNT\\apple"])


val test4 = check' "check Windows.findExecutable: with directories result should be \"Explorer.exe\""
  (fn _=>
   all2 (fn x=> isSome x andalso (valOf x) = "C:\\WINNT\\Explorer.exe")
   (Windows.findExecutable)
   ["c:",
    "C:",
    "d:",
    "c:\\tmp",
    "",
    "c:\\WINNT\\system32",
    "c:/WINNT/system32",
    "d:/users/io/work/build", (* this fails *)
    "d:\\users\\io\\work\\build",
    "d:/users/io/work/",
    "d:/users/io/work",
    "d:\\users\\io\\work\\",
    "d:\\users\\io\\work"
    ]
   )
   

val test5 = check' "check Windows.findExecutable: on stuff in the NT directory"
  (fn _=> 
   all2 (isSome) (Windows.findExecutable) ["c:\\WINNT\\WinHlp32.BMK", (* seems to raise SysErr *)
                                                 "c:\\WINNT\\Win.INI",
                                                 "c:\\WINNT\\clock.avi",
                                                 "c:/WINNT/clock.avi",
                                                 "c:\\WINNT\\system32\\557SET.GID",
                                                 "c:\\WINNT\\system32\\PLUGIN.OCX" (* seems to raise SysErr *)
                                                 ])

val test6 = checkexn' "check Windows.findExecutable: with mixed directory separators is bad"
  (OS.SysErr ("file 'clock.avi' not found\013\n", NONE))
   (fn _=> 
    (not o isSome o  Windows.findExecutable) "c:\\WINNT/clock.avi")

val test7 = check' "check Windows.launchApplication runs hope help"
  (fn _=>
   let val exec = Windows.findExecutable "sh.exe"
   in
     case exec of 
       NONE => false
     | SOME exec => (Windows.launchApplication (exec, ["/x/c", "hope.bat", "help"]); true)
   end);


val test8 = check' "check Windows.lauchApplication runs sh for ten seconds"
  (fn _=>
   let val exec = Windows.findExecutable "sh.exe"
   in
     case exec of 
       NONE => false
     | SOME exec => (Windows.launchApplication (exec, ["-c", "\"help set; echo $0; echo $1; sleep 10\""]); 
                     true)
   end);
  
val test9 = check' "check Windows.launchApplications runs sh on cout"
  (fn _=>
   let val exec = Windows.findExecutable "sh.exe"
   in
     case exec of 
       NONE => false
     | SOME exec => (Windows.launchApplication (exec, ["d:/users/io/work/build/MLW/tools/cout"]);
                     true)
   end);


val test10 = check' "check Windows.launchApplication runs sh to use cout cout and should take a while"
  (fn _=>
   let val exec = Windows.findExecutable "sh.exe"
   in
     case exec of
       NONE => false
     | SOME exec => (Windows.launchApplication (exec, ["d:/users/io/work/build/MLW/tools/cout", "d:/users/io/work/build/MLW/tools/cout"]);
                     true)
   end);

val test11 = check' "check Windows.launchApplication is given a non executable"
  (fn _=>
   (Windows.launchApplication ("hope.bat",["help"]); true))

val test12 = checkexn' "check Windows.launchApplication is given a bogus file which should raise an exception"
  (OS.SysErr ("file 'hope2.bat' not found\013\n", NONE))
  (fn _=>
   (Windows.launchApplication ("hope2.bat", []); false))

val test13 = checkexn' "check Windows.launchApplication handling of bogus files"
  (OS.SysErr ("file 'a' not found\013\n", NONE))
  (fn _=>
   (Windows.launchApplication ("a", []); false))

val test14 = check' "check Windows.execute: uses its stdin and stdout"
  (fn _=>
   let
     val exec = Windows.findExecutable "cmd.exe"
   in
     case exec of
       NONE =>  false
     | SOME exec =>
	 let
	   val proc = Windows.execute (exec, [])
	   val procin = Windows.textInstreamOf proc
	   val procout = Windows.textOutstreamOf proc
	   val _ = TextIO.output(procout, "dir c:\\");
	   val _ = TextIO.flushOut procout;
	   val _ = TextIO.output(TextIO.stdOut, TextIO.inputLine procin);
	   val _ = TextIO.output(TextIO.stdOut, "Finishing output\n");
	 in
	   true
	 end
   end)


val test15 = checkexn' "check Windows.execute cannot find files"
  (OS.SysErr ("The system cannot find the file specified\013\n", NONE))
  (fn _=> Windows.execute ("bogus", []))

val test16 = checkexn' "check Windows.execute cannot find files"
  (OS.SysErr ("The system cannot find the file specified\013\n", NONE))
  (fn _=> Windows.execute ("", []))
  
val test17 = checkexn' "check Windows.execute raises access denied"
  (OS.SysErr ("Access is denied\013\n", NONE))
  (fn _=> Windows.execute ("c:", []))
   

  (* File System *)
  
val test18 = check' "check Windows.localFileTimeToFileTime"
  (fn _=>
   let
     val exec = Windows.findExecutable "sh.exe"
   in
     case exec of
       NONE => false
     | SOME exec => case OS.FileSys.modTime exec of
         sh_time => (Windows.fileTimeToLocalFileTime o Windows.localFileTimeToFileTime) sh_time = sh_time
   end);

val test19 = checkexn' "check Windows.getVolumeInformation would SysErr on unmounted floppy" 
  (OS.SysErr ("The device is not ready.\013\n", NONE)) 
  (fn _=>(ignore (Windows.getVolumeInformation "a:"); false))
  
val test20 = checkexn' "check Windows.getVolumeInformation would complain about an invalid volume"
  (OS.SysErr ("The system cannot find the path specified.\013\n", NONE))
  (fn _=>
   (ignore (Windows.getVolumeInformation "_:");
    false))
  
val test21 = checkexn' "check Windows.getVolumeInformation would complain about poor volume syntax"
  (OS.SysErr ("The filename, directory name, or volume label syntax is incorrect.\013\n", NONE))
  (fn _=>
   (ignore (Windows.getVolumeInformation "as:");
    false))

val test22 = check' "check Windows.getVolumeInformation: should pass"
  (fn _=>
   all2 (fn 
         {volumeName = volumeName,
          systemName = systemName,
          serialNumber = serialNumber,
          maximumComponentLength = maximumComponentLength}
         => (List.exists (fn x=>x=systemName) ["Samba", "FAT", "CDROM", "NTFS"]))

   (Windows.getVolumeInformation)
   ["c:", "d:", "e:", "y:", "z:"] (* d: seems to fail for me *)
   )

val test23 = check' "check Windows.Registry entries for MLWorks in HKEY_CURRENT_USER"
  (fn _=>
   let
     fun scan s = 
       let
         val software_hkey = (valOf o Windows.Reg.openKeyEx) (Windows.Reg.currentUser, "Software", Windows.Key.read)
         val harlequin_hkey = (valOf o Windows.Reg.openKeyEx) (software_hkey, "Harlequin", Windows.Key.read)
         val mlworks_hkey = (valOf o Windows.Reg.openKeyEx) (harlequin_hkey, "MLWorks", Windows.Key.read)
         val res = Windows.Reg.queryValueEx (mlworks_hkey, s)
       in
         ignore (app Windows.Reg.closeKey [mlworks_hkey, harlequin_hkey, software_hkey]);
         res
       end
     handle Option => "scan: Option raised"
   in
     all2 (fn x=> x <> "" andalso x <> "scan: Option raised" 
           (* andalso List.exists (fn y=>x=y) [Shell.Path.pervasive (), (hd o Shell.Path.sourcePath) ()] *)
           )
     scan
     [(* "Object Path",  returns null *)
      "Pervasive Path",
      "Source Path",
      "Startup Directory"]
     
   end)
   
val test24 = check' "check Windows.Registry entries for MLWorks in HKEY_CURRENT_USER using different case"
  (fn _=>
   let
     fun scan s = 
       let
         val software_hkey = (valOf o Windows.Reg.openKeyEx) (Windows.Reg.currentUser, "SOFTWARE", Windows.Key.read)
         val harlequin_hkey = (valOf o Windows.Reg.openKeyEx) (software_hkey, "HARLEQUIN", Windows.Key.read)
         val mlworks_hkey = (valOf o Windows.Reg.openKeyEx) (harlequin_hkey, "MLWORKS", Windows.Key.read)
         val res = Windows.Reg.queryValueEx (mlworks_hkey, s)
       in
         ignore (app Windows.Reg.closeKey [mlworks_hkey, harlequin_hkey, software_hkey]);
         res
       end
     handle Option => "scan: Option raised"
   in
     all2 (fn x=> x <> "" andalso x <> "scan: Option raised" 
           (* andalso List.exists (fn y=>x=y) [Shell.Path.pervasive (), (hd o Shell.Path.sourcePath) ()] *)
           )
     scan
     [(* "Object Path",  returns null *)
      "Pervasive Path",
      "Source Path",
      "Startup Directory"]
     
   end)

val test25 = check' "check Windows.Registry entries for MLWorks in HKEY_LOCAL using bogus arguments"
  (fn _=>
   let
     fun scan s = 
       let
         val software_hkey = (valOf o Windows.Reg.openKeyEx) (Windows.Reg.localMachine, "SOFTWARE", Windows.Key.read)
         val harlequin_hkey = (valOf o Windows.Reg.openKeyEx) (software_hkey, "HARLEQUIN", Windows.Key.read)
         val mlworks_hkey = (valOf o Windows.Reg.openKeyEx) (harlequin_hkey, "MLWORKS", Windows.Key.read)
         val res = Windows.Reg.queryValueEx (mlworks_hkey, s)
       in
         ignore (app Windows.Reg.closeKey [mlworks_hkey, harlequin_hkey, software_hkey]);
         res
       end
     handle Option => "scan: Option raised"
   in
     all2 (fn x=> x = "" andalso x <> "scan: Option raised")
     scan
     [(* "Object Path",  returns null *)
      "Pervasive Path",
      "Source Path",
      "Startup Directory"]
     
   end)

val test26 = check' "check Windows.Registry entries for MLWorks in HKEY_LOCAL_MACHINE"
  (fn _=>
   let
     val software_hkey = (valOf o Windows.Reg.openKeyEx) (Windows.Reg.localMachine, "Software", Windows.Key.read)
     val harlequin_hkey = (valOf o Windows.Reg.openKeyEx) (software_hkey, "Harlequin", Windows.Key.read)
     val mlworks_hkey = (valOf o Windows.Reg.openKeyEx) (harlequin_hkey, "MLWorks", Windows.Key.read)
   in
     true
   end)
  

val test27 = check' "check creation and deletion of registry entries"
  (fn _=>
   let
     val software_hkey = (valOf o Windows.Reg.openKeyEx) (Windows.Reg.currentUser, "Software", Windows.Key.read)
     val harlequin_hkey = (valOf o Windows.Reg.openKeyEx) (software_hkey, "Harlequin", Windows.Key.read)
     val mlworks_hkey = (valOf o Windows.Reg.openKeyEx) (harlequin_hkey, "MLWorks", Windows.Key.read)

     val test_suite_v_hkey = case (valOf o Windows.Reg.createKeyEx) (mlworks_hkey, "TestSuiteV", Windows.Reg.VOLATILE, Windows.Key.allAccess) of
       Windows.Reg.CREATED_NEW_KEY test_suite_hkey => test_suite_hkey
     | Windows.Reg.OPENED_EXISTING_KEY test_suite_hkey => test_suite_hkey

     val test_suite_v_hkey2 = case (valOf o Windows.Reg.createKeyEx) (mlworks_hkey, "TestSuiteV2", Windows.Reg.VOLATILE, Windows.Key.allAccess) of
       Windows.Reg.CREATED_NEW_KEY test_suite_hkey => test_suite_hkey
     | Windows.Reg.OPENED_EXISTING_KEY test_suite_hkey => test_suite_hkey
         
     val test_suite_nv_hkey = case (valOf o Windows.Reg.createKeyEx) (mlworks_hkey, "TestSuiteNV", Windows.Reg.NON_VOLATILE, Windows.Key.allAccess) of
       Windows.Reg.CREATED_NEW_KEY test_suite_hkey => test_suite_hkey
     | Windows.Reg.OPENED_EXISTING_KEY test_suite_hkey => test_suite_hkey

     val test_suite_nv_hkey2 = case (valOf o Windows.Reg.createKeyEx) (mlworks_hkey, "TestSuiteNV2", Windows.Reg.NON_VOLATILE, Windows.Key.allAccess) of
       Windows.Reg.CREATED_NEW_KEY test_suite_hkey => test_suite_hkey
     | Windows.Reg.OPENED_EXISTING_KEY test_suite_hkey => test_suite_hkey


     val subkeyList = [(test_suite_nv_hkey2, "TestSuiteNV2"),
                       (test_suite_nv_hkey, "TestSuiteNV"),
                       (test_suite_v_hkey2, "TestSuiteV2"),
                       (test_suite_v_hkey, "TestSuiteV")]

     val keyValueList = [("test key", "test value"), 
                         ("test2 key", "test2 value"), 
                         ("test3 key", "test3 value")]


     fun mungeKeyValueList s xs = map (fn (x,y)=> (s^x,y)) xs
       
       
     val test27a = check' "check setting key value pairs volatile registry"
       (fn _=>
        all2
        (fn x=> x=true)
        (fn x=>(Windows.Reg.setValueEx (test_suite_v_hkey, #1(x), #2(x));
                true))
        (mungeKeyValueList "v" keyValueList))

     val test27b = check' "check setting key value pairs volatile registry2"
       (fn _=>
        all2
        (fn x=> x=true)
        (fn x=>(Windows.Reg.setValueEx (test_suite_v_hkey2, #1(x), #2(x));
                true))
        (mungeKeyValueList "v2" keyValueList))
        
     val test27c = check' "check setting key value pairs non volatile registry"
       (fn _=>
        all2
        (fn x=> x=true)
        (fn x=>(Windows.Reg.setValueEx (test_suite_nv_hkey, #1(x), #2(x));
                true))
        (mungeKeyValueList "nv" keyValueList))
       
     val test27d = check' "check setting key value pairs non volatile registry2"
       (fn _=>
        all2
        (fn x=> x=true)
        (fn x=>(Windows.Reg.setValueEx (test_suite_nv_hkey2, #1(x), #2(x));
                true))
        (mungeKeyValueList "nv2" keyValueList))
       

     val test27e = check' "check deleting keys succeeds"
       (fn _=>
        all2 
        (fn x=>x = true)
        (fn x=>(Windows.Reg.deleteKey x; true))
        subkeyList)

         
     val test27f = check' "check closing keys succeeds"
       (fn _=>
        all2 
        (fn x=>x=true)
        (fn x=>(Windows.Reg.closeKey x; true))
        (map (#1) subkeyList))

     val test27g = check' "check closing keys again fail"
       (fn _=>
        all2
        (fn x=> x = "PASS12")
        (fn x=>((Windows.Reg.closeKey x; "FAIL")
                handle OS.SysErr ("The handle is invalid.\013\n", SOME arg) => ("PASS" ^ Int.toString arg)
                     | exn => "FAIL"))
        (map (#1) subkeyList))

     (* should test_suite_hkey = test_suite_hkey2? *)
   in
     true
   end)
       
       
 (* DDE *)


(* assume netscape is running at same time
 * some code to start Netscape when exception gets raised would need to be written
 *)

val test28 = check' "checks Windows.DDE tells Netscape to open a URL and move it to the foreground"
  (fn _=> 
   let 
     val info = Windows.DDE.startDialog ("NSShell", "WWW_OpenURL")
   in
     (* \"http://src.doc.ic.ac.uk\" kills netscape permanently you need to relogin *)
      ignore (Windows.DDE.executeString (info, "http://home.netscape.com", 3,3));
      ignore (Windows.DDE.stopDialog info);
      false
   end)
   


val test29 = check' "check DDE interaction with Netscape like crash it"
  (fn _ =>
   let
     val info = Windows.DDE.startDialog ("NSShell", "WWW_Version")
   in
     ignore (Windows.DDE.executeString (info, "", 3, 10));
     ignore (Windows.DDE.stopDialog info);
     false
   end)

(* ensure Netscape is running at the same time and c:/hqbin/nt/x86/ls.txt is loaded *)
val test30 = check' "check DDE interaction with Netscape like crash it"
  (fn _ =>
   let
     val info = Windows.DDE.startDialog ("NSShell", "WWW_QueryURLFile")
   in
     ignore (Windows.DDE.executeString (info, "file:///C|/hqbin/nt/x86/ls.txt",3,10));
     ignore (Windows.DDE.stopDialog info);
     false
   end)

val test31 = checkexn' "check DDE exception on unknown service"
  (OS.SysErr ("start_dde_dialog : DdeConnect - no conversation established\013\n", NONE))
  (fn _ =>
   let
     val info = Windows.DDE.startDialog ("NSShell_NON_APPLICATION", "WWW_QueryURLFile")
   in
     ignore (Windows.DDE.executeString (info, "file:///C|/hqbin/nt/x86/ls.txt",3,10));
     ignore (Windows.DDE.stopDialog info);
     true
   end)


  val _ = print "Windows.Registry: needs better coverage\n"
  val _ = print "Windows.hasOwnConsole: unimplemented"

in
  ()
end

  
