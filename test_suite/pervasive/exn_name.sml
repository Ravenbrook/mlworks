(*
Result: OK
 
* $Log: exn_name.sml,v $
* Revision 1.3  1997/11/21 10:53:14  daveb
* [Bug #30323]
*
 *  Revision 1.2  1997/08/11  09:51:31  brucem
 *  [Bug #30086]
 *  Stop printing structure contents to prevent spurious failure.
 *
 *  Revision 1.1  1997/03/27  13:10:06  andreww
 *  new unit
 *  [Bug #1989]
 *  tests that the pervasive function exnName really does return a string.
 *
*
*
*
Copyright (c) 1997 Harlequin Ltd.
*)

fun reportOK true = "test succeeded"
  | reportOK false = "test failed"


exception MyException

fun noDebugInfo s =
  let
    fun nameOnly i =
      if i=size s then s
      else
        if String.sub(s,i)= #"[" then String.substring(s,0,i)
        else nameOnly (i+1)
  in
    nameOnly 0
  end

val x = reportOK(noDebugInfo(exnName MyException)="MyException")
        handle e => "exception raised";
