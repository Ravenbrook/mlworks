(*  ==== Testing ====
 *
    Result: OK
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Revision Log
 *  ------------
 *  $Log: bool.sml,v $
 *  Revision 1.6  1997/11/21 10:43:15  daveb
 *  [Bug #30323]
 *
 *  Revision 1.5  1997/05/28  11:22:21  matthew
 *  Updating
 *
 *  Revision 1.4  1996/10/22  13:19:56  jont
 *  Remove references to toplevel
 *
 *  Revision 1.3  1996/06/04  18:14:12  io
 *  stringcvt->string_cvt
 *
 *  Revision 1.2  1996/05/22  10:18:58  daveb
 *  Shell.Module renamed to Shell.Build.
 *
 *  Revision 1.1  1996/05/08  19:15:22  io
 *  new unit
 *
 *)

local
  fun print_result s res = print (s^":"^res^"\n")
  fun check' f = (if f () then "OK" else "WRONG") handle _ => "EXN"

  val test1 = 
    check' (fn _=>
            Bool.fromString "abc" = NONE andalso
            Bool.fromString "afals" = NONE andalso
            Bool.fromString "afalse" = NONE andalso
            Bool.fromString "false" = SOME false andalso
            Bool.fromString "falsea" = SOME false andalso
            Bool.fromString "atru" = NONE andalso
            Bool.fromString "atrue" = NONE andalso
            Bool.fromString "true" = SOME true andalso
            Bool.fromString "truea" = SOME true andalso
            Bool.fromString " true" = SOME true andalso
            Bool.fromString " false" = SOME false andalso
            Bool.fromString " FALSE" = SOME false andalso
            Bool.fromString "fAlSe" = SOME false)
  val test2 = 
    check' (fn _=>
            Bool.not true = false andalso
            Bool.not false = true)
  val test3 = 
    check' (fn _=>
            Bool.fromString "False" = StringCvt.scanString Bool.scan "_False")

  val test4 =
    check' (fn _=>
            Bool.toString true = "true" andalso
            Bool.toString false = "false")
in
  val it = 
    (print_result "fromString" test1;
     print_result "not" test2;
     print_result "toString" test4)
end
