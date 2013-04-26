(* Tests that __sys_word provides SysWord synonym structure
 *
 *  Result: OK
 *
 *  Revision Log
 *  ------------
 *  $Log: sys_word.sml,v $
 *  Revision 1.3  1998/07/08 14:36:47  jont
 *  [Bug #70106]
 *  Avoid getting LargeWord into answers, since it can appear as flags
 *
 *  Revision 1.2  1997/11/21  10:49:26  daveb
 *  [Bug #30323]
 *
 *  Revision 1.1  1997/05/23  12:32:28  jkbrook
 *  new unit
 *  Test that file provides synonym structure
 *
 *
 * Copyright (C) 1997 Harlequin Ltd.
 *)


SysWord.fromInt 3 = 0w3;
