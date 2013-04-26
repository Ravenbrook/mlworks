(*  ==== INITIAL BASIS : SysWord structure  ====
 *
 *  Copyright (C) 1997 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: __sys_word.sml,v $
 *  Revision 1.2  1999/02/17 14:41:39  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.1  1997/05/23  09:26:58  jkbrook
 *  new unit
 *  Separate file for synonym structure SysWord
 *
*)

require "__pre_word32";
require "word";

structure SysWord : WORD = PreWord32;

