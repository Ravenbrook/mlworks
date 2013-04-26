(*
 * $Log: __simpleutils.sml,v $
 * Revision 1.6  1997/01/06 16:38:19  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.5  1996/12/18  14:39:25  matthew
 * Simplifications and rationalizations
 *
 * Revision 1.4  1995/04/27  15:29:53  jont
 * Fix require statements and comments
 *
 * Revision 1.3  1994/10/12  09:32:29  matthew
 * Changed simpletypes unit name
 *
 * Copyright (c) 1997 Harlequin Ltd.
 *)

require "../utils/__lists";
require "../utils/__crash";
require "../main/__pervasives";
require "../basics/__scons";
require "__lambdatypes";
require "_simpleutils";

structure SimpleUtils_ = SimpleUtils ( structure Lists = Lists_
                                       structure LambdaTypes = LambdaTypes_
                                       structure Pervasives = Pervasives_
                                       structure Scons = Scons_
                                       structure Crash = Crash_
                                         )

