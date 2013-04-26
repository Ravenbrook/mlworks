(*
 * $Log: __transsimple.sml,v $
 * Revision 1.7  1997/01/06 16:39:29  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.6  1996/10/22  11:11:09  matthew
 * Adding LambdaSub
 *
 * Revision 1.5  1995/04/27  15:26:23  jont
 * Fix require statements and comments
 *
 * Revision 1.4  1995/01/10  15:21:50  matthew
 * Adding Crash
 *
 * Revision 1.3  1994/10/12  10:59:21  matthew
 * Renamed simpletypes to simplelambdatypes
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *)

require "../utils/__lists";
require "../utils/__crash";
require "__simpleutils";
require "../main/__pervasives";
require "_transsimple";

structure TransSimple_ =  TransSimple ( structure Lists = Lists_
                                        structure Crash = Crash_
                                        structure SimpleUtils = SimpleUtils_
                                        structure Pervasives = Pervasives_)

